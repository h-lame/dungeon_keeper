require 'spec_helper'

describe EvilWizardsController do
  fixtures :all

  before :each do
    @evil_wizard = evil_wizards(:one)
  end

  context "index" do
    it "should get index" do
      get :index
      response.should be_success
      assigns(:evil_wizards).should_not be_nil
    end
  end

  context "new" do
    it "should get new" do
      get :new
      response.should be_success
    end

    it "should fetch a list of dungeons" do
      get :new
      assigns(:dungeons).should_not be_nil
    end

    it "the dungeons fetched should only be dungeons without an evil wizard" do
      d1 = Dungeon.create!(:name => 'Despair', :levels => 4)
      d2 = Dungeon.create!(:name => 'Destard', :levels => 6)

      d1.create_evil_wizard(:name => 'David Blaine', :magic_school => 'stage', :experience_points => 450)

      get :new

      assigns(:dungeons).should include(d2)
      assigns(:dungeons).should_not include(d1)
    end
  end

  context "create" do
    context "with correct params" do
      it "should create evil wizard" do
        @evil_wizard.destroy
        lambda {
          post :create, :evil_wizard => @evil_wizard.attributes
        }.should change(EvilWizard, :count).by(1)

        response.should redirect_to(evil_wizard_path(assigns(:evil_wizard)))
      end
    end

    context "with incorrect params" do
      before :each do
        @invalid_params = @evil_wizard.attributes.except('name')
      end

      it "should not create evil wizard" do
        lambda {
          post :create, :dungeon => @invalid_params
        }.should_not change(EvilWizard, :count)

        response.should be_success
      end

      it "should leave the broken evil wizard available to the view" do
        post :create, :dungeon => @invalid_params

        assigns(:evil_wizard).name.should be_blank
        assigns(:evil_wizard).errors.should_not be_empty
      end

      it "should fetch a list of dungeons" do
        post :create, :dungeon => @invalid_params
        assigns(:dungeons).should_not be_nil
      end

      it "the dungeons fetched should only be dungeons without an evil wizard" do
        d1 = Dungeon.create!(:name => 'Despair', :levels => 4)
        d2 = Dungeon.create!(:name => 'Destard', :levels => 6)

        d1.create_evil_wizard(:name => 'David Blaine', :magic_school => 'stage', :experience_points => 450)

        post :create, :dungeon => @invalid_params

        assigns(:dungeons).should include(d2)
        assigns(:dungeons).should_not include(d1)
      end
    end
  end

  context "show" do
    it "should show the requested evil wizard" do
      get :show, :id => @evil_wizard.to_param
      response.should be_success
      assigns(:evil_wizard).should == @evil_wizard
    end
  end

  context "edit" do
    it "should get edit for the requested evil wizard" do
      get :edit, :id => @evil_wizard.to_param
      response.should be_success
      assigns(:evil_wizard).should == @evil_wizard
    end

    it "should fetch a list of dungeons" do
      get :edit, :id => @evil_wizard.to_param
      assigns(:dungeons).should_not be_nil
    end

    it "the dungeons fetched should be dungeons without an evil wizard and the dungeon of the requested evil wizard" do
      d1 = Dungeon.create!(:name => 'Despair', :levels => 4)
      d2 = Dungeon.create!(:name => 'Destard', :levels => 6)

      d1.create_evil_wizard(:name => 'David Blaine', :magic_school => 'stage', :experience_points => 450)

      get :edit, :id => @evil_wizard.to_param

      assigns(:dungeons).should include(d2)
      assigns(:dungeons).should_not include(d1)
      assigns(:dungeons).should include(@evil_wizard.dungeon)
    end
  end

  context "update" do
    context "with valid params" do
      it "should update evil_wizard" do
        put :update, :id => @evil_wizard.to_param, :evil_wizard => @evil_wizard.attributes
        response.should redirect_to(evil_wizard_path(assigns(:evil_wizard)))
      end
    end

    context "with invalid params" do
      before :each do
        @invalid_params = @evil_wizard.attributes.merge('experience_points' => "2000")
      end

      it "should not update evil wizard" do
        put :update, :id => @evil_wizard.to_param, :evil_wizard => @invalid_params
        response.should be_success
        @evil_wizard.reload.experience_points.should == 1
      end

      it "should leave the broken evil wizard available to the view" do
        put :update, :id => @evil_wizard.to_param, :evil_wizard => @invalid_params
        assigns(:evil_wizard).experience_points.should == 2000
        assigns(:evil_wizard).errors.should_not be_empty
      end

      it "should fetch a list of dungeons during update" do
        put :update, :id => @evil_wizard.to_param, :evil_wizard => @invalid_params
        assigns(:dungeons).should_not be_nil
      end

      it "the dungeons fetcheds should be dungeons without an evil wizard and the dungeon of the requested evil wizard" do
        d1 = Dungeon.create!(:name => 'Despair', :levels => 4)
        d2 = Dungeon.create!(:name => 'Destard', :levels => 6)

        d1.create_evil_wizard(:name => 'David Blaine', :magic_school => 'stage', :experience_points => 450)

        put :update, :id => @evil_wizard.to_param, :evil_wizard => @evil_wizard.attributes.merge('experience_points' => "2000")

        assigns(:dungeons).should include(d2)
        assigns(:dungeons).should_not include(d1)
        assigns(:dungeons).should include(@evil_wizard.dungeon)
      end
    end
  end

  context "destroy" do
    it "should destroy evil wizard" do
      lambda {
        delete :destroy, :id => @evil_wizard.to_param
      }.should change(EvilWizard, :count).by(-1)

      response.should redirect_to(evil_wizards_path)
    end
  end
end
