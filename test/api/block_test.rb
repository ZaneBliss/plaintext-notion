# frozen_string_literal: true

require 'minitest/autorun'

require_relative '../../lib/api/block'

module Api
  class BlockTest < Minitest::Test
    def test_casting_block_types
      heading_1 = Block.new('# line')
      assert_equal heading_1.hash,
                   { object: :block, type: :heading_1,
                     heading_1: { rich_text: [{ type: :text, text: { content: 'line' } }] } }

      heading_2 = Block.new('## line')
      assert_equal heading_2.hash,
                   { object: :block, type: :heading_2,
                     heading_2: { rich_text: [{ type: :text, text: { content: 'line' } }] } }

      heading_3 = Block.new('### line')
      assert_equal heading_3.hash,
                   { object: :block, type: :heading_3,
                     heading_3: { rich_text: [{ type: :text, text: { content: 'line' } }] } }

      to_do = Block.new('-[] line')
      assert_equal to_do.hash,
                   { object: :block, type: :to_do,
                     to_do: { rich_text: [{ type: :text, text: { content: 'line' } }] } }

      numbered_list_item = Block.new('1. line')
      assert_equal numbered_list_item.hash,
                   { object: :block, type: :numbered_list_item,
                     numbered_list_item: { rich_text: [{ type: :text, text: { content: 'line' } }] } }

      bulleted_list_item = Block.new('- line')
      assert_equal bulleted_list_item.hash,
                   { object: :block, type: :bulleted_list_item,
                     bulleted_list_item: { rich_text: [{ type: :text, text: { content: 'line' } }] } }

      quote = Block.new('> line')
      assert_equal quote.hash,
                   { object: :block, type: :quote,
                     quote: { rich_text: [{ type: :text, text: { content: 'line' } }] } }

      paragraph = Block.new('line')
      assert_equal paragraph.hash,
                   { object: :block, type: :paragraph,
                     paragraph: { rich_text: [{ type: :text, text: { content: 'line' } }] } }
    end
  end
end
