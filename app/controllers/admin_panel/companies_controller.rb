class AdminPanel::CompaniesController < AdminPanel::AdminApplicationController
  before_filter :find_company, :only => [:update, :show, :edit, :destroy]

  def create
    @company = Company.new(params[:company])
    photo_build

    if @company.save
      redirect_to(admin_panel_companies_path, :notice => 'Company was successfully created.')
    else
      render :action => "new"
    end
  end

  def index
    @companies = Company.all
  end

  def new
    @company = Company.new
    @photo = Photo.new
  end

  def update
    photo_build
    if @company.update_attributes(params[:company])
      redirect_to(admin_panel_company_path(@company), :notice => 'Company was successfully updated.')
    else
      render :action => "edit"
    end
  end

  def show
  end

  def edit
  end

  def destroy
    @company.destroy
    redirect_to admin_panel_companies_path, :notice => 'Company was successfully deleted.'
  end

  private

  def find_company
    unless @company = Company.find_by_id(params[:id])
      flash[:error] = "Could not find id: #{params[:id]}"
      redirect_to admin_panel_companies_path
    end
  end

  def photo_build
    params[:photos].each_value { |photo| @company.photos.build(photo) } if params[:photos]
  end

end
