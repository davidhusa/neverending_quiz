# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
[
  "What are the main characteristics of a monkey's habitat?",
  "How do monkeys communicate with each other?",
  "What is the average lifespan of different monkey species?",
  "Can you describe the social structure within monkey communities?",
  "What types of food make up a typical monkey diet?",
  "How do monkeys adapt to different environmental conditions?",
  "What are the most distinctive features of a monkey's anatomy?",
  "Are there specific threats or challenges faced by certain monkey species?",
  "How do monkeys contribute to their ecosystems?",
  "What unique behaviors or traits set monkeys apart from other primates?"
].each do |question|
  Question.create(question: question)
end
