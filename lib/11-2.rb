module D11P2
  class D11P2
    def run(input)
      monkeys  = []
      monkey = nil
      i_map = {:* => 1, :+ => 0}
      input.each do |line|
        line = line.split(":")
        case line.first
        when /Monkey \d+/
          if monkey
            monkey[:checked] = 0
            monkeys.push monkey
          end
          monkey = {}
        when /Starting items/
          monkey[:items] = line.last.split(", ").map{|n| n.to_i}
        when /Operation/
          op = line.last.split(" = ").last.split(" ")
          command = op.delete_at(1).to_sym
          num = op.map{|n| n == "old" ? :old : n.to_i}
          monkey[:op] = {cmd: command, num: num}
        when /Test/
          monkey[:test] = line.last.split(" ").last.to_i
        when /If true/
          monkey[:true] = line.last.split(" ").last.to_i
        when /If false/
          monkey[:false] = line.last.split(" ").last.to_i
        end
      end
      monkey[:checked] = 0
      monkeys.push monkey
      divisor = monkeys.map{|m| m[:test]}.inject(1, :*)
      10000.times do
        monkeys.each do |monkey|
          while monkey[:items].count > 0
            monkey[:checked] += 1
            item = monkey[:items].shift
            op = monkey[:op]
            worry = op[:num].map{|n| n == :old ? item : n}.inject(i_map[op[:cmd]], op[:cmd])
            worry = worry % divisor
            target = nil
            if (worry % monkey[:test]) == 0
              target = monkey[:true]
            else
              target = monkey[:false]
            end
            monkeys[target][:items].push(worry)
          end
        end
      end
      business = monkeys.map{|m| m[:checked]}.sort[-2..-1].inject(1, :*)
      puts "Monkey Business: #{business}"
    end
  end
end
