module D3P2
  class D3P2
    def run(input)
      badges = []
      (0..input.size/3-1).each do |idx|
        start = idx * 3
        group = input[start..start+2]
        badges.push group.map {|backpack| backpack.split("")}.reduce(:&).first
      end
      puts "Sum: #{badges.map {|i| n = (i.ord-38)%58}.sum}"
    end
  end
end
