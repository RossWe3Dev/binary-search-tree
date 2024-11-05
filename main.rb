require_relative "lib/binary_search_tree"
require "colorize"

puts "- Initializing Binary Search Tree".colorize(:yellow)
driver = Tree.new(Array.new(15) { rand(1..100) })

p driver.array
driver.pretty_print
puts driver.balanced? ? "Tree is balanced".colorize(:green) : "Tree is not balanced".colorize(:magenta)

puts "\n- Tree traversal".colorize(:yellow)
puts "Level order = #{driver.level_order}"
puts "Inorder = #{driver.inorder}"
puts "Preorder = #{driver.preorder}"
puts "Postorder = #{driver.postorder}"

puts "\n- Adding 8 nodes with values > 100".colorize(:yellow)
added_numbers = []
8.times do
  num = rand(101..1000)
  driver.insert(num)
  added_numbers << num
end
p added_numbers.sort

puts "\n- Checking if tree is balanced".colorize(:yellow)
driver.pretty_print
puts driver.balanced? ? "Tree is balanced".colorize(:green) : "Tree is not balanced".colorize(:magenta)

puts "\n- Rebalancing tree".colorize(:yellow)
driver.rebalance
puts driver.balanced? ? "Confirming that tree is balanced".colorize(:green) : "Tree is not balanced".colorize(:magenta)

puts "\n- Tree traversal".colorize(:yellow)
puts "Level order = #{driver.level_order}"
puts "Inorder = #{driver.inorder}"
puts "Preorder = #{driver.preorder}"
puts "Postorder = #{driver.postorder}"
