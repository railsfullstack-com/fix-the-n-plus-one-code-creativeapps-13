# PostsDashboardQuery powers the admin dashboard's "recent posts" panel.
#
# It returns the N most-recent posts as plain hashes, with the author's
# name resolved per row:
#
#   [
#     { id: 12, title: "...", author_name: "Ada Lovelace" },
#     { id: 11, title: "...", author_name: "Grace Hopper" },
#     ...
#   ]
#
# Don't change the return shape — downstream code depends on it.
class PostsDashboardQuery
  DEFAULT_LIMIT = 10

  def initialize(limit: DEFAULT_LIMIT)
    @limit = limit
  end

  def call
    Post.order(created_at: :desc).limit(@limit).map do |post|
      {
        id:          post.id,
        title:       post.title,
        author_name: post.author.name
      }
    end
  end
end
