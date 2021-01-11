require_relative '../utils/printer'
require_relative '../utils/input_reader'
require_relative '../../lib/customs/group_declaration_form'

input_reader = Utils::InputReader.new(File.expand_path('input.txt'))

forms = input_reader.all_groups.split_with(/\s/).read
forms = forms.map { |answers| Customs::GroupDeclarationForm.new(answers) }
info "Processing #{forms.length} forms"

anyone_answered_questions_sum = forms.sum { |form| form.all_positive_answers.count }
info "Sum of any positive answers is: #{anyone_answered_questions_sum}"

everyone_answered_questions_sum = forms.sum { |form| form.everyone_positive_answers.count }
info "Sum of everyone positive answers is: #{everyone_answered_questions_sum}"
