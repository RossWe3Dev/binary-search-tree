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

puts "\nThis should add 3 leaf nodes of value: 2, 39 and 100; then add (98) and (96) as children of (100)"
test.insert(2)
test.insert(39)
test.insert(100)
test.insert(98)
test.insert(96)
test.pretty_print

puts "\nTesting #delete on leaf nodes (2) and (6345)"
test.delete(2)
test.delete(6345)
test.pretty_print

puts "\nTesting #delete on a node with a single left child (324) and one with both (4)"
test.delete(324)
test.delete(4)
test.pretty_print

puts "\nTesting if nothing changes when deleting a value that's not part of the tree"
test.delete(45)

puts "\nTesting #find"
p test.find(100)
p test.find(500)
p test.find(5)

puts "\nTesting #level_order"
p test.level_order
test.level_order { |x| print "#{x.data} " }

puts "\n\nTesting #level_order_rec"
p test.level_order_rec
test.level_order_rec { |x| print "#{x.data} " }

puts "\n\nTesting #inorder"
p test.inorder

puts "\nTesting #preorder"
p test.preorder

puts "\nTesting #postorder"
p test.postorder

puts "\nTesting #height"
p test.height
p test.height(test.find(4))
p test.height(test.find(67))
p test.height(test.find(5))
