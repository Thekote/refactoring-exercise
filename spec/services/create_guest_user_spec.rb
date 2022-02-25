require 'rails_helper'

RSpec.describe CreateGuestUser, type: :controller do
  describe '#call' do
      context 'when cart user is nil but has user params' do
        let(:cart) { create(:cart, user: nil) }
        let(:user_params) { create(:user).attributes }  
        
        it 'creates a guest user with user params' do
          guest_user = CreateGuestUser.call(cart: cart, purchase_params: { user: user_params })

          expect(guest_user.attributes).to include({ 
            'email' => 'user@spec.io', 
            'first_name' => 'John',
            'last_name' => 'Doe',
            'guest' => true
          })

      end

      context 'when cart user is nil but has no user params' do
        let(:cart) { create(:cart, user: nil) }
        
        it 'raises an exception' do
          guest_user = CreateGuestUser.call(cart: cart, purchase_params: {})
      
          expect(guest_user.valid?).to be(false)

        end
      end
      
      context 'when cart user is present' do
        let(:cart) { create(:cart) }

        it 'it returns user with guest attribute as false' do
          cart_user = CreateGuestUser.call(cart: cart, purchase_params: { user: cart.user })

          expect(cart_user.attributes).to include({ 'guest' => false })
        end
      end                                 
    end  
  end
end
