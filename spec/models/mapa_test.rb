require 'test_helper'

class MapaTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "should not save mapa without name" do
    mapa = Mapa.new
    assert_not mapa.save
  end

  test "should have unique name" do
    mapa1 = Mapa.create(:nome => 'Ruby')
    assert mapa1.valid?, "Mapa was not valid #{mapa1.errors.inspect}"

    mapa2 = Mapa.new(:nome => 'Ruby')
    mapa2.valid?
    assert mapa2.errors.include?(:nome)
  end
end
