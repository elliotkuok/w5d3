require_relative 'questions_database.rb'
require_relative 'user.rb'
require_relative 'reply.rb'
require_relative 'question_follow.rb'
require "byebug"

class Question
    def self.all
        res = QuestionsDatabase.instance.execute(<<-SQL) 
        SELECT 
            *
        FROM 
            questions
        SQL
        res.map {|ele| Question.new(ele)}
    end

    def self.find_by_id(id)
        res = QuestionsDatabase.instance.execute("SELECT * FROM questions WHERE id = ?;", id)
        res.first ? Question.new(res.first) : nil
    end

    def self.find_by_author_id(author_id)
        questions = QuestionsDatabase.instance.execute("SELECT * FROM questions WHERE author_id = ?;", author_id)
        # authors.first ? Question.new(authors.first) : nil
        # debugger
        questions.map {|question| Question.new(question)}
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

    def followers
        QuestionFollow.followers_for_question_id(@id)
    end
end

if __FILE__ == $PROGRAM_NAME
    r = Question.find_by_author_id(3)
    r.each { |i| p i.followers }
end
