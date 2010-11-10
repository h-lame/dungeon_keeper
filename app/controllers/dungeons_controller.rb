class DungeonsController < ApplicationController
  # GET /dungeons
  # GET /dungeons.xml
  def index
    @dungeons = Dungeon.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @dungeons }
    end
  end

  # GET /dungeons/1
  # GET /dungeons/1.xml
  def show
    @dungeon = Dungeon.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @dungeon }
    end
  end

  # GET /dungeons/new
  # GET /dungeons/new.xml
  def new
    @dungeon = Dungeon.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @dungeon }
    end
  end

  # GET /dungeons/1/edit
  def edit
    @dungeon = Dungeon.find(params[:id])
  end

  # POST /dungeons
  # POST /dungeons.xml
  def create
    @dungeon = Dungeon.new(params[:dungeon])

    respond_to do |format|
      if @dungeon.save
        format.html { redirect_to(@dungeon, :notice => 'Dungeon was successfully created.') }
        format.xml  { render :xml => @dungeon, :status => :created, :location => @dungeon }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @dungeon.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /dungeons/1
  # PUT /dungeons/1.xml
  def update
    @dungeon = Dungeon.find(params[:id])

    respond_to do |format|
      if @dungeon.update_attributes(params[:dungeon])
        format.html { redirect_to(@dungeon, :notice => 'Dungeon was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @dungeon.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /dungeons/1
  # DELETE /dungeons/1.xml
  def destroy
    @dungeon = Dungeon.find(params[:id])
    @dungeon.destroy

    respond_to do |format|
      format.html { redirect_to(dungeons_url) }
      format.xml  { head :ok }
    end
  end
end
