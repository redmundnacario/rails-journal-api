class User < ApplicationRecord
    validates :username, :password_digest, :email, presence: true
    validates :email, uniqueness: true
    validates :password_digest, length: { minimum: 6 }
    # validates :password_digest, with: /^[A-Za-z0-9]+$/

    has_secure_password

    has_many :journals, dependent: :destroy
    has_many :tasks, through: :journals
end
