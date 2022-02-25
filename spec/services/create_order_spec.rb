require 'rails_helper'

RSpec.describe CreateOrder, type: :controller do
  describe '#call' do
    let!(:order) { create(:order) }
    #let(:order_params) { create(:order, user: order.user).attributes }

    it 'creates an order with an user and address params' do
      new_order = CreateOrder.call(user: order.user, address_params: {})

      expect(new_order.attributes).to include({ 
        'user_id' => order.user.id, 
        'first_name' => order.user.first_name,
        'last_name' => order.user.last_name,
        'address_1' => nil,
        'address_2' => nil, 
        'city' => nil,
        'state' => nil,
        'country' => nil,
        'zip' => nil
      })
    end
  end
end