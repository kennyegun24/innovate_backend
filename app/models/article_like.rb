class ArticleLike < ApplicationRecord
  belongs_to :article
  belongs_to :user

  after_create :update_counter
  after_destroy :decrease_counter

  def update_counter
    article.increment!(:likes_counter)
    article.blog.increment!(:likes_counter)
  end

  def decrease_counter
    article.decrement!(:likes_counter)
    article.blog.decrement!(:likes_counter)
  end
end
