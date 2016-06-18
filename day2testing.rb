load './day2.rb'


def main()
  #file_read("README.md")
  #file_write("DONTREADME.md", "You weren't listening")
  # my_array = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16]
  # print_array2(my_array)
  #  my_tree = Tree.new({"Root"=> [{"leaf1"=> {}}, {"leaf2"=> {} }]})
  #  my_tree.visit_all {|subtree| puts "hello #{subtree.node_name}"}
  simple_grep("README.md", "Ruby")

end






main()
