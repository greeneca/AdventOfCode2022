module D8P2
  class D8P2
    LEFT=0
    TOP=1
    RIGHT=2
    BOT=3
    def run(input)
      grid = {}
      x, y, = 0, 0
      input.each do |line|
        line.split("").map{|h|h.to_i}.each do|h|
          grid[idx(x,y)] = h
          x += 1
        end
        x = 0
        y += 1
      end
      y -= 1
      max_x = input.first.size-1
      x = max_x
      max_score = 0
      while y >= 0 do
        while x >= 0 do
          test = idx(x,y)
          score = 1
          [idx(0,1), idx(1,0), idx(0,-1), idx(-1,0)].each do |adj|
            cur = idx(x,y)+adj
            count = 0
            while grid[cur]
              count += 1
              if grid[cur] >= grid[test]
                break
              end
              cur = cur+adj
            end
            score *= count
          end
          max_score = score if score > max_score
          x -= 1
        end
        y -= 1
        x = max_x
      end
      puts "Sum: #{max_score}"
    end
    def idx(x, y)
      Matrix[[x, y]]
    end
  end
end
