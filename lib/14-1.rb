module D14P1
  class D14P1
    X = 0
    Y = 1
    DOWN = Vector[0,1]
    LEFT = Vector[-1,1]
    RIGHT = Vector[1,1]
    def run(input)
      sand_start = Vector[500,0]
      map = {
        sand_start => "+"
      }
      @max = sand_start
      @min = sand_start
      input.each do |line|
        prev_point = nil
        line.split(" -> ").each do |point|
          x,y = point.split(",").map{|p| p.to_i}
          point = Vector[x,y]
          adjust_min_max(point)
          map[point] = "#"
          if prev_point
            adj = get_adj(point, prev_point)
            cur_point = point
            while cur_point != prev_point
              cur_point = cur_point + adj
              map[cur_point] = "#"
            end
          end
          prev_point = point
        end
      end
      catch :void do 
        while true
          sand = sand_start
          while true
            if not map[sand+DOWN]
              sand = sand + DOWN
            elsif not map[sand+LEFT]
              sand = sand + LEFT
            elsif not map[sand+RIGHT]
              sand  = sand + RIGHT
            else
              map[sand] = "O"
              break
            end
            throw :void if sand[Y] > @max[Y]
          end
        end
      end
      print_grid(map)
      puts "Sand: #{map.select{|k,v| v == "O"}.count}"
    end
    def get_adj(a,b)
      Vector.elements((b-a).to_a.map{|n| n == 0 ? n : n/n.abs})
    end
    def adjust_min_max(point)
      if point[X] > @max[X]
        @max = Vector[point[X], @max[Y]]
      end
      if point[Y] > @max[Y]
        @max = Vector[@max[X], point[Y]]
      end
      if point[X] < @min[X]
        @min = Vector[point[X], @min[Y]]
      end
      if point[Y] < @min[Y]
        @min = Vector[@min[X], point[Y]]
      end
    end
    def print_grid(grid)
      str = ""
      (@min[Y]..@max[Y]).each do |y|
        (@min[X]..@max[X]).each do |x|
          p = Vector[x,y]
          if grid[p]
            str += grid[p]
          else
            str += "."
          end
        end
        str += "\n"
      end
      puts str
    end
  end
end
