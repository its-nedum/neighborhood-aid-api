class Request < ApplicationRecord
    belongs_to :user

    validates :title, presence: true
    validates :reqtype, presence: true
    validates :description, presence: true
    validates :lat, presence: true
    validates :lng, presence: true
    validates :address, presence: true
    validates :status, presence: true
end
