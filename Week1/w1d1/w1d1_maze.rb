# run maze expects a maze as a string like so:
#  ****************
#  *         *   E*
#  *    *    *  ***
#  *    *    *    *
#  *    *    *    *
#  *    *    *    *
#  *S   *         *
#  ****************


class Maze

	def initialize(maze)
		@maze = parse_maze(maze)
		@start = get_start()
		@paths = make_paths()
		@path = @paths.min
	end

	def parse_maze(maze_string)
		maze_array = []
		maze_string.each_line do |line|
			maze_array << line.split('')
		end
		maze_array
	end

	def get_start()
		start = nil
		@maze.each_with_index do |row, rowindex|
			if row.include? "S"
				start = [rowindex,  row.find_index("S")]
			end
		end
		start
	end

	def make_paths(path = [@start])
		next_steps = next_steps(mark_maze(path), path.last)
		puts "next_steps = #{next_steps}"
		if next_steps.length > 0
			if next_to_end?(path[-1])
				add_path_to_paths(next_steps, path)
			else
				next_steps.each do |step|
					path << step
					make_paths(path)
				end
			end
		end
	end
	
	def mark_maze(path)
		marked_maze = maze.clone
		path.each { |step| marked_maze[step[0]][step[1]] = "X"}
		marked_maze
	end
	
	def add_path_to_paths(next_steps, path)
		next_steps.each do |step|
			if @maze[step] == "E"
				path << step
				@paths << path
			end
		end
	end
	
	def possible_steps(current)
		[	[current[0]-1, current[1]-1],
			[current[0]-1, current[1]],
			[current[0]-1, current[1]+1],
			[current[0], current[1]-1],
			[current[0], current[1]+1],
			[current[0]+1, current[1]-1],
			[current[0]+1, current[1]],
			[current[0]+1, current[1]+1]
		]		
	end
	
	def next_steps(current_maze, current_step)
		possible_steps = (possible_steps(current))
		next_steps = []		
		
		possible_steps.each do |step|
			if @maze[step[0]][step[1]] == " "
				next_steps << step
			end
		end	
		
		return next_steps
	end
	
	def next_to_end?(current)
		possible_steps = possible_steps(current)
		possible_steps.each do |step|
			if @maze[step[0]][step[1]] == "E"
				return true
			else
				return false
			end
		end
	end
	
end

first_maze = %q[****************
*         *   E*
*    *    *  ***
*    *    *    *
*    *    *    *
*    *    *    *
*S   *         *
****************]
  
  puts first_maze
  
Maze.new(first_maze)
  