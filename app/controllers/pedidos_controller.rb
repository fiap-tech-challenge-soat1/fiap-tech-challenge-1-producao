class PedidosController < ApplicationController
  def index
    head :ok
  end

  def create
    pedido = Pedido.new(pedido_params.merge(status: :recebido))
    if pedido.save!
      render json: pedido
    end
  end

  def update
  end

  private

  def pedido_params
    params.permit(:num_pedido, :status)
  end
end
