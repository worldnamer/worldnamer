module Api
  class StickiesController < ApplicationController
    def index
      render json: Sticky.all
    end

    def create
    end

    def destroy
    end
  end
end