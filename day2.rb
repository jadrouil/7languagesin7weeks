




#how to access file without code block


def file_read(file)
  fileobject = File.new(file,"r")
  while(line = fileobject.gets)
    puts line
  end
  fileobject.close
end

def file_write(file, text)
  fileobject = File.new(file,"w")
  fileobject.write(text)
  fileobject.close
end



#Printing contents of array 4 numbers at a time using each
def print_array(array)
  elements = []
  totalSize = 0
  array.each do |n1|
    elements[totalSize] = n1
    totalSize += 1
    if totalSize == 4
      puts "Numbers: #{elements}"
      elements = []
      totalSize = 0
    end
  end
end

#printing array 4 at a time using each_slice
def print_array2(array)
  array.each_slice(4){|n| p n}
end

class Tree
  attr_accessor :children, :node_name

  def initialize(hash)
    @node_name = hash.keys.first
    @children = []
    hash[@node_name].each do |subhash|
      @children << Tree.new(subhash)
    end
  end

  def visit_all(&block)
    visit &block
    children.each{|c| c.visit_all &block}
  end
  def visit(&block)
    block.call(self)
  end
end
