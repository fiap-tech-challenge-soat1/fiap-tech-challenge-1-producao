class Pedido < ApplicationRecord
  enum status: {
    "recebido" => 0,
    "em_preparacao" => 1,
    "pronto" => 2,
    "finalizado" => 3
  }

  DEFAULT_STATUS = "recebido"

  validates :num_pedido, presence: true, uniqueness: true
  validates :status, presence: true

  after_update :notificar_pedidos_api, if: :finalizado?

  has_many :itens, class_name: "Item", dependent: :destroy
  accepts_nested_attributes_for :itens

  private

  def notificar_pedidos_api
    pedidos_api = PedidosApi::Client.new
    pedidos_api.notificar(num_pedido)
  end
end
