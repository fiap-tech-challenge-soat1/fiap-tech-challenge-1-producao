class Pedido < ApplicationRecord
  enum status: {"recebido" => 0, "em_preparacao" => 1, "pronto" => 2, "finalizado" => 3}

  validates :num_pedido, presence: true
  validates :status, presence: true
end
