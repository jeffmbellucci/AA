class QuestionLike

  def self.find_by_id(id)
    result = QuestionsDatabase.instance.execute( <<-SQL, id )
    SELECT
      *
    FROM
      question_like
    WHERE
      id = ?
    SQL
    result[0]
  end

  def self.likers_for_question_id(question_id)
    result = QuestionsDatabase.instance.execute( <<-SQL, question_id )
    SELECT
      users.id id,
      users.fname fname,
      users.lname lname
    FROM
      users
    JOIN
      question_likes ON question_likes.user_id = users.id
    WHERE
      question_likes.question_id = ?
    SQL
    result.map { |row| User.new(row) }
  end

  def self.num_likes_for_question_id(question_id)
    result = QuestionsDatabase.instance.execute( <<-SQL, question_id )
    SELECT
      COUNT(*)
    FROM
      question_likes
    WHERE
      question_id = ?
    -- GROUP_BY
    --   question_id
    -- HAVING
    --   question_id = ?
    SQL
    result.first.value
  end

  def self.liked_questions_for_user_id(user_id)
    result = QuestionsDatabase.instance.execute( <<-SQL, user_id )
    SELECT
      questions.id id,
      questions.title title,
      questions.body body,
      questions.user_id user_id
    FROM
      questions
    JOIN
      question_likes ON question_likes.question_id = questions.id
    WHERE
      question_likes.user_id = ?
    SQL
    result.map { |row| Question.new(row) }
  end

  def self.most_liked_questions(n = 1)
    result = QuestionsDatabase.instance.execute( <<-SQL, n )
    SELECT
    questions.id id,
    questions.title title,
    questions.body body,
    questions.user_id user_id
    FROM
      questions
    JOIN
      question_likes ON question_likes.question_id = questions.id
    GROUP BY
      questions.id
    ORDER BY
      count(*) DESC
    LIMIT
      ?
    SQL
    result.map { |row| Question.new(row) }
  end

  attr_reader :id, :user_id, :question_id

  def initialize(options)
    @id, @user_id, @question_id  = options.values_at('id', 'user_id', 'question_id')
  end


  def likers
    QuestionLike.likers_for_question_id(self.id)
  end

  def num_likes
    QuestionLike.num_likes_for_question_id(self.id)
  end

end # end class Question_like
