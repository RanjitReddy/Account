class BankAccount < ApplicationRecord
  ACCTYPE = %w( Current Savings ).freeze
  validates :account_type, :open_date, :customer_id, presence: true
end
