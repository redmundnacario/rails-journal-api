class Journal < ApplicationRecord
    validates :title, :description, presence:true
    validates :description, length: { minimum: 50 }

    belongs_to :user
    has_many :tasks
end
