class QuestionFollower

  def self.find_by_id(id)
    result = QuestionsDatabase.instance.execute( <<-SQL, id )
    SELECT
      *
    FROM
      question_followers
    WHERE
      id = ?
    SQL
    QuestionFollower.new(result.first) unless result.empty?
  end

  def self.followers_for_question_id(question_id)
    result = QuestionsDatabase.instance.execute( <<-SQL, question_id )
    SELECT
    users.id id,
    users.fname fname,
    users.lname lname
    FROM
      users
    JOIN
      question_followers ON question_followers.user_id = users.id
    WHERE
      question_followers.question_id = ?
    SQL
    result.map { |row| User.new(row) }
  end

  def self.followed_questions_for_user_id(user_id)
    result = QuestionsDatabase.instance.execute( <<-SQL, user_id )
    SELECT
    questions.id id,
    questions.title title,
    questions.body body,
    questions.user_id user_id
    FROM
      questions
    JOIN
      question_followers ON question_followers.question_id = questions.id
    WHERE
      question_followers.user_id = ?
    SQL
    result.map { |row| Question.new(row) }
  end

  def self.most_followed_questions(n = 1)
    result = QuestionsDatabase.instance.execute( <<-SQL, n )
    SELECT
    questions.id id,
    questions.title title,
    questions.body body,
    questions.user_id user_id
    FROM
      questions
    JOIN
      question_followers ON question_followers.question_id = questions.id
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

end # end class Question_Follower