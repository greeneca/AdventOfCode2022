module D10P2
  class D10P2
    def run(input)
      x = 1
      cycle = 0
      signal_sum = 0
      done = false
      current = {
        "command":nil,
        "cycles_remaining": 0
      }
      cycles = {
        "noop" => 1,
        "addx" => 2
      }
      screen = ""
      while not done
        if current[:cycles_remaining] == 0
          line = input.shift
          break unless line
          current[:command] = line.split(" ")
          current[:cycles_remaining] = cycles[current[:command].first]
        end
        if ((cycle%40)-x).abs < 2
          screen += "#"
        else
          screen += "."
        end
        current[:cycles_remaining] -= 1
        cycle += 1
        if (cycle%40) == 0
          screen += "\n"
        end
        if current[:cycles_remaining] == 0
          case current[:command].first
          when "noop"
            #do nothing
          when "addx"
            x += current[:command][1].to_i
          end
        end
      end
      puts screen
    end
  end
end
