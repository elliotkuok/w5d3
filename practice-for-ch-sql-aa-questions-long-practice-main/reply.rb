require_relative 'questions_database.rb'
require_relative 'question.rb'
require_relative 'user.rb'
require "byebug"

class Reply

    def self.find_by_user_id(id)
        replies = QuestionsDatabase.instance.execute(<<-SQL, id) 
        SELECT * FROM replies 
        WHERE author_id = ?
        SQL
        replies.first ? Reply.new(replies.first) : nil
    end

    def self.find_by_question_id(id)
        res =  QuestionsDatabase.instance.execute(<<-SQL, id) 
        SELECT * FROM replies 
        WHERE question_id = ?
        SQL
        res.map {|reply| Reply.new(reply)}
    end

    def self.find_by_id(id)
        res = QuestionsDatabase.instance.execute("SELECT * FROM replies WHERE id = ?;", id)
        res.first ? Reply.new(res.first) : nil
    end

    def initialize(options)
        @id = options['id']
        @question_id = options['question_id']
        @parent_reply_id = options['parent_reply_id']
        @user_id = options['author_id']
        @body = options['body']
    end

    def author
        User.find_by_id(@user_id) #check with instructor
    end
    
    def question
        Question.find_by_id(@question_id)
    end

    def parent_reply
        Reply.find_by_user_id(@parent_reply_id)
    end

    def child_reply
        child_rep = QuestionsDatabase.instance.execute(<<-SQL, @id) 
        SELECT * FROM replies 
        WHERE parent_reply_id = ?
        SQL
        # debugger
        child_rep.first ? Reply.new(child_rep.first) : nil
    end
end


# if __FILE__ == $PROGRAM_NAME
#     r = Reply.find_by_user_id(2)
#     p r.author
# end