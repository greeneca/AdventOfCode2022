module D3P1
  class D3P1
    def run(input)
      common_items = []
      input.each do |backpack|
        a = backpack[0..backpack.size/2-1]
        b = backpack[backpack.size/2..-1]
        common_items.push((a.split("") & b.split("")).first)
      end
      puts "Sum: #{common_items.map {|i| n = (i.ord-38)%58}.sum}"
    end
  end
end
