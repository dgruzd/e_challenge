module MembersHelper
  def sort_experts(result)
    #Sort result by deep, heading level
    result.sort do |x,y|
      x_count = x[:path].count
      y_count = y[:path].count
      if x_count == y_count
        x[:topic].level <=> y[:topic].level
      else
        x_count <=> y_count
      end
    end
  end
end
