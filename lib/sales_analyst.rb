require_relative 'sales_engine'
require_relative 'merchant_analyst_mod'
require_relative 'item_analyst_mod'

class SalesAnalyst
  include MerchantAnalyst
  include ItemAnalyst

  def initialize(sales_engine)
    @sales_engine = sales_engine
  end

  def average_items_per_merchant
    (total_items / total_merchants).round(2)
  end

  def mean_calculation_merchant(merchant)
    (items.find_all_by_merchant_id(merchant.id).count - average_items_per_merchant) ** 2
  end

  def average_items_per_merchant_standard_deviation
    mean = merchants.all.map do |merchant|
      mean_calculation_merchant(merchant)
    end
    calculate_stdev(mean)
  end

  def merchants_with_high_item_count
    all_merchants.values.find_all do |merchant|
      merchant.items.count > (average_items_per_merchant_standard_deviation * 2)
    end
  end

  def average_item_price_standard_deviation
    Math.sqrt(item_stdev).round(2)
  end

  def golden_items
    mean = all_items_price / total_items
    all_items.values.find_all do |item|
      item.unit_price > (mean + average_item_price_standard_deviation * 2)
    end
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

  def calculate_stdev(mean)
    variance = mean.sum / (mean.count - 1)
    Math.sqrt(variance).round(2)
  end
end
