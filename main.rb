require_relative "lib/binary_search_tree"

test_arr1 = [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]

test = Tree.new(test_arr1)
p test.array

test.build_tree
puts "\nRoot node is element: #{test.build_tree.data}"
puts "\nTesting #pretty_print after #build_tree"
test.pretty_print

puts "\nThis shouldn't add anything"
test.insert(67)
test.pretty_print

puts "\nThis should add 3 leaf nodes of value: 2, 39 and 100 "
test.insert(2)
test.insert(39)
test.insert(100)
test.pretty_print
