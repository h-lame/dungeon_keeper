require 'test_helper'

class TrapsControllerTest < ActionController::TestCase
  setup do
    @trap = traps(:one)
  end

  context "index" do
    setup do
      get :index
    end

    should respond_with(:success)
    should assign_to(:traps)
  end

  context "new" do
    setup do
      get :new
    end

    should respond_with(:success)
  end

  context "create" do
    setup do
      @trap.destroy
    end

    context "with valid params" do
      setup do
        post :create, :trap => @trap.attributes
      end

      should redirect_to("the show page for the newly created trap") { trap_path(assigns(:trap)) }
      should_change("the number of traps", :by => 1) { Trap.count }
    end

    context "with invalid params" do
      setup do
        post :create, :trap => @trap.attributes.except('name')
      end

      should_not_change("the number of traps") { Trap.count }
      should respond_with(:success)

      should "leave the broken trap available to the view if params are wrong during create" do
        assert assigns(:trap).name.blank?
        refute_empty assigns(:trap).errors
      end
    end
  end

  context "show" do
    setup do
      get :show, :id => @trap.to_param
    end

    should respond_with(:success)
    should "assign the correct trap" do
      assert_equal @trap, assigns(:trap)
    end
  end

  context "edit" do
    setup do
      get :edit, :id => @trap.to_param
    end

    should respond_with(:success)
    should "assign the correct trap" do
      assert_equal @trap, assigns(:trap)
    end
  end

  context "update" do
    context "with valid params" do
      setup do
        put :update, :id => @trap.to_param, :trap => @trap.attributes.merge('base_damage_caused' => "60")
      end

      should redirect_to("the show page for the newly updated trap") { trap_path(assigns(:trap)) }
      should "update the trap in question" do
        assert_equal 60, @trap.reload.base_damage_caused
      end
    end

    context "with invalid params" do
      setup do
        put :update, :id => @trap.to_param, :trap => @trap.attributes.merge('base_damage_caused' => "-1")
      end

      should respond_with(:success)
      should "not update the trap in question" do
        assert_equal 20, @trap.reload.base_damage_caused
      end
      should "leave the broken trap available to the view if params are wrong during update" do
        assert_equal -1, assigns(:trap).base_damage_caused
        refute_empty assigns(:trap).errors
      end
    end
  end

  context "destroy" do
    setup do
      delete :destroy, :id => @trap.to_param
    end

    should_change("the number of traps", :by => -1) { Trap.count }
    should redirect_to("the list of the traps") { traps_path }
  end
end
