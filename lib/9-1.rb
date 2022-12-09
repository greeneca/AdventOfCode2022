module D9P1
  class D9P1
    def run(input)
      map = {
        "U" => Vector[0,1],
        "D" => Vector[0,-1],
        "L" => Vector[-1,0],
        "R" => Vector[1,0],
      }
      head = Vector[0,0]
      tail = Vector[0,0]
      visited = [tail]
      input.each do |move|
        dir, count = move.split(" ")
        count = count.to_i
        count.times do 
          head = head + map[dir]
          tail = move_tail(head, tail)
          visited.push tail
          #puts "h: #{head}  t: #{tail}"
        end
      end
      puts "Visited: #{visited.uniq.count}"
    end
    def move_tail(head, tail)
      new_tail = tail
      diff = head-tail
      if diff[0].abs > 1 or diff[1].abs > 1
        move = nil
        if (diff[0].abs+diff[1].abs > 2) and (diff[0] != -1 and diff[1] != -1)
          move = diff - diff/2
        else
          move = diff/2
        end
        new_tail = tail + move
      end
      return new_tail      
    end
  end
end
