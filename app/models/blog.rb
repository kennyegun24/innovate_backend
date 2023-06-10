class Blog < ApplicationRecord
  has_many :articles

  belongs_to :user, class_name: 'User', foreign_key: :author_id

  before_save :update_author_columns

  validates :articles_counter, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :likes_counter, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :comments_counter, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  private

  def update_author_columns
    self.author_image = user.image
    self.author_name = user.name
  end
end
