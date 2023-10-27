class Author < ApplicationRecord
    validates :name, presence: true
    validates :email, presence: true
    validates :birth_date, presence: true
    has_many :book
    has_many :newsletters
end
