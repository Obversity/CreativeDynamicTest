require 'utilities'

class ProductsController < ApplicationController
  before_action :set_product, only: [:show]

  include Utilities

  # GET /products
  # GET /products.json
  def index
    if params[:category_id]
      @category = Category.find(params[:category_id])
      @products = @category.products.order(:product_name).page(params[:page]).per(5)
    else
      @products = Product.all.page(params[:page]).per(5)
    end
  end

  # GET /products/1
  # GET /products/1.json
  def show
  end

  def start

  end

  def import_products
    # see utilities module
    csv = get_remote_csv 'https://dl.dropboxusercontent.com/u/6582068/products.csv'

    #create categories
    csv.map { |row| row.to_hash['Category'] }.uniq.each do |name|
      unless Category.exists?(category_name: name)
        Category.create(category_name: name)
      end
    end

    #create products
    csv.map { |row| row.to_hash }.each do |row|
      unless Product.exists?(product_id: row['ProductID'])
        Product.create(
            category: Category.where(category_name: row['Category']).first,
            product_id: row['ProductID'],
            product_name: row['Product Name'],
            price: row['Price'].to_f
        )
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_product
    @product = Product.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def product_params
    params.require(:product).permit(:product_id, :category, :product_name, :price, :page)
  end
end
