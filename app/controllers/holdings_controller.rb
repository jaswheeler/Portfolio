class HoldingsController < ApplicationController
  
  #As the spec states this is single user only just going to do some 
  #simple authentication.  I could move the user name and password to a 
  #config file but this show the concept
  http_basic_authenticate_with :name => "name", :password => "password"  
  before_filter :get_market_values, :only => [:create, :update]

  # GET /holdings
  # GET /holdings.json
  def index
    @holdings = Holding.select("*, ((bid - price) * qty) as gain")

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @holdings }
    end
  end

  # GET /holdings/1
  # GET /holdings/1.json
  def show
    #@holding = Holding.find(params[:id])
    @holding = Holding.select("*, ((bid - price) * qty) as gain").where(id: params[:id]).first

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @holding }
    end
  end

  # GET /holdings/new
  # GET /holdings/new.json
  def new
    @holding = Holding.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @holding }
    end
  end

  # GET /holdings/1/edit
  def edit
    @holding = Holding.find(params[:id])
  end

  # POST /holdings
  # POST /holdings.json
  def create
    @holding = Holding.new(params[:holding].merge(@yahoo_data))

    respond_to do |format|
      if @holding.save
        format.html { redirect_to @holding, notice: 'Holding was successfully created.' }
        format.json { render json: @holding, status: :created, location: @holding }
      else
        format.html { render action: "new" }
        format.json { render json: @holding.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /holdings/1
  # PUT /holdings/1.json
  def update
    @holding = Holding.find(params[:id])

    respond_to do |format|
      if @holding.update_attributes(params[:holding].merge(@yahoo_data))
        format.html { redirect_to @holding, notice: 'Holding was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @holding.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /holdings/1
  # DELETE /holdings/1.json
  def destroy
    @holding = Holding.find(params[:id])
    @holding.destroy

    respond_to do |format|
      format.html { redirect_to holdings_url }
      format.json { head :no_content }
    end
  end

  private

  def get_market_values
    @yahoo_data = YahooFinance.market_details(params[:holding][:symbol])
  end
end
