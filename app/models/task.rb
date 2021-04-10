class Task < ApplicationRecord
    validates :title, :description, :deadline, presence: true
    validates :description, length: { minimum: 10 }
    validates :done, inclusion: { in: [true, false] }

    belongs_to :journal
end
