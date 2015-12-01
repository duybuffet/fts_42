Subject.create!(name: "Ruby on rails")

Subject.create!(name: "Mysql")

Subject.create!(name: "Ruby")

exam = Exam.create!(status: 0, subject_id: 1, user_id: 1)
30.times do |n|
  name = Faker::Lorem.sentence
  question_type = 0
  if n%2 == 0
    question_type = 1
  end
  question = Question.create!(content: name, subject_id: 1, user_id: 1, question_type: question_type)
  question_id = question.id
  answer_correct = Faker::Lorem.word
  Answer.create!(content: answer_correct, correct: true, question_id: question_id)
  3.times do |t|
    answer_incorrect = Faker::Lorem.word
    Answer.create!(content: answer_incorrect, correct: false, question_id: question_id)
  end
end

10.times do |n|
  name = Faker::Lorem.sentence
  question = Question.create!(content: name, subject_id: 1, user_id: 1, question_type: 2)
  question_id = question.id
  answer_correct = Faker::Lorem.word
  Answer.create!(content: answer_correct, correct: true, question_id: question_id)
end
