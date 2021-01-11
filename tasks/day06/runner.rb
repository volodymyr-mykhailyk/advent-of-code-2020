require_relative '../utils/printer'
require_relative '../utils/input_reader'
require_relative '../../lib/customs/group_declaration_form'

input_reader = Utils::InputReader.new(File.expand_path('input.txt'))

forms = input_reader.all_groups.split_with(/\s/).read
forms = forms.map { |answers| Customs::GroupDeclarationForm.new(answers) }
info "Processing #{forms.length} forms"

positive_answers_sum = forms.sum { |form| form.positive_answers_list.count }
info "Sum of all positive answers is: #{positive_answers_sum}"
