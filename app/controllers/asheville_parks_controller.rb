class AshevilleParksController < ApplicationController
    def index
        @asheville_parks = AshevillePark.ordered_parks
    end

    def show
        @asheville_park = AshevillePark.find(params[:id])
    end
end