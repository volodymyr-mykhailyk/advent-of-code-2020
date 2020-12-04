module Customs
  class PasswordScanner
    def has_all_fields?(passport)
      keys = passport.keys.map(&:to_s)
      fields.keys.all? { |field| keys.include?(field.to_s) }
    end

    def has_all_valid_fields?(passport)
      fields.all? { |field, verification| verification.call(passport[field.to_s] || passport[field]) }
    end

    def fields
      {
        byr: ->(value) { (1920..2002).include?(value.to_i) },
        iyr: ->(value) { (2010..2020).include?(value.to_i) },
        eyr: ->(value) { (2020..2030).include?(value.to_i) },
        hgt: ->(value) do
          return (150..193).include?(value.to_i) if value.include?('cm')
          return (59..76).include?(value.to_i) if value.include?('in')
          false
        end,
        hcl: ->(value) { value.match?(/^\#[0-9a-f]{6}$/) },
        ecl: ->(value) { %w[amb blu brn gry grn hzl oth].include?(value) },
        pid: ->(value) { value.match?(/^[0-9]{9}$/) },
      }
    end
  end
end