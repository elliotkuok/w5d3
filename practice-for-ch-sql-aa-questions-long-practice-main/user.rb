require_relative 'questions_database.rb'
require_relative 'question.rb'
require_relative 'reply.rb'

class User

    def self.find_by_name(fname, lname)
        res = QuestionsDatabase.instance.execute("SELECT * FROM users WHERE fname = ?;", id)
        res.first ? Question.new(res.first) : nil
    end

    def initialize(options)
        @id = options['id']
        @fname = options['fname']
        @lname = options['lname']
    end

    def authored_questions
        Question.find_by_author_id(@id)
    end

    def authored_replies
        Reply.find_by_user_id(@id)
    end
end
