class AssignOrderItems
  def initialize(order:, cart:, **options)
    @order = order
    @cart = cart
    @shipping_costs = options[:shipping_costs]
  end

  def self.call(order:, cart:, **options)
    new(order: order, cart: cart, **options).call
  end

  def call
    return unless @cart.items
    @cart.items.each do |item|
      item.quantity.times do
        @order.items << OrderLineItem.new(
          order: @order,
          sale: item.sale,
          unit_price_cents: item.sale.unit_price_cents,
          shipping_costs_cents: @shipping_costs,
          paid_price_cents: item.sale.unit_price_cents + @shipping_costs
        )
      end
    end
  end
end
