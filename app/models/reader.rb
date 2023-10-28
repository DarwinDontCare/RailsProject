class Reader < ApplicationRecord
    has_secure_password
    validates :email, presence: true
    validates :password, presence: true
    has_many :subscriptions
end