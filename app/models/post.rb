class Post < ApplicationRecord
    belongs_to :author, class_name: 'User'
    has_many :comment
    has_many :like
end
