module StandardDeviation

  def mean(total, objects)
    total / objects
  end

  def variance(total, objects, population)
    mean_for_variance = mean(total, objects)
    population.sum do |populate|
      (populate - mean_for_variance) ** 2
    end
  end

  def stdev(total, objects, population)
    Math.sqrt(variance(total, objects, population) / (objects - 1)).round(2)
  end
end
