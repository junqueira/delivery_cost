require 'test_helper'

class MapasControllerTest < ActionController::TestCase
  setup do
    @mapa = mapas(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:mapas)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create mapa" do
    assert_difference('Mapa.count') do
      post :create, mapa: { nome: 'ruby' }
    end

    assert_redirected_to mapa_path(assigns(:mapa))
  end

  test "should show mapa" do
    get :show, id: @mapa
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @mapa
    assert_response :success
  end

  test "should update mapa" do
    patch :update, id: @mapa, mapa: { nome: @mapa.nome }
    assert_redirected_to mapa_path(assigns(:mapa))
  end

  test "should destroy mapa" do
    assert_difference('Mapa.count', -1) do
      delete :destroy, id: @mapa
    end

    assert_redirected_to mapas_path
  end
end
