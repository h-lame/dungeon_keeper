require 'spec_helper'

describe DungeonsController do
  fixtures :all

  before :each do
    @dungeon = dungeons(:one)
  end

  context "index" do
    it "should get index" do
      get :index
      response.should be_success
      assigns(:dungeons).should_not be_nil
    end
  end

  context "new" do
    it "should get new" do
      get :new
      response.should be_success
    end
  end

  context "create" do
    context "with valid params" do
      it "should create dungeon" do
        @dungeon.destroy
        lambda {
          post :create, :dungeon => @dungeon.attributes
        }.should change(Dungeon, :count).by(1)

        response.should redirect_to(dungeon_path(assigns(:dungeon)))
      end
    end

    context "with invalid params" do
      before :each do
        @invalid_params = @dungeon.attributes.except('name')
      end

      it "should not create dungeon" do
        lambda {
          post :create, :dungeon => @invalid_params
        }.should_not change(Dungeon, :count)

        response.should be_success
      end

      it "should leave the broken dungeon available to the view" do
        post :create, :dungeon => @invalid_params

        assigns(:dungeon).name.should be_blank
        assigns(:dungeon).errors.should_not be_empty
      end
    end
  end

  context "show" do
    it "should show the requested dungeon" do
      get :show, :id => @dungeon.to_param
      response.should be_success
      assigns(:dungeon).should == @dungeon
    end
  end

  context "edit" do
    it "should get edit for the requested dungeon" do
      get :edit, :id => @dungeon.to_param
      response.should be_success
      assigns(:dungeon).should == @dungeon
    end
  end

  context "update" do
    context "with valid params" do
      it "should update dungeon" do
        put :update, :id => @dungeon.to_param, :dungeon => @dungeon.attributes.merge('levels' => "200")
        response.should redirect_to(dungeon_path(assigns(:dungeon)))
        @dungeon.reload.levels.should == 200
      end
    end

    context "with invalid params" do
      before :each do
        @invalid_params = @dungeon.attributes.merge('levels' => "-1")
      end

      it "should not update dungeon if params are wrong" do
        put :update, :id => @dungeon.to_param, :dungeon => @invalid_params
        response.should be_success
        @dungeon.reload.levels.should == 1
      end

      it "should leave the broken dungeon available to the view if params are wrong during update" do
        put :update, :id => @dungeon.to_param, :dungeon => @invalid_params
        assigns(:dungeon).levels.should == -1
        assigns(:dungeon).errors.should_not be_empty
      end
    end
  end

  it "should destroy dungeon" do
    lambda {
      delete :destroy, :id => @dungeon.to_param
    }.should change(Dungeon, :count).by(-1)

    response.should redirect_to(dungeons_path)
  end
end
