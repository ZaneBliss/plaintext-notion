# frozen_string_literal: true

require 'json'

module Api
  # Representation of a Page api resource
  class Page
    def initialize(node)
      @pretty_name = node.pretty_name
      @lines = node.lines
    end

    def to_json(*_args)
      {}.merge(parent, properties, children).to_json
    end

    private

    def parent
      {
        parent: {
          page_id: '2aadcb4694944f19bc0dc673f6abbf4b'
        }
      }
    end

    def properties
      {
        properties: {
          title: {
            title: [
              type: 'text',
              text: {
                content: @pretty_name
              }
            ]
          }
        }
      }
    end

    def children
      {
        children: [
          {
            object: 'block',
            type: 'paragraph',
            paragraph: {
              rich_text: [
                {
                  type: 'text',
                  text: {
                    content: @lines
                  }
                }
              ]
            }
          }
        ]
      }
    end
  end
end
