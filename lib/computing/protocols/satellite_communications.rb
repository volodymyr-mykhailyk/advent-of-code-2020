module Computing
  module Protocols
    class SatelliteCommunications
      def initialize(rules)
        @rules = {}
        parse_rules(rules)
      end

      def parse_rules(rules)
        rules.each do |rule_string|
          position, rule_text = rule_string.split(': ')
          rule_class = rule_class_for(rule_text)
          @rules[position] = rule_class.new(self, rule_text)
        end
      end

      def rule_class_for(rule_string)
        return CharacterRule if CharacterRule.described_as?(rule_string)
        return OrRule if OrRule.described_as?(rule_string)

        AndRule
      end

      def valid_message?(message)
        regexp = /^#{rule_at('0').to_regexp(0)}$/
        message.match?(regexp)
      end

      def rule_at(position)
        @rules[position]
      end

      class AndRule
        attr_reader :protocol, :value

        def initialize(protocol, value)
          @protocol = protocol
          @value = tokenize(value)
        end

        def to_regexp(depth)
          return '' if depth > 50
          value.map { |rule| protocol.rule_at(rule).to_regexp(depth + 1) }.join
        end

        def tokenize(text)
          text.split(' ')
        end

        def self.described_as?(_text)
          raise 'not implemented'
        end
      end

      class CharacterRule < AndRule
        def to_regexp(_depth)
          value.to_s
        end

        def tokenize(text)
          text.tr('"', '')
        end

        def self.described_as?(text)
          text.include?('"')
        end
      end

      class OrRule < AndRule
        def matches?(string)
          value.any? { |rule| rule.matches?(string.clone) }
        end

        def to_regexp(depth)
          patterns = value.map { |rule| rule.to_regexp(depth + 1) }
          "(?:#{patterns.join('|')})"
        end

        def tokenize(text)
          text.split(' | ').map { |rule| AndRule.new(protocol, rule) }
        end

        def self.described_as?(text)
          text.include?('|')
        end
      end
    end
  end
end