module D2P2
  class D2P2
    def run(input)
      score = 0
      map = {
        "A" => {"X" => 3, "Y" => 4, "Z" => 8},
        "B" => {"X" => 1, "Y" => 5, "Z" => 9},
        "C" => {"X" => 2, "Y" => 6, "Z" => 7}
      }
      input.each do |game|
        opp, own = game.split(" ")
        score += map[opp][own]
      end
      puts "Score: #{score}"
    end
  end
end
