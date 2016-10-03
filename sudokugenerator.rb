# Generate a random seed for a sudoku puzzle
# Generate a valid sudoku solution for that puzzle
# Punch random holes in that solution

def generate_sudoku_solution(sudoku_puzzle)
	# This function takes arg a random string of numbers from 1 to 9.
	# and produces a sudoku solution.
	# Then it punches holes in that solution to create a sudoku puzzle
	result = ''
	sudoku_puzzle.map {
		|a|(i= (a =~/0/)) ?	
			(v = *?1..?9).fill {
				|j| v -= [a[j + i - (k = i % 9)] , 
						  a[k + j *= 9] , 
						  a[j % 26 + i - i % 3 - i % 27 + k]]
			} +
			v.map {
					|m| sudoku_puzzle . << $` << m <<$'
			}
		: result << a
	}
	result
end

def punch_holes(sudoku_solution)
	
end

def generate_sudoku_seed()
	# This function generates randomly a seed for a sudoku puzzle
	sudoku_seed = []
	puzzle = [0] * 81

	a = (1..9).sort_by{rand}
	b = (1..9).sort_by{rand}
	c = (1..9).sort_by{rand}

	puzzle[0..2] = a[0..2]
	puzzle[9..11] = a[3..5]
	puzzle[18..20] = a[6..8]

	puzzle[30..32] = b[0..2]
	puzzle[39..41] = b[3..5]
	puzzle[48..50] = b[6..8]

	puzzle[60..62] = b[0..2]
	puzzle[69..71] = b[3..5]
	puzzle[78..80] = b[6..8]

	puzzle.each_slice(9){
		|s| sudoku_seed.push(s)
	}
	return sudoku_seed
end

def print_sudoku(sudoku_puzzle) 
	result = "["
	newline = ""
	sudoku_puzzle.each {
		|s| result += newline + '[' + s.map!(&:to_s).join(" ")
		result += "]"
		newline = "\n "
	}
	result += "]"
	puts result
end

def print_sudoku_html(sudoku_puzzle)
	prettyTable = "<!DOCTYPE html>\n"
	prettyTable += "<html>\n"
	prettyTable += "<head>"
	prettyTable += "<style>"
	prettyTable += "table {"
	prettyTable += "    font-family: arial, sans-serif;"
	prettyTable += "    border-collapse: collapse;"
	#prettyTable += "    width: 100%;"
	prettyTable += "}"

	prettyTable += "td, th {"
	prettyTable += "    border: 1px solid #dddddd;"
	prettyTable += "    text-align: center;"
	prettyTable += "    padding: 16px;"
	prettyTable += "}"

	prettyTable += "</style>"
	prettyTable += "</head>"
	prettyTable += "<body>"

	prettyTable += "<table>"

	for index in 0 ... sudoku_puzzle.size
		prettyTable += "  <tr>"
		sudoku_puzzle[index].each {
			|t| prettyTable += "<td>#{t}</td>"
		}
		prettyTable += "  </tr>"
	end
	
	prettyTable += "</table>"

	prettyTable += "</body>"
	prettyTable += "</html>"

	File.write('sudoku_solution.html', prettyTable)
end

sudoku_puzzle = generate_sudoku_seed()

aaa = ["200370009009200007001004002050000800008000900006000040900100500800007600400089001"]
puts generate_sudoku_solution(aaa)
print_sudoku(sudoku_puzzle)
print_sudoku_html(sudoku_puzzle)

