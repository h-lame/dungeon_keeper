require 'spec_helper'

describe TrapsController do
  fixtures :all

  before :each do
    @trap = traps(:one)
  end

  context "index" do
    it "should respond successfully" do
      get :index
      response.should be_success
      assigns(:traps).should_not be_nil
    end
  end

  context "new" do
    it "should get new" do
      get :new
      response.should be_success
    end
  end

  context "create" do
    it "should create trap" do
      @trap.destroy
      lambda {
        post :create, :trap => @trap.attributes
      }.should change(Trap, :count).by(1)

      response.should redirect_to(trap_path(assigns(:trap)))
    end

    it "should not create trap if params are wrong" do
      lambda {
        post :create, :trap => @trap.attributes.except('name')
      }.should_not change(Trap, :count)

      response.should be_success
    end

    it "should leave the broken trap available to the view if params are wrong" do
      post :create, :trap => @trap.attributes.except('name')

      assigns(:trap).name.should be_blank
      assigns(:trap).errors.should_not be_empty
    end
  end

  context "show" do
    it "should show the requested trap" do
      get :show, :id => @trap.to_param
      response.should be_success
      assigns(:trap).should == @trap
    end
  end

  context "edit" do
    it "should get the requested trap" do
      get :edit, :id => @trap.to_param
      response.should be_success
      assigns(:trap).should == @trap
    end
  end

  context "update" do
    it "should update trap" do
      put :update, :id => @trap.to_param, :trap => @trap.attributes.merge('base_damage_caused' => "60")

      response.should redirect_to(trap_path(assigns(:trap)))
      @trap.reload.base_damage_caused.should == 60
    end

    it "should not update trap if params are wrong" do
      put :update, :id => @trap.to_param, :trap => @trap.attributes.merge('base_damage_caused' => "-1")

      response.should be_success
      @trap.reload.base_damage_caused.should == 20
    end

    it "should leave the broken trap available to the view if params are wrong" do
      put :update, :id => @trap.to_param, :trap => @trap.attributes.merge('base_damage_caused' => "-1")

      assigns(:trap).base_damage_caused.should == -1
      assigns(:trap).errors.should_not be_empty
    end
  end

  context "destroy" do
    it "should destroy trap" do
      lambda {
        delete :destroy, :id => @trap.to_param
      }.should change(Trap, :count).by(-1)

      response.should redirect_to(traps_path)
    end
  end
end
