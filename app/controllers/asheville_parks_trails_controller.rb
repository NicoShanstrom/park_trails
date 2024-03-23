class AshevilleParksTrailsController < ApplicationController
    def index
        @park = AshevillePark.find(params[:id])
        @trails = @park.trails
    end

    def new 
        @asheville_park = AshevillePark.find(params[:id])
        @trail = Trail.new
    end

    def create
        @asheville_park = AshevillePark.find(params[:id])
        @trail = @asheville_park.trails.new(trail_params)
        if @trail.save
            redirect_to "/asheville_parks/#{@asheville_park.id}/trails"
        else
            render 'new'
        end
    end

    private

    def trail_params
        params.require(:trail).permit(:name, :paved, :total_length)
    end
end