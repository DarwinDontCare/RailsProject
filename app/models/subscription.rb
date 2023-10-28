class Subscription < ApplicationRecord
    belongs_to :reader
    has_one :newsletter

    validates :reader_id, presence: true
    validates :newsletter_id, presence: true
end