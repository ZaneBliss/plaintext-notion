# frozen_string_literal: true

require 'minitest/autorun'
require 'pry'

require_relative '../../lib/file_system/tree'
require_relative '../../lib/api/page'

module Api
  class PageTest < Minitest::Test
    def test_builds_json_representation
      node = FileSystem::Tree::Node.new('test/fixtures/standard_fs/Fakefile')

      page = Api::Page.new(node)

      assert_includes page.to_json,
                      '{"parent":{"page_id":"2aadcb4694944f19bc0dc673f6abbf4b"},"properties":{"title":{"title":[{"type":"text","text":{"content":"Fakefile"}}]}},"children":[{"object":"block","type":"paragraph","paragraph":{"rich_text":[{"type":"text","text":{"content":"CC=gcc\\nCFLAGS=-I.\\nDEPS = hellomake.h\\nOBJ = hellomake.o hellofunc.o\\n\\n%.o: %.c $(DEPS)\\n  $(CC) -c -o $@ $< $(CFLAGS)\\n\\nhellomake: $(OBJ)\\n  $(CC) -o $@ $^ $(CFLAGS)\\n"}}]}}]}'
    end
  end
end
