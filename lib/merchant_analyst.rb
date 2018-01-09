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

  def all_merchants_with_items
    all_merchants.values.reduce([]) do |result, merchant|
      result << {merchant =>@sales_engine.find_item_by_merchant_id(merchant.id)}
    end
  end

  def find_merchants_with_only_one_item
    all_merchants_with_items.find_all do |merchant|
      merchant.values[0].count == 1
    end
  end
end
