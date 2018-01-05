require_relative 'sales_engine'

class SalesAnalyst

  def initialize(sales_engine)
    @sales_engine = sales_engine
  end

  def average_items_per_merchant
    total_items / total_merchants
  end

  def total_merchants
    @sales_engine.merchants.all.count
  end

  def total_items
    @sales_engine.items.all.count
  end


end
