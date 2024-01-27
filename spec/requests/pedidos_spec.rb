require "rails_helper"

RSpec.describe "Pedidos", type: :request do
  describe "Producao API" do
    path "/" do
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
    end
  end
end
