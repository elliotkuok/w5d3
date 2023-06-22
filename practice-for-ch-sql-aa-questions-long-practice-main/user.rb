require_relative 'questions_database.rb'
require_relative 'question.rb'
require_relative 'reply.rb'
require_relative 'question_follow.rb'
class User
    def self.find_by_id(id)
        users = QuestionsDatabase.instance.execute("SELECT * FROM users WHERE id = ?;", id)
        users.first ? User.new(users.first) : nil
    end

    def self.find_by_name(fname, lname)
        user = QuestionsDatabase.instance.execute("SELECT * FROM users WHERE fname = ? AND lname = ?;", fname, lname)
        user.first ? User.new(user.first) : nil
    end

    attr_reader :fname, :lname
    
    
    def authored_questions
        Question.find_by_author_id(@id)
    end
    
    def authored_replies
        Reply.find_by_user_id(@id)
    end
    
    def followed_questions
        QuestionFollow.followed_questions_for_user_id(@id)
    end

    def initialize(options)
        @id = options['id']
        @fname = options['fname']
        @lname = options['lname']
    end
end

# if __FILE__ == $PROGRAM_NAME
#     r = User.find_by_id(1)
#     p r.followed_questions

# end