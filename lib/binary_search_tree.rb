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

  # find the inorder successor, the bottom left node of the right subtree of current_node
  def get_successor(current_node)
    current_node = current_node.right
    current_node = current_node.left while !current_node.nil? && !current_node.left.nil?
    current_node
  end

  def delete(value, node = @root)
    return node if node.nil?

    # traverse if value is in a sub-tree
    if value < node.data
      node.left = delete(value, node.left)
    elsif value > node.data
      node.right = delete(value, node.right)
    else
      # delete leaf node or node that has only a right child (skip to the next node)
      return node.right if node.left.nil?

      # delete a node with a single left child
      return node.left if node.right.nil?

      # delete a node with both children => replace it with the inorder successor, than delete it
      inorder_succ = get_successor(node)
      node.data = inorder_succ.data
      node.right = delete(inorder_succ.data, node.right)
    end

    node
  end

  def find(value, node = @root)
    return nil if node.nil?
    return node if node.data == value

    find(value, node.left) if value < node.data
    find(value, node.right) if value > node.data
  end

  def level_order(&block)
    queue = [@root]
    result = []

    until queue.empty?
      node = queue.shift
      block_given? ? (yield node) : (result << node.data)
      queue << node.left if node.left
      queue << node.right if node.right
    end

    result unless block_given?
  end

  def level_order_rec(node = @root, queue = [], result = [], &block)
    block_given? ? (yield node) : (result << node.data)
    queue << node.left if node.left
    queue << node.right if node.right

    block_given? ? (return if queue.empty?) : (return result if queue.empty?)

    level_order_rec(queue.shift, queue, result, &block)
  end
end
