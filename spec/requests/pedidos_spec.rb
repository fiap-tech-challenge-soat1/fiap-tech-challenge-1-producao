require "rails_helper"

RSpec.describe "Pedidos" do
  describe "Producao API" do
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
  end
end
