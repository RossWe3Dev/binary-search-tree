require_relative "lib/binary_search_tree"

driver = Tree.new(Array.new(15) { rand(1..100) })

p driver.array
driver.pretty_print
