module D7P1
  class D7P1
    def run(input)
      tree = nil
      current_dir = nil
      input.each do |line|
        if line.start_with?("$")
          line = line[2..-1]
          if line.start_with?("cd")
            dir = line[3..-1]
            if dir == "/"
              tree = FileTreeNode.new("/", true)
              current_dir = tree
            else
              current_dir = current_dir.cd(dir)
            end
          end
        else
          size, name = line.split(" ")
          if size == "dir"
            current_dir.create_child(name, true)
          else
            current_dir.create_child(name, false, size.to_i)
          end
        end
      end
      @small_dirs = []
      @small_dirs.push tree if tree.size <= 100000
      traverse(tree)
      puts "Sum: #{@small_dirs.reduce(0){|sum,n| sum + n.size}}"
    end
    def traverse(node)
      node.children.each_value do |child|
        if child.is_dir?
          @small_dirs.push child if child.size <= 100000
          traverse(child)
        end
      end
    end
  end
  class FileTreeNode
    attr_reader :name, :children
    def initialize(name, dir, parent=nil, size=0)
      @name = name.to_sym
      @dir = dir
      @parent = parent
      @size = size
      @children = {}
    end

    def is_dir?
      @dir
    end

    def size
      return @size if @size > 0
      @size = @children.values.reduce(0){|sum, n| sum + n.size}
    end

    def create_child(name, dir, size=0)
      child = FileTreeNode.new(name, dir, self, size)
      @children[child.name] = child
    end

    def cd(target)
      if target == ".."
        return @parent
      else
        target = @children[target.to_sym]
        return target if target
        raise "No Such File: #{target}"
      end
    end

    def to_s(depth=1)
      str = "- #{@name} (#{is_dir? ? "dir, size=#{size}" : "file, size=#{size}"})"
      @children.each_value do |child|
        str += "\n#{"  "*depth}#{child.to_s(depth+1)}"
      end
      str
    end
  end
end
