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
    all_invoices.values.map do |invoice|
      (@sales_engine.find_invoices(invoice.merchant_id)).count
    end
  end

  def invoice_mean
    all_invoices_by_merchant.sum / total_merchants
  end

  def invoice_variance
    all_invoices_by_merchant.map do |invoice|
      (invoice - invoice_mean) ** 2
    end
  end

  def calculate_invoice_stdev
    Math.sqrt(invoice_variance / total_invoices)
  end

end