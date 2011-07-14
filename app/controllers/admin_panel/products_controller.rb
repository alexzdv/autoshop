class AdminPanel::ProductsController < AdminPanel::AdminApplicationController

  def create
    @product = Product.new(params[:product])

    if params[:photos]
      params[:photos].each do |hash|
        @product.photos.build(hash)
      end
    end

    if @product.save
      redirect_to(admin_panel_products_path, :notice => 'Product was successfully created.')
    else
      render :action => "new"
    end
  end

  def index
    @products = Product.includes(:company,:group).all
  end

  def new
    @product = Product.new
    @companies = Company.all
    @groups = Group.all

    @photo = Photo.new

  end

  def update
    @product = Product.find(params[:id])

    if @product.update_attributes(params[:product])
      redirect_to(admin_panel_product_path(@product), :notice => 'Product was successfully updated.')
    else
      render :action => "edit"
    end
  end

  def show
    @product = Product.find(params[:id])
  end

  def edit
    @product = Product.find(params[:id])

    @companies = Company.all
    @groups = Group.all
  end

  def destroy
    if Product.find(params[:id]).destroy
      redirect_to(admin_panel_products_path, :notice => 'Product was successfully deleted.')
    else
      redirect_to(admin_panel_products_path, :notice => 'Error.')
    end
  end
end
