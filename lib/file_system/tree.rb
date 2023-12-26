# frozen_string_literal: true

module FileSystem
  # A data structure used to interact with the filesystem
  class Tree
    attr_reader :pretty_name, :root

    def self.build(path)
      new(path)
    end

    private

    def initialize(path)
      @root = Node.new(path)

      traverse(@root)
    end

    def traverse(root)
      nodes = Dir.children(Dir.new(root.path)).difference(IGNORED_FILES)

      until nodes.empty?
        path = root.path + '/' + nodes.first
        child = Node.new(path)

        traverse(child) if File.directory?(path)

        root.children << child && nodes.shift
      end
    end

    IGNORED_FILES = %w[.git .env .DS_Store].freeze

    # A representation of a file in the filesystem tree
    class Node
      attr_accessor :path, :pretty_name

      def initialize(path)
        @path = path
        @pretty_name = @path.split('/').last
      end

      def method_missing(method, *_args)
        if method == :children
          singleton_class.class_eval { attr_accessor :name, :children }
          instance_variable_set '@children', []
        else
          super
        end
      end

      def respond_to_missing?(method_name, include_private = false)
        method_name == :children || super
      end
    end
  end
end
