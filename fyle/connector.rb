{
  title: "Fyle",

  # API key authentication example. See more examples at https://docs.workato.com/developing-connectors/sdk/guides/authentication.html
  connection: {
    fields: [
      {
        name: "client_id",
        optional: true,
        hint: "this is just to avoid a workato bug",
      },
    ],
    authorization: {
      type: "custom_auth",

      client_id: lambda do |connection|
        account_property("FYLE_CLIENT_ID")
      end,

      client_secret: lambda do |connection|
        account_property("FYLE_CLIENT_SECRET")
      end,

      refresh_token: lambda do |connection|
        account_property("REFRESH_TOKEN")
      end,

      token_url: lambda do |connection|
        account_property("FYLE_TOKEN_URI")
      end,

      base_uri: lambda do |connection|
        account_property("BASE_URI")
      end,

      acquire: lambda do |connection|
        response = post(connection.member?("token_url") ? connection["token_url"] : account_property("FYLE_TOKEN_URI"),
                        grant_type: "refresh_token",
                        refresh_token: connection.member?(:refresh_token) ? connection["refresh_token"] : account_property("REFRESH_TOKEN"),
                        client_id: connection.member?(:client_id) ? connection["client_id"] : account_property("FYLE_CLIENT_ID"),
                        client_secret: connection.member?(:client_secret) ? connection["client_secret"] : account_property("FYLE_CLIENT_SECRET"))
        { token: response.after_response do |code, body, response_headers| body["access_token"] end }
      end,

      credentials: ->(connection) {
        headers("Authorization": "Bearer #{connection["token"]}")
      },
    },
    base_uri: lambda do |connection|
      account_property("BASE_URI")
    end,
  },

  test: ->(connection) { },

  object_definitions: {
    files: {
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
            "label": "Name",
            "type": "string",
            "name": "name",
          },
          {
            "control_type": "text",
            "label": "Content Type",
            "type": "string",
            "name": "content_type",
          },
        ]
      end,
    },
    file_upload_url: {
      fields: lambda do |connection, config_fields|
        [
          {
            "control_type": "text",
            "label": "Content type",
            "type": "string",
            "name": "content_type",
          },
          {
            "control_type": "text",
            "label": "Download URL",
            "type": "string",
            "name": "download_url",
          },
          {
            "control_type": "text",
            "label": "ID",
            "type": "string",
            "name": "id",
          },
          {
            "control_type": "text",
            "label": "Name",
            "type": "string",
            "name": "name",
          },
          {
            "control_type": "text",
            "label": "Upload URL",
            "type": "string",
            "name": "upload_url",
          },
        ]
      end,
    },
    user: {
      fields: lambda do |connection, config_fields|
        [
          {
            "name": "id",
          },
          {
            "name": "email",
          },
          {
            "name": "full_name",
          },
        ]
      end,
    },
    cost_center: {
      fields: lambda do |connection, config_fields|
        [
          {
            "name": "id",
          },
          {
            "name": "name",
          },
          {
            "name": "code",
          },
        ]
      end,
    },
    department: {
      fields: lambda do |connection, config_fields|
        [
          {
            "control_type": "text",
            "label": "Code",
            "type": "string",
            "name": "code",
          },
          {
            "control_type": "text",
            "label": "Created at",
            "render_input": "date_time_conversion",
            "parse_output": "date_time_conversion",
            "type": "date_time",
            "name": "created_at",
          },
          {
            "control_type": "text",
            "label": "Description",
            "type": "string",
            "name": "description",
          },
          {
            "control_type": "text",
            "label": "Display name",
            "type": "string",
            "name": "display_name",
          },
          {
            "control_type": "text",
            "label": "Doc URL",
            "type": "string",
            "name": "doc_url",
          },
          {
            "control_type": "text",
            "label": "ID",
            "type": "string",
            "name": "id",
          },
          {
            "control_type": "text",
            "label": "Is enabled",
            "render_input": {},
            "parse_output": {},
            "toggle_hint": "Select from option list",
            "toggle_field": {
              "label": "Is enabled",
              "control_type": "text",
              "toggle_hint": "Use custom value",
              "type": "boolean",
              "name": "is_enabled",
            },
            "type": "boolean",
            "name": "is_enabled",
          },
          {
            "control_type": "text",
            "label": "Name",
            "type": "string",
            "name": "name",
          },
          {
            "control_type": "text",
            "label": "Org ID",
            "type": "string",
            "name": "org_id",
          },
          {
            "control_type": "text",
            "label": "Sub department",
            "type": "string",
            "name": "sub_department",
          },
          {
            "control_type": "text",
            "label": "Updated at",
            "render_input": "date_time_conversion",
            "parse_output": "date_time_conversion",
            "type": "date_time",
            "name": "updated_at",
          },
        ]
      end,
    },
    category: {
      fields: lambda do |connection, config_fields|
        [
          {
            "control_type": "number",
            "label": "ID",
            "parse_output": "float_conversion",
            "type": "number",
            "name": "id",
          },
          {
            "control_type": "text",
            "label": "Org ID",
            "type": "string",
            "name": "org_id",
          },
          {
            "control_type": "text",
            "label": "Created at",
            "render_input": "date_time_conversion",
            "parse_output": "date_time_conversion",
            "type": "date_time",
            "name": "created_at",
          },
          {
            "control_type": "text",
            "label": "Updated at",
            "render_input": "date_time_conversion",
            "parse_output": "date_time_conversion",
            "type": "date_time",
            "name": "updated_at",
          },
          {
            "control_type": "text",
            "label": "Name",
            "type": "string",
            "name": "name",
          },
          {
            "control_type": "text",
            "label": "Sub category",
            "type": "string",
            "name": "sub_category",
          },
          {
            "control_type": "text",
            "label": "Is enabled",
            "render_input": {},
            "parse_output": {},
            "toggle_hint": "Select from option list",
            "toggle_field": {
              "label": "Is enabled",
              "control_type": "text",
              "toggle_hint": "Use custom value",
              "type": "boolean",
              "name": "is_enabled",
            },
            "type": "boolean",
            "name": "is_enabled",
          },
          {
            "control_type": "text",
            "label": "Display name",
            "type": "string",
            "name": "display_name",
          },
          {
            "control_type": "text",
            "label": "System category",
            "type": "string",
            "name": "system_category",
          },
          {
            "control_type": "text",
            "label": "Code",
            "type": "string",
            "name": "code",
          },
        ]
      end,
    },
    system_category: {
      fields: lambda do |connection, config_fields|
        [
          {
            "control_type": "number",
            "label": "Count",
            "parse_output": "float_conversion",
            "type": "number",
            "name": "count",
          },
          {
            "name": "data",
            "type": "array",
            "of": "object",
            "label": "Data",
            "properties": [
              {
                "control_type": "text",
                "label": "Name",
                "type": "string",
                "name": "name",
              },
            ],
          },
        ]
      end,
    },
    project: {
      fields: lambda do |connection, config_fields|
        [
          {
            "control_type": "number",
            "label": "ID",
            "parse_output": "float_conversion",
            "type": "number",
            "name": "id",
          },
          {
            "control_type": "text",
            "label": "Org ID",
            "type": "string",
            "name": "org_id",
          },
          {
            "control_type": "text",
            "label": "Created at",
            "render_input": "date_time_conversion",
            "parse_output": "date_time_conversion",
            "type": "date_time",
            "name": "created_at",
          },
          {
            "control_type": "text",
            "label": "Updated at",
            "render_input": "date_time_conversion",
            "parse_output": "date_time_conversion",
            "type": "date_time",
            "name": "updated_at",
          },
          {
            "control_type": "text",
            "label": "Name",
            "type": "string",
            "name": "name",
          },
          {
            "control_type": "text",
            "label": "Sub project",
            "type": "string",
            "name": "sub_project",
          },
          {
            "control_type": "text",
            "label": "Code",
            "type": "string",
            "name": "code",
          },
          {
            "control_type": "text",
            "label": "Display name",
            "type": "string",
            "name": "display_name",
          },
          {
            "control_type": "text",
            "label": "Description",
            "type": "string",
            "name": "description",
          },
          {
            "control_type": "text",
            "label": "Is enabled",
            "render_input": {},
            "parse_output": {},
            "toggle_hint": "Select from option list",
            "toggle_field": {
              "label": "Is enabled",
              "control_type": "text",
              "toggle_hint": "Use custom value",
              "type": "boolean",
              "name": "is_enabled",
            },
            "type": "boolean",
            "name": "is_enabled",
          },
        ]
      end,
    },
    source_account: {
      fields: lambda do
        [
          {
            "name": "id",
          },
          {
            "name": "type",
          },
        ]
      end,
    },
    corporate_card: {
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
            "label": "Org ID",
            "type": "string",
            "name": "org_id",
          },
          {
            "control_type": "text",
            "label": "User ID",
            "type": "string",
            "name": "user_id",
          },
          {
            "control_type": "text",
            "label": "Created at",
            "render_input": "date_time_conversion",
            "parse_output": "date_time_conversion",
            "type": "date_time",
            "name": "created_at",
          },
          {
            "control_type": "text",
            "label": "Updated at",
            "render_input": "date_time_conversion",
            "parse_output": "date_time_conversion",
            "type": "date_time",
            "name": "updated_at",
          },
          {
            "control_type": "text",
            "label": "Bank name",
            "type": "string",
            "name": "bank_name",
          },
          {
            "control_type": "text",
            "label": "Card number",
            "type": "string",
            "name": "card_number",
          },
          {
            "control_type": "text",
            "label": "Cardholder name",
            "type": "string",
            "name": "cardholder_name",
          },
          {
            "control_type": "text",
            "label": "Data feed source",
            "type": "string",
            "name": "data_feed_source",
          },
          {
            "control_type": "text",
            "label": "Code",
            "type": "string",
            "name": "code",
          },
          {
            "control_type": "text",
            "label": "Last synced at",
            "render_input": "date_time_conversion",
            "parse_output": "date_time_conversion",
            "type": "date_time",
            "name": "last_synced_at",
          },
          {
            "control_type": "text",
            "label": "Last assigned at",
            "render_input": "date_time_conversion",
            "parse_output": "date_time_conversion",
            "type": "date_time",
            "name": "last_assigned_at",
          },
          {
            "control_type": "text",
            "label": "Assignor user ID",
            "type": "string",
            "name": "assignor_user_id",
          },
          {
            "control_type": "text",
            "label": "Is visa enrolled",
            "render_input": {},
            "parse_output": {},
            "toggle_hint": "Select from option list",
            "toggle_field": {
              "label": "Is visa enrolled",
              "control_type": "text",
              "toggle_hint": "Use custom value",
              "type": "boolean",
              "name": "is_visa_enrolled",
            },
            "type": "boolean",
            "name": "is_visa_enrolled",
          },
          {
            "control_type": "text",
            "label": "Is dummy",
            "render_input": {},
            "parse_output": {},
            "toggle_hint": "Select from option list",
            "toggle_field": {
              "label": "Is dummy",
              "control_type": "text",
              "toggle_hint": "Use custom value",
              "type": "boolean",
              "name": "is_dummy",
            },
            "type": "boolean",
            "name": "is_dummy",
          },
          {
            "control_type": "text",
            "label": "Last ready for verification at",
            "render_input": "date_time_conversion",
            "parse_output": "date_time_conversion",
            "type": "date_time",
            "name": "last_ready_for_verification_at",
          },
          {
            "control_type": "text",
            "label": "Last verification attempt at",
            "render_input": "date_time_conversion",
            "parse_output": "date_time_conversion",
            "type": "date_time",
            "name": "last_verification_attempt_at",
          },
          {
            "control_type": "text",
            "label": "Last verified at",
            "render_input": "date_time_conversion",
            "parse_output": "date_time_conversion",
            "type": "date_time",
            "name": "last_verified_at",
          },
          {
            "control_type": "text",
            "label": "Verification status",
            "type": "string",
            "name": "verification_status",
          },
        ]
      end,
    },
    expense: {
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
            "label": "User ID",
            "type": "string",
            "name": "user_id",
          },
          {
            "control_type": "text",
            "label": "User email",
            "type": "string",
            "name": "user_email",
          },
          {
            "control_type": "text",
            "label": "User full name",
            "type": "string",
            "name": "user_full_name",
          },
          {
            "control_type": "text",
            "label": "Org ID",
            "type": "string",
            "name": "org_id",
          },
          {
            "control_type": "text",
            "label": "Created at",
            "render_input": "date_time_conversion",
            "parse_output": "date_time_conversion",
            "type": "date_time",
            "name": "created_at",
          },
          {
            "control_type": "text",
            "label": "Updated at",
            "render_input": "date_time_conversion",
            "parse_output": "date_time_conversion",
            "type": "date_time",
            "name": "updated_at",
          },
          {
            "control_type": "text",
            "label": "Spent at",
            "render_input": "date_time_conversion",
            "parse_output": "date_time_conversion",
            "type": "date_time",
            "name": "spent_at",
          },
          {
            "control_type": "text",
            "label": "Source",
            "type": "string",
            "name": "source",
          },
          {
            "control_type": "text",
            "label": "Merchant",
            "type": "string",
            "name": "merchant",
          },
          {
            "control_type": "text",
            "label": "Currency",
            "type": "string",
            "name": "currency",
          },
          {
            "control_type": "number",
            "label": "Amount",
            "parse_output": "float_conversion",
            "type": "number",
            "name": "amount",
          },
          {
            "control_type": "text",
            "label": "Foreign currency",
            "type": "string",
            "name": "foreign_currency",
          },
          {
            "control_type": "number",
            "label": "Foreign amount",
            "parse_output": "float_conversion",
            "type": "number",
            "name": "foreign_amount",
          },
          {
            "control_type": "text",
            "label": "Purpose",
            "type": "string",
            "name": "purpose",
          },
          {
            "control_type": "number",
            "label": "Cost center ID",
            "parse_output": "float_conversion",
            "type": "number",
            "name": "cost_center_id",
          },
          {
            "control_type": "text",
            "label": "Cost center name",
            "type": "string",
            "name": "cost_center_name",
          },
          {
            "control_type": "text",
            "label": "Cost center code",
            "type": "string",
            "name": "cost_center_code",
          },
          {
            "control_type": "number",
            "label": "Category ID",
            "parse_output": "float_conversion",
            "type": "number",
            "name": "category_id",
          },
          {
            "control_type": "text",
            "label": "Category name",
            "type": "string",
            "name": "category_name",
          },
          {
            "control_type": "text",
            "label": "Sub category",
            "type": "string",
            "name": "sub_category",
          },
          {
            "control_type": "text",
            "label": "Category code",
            "type": "string",
            "name": "category_code",
          },
          {
            "control_type": "number",
            "label": "Project ID",
            "parse_output": "float_conversion",
            "type": "number",
            "name": "project_id",
          },
          {
            "control_type": "text",
            "label": "Project name",
            "type": "string",
            "name": "project_name",
          },
          {
            "control_type": "text",
            "label": "Sub project",
            "type": "string",
            "name": "sub_project",
          },
          {
            "control_type": "text",
            "label": "Project code",
            "type": "string",
            "name": "project_code",
          },
          {
            "control_type": "text",
            "label": "Source account ID",
            "type": "string",
            "name": "source_account_id",
          },
          {
            "control_type": "text",
            "label": "Source account type",
            "type": "string",
            "name": "source_account_type",
          },
          {
            "control_type": "number",
            "label": "Tax amount",
            "parse_output": "float_conversion",
            "type": "number",
            "name": "tax_amount",
          },
          {
            "control_type": "text",
            "label": "Tax group ID",
            "type": "string",
            "name": "tax_group_id",
          },
          {
            "control_type": "text",
            "label": "Is billable",
            "render_input": {},
            "parse_output": {},
            "toggle_hint": "Select from option list",
            "toggle_field": {
              "label": "Is billable",
              "control_type": "text",
              "toggle_hint": "Use custom value",
              "type": "boolean",
              "name": "is_billable",
            },
            "type": "boolean",
            "name": "is_billable",
          },
          {
            "control_type": "text",
            "label": "Is reimbursable",
            "render_input": {},
            "parse_output": {},
            "toggle_hint": "Select from option list",
            "toggle_field": {
              "label": "Is reimbursable",
              "control_type": "text",
              "toggle_hint": "Use custom value",
              "type": "boolean",
              "name": "is_reimbursable",
            },
            "type": "boolean",
            "name": "is_reimbursable",
          },
          {
            "control_type": "text",
            "label": "Code",
            "type": "string",
            "name": "code",
          },
          {
            "control_type": "text",
            "label": "State",
            "type": "string",
            "name": "state",
          },
          {
            "control_type": "text",
            "label": "Seq num",
            "type": "string",
            "name": "seq_num",
          },
          {
            "control_type": "text",
            "label": "Added to report at",
            "render_input": "date_time_conversion",
            "parse_output": "date_time_conversion",
            "type": "date_time",
            "name": "added_to_report_at",
          },
          {
            "control_type": "text",
            "label": "Report ID",
            "type": "string",
            "name": "report_id",
          },
          {
            "control_type": "text",
            "label": "Report last approved at",
            "render_input": "date_time_conversion",
            "parse_output": "date_time_conversion",
            "type": "date_time",
            "name": "report_last_approved_at",
          },
          {
            "control_type": "text",
            "label": "Report last submitted at",
            "render_input": "date_time_conversion",
            "parse_output": "date_time_conversion",
            "type": "date_time",
            "name": "report_last_submitted_at",
          },
          {
            "control_type": "text",
            "label": "Report seq num",
            "type": "string",
            "name": "report_seq_num",
          },
          {
            "control_type": "text",
            "label": "Report title",
            "type": "string",
            "name": "report_title",
          },
          {
            "control_type": "text",
            "label": "Report state",
            "type": "string",
            "name": "report_state",
          },
          {
            "control_type": "text",
            "label": "Report settlement ID",
            "type": "string",
            "name": "report_settlement_id",
          },
          {
            "control_type": "text",
            "label": "Report last paid at",
            "render_input": "date_time_conversion",
            "parse_output": "date_time_conversion",
            "type": "date_time",
            "name": "report_last_paid_at",
          },
          {
            "control_type": "text",
            "label": "Is verified",
            "render_input": {},
            "parse_output": {},
            "toggle_hint": "Select from option list",
            "toggle_field": {
              "label": "Is verified",
              "control_type": "text",
              "toggle_hint": "Use custom value",
              "type": "boolean",
              "name": "is_verified",
            },
            "type": "boolean",
            "name": "is_verified",
          },
          {
            "control_type": "text",
            "label": "Last verified at",
            "render_input": "date_time_conversion",
            "parse_output": "date_time_conversion",
            "type": "date_time",
            "name": "last_verified_at",
          },
          {
            "control_type": "text",
            "label": "Is exported",
            "render_input": {},
            "parse_output": {},
            "toggle_hint": "Select from option list",
            "toggle_field": {
              "label": "Is exported",
              "control_type": "text",
              "toggle_hint": "Use custom value",
              "type": "boolean",
              "name": "is_exported",
            },
            "type": "boolean",
            "name": "is_exported",
          },
          {
            "control_type": "text",
            "label": "Last exported at",
            "render_input": "date_time_conversion",
            "parse_output": "date_time_conversion",
            "type": "date_time",
            "name": "last_exported_at",
          },
          {
            "control_type": "text",
            "label": "Employee ID",
            "type": "string",
            "name": "employee_id",
          },
          {
            "control_type": "text",
            "label": "Employee code",
            "type": "string",
            "name": "employee_code",
          },
          {
            "control_type": "text",
            "label": "Employee department ID",
            "type": "string",
            "name": "employee_department_id",
          },
          {
            "control_type": "text",
            "label": "Employee department code",
            "type": "string",
            "name": "employee_department_code",
          },
          {
            "control_type": "text",
            "label": "Employee department name",
            "type": "string",
            "name": "employee_department_name",
          },
          {
            "control_type": "text",
            "label": "Employee sub department name",
            "type": "string",
            "name": "employee_sub_department_name",
          },
          {
            "control_type": "text",
            "label": "Is corporate card transaction auto matched",
            "render_input": {},
            "parse_output": {},
            "toggle_hint": "Select from option list",
            "toggle_field": {
              "label": "Is corporate card transaction auto matched",
              "control_type": "text",
              "toggle_hint": "Use custom value",
              "type": "boolean",
              "name": "is_corporate_card_transaction_auto_matched",
            },
            "type": "boolean",
            "name": "is_corporate_card_transaction_auto_matched",
          },
          {
            "control_type": "text",
            "label": "Corporate card ID",
            "type": "string",
            "name": "corporate_card_id",
          },
          {
            "control_type": "text",
            "label": "Corporate card number",
            "type": "string",
            "name": "corporate_card_number",
          },
          {
            "control_type": "text",
            "label": "Last settled at",
            "render_input": "date_time_conversion",
            "parse_output": "date_time_conversion",
            "type": "date_time",
            "name": "last_settled_at",
          },
          {
            "control_type": "text",
            "label": "Cluster Domain",
            "type": "string",
            "name": "cluster_domain",
          },
        ]
      end,
    },
    employees: {
      fields: lambda do |connection, config_fields|
        [
          {
            "control_type": "number",
            "label": "Count",
            "parse_output": "float_conversion",
            "type": "number",
            "name": "count",
          },
          {
            "name": "data",
            "type": "array",
            "of": "object",
            "label": "Data",
            "properties": [
              {
                "control_type": "text",
                "label": "Branch account",
                "type": "string",
                "name": "branch_account",
              },
              {
                "control_type": "text",
                "label": "Branch ifsc",
                "type": "string",
                "name": "branch_ifsc",
              },
              {
                "control_type": "text",
                "label": "Business unit",
                "type": "string",
                "name": "business_unit",
              },
              {
                "control_type": "text",
                "label": "Code",
                "type": "string",
                "name": "code",
              },
              {
                "control_type": "text",
                "label": "Created at",
                "render_input": "date_time_conversion",
                "parse_output": "date_time_conversion",
                "type": "date_time",
                "name": "created_at",
              },
              {
                "control_type": "text",
                "label": "Department",
                "type": "string",
                "name": "department",
              },
              {
                "control_type": "text",
                "label": "Department ID",
                "type": "string",
                "name": "department_id",
              },
              {
                "control_type": "text",
                "label": "Has accepted invite",
                "render_input": {},
                "parse_output": {},
                "toggle_hint": "Select from option list",
                "toggle_field": {
                  "label": "Has accepted invite",
                  "control_type": "text",
                  "toggle_hint": "Use custom value",
                  "type": "boolean",
                  "name": "has_accepted_invite",
                },
                "type": "boolean",
                "name": "has_accepted_invite",
              },
              {
                "control_type": "text",
                "label": "ID",
                "type": "string",
                "name": "id",
              },
              {
                "control_type": "text",
                "label": "Is enabled",
                "render_input": {},
                "parse_output": {},
                "toggle_hint": "Select from option list",
                "toggle_field": {
                  "label": "Is enabled",
                  "control_type": "text",
                  "toggle_hint": "Use custom value",
                  "type": "boolean",
                  "name": "is_enabled",
                },
                "type": "boolean",
                "name": "is_enabled",
              },
              {
                "control_type": "text",
                "label": "Joined at",
                "render_input": "date_time_conversion",
                "parse_output": "date_time_conversion",
                "type": "date_time",
                "name": "joined_at",
              },
              {
                "control_type": "text",
                "label": "Level",
                "type": "string",
                "name": "level",
              },
              {
                "control_type": "text",
                "label": "Level ID",
                "type": "string",
                "name": "level_id",
              },
              {
                "control_type": "text",
                "label": "Location",
                "type": "string",
                "name": "location",
              },
              {
                "control_type": "text",
                "label": "Mobile",
                "type": "string",
                "name": "mobile",
              },
              {
                "control_type": "text",
                "label": "Org ID",
                "type": "string",
                "name": "org_id",
              },
              {
                "name": "roles",
                "type": "array",
                "of": "string",
                "control_type": "text",
                "label": "Roles",
              },
              {
                "control_type": "text",
                "label": "Special email",
                "type": "string",
                "name": "special_email",
              },
              {
                "control_type": "text",
                "label": "Title",
                "type": "string",
                "name": "title",
              },
              {
                "control_type": "text",
                "label": "Updated at",
                "render_input": "date_time_conversion",
                "parse_output": "date_time_conversion",
                "type": "date_time",
                "name": "updated_at",
              },
              {
                "label": "User",
                "type": "object",
                "name": "user",
                "properties": [
                  {
                    "control_type": "text",
                    "label": "Email",
                    "type": "string",
                    "name": "email",
                  },
                  {
                    "control_type": "text",
                    "label": "Full name",
                    "type": "string",
                    "name": "full_name",
                  },
                  {
                    "control_type": "text",
                    "label": "ID",
                    "type": "string",
                    "name": "id",
                  },
                ],
              },
              {
                "control_type": "text",
                "label": "User ID",
                "type": "string",
                "name": "user_id",
              },
            ],
          },
          {
            "control_type": "number",
            "label": "Offset",
            "parse_output": "float_conversion",
            "type": "number",
            "name": "offset",
          },
        ]
      end,
    },
    expese_reports: {
      fields: lambda do |connection, config_fields|
        [
          {
            "name": "data",
            "type": "array",
            "of": "object",
            "label": "Data",
            "properties": [
              {
                "control_type": "number",
                "label": "Amount",
                "parse_output": "float_conversion",
                "type": "number",
                "name": "amount",
              },
              {
                "name": "approvals",
                "type": "array",
                "of": "object",
                "label": "Approvals",
                "properties": [
                  {
                    "label": "Approver user",
                    "type": "object",
                    "name": "approver_user",
                    "properties": [
                      {
                        "control_type": "text",
                        "label": "Email",
                        "type": "string",
                        "name": "email",
                      },
                      {
                        "control_type": "text",
                        "label": "Full name",
                        "type": "string",
                        "name": "full_name",
                      },
                      {
                        "control_type": "text",
                        "label": "ID",
                        "type": "string",
                        "name": "id",
                      },
                    ],
                  },
                  {
                    "control_type": "text",
                    "label": "Approver user ID",
                    "type": "string",
                    "name": "approver_user_id",
                  },
                  {
                    "control_type": "text",
                    "label": "State",
                    "type": "string",
                    "name": "state",
                  },
                ],
              },
              {
                "control_type": "text",
                "label": "Created at",
                "render_input": "date_time_conversion",
                "parse_output": "date_time_conversion",
                "type": "date_time",
                "name": "created_at",
              },
              {
                "control_type": "text",
                "label": "Currency",
                "type": "string",
                "name": "currency",
              },
              {
                "control_type": "text",
                "label": "ID",
                "type": "string",
                "name": "id",
              },
              {
                "control_type": "text",
                "label": "Is exported",
                "render_input": {},
                "parse_output": {},
                "toggle_hint": "Select from option list",
                "toggle_field": {
                  "label": "Is exported",
                  "control_type": "text",
                  "toggle_hint": "Use custom value",
                  "type": "boolean",
                  "name": "is_exported",
                },
                "type": "boolean",
                "name": "is_exported",
              },
              {
                "control_type": "text",
                "label": "Is manually flagged",
                "render_input": {},
                "parse_output": {},
                "toggle_hint": "Select from option list",
                "toggle_field": {
                  "label": "Is manually flagged",
                  "control_type": "text",
                  "toggle_hint": "Use custom value",
                  "type": "boolean",
                  "name": "is_manually_flagged",
                },
                "type": "boolean",
                "name": "is_manually_flagged",
              },
              {
                "control_type": "text",
                "label": "Is physical bill submitted",
                "render_input": {},
                "parse_output": {},
                "toggle_hint": "Select from option list",
                "toggle_field": {
                  "label": "Is physical bill submitted",
                  "control_type": "text",
                  "toggle_hint": "Use custom value",
                  "type": "boolean",
                  "name": "is_physical_bill_submitted",
                },
                "type": "boolean",
                "name": "is_physical_bill_submitted",
              },
              {
                "control_type": "text",
                "label": "Is policy flagged",
                "render_input": {},
                "parse_output": {},
                "toggle_hint": "Select from option list",
                "toggle_field": {
                  "label": "Is policy flagged",
                  "control_type": "text",
                  "toggle_hint": "Use custom value",
                  "type": "boolean",
                  "name": "is_policy_flagged",
                },
                "type": "boolean",
                "name": "is_policy_flagged",
              },
              {
                "control_type": "text",
                "label": "Is verified",
                "render_input": {},
                "parse_output": {},
                "toggle_hint": "Select from option list",
                "toggle_field": {
                  "label": "Is verified",
                  "control_type": "text",
                  "toggle_hint": "Use custom value",
                  "type": "boolean",
                  "name": "is_verified",
                },
                "type": "boolean",
                "name": "is_verified",
              },
              {
                "control_type": "text",
                "label": "Last approved at",
                "render_input": "date_time_conversion",
                "parse_output": "date_time_conversion",
                "type": "date_time",
                "name": "last_approved_at",
              },
              {
                "control_type": "text",
                "label": "Last paid at",
                "type": "string",
                "name": "last_paid_at",
              },
              {
                "control_type": "text",
                "label": "Last submitted at",
                "render_input": "date_time_conversion",
                "parse_output": "date_time_conversion",
                "type": "date_time",
                "name": "last_submitted_at",
              },
              {
                "control_type": "number",
                "label": "Num expenses",
                "parse_output": "float_conversion",
                "type": "number",
                "name": "num_expenses",
              },
              {
                "control_type": "text",
                "label": "Org ID",
                "type": "string",
                "name": "org_id",
              },
              {
                "control_type": "text",
                "label": "Physical bill submitted at",
                "type": "string",
                "name": "physical_bill_submitted_at",
              },
              {
                "control_type": "text",
                "label": "Purpose",
                "type": "string",
                "name": "purpose",
              },
              {
                "control_type": "text",
                "label": "Seq num",
                "type": "string",
                "name": "seq_num",
              },
              {
                "control_type": "text",
                "label": "Settlement ID",
                "type": "string",
                "name": "settlement_id",
              },
              {
                "control_type": "text",
                "label": "Source",
                "type": "string",
                "name": "source",
              },
              {
                "control_type": "text",
                "label": "State",
                "type": "string",
                "name": "state",
              },
              {
                "control_type": "number",
                "label": "Tax",
                "parse_output": "float_conversion",
                "type": "number",
                "name": "tax",
              },
              {
                "control_type": "text",
                "label": "Updated at",
                "render_input": "date_time_conversion",
                "parse_output": "date_time_conversion",
                "type": "date_time",
                "name": "updated_at",
              },
              {
                "label": "User",
                "type": "object",
                "name": "user",
                "properties": [
                  {
                    "control_type": "text",
                    "label": "Email",
                    "type": "string",
                    "name": "email",
                  },
                  {
                    "control_type": "text",
                    "label": "Full name",
                    "type": "string",
                    "name": "full_name",
                  },
                  {
                    "control_type": "text",
                    "label": "ID",
                    "type": "string",
                    "name": "id",
                  },
                ],
              },
              {
                "control_type": "text",
                "label": "User ID",
                "type": "string",
                "name": "user_id",
              },
            ],
          },
        ]
      end,
    },
  },

  actions: {

    #GET API's
    get_list_of_categories: {

      execute: lambda do |connection|
        categories = get("#{connection["base_uri"]}/platform/v1beta/admin/categories")
      end,
      output_fields: lambda do |object_definitions|
        [
          {
            name: "data",
            label: "Categories",
            type: :array,
            of: :object,
            properties: object_definitions["category"],
          },
        ]
      end,
    },

    get_list_of_system_categories: {
      execute: lambda do |connection, input|
        categories = get("#{connection["base_uri"]}/platform/v1beta/admin/categories/system_categories")
      end,
      output_fields: lambda do |object_definitions|
        [
          {
            name: "data",
            label: "System Categories",
            type: "array",
            of: "object",
            properties: object_definitions["system_category"],
          },
        ]
      end,
    },

    get_list_of_projects: {
      execute: lambda do |connection, input|
        categories = get("#{connection["base_uri"]}/platform/v1beta/admin/projects")
      end,
      output_fields: lambda do |object_definitions|
        [
          {
            name: "data",
            label: "Projects",
            type: :array,
            of: :object,
            properties: object_definitions["project"],
          },
        ]
      end,
    },

    get_list_of_expenses: {
      input_fields: lambda do
        [
          {
            name: "state",
            type: :string,
            optional: false,
          },
          {
            name: "order",
            type: :string,
            optional: false,
          },
          {
            name: "updated_at",
            type: :string,
            optional: false,
          },
          {
            name: "exported",
            type: :string,
            optional: false,
          },
        ]
      end,

      execute: lambda do |connection, input_fields|
        expenses = call(:paginated_get_all, input_fields)

        expenses
      end,
      output_fields: lambda do |object_definitions|
        [
          {
            name: "data",
            label: "Expenses",
            type: :array,
            of: :object,
            properties: object_definitions["expense"],
          },
        ]
      end,
    },

    get_list_of_cost_centers: {
      execute: lambda do |connection, input|
        categories = get("#{connection["base_uri"]}/platform/v1beta/admin/cost_centers")
      end,
      output_fields: lambda do |object_definitions|
        [
          {
            name: "data",
            label: "Cost Centers",
            type: :array,
            of: :object,
            properties: object_definitions["cost_center"],
          },
        ]
      end,
    },

    get_list_of_expense_report: {
      input_fields: lambda do
        [
          {
            name: "state",
            type: :string,
            optional: false,
          },
          {
            name: "order",
            type: :string,
            optional: false,
          },
          {
            name: "updated_at",
            type: :string,
            optional: false,
          },
          {
            name: "exported",
            type: :string,
            optional: false,
          },
        ]
      end,
      execute: lambda do |connection, input_fields|
        results = []
        query_params = {
          order: input_fields["order"],
          state: input_fields["state"],
          is_exported: input_fields["exported"],
        }
        expense_reports = get("#{connection["base_uri"]}/platform/v1beta/admin/reports").params(
          query_params
        )
        { data: expense_reports["data"] }
      end,
      output_fields: lambda do |object_definitions|
        [
          {
            name: "data",
            label: "Expenses",
            type: :array,
            of: :object,
            properties: object_definitions["expense"],
          },
        ]
      end,
    },

    get_list_of_expense_by_report_id: {
      input_fields: lambda do
        [
          {
            name: "report_id",
            type: :string,
            optional: false,
          },
        ]
      end,

      execute: lambda do |connection, input_fields|
        query_params = {
          report_id: input_fields["report_id"],
        }

        response = get("#{connection["base_uri"]}/platform/v1beta/admin/expenses").params(
          query_params
        )

        flattened_expenses = call(:flatten_expenses, response["data"])

        flattened_expenses
      end,
      output_fields: lambda do |object_definitions|
        [
          {
            name: "data",
            label: "Expenses",
            type: :array,
            of: :object,
            properties: object_definitions["expense"],
          },
        ]
      end,
    },

    get_list_of_corporate_cards: {
      execute: lambda do |connection, input|
        categories = get("#{connection["base_uri"]}/platform/v1beta/admin/corporate_cards")
      end,
      output_fields: lambda do |object_definitions|
        [
          {
            name: "data",
            label: "Corporate Cards",
            type: :array,
            of: :object,
            properties: object_definitions["corporate_card"],
          },
        ]
      end,
    },

    get_list_of_expense_fields: {
      execute: lambda do |connection, input|
        query_params = {
          'is_enabled': "eq.true",
        }
        expense_fields = get("#{connection["base_uri"]}/platform/v1beta/admin/expense_fields").params(
          query_params
        )
      end,
      output_fields: lambda do |object_definitions|
        [
          {
            name: "data",
            label: "Expense Field",
            type: :array,
            of: :object,
            properties: object_definitions["category"],
          },
        ]
      end,
    },

    get_list_of_tax_groups: {
      execute: lambda do |connection, input|
        query_params = {
          'is_enabled': "eq.true",
        }
        tax_groups = get("#{connection["base_uri"]}/platform/v1beta/admin/tax_groups").params(
          query_params
        )
      end,
      output_fields: lambda do |object_definitions|
        [
          {
            name: "data",
            label: "Expense Field",
            type: :array,
            of: :object,
            properties: object_definitions["category"],
          },
        ]
      end,
    },

    get_list_of_reimbursement: {
      execute: lambda do |connection, input|
        reimbursements = get("#{connection["base_uri"]}/platform/v1beta/admin/reimbursements")
      end,
      output_fields: lambda do |object_definitions|
        [
          {
            name: "data",
            label: "Expense Field",
            type: "array",
            of: "object",
            properties: object_definitions["category"],
          },
        ]
      end,
    },

    get_list_of_employees: {
      execute: lambda do |connection, input|
        query_params = {
          'is_enabled': "eq.true",
        }
        tax_groups = get("#{connection["base_uri"]}/platform/v1beta/admin/employees").params(
          query_params
        )
      end,
      output_fields: lambda do |object_definitions|
        [
          {
            name: "data",
            label: "Employees",
            type: :array,
            of: :object,
            properties: object_definitions["employees"],
          },
        ]
      end,
    },

    search_employee: {
      input_fields: lambda do
        [
          {
            name: "email",
            type: :string,
            optional: false,
          },
        ]
      end,

      execute: lambda do |connection, input_fields|
        query_params = {
          "user->email": input_fields["email"],
        }

        employee = get("#{connection["base_uri"]}/platform/v1beta/admin/employees").params(
          query_params
        )
      end,
      output_fields: lambda do |object_definitions|
        [
          {
            name: "data",
            label: "Employees",
            type: :array,
            of: :object,
            properties: object_definitions["employees"],
          },
        ]
      end,
    },

    get_departments: {
      execute: lambda do |connection, input|
        categories = get("#{connection["base_uri"]}/platform/v1beta/admin/departments")
      end,
      output_fields: lambda do |object_definitions|
        [
          {
            name: "data",
            label: "Department",
            type: :array,
            of: :object,
            properties: object_definitions["department"],
          },
        ]
      end,
    },

    # POST API's
    upload_to_fyle: {

      input_fields: lambda do
        [
          {
            "name": "limeitem_data",
            "type": "array",
            "of": "object",
            "label": "Rows",
            "properties": [
              {
                "control_type": "text",
                "label": "Object ID",
                "type": "string",
                "name": "object_id",
              },
              {
                "control_type": "text",
                "label": "Object type",
                "type": "string",
                "name": "object_type",
              },
              {
                "control_type": "text",
                "label": "Reference",
                "type": "string",
                "name": "reference",
              },
            ],
          },
        ]
      end,

      execute: lambda do |connection, input_fields|
        user_profile = call(:get_user_profile)
        file_payload = {
          "data": {
            "name": "Test Fyle Name",
            "type": "INTEGRATION",
            "password": nil,
            "user_id": user_profile["id"],
          },
        }

        type = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"

        file_obj = post("#{connection["base_uri"]}/platform/v1beta/admin/files", file_payload)

        file_id = file_obj["data"]["id"]

        accounting_exports_payload = {
          "data": {
            "file_ids": [
              file_id,
            ],
            "exported_at": Time.now(),
            "description": "TST Foundation CSV Export - 2",
            "name": "TST Foundation CSV Export",
          },
        }
        accounting_export = post("#{connection["base_uri"]}/platformv1beta/admin/accounting_exports", accounting_exports_payload)
        accounting_export_id = accounting_export["data"]["id"]

        if input_fields["limeitem_data"]
          input_fields["limeitem_data"].each_with_object({}) do |element, hash|
            element[:accounting_export_id] = accounting_export_id
          end

          accounting_export_line_items_payload = {
            "data": input_fields["limeitem_data"],
          }

          accounting_export_lineitems = post("#{connection["base_uri"]}/platform/v1beta/admin/accounting_export_lineitems/bulk", accounting_export_line_items_payload)
          accounting_export_lineitems
        end
      end,
      output_fields: lambda do |object_definitions|
        [
          {
            name: "data",
            label: "Expenses",
            type: "array",
            of: "object",
            properties: object_definitions["user"],
          },
        ]
      end,
    },
    upload_categories_to_fyle: {
      input_fields: lambda do
        [
          {
            name: "name",
            type: :string,
            optional: false,
          },
          {
            name: "code",
            type: :string,
            optional: false,
          },
        ]
      end,
      execute: lambda do |connection, input_fields|
        payload = {
          "data": {
            'name': input_fields["name"],
            'code': input_fields["code"],
            'is_enabled': true,
            'restricted_project_ids': [],
          },
        }
        categories = post("#{connection["base_uri"]}/platform/v1beta/admin/categories", payload)
      end,
    },
    get_departments_payload: {
      input_fields: lambda do
        [
          {
            "name": "limeitem_data",
            "type": "array",
            "of": "object",
            "label": "Rows",
            "properties": [
              {
                "control_type": "text",
                "label": "Department Name",
                "type": "string",
                "name": "department_name",
              },
            ],
          },
        ]
      end,

      execute: lambda do |connection, input_fields|
        fyle_departments = call(:get_department_list, input_fields[:limeitem_data], connection)

        fyle_departments
      end,

      output_fields: lambda do |object_definitions|
        [
          {
            "name": "data",
            "type": "array",
            "of": "string",
            "control_type": "text",
            "label": "Data",
          },
        ]
      end,
    },
    create_employees_in_fyle: {
      input_fields: lambda do
        [
          {
            "name": "data",
            "type": "array",
            "of": "object",
            "label": "Rows",
            "properties": [
              {
                "control_type": "text",
                "label": "Name",
                "name": "user_full_name",
                "type": "string",
                "optional": false,
              },
              {
                "control_type": "text",
                "label": "Email",
                "name": "user_email",
                "type": "string",
                "optional": false,
              },
              {
                "name": "title",
                "type": "string",
                "optional": false,
                "control_type": "text",
              },
              {
                "name": "location",
                "type": "string",
                "optional": false,
                "control_type": "text",
              },
              {
                "name": "department_name",
                "type": "string",
                "optional": true,
                "control_type": "text",
              },
              {
                "name": "mobile",
                "type": "string",
                "optional": true,
                "control_type": "text",
              },
              {
                "name": "is_enabled",
                "type": "boolean",
                "optional": true,
                "control_type": "boolean",
              },
              {
                "name": "approver_emails",
                "type": "array",
                "of": "string",
                "label": "Approver emails",
              },
            ],
          },
        ]
      end,
      execute: lambda do |connection, input_fields|
        payload = {
          "data": input_fields["data"],
        }
        employee = post("#{connection["base_uri"]}/platform/v1beta/admin/employees/invite/bulk", payload).
          after_error_response(400) do |code, body, header, message|
          error("#{message}: #{body}")
        end
      end,
    },
    upload_department_to_fyle: {
      input_fields: lambda do
        [
          {
            name: "name",
            type: "string",
            optional: false,
          },
        ]
      end,
      execute: lambda do |connection, input_fields|
        payload = {
          "data": {
            'name': input_fields["name"],
            'is_enabled': true,
          },
        }
        departments = post("#{connection["base_uri"]}/platform/v1beta/admin/departments", payload)
      end,
    },
    post_expenses: {
      input_fields: lambda do
        [
          {
            "name": "data",
            "type": "array",
            "of": "object",
            "label": "Rows",
            "properties": [
              {
                "control_type": "text",
                "label": "Spent at",
                "render_input": "date_time_conversion",
                "parse_output": "date_time_conversion",
                "type": "date_time",
                "name": "spent_at",
                "optional": false,
              },
              {
                "control_type": "text",
                "label": "Purpose",
                "name": "purpose",
                "type": "string",
                "optional": false,
              },
              {
                "control_type": "text",
                "label": "Is Reimbursable",
                "name": "is_reimbursable",
                "type": "boolean",
                "optional": false,
              },
              {
                "control_type": "text",
                "label": "Currency",
                "name": "currency",
                "type": "string",
                "optional": false,
              },
              {
                "name": "claim_amount",
                "parse_output": "float_conversion",
                "type": "number",
                "optional": false,
                "control_type": "text",
              },
              {
                "control_type": "text",
                "label": "Merchant",
                "type": "string",
                "name": "merchant",
                "optional": false,
              },
              {
                "control_type": "text",
                "label": "Category Id",
                "type": "string",
                "name": "category_id",
                "optional": false,
              },
              {
                "control_type": "text",
                "label": "Source",
                "type": "string",
                "name": "source",
                "optional": false,
              },
            ],
          },
        ]
      end,
      execute: lambda do |connection, input_fields|
        payload = {
          "data": input_fields["data"][0],
        }
        category_map = { "flight" => "Airlines", "car" => "Taxi", "train" => "Train", "hotel" => "Lodging" }

        if category_map[input_fields["data"][0]["category_id"]]
          category_id = call(:get_category_id, connection, category_map[input_fields["data"][0]["category_id"]])
          if category_id
            payload[:data]["category_id"] = category_id
          else
            payload[:data].delete("category_id")
          end
        else
          payload[:data].delete("category_id")
        end
        post("#{connection["base_uri"]}/platform/v1beta/spender/expenses", payload)
      end,
      output_fields: lambda do |object_definitions|
        [
          {
            name: "data",
            label: "Data",
            type: "array",
            of: "object",
            properties: object_definitions["expense"],
          },
        ]
      end,
    },
    post_file: {
      input_fields: lambda do
        [
          {
            "name": "data",
            "type": "array",
            "of": "object",
            "label": "Rows",
            "properties": [
              {
                "control_type": "text",
                "label": "Name",
                "name": "name",
                "type": "string",
                "optional": false,
              },
              {
                "control_type": "text",
                "label": "Type",
                "name": "type",
                "type": "string",
                "optional": false,
              },
            ],
          },
        ]
      end,
      execute: lambda do |connection, input_fields|
        payload = {
          "data": input_fields["data"][0],
        }
        post("#{connection["base_uri"]}/platform/v1/spender/files", payload)
      end,
      output_fields: lambda do |object_definitions|
        [
          {
            name: "data",
            label: "Data",
            type: :array,
            of: :object,
            properties: object_definitions["files"],
          },
        ]
      end,
    },
    generate_upload_url: {
      input_fields: lambda do
        [
          {
            "name": "data",
            "type": "array",
            "of": "object",
            "label": "Rows",
            "properties": [
              {
                "control_type": "text",
                "label": "id",
                "name": "id",
                "type": "string",
                "optional": false,
              },
            ],
          },
        ]
      end,
      execute: lambda do |connection, input_fields|
        payload = {
          "data": input_fields["data"][0],
        }
        post("#{connection["base_uri"]}/platform/v1/spender/files/generate_urls", payload)
      end,
      output_fields: lambda do |object_definitions|
        [
          {
            name: "data",
            label: "Data",
            type: :array,
            of: :object,
            properties: object_definitions["file_upload_url"],
          },
        ]
      end,
    },
    attach_receipt_to_expense: {
      input_fields: lambda do
        [
          {
            "name": "data",
            "type": "array",
            "of": "object",
            "label": "Rows",
            "properties": [
              {
                "control_type": "text",
                "label": "id",
                "name": "id",
                "type": "string",
                "optional": false,
              },
              {
                "control_type": "text",
                "label": "file_id",
                "name": "file_id",
                "type": "string",
                "optional": false,
              },
            ],
          },
        ]
      end,
      execute: lambda do |connection, input_fields|
        payload = {
          "data": input_fields["data"][0],
        }
        post("#{connection["base_uri"]}/platform/v1/spender/expenses/attach_receipt", payload)
      end,
    },
  },

  triggers: {
    new_updated_cost_center: {
      title: "New/Updated Cost Center",

      subtitle: "Triggers when a Cost Center is created or " \
      "updated in Fyle",

      description: lambda do |input, picklist_label|
        "New/updated <span class='provider'>Cost Center</span> " \
        "in <span class='provider'>Fyle</span>"
      end,

      help: "Creates a job when cost centers are created or " \
      "updated in Fyle. Each cost center creates a separate job.",

      input_fields: lambda do |object_definitions|
        [
          {
            name: "since",
            label: "When first started, this recipe should pick up events from",
            type: "timestamp",
            optional: true,
            sticky: true,
            hint: "When you start recipe for the first time, it picks up " \
            "trigger events from this specified date and time. Defaults to " \
            "the current time.",
          },
        ]
      end,

      poll: lambda do |connection, input, closure, _eis, _eos|
        closure = {} unless closure.present?
        limit = 100

        updated_since = (closure["cursor"] || input["since"] || Time.now).to_time.utc.iso8601

        cost_center = get("#{connection["base_uri"]}/platform/v1beta/admin/cost_centers").
          params(
          'order': "updated_at.asc",
        )

        closure["cursor"] = cost_center["data"].last["updated_at"] unless cost_center.blank?

        {
          events: cost_center,
          next_poll: closure,
          can_poll_more: false,
        }
      end,

      dedup: lambda do |record|
        "#{record["data"].last["id"]}@#{record["data"].last["created_at"]}"
      end,
      output_fields: lambda do |object_definitions|
        [
          {
            name: "data",
            label: "Cost Centers",
            type: :array,
            of: :object,
            properties: object_definitions["cost_center"],
          },
        ]
      end,
    },
    new_expenses: {
      title: "New/Updated Expense",

      subtitle: "Triggers when a expense is created or " \
      "updated in Fyle",

      description: lambda do |input, picklist_label|
        "New <span class='provider'>Expense</span> " \
        "in <span class='provider'>Fyle</span>"
      end,

      help: "Creates a job when Expense are created " \
      "in Fyle. Each expense creates a separate job.",

      input_fields: lambda do
        [
          {
            name: "since",
            label: "When first started, this recipe should pick up events from",
            type: "timestamp",
            optional: true,
            sticky: true,
            hint: "When you start recipe for the first time, it picks up " \
            "trigger events from this specified date and time. Defaults to " \
            "the current time.",
          },
          {
            name: "state",
            type: :string,
            optional: false,
          },
          {
            name: "order",
            type: :string,
            optional: false,
          },
          {
            name: "updated_at",
            type: :string,
            optional: false,
          },
          {
            name: "exported",
            type: :string,
            optional: false,
          },
        ]
      end,

      poll: lambda do |connection, input, closure, _eis, _eos|
        closure = {} unless closure.present?
        limit = 100

        updated_since = (closure["cursor"] || input["since"] || Time.now).to_time.utc.iso8601

        expenses = get("#{connection["base_uri"]}/platform/v1beta/admin/expenses").
          params(
          'state': "eq.PAYMENT_PROCESSING",
          'order': "updated_at.asc",
        )

        closure["cursor"] = expenses["data"].last["updated_at"] unless expenses.blank?

        {
          events: expenses,
          next_poll: closure,
          can_poll_more: false,
        }
      end,

      dedup: lambda do |record|
        "#{record["data"].last["id"]}@#{record["data"].last["created_at"]}"
      end,
      output_fields: lambda do |object_definitions|
        [
          {
            name: "data",
            label: "Expense",
            type: :array,
            of: :object,
            properties: object_definitions["expense"],
          },
        ]
      end,
    },
  },

  pick_lists: {},
  # Reusable methods can be called from object_definitions, picklists or actions
  # See more at https://docs.workato.com/developing-connectors/sdk/sdk-reference/methods.html
  methods: {

    get_category_id: lambda do |connection, category_name|
      category_id = get("#{connection["base_uri"]}/platform/v1beta/admin/categories").params(
        'limit': 1,
        'order': "updated_at.asc",
        'system_category': "eq.#{category_name}",
        'is_enabled': "eq.True",
      )

      if category_id["count"] > 0
        category_id["data"][0]["id"]
      else
        nil
      end
    end,

    get_department_list: lambda do |input, connection|
      dept_list = []
      existing_fyle_departments = []
      fyle_departments = get("#{connection["base_uri"]}/platform/v1beta/admin/departments")["data"]
      fyle_departments.each { |dept|
        existing_fyle_departments.push(dept["display_name"])
      }

      input.each { |department|
        if not existing_fyle_departments.include?(department["department_name"])
          if not dept_list.include?(department["department_name"]) and department["department_name"] != ""
            dept_list.push(department["department_name"])
          end
        end
      }
      {
        data: dept_list,
      }
    end,

    flatten_expenses: lambda do |input|
      flattened_expenses = []

      cluster_domain = post("https://accounts.fyle.tech/oauth/cluster")["cluster_domain"]

      input.each { |expense|
        flattened_expenses.push({
          id: expense["id"],
          user_id: expense["user_id"],
          user_email: expense["user"]["email"],
          user_full_name: expense["user"]["full_name"],
          org_id: expense["org_id"],
          created_at: expense["created_at"],
          updated_at: expense["updated_at"],
          spent_at: expense["spent_at"],
          source: expense["source"],
          merchant_id: expense["merchant_id"],
          currency_code: expense["currency_code"],
          amount: expense["amount"],
          foreign_currency: expense["foreign_currency"],
          foreign_amount: expense["foreign_amount"],
          purpose: expense["purpose"],
          cost_center_id: expense["cost_center_id"],
          cost_center_name: expense["cost_center"] ? expense["cost_center"]["name"] : nil,
          cost_center_code: expense["cost_center"] ? expense["cost_center"]["code"] : nil,
          category_id: expense["category_id"],
          category_name: expense["category"] ? expense["category"]["name"] : nil,
          sub_category: expense["category"] ? expense["category"]["sub_category"] : nil,
          category_code: expense["category"] ? expense["category"]["code"] : nil,
          project_id: expense["project_id"],
          project_name: expense["project"] ? expense["project"]["name"] : nil,
          project_code: expense["project"] ? expense["project"]["code"] : nil,
          sub_project: expense["project"] ? expense["project"]["sub_project"] : nil,
          source_account_id: expense["source_account_id"],
          source_account_type: expense["source_account"] ? expense["source_account"]["type"] : nil,
          tax_amount: expense["tax_amount"],
          tax_group_id: expense["tax_group_id"],
          is_billable: expense["is_billable"],
          is_reimbursable: expense["is_reimbursable"],
          state: expense["state"],
          seq_num: expense["seq_num"],
          added_to_report_at: expense["added_to_report_at"],
          report_id: expense["report_id"],
          report_last_approved_at: expense["report"] ? expense["report"]["last_approved_at"] : nil,
          report_last_submitted_at: expense["report"] ? expense["report"]["last_submitted_at"] : nil,
          report_number: expense["report"] ? expense["report"]["seq_num"] : nil,
          report_title: expense["report"] ? expense["report"]["title"] : nil,
          report_state: expense["report"] ? expense["report"]["state"] : nil,
          settlement_id: expense["report"] ? expense["report"]["settlement_id"] : nil,
          report_last_paid_at: expense["report"] ? expense["report"]["last_paid_at"] : nil,
          is_verified: expense["is_verified"],
          last_verified_at: expense["last_verified_at"],
          is_exported: expense["is_exported"],
          last_exported_at: expense["last_exported_at"],
          employee_id: expense["employee_id"],
          employee_code: expense["employee"]["code"],
          employee_department_id: expense["employee"]["department"] ? expense["employee"]["department"]["id"] : nil,
          employee_department_code: expense["employee"]["department"] ? expense["employee"]["department"]["code"] : nil,
          employee_department_name: expense["employee"]["department"] ? expense["employee"]["department"]["name"] : nil,
          employee_sub_department_name: expense["employee"]["department"] ? expense["employee"]["department"]["sub_department"] : nil,
          is_corporate_card_transaction_auto_matched: expense["is_corporate_card_transaction_auto_matched"],
          corporate_card_id: expense["matched_corporate_card_transactions"][0] ? expense["matched_corporate_card_transactions"][0]["corporate_card_id"] : nil,
          corporate_card_number: expense["matched_corporate_card_transactions"][0] ? expense["matched_corporate_card_transactions"][0]["corporate_card_number"] : nil,
          last_settled_at: expense["last_settled_at"],
          cluster_domain: cluster_domain,
        })
      }
      {
        data: flattened_expenses,
      }
    end,

    get_user_profile: lambda do |connection|
      user_profile = get("#{connection["base_uri"]}/platform/v1beta/spender/my_profile")["data"]["user"]

      user_profile
    end,

    paginated_get_all: lambda do |input, connection|
      count = 1
      total_count = 0
      results = []

      query_params = {
        order: input["order"],
        state: input["state"],
        is_exported: input["exported"],
      }

      while total_count < count
        response = get("#{connection["base_uri"]}/platform/v1beta/admin/expenses").params(
          query_params
        )

        data_size = response["data"].length()
        total_count = total_count + data_size
        count = response["count"]

        query_params = {
          order: input["order"],
          state: input["state"],
          'offset': total_count,
          'limit': data_size,
        }

        results = results + response["data"]
      end
      flattened_expenses = call(:flatten_expenses, results)

      flattened_expenses
    end,
  },
}
