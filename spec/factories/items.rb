FactoryBot.define do
  factory :item do
    pedido_id { nil }
    nome { "MyString" }
    observacao { "MyText" }
    quantidade { 1 }
  end
end
