module D4P2
  class D4P2
    def run(input)
      count = 0
      input.each do |pair|
        a,b = pair.split(",").map{|r| r = r.split("-").map{|i|i.to_i}; (r[0]..r[1])}
        if (a.include? b.begin or a.include? b.end) or (b.include? a.begin or b.include? a.end)
          count += 1
        end
      end
      puts "Count: #{count}"
    end
  end
end
