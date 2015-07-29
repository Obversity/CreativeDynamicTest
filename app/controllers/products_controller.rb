class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  # GET /products
  # GET /products.json
  def index
    if params["category"]
      @products = Category.where(category_name:params["category"]).first.products.order(:product_name).page(params[:page]).per(5)
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
    require 'csv'
    require 'open-uri'
    csv_text = open("https://dl.dropboxusercontent.com/u/6582068/products.csv").read
    csv = CSV.parse(csv_text, :headers=>true)

    #create categories
    csv.map{|row|row.to_hash["Category"]}.uniq.each do |name|
      if Category.where(category_name:name).length==0
        Category.create(category_name:name)
      end
    end

    #create products
    csv.map{|row|row.to_hash}.each do |row|
      if Product.where(product_id:row["ProductID"]).length == 0
        prod = Product.new
        prod.category = Category.where(category_name:row["Category"]).first
        prod.product_id = row["ProductID"]
        prod.product_name = row["Product Name"]
        prod.price = row["Price"].to_f
        prod.save!
      end
    end
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products
  # POST /products.json
  def create
    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: 'Product was successfully created.' }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url, notice: 'Product was successfully destroyed.' }
      format.json { head :no_content }
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
