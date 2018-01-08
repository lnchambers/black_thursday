module StandardDeviation

  def mean(total, total_objects)
    total / total_objects
  end

  def stdev(variance, total)
    Math.sqrt(variance / total).round(2)
  end

end
