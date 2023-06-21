require 'sqlite3'
require 'singleton'

class QuestionsDatabase
    def initialize
        @database = SQLite3::Database.new('./questions.db')
        @database.results_as_hash = true
        @database.type_translation = true
    end

    def execute(*args)
        @database.execute(*args)
    end
end

q = QuestionsDatabase.new
p q.execute("SELECT * FROM questions;")