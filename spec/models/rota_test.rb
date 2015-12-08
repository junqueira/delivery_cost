require 'test_helper'

class RotaTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "should not save rota without origem" do
    rota = Rota.new()
    rota.valid?
    assert rota.errors.include?(:origem)
  end

  test "should not save rota without destino" do
    rota = Rota.new()
    rota.valid?
    assert rota.errors.include?(:destino)
  end

  test "should not save rota without mapa_id" do
    rota = Rota.new()
    rota.valid?
    assert rota.errors.include?(:mapa_id)
  end
end
