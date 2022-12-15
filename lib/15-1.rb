module D15P1
  class D15P1
    X = 0
    Y = 1
    def run(input)
      @col = ARGV.shift.to_i
      @max = nil
      @min = nil
      intervals = []
      known = []
      input.each do |line|
        sensor, beacon = line.split(":").map{|input| to_vector(input)}
        adjust_min_max(sensor)
        adjust_min_max(beacon)
        known.push beacon[X] if beacon[Y] == @col
        distance = get_distance(sensor, beacon)
        from_col = (sensor[Y]-@col).abs
        if from_col < distance
          range = distance-from_col
          intervals.push(sensor[X]-range..sensor[X]+range)
        end
      end
      intervals.sort_by!{|inter| inter.first}
      merged = [intervals.first]
      (1...intervals.length).each do |i|
        if merged.last.end >= intervals[i].first
          merged[-1] = (merged[-1].first..[merged[-1].end, intervals[i].end].max)
        else
          merged.push intervals[i]
        end
      end
      count = merged.inject(0){|sum,inter| sum+inter.size}
      count -= known.uniq.count
      puts "Count: #{count}"
    end

    def to_vector(input)
      Vector.elements(input.split(" ")[-2..-1].map{|n| n.split("=")[-1].to_i})
    end

    def get_distance(a, b)
      (a-b).to_a.map{|n| n.abs}.inject(:+)
    end

    def adjust_min_max(point)
      unless @max
        @max = point
        @min = point
      else
        if point[X] > @max[X]
          @max = Vector[point[X], @max[Y]]
        end
        if point[X] < @min[X]
          @min = Vector[point[X], @min[Y]]
        end
      end
    end
  end
end
