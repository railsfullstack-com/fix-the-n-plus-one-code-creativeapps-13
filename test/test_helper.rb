require "minitest/autorun"
require_relative "../db/setup"

module QueryCountHelper
  # Counts every SELECT/INSERT/UPDATE/DELETE issued inside the block,
  # excluding schema queries and transaction control statements.
  def assert_queries(expected, &block)
    queries = []
    counter = ->(_name, _start, _finish, _id, payload) {
      sql = payload[:sql]
      next if payload[:name] == "SCHEMA"
      next if sql =~ /\A\s*(BEGIN|COMMIT|ROLLBACK|SAVEPOINT|RELEASE)/i
      queries << sql
    }
    ActiveSupport::Notifications.subscribed(counter, "sql.active_record", &block)
    assert_equal expected, queries.size,
      "Expected #{expected} queries, got #{queries.size}:\n#{queries.join("\n")}"
  end
end

class Minitest::Test
  include QueryCountHelper

  def setup
    Post.delete_all
    Author.delete_all
  end
end
