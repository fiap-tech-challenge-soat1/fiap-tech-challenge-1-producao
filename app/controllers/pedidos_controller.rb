class PedidosController < ApplicationController
  before_action :set_pedido, only: [:update]

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
    return render "show", status: :ok if @pedido.update(status: params[:status])

    head :unprocessable_entity
  end

  private

  def set_pedido
    @pedido = Pedido.find_by!(num_pedido: params[:num_pedido])
  end

  def pedido_params
    params.permit(:num_pedido, :status)
  end
end
