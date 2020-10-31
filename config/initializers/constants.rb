# frozen_string_literal: true

if Rails.env.production?
  AUTH_APP_URL = 'http://customer-omniapp.herokuapp.com/api/v1'
else
  AUTH_APP_URL = 'http://localhost:3000/api/v1'
end
