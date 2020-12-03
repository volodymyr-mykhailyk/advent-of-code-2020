module Security
  class PasswordChecker
    def valid_for_sled_rental?(policy, password)
      occurrences, symbol = read_policy(policy)
      occurrences.include?(password.count(symbol))
    end

    def valid_for_toboggan_authentication?(policy, password)
      occurrences, symbol = read_policy(policy)
      symbols = password[occurrences.first - 1], password[occurrences.last - 1]
      symbols.include?(symbol) && symbols.uniq.count > 1
    end

    private

    def read_policy(policy)
      occurrences, symbol = policy.split(' ')
      occurrences = occurrences.split('-').map(&:to_i)
      return occurrences.first..occurrences.last, symbol
    end
  end
end
