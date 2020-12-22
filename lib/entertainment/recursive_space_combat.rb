require_relative 'space_combat'

module Entertainment
  class RecursiveSpaceCombat < SpaceCombat
    def initialize(player1, player2, game = 1)
      @next_game = game
      super
    end

    def play_round(print = false)
      return false unless all_players_have_cards?
      return false if recursion?
      if sub_game?
        @round += 1
        @stack.add(recursion_hash)
        play_sub_game(print)
      else
        super
      end
    end

    def play_game(print = false)
      print_game_info if print
      loop do
        break unless play_round(print)
      end
      print_game_resunts if print
      game_winner
    end


    protected

    def sub_game?
      (player1.count - 1) >= player1.first && (player2.count - 1) >= player2.first
    end

    def play_sub_game(print = false)
      print_sub_info if print
      cards = deal_cards
      stack1 = player1.first(cards.first)
      stack2 = player2.first(cards.last)
      game = SpaceCombat.new(stack1, stack2, @next_game += 1)
      winner = game.play_game(print)
      return_to_winner(winner, cards)
      print_sub_results(winner) if print
      true
    end

    def game_winner
      return 0 if recursion?
      super
    end

    def print_sub_info
      print_round_info
      puts "Playing a sub-game to determine the winner..."
      puts ""
    end

    def print_sub_results(winner)
      puts "...anyway, back to game 1."
      print_round_result(winner)
    end
  end
end