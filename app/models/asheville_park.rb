class AshevillePark < ApplicationRecord
    has_many :trails, dependent: :destroy

    def self.ordered_parks
        order(created_at: :desc)
    end

    def trail_count
        trails.count
    end
end
