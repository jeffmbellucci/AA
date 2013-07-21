require './TreeNode.rb'

class KnightPathFinder

  def initialize(pos)
    @move_tree = build_move_tree(pos)
  end

#TODO if you are ever bored: make shift for TreeNode then use the root treenode as the queue
  def build_move_tree(pos)
    root = TreeNode.new(pos)
    queue = [root]
    visited_positions = {root.value => true}
    while queue.length > 0
      treenode = queue.shift
      next_level = KnightPathFinder.new_move_positions(treenode.value)
      next_level.delete_if{ |pos| visited_positions.has_key?(pos) }
      next_level.each do |pos|
        new_node = TreeNode.new(pos)
        queue << new_node
        treenode.push(new_node)
        visited_positions[pos] = true
      end
    end
    root
  end

  def to_s
    @move_tree.children.each {|child| child.to_s }
  end


  def self.new_move_positions(pos)
    new_move_positions = []
    reachable = [
      [1, 2],
      [2, 1],
      [-1, -2],
      [-2, -1],
      [-1, 2],
      [2, -1],
      [-2, 1],
      [1, -2]
    ]
    reachable.each do |move|
      x, y = pos.first + move.first, pos.last + move.last
      if x.between?(0, 7) && y.between?(0, 7)
        new_move_positions << [x, y]
      end
    end
    new_move_positions
  end

  def find_path(end_pos)
    @move_tree.bfs(end_pos).path
  end

end

new_knight = KnightPathFinder.new([0,0])
p new_knight.find_path([7,7])

