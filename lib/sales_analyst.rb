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

  def average_items_per_merchant_standard_deviation
    mean = merchants.all.map do |merchant|
      mean_calculation_merchant(merchant)
    end
    calculate_stdev(mean)
  end

  def merchants_with_high_item_count
    merchants.merchants.values.find_all do |merchant|
      merchant.items.count > (average_items_per_merchant_standard_deviation * 2)
    end
  end

  def golden_items
    items.items.values.find_all do |item|
      item.unit_price > ((average_item_price_standard_deviation * 2) * 2)
    end
  end

  def average_item_price_standard_deviation
    mean = items.all.map do |item|
      item.unit_price
    end
    calculate_stdev(mean)
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

  def mean_calculation_merchant(merchant)
    (items.find_all_by_merchant_id(merchant.id).count - average_items_per_merchant) ** 2
  end

  def calculate_stdev(mean)
    total_div = mean.count - 1
    variance = mean.sum / total_div
    Math.sqrt(variance).round(2)
  end
end
