module Computing
  module Structures
    class DoubleLinkedList
      def initialize(first)
        @head = Node.new(first)
        @tail = @head
      end

      def append(item)
        node = Node.new(item)
        @tail.append(node)
      end

      class Node
        attr_reader :before, :after, :item

        def initialize(item)
          @item = item
        end

        def append(node)
          node.before = self
          node.after = @after
          @after.before = node
          @after = node
        end
      end
    end
  end
end