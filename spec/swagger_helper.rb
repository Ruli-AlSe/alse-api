# frozen_string_literal: true

require 'rails_helper'

RSpec.configure do |config|
  # Specify a root folder where Swagger JSON files are generated
  # NOTE: If you're using the rswag-api to serve API descriptions, you'll need
  # to ensure that it's configured to serve Swagger from the same folder
  config.openapi_root = Rails.root.join('swagger').to_s

  # Define one or more Swagger documents and provide global metadata for each one
  # When you run the 'rswag:specs:swaggerize' rake task, the complete Swagger will
  # be generated at the provided relative path under openapi_root
  # By default, the operations defined in spec files are added to the first
  # document below. You can override this behavior by adding a openapi_spec tag to the
  # the root example_group in your specs, e.g. describe '...', openapi_spec: 'v2/swagger.json'
  config.openapi_specs = {
    'v1/swagger.yaml' => {
      openapi: '3.0.1',
      info: {
        title: 'API V1',
        version: 'v1'
      },
      paths: {},
      components: {
        securitySchemes: {
          # tokens
          Bearer: {
            description: 'Bearer token of the logged user to access the API ressources',
            type: :apiKey,
            in: :header,
            name: :Authorization
          }
        },
        schemas: {
          # models
          user: {
            type: 'object',
            properties: {
              email: { type: 'string', required: true },
              password: { type: 'string', required: true },
              age: { type: 'integer', required: true },
              store_attributes: {
                type: 'object',
                properties: {
                  name: { type: 'string', required: true }
                }
              }
            },
            example: {
              user: {
                email: 'test@example.com',
                password: '12345678',
                age: 31,
                store_attributes: {
                  name: 'test'
                }
              }
            }
          },
          login_user: {
            type: 'object',
            properties: {
              email: { type: 'string', required: true },
              password: { type: 'string', required: true }
            },
            example: {
              user: {
                email: 'test@example.com',
                password: '12345678'
              }
            }
          },
          product_id: {
            type: 'integer',
            required: true,
            example: 1
          },
          product: {
            type: 'object',
            properties: {
              name: { type: 'string', required: true },
              description: { type: 'string', required: true },
              price: { type: 'number', required: true }
            },
            example: {
              product: {
                name: 'test',
                description: 'product description',
                price: 50.0
              }
            }
          }
        }
      },
      servers: [
        {
          url: '{defaultHost}',
          variables: {
            defaultHost: {
              default: ENV['HOST'] || 'http://localhost:3000'
            }
          }
        }
      ]
    }
  }

  # Specify the format of the output Swagger file when running 'rswag:specs:swaggerize'.
  # The openapi_specs configuration option has the filename including format in
  # the key, this may want to be changed to avoid putting yaml in json files.
  # Defaults to json. Accepts ':json' and ':yaml'.
  config.openapi_format = :yaml
end
