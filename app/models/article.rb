class Article < ApplicationRecord
  belongs_to :blogs

  has_many :article_comments
  has_many :article_likes
end
