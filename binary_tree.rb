class Node
	attr_reader :value
	attr_accessor :head, :left, :right

	def initialize(value)
		@value = value
	end

	def value
		@value
	end

	def head=(head=nil)
		@head=head
	end

	def left=(left=nil)
		@left=left
	end

	def right=(right=nil)
		@right=right
	end

end

def create_array num_of_elts
	array = []

	num_of_elts.times do |x|
		array << Random.rand(100)
	end

	array
end


def create_tree(array)
	root = Node.new(array[0]) # the first element is the root

	i = 1
	while i < array.length do #iterate each array element from index 1
		head = root
		current = Node.new(array[i])

		j = 0
		puts "root = #{root.value}"
		loop do
			if current.value >= head.value
				if head.right == nil
					head.right = current.clone
					head.right.head = head
					puts ">= added head: #{head.right.value}"
					head = head.right.head
					break
				else
					puts ">> #{head.right.value}"
					# puts "my head = #{head.head.value}"
					head = head.right
				end

			elsif current.value < head.value
				if head.left == nil
					head.left = current.clone
					head.left.head = head
					puts "< added head: #{head.left.value}"
					head = head.left.head
					break
				else
					puts "<< #{head.left.value}"
					# puts "my head = #{head.head.value}"
					head = head.left
				end
			end
		end
		puts "-" * 10

		i += 1
	end
	root
end


def breadth_first_search(tree, to_search)

	queue = []
	result = []
	current = tree
	queue   << current
	result  << current.value
	i = 0
	until queue.empty?

		if current.value == to_search
			puts "Item found: #{to_search}"
			puts "In node: #{current}"
			return nil
		end
		
		unless current.left == nil
			queue << current.left
		end

		unless current.right == nil
			queue << current.right
		end
		queue.shift
		current = queue[0]

		unless current == nil
			result << current.value
		end
	end
	puts "Item \"#{to_search}\" not found."
	# puts "RESULT: #{result.inspect}"
end


def depth_first_search(tree, to_search=0)
	stack = []
	result = []
	current = tree
	stack << current
	result << current.value
	lpop = []
	rpop = []

	until stack.empty?

		if current.value == to_search
			puts "Item found: #{to_search}"
			puts "In node: #{current}"
			return nil
		end
		
		if (current.left) and (current.left != lpop[-1])
			stack << current.left
			current = current.left
			lpop << current

			result << current.value

		elsif (current.right) and (rpop[-1] != current.right)
			stack << current.right
			current = current.right		
			rpop << current

			result << current.value

		else
			unless stack.empty?
				current = stack[-1]
			end

			stack.pop

			if (current.left == lpop[-1] or current.left == nil) && 
				(current.right == rpop[-1] or current.right == nil)

				unless current.left == nil
					lpop.pop
				end

				unless current.right == nil
					rpop.pop
				end

				current = stack[-1]
			end
		end

	end

	puts "Item \"#{to_search}\" not found."

	# result.each{|x| print "#{x}, "}
	# puts
end
