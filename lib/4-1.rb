module D4P1
  class D4P1
    def run(input)
      count = 0
      input.each do |pair|
        a,b = pair.split(",").map{|r| r = r.split("-").map{|i|i.to_i}; (r[0]..r[1])}
        if (a.include? b.begin and a.include? b.end) or (b.include? a.begin and b.include? a.end)
          count += 1
        end
      end
      puts "Count: #{count}"
    end
  end
end
