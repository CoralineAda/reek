require 'reek/source/core_extras'
require 'reek/source/source_code'
require 'reek/source/source_locator'

module Reek
  module Source
    #
    # A collection of source code. If the collection is initialized with an array
    # it is assumed to be a list of file paths. Otherwise it is assumed to be a
    # single unit of Ruby source code.
    #
    class SourceRepository
      def self.parse source
        case source
        when Array
          new 'dir', Source::SourceLocator.new(source).all_sources
        when Source::SourceCode
          new source.desc, [source]
        else
          src = source.to_reek_source
          new src.desc, [src]
        end
      end

      include Enumerable
      attr_reader :description

      def initialize description, sources
        @description = description
        @sources = sources
      end

      def each &block
        @sources.each(&block)
      end
    end
  end
end
