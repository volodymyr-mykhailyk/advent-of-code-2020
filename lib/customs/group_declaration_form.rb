module Customs
  class GroupDeclarationForm
    def initialize(answers = [])
      @answers = {}
      answers.each { |answer| answer.split('').each { |question| @answers[question] = true } }
    end

    def positive_answers_list
      @answers.keys.sort
    end
  end
end