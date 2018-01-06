module InvoiceAnalyst

  def invoices
    @sales_engine.invoices
  end

  def total_invoices
    @sales_engine.invoices.all.count.to_f
  end

  def all_invoices_by_merchant
    invoices.find_all_by_merchant_id.sum do |invoice|
      invoice
    end
  end

  def invoice_mean
    all_invoices_by_merchant.sum / total_merchants.count
  end

  def invoice_variance
    .map do |invoice|
      (invoice - invoice_mean) ** 2
    end
  end

  def calculate_invoice_stdev
    Math.sqrt(invoice_variance / total_invoices)
  end

end
