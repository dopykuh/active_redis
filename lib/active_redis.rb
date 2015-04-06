require "active_model"
require "redis"

require "active_redis/version"
require "active_redis/attributes"
require "active_redis/relation"
require "active_redis/boolean"

module ActiveRedis

  @redis ||= Redis.new

  attr_reader :redis

  class Base

    include ActiveModel::Validations
    include ActiveModel::Serialization
    include ActiveModel::Serializers::JSON
    include ActiveModel::Serializers::Xml
    include ActiveRedis::Attributes::InstanceMethods
    include ActiveRedis::Relation::InstanceMethods
    extend ActiveRedis::Attributes::ClassMethods
    extend ActiveRedis::Relation::ClassMethods

    def initialize args={}, settings={reload: false}
      raise TypeError, 'Hash expected.' unless args.is_a? Hash
      keys.merge!({id: Integer, updated_at: Time})
      args = Hash[args.map{|(k,v)| [k.to_sym,v]}]
      @h = args
      create_relation_methods
      create_attribute_methods
      get_attributes reload: settings[:reload]
    end

  end

  extend self

end
