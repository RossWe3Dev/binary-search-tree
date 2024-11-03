require_relative "node"

class Tree
  attr_accessor :array, :root

  def initialize(arr)
    useful_arr = arr.uniq.sort
    @array = useful_arr
    @root = nil
    puts "Input array was sorted, eventual duplicates were removed" unless arr == useful_arr
  end

  def sorted_arr_to_bst(arr, start, finish)
    return nil if start > finish

    mid = start + ((finish - start) / 2).to_i
    root = Node.new(arr[mid])

    root.left = sorted_arr_to_bst(arr, start, mid - 1)
    root.right = sorted_arr_to_bst(arr, mid + 1, finish)

    root
  end

  def build_tree
    finish = @array.length - 1
    @root = sorted_arr_to_bst(@array, 0, finish)
  end

  def pretty_print(node = @root, prefix = "", is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end

  def insert(value, node = @root)
    return Node.new(value) if node.nil?
    return node if node.data == value

    if value < node.data
      node.left = insert(value, node.left)
    elsif value > node.data
      node.right = insert(value, node.right)
    end
    node
  end
end
