class CategoriesController < ApplicationController

  # GET /categories
  # GET /categories.json
  def index
    @categories = Category.all.order(:category_name)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = Category.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def category_params
      params.require(:category).permit(:category_name)
    end
end
