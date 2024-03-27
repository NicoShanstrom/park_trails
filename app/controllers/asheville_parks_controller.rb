class AshevilleParksController < ApplicationController
    def index
        @asheville_parks = AshevillePark.ordered_parks
    end

    def show
        @asheville_park = AshevillePark.find(params[:id])
    end

    def new 
        @asheville_park = AshevillePark.new
    end

    def create
        @asheville_park = AshevillePark.new(asheville_park_params)
        if @asheville_park.save
            redirect_to '/asheville_parks'
        else
            render 'new'
        end
    end

    def edit
        @asheville_park = AshevillePark.find(params[:id])
    end
    
    def update
        @asheville_park = AshevillePark.find(params[:id])
        if @asheville_park.update(asheville_park_params)
            redirect_to "/asheville_parks/#{@asheville_park.id}", notice: "Asheville Park was successfully updates."
        else
            render :edit
        end
    end

    def destroy
        AshevillePark.destroy(params[:id])
        redirect_to "/asheville_parks"
    end

    private

    def asheville_park_params
        params.require(:asheville_park).permit(:name, :fee, :pets_allowed)
    end
end