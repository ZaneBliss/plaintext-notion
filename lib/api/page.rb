# frozen_string_literal: true

require 'json'

require_relative './block'

module Api
  # Representation of a Page api resource
  class Page
    def initialize(node)
      @node = node
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
          title: { title: [{ type: :text, text: { content: @node.pretty_name } }] }
        }
      }
    end

    def children
      # Idea: a Line class could contain #to_ methods to create different kinds
      # of lines
      to_block = ->(line) { Block.new(line) }
      {
        children: @node.lines.map(&to_block)
      }
    end
  end
end
