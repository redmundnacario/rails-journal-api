class Journal < ApplicationRecord
    validates :title, :description, presence:true
    validates :description, length: { minimum: 10 }

    belongs_to :user
    has_many :tasks, dependent: :destroy
end
