class Rota < ActiveRecord::Base
  belongs_to :mapa

  validates :origem, :destino, :distancia, :mapa_id, presence: true
  validates :origem, uniqueness: {scope: :destino}
  validates :distancia, numericality: {greater_than: 0}

  validate :duplicado

  private

  def duplicado
    errors.add(:origem, "já está em uso") unless Rota.find_by_origem_and_destino(destino, origem).blank?
  end
end
