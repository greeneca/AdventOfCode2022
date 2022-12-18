module D17P1
  class D17P1
    def run(input)
      input = input.first.split("")
      index = 0
      rocks = 0
      current_rock = nil
      map = {}
      height = 0
      (0..7).each do |x|
        map[Vector[x,0]] = "-"
      end
      while rocks < 2023
        if current_rock.nil?
          current_rock = Rock.new(height)
          rocks += 1
        end
        case input[index]
        when "<"
          current_rock.move_left(map)
        when ">"
          current_rock.move_right(map)
        end
        index = (index+1) % input.length
        unless current_rock.move_down?(map)
          current_rock.stop(map)
          height = [height, current_rock.get_height].max
          current_rock = nil
          #print_map(map, height)
        end
      end
      puts "Height: #{height}"
    end
    def print_map(map, height)
      str = ""
      (0..height).to_a.reverse.each do |y|
        str += "|"
        (0..6).each do |x|
          char = map[Vector[x,y]]
          char ||= "."
          str += char
        end
        str += "|\n"
      end
      puts str
    end
  end
  class Rock
    CLASSES = %w(_ + L | o)
    @@next_class = 0
    attr_reader :position
    def initialize(height)
      @class = CLASSES[@@next_class]
      @@next_class = (@@next_class+1) % CLASSES.length
      @position = Vector[2, height+4]
    end

    def move_down?(map)
      new_position = @position + Vector[0,-1]
      move?(new_position, map)
    end
    def move_left(map)
      new_position = @position + Vector[-1,0]
      move?(new_position, map)
    end
    def move_right(map)
      new_position = @position + Vector[1,0]
      return move?(new_position, map)
    end
    def move?(new_position, map)
      positions.each do |check_pos|
        check_pos += new_position
        return false if  [-1, 7].include?(check_pos[0])
        return false if map[check_pos]
      end
      @position = new_position
      true
    end

    def stop(map)
      positions.each do |position|
        map[@position+position] = "#"
      end
    end

    def get_height
      case @class
      when "_"
        @position[1]
      when "+"
        @position[1]+2
      when "L"
        @position[1]+2
      when "|"
        @position[1]+3
      when "o"
        @position[1]+1
      end
    end

    def positions
      case @class
      when"_"
        [
          Vector[0,0],
          Vector[1,0],
          Vector[2,0],
          Vector[3,0]
        ]
      when "+"
        [
          Vector[1,0],
          Vector[1,1],
          Vector[1,2],
          Vector[0,1],
          Vector[2,1]
        ]
      when "L"
        [
          Vector[0,0],
          Vector[1,0],
          Vector[2,0],
          Vector[2,1],
          Vector[2,2]
        ]
      when "|"
        [
          Vector[0,0],
          Vector[0,1],
          Vector[0,2],
          Vector[0,3]
        ]
      when "o"
        [
          Vector[0,0],
          Vector[0,1],
          Vector[1,0],
          Vector[1,1]
        ]
      end
    end
  end
end
