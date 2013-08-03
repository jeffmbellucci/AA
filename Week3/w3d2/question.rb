class Question

  def self.find_by_id(id)
    result = QuestionsDatabase.instance.execute( <<-SQL, id )
    SELECT
      *
    FROM
      questions
    WHERE
      id = ?
    SQL
    Question.new(result.first) unless result.empty?
  end

  def self.find_by_author_id(user_id)
    result = QuestionsDatabase.instance.execute( <<-SQL, user_id )
    SELECT
      *
    FROM
      questions
    WHERE
      user_id = ?
    SQL
    result.map { |row| Question.new(row) }
  end

  def self.most_followed(n = 1)
    QuestionFollower.most_followed_questions(n)
  end

  def self.most_liked(n = 1)
    QuestionLike.most_liked_questions(n)
  end

  attr_reader :id, :title, :body, :user_id

  def initialize(options)
    @id, @title, @body, @user_id  = options.values_at('id', 'title', 'body', 'user_id')
  end

  def author
    result = QuestionsDatabase.instance.execute( <<-SQL, self.user_id )
    SELECT
      *
    FROM
      users
    WHERE
      id = ?
    SQL
    User.new(result.first) unless result.empty?
  end

  def replies
    result = QuestionsDatabase.instance.execute( <<-SQL, self.id )
    SELECT
      *
    FROM
      replies
    WHERE
      id = ?
    SQL
    result.map { |row| Reply.new(row) }
  end

  def followers
    QuestionFollower.followers_for_question_id(self.id)
  end


end # end class Question
