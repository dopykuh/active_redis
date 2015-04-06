
class TestActiveRedis < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::ActiveRedis::VERSION
  end

  def test_that_class_is_defined
    assert defined?(ActiveRedis::Base)
  end

  def test_that_attributes_are_correctly_set
    require './test/blog'
    assert_instance_of Redis, ActiveRedis.redis
    assert_equal ActiveRedis.redis, Post.connection
    ActiveRedis.redis.flushdb

    assert_empty Author.all
    assert_empty Post.all

    a = Author.create name: "Timmy"

    refute_nil Author.all.first
    refute_nil Author.all.first.name

    a.name = "timmy"

    refute_equal Author.all.first.name, a.name
    assert_equal Author.all.first.updated_at, a.updated_at
    assert_kind_of Time, Author.all.first.updated_at
    
    assert a.save
    
    assert_equal Author.all.first.name, a.name
    assert_equal Author.all.first.updated_at, a.updated_at
  end
  
  def test_that_validation_works
    require './test/blog'
    assert_instance_of Redis, ActiveRedis.redis
    ActiveRedis.redis.flushdb

    assert_empty Author.all
    assert_empty Post.all

    a = Post.new title: "Moooo"

    refute_empty a.attributes

    assert_nil Post.all.first
    assert_nil a.markdown

    refute a.save

    refute_empty a.errors.messages
  end
  
  def test_that_relations_are_correctly_set
    require './test/blog'
    assert_instance_of Redis, ActiveRedis.redis
    ActiveRedis.redis.flushdb

    assert_empty Author.all
    assert_empty Post.all

    a = Author.create name: "Timmy"
    p = Post.create title: "Moooo", markdown: '#Hi', author_id: 1

    refute_nil Author.all.first
    refute_nil Post.all.first
    assert_equal Author.all.first.name, p.author.name
    assert_includes a.posts.map(&:title), Post.all.first.title
  end
end
