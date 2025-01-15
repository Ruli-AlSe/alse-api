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
              company_attributes: {
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
                company_attributes: {
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
                email: 'raul@example.com',
                password: '123abc'
              }
            }
          },
          post_id: {
            type: 'integer',
            required: true,
            example: 1
          },
          profile_id: {
            type: 'integer',
            required: true,
            example: 1
          },
          category_id: {
            type: 'integer',
            required: true,
            example: 1
          },
          post: {
            type: 'object',
            properties: {
              title: { type: 'string', required: true },
              content: { type: 'string', required: true },
              image_url: { type: 'string', required: true },
              credits: { type: 'string', required: false }
            },
            example: {
              post: {
                title: 'test',
                content: 'post description',
                image_url: 'image.url.com',
                credits: '(page.link,page name,user name)'
              }
            }
          },
          category: {
            type: 'object',
            properties: {
              title: { type: 'string', required: true },
              description: { type: 'string', required: true },
              slug: { type: 'string', required: true, unique: true }
            },
            example: {
              title: 'Category title',
              description: 'Category description',
              slug: 'category-title'
            }
          },
          profile: {
            type: 'object',
            properties: {
              name: { type: 'string', required: false },
              last_name: { type: 'string', required: false },
              headliner: { type: 'string', required: false },
              bio: { type: 'text', required: false },
              city: { type: 'string', required: false },
              state: { type: 'string', required: false },
              country: { type: 'string', required: false },
              phone_number: { type: 'string', required: false },
              social_media: { type: 'string', required: false },
            },
            example: {
              profile: {
                name: 'user name updated',
                last_name: 'user last name updated',
                headliner: 'user headliner updated',
                bio: 'user bio updated',
                city: 'city updated',
                state: 'state updated',
                country: 'country updated',
                phone_number: 'phone number updated',
                social_media: 'linkedin.com,facebook.com,instagram.com,github.com,whatsapp.com,x.com',
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
