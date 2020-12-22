module Entertainment
  class SpaceCombat
    attr_reader :player1, :player2, :players, :round

    def initialize(player1, player2, game = 1)
      @player1, @player2 = [player1.clone, player2.clone]
      @players = [@player1, @player2]
      @round = 0
      @game = game
      @stack = Set.new
    end


    def play_round(print = false)
      return false unless all_players_have_cards?
      return false if recursion?

      @stack.add(recursion_hash)
      @round += 1

      print_round_info if print
      cards = deal_cards
      winner = round_winner(cards)
      return_to_winner(winner, cards)
      print_round_result(winner) if print

      true
    end

    def play_game(print = false)
      print_game_info if print
      loop do
        break unless play_round(print)
      end
      print_game_resunts if print
      game_winner
    end

    def winner_score
      calculate_score(players[game_winner])
    end

    def calculate_score(cards)
      cards.reverse.map.with_index { |card, i| card * (i + 1) }.sum
    end

    protected

    def all_players_have_cards?
      player1.any? && player2.any?
    end

    def recursion?
      @stack.include?(recursion_hash)
    end

    def recursion_hash
      "#{player1.join(",")}:#{player2.join(",")}"
    end

    def deal_cards
      [player1.shift, player2.shift]
    end

    def sneak_cards
      [player1.first, player2.first]
    end

    def round_winner(cards)
      cards.first > cards.last ? 0 : 1
    end

    def return_to_winner(winner, cards)
      sorted = [cards[winner], cards[winner - 1]]
      players[winner].push(*sorted)
    end

    def game_winner
      return 0 if recursion?
      raise 'game not finished' if all_players_have_cards?
      player1.empty? ? 1 : 0
    end

    def print_round_info
      puts "-- Round #{@round} (Game #{@game}) --"
      puts "Player 1's deck: #{player1}"
      puts "Player 2's deck: #{player2}"
      puts "Player 1 plays: #{sneak_cards.first}"
      puts "Player 2 plays: #{sneak_cards.last}"
    end

    def print_round_result(winner)
      puts "Player #{winner + 1} wins round #{@round} of game #{@game}!"
      puts ""
    end

    def print_game_info
      puts "=== Game #{@game} ==="
      puts ""
    end

    def print_game_resunts
      puts "The winner of game #{@game} is player #{game_winner + 1}!"
      puts ""
    end
  end
end