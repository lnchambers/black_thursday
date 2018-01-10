module MerchantAnalyst

  def merchants
    @sales_engine.merchants
  end

  def all_merchants
    merchants.merchants
  end

  def total_merchants
    @sales_engine.merchants.all.count.to_f
  end

  def merchant_mean
    merchants.all.map do |merchant|
      mean_calculation_merchant(merchant)
    end
  end

  def total_items_per_merchant(merchant)
    items.find_all_by_merchant_id(merchant.id).count
  end

  def find_all_merchants_by_revenue
    all_merchants.values.map do |merchant|
      [merchant, revenue_by_merchant(merchant.id)]
    end
  end
end
