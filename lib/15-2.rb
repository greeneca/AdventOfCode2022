module D15P2
  class D15P2
    X = 0
    Y = 1
    def run(input)
      @range = ARGV.shift.to_i
      pids = []
      (0...4).each do |process|
        pid = fork do 
          (@range/4*process..@range/4*(process+1)).each do |y|
            intervals = []
            input.each do |line|
              sensor, beacon = line.split(":").map{|input| to_vector(input)}
              distance = get_distance(sensor, beacon)
              from_y = (sensor[Y]-y).abs
              if from_y < distance
                range = distance-from_y
                intervals.push(sensor[X]-range..sensor[X]+range)
              end
            end
            intervals = merge_intervals(intervals)
            x = 0
            intervals.each do |interval|
              if x < interval.first
                frequency = ((x*4000000)+y)
                puts "Frequency: #{x}:#{y} - #{frequency}"
                exit(0)
              else
                x = interval.end + 1
                break if x > @range
              end
            end
          end
        end
        pids.push pid
      end
      Process.wait
      pids.each do |pid|
        begin
          Process.kill("ABRT", pid)
        rescue Errno::ESRCH
          #Do Nothing
        end
      end
    end

    def to_vector(input)
      Vector.elements(input.split(" ")[-2..-1].map{|n| n.split("=")[-1].to_i})
    end

    def get_distance(a, b)
      (a-b).to_a.map{|n| n.abs}.inject(:+)
    end

    def merge_intervals(intervals)
      intervals.sort_by!{|inter| inter.first}
      merged = [intervals.first]
      (1...intervals.length).each do |i|
        if merged.last.end >= intervals[i].first
          merged[-1] = (merged[-1].first..[merged[-1].end, intervals[i].end].max)
        else
          merged.push intervals[i]
        end
      end
      merged
    end
  end
end
