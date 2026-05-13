# Fix the N+1 in PostsDashboardQuery

This is a learning scenario from learn.railsfullstack.com.

## The task

`app/queries/posts_dashboard_query.rb` powers the admin dashboard's "recent posts" panel. Profiling caught it firing one extra SELECT per post to look up the author. The product team is fine with everything about the public shape — they just want the query count down.

Refactor `PostsDashboardQuery#call` so the test suite goes green. Don't change the return value's structure: each row is still `{ id:, title:, author_name: }`.

## Running tests

```sh
bundle install
bundle exec rake test
```

The first test (`test_returns_recent_posts_with_author_name`) asserts the data shape. The second (`test_does_not_n_plus_one`) wraps the query in an `assert_queries(2)` block — one SELECT for posts, one SELECT for authors.

CI runs the same `bundle exec rake test` on every push. When it goes green, the scorecard will appear on your attempt page on learn.railsfullstack.com.
