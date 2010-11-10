class TrapInstallationsController < ApplicationController
  before_filter :fetch_trap_installation, :only => [:show, :edit, :update, :destroy]
  before_filter :fetch_dungeons_and_traps, :only => [:new, :edit]

  # GET /trap_installations
  # GET /trap_installations.xml
  def index
    @trap_installations = TrapInstallation.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @trap_installations }
    end
  end

  # GET /trap_installations/1
  # GET /trap_installations/1.xml
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @trap_installation }
    end
  end

  # GET /trap_installations/new
  # GET /trap_installations/new.xml
  def new
    @trap_installation = TrapInstallation.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @trap_installation }
    end
  end

  # GET /trap_installations/1/edit
  def edit
  end

  # POST /trap_installations
  # POST /trap_installations.xml
  def create
    @trap_installation = TrapInstallation.new(params[:trap_installation])

    respond_to do |format|
      if @trap_installation.save
        format.html { redirect_to(@trap_installation, :notice => 'Trap installation was successfully created.') }
        format.xml  { render :xml => @trap_installation, :status => :created, :location => @trap_installation }
      else
        fetch_dungeons_and_traps
        format.html { render :action => "new" }
        format.xml  { render :xml => @trap_installation.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /trap_installations/1
  # PUT /trap_installations/1.xml
  def update
    respond_to do |format|
      if @trap_installation.update_attributes(params[:trap_installation])
        format.html { redirect_to(@trap_installation, :notice => 'Trap installation was successfully updated.') }
        format.xml  { head :ok }
      else
        fetch_dungeons_and_traps
        format.html { render :action => "edit" }
        format.xml  { render :xml => @trap_installation.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /trap_installations/1
  # DELETE /trap_installations/1.xml
  def destroy
    @trap_installation.destroy

    respond_to do |format|
      format.html { redirect_to(trap_installations_url) }
      format.xml  { head :ok }
    end
  end

  protected
  def fetch_trap_installation
    @trap_installation = TrapInstallation.find(params[:id])
  end

  def fetch_dungeons_and_traps
    @dungeons = Dungeon.all
    @traps = Trap.all
  end
end
