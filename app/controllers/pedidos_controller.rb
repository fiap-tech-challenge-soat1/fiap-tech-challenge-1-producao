class PedidosController < ApplicationController
  before_action :set_pedido, only: [:update]

  def index
    @pedidos = Pedido.all
    render "index"
  end

  def create
    @pedido = Pedido.new(create_params)

    if @pedido.save!
      render "show", status: :created
    end
  end

  def update
    return render "show", status: :ok if @pedido.update(update_params)

    head :unprocessable_entity
  end

  private

  def set_pedido
    @pedido = Pedido.find_by!(num_pedido: params[:num_pedido])
  end

  def create_params
    params.permit(:num_pedido, itens_attributes: [:nome, :quantidade, :observacao]).merge(status: Pedido::DEFAULT_STATUS)
  end

  def update_params
    params.permit(:num_pedido)
  end
end
