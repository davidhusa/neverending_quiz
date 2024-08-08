require 'question_generator'
# Rake task to generate a new questions
desc 'Generate a new topic with questions and answers'
task :generate, [:topic] => [:environment] do |t, args|
  raise 'Please provide a topic an argument' if args[:topic].blank?

  puts "Generating questions for: #{args[:topic]}"
  question_generator = QuestionGenerator::Generator.new
  question_generator.import_topic(args[:topic])
end
