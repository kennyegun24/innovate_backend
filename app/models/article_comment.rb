class ArticleComment < ApplicationRecord
  belongs_to :article
  belongs_to :user

  before_save :update_author_columns
  after_save :update_counter
  after_destroy :decrease_counter

  validates :text, presence: true, length: { minimum: 3, maximum: 300 }

  def update_author_columns
    self.user_image = user.image
    self.user_name = user.name
  end

  def update_counter
    article.increment!(:comments_counter)
    article.blog.increment!(:comments_counter)
  end

  def decrease_counter
    article.decrement!(:comments_counter)
    article.blog.decrement!(:comments_counter)
  end
end
