json.extract! user, :id, :email, :age, :created_at, :updated_at
json.company do
  json.partial! 'v1/companies/company', company: user.company
end
json.token do
  json.partial! 'v1/tokens/token', token: @token
end
