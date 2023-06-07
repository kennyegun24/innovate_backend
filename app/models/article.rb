class Article < ApplicationRecord
  belongs_to :blog, class_name: 'Blog', foreign_key: :blogs_id

  has_many :article_comments
  has_many :article_likes

  before_save :update_author_columns
  after_create :update_counter
  after_destroy :reduce_counter

  validates :title, presence: true, length: { minimum: 2, maximum: 100 }
  validates :text, presence: true, length: { minimum: 10, maximum: 5000 }
  validates :likes_counter, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :comments_counter, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  private

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
