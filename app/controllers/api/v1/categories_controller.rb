class Api::V1::CategoriesController < ApplicationController
    skip_before_action :authenticated
    before_action :set_category, only: %i[ show ]
    rescue_from ActiveRecord::RecordInvalid, with: :handle_invalid_record

    # GET /categories
    def index
        @categories = Category.all
        render json: @categories
    end

    # GET /categories/1
    def show
        render json: @category, include: ['main_threads','main_threads.user'] # overwrite AMS behaviour to obtain deeply nested data
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_category
        @category = Category.find(params[:id])
    rescue ActiveRecord::RecordNotFound
        render json: { message: 'Not Found' }, status: :not_found
    end

    def handle_invalid_record(e)
        render json: { message: e.record.errors.full_messages }, status: :unprocessable_entity
    end
end
