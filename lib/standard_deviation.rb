module StandardDeviation

  def mean(total, total_objects)
    total / total_objects
  end

  def variance(total, total_objects, population)
    mean_for_variance = mean(total, total_objects)
    population.sum do |populate|
      (populate - mean_for_variance) ** 2
    end
  end

  def stdev(total, total_objects, population)
    Math.sqrt(variance(total, total_objects, population) / (total_objects - 1)).round(2)
  end

end
