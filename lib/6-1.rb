module D6P1
  class D6P1
    def run(input)
      buffer = input.first.split("")
      for i in (0..buffer.size-5)
        marker = buffer[i..i+3]
        if marker.uniq.size == 4
          puts "Index: #{i+4}"
          exit
        end
      end
    end
  end
end
