module D1P1
  class D1P1
    def run(input)
      max = 0
      current_total = 0
      input.each do |cals|
        if cals.empty?
          max = current_total if current_total > max
          current_total = 0
        else
          current_total += cals.to_i
        end
      end
      max = current_total if current_total > max
      puts "Max Calories: #{max}"
    end
  end
end
