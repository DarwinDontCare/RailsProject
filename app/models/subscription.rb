class Subscription < ApplicationRecord
    belongs_to :reader
    belongs_to :newsletter

    validates :reader_id, presence: true
    validates :newsletter_id, presence: true
end