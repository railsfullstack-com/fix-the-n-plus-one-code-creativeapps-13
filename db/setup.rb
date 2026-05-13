require "active_record"
require "logger"

ActiveRecord::Base.establish_connection(adapter: "sqlite3", database: ":memory:")
ActiveRecord::Base.logger = nil

ActiveRecord::Schema.define do
  create_table :authors, force: true do |t|
    t.string :name, null: false
    t.timestamps
  end

  create_table :posts, force: true do |t|
    t.references :author, null: false, foreign_key: true
    t.string :title, null: false
    t.timestamps
  end
end

require_relative "../app/models/author"
require_relative "../app/models/post"
require_relative "../app/queries/posts_dashboard_query"
