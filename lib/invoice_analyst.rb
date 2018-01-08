require 'pry'

module InvoiceAnalyst

  def invoices
    @sales_engine.invoices
  end

  def all_invoices
    invoices.invoices
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

end
