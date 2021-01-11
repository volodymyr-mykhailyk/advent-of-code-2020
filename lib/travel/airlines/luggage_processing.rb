require_relative '../luggage/bag'

module Travel
  module Airlines
    class LuggageProcessing
      def initialize(bags_descriptions)
        @bags = {}
        read_bags(bags_descriptions)
      end

      def all_bags
        @bags.values
      end

      def bags_holding_a(another_bag)
        all_bags.select do |bag|
          bag.holds?(another_bag)
        end
      end

      def bags_inside_of(bag)
        @bags[bag].bags_inside
      end

      protected

      def read_bags(bags_descriptions)
        bags_descriptions.each do |bag|
          key, contents = bag.delete_suffix('.').split('s contain ')
          contained_bags = Hash[contents.split(', ').map { |bag_info| bag_info.split(' ', 2).reverse }]
          contained_bags = {} if contents == 'no other bags'
          read_children_bags(bag_for(key), contained_bags)
        end
      end

      def read_children_bags(bag, contained_bags)
        contents = contained_bags.map { |key, count| [bag_for(key.delete_suffix('s')), count.to_i] }
        bag.contents = Hash[contents]
      end

      def bag_for(key)
        @bags[key] ||= Travel::Luggage::Bag.new(key)
      end
    end
  end
end