require_relative 'sales_engine'
require_relative 'merchant_analyst'
require_relative 'item_analyst'
require_relative 'invoice_analyst'
require_relative 'standard_deviation'

class SalesAnalyst
  include MerchantAnalyst
  include ItemAnalyst
  include InvoiceAnalyst
  include StandardDeviation

  def initialize(sales_engine)
    @sales_engine = sales_engine
  end

  def average_items_per_merchant
    (total_items / total_merchants).round(2)
  end

  def mean_calculation_merchant(merchant)
    (total_items_per_merchant(merchant) - average_items_per_merchant) ** 2
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
    mean(total_invoices, total_merchants).round(2)
  end

  def average_invoices_per_merchant_standard_deviation
    calculate_invoice_stdev
  end

  def top_merchants_by_invoice_count
    stdev = calculate_invoice_stdev
    mean = mean(total_invoices, total_merchants)
    all_merchants.values.find_all do |merchant|
      merchant.invoices.count > mean + stdev * 2
    end
  end

  def bottom_merchants_by_invoice_count
    stdev = calculate_invoice_stdev
    mean = mean(total_invoices, total_merchants)
    all_merchants.values.find_all do |merchant|
      merchant.invoices.length < mean - stdev * 2
    end
  end

  def total_with_status(status)
    all_invoices.values.find_all do |invoice|
      invoice.status == status
    end
  end

  def top_days_by_invoice_count
    stdev = calculate_invoice_day_stdev
    mean = mean(total_invoices, 7)
    transform_get_days.keep_if do |key|
       transform_get_days[key] > mean + stdev
    end.keys
  end

  def total_revenue_by_date(date)
    get_invoice_items_for_revenue(date)[0].sum do |invoice_items|
      invoice_items.unit_price * invoice_items.quantity
    end
  end

  def get_invoices_for_revenue(date)
    all_invoices.values.find_all do |invoice|
      invoice.created_at.to_i == date.to_i
    end
  end

  def get_invoice_items_for_revenue(date)
    get_invoices_for_revenue(date).map do |invoice|
      @sales_engine.invoice_items.find_all_by_invoice_id(invoice.id)
    end
  end

  def revenue_by_merchant(id)
    @sales_engine.all_successful_transactions_by_merchant_id(id).sum do |invoice|
      invoice.total
    end
  end

  def merchants_ranked_by_revenue

  end

  def merchants_with_pending_invoices
    all_merchants.values.find_all do |merchant|
      find_invoices_per_merchant(merchant.id)
    end
  end

  def find_invoices_per_merchant(id)
    @sales_engine.find_invoices(id).any? do |invoice|
      !invoice.is_paid_in_full?
    end
  end

  def merchants_with_only_one_item
    all_merchants.values.find_all do |merchant|
      merchant.items.count == 1
    end
  end

  def merchants_with_only_one_item_registered_in_month(month)
    merchants_with_only_one_item.find_all do |merchant|
      merchant.created_at.strftime("%B") == month
    end
  end

  def most_sold_item_for_merchant(id)
    find_top_items(id).flatten.map do |invoice_items|
      items.find_by_id(invoice_items.item_id)
    end
  end

  def best_item_for_merchant(id)
    items.find_by_id(invoice_items.find_by_id(find_max_invoice(id)[0]).item_id)
  end

end
