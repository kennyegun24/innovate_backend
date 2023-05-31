class Article < ApplicationRecord
  belongs_to :blog, class_name: 'Blog', foreign_key: :blogs_id

  has_many :article_comments
  has_many :article_likes

  before_save :update_author_columns
  after_save :update_counter
  after_destroy :reduce_counter

  # validates :art_counter, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  def update_author_columns
    self.author_image = blog.user.image
    self.author_name = blog.user.name
  end

  def update_counter
    blog.increment!(:articles_counter)
  end

  def reduce_counter
    blog.decrement!(:articles_counter)
  end
end
