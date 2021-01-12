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
        regexp = /^#{rule_at('0').to_regexp}$/
        message.match?(regexp)
      end

      def rule_at(position)
        @rules[position]
      end

      class CharacterRule
        attr_reader :protocol, :value

        def initialize(protocol, value)
          @protocol = protocol
          @value = tokenize(value)
        end

        def matches?(string)
          puts "CharacterRule:#{value}:#{string.inspect}"
          string.shift == value
        end

        def to_regexp
          value.to_s
        end

        def tokenize(text)
          text.tr('"', '')
        end

        def self.described_as?(text)
          text.include?('"')
        end
      end

      class AndRule < CharacterRule
        def matches?(string)
          value.all? { |rule| protocol.rule_at(rule).matches?(string) }
        end

        def to_regexp
          value.map { |rule| protocol.rule_at(rule).to_regexp }.join
        end

        def tokenize(text)
          text.split(' ')
        end

        def self.described_as?(text)
          return false if CharacterRule.described_as?(text)
          return false if OrRule.described_as?(text)

          true
        end
      end

      class OrRule < CharacterRule
        def matches?(string)
          value.any? { |rule| rule.matches?(string.clone) }
        end

        def to_regexp
          "(#{value.map(&:to_regexp).join('|')})"
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