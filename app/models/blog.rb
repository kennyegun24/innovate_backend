class Blog < ApplicationRecord
  has_many :articles

  belongs_to :user, class_name: 'User', foreign_key: :author_id
end
