module Computing
  module Protocols
    class SecurityDoors
      VALUE = 1
      DIVIDER = 20201227
      LOOP_LIMIT = 100_000_000

      def initialize(subject_number)
        @subject = subject_number
      end

      def loop_size_for(public_key, value = VALUE)
        (1..LOOP_LIMIT).detect do
          value = encrypt(value)
          value == public_key
        end
      end

      def encryption_key_for(loop)
        loop.times.reduce(VALUE) { |value, n| encrypt(value) }
      end

      def encrypt(value)
        (value * @subject) % DIVIDER
      end

      class Decipher
        SUBJECT_LIMIT = 100_000_000

        def find_subject_for(key)
          (1..SUBJECT_LIMIT).detect do |subject|
            raise 'subject impossible' if subject > SUBJECT_LIMIT - 1
            protocol_for(subject).loop_size_for(key)
          rescue => _
            # Invalid subject
          end
        end

        def find_encryption_keys(subject_number, card_key, door_key)
          public_protocol = protocol_for(subject_number)
          card_loop = public_protocol.loop_size_for(card_key)
          door_loop = public_protocol.loop_size_for(door_key)
          card_encryption = protocol_for(card_key).encryption_key_for(door_loop)
          door_encryption = protocol_for(door_key).encryption_key_for(card_loop)
          [card_encryption, door_encryption]
        end

        def protocol_for(subject_number)
          Computing::Protocols::SecurityDoors.new(subject_number)
        end
      end
    end
  end
end