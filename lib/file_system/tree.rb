# frozen_string_literal: true

module FileSystem
  # A data structure used to interact with the filesystem
  class Tree
    attr_reader :pretty_name, :root

    def self.build
      new
    end

    private

    def initialize
      @root = Node.new(Dir.getwd)
      @pretty_name = @root.name.split('/').last

      traverse(@root)
    end

    def traverse(root)
      nodes = Dir.children(Dir.getwd).difference(IGNORED_FILES)

      until nodes.empty?
        child = Node.new(nodes.first)

        if File.directory?(child.name)
          Dir.chdir(child.name)

          traverse(child)
        end

        root.children << child && nodes.shift
      end

      Dir.chdir('..')
    end

    IGNORED_FILES = %w[.git .env .DS_Store].freeze

    # A representation of a file in the filesystem tree
    class Node
      attr_accessor :name

      def initialize(name)
        @name = name
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
