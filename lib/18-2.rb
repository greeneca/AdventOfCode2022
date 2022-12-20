module D18P2
  class D18P2
    def run(input)
      dropplet = {}
      @max = nil
      @min = nil
      input.each do |cube|
        cor = Vector.elements(cube.split(",").map{|c|c.to_i})
        set_min_max(cor)
        dropplet[cor] = "D"
      end
      sides = 0
      adjecent = [
        Vector[0,0,1],
        Vector[0,1,0],
        Vector[1,0,0],
        Vector[0,0,-1],
        Vector[0,-1,0],
        Vector[-1,0,0]
      ]
      queue = [@min]
      surface = {}
      checked = {}
      puts "Min: #{@min} Max: #{@max}"
      while queue.size > 0
        cube = queue.shift
        adjecent.each do |adj|
          check = cube+adj
          puts "Checking: #{check}"
          if within(check)
            if dropplet[check]
              puts "Is Drop"
              surface[cube] = true
            elsif not checked[check]
              puts "Is Air"
              queue.push check
            end
            checked[check] = true
          end
        end
      end
      puts "Sides: #{surface.count}"
    end
    def set_min_max(cor)
      if @min.nil?
        @min = Vector.elements(cor.to_a)
        @max = Vector.elements(cor.to_a)
      else
        (0..2).each do |idx|
          @min[idx] = [@min[idx], cor[idx]-1].min
          @max[idx] = [@max[idx], cor[idx]+1].max
        end
      end
    end
    def within(cor)
      (0..2).each do |idx|
        return false unless (@min[idx] <= cor[idx] and cor[idx] <= @max[idx])
      end
      return true
    end
  end
end
