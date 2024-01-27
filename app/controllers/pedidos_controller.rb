class PedidosController < ApplicationController
  def index
    @pedidos = Pedido.all
    render "index"
  end

  def create
    pedido = Pedido.new(
      num_pedido: pedido_params[:pedido],
      status: pedido_params[:status]
    )

    if pedido.save!
      render json: pedido, status: :ok
    end
  end

  def update
  end

  private

  def pedido_params
    params.permit(:pedido, :status)
  end
end
