require "test_helper"

class PostsDashboardQueryTest < Minitest::Test
  def seed_posts(n)
    n.times do |i|
      author = Author.create!(name: "Author #{i}")
      Post.create!(author: author, title: "Post #{i}")
    end
  end

  def test_returns_recent_posts_with_author_name
    seed_posts(3)
    rows = PostsDashboardQuery.new(limit: 3).call

    assert_equal 3, rows.size
    assert_equal [:id, :title, :author_name].sort, rows.first.keys.sort
    assert rows.all? { |r| r[:author_name].is_a?(String) && !r[:author_name].empty? }
  end

  def test_does_not_n_plus_one
    seed_posts(5)
    assert_queries(2) do
      PostsDashboardQuery.new(limit: 5).call
    end
  end

  def test_respects_limit
    seed_posts(10)
    assert_equal 4, PostsDashboardQuery.new(limit: 4).call.size
  end
end
