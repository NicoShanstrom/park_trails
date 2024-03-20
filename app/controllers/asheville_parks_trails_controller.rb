class AshevilleParksTrailsController < ApplicationController
    def index
        @park = AshevillePark.find(params[:id])
        @trails = @park.trails
    end
end