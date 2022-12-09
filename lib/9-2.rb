module D9P2
  class D9P2
    def run(input)
      map = {
        "U" => Vector[0,1],
        "D" => Vector[0,-1],
        "L" => Vector[-1,0],
        "R" => Vector[1,0],
      }
      knots = Array.new(10){Vector[0,0]}
      visited = [knots.last]
      input.each do |move|
        dir, count = move.split(" ")
        count = count.to_i
        count.times do 
          knots[0] = knots[0] + map[dir]
          for idx in 0..knots.count-2 do
            knots[idx+1] = move_knot(knots[idx], knots[idx+1])
          end
          visited.push knots.last
        end
      end
      puts "Visited: #{visited.uniq.count}"
    end
    def move_knot(a, b)
      new_b = b
      diff = a-b
      if diff[0].abs > 1 or diff[1].abs > 1
        move = nil
        if (diff[0].abs+diff[1].abs > 2) and (diff[0] != -1 and diff[1] != -1)
          move = diff - diff/2
        else
          move = diff/2
        end
        new_b = b + move
      end
      return new_b      
    end
  end
end
