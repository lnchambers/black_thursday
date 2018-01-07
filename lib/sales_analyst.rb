require_relative 'sales_engine'
require_relative 'merchant_analyst'
require_relative 'item_analyst'
require_relative 'invoice_analyst'

class SalesAnalyst
  include MerchantAnalyst
  include ItemAnalyst
  include InvoiceAnalyst

  def initialize(sales_engine)
    @sales_engine = sales_engine
  end

  def average_items_per_merchant
    (total_items / total_merchants).round(2)
  end

  def mean_calculation_merchant(merchant)
    (total_items_per_merchant - average_items_per_merchant) ** 2
  end

  def average_items_per_merchant_standard_deviation
    calculate_stdev(merchant_mean)
  end

  def merchants_with_high_item_count
    merchant_stdev = average_items_per_merchant_standard_deviation
    all_merchants.values.find_all do |merchant|
      merchant.items.count > (merchant_stdev * 2)
    end
  end

  def average_item_price_standard_deviation
    Math.sqrt(calculate_item_stdev).round(2)
  end

  def golden_items
    item_stdev = calculate_item_stdev
    item_mean = item_price_mean
    all_items.values.find_all do |item|
      item.unit_price > (item_mean + item_stdev * 2)
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

  def average_invoices_per_merchant
    (total_invoices / total_merchants).round(2)
  end

  def average_invoices_per_merchant_standard_deviation
    calculate_invoice_stdev
  end

  def top_merchants_by_invoice_count
    stdev = calculate_invoice_stdev
    mean = invoice_mean
    all_merchants.values.find_all do |merchant|
      merchant.invoices.count > mean + stdev * 2
    end
  end

  def bottom_merchants_by_invoice_count
    stdev = calculate_invoice_stdev
    mean = invoice_mean
    all_merchants.values.find_all do |merchant|
      merchant.invoices.length < mean - stdev * 2
    end
  end

  def top_days_by_invoice_count
    stdev = calculate_invoice_day_stdev
    mean = invoice_day_mean
    all_invoices.values.find_all do |invoice|
      invoice.created_at > mean + stdev * 2
    end
  end

end
