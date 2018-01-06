module ItemAnalyst

  def items
    @sales_engine.items
  end

  def all_items
    items.items
  end

  def total_items
    @sales_engine.items.all.count.to_f
  end

  def all_items_price
    items.all.sum do |item|
      item.unit_price
    end
  end

  def item_price_mean
    all_items_price / total_items
  end

  def item_variance
    all_items.map do |item|
    (item[1].unit_price - item_price_mean) ** 2
    end.sum
  end

  def item_stdev
    item_variance / total_items
  end

end
