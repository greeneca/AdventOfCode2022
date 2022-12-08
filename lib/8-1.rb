module D8P1
  class D8P1
    LEFT=0
    TOP=1
    RIGHT=2
    BOT=3
    def run(input)
      grid = {}
      x, y, = 0, 0
      input.each do |line|
        line.split("").map{|h|h.to_i}.each do|h|
          current = {
            h: h,
            max: [-1, -1, -1, -1]
          }

          left = grid[idx(x-1,y)]
          current[:max][LEFT] = [left[:h], left[:max][LEFT]].max if left
          top = grid[idx(x,y-1)]
          current[:max][TOP] = [top[:h], top[:max][TOP]].max if top

          grid[idx(x,y)] = current
          x += 1
        end
        x = 0
        y += 1
      end
      y -= 1
      max_x = input.first.size-1
      x = max_x
      vis_count = 0
      while y >= 0 do
        while x >= 0 do
          current = grid[idx(x,y)]
          h = current[:h]
          right = grid[idx(x+1,y)]
          current[:max][RIGHT] = [right[:h], right[:max][RIGHT]].max if right
          bot = grid[idx(x,y+1)]
          current[:max][BOT] = [bot[:h], bot[:max][BOT]].max if bot
          current[:max].each do |max|
            if max < current[:h]
              vis_count += 1
              break
            end
          end
          x -= 1
        end
        y -= 1
        x = max_x
      end
      puts "Count: #{vis_count}"
    end
    def idx(x, y)
      Matrix[[x, y]]
    end
  end
end
