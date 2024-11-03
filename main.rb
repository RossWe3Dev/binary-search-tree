require_relative "lib/binary_search_tree"

test_arr1 = [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]

test = Tree.new(test_arr1)
p test.array

test.build_tree
puts "\nRoot node is element: #{test.build_tree.data}"
puts "\nBST"
test.pretty_print
