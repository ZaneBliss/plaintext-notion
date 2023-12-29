# frozen_string_literal: true

require 'minitest/autorun'
require 'pry'

require_relative '../../lib/file_system/tree'
require_relative '../../lib/api/page'

module Api
  class PageTest < Minitest::Test
    def test_builds_json_representation
      node = FileSystem::Tree::Node.new('test/fixtures/standard_fs/foo/file_b.txt')

      page = Api::Page.new(node)

      assert_equal page.hash[:properties], { title: [{ type: 'text', text: { content: 'file_b.txt' } }] }
      assert_equal page.hash.key?(:children), true
      assert_equal page.hash[:parent], { page_id: '2aadcb4694944f19bc0dc673f6abbf4b' }
    end
  end
end
