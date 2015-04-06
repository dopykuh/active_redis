# ActiveRedis

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'active_kv'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install active_kv

## Usage

**Redis server needs to be run on localhost.**

```ruby
  require "active_redis"

  class Post < ActiveRedis::Base

    keys title: String,
      markdown: String,
      tags: Array,
      source: String

    belongs_to :author

    validates :markdown, presence: true
    validates :title, presence: true

  end

  class Author < ActiveRedis::Base

  keys name: String

  has_many :posts

  end
```

* Create new Post

```ruby
  Post.create title: "Mooo", markdown: "Some stuff"
```

* Error messages.

```ruby
  p = Post.new title: "Moo"
  p.save
  p.errors
```

* Handle relations

```ruby
  a = Author.create name: "Timmy"
  p = Post.create title: "Mooo", markdown: "Some stuff", author_id: 1
  
  a.posts 
  # => Get all posts by author
  
  p.author 
  # => Get author
```
