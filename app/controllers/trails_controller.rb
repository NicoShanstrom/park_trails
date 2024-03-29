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
            redirect_to "/trails/#{@trail.id}"
        else
            render :edit
        end
    end

    def destroy
        Trail.destroy(params[:id])
        redirect_to "/trails"
    end

    private

    def trail_params
        params.permit(:name, :paved, :total_length)
    end
end