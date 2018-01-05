require_relative 'sales_engine'

class SalesAnalyst

  def initialize(sales_engine)
    @sales_engine = sales_engine
  end

  def average_items_per_merchant
    (total_items / total_merchants).round(2)
  end

  def total_merchants
    @sales_engine.merchants.all.count.to_f
  end

  def total_items
    @sales_engine.items.all.count.to_f
  end

  def average_items_per_merchant_standard_deviation
    average_items_per_merchant
    @sales_engine.merchants.all.map do |merchant|
    @sales_engine.items.find_all_by_merchant_id(merchant.id).count - average_items_per_merchant
    end
  end


end

# it would be nice to have a hash collection where each merchant
# would be a value where the key is their merchant ID

# then we would want to iterate over this collection and make another
# hash where the number of items each merchant has is the key and the
# merchant is the value

# then we turn the keys of each merchant into its own array and subtract the mean
# amount of items from the total
