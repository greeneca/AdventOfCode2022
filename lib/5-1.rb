module D5P1
  class D5P1
    NO_STRIP = true
    def run(input)
      stacks = Array.new(input.first.size/4){Array.new()}
      mode = :stacks
      input.each do |line|
        case mode
        when :stacks
          if line[1].to_i != 0
            mode = :orders
            next
          end
          for i in 0..(line.size/4-1)
            char = line[(i*4)+1]
            stacks[i].push(char) unless char.strip.empty?
          end
        when :orders
          next if line.strip.empty?
          line = line.split(" ")
          line[1].to_i.times do
            stacks[line[5].to_i-1].unshift(stacks[line[3].to_i-1].shift)
          end
        end
      end
      code = ""
      stacks.each do |stack|
        code += stack.shift
      end
      puts "Code: #{code}"
    end
  end
end
