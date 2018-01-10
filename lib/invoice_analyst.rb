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

end
