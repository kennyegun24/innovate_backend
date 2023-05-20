class Following < ApplicationRecord
    belongs_to :followed, class_name: "User"
    belongs_to :user
end
  