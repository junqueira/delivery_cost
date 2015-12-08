class Mapa < ActiveRecord::Base
  validates :nome, presence: true, uniqueness: true

  has_many :rotas

  accepts_nested_attributes_for :rotas, allow_destroy: true
end
