require_relative 'questions_database.rb'
require_relative 'user.rb'
require_relative 'reply.rb'

class Question
    def self.find_by_id(id)
        res = QuestionsDatabase.instance.execute("SELECT * FROM questions WHERE id = ?;", id)
        res.first ? Question.new(res.first) : nil
    end

    def self.find_by_author_id(author_id)
        authors = QuestionsDatabase.instance.execute("SELECT * FROM questions WHERE author_id = ?;", author_id)
        authors.map {|question| Question.new(question)}
    end

    def initialize(options)
        @id = options['id']
        @title = options['title']
        @body = options['body']
        @author_id = options['author_id']
    end

    def author
        User.find_by_id(@author_id)
    end

    def replies
        Reply.find_by_question_id(@id)
    end
end

# p Question.all
# p Question.find_by_id(2)

# if __FILE__ == $PROGRAM_NAME
#     r = Question.find_by_id(2)
#     p r.question
# end