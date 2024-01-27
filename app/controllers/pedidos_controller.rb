class PedidosController < ApplicationController
  def index
    @pedidos = Pedido.all
    render "index"
  end

  def create
    @pedido = Pedido.new(pedido_params)

    if @pedido.save!
      render "show", status: :created
    end
  end

  def update
  end

  private

  def pedido_params
    params.permit(:num_pedido, :status)
  end
end
