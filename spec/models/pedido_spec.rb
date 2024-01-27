require "rails_helper"

RSpec.describe Pedido do
  describe "validations" do
    it { is_expected.to validate_presence_of(:num_pedido) }
    it { is_expected.to validate_presence_of(:status) }
    it { is_expected.to validate_uniqueness_of(:num_pedido) }
  end

  describe "#notificar_pedidos_api" do
    context "quando o pedido é atualizado para outro status diferente de finalizado" do
      it "nao notifica a api de pedidos" do
        pedido = create(:pedido, status: :recebido)

        pedidos_api = instance_double(PedidosApi::Client)
        allow(pedidos_api).to receive(:notificar).with(pedido.num_pedido)

        pedido.em_preparacao!
        expect(pedidos_api).not_to have_received(:notificar)
      end
    end

    context "quando o pedido é atualizado para finalizado" do

      it "notifica a api de pedidos" do
        pedido = create(:pedido, status: :recebido)

        # Stub the HTTP request with WebMock
        stub_request(:post, "http://api.pedidos.com/pedidos/#{pedido.num_pedido}/finalizar")
          .to_return(status: 201, body: {}.to_json)

        expect_any_instance_of(PedidosApi::Client).to receive(:notificar).with(pedido.num_pedido)

        pedido.finalizado!
      end
    end
  end
end
