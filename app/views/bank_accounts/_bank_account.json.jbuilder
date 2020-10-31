json.extract! bank_account, :id, :account_type, :open_date, :customer_id, :customer_name, :branch, :minor_indicator, :created_at, :updated_at
json.url bank_account_url(bank_account, format: :json)
