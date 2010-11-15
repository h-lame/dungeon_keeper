require 'spec_helper'

shared_examples_for 'a scoped trap installations controller' do

  context "index" do
    it "should respond successfully" do
      get :index, @scoping_params
      response.should be_success
      assigns(:trap_installations).should_not be_nil
    end

    it "should fetch only the trap installations that belong to the scope" do
      get :index, @scoping_params

      assigns(:trap_installations).should include(@trap_installation)
      assigns(:trap_installations).should_not include(trap_installations(:two))
    end
  end

  context "new" do
    it "should get new" do
      get :new, @scoping_params
      response.should be_success
    end
  end

  context "create" do
    context "with valid params" do
      it "should create trap installation and redirect to scoped show page" do
        lambda {
          post :create, {:trap_installation => @trap_installation.attributes}.merge(@scoping_params)
        }.should change(TrapInstallation, :count).by(1)

        response.should redirect_to([@scope, assigns(:trap_installation)])
      end
    end

    context "with invalid params" do
      before :each do
        @invalid_params = @trap_installation.attributes.except('size')
      end

      it "should not create trap installation" do
        lambda {
          post :create, {:trap_installation => @invalid_params}.merge(@scoping_params)
        }.should_not change(TrapInstallation, :count)

        response.should be_success
      end

      it "should leave the broken trap installation available to the view" do
        post :create, {:trap_installation => @invalid_params}.merge(@scoping_params)

        assigns(:trap_installation).size.should be_blank
        assigns(:trap_installation).errors.should_not be_empty
      end
    end
  end

  context "show" do
    it "should show the requested trap installation" do
      get :show, {:id => @trap_installation.to_param}.merge(@scoping_params)
      response.should be_success
      assigns(:trap_installation).should == @trap_installation
    end

    it "should 404 if the requested trap installation isn't owned by the supplied scope" do
      lambda {
        get :show, {:id => trap_installations(:two).to_param}.merge(@scoping_params)
      }.should raise_error(ActiveRecord::RecordNotFound)
      # we'd prefer to do
      # response.code.should == "404"
      # without the assert_raises block, but it doesn't work
    end
  end

  context "edit" do
    it "should get edit for the requested trap installation" do
      get :edit, {:id => @trap_installation.to_param}.merge(@scoping_params)
      response.should be_success
      assigns(:trap_installation).should == @trap_installation
    end

    it "should 404 on edit if the requested trap installation isn't in the supplied dungeon" do
      lambda {
        get :edit, {:id => trap_installations(:two).to_param}.merge(@scoping_params)
      }.should raise_error(ActiveRecord::RecordNotFound)
    end
  end

  context "update" do
    it "should 404 if the requested trap_installation does not belong to the supplied scope" do
      lambda {
        put :update, {:id => trap_installations(:two).to_param, :trap_installation => @trap_installation.attributes}.merge(@scoping_params)
      }.should raise_error(ActiveRecord::RecordNotFound)
    end

    context "with valid params" do
      it "should update trap_installation" do
        put :update, {:id => @trap_installation.to_param, :trap_installation => @trap_installation.attributes}.merge(@scoping_params)
        response.should redirect_to([@scope, assigns(:trap_installation)])
      end
    end

    context "with invalid params" do
      before :each do
        @invalid_params = @trap_installation.attributes.merge('level' => "-1")
      end

      it "should not update trap installation" do
        put :update, {:id => @trap_installation.to_param, :trap_installation => @invalid_params}.merge(@scoping_params)
        response.should be_success
        @trap_installation.reload.level.should == 1
      end

      it "should leave the broken trap installation available to the view" do
        put :update, {:id => @trap_installation.to_param, :trap_installation => @invalid_params}.merge(@scoping_params)
        assigns(:trap_installation).level.should == -1
        assigns(:trap_installation).errors.should_not be_empty
      end
    end
  end

  context "destroy" do
    it "should destroy trap installation" do
      lambda {
        delete :destroy, {:id => @trap_installation.to_param}.merge(@scoping_params)
      }.should change(TrapInstallation, :count).by(-1)

      response.should redirect_to([@scope, :trap_installations])
    end

    it "should 404 and not destroy the trap installation if it's not in the supplied dungeon" do
      lambda {
        lambda {
          delete :destroy, {:id => trap_installations(:two).to_param}.merge(@scoping_params)
        }.should raise_error(ActiveRecord::RecordNotFound)
      }.should_not change(TrapInstallation, :count)
    end
  end
end

describe TrapInstallationsController do
  fixtures :all

  context "when scoped by a trap" do
    before :each do
      @scope = @trap = traps(:one)
      @scoping_params = {:trap_id => @trap.to_param}
      @trap_installation = trap_installations(:one)
    end

    it_should_behave_like 'a scoped trap installations controller'

    context "new" do
      it "should prepare the trap installation to be scoped to the supplied trap" do
        get :new, :trap_id => @trap.to_param

        assigns(:trap_installation).trap.should == @trap
      end

      it "should fetch a list of dungeons" do
        get :new, :trap_id => @trap.to_param
        assigns(:dungeons).should_not be_nil
      end

      it "should not fetch a list of traps" do
        get :new, :trap_id => @trap.to_param
        assigns(:traps).should be_nil
      end
    end

    context "create" do
      it "should create trap installation scoped to supplied trap even when no trap_id supplied in trap_installation params" do
        post :create, :trap_installation => @trap_installation.attributes.except('trap_id'), :trap_id => @trap.to_param

        assigns(:trap_installation).trap.should == @trap
      end

      it "should create trap installation scoped to supplied trap even when if an alternative trap_id is supplied in trap_installation params" do
        post :create, :trap_installation => @trap_installation.attributes.merge('trap_id' => traps(:two).id), :trap_id => @trap.to_param

        assigns(:trap_installation).trap.should == @trap
      end

      context "with invalid params" do
        before :each do
          @invalid_params = @trap_installation.attributes.except('size')
        end

        it "should fetch a list of dungeons" do
          post :create, :trap_installation => @invalid_params, :trap_id => @trap.to_param
          assigns(:dungeons).should_not be_nil
        end

        it "should not fetch a list of traps" do
          post :create, :trap_installation => @invalid_params, :trap_id => @trap.to_param
          assigns(:traps).should be_nil
        end
      end
    end

    context "edit" do
      it "should fetch a list of dungeons" do
        get :edit, :id => @trap_installation.to_param, :trap_id => @trap.to_param
        assigns(:dungeons).should_not be_nil
      end

      it "should not fetch a list of traps" do
        get :edit, :id => @trap_installation.to_param, :trap_id => @trap.to_param
        assigns(:traps).should be_nil
      end
    end

    context "update" do
      it "should ignore any attempted to change the trap parameters" do
        put :update, :id => @trap_installation.to_param, :trap_installation => @trap_installation.attributes.merge('trap_id' => traps(:two).id), :trap_id => @trap.to_param
        assigns(:trap_installation).trap.should == @trap
        @trap_installation.reload.trap.should == @trap
      end

      context "with invalid params" do
        before :each do
          @invalid_params = @trap_installation.attributes.merge('level' => "-1")
        end

        it "should fetch a list of dungeons" do
          put :update, :id => @trap_installation.to_param, :trap_installation => @invalid_params, :trap_id => @trap.to_param

          assigns(:dungeons).should_not be_nil
        end

        it "should not fetch a list of traps" do
          put :update, :id => @trap_installation.to_param, :trap_installation => @invalid_params, :trap_id => @trap.to_param

          assigns(:traps).should be_nil
        end
      end
    end
  end

  context "when scoped by a dungeon" do
    before :each do
      @scope = @dungeon = dungeons(:one)
      @scoping_params = {:dungeon_id => @dungeon.to_param}
      @trap_installation = trap_installations(:one)
    end

    it_should_behave_like 'a scoped trap installations controller'

    context "new" do
      it "should prepare the trap installation to be scoped to the supplied dungeon" do
        get :new, :dungeon_id => @dungeon.to_param

        assigns(:trap_installation).dungeon.should == @dungeon
      end

      it "should not fetch a list of dungeons" do
        get :new, :dungeon_id => @dungeon.to_param
        assigns(:dungeons).should be_nil
      end

      it "should fetch a list of traps" do
        get :new, :dungeon_id => @dungeon.to_param
        assigns(:traps).should_not be_nil
      end
    end

    context "create" do
      it "should create trap installation scoped to supplied dungeon even when no dungeon_id supplied in trap_installation params" do
        post :create, :trap_installation => @trap_installation.attributes.except('dungeon_id'), :dungeon_id => @dungeon.to_param

        assigns(:trap_installation).dungeon.should == @dungeon
      end

      it "should create trap installation scoped to supplied dungeon even when if an alternative dungeon_id is supplied in trap_installation params" do
        post :create, :trap_installation => @trap_installation.attributes.merge('dungeon_id' => dungeons(:two).id), :dungeon_id => @dungeon.to_param

        assigns(:trap_installation).dungeon.should == @dungeon
      end

      context "with invalid params" do
        before :each do
          @invalid_params = @trap_installation.attributes.except('size')
        end

        it "should not fetch a list of dungeons" do
          post :create, :trap_installation => @invalid_params, :dungeon_id => @dungeon.to_param
          assigns(:dungeons).should be_nil
        end

        it "should fetch a list of traps" do
          post :create, :trap_installation => @invalid_params, :dungeon_id => @dungeon.to_param
          assigns(:traps).should_not be_nil
        end
      end
    end

    context "edit" do
      it "should not fetch a list of dungeons" do
        get :edit, :id => @trap_installation.to_param, :dungeon_id => @dungeon.to_param
        assigns(:dungeons).should be_nil
      end

      it "should fetch a list of traps" do
        get :edit, :id => @trap_installation.to_param, :dungeon_id => @dungeon.to_param
        assigns(:traps).should_not be_nil
      end
    end

    context "update" do
      it "should ignore any attempted to change the dungeon parameters" do
        put :update, :id => @trap_installation.to_param, :trap_installation => @trap_installation.attributes.merge('dungeon_id' => dungeons(:two).id), :dungeon_id => @dungeon.to_param
        assigns(:trap_installation).dungeon.should == @dungeon
        @trap_installation.reload.dungeon.should == @dungeon
      end

      context "with invalid params" do
        before :each do
          @invalid_params = @trap_installation.attributes.merge('level' => "-1")
        end

        it "should not fetch a list of dungeons" do
          put :update, :id => @trap_installation.to_param, :trap_installation => @invalid_params, :dungeon_id => @dungeon.to_param
          assigns(:trap_installation).dungeon.should == @dungeon
          assigns(:dungeons).should be_nil
        end

        it "should fetch a list of traps during" do
          put :update, :id => @trap_installation.to_param, :trap_installation => @invalid_params, :dungeon_id => @dungeon.to_param
          assigns(:trap_installation).dungeon.should == @dungeon
          assigns(:traps).should_not be_nil
        end
      end
    end
  end
end
