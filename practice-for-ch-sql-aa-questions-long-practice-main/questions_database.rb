require 'sqlite3'
require 'singleton'

class QuestionsDatabase < SQLite3::Database
    include Singleton
    def initialize
        super('questions.db')
        self.results_as_hash = true
        self.type_translation = true
    end

    # def execute(*args)
    #     self.execute(*args)
    # end
end

# q = QuestionsDatabase.new
# p q.execute("SELECT * FROM questions;")