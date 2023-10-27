class Newsletter < ApplicationRecord
    belongs_to :author
    belongs_to :book
    has_many :subscriptions, dependent: :destroy
    validates :active, presence: true
    validates :title, presence: true
end