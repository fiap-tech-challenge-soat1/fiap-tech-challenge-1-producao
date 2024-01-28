require "rails_helper"

RSpec.describe "Pedidos" do
  path "/pedidos" do
    get "Listar pedidos em producao" do
      tags "Producao"
      consumes "application/json"
      produces "application/json"
      response "200", "lista de pedidos em producao" do
        schema type: :array,
          items: {
            type: :object,
            properties: {
              num_pedido: {type: :integer},
              status: {type: :string}
            },
            required: %w[num_pedido status]
          }
        run_test!
      end
    end

    post "Enviar pedido para producao" do
      tags "Producao"
      consumes "application/json"
      produces "application/json"
      parameter name: :pedido_params, in: :body, required: true, schema: {
        type: :object,
        properties: {
          num_pedido: {type: :integer},
          status: {type: :string}
        },
        required: %w[num_pedido status]
      }

      response "201", "Pedido enviado para producao com sucesso" do
        let(:pedido_params) { {num_pedido: 123, status: "recebido"} }
        run_test!
      end

      response "422", "Unprocessable Entity" do
        before do
          create(:pedido, num_pedido: 123, status: "recebido")
        end

        let(:pedido_params) { {num_pedido: 123, status: "recebido"} }
        run_test!
      end
    end
  end

  path "/pedidos/{num_pedido}" do
    parameter name: :num_pedido, in: :path, type: :integer, description: "Número do Pedido"

    put "Atualizar status do pedido" do
      tags "Producao"
      consumes "application/json"
      produces "application/json"
      parameter name: :status, in: :query, type: :string, description: "Novo status do pedido", required: true

      response "200", "Status do pedido atualizado com sucesso" do
        let(:pedido) { create(:pedido, status: "recebido") }
        let(:num_pedido) { pedido.num_pedido }
        let(:status) { "em_preparacao" }

        run_test!
      end

      response "404", "Pedido não encontrado" do
        let(:num_pedido) { 999 } # Assuming 999 is an invalid num_pedido
        let(:status) { "recebido" }

        run_test!
      end

      response "422", "Unprocessable Entity" do
        let(:pedido) { create(:pedido) }
        let(:num_pedido) { pedido.num_pedido }
        let(:status) { nil } # Invalid status, assuming it's required

        run_test!
      end
    end
  end
end
