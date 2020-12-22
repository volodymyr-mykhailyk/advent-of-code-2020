require_relative '../utils/printer'
require_relative '../utils/input_reader'
require_relative '../../lib/entertainment/space_combat'
require_relative '../../lib/entertainment/recursive_space_combat'

input_reader1 = Utils::InputReader.new(File.expand_path('input_player1.txt'))
input_reader2 = Utils::InputReader.new(File.expand_path('input_player2.txt'))

player1 = input_reader1.all_lines.to_integer.read
player2 = input_reader2.all_lines.to_integer.read

regular_game = Entertainment::SpaceCombat.new(player1, player2)

info "Playing round of regular space combat. Each player have #{player1.count} cards"

regular_winner = regular_game.play_game(false)
regular_score = regular_game.winner_score
info "Regular Game won by player #{regular_winner + 1} with score: #{regular_score}"

recursive_game = Entertainment::RecursiveSpaceCombat.new(player1, player2)

info "Playing round of recursive space combat. Each player have #{player1.count} cards"

recursive_winner = recursive_game.play_game(false)
recursive_score = recursive_game.winner_score
info "Recursive Game won by player #{recursive_winner + 1} with score: #{recursive_score}"
