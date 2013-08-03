class Reply
  def self.find_by_id(id)
    result = QuestionsDatabase.instance.execute( <<-SQL, id )
    SELECT
      *
    FROM
      reply
    WHERE
      id = ?
    SQL
    result.first
  end

  def self.find_by_question_id(question_id)
    result = QuestionsDatabase.instance.execute( <<-SQL, question_id )
    SELECT
      *
    FROM
      replies
    WHERE
      question_id = ?
    SQL
    (result.empty?) ? (nil) : (result.map { |row| Reply.new(row) })
  end

  def self.find_by_user_id(user_id)
    result = QuestionsDatabase.instance.execute( <<-SQL, user_id )
    SELECT
      *
    FROM
      replies
    WHERE
      user_id = ?
    SQL
    (result.empty?) ? (nil) : (result.map { |row| Reply.new(row) })
  end

  attr_reader :id, :question_id, :parent_id, :body, :user_id

  def initialize(options)
    @id, @question_id, @parent_id, @body, @user_id  =
        options.values_at('id', 'question_id', 'parent_id', 'body', 'user_id')
  end

  def author
    result = QuestionsDatabase.instance.execute( <<-SQL, self.user_id )
    SELECT
      *
    FROM
      replies
    WHERE
      user_id = ?
    SQL
    Author.new(result.first)
  end

  def question
    result = QuestionsDatabase.instance.execute( <<-SQL, self.question_id )
    SELECT
      *
    FROM
      replies
    WHERE
      question_id = ?
    SQL
    Question.new(result.first)
  end

  def parent_reply
    result = QuestionsDatabase.instance.execute( <<-SQL, self.parent_id )
    SELECT
      *
    FROM
      replies
    WHERE
      id = ?
    SQL
    (result.empty?) ? (nil) : (Reply.new(result.first))
  end

  def child_replies
    result = QuestionsDatabase.instance.execute( <<-SQL, self.id )
    SELECT
      *
    FROM
      replies
    WHERE
      parent_id = ?
    SQL
    (result.empty?) ? (nil) : (result.map { |row| Reply.new(row) })
  end

end # end class Reply