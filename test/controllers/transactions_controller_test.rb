require "test_helper"

class TransactionsControllerTest < ActionController::TestCase

  #before do
  #  @transaction = transactions(:one)
  #end

  test "should get balance sheet" do
    sign_in users(:one)

    tr = Transaction.new(:amount => 100, :credit_account_id => accounts(:one).id, :debit_account_id => accounts(:two).id)
    tr.save()
    tr = Transaction.new(:amount => 120, :credit_account_id => accounts(:two).id, :debit_account_id => accounts(:one).id)
    tr.save()
    tr = Transaction.new(:amount => 1123, :credit_account_id => accounts(:two).id, :debit_account_id => accounts(:two).id)
    tr.save()
    tr = Transaction.new(:amount => 11, :credit_account_id => accounts(:one).id, :debit_account_id => accounts(:one).id)
    tr.save()
    get :balance_sheet
    assert_response :success

    assets = assigns['assets']
    other  = assigns['other']

    assert_equal assets, other
  end

end
__END__
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
