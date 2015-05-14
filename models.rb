class User < Sequel::Model
  one_to_many :discussions
  one_to_many :contents
  one_to_many :comments
end

class Discussion < Sequel::Model
  many_to_one :user

  one_to_many :contents
end

class Content < Sequel::Model
  many_to_one :user
  many_to_one :discussion

  one_to_many :comments
end

class Comment < Sequel::Model
  many_to_one :user
  many_to_one :content
end