module Customs
  class GroupDeclarationForm
    def initialize(answers = [])
      @answers = {}
      @people = answers.length
      process_answers(answers)
    end

    def all_positive_answers
      @answers.keys.sort
    end

    def everyone_positive_answers
      @answers.keys.select {|key| @answers[key] == @people}
    end

    private

    def process_answers(answers)
      answers.each do |answer|
        answer.split('').each do |question|
          @answers[question] ||= 0
          @answers[question] +=1
        end
      end
    end
  end
end