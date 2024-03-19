class AshevilleParksController < ApplicationController
    def index
        @asheville_parks = AshevillePark.all
    end
end