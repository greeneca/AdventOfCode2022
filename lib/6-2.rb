module D6P2
  class D6P2
    def run(input)
      buffer = input.first.split("")
      for i in (0..buffer.size-16)
        marker = buffer[i..i+13]
        if marker.uniq.size == 14
          puts "Index: #{i+14}"
          exit
        end
      end
    end
  end
end
