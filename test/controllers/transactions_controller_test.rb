require "test_helper"

class TransactionsControllerTest < ActionController::TestCase

  before do
    @transaction = transactions(:one)
  end

  def test_index
    get :index
    assert_response :success
    assert_not_nil assigns(:transactions)
  end

  def test_new
    get :new
    assert_response :success
  end

  def test_create
    assert_difference('Transaction.count') do
      post :create, transaction: {  }
    end

    assert_redirected_to transaction_path(assigns(:transaction))
  end

  def test_show
    get :show, id: @transaction
    assert_response :success
  end

  def test_edit
    get :edit, id: @transaction
    assert_response :success
  end

  def test_update
    put :update, id: @transaction, transaction: {  }
    assert_redirected_to transaction_path(assigns(:transaction))
  end

  def test_destroy
    assert_difference('Transaction.count', -1) do
      delete :destroy, id: @transaction
    end

    assert_redirected_to transactions_path
  end
end
