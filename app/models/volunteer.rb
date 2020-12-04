class Volunteer < ApplicationRecord
    belongs_to :request

  validates :request_id, presence: true
  validates :requester_id, presence: true
end
