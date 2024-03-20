class AshevillePark < ApplicationRecord
    has_many :trails

    def self.ordered_parks
        order(created_at: :desc)
    end
end
