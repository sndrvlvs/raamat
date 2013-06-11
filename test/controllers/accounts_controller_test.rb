require "test_helper"

class AccountsControllerTest < ActionController::TestCase

  before do
    @account = accounts(:one)
  end
end
__END__
  def test_index
    @request.env["devise.mapping"] = Devise.mappings[:user]
    get :index
    assert_response :success
    assert_not_nil assigns(:accounts)
  end

  def test_new
    get :new
    assert_response :success
  end

  def test_create
    assert_difference('Account.count') do
      post :create, account: {  }
    end

    assert_redirected_to account_path(assigns(:account))
  end

  def test_show
    get :show, id: @account
    assert_response :success
  end

  def test_edit
    get :edit, id: @account
    assert_response :success
  end

  def test_update
    put :update, id: @account, account: {  }
    assert_redirected_to account_path(assigns(:account))
  end

  def test_destroy
    assert_difference('Account.count', -1) do
      delete :destroy, id: @account
    end

    assert_redirected_to accounts_path
  end
end
