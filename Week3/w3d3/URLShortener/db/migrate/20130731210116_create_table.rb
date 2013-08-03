ßclass CreateTable < ActiveRecord::Migration
  def change

    create_table :users do |t|
      t.string :alias
      t.string :email

      t.timestamps

    end

    create_table :long_urls do |t|
      t.string :url

      t.timestamps
    end

    create_table :short_urls do |t|
      t.string :short_url
      t.integer :long_url_id
      t.integer :user_id

      t.timestamps
    end

    create_table :visits do |t|
      t.integer :short_url_id
      t.integer :user_id
      t.datetime :visit_time

      t.timestamp
    end


    create_table :comments do |t|
      t.integer :user_id
      t.integer :short_url_id
      t.text :body

      t.timestamps
    end

    create_table :tags do |t|
      t.string :tag

      t.timestamp
    end

    create_table :tagged_urls do |t|
      t.integer :tag_id
      t.integer :short_url_id

      t.timestamps
    end

  end

end
