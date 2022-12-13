module D13P2
  class D13P2
    def run(input)
      left, right = nil, nil
      sum, index = [], 0
      input = input.map do |line|
        if line.empty?
          nil
        else
          process(line[1..-1].split(""))
        end
      end.compact
      input.push([[2]])
      input.push([[6]])
      input.sort! do |a,b| 
        compare(b.ddup,a.ddup)
      end
      key = (input.index([[2]])+1)*(input.index([[6]])+1)
      puts "Sum: #{key}"
    end
    def process(line)
      list = []
      num = ""
      while true
        char = line.shift
        case char
        when ","
          list.push num.to_i unless num.empty?
          num = ""
        when "["
          list.push process(line)
        when "]"
          list.push num.to_i unless num.empty?
          num = ""
          return list
        else
          num += char
        end
      end
    end
    def compare(left, right)
      while true
        litm = left.shift
        ritm = right.shift
        #puts "Compare #{litm} vs #{ritm}"
        if is_i(litm) and is_i(ritm)
          if litm > ritm
            #puts "Right side smaller, out of order"
            return -1
          elsif ritm > litm
            #puts "Left side smaller, in order"
            return 1
          end
        elsif litm.nil? and not ritm.nil?
          #puts "Left side ran out of items, in order"
          return 1
        elsif not litm.nil? and ritm.nil?
          #puts "Right side ran out of items, out of order"
          return -1
        elsif litm.nil? and ritm.nil?
          #puts "Both ran out, continuing"
          return 0
        elsif is_i(litm)
          #puts "Mixed Types, convert left to #{[litm]}"
          value = compare([litm], ritm)
          return value if value != 0
        elsif is_i(ritm)
          #puts "Mixed Types, convert right to #{[ritm]}"
          value = compare(litm, [ritm])
          return value if value != 0
        else
          value = compare(litm, ritm)
          return value if value != 0
        end
      end
    end
    def is_i(itm)
      itm.class == Integer
    end
  end
end
class Array
  def ddup
    Marshal.load(Marshal.dump(self))
  end
end
