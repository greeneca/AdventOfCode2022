module D2P1
  class D2P1
    def run(input)
      score = 0
      map = {
        "A" => {"X" => 4, "Y" => 8, "Z" => 3},
        "B" => {"X" => 1, "Y" => 5, "Z" => 9},
        "C" => {"X" => 7, "Y" => 2, "Z" => 6}
      }
      input.each do |game|
        opp, own = game.split(" ")
        score += map[opp][own]
      end
      puts "Score: #{score}"
    end
  end
end
