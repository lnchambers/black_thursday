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

  # def items_per_merchant TODO
  #   @sales_engine.merchants.map do |merchant|
  #
  # end

  def average_items_per_merchant_standard_deviation
    mean = merchants.all.map do |merchant|
     mean_calculation(merchant)
    end
    total_div = mean.count - 1
    variance = mean.sum / total_div
    stdev = Math.sqrt(variance).round(2)
  end

  def average_item_price_for_merchant(merchant_id)
    item_per_merchant = @sales_engine.find_item_by_merchant_id(merchant_id)
    total = item_per_merchant.sum do |price|
      price.unit_price
    end
    (total / item_per_merchant.count).round(2)
  end

  def average_average_price_per_merchant
    total = merchants.all.sum do |merchant|
      average_item_price_for_merchant(merchant.id)
    end
    (total / merchants.all.count).round(2)
  end

  def merchants
    @sales_engine.merchants
  end

  def items
    @sales_engine.items
  end

  def mean_calculation(merchant)
    (items.find_all_by_merchant_id(merchant.id).count - average_items_per_merchant) ** 2
  end
end
