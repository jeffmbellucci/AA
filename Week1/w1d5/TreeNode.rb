class TreeNode

  attr_reader :left, :right
  attr_accessor :parent, :value

  def initialize(value = nil)
    @parent = nil
    @value = value
    @children = []
    # @left =
    # @right =
  end

  # def left=(treenode)
  #   unless self.left.nil?
  #     self.left.parent = nil
  #   end
  #   @left = treenode
  #   treenode.parent = self
  # end
  #
  # def right=(treenode)
  #   unless self.right.nil?
  #     self.right.parent = nil
  #   end
  #   @right = treenode
  #   treenode.parent = self
  # end

  def push(treenode)
      @children.push(treenode)
      treenode.parent = self
  end

  def <<(treenode)
    self.push(treenode)
  end

  def pop(treenode)
    treenode = @children.pop
    treenode.parent = nil
    treenode
  end

  def dfs_recursive(target = nil, &blk)
    if (!blk.nil? && blk.call(self.value)) || self.value == target
      return self
    else
      self.children.each do |child|
        next_step = blk.nil? ? child.dfs(target) : child.dfs(target, &blk)
        return next_step unless next_step.nil?
      end
    end
    nil
  end


  def dfs_no_recursion(target = nil, &blk)
    path = [self]
    visited = [self]
    while path.size > 0
     if (!blk.nil? && blk.call(path[-1].value)) || path[-1].value == target
        return path[-1]
     end
      next_step = path[-1].children.select{ |child| !visited.include?(child) }[0] #first nonvisited child
      if next_step.nil?
        path.pop
      else
        path << next_step
        visited << next_step
      end
    end
  end

  # def dfs(target)
  #   if self.value == target
  #     return self
  #   else
  #     self.children.each do |child|
  #       next_step = child.dfs(target)
  #       return next_step unless next_step.nil?
  #     end
  #   end
  #   nil
  # end

  def children
    @children
  end

  def bfs(target = nil, &blk)
    fringe = [self]
    next_fringe = []
    while fringe.length > 0
      fringe.each do |node|
        return node if (!blk.nil? && blk.call(node.value)) || node.value == target
        next_fringe += node.children
      end
      fringe = next_fringe
      next_fringe = []
    end
    return nil
  end

    def bfs_with_queue(target = nil, &blk)
      queue = [self]
      while queue.length > 0
        node = queue.shift
        return node if (!blk.nil? && blk.call(node.value)) || node.value == target
        queue += node.children
      end
      return nil
    end

  # def bfs(target)
  #   fringe = [self]
  #   next_fringe = []
  #   while fringe.length > 0
  #     fringe.each do |node|
  #       return node if node.value == target
  #       next_fringe += node.children
  #     end
  #     fringe = next_fringe
  #     next_fringe = []
  #   end
  #   return nil
  # end



  def to_s
    "TreeNode: #{@value} "
  end

  # def to_s_recursive
  #   if self.children.length > 0
  #     print "o--"
  #     return self.children.map{ |child| child.to_s_recursive }
  #   else
  #     puts "o  "
  #     return self
  #   end
  # end


  def path
    if self.parent.nil?
      return [self]
    else
      return (self.parent.path + [self])
    end
  end



end

# top = TreeNode.new("Top")
# left = TreeNode.new("Top -> Left")
#
# top.push(left)
# left.push(TreeNode.new("Top -> Left -> Left"))
#
#
# p left.path
# p top.path
#puts top.dfs_no_recursion("Top -> Right")
#puts top.bfs_with_queue("Top -> Right")
#
#
# p "Top"
# puts top
# puts
# p "left"
# p left
# puts
# p "top.left"
# p top.left
# puts
# p "top.right"
# p top.right
# puts
# p "top.left.left"
# p top.left.left
