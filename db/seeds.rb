# frozen_string_literal: true

# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

riddles = [
  {
    question: 'I speak without a mouth and hear without ears. I have no body, but I come alive with the wind. What am I?',
    options: %w[Echo Whistle Cloud Shadow],
    correct_answer: 'Echo'
  },
  {
    question: 'The more you take, the more you leave behind. What am I?',
    options: %w[Footsteps Memories Time Money],
    correct_answer: 'Footsteps'
  },
  {
    question: 'I fly without wings. I cry without eyes. Wherever I go, darkness follows me. What am I?',
    options: %w[Thunder Wind Night Ghost],
    correct_answer: 'Thunder'
  },
  {
    question: 'The person who makes it, sells it. The person who buys it never uses it. What is it?',
    options: %w[Candle Coffin Computer Cake],
    correct_answer: 'Coffin'
  },
  {
    question: "What has keys but can't open locks?",
    options: ['Piano', 'Typewriter', 'Computer', 'Treasure chest'],
    correct_answer: 'Piano'
  },
  {
    question: "I'm tall when I'm young, and short when I'm old. What am I?",
    options: %w[Candle Tree Book Person],
    correct_answer: 'Candle'
  },
  {
    question: 'The more you take, the more you leave behind. What am I?',
    options: %w[Footsteps Memories Time Money],
    correct_answer: 'Footsteps'
  },
  {
    question: "What has a heart that doesn't beat?",
    options: %w[Artichoke Tomato Teapot Clock],
    correct_answer: 'Artichoke'
  },
  {
    question: 'I can be cracked, made, told, and played. What am I?',
    options: %w[Joke Egg Song Code],
    correct_answer: 'Joke'
  },
  {
    question: "I have keys but no locks. I have space but no room. You can enter, but you can't go inside. What am I?",
    options: %w[Computer Book Keyboard City],
    correct_answer: 'Keyboard'
  }
]

riddles.each do |riddle|
  question = Question.create(question: riddle[:question])
  riddle[:options].each do |answer|
    Answer.create(answer:, correct: answer == riddle[:correct_answer], question:)
  end
end
