# frozen_string_literal: true

require 'minitest/autorun'
require 'pry'

require_relative '../../lib/file_system/tree'

module FileSystem
  class TreeTest < Minitest::Test
    def test_build_standard_fs
      tree = FileSystem::Tree.build('test/fixtures/standard_fs')

      assert tree.root.pretty_name, 'file_system'
      assert tree.root.children.size, 2

      first = tree.root.children.first
      second = tree.root.children[1]
      third = tree.root.children[2]

      assert_equal first.pretty_name, 'Fakefile'
      assert_equal first.instance_variable_defined?(:@children), false
      assert_equal second.pretty_name, 'foo'
      assert_equal second.instance_variable_defined?(:@children), true
      assert_equal third.pretty_name, 'bar'
      assert_equal third.instance_variable_defined?(:@children), false

      assert second.children.first.pretty_name, 'file_a.txt'
      assert second.children.first.pretty_name, 'file_b.md'
    end

    def test_build_empty_fs
      tree = FileSystem::Tree.build('test/fixtures/empty_fs')

      assert tree.root.pretty_name, 'empty_fs'
      assert_equal tree.root.instance_variable_defined?(:@children), false
    end
  end
end

