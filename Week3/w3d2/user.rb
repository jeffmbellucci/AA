class User

  def self.find_by_id(id)
    result = QuestionsDatabase.instance.execute( <<-SQL, id )
    SELECT
      *
    FROM
      users
    WHERE
      id = ?
    SQL
    User.new(result.first) unless result.empty?
  end

  def self.find_by_name(fname, lname)
    result = QuestionsDatabase.instance.execute( <<-SQL, fname, lname )
    SELECT
      *
    FROM
      users
    WHERE
      fname = ? AND lname = ?
    SQL
    User.new(result.first) unless result.empty?
  end

  attr_reader :id, :fname, :lname

  def initialize(options)
    @id, @fname, @lname  = options.values_at( 'id', 'fname', 'lname' )
  end

  def authored_questions
    Question.find_by_author_id(self.id)
  end

  def authored_replies
    Reply.find_by_user_id(self.id)
  end

  def followed_questions
    QuestionFollower.followed_questions_for_user_id(self.id)
  end

  def liked_questions
    QuestionLikes.liked_questions_for_user_id(self.id)
  end

  def average_karma
     result = QuestionsDatabase.instance.execute( <<-SQL, self.id )
     SELECT
       AVG(
         CASE WHEN count = 1 THEN 0
         ELSE count
       END)
     FROM (
         SELECT
           questions.id,
           COUNT(*) count
         FROM
           questions
         LEFT JOIN
           question_likes ON question_likes.question_id = questions.id
         WHERE questions.user_id = ?
         GROUP BY questions.id
       )
    SQL
    result.first.values.first
  end

  def save
   insert if self.id.nil?
   update if !self.id.nil?
  end

  private

  def insert
    QuestionsDatabase.instance.execute( <<-SQL, @fname, @lname )
    INSERT INTO users (fname, lname)
    VALUES (?, ?)
    SQL
    @id = QuestionsDatabase.instance.last_insert_row_id
  end

  def update
    QuestionsDatabase.instance.execute( <<-SQL, @fname, @lname, @id )
    UPDATE users
    SET fname = ?, lname = ?
    WHERE id = ?
    SQL
  end

  def snake_name
    camel_name = self.class.to_s
    snake_name = camel_name.gsub(/[(A-Z)]/, "_#{$&}".downcase)[1..-1]

  end

  def columns
    my_table = self.class.to_s
    while camel_name =~(/[(A-Z)]/)
      camel_name.sub($1, '_#{$1}'.downcase)
    end

"CamelName".gsub(/[(A-Z)]/, "_#{$0}".downcase)[1..-1]



    result = PRAGMA table_info(self.)

  end

end # end class User
