module D1P2
  class D1P2
    def run(input)
      counts = []
      current_total = 0
      input.each do |cals|
        if cals.empty?
          counts.push current_total
          current_total = 0
        else
          current_total += cals.to_i
        end
      end
      counts.push current_total
      counts.sort!
      sum = counts[-3..-1].inject(0, :+)
      puts "Sum of Calories: #{sum}"
    end
  end
end
