class TrailsController < ApplicationController
    def index
        if params[:paved] == 'true'
            @trails = Trail.paved_trails
        else
            @trails = Trail.all
        end
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