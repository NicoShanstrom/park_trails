class AshevilleParksController < ApplicationController
    def index
        @asheville_parks = AshevillePark.all
    end

    def show
        @asheville_park = AshevillePark.find(params[:id])
    end
end