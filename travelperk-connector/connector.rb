{
  title: 'Travelperk Connector',

  connection: {
    base_uri: lambda do
    account_property('TRAVELPERK_BASE_URL')
    end,

    authorization: {

      type: "oauth2",

      client_id: lambda do
        account_property('TRAVELPERK_CLIENT_ID')
      end,

      client_secret: lambda do
        account_property('TRAVELPERK_CLIENT_SECRET')
      end,

      authorization_url: lambda do |connection|
        account_property('TRAVELPERK_AUTHORIZATION_URL')
      end,

      token_url: lambda do |connection|
        account_property('TRAVELPERK_TOKEN_URL')
      end,

      apply: lambda do |connection, access_token|
        headers("Authorization": "Bearer #{access_token}", "Api-Version": "1")
      end,

      refresh_on: [401, 403, '401 Authorization Required'],

      refresh: lambda do |connection, refresh_token|

        response = post('#{token_url}').
            payload(
              grant_type: 'refresh_token',
              client_id: connection["client_id"],
              client_secret: connection["client_secret"],
              refresh_token: refresh_token
            )
       [
          {
            access_token: response["access_token"],
            refresh_token: response["refresh_token"]
          }
        ]
      end,
    }
  },

  object_definitions: {
  invoice_lines: {
      fields: lambda do |connection, config_fields|
      [
        {
          "control_type": "text",
          "label": "ID",
          "type": "string",
          "name": "id"
        },
        {
          "control_type": "text",
          "label": "Invoice Serial Number",
          "type": "string",
          "name": "invoice_serial_number"
        },
        {
          "control_type": "text",
          "label": "Expense Date",
          "render_input": "date_time_conversion",
          "parse_output": "date_time_conversion",
          "type": "date_time",
          "name": "expense_date"
        },
        {
          "control_type": "text",
          "label": "Description",
          "type": "string",
          "name": "description"
        },
        {
          "control_type": "number",
          "label": "Total Amount",
          "parse_output": "float_conversion",
          "type": "number",
          "name": "total_amount"
        },
        {
          "control_type": "text",
          "label": "Booker",
          "type": "string",
          "name": "booker"
        },
        {
          "control_type": "text",
          "label": "CostCenter",
          "type": "string",
          "name": "cost_center"
        },
        {
          "control_type": "text",
          "label": "Vendor",
          "type": "string",
          "name": "vendor"
        },
        {
          "control_type": "text",
          "label": "Currency",
          "type": "string",
          "name": "currency"
        },
      ]
      end
    },
  invoices: {
    fields: lambda do |connection, config_fields|
      [
        {
          "control_type": "text",
          "label": "PDF",
          "type": "string",
          "name": "pdf"
        },
     ]
    end
   }
  },

  actions: {
    get_invoice_lines: {          
      execute: lambda do |connection, input|        
        invoice_lines = get("#{connection['base_uri']}invoices/lines")['invoice_lines']
        flattened_invoice_lines = call(:flatten_invoice_lines, invoice_lines)

        flattened_invoice_lines
      end,
      output_fields: lambda do |object_definitions|
        [
          {
            name: "data",
            label: "Data",
            type: :array,
            of: :object,
            properties: object_definitions["invoice_lines"]
          }
        ]
      end
    },
    get_invoice: {
      input_fields: lambda do
        [
          {
            "control_type": "text",
            "label": "Invoie Serial Number",
            "name": "invoice_serial_number",
            "type": "string",
            "optional": false
          }
        ]
      end,
      execute: lambda do |connection, input|
        query_params = {
          'serial_number': input['invoice_serial_number']
        }
        invoices = get("#{connection['base_uri']}invoices", query_params)["invoices"]
        flattened_invoices = call(:flatten_invoices, invoices)
      end,
      output_fields: lambda do |object_definitions|
        [
          {
            name: "data",
            label: "Data",
            type: :array,
            of: :object,
            properties: object_definitions["invoices"]
          }
        ]
      end
    }
  },

  methods: {
    flatten_invoice_lines: lambda do |input|
      flattened_invoice_lines = []
      input.each { |invoice_line|
        flattened_invoice_lines.push({
          id: invoice_line["id"],
          invoice_serial_number: invoice_line["invoice_serial_number"],         
          expense_date: invoice_line["expense_date"],
          description: invoice_line["description"],
          vendor: invoice_line["metadata"]["vendor"]["name"],
          booker: invoice_line["metadata"]["booker"]["name"],
          cost_center: invoice_line["metadata"]["cost_center"],
          currency: invoice_line["currency"],
          total_amount: invoice_line["total_amount"],
        })
      }
      {
        data: flattened_invoice_lines
      }
    end,
  flatten_invoices: lambda do |input|
    flattened_invoices = []
    input.each { |invoice|
      flattened_invoices.push({
        pdf: invoice["pdf"]
      })
    }
    {
      data: flattened_invoices
    }
  end
  }
}
