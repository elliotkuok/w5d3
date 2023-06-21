require_relative 'questions_database.rb'
class Question
    @@database = QuestionsDatabase.new

    def self.all
        res = @@database.execute("SELECT * FROM questions;")
        res.map {|ele| Question.new(ele)}
    end

    def self.find_by_id(id)
        res = @@database.execute("SELECT * FROM questions WHERE id = ?;", id)
        res.first ? Question.new(res.first) : nil
    end

    def initialize(options)
        @id = options['id']
        @title = options['title']
        @body = options['body']
        @author_id = options['author_id']
    end
end

p Question.all
p Question.find_by_id(2)