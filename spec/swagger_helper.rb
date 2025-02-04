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
          post_email: {
            type: 'string',
            required: true,
            example: 'raul@example.com'
          },
          profile_id: {
            type: 'integer',
            required: true,
            example: 1
          },
          profile_email: {
            type: 'string',
            required: true,
            example: 'raul@example.com'
          },
          category_id: {
            type: 'integer',
            required: true,
            example: 1
          },
          category_email: {
            type: 'string',
            required: true,
            example: 'raul@example.com'
          },
          skill_id: {
            type: 'integer',
            required: true,
            example: 1
          },
          education_id: {
            type: 'integer',
            required: true,
            example: 1
          },
          job_id: {
            type: 'integer',
            required: true,
            example: 1
          },
          project_id: {
            type: 'integer',
            required: true,
            example: 1
          },
          project_email: {
            type: 'string',
            required: true,
            example: 'raul@example.com'
          },
          post: {
            type: 'object',
            properties: {
              title: { type: 'string', required: true },
              content: { type: 'string', required: true },
              image_url: { type: 'string', required: true },
              slug: { type: 'string', required: true },
              short_description: { type: 'string', required: true },
              credits: { type: 'string', required: false }
            },
            example: {
              post: {
                title: 'test',
                content: 'post description',
                image_url: 'image.url.com',
                slug: 'test-slug',
                short_description: 'short description',
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
          skill: {
            type: 'object',
            properties: {
              name: { type: 'string', required: true },
              icon_url: { type: 'string', required: false },
              level: { type: 'integer', required: false },
              category_id: { type: 'string', required: true }
            },
            example: {
              name: 'Skill name',
              icon_url: 'image.url.com/icon',
              level: 1,
              category_id: 9
            }
          },
          education: {
            type: 'object',
            properties: {
              school_name: { type: 'string', required: true },
              career: { type: 'string', required: true },
              start_date: { type: 'date', required: false },
              end_date: { type: 'date', required: false },
              location: { type: 'string', required: false },
              professional_license: { type: 'string', required: false },
              is_course: { type: 'string', required: false, default: false },
              relevant_topics: { type: 'string[]', required: false, default: [] }
            },
            example: {
              school_name: 'School name',
              career: 'Career name',
              start_date: '2015-11-21',
              end_date: '2019-06-15',
              location: 'University location',
              professional_license: 'sdfd-4354-34543-fgfdg',
              is_course: true,
              relevant_topics: ['web development', 'ux/ui design']
            }
          },
          job: {
            type: 'object',
            properties: {
              title: { type: 'string', required: true },
              location: { type: 'string', required: true },
              job_type: { type: 'integer', required: true },
              company_name: { type: 'string', required: true },
              start_date: { type: 'date', required: false },
              end_date: { type: 'date', required: false },
              activities: { type: 'string[]', required: false, default: [] }
            },
            example: {
              title: 'Job title',
              location: 'city, state, country',
              job_type: 2,
              company_name: 'Company name',
              start_date: '2015-11-21',
              end_date: '2020-11-21',
              activities: ['Design new web application', 'TDD pattern']
            }
          },
          project: {
            type: 'object',
            properties: {
              name: { type: 'string', required: true },
              description: { type: 'string', required: true },
              company_name: { type: 'integer', required: true },
              live_url: { type: 'string', required: false },
              repository_url: { type: 'string', required: true }
            },
            example: {
              name: 'project name',
              description: 'project large description',
              company_name: 'company name',
              live_url: 'www.link.url',
              repository_url: 'www.myrepo.com'
            }
          },
          profile: {
            type: 'object',
            properties: {
              name: { type: 'string', required: false },
              last_name: { type: 'string', required: false },
              headliner: { type: 'string', required: false },
              image_url: { type: 'string', required: false },
              about_me: { type: 'string', required: false },
              bio: { type: 'text', required: false },
              city: { type: 'string', required: false },
              state: { type: 'string', required: false },
              country: { type: 'string', required: false },
              phone_number: { type: 'string', required: false },
              social_media: { type: 'string', required: false }
            },
            example: {
              profile: {
                name: 'user name updated',
                last_name: 'user last name updated',
                image_url: 'https://avatars.githubusercontent.com/u/38964571?v=4',
                about_me: 'some information about me',
                headliner: 'user headliner updated',
                bio: 'user bio updated',
                city: 'city updated',
                state: 'state updated',
                country: 'country updated',
                phone_number: 'phone number updated',
                social_media: 'linkedin.com,facebook.com,instagram.com,github.com,whatsapp.com,x.com'
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
