class CreateGuestUser
  def initialize(cart:, **options)
    @cart = cart
    @purchase_params = options[:purchase_params]
  end

  def self.call(cart:, **options)
    new(cart: cart, **options).call
  end

  def call
    if @cart.user.nil?
      user_params = @purchase_params[:user] ? @purchase_params[:user] : {}
      User.create(**user_params.merge(guest: true))
    else
      @cart.user
    end
  end

end
