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
    Math.sqrt(invoice_variance / total_merchants).round(2)
  end

  def invoice_variance
    mean = invoice_mean
    all_invoices_by_merchant.sum do |invoice|
      (invoice - mean) ** 2
    end
  end

  def invoice_mean
    total_invoices / total_merchants
  end

  def invoice_status(status)
    ((total_with_status(status).count / total_invoices) * 100).round(2)
  end

  def total_with_status(status)
    all_invoices.values.find_all do |invoice|
      invoice.status == status
    end
  end

  def top_days_by_invoice_count

  end

end
