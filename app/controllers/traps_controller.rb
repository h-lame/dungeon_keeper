class TrapsController < ApplicationController
  before_filter :fetch_trap, :only => [:show, :edit, :update, :destroy]

  # GET /traps
  # GET /traps.xml
  def index
    @traps = Trap.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @traps }
    end
  end

  # GET /traps/1
  # GET /traps/1.xml
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @trap }
    end
  end

  # GET /traps/new
  # GET /traps/new.xml
  def new
    @trap = Trap.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @trap }
    end
  end

  # GET /traps/1/edit
  def edit
  end

  # POST /traps
  # POST /traps.xml
  def create
    @trap = Trap.new(params[:trap])

    respond_to do |format|
      if @trap.save
        format.html { redirect_to(@trap, :notice => 'Trap was successfully created.') }
        format.xml  { render :xml => @trap, :status => :created, :location => @trap }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @trap.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /traps/1
  # PUT /traps/1.xml
  def update
    respond_to do |format|
      if @trap.update_attributes(params[:trap])
        format.html { redirect_to(@trap, :notice => 'Trap was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @trap.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /traps/1
  # DELETE /traps/1.xml
  def destroy
    @trap.destroy

    respond_to do |format|
      format.html { redirect_to(traps_url) }
      format.xml  { head :ok }
    end
  end

  protected
  def fetch_trap
    @trap = Trap.find(params[:id])
  end
end
