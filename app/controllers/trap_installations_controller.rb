class TrapInstallationsController < ApplicationController
  before_filter :fetch_scoping
  before_filter :fetch_trap_installation, :only => [:show, :edit, :update, :destroy]
  before_filter :fetch_dungeons_or_traps, :only => [:new, :edit]

  # GET /trap_installations
  # GET /trap_installations.xml
  def index
    @trap_installations = @scope.trap_installations.all

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
    @trap_installation = @scope.trap_installations.build

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
    @trap_installation = @scope.trap_installations.build(params[:trap_installation])
    set_dungeon_or_trap(@trap_installation, params)

    respond_to do |format|
      if @trap_installation.save
        format.html { redirect_to([@scope, @trap_installation], :notice => 'Trap installation was successfully created.') }
        format.xml  { render :xml => @trap_installation, :status => :created, :location => @trap_installation }
      else
        fetch_dungeons_or_traps
        format.html { render :action => "new" }
        format.xml  { render :xml => @trap_installation.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /trap_installations/1
  # PUT /trap_installations/1.xml
  def update
    @trap_installation.attributes = params[:trap_installation]
    set_dungeon_or_trap(@trap_installation, params)

    respond_to do |format|
      if @trap_installation.save
        format.html { redirect_to([@scope, @trap_installation], :notice => 'Trap installation was successfully updated.') }
        format.xml  { head :ok }
      else
        fetch_dungeons_or_traps
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
      format.html { redirect_to([@scope, :trap_installations]) }
      format.xml  { head :ok }
    end
  end

  protected
  def fetch_trap_installation
    @trap_installation = @scope.trap_installations.find(params[:id])
  end

  def fetch_dungeons_or_traps
    case @scope
    when Trap
      @dungeons = Dungeon.all
    when Dungeon
      @traps = Trap.all
    end
  end

  def fetch_scoping
    @scope =
      if params[:trap_id]
        @trap = Trap.find(params[:trap_id])
      elsif params[:dungeon_id]
        @dungeon = Dungeon.find(params[:dungeon_id])
      end
  end

  def set_dungeon_or_trap(for_installation, params)
    case @scope
    when Trap
      for_installation.dungeon_id = params[:trap_installation][:dungeon_id]
    when Dungeon
      for_installation.trap_id = params[:trap_installation][:trap_id]
    end
  end
end
