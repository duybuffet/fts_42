ActiveRecord::Schema.define(version: 20151123130644) do

  create_table "answers", force: :cascade do |t|
    t.boolean  "correct"
    t.string   "content"
    t.integer  "question_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "answers", ["question_id"], name: "index_answers_on_question_id"

  create_table "exams", force: :cascade do |t|
    t.integer  "status"
    t.integer  "duration"
    t.integer  "subject_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "exams", ["subject_id"], name: "index_exams_on_subject_id"
  add_index "exams", ["user_id"], name: "index_exams_on_user_id"

  create_table "questions", force: :cascade do |t|
    t.string   "content"
    t.integer  "status"
    t.integer  "subject_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "questions", ["subject_id"], name: "index_questions_on_subject_id"
  add_index "questions", ["user_id"], name: "index_questions_on_user_id"

  create_table "results", force: :cascade do |t|
    t.boolean  "correct"
    t.integer  "answer_id"
    t.integer  "question_id"
    t.integer  "exam_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "results", ["answer_id", "question_id", "exam_id"], name: "index_results_on_answer_id_and_question_id_and_exam_id", unique: true
  add_index "results", ["answer_id"], name: "index_results_on_answer_id"
  add_index "results", ["exam_id"], name: "index_results_on_exam_id"
  add_index "results", ["question_id"], name: "index_results_on_question_id"

  create_table "subjects", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "chatwork_id"
    t.integer  "role"
    t.string   "password_digest"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

end
