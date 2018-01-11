require 'pry'

module InvoiceAnalyst

  def invoices
    @sales_engine.invoices
  end

  def all_invoices
    invoices.invoices
  end

  def invoice_items
    @sales_engine.invoice_items
  end

  def total_invoices
    @sales_engine.invoices.all.count.to_f
  end

  def all_invoices_by_merchant
    merchants.merchants.values.map do |merchant|
      merchant.invoices.count
    end
  end

  def calculate_invoice_stdev
    stdev(total_invoices, total_merchants, all_invoices_by_merchant)
  end

  def invoice_status(status)
    ((total_with_status(status).count / total_invoices) * 100).round(2)
  end

  def get_days
    all_invoices.values.group_by do |invoice|
      invoice.created_at.strftime("%A")
    end
  end

  def transform_get_days
    get_days.transform_values do |invoice|
      invoice.count
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

  def calculate_invoice_day_stdev
    stdev(total_invoices, 7, transform_get_days.values)
  end

  def find_top_items(id)
    maximum = find_max(id)
    find_invoice_items_by_invoice(id).flatten.find_all do |invoice_item|
      invoice_item.quantity == maximum.quantity
    end
  end

  def find_max(id)
    find_invoice_items_by_invoice(id).flatten.max_by do |invoice_item|
      invoice_item.quantity
    end
  end

  def find_invoice_items_by_invoice(id)
    find_if_invoice_paid_in_full(id).map do |invoice|
      invoice.invoice_items
    end
  end

  def find_if_invoice_paid_in_full(id)
    invoices.find_all_by_merchant_id(id).find_all do |invoice|
      invoice.is_paid_in_full?
    end
  end

  def find_max_invoice(id)
    match_invoice_with_price(id).max_by do |invoice_item|
      invoice_item[1]
    end
  end

  def match_invoice_with_price(id)
    find_invoice_item_by_invoice(id).flatten.map do |invoice_item|
      [invoice_item.id, invoice_item.total]
    end
  end

  def find_invoice_item_by_invoice(id)
    find_invoices_for_merchant_paid_in_full(id).map do |invoice|
      invoice.invoice_items
    end
  end

  def find_invoices_for_merchant_paid_in_full(id)
    merchants.find_by_id(id).invoices.find_all do |invoice|
      invoice.is_paid_in_full?
    end
  end
end
