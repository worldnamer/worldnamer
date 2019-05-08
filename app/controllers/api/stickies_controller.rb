module Api
  class StickiesController < ApplicationController
    def index
      render json: Sticky.all
    end

    def create
      sticky = Sticky.create(text: '', color: 'yellow lighten-3')

      render json: sticky
    end

    def destroy
      sticky = Sticky.find_by(id: params[:id])

      sticky.destroy if sticky
    end

    def update
      sticky = Sticky.find_by(id: params[:id])

      if sticky
        sticky.update_attributes(text: params[:text], color: params[:color])
        
        head :no_content
      else
        head :not_found
      end
    end
  end
end