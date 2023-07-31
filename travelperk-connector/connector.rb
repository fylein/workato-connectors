{
  title: "TravelPerk SDK",

  # API key authentication example. See more examples at https://docs.workato.com/developing-connectors/sdk/guides/authentication.html
  connection: {

    base_uri: lambda do
      account_property("TRAVELPERK_BASE_URL")
    end,

    authorization: {

      type: "custom_auth",

      client_id: lambda do |connection|
        account_property("TRAVELPERK_CLIENT_ID")
      end,

      client_secret: lambda do |connection|
        account_property("TRAVELPERK_CLIENT_SECRET")
      end,

      authorization_url: lambda do |connection|
        account_property("TRAVELPERK_AUTH_URL")
      end,

      token_url: lambda do |connection|
        account_property("TRAVELPERK_TOKEN_URL")
      end,

      refresh_token: lambda do |connection|
        account_property("TRAVELPERK_REFRESH_TOKEN")
      end,

      acquire: lambda do |connection|
        response = post(account_property("TRAVELPERK_TOKEN_URL")).
          payload(
          grant_type: "refresh_token",
          client_id: account_property("TRAVELPERK_CLIENT_ID"),
          client_secret: account_property("TRAVELPERK_CLIENT_SECRET"),
          refresh_token: connection["refresh_token"] ? connection["refresh_token"] : account_property("TRAVELPERK_REFRESH_TOKEN"),
        ).request_format_www_form_urlencoded

        {
          access_token: response["access_token"],
          refresh_token: response["refresh_token"],
        }
      end,

      credentials: ->(connection) {
        headers("Authorization": "Bearer #{connection["access_token"]}", "Api-Version": "1")
      },
    },
  },
  test: ->(connection) { },
  object_definitions: {
    invoice_lines: {
      fields: lambda do |connection, config_fields|
        [
          {
            "control_type": "text",
            "label": "ID",
            "type": "string",
            "name": "id",
          },
          {
            "control_type": "text",
            "label": "Invoice Serial Number",
            "type": "string",
            "name": "invoice_serial_number",
          },
          {
            "control_type": "text",
            "label": "Expense Date",
            "render_input": "date_time_conversion",
            "parse_output": "date_time_conversion",
            "type": "date_time",
            "name": "expense_date",
          },
          {
            "control_type": "text",
            "label": "Description",
            "type": "string",
            "name": "description",
          },
          {
            "control_type": "number",
            "label": "Total Amount",
            "parse_output": "float_conversion",
            "type": "number",
            "name": "total_amount",
          },
          {
            "control_type": "text",
            "label": "Booker",
            "type": "string",
            "name": "booker",
          },
          {
            "control_type": "text",
            "label": "CostCenter",
            "type": "string",
            "name": "cost_center",
          },
          {
            "control_type": "text",
            "label": "Vendor",
            "type": "string",
            "name": "vendor",
          },
          {
            "control_type": "text",
            "label": "Currency",
            "type": "string",
            "name": "currency",
          },
          {
            "control_type": "text",
            "label": "Category",
            "type": "string",
            "name": "category",
          },
        ]
      end,
    },
    invoices: {
      fields: lambda do |connection, config_fields|
        [
          {
            "control_type": "text",
            "label": "PDF",
            "type": "string",
            "name": "pdf",
          },
        ]
      end,
    },
    trigger_invoices: {
      fields: lambda do |connection, config_fields|
        [
          {
            control_type: "text",
            label: "Serial number",
            type: "string",
            name: "serial_number",
          },
          {
            control_type: "text",
            label: "Profile ID",
            type: "string",
            name: "profile_id",
          },
          {
            control_type: "text",
            label: "Profile name",
            type: "string",
            name: "profile_name",
          },
          {
            properties: [
              {
                control_type: "text",
                label: "Legal name",
                type: "string",
                name: "legal_name",
              },
              {
                control_type: "text",
                label: "Vat number",
                type: "string",
                name: "vat_number",
              },
              {
                control_type: "text",
                label: "Address line 1",
                type: "string",
                name: "address_line_1",
              },
              {
                control_type: "text",
                label: "Address line 2",
                type: "string",
                name: "address_line_2",
              },
              {
                control_type: "text",
                label: "City",
                type: "string",
                name: "city",
              },
              {
                control_type: "text",
                label: "Postal code",
                type: "string",
                name: "postal_code",
              },
              {
                control_type: "text",
                label: "Country name",
                type: "string",
                name: "country_name",
              },
            ],
            label: "Billing information",
            type: "object",
            name: "billing_information",
          },
          {
            control_type: "text",
            label: "Mode",
            type: "string",
            name: "mode",
          },
          {
            control_type: "text",
            label: "Status",
            type: "string",
            name: "status",
          },
          {
            control_type: "text",
            label: "Issuing date",
            type: "string",
            name: "issuing_date",
          },
          {
            control_type: "text",
            label: "Billing period",
            type: "string",
            name: "billing_period",
          },
          {
            control_type: "text",
            label: "From date",
            type: "string",
            name: "from_date",
          },
          {
            control_type: "text",
            label: "To date",
            type: "string",
            name: "to_date",
          },
          {
            control_type: "text",
            label: "Due date",
            type: "string",
            name: "due_date",
          },
          {
            control_type: "text",
            label: "Currency",
            type: "string",
            name: "currency",
          },
          {
            control_type: "text",
            label: "Total",
            type: "string",
            name: "total",
          },
          {
            name: "taxes_summary",
            type: "array",
            of: "object",
            label: "Taxes summary",
            properties: [
              {
                control_type: "text",
                label: "Tax regime",
                type: "string",
                name: "tax_regime",
              },
              {
                control_type: "text",
                label: "Subtotal",
                type: "string",
                name: "subtotal",
              },
              {
                control_type: "text",
                label: "Tax percentage",
                type: "string",
                name: "tax_percentage",
              },
              {
                control_type: "text",
                label: "Tax amount",
                type: "string",
                name: "tax_amount",
              },
              {
                control_type: "text",
                label: "Total",
                type: "string",
                name: "total",
              },
            ],
          },
          {
            control_type: "text",
            label: "Reference",
            type: "string",
            name: "reference",
          },
          {
            control_type: "text",
            label: "Travelperk bank account",
            type: "string",
            name: "travelperk_bank_account",
          },
          {
            control_type: "text",
            label: "Pdf",
            type: "string",
            name: "pdf",
          },
          {
            name: "lines",
            type: "array",
            of: "object",
            label: "Lines",
            properties: [
              {
                control_type: "text",
                label: "ID",
                type: "string",
                name: "id",
              },
              {
                control_type: "text",
                label: "Expense date",
                type: "string",
                name: "expense_date",
              },
              {
                control_type: "text",
                label: "Description",
                type: "string",
                name: "description",
              },
              {
                control_type: "number",
                label: "Quantity",
                parse_output: "float_conversion",
                type: "number",
                name: "quantity",
              },
              {
                control_type: "text",
                label: "Unit price",
                type: "string",
                name: "unit_price",
              },
              {
                control_type: "text",
                label: "Non taxable unit price",
                type: "string",
                name: "non_taxable_unit_price",
              },
              {
                control_type: "text",
                label: "Tax percentage",
                type: "string",
                name: "tax_percentage",
              },
              {
                control_type: "text",
                label: "Tax amount",
                type: "string",
                name: "tax_amount",
              },
              {
                control_type: "text",
                label: "Tax regime",
                type: "string",
                name: "tax_regime",
              },
              {
                control_type: "text",
                label: "Total amount",
                type: "string",
                name: "total_amount",
              },
              {
                properties: [
                  {
                    control_type: "number",
                    label: "Trip ID",
                    parse_output: "float_conversion",
                    type: "number",
                    name: "trip_id",
                  },
                  {
                    control_type: "text",
                    label: "Trip name",
                    type: "string",
                    name: "trip_name",
                  },
                  {
                    control_type: "text",
                    label: "Service",
                    type: "string",
                    name: "service",
                  },
                  {
                    name: "travelers",
                    type: "array",
                    of: "object",
                    label: "Travelers",
                    properties: [
                      {
                        control_type: "text",
                        label: "Name",
                        type: "string",
                        name: "name",
                      },
                      {
                        control_type: "text",
                        label: "Email",
                        type: "string",
                        name: "email",
                      },
                      {
                        control_type: "text",
                        label: "External ID",
                        type: "string",
                        name: "external_id",
                      },
                    ],
                  },
                  {
                    properties: [
                      {
                        control_type: "text",
                        label: "Name",
                        type: "string",
                        name: "name",
                      },
                      {
                        control_type: "text",
                        label: "Email",
                        type: "string",
                        name: "email",
                      },
                      {
                        control_type: "text",
                        label: "External ID",
                        type: "string",
                        name: "external_id",
                      },
                    ],
                    label: "Booker",
                    type: "object",
                    name: "booker",
                  },
                  {
                    control_type: "text",
                    label: "Start date",
                    type: "string",
                    name: "start_date",
                  },
                  {
                    control_type: "text",
                    label: "End date",
                    type: "string",
                    name: "end_date",
                  },
                  {
                    control_type: "text",
                    label: "Cost center",
                    type: "string",
                    name: "cost_center",
                  },
                  {
                    properties: [
                      {
                        control_type: "text",
                        label: "Code",
                        type: "string",
                        name: "code",
                      },
                      {
                        control_type: "text",
                        label: "Name",
                        type: "string",
                        name: "name",
                      },
                    ],
                    label: "Vendor",
                    type: "object",
                    name: "vendor",
                  },
                  {
                    control_type: "text",
                    label: "Out of policy",
                    render_input: {},
                    parse_output: {},
                    toggle_hint: "Select from option list",
                    toggle_field: {
                      label: "Out of policy",
                      control_type: "text",
                      toggle_hint: "Use custom value",
                      type: "boolean",
                      name: "out_of_policy",
                    },
                    type: "boolean",
                    name: "out_of_policy",
                  },
                  {
                    properties: [
                      {
                        properties: [
                          {
                            control_type: "text",
                            label: "City",
                            type: "string",
                            name: "city",
                          },
                          {
                            control_type: "text",
                            label: "Country",
                            type: "string",
                            name: "country",
                          },
                          {
                            control_type: "text",
                            label: "Latitude",
                            type: "string",
                            name: "latitude",
                          },
                          {
                            control_type: "text",
                            label: "Longitude",
                            type: "string",
                            name: "longitude",
                          },
                          {
                            control_type: "text",
                            label: "Country code",
                            type: "string",
                            name: "country_code",
                          },
                        ],
                        label: "Hotel location",
                        type: "object",
                        name: "hotel_location",
                      },
                    ],
                    label: "Service location",
                    type: "object",
                    name: "service_location",
                  },
                  {
                    control_type: "text",
                    label: "Include breakfast",
                    render_input: {},
                    parse_output: {},
                    toggle_hint: "Select from option list",
                    toggle_field: {
                      label: "Include breakfast",
                      control_type: "text",
                      toggle_hint: "Use custom value",
                      type: "boolean",
                      name: "include_breakfast",
                    },
                    type: "boolean",
                    name: "include_breakfast",
                  },
                  {
                    control_type: "text",
                    label: "Credit card last 4 digits",
                    type: "string",
                    name: "credit_card_last_4_digits",
                  },
                ],
                label: "Metadata",
                type: "object",
                name: "metadata",
              },
            ],
          },
        ]
      end,
    },
  },
  actions: {
    get_invoice_lines: {
      execute: lambda do |connection|
        invoice_lines = get("#{connection["base_uri"]}invoices/lines")["invoice_lines"]
        flattened_invoice_lines = call(:flatten_invoice_lines, { "lines": invoice_lines })

        flattened_invoice_lines
      end,
      output_fields: lambda do |object_definitions|
        [
          {
            name: "data",
            label: "Data",
            type: "array",
            of: "object",
            properties: object_definitions["invoice_lines"],
          },
        ]
      end,
    },
    get_invoice: {
      input_fields: lambda do
        [
          {
            "control_type": "text",
            "label": "Invoie Serial Number",
            "name": "invoice_serial_number",
            "type": "string",
            "optional": false,
          },
        ]
      end,
      execute: lambda do |connection, input|
        query_params = {
          'serial_number': input["invoice_serial_number"],
        }
        invoices = get("#{connection["base_uri"]}invoices", query_params)["invoices"]
        flattened_invoices = call(:flatten_invoices, invoices)
      end,
      output_fields: lambda do |object_definitions|
        [
          {
            name: "data",
            label: "Data",
            type: "array",
            of: "object",
            properties: object_definitions["invoices"],
          },
        ]
      end,
    },
    get_webhooks: {
      execute: lambda do |connection|
        invoices = get("#{connection["base_uri"]}webhooks")
      end,
    },
    test_webhooks: {
      input_fields: lambda do
        [
          {
            "control_type": "text",
            "label": "Webhook ID",
            "name": "webhook_id",
            "type": "string",
            "optional": false,
          },
        ]
      end,
      execute: lambda do |connection, input|
        invoices = post("#{connection["base_uri"]}webhooks/#{input["webhook_id"]}/test", { "data": { "name": "Nilesh Pant" } })
      end,
    },
    flatten_travelperk_lines: {
      input_fields: lambda do |object_definitions|
        object_definitions["trigger_invoices"]
      end,

      execute: lambda do |connection, input|
        flattened_invoice_lines = call(:flatten_invoice_lines, input)
        flattened_invoice_lines
      end,

      output_fields: lambda do |object_definitions|
        [
          {
            name: "data",
            label: "Data",
            type: "array",
            of: "object",
            properties: object_definitions["invoice_lines"],
          },
        ]
      end,

    },
  },
  triggers: {
    invoice_created: {
      title: "Invoice Issued",
      subtitle: "Triggers a message when a new invoice is Issued!",
      description: lambda do |input, picklist_label|
        "New <span class='provider'>Invoice Issued</span> in " \
        "<span class='provider'>Travelperk</span>"
      end,
      help: "Triggers when webhook is sent from Travelperk.",

      input_fields: lambda do |object_definitions|
        [
          {
            name: "secret",
            label: "Secret",
            optional: false,
          },
        ]
      end,

      webhook_subscribe: lambda do |webhook_url, connection, input, recipe_id|
        response = post("#{connection["base_uri"]}/webhooks",
                        name: "Workato recipe #{recipe_id}",
                        url: webhook_url,
                        events: ["invoice.issued"],
                        secret: input["secret"])
      end,

      webhook_notification: lambda do |input, payload, extended_input_schema, extended_output_schema, headers, params|
        payload
      end,

      webhook_unsubscribe: lambda do |webhook_subscribe_output, connection|
        delete("#{connection["base_uri"]}/webhooks/#{webhook_subscribe_output["id"]}")
      end,

      dedup: lambda do |_message|
        Time.now.to_f.to_s
      end,

      output_fields: lambda do |object_definitions|
        object_definitions["trigger_invoices"]
      end,
    },
  },
  methods: {
    flatten_invoice_lines: lambda do |input|
      flattened_invoice_lines = []
      input["lines"].each { |invoice_line|
        flattened_invoice_lines.push({
          id: invoice_line["id"],
          invoice_serial_number: input["serial_number"],
          expense_date: invoice_line["expense_date"],
          description: invoice_line["description"],
          vendor: invoice_line["metadata"]["vendor"] ? invoice_line["metadata"]["vendor"]["name"] : null,
          category: invoice_line["metadata"]["service"] ? invoice_line["metadata"]["service"] : null,
          booker: invoice_line["metadata"]["booker"]["name"],
          cost_center: invoice_line["metadata"]["cost_center"],
          currency: input["currency"],
          total_amount: invoice_line["total_amount"],
          assignee_user_email: invoice_line["metadata"]["travelers"][0]["email"],
        })
      }

      {
        data: flattened_invoice_lines,
      }
    end,
    flatten_invoices: lambda do |input|
      flattened_invoices = []
      input.each { |invoice|
        flattened_invoices.push({
          pdf: invoice["pdf"],
        })
      }
      {
        data: flattened_invoices,
      }
    end,
  },
}
