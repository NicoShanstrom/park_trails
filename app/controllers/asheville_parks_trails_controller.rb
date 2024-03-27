class AshevilleParksTrailsController < ApplicationController
    def index
        @park = AshevillePark.find(params[:id])
        if params[:alphabetical] == 'true'
            @trails = @park.trails.alphabetical
        elsif params[:trail].present?
            @trails = @park.trails.minimum_length(params[:trail][:min_length])
        else
            @trails = @park.trails
        end
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
        params.permit(:name, :paved, :total_length)
    end
end