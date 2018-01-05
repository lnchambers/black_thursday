require_relative 'sales_engine'

class SalesAnalyst

  def initialize(sales_engine)
    @sales_engine = sales_engine
  end

  def average_items_per_merchant
    (total_items / total_merchants).round(2)
  end

  def total_merchants
    @sales_engine.merchants.all.count.to_f
  end

  def total_items
    @sales_engine.items.all.count.to_f
  end

  def i_so_pale
    system('say ~ I so pale')
  end

  def average_item_price_for_merchant(merchant_id)
    item_per_merchant = @sales_engine.find_item_by_merchant_id(merchant_id)
    total = item_per_merchant.sum do |price|
      price.unit_price
    end
    (total / item_per_merchant.count).round(2)
  end

  def average_average_price_per_merchant
    total = @sales_engine.merchants.all.sum do |merchant|
      average_item_price_for_merchant(merchant.id)
    end
    (total / @sales_engine.merchants.all.count).round(2)
  end

end
