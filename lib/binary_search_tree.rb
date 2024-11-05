require_relative "node"

class Tree
  attr_accessor :array, :root

  def initialize(arr)
    useful_arr = arr.uniq.sort
    @array = useful_arr
    @root = build_tree(@array)
    puts "Input array was sorted, eventual duplicates were removed" unless arr == useful_arr
  end

  def build_tree(arr)
    return nil if arr.empty?

    mid = ((arr.size - 1) / 2)
    root = Node.new(arr[mid])

    root.left = build_tree(arr[0...mid])
    root.right = build_tree(arr[(mid + 1)..-1])

    root
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
    current_node = current_node.left until current_node.left.nil?
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

    if value < node.data
      find(value, node.left)
    else
      find(value, node.right)
    end
  end

  # iterative approach to return level_order / breadth-first-search
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

  # recursive approach to return level_order / breadth-first-search
  # correctly accepts a block to yield control on message output but it is convoluted
  def level_order_rec(node = @root, queue = [], result = [], &block)
    block_given? ? (yield node) : (result << node.data)
    queue << node.left if node.left
    queue << node.right if node.right

    block_given? ? (return if queue.empty?) : (return result if queue.empty?)

    level_order_rec(queue.shift, queue, result, &block)
  end

  # the following method is not called in the driver, shown here to point the difference
  def level_order_rec_no_block(node = @root, queue = [], result = [])
    result << node.data if node
    queue << node.left if node.left
    queue << node.right if node.right

    return result if queue.empty?

    level_order_rec(queue.shift, queue, result, &block)
  end

  # from here on out will not handle block_given? and will just return a result array

  # recursive approaches to return inorder, preorder and postorder / depth-first-search

  def inorder(node = @root, result = [])
    return if node.nil?

    inorder(node.left, result)
    result << node.data
    inorder(node.right, result)

    result
  end

  def preorder(node = @root, result = [])
    return if node.nil?

    result << node.data
    preorder(node.left, result)
    preorder(node.right, result)

    result
  end

  def postorder(node = @root, result = [])
    return if node.nil?

    postorder(node.left, result)
    postorder(node.right, result)
    result << node.data

    result
  end

  # #height and #depth return -1 if node isn't found, necessary for #max

  def height(node = @root)
    return -1 if node.nil?

    left_height = height(node.left)
    right_height = height(node.right)

    1 + [left_height, right_height].max
  end

  def depth(node = @root, current_node = @root, current_depth = 0)
    return current_depth if current_node == node
    return -1 if current_node.nil? || node.nil?

    left_depth = depth(node, current_node.left, current_depth + 1)
    right_depth = depth(node, current_node.right, current_depth + 1)

    [left_depth, right_depth].max
  end

  # a tree is balanced when the difference between heights of left and right subtree of every node is not more than 1

  def balanced?(node = @root)
    return true if node.nil?

    left_height = height(node.left)
    right_height = height(node.right)

    return false if (left_height - right_height).abs > 1

    balanced?(node.left) && balanced?(node.right)
  end

  def rebalance
    return puts "Tree is already balanced" if balanced?

    @root = build_tree(inorder)
    puts "Tree is now balanced"
    pretty_print
  end
end
