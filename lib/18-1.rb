module D18P1
  class D18P1
    def run(input)
      dropplet = {}
      input.each do |cube|
        dropplet[Vector.elements(cube.split(",").map{|c|c.to_i})] = true
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
      dropplet.each_key do |cube|
        adjecent.each do |adj|
          unless dropplet[cube+adj]
            sides += 1
          end
        end
      end
      puts "Sides: #{sides}"
    end
  end
end
