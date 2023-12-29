# frozen_string_literal: true

require 'json'

module Api
  # Respresentation of a Block api resource
  class Block
    attr_reader :hash

    def initialize(line)
      prefix, content = to_prefix_content_array(line)

      @type = infer_type(prefix)
      @content = content.delete("\n")
      @hash = build_hash
    end

    private

    def build_hash
      @hash = {
        object: :block,
        type: @type,
        @type => {
          rich_text: [{ type: :text, text: { content: @content } }]
        }
      }
    end

    def to_prefix_content_array(line)
      prefix, content = line.split(' ', 2)

      return [nil, line] if infer_type(prefix) == :paragraph

      [prefix, content]
    end

    def infer_type(prefix) # rubocop:disable Metrics/MethodLength, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
      if prefix == ('#')
        :heading_1
      elsif prefix == ('##')
        :heading_2
      elsif prefix == ('###')
        :heading_3
      elsif prefix == ('-[]')
        :to_do
      elsif prefix == ('1.')
        :numbered_list_item
      elsif prefix == ('-')
        :bulleted_list_item
      elsif prefix == ('>')
        :quote
      else
        :paragraph
      end
    end
  end
end
