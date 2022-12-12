module D12P2
  class D12P2
    def run(input)
      grid = {}
      start = nil
      finish = nil
      size = Vector[input[0].length, input.count]
      distance = {
      }
      input.each_index do |y|
        line = input[y].split("")
        line.each_index do |x|
          char = line[x]
          case char
          when "S"
            start = Vector[x,y]
            grid[start] = "a".ord
            distance[start] = 0
          when "E"
            finish = Vector[x,y]
            grid[finish] = "z".ord
          when "a"
            c = Vector[x,y]
            grid[c] = char.ord
            distance[c] = 0
          else
            grid[Vector[x,y]] = char.ord
          end
        end
      end
      visited = {}
      to_test = {}
      current = start
      while true
        #puts current
        [Vector[0,-1], Vector[-1,0], Vector[0,1], Vector[1,0]].each do |dir|
          test = current + dir
          if grid[test] and (not visited[test]) and (grid[test]-grid[current]) < 2
            dist = distance[current]+1
            if not distance[test] or distance[test] > dist
              distance[test] = dist
            end
            to_test[test] = distance[test]
          end
        end
        visited[current] = true
        break if distance[finish]
        #print_grid(size, grid, visited, to_test)
        current = to_test.to_a.sort{|a,b| a[1] <=> b[1]}.first[0]
        to_test.delete(current)
      end
      puts "Path Length: #{distance[finish]}"
    end
    def  print_grid(size, grid, visited, to_test)
      str = "\n"
      size[1].times do |y|
        size[0].times do |x|
        print_grid(size, grid, visited, to_test)
          coor = Vector[x,y]
          if to_test[coor]
            str += "T"
          elsif visited[coor]
            str += "V"
          elsif grid[coor]
            str += grid[coor].chr
          else
            puts "Missing Coor: #{coor}"
          end
        end
        str += "\n"
      end
      puts str
    end
  end
end
