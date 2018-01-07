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

  def calculate_invoice_stdev
    Math.sqrt(invoice_variance / total_invoices).round(2)
  end

  def invoice_variance
    mean = invoice_mean
    all_invoices_by_merchant.sum do |invoice|
      (invoice - mean) ** 2
    end
  end

  def invoice_mean
    all_invoices_by_merchant.sum / total_invoices
  end

end
