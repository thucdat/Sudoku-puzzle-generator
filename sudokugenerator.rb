def generate_sudoku_puzzle()
    # This function creates a complete filled Sudoku
    maxTries    = 100 #stops the program after 100 attempts
    count       = 9999
    puzzle      = []
    while count > maxTries do    # To trigger the creation of the Sudoku
        # Initialize the 9x9 array with 0
        puzzle = []
        for r in 1..9
            puzzle << ([0] * 9)
        end
        
        # Fill the 9x9 array with unique values from 1 to 9
        # in the units (rows, columns, and 3x3 sub arrays)
        myRand = Random.new
        for row in 0..8
            for col in 0..8
                thisRow = puzzle[row]
                thisCol = []
                for r in 0..8
                    thisCol << puzzle[r][col]
                end
                subRow, subCol = row/3, col/3
                subArr = []
                for subR in 0..2
                    for subC in 0..2
                        subArr << puzzle[subRow*3 + subR][subCol*3 + subC]
                    end
                end
                randVal, count = 0, 0
                # Attemp to fill the Sudoku Array with valid numbers
                while (thisRow.include?(randVal) or thisCol.include?(randVal) or subArr.include?(randVal))
                    randVal = myRand.rand(1..9)
                    count += 1
                    if count > maxTries
                        break
                    end
                end
                if count > maxTries
                    break
                end
                # Fill the Sudoku Array with found unique number
                puzzle[row][col] = randVal
            end
            if count > maxTries
                break
            end
        end
    end
    return puzzle
end

def print_puzzle(puzzle)
    # This function prints a puzzle
    print "["
    for r in 0..8
        print puzzle[r], "\n"
    end
	puts "]"
end

def print_sudoku_html(sudoku_puzzle, filename)
	# This function prints a sudoku puzzle in a html
	# file with borders, it fills the empty with underscores.

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
			|t| prettyTable += "<td>" + (t.to_s() == "0" ? "_" : t.to_s()) + "</td>"			
		}
		prettyTable += "  </tr>"
	end
	
	prettyTable += "</table>"

	prettyTable += "</body>"
	prettyTable += "</html>"

	File.write(filename, prettyTable)
end

def punch_holes(puzzle)
    myRand = Random.new
    1.upto(64) do
        aRand = myRand.rand(0..80)
        row = aRand / 9
        col = aRand % 9
        puzzle[row][col] = 0
    end
    return puzzle
end

def array_has_unique_1_to_9(anArray)
	result = TRUE
	for elem in 1..9
		result &= anArray.count(elem) == 1
		if not result
			raise "Element " + anArray[elem].to_s() + " is not unique" +
			      "in array" + anArray.to_s()
		end
	end
	return result
end	

def test_a_sukodu(puzzle)
	# This function tests if a 9x9 Array conforms to the
	# rule of sudoku.
	# It test if every units (row, col, and subarray of 3x3) contains
	# only unique digits from 1 to 9.
	for row in 0..8
		for col in 0..8
			thisRow = puzzle[row]
			result = array_has_unique_1_to_9(thisRow)
			thisCol = []
			for r in 0..8
				thisCol << puzzle[r][col]
			end
			result &= array_has_unique_1_to_9(thisCol)
			subRow, subCol = row/3, col/3
			subArr = []
			for subR in 0..2
				for subC in 0..2
					subArr << puzzle[subRow*3 + subR][subCol*3 + subC]
				end
			end
			result &= array_has_unique_1_to_9(subArr)
		end
	end
	if result
		puts "This Sudoku conforms to the rule"
	end
end

def aSampleTest()
	sudoku = [
	[4, 7, 5, 8, 1, 6, 3, 2, 9],
	[6, 3, 2, 7, 9, 5, 4, 1, 8],
	[9, 8, 1, 4, 3, 2, 7, 5, 6],
	[8, 4, 9, 5, 2, 3, 6, 7, 1],
	[7, 2, 6, 1, 8, 9, 5, 3, 4],
	[1, 5, 3, 6, 7, 4, 9, 8, 2],
	[5, 1, 8, 9, 4, 7, 2, 6, 3],
	[2, 9, 7, 3, 6, 1, 8, 4, 5],
	[3, 6, 4, 2, 5, 8, 1, 9, 7]
	]

	test_a_sukodu(sudoku)
end

complete_puzzle = generate_sudoku_puzzle()
test_a_sukodu(complete_puzzle)
print_puzzle(complete_puzzle)
sudoku_puzzle = punch_holes(complete_puzzle)
print_puzzle(sudoku_puzzle)
print_sudoku_html(sudoku_puzzle, "prettyTable.html")
