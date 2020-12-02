module Security
  class PasswordChecker
    def valid_for_sled_rental?(policy, password)
      occurrences, symbol = read_policy(policy)
      occurrences.include?(password.count(symbol))
    end

    private

    def read_policy(policy)
      occurrences, symbol = policy.split(' ')
      occurrences = occurrences.split('-').map(&:to_i)
      return occurrences.first..occurrences.last, symbol
    end
  end
end
