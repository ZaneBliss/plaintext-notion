# frozen_string_literal: true

require 'minitest/autorun'
require 'pry'

require_relative '../test_helper'
require_relative '../../lib/file_system/tree'

module FileSystem
  class TreeTest < Minitest::Test
    include TestHelper

    def test_build_standard_fs
      chdir_to_standard

      tree = FileSystem::Tree.build

      assert tree.pretty_name, 'file_system'
      assert tree.root.children.size, 2

      first = tree.root.children.first
      second = tree.root.children[1]
      third = tree.root.children[2]

      assert first.name, 'Fakefile'
      assert_equal first.instance_variable_defined?(:@children), false
      assert second.name, 'foo'
      assert_equal second.instance_variable_defined?(:@children), true
      assert third.name, 'bar'
      assert_equal third.instance_variable_defined?(:@children), false

      assert second.children.first.name, 'file_a.txt'
      assert second.children.first.name, 'file_b.md'

      reset_directory
    end

    def test_build_empty_fs
      chdir_to_empty

      tree = FileSystem::Tree.build

      assert tree.pretty_name, 'empty_fs'
      assert_equal tree.root.instance_variable_defined?(:@children), false

      reset_directory
    end
  end
end

