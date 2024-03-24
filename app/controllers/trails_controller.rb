class TrailsController < ApplicationController
    def index
        @trails = Trail.all
    end

    def show
        @trail = Trail.find(params[:id])
    end

    def edit
        @trail = Trail.find(params[:id])
    end
    
    def update
        @trail = Trail.find(params[:id])
        if @trail.update(trail_params)
            redirect_to "/trails/#{@trail.id}", notice: "Trail was successfully updated."
        else
            render :edit
        end
    end

    private

    def trail_params
        params.require(:trail).permit(:name, :paved, :total_length)
    end
end