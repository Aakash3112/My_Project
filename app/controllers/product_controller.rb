class ProductController < ApplicationController
  
  before_action :authenticate_user!
  before_action :correct_user, only: [:update, :delete]

  api :GET, '/products', "Gets list of all products"
  def index

    
    if current_user.role == "1"
      @product = Product.all.page(params[:page]).per(5)
    else
      @product = Product.where(user_id: current_user.id).page(params[:page]).per(5)
    end
    # render :json => @product
    authorize @product
  end

  api :GET, '/products/:id', "Shows the deatils of a product"
  def show
    @product = Product.find(params[:id])
    # render :json => @product
    authorize @product
  end

  def new
    # @product = Product.new
    @product = current_user.products.build
  end

  api :POST, '/create_user', "Creates a new product"
  def create
    # @product = Product.new(product_params)
    @product = current_user.products.build(product_params)
    # @product.user_id = current_user.id
    if @product.valid?
      @product.save
      flash[:notice] = "Product successfully created"
      redirect_to root_path
    else
      puts @product.errors.full_messages
      flash[:alert] = "Make sure all field are given"
    end
  end

  def edit
    @product = Product.find(params[:id])
    authorize @product
  end

  api :PUT, '/update/:id', "Updates the details of a product"
  def update
    # @product = Product.find(params[:id])

    # @product.update(params[:product])
    # redirect_to product_show_path(@product)
    # respond_to do |format|
    if @product.valid?
      @product.update(product_params)
      flash[:notice] = "Updated package successfully"
      redirect_to root_path
      authorize @product

        # format.html { redirect_to root_path, notice: "Product was successfully updated." }
        # format.json { render :show, status: :ok, location: root_path }
      # else
      #   format.html { render :edit, status: :unprocessable_entity }
      #   format.json { render json: @product.errors, status: :unprocessable_entity }
      end
  end

  def correct_user
    if current_user.role == "1"
       @product = Product.all.find_by(id: params[:id])
    else
      @product = current_user.products.find_by(id: params[:id])
    end
    redirect_to root_path, notice: "Not Authorized to edit this user" if @product.nil?
  end

  def product_params
    params.require(:product).permit(:image, :title, :description, :price)
  end

  api :DELETE, 'delete/:id', "Deletes the product"
  def delete
    @product = Product.find(params[:id])
    flash[:notice] = @product.title + " " + "deleted successfully"
    @product.destroy
    redirect_to root_path
  end
end
