class Article < ApplicationRecord
  belongs_to :blog, class_name: 'Blog', foreign_key: :blogs_id

  has_many :article_comments, class_name: 'ArticleComment', foreign_key: :articles_id
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
    self.author_id = blog.author_id
  end

  def update_counter
    blog.update(articles_counter: blog.articles.count)
  end

  def reduce_counter
    blog.update(articles_counter: blog.articles.count)
  end
end
