module D16P1
  class D16P1
    def run(input)
      @map = {}
      input.each do |line|
        line = line.split(" ")
        room = @map[line[1]]
        unless room
          room ||= Room.new(line[1])
          @map[line[1]] = room
        end
        room.flow_rate = line[4].split("=").last.to_i
        line[9..-1].each do |child|
          name = child.gsub(",", "")
          child = @map[name]
          if child
            room.add_child(child)
          else
            @map[name] = room.createChild(name)
          end
        end
      end
      pressure = max_pressure(@map["AA"], [], [], 30)

      puts "Pressure = #{pressure}"
    end

    def max_pressure(current, opened, visited, time_left)
      byebug if opened.count == @map.count
      if time_left <= 0
        return 0
      end
      best = 0
      value = 0
      current_opened = opened.dup
      next_visited = visited.dup.push(current.name)
      unless opened.include? current
        current_opened.push(current)
        time_left -= 1 if current.flow_rate > 0
        value = current.pressure_released(time_left)
      end
      current.children.each do |child|
        best = [best, value+max_pressure(child, current_opened, next_visited, time_left-1)].max
      end
      puts "#{best} -> #{next_visited.to_s}"
      best
    end
  end
  class Room

    attr_accessor :flow_rate, :opened
    attr_reader :children, :name

    def initialize(name)
      @name = name
      @flow_rate = 0
      @children = []
    end

    def createChild(name)
      child = Room.new(name)
      @children.push(child)
      child
    end

    def add_child(child)
      @children.push(child)
    end

    def pressure_released(time_left)
      time_left*@flow_rate
    end

    def to_s
      "#{@name}: #{@flow_rate} -> #{@children.map{|r| r.name}.to_s}"
    end
  end
end
