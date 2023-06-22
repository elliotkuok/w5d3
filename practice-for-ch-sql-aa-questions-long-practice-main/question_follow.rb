require_relative 'questions_database.rb'
require_relative 'user.rb'
require_relative 'reply.rb'
require_relative 'question.rb'

class QuestionFollow
    def self.all
        res = QuestionsDatabase.instance.execute(<<-SQL) 
        SELECT 
            *
        FROM 
            question_follows
        SQL
        res.map {|ele| QuestionFollow.new(ele)}
    end

    def self.followers_for_question_id(question_id)
        res = QuestionsDatabase.instance.execute(<<-SQL, question_id) 
        SELECT 
        question_follows.*
        FROM 
        question_follows
        JOIN
        users ON users.id = question_follows.user_id
        JOIN
        questions ON questions.id = question_follows.question_id
        WHERE 
        question_id = ?
        SQL
        res.map {|ele| QuestionFollow.new(ele)}
    end

    def self.followed_questions_for_user_id(user_id)
        res = QuestionsDatabase.instance.execute(<<-SQL, user_id) 
        SELECT 
            questions.*
        FROM 
            questions
        JOIN
            question_follows ON questions.id = question_follows.question_id
        WHERE 
            question_follows.user_id = ?
        SQL
        # puts res
        res.map {|question| Question.new(question)}
    end

    def initialize(options)
        @id = options['id']
        @user_id = options['user_id']
        @question_id = options['question_id']
    end
end

# if __FILE__ == $PROGRAM_NAME
#     p QuestionFollow.followed_questions_for_user_id(1)
#     # p r.author
# end