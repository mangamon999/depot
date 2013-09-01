require 'test_helper'

class LineItemsControllerTest < ActionController::TestCase
  fixtures :line_items, :products

  setup do
    @line_item = line_items(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:line_items)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create line item" do
    assert_difference "LineItem.count" do
      post :create, product_id: products(:ruby).id
    end

    assert_redirected_to cart_path(assigns(:line_item).cart)
  end

  test "should not create new line item if product added again" do

    session[:cart_id] = carts(:my_cart).id

    assert_no_difference "LineItem.count" do
      post :create, product_id: carts(:my_cart).line_items.first.product_id
    end

    assert_redirected_to cart_path(assigns(:line_item).cart)
  end

  test "should update line item quantity if product is addeed again" do

    session[:cart_id] = carts(:my_cart).id
    list_item = carts(:my_cart).line_items.first
    initial_quantity = list_item.quantity

    post :create, product_id: carts(:my_cart).line_items.first.product_id

    list_item.reload
    assert_equal list_item.quantity, initial_quantity + 1

    assert_redirected_to cart_path(assigns(:line_item).cart)
  end


  test "should show line_item" do
    get :show, id: @line_item
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @line_item
    assert_response :success
  end

  test "should update line_item" do
    patch :update, id: @line_item, line_item: { cart_id: @line_item.cart_id, product_id: @line_item.product_id }
    assert_redirected_to line_item_path(assigns(:line_item))
  end

  test "should destroy line_item" do
    assert_difference('LineItem.count', -1) do
      delete :destroy, id: @line_item
    end

    assert_redirected_to line_items_path
  end
end
