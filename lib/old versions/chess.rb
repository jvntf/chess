class Array
  # swap index of a & b of caller array
  # pry>  [1, 2, 3, 4, 5].swap!(0, 4)
  # pry>  [5, 2, 3, 4, 1]
  def swap!(a, b)
    self[a], self[b] = self[b], self[a]
    self
  end
end

def check_if_in_row(start, destination)

	if (32..39).include? start
		if (32..39).include? destination
			return true
		end
	elsif (56..63).include? start
		return true if (56..63).include? destination
	elsif (80..87).include? start
		return true if (80..87).include? destination
	elsif (104..111).include? start
		return true if (104..111).include? destination
	elsif (128..135).include? start
		return true if (128..135).include? destination
	elsif (152..159).include? start
		return true if (152..159).include? destination
	elsif (176..183).include? start
		return true if (176..183).include? destination
	else
		return false
	end
end

class Board
	BLACK = 1
	WHITE = 0
	attr_accessor :board_array
	attr_accessor :coordinate_hash
	def initialize
		@board_array = build_board
		@coordinate_hash=build_hash
		populate
	end

	def build_board
		array=[]
		black=1
		white=0
		@current_row=0
		small_row=0
		until array.length>168 do
			if @current_row%2==0 ||@current_row==0
				while true do
					if (small_row-1)%3==0
						array.push(Piece.new(1))
						array.push(Piece.new(0))
						if array.length%8==0
							small_row+=1
						end
					else
						array.push(build_space(1))
						array.push(build_space(0))
						if array.length%8==0
							small_row+=1
						end
					end
					if array.length%24==0 &&array.length>0
						@current_row+=1
						break
					end
				end
			else
				while true do
					if (small_row-1)%3==0
						array.push(Piece.new(0))
						array.push(Piece.new(1))
						if array.length%8==0
							small_row+=1
						end
					else
						array.push(build_space(0))
						array.push(build_space(1))
						if array.length%8==0
							small_row+=1
						end
					end
					if array.length%24==0 &&array.length>0
						@current_row+=1
						break
					end
				end
			end
		end
		return array

	end

	def populate
		#black pieces
		#convert pieces to appropriate classes and make appearance correct
		@board_array[@coordinate_hash["A1"]]=Rook.new(@board_array[@coordinate_hash["A1"]])
		@board_array[@coordinate_hash["A1"]].update("♜",3,1)

		@board_array[@coordinate_hash["B1"]]=Knight.new(@board_array[@coordinate_hash["B1"]])
		@board_array[@coordinate_hash["B1"]].update("♞",3,1)

		@board_array[@coordinate_hash["C1"]]=Bishop.new(@board_array[@coordinate_hash["C1"]])
		@board_array[@coordinate_hash["C1"]].update("♝",3,1)

		@board_array[@coordinate_hash["D1"]]=King.new(@board_array[@coordinate_hash["D1"]])
		@board_array[@coordinate_hash["D1"]].update("♛",3,1)

		@board_array[@coordinate_hash["E1"]]=Queen.new(@board_array[@coordinate_hash["E1"]])
		@board_array[@coordinate_hash["E1"]].update("♚",3,1)

		@board_array[@coordinate_hash["F1"]]=Bishop.new(@board_array[@coordinate_hash["F1"]])
		@board_array[@coordinate_hash["F1"]].update("♝",3,1)

		@board_array[@coordinate_hash["G1"]]=Knight.new(@board_array[@coordinate_hash["G1"]])
		@board_array[@coordinate_hash["G1"]].update("♞",3,1)

		@board_array[@coordinate_hash["H1"]]=Rook.new(@board_array[@coordinate_hash["H1"]])
		@board_array[@coordinate_hash["H1"]].update("♜",3,1)

		for i in @coordinate_hash["A2"]..(@coordinate_hash["H2"])
			@board_array[i]=Pawn.new(@board_array[i])
			@board_array[i].update("♟",3,1)
		end

		#white
		@board_array[@coordinate_hash["A8"]]=Rook.new(@board_array[@coordinate_hash["A8"]])
		@board_array[@coordinate_hash["A8"]].update("♖",3,0)

		@board_array[@coordinate_hash["B8"]]=Knight.new(@board_array[@coordinate_hash["B8"]])
		@board_array[@coordinate_hash["B8"]].update("♘",3,0)

		@board_array[@coordinate_hash["C8"]]=Bishop.new(@board_array[@coordinate_hash["C8"]])
		@board_array[@coordinate_hash["C8"]].update("♗",3,0)

		@board_array[@coordinate_hash["D8"]]=King.new(@board_array[@coordinate_hash["D8"]])
		@board_array[@coordinate_hash["D8"]].update("♕",3,0)

		@board_array[@coordinate_hash["E8"]]=Queen.new(@board_array[@coordinate_hash["E8"]])
		@board_array[@coordinate_hash["E8"]].update("♔",3,0)

		@board_array[@coordinate_hash["F8"]]=Bishop.new(@board_array[@coordinate_hash["F8"]])
		@board_array[@coordinate_hash["F8"]].update("♗",3,0)

		@board_array[@coordinate_hash["G8"]]=Knight.new(@board_array[@coordinate_hash["G8"]])
		@board_array[@coordinate_hash["G8"]].update("♘",3,0)

		@board_array[@coordinate_hash["H8"]]=Rook.new(@board_array[@coordinate_hash["H8"]])
		@board_array[@coordinate_hash["H8"]].update("♖",3,0)

		for i in @coordinate_hash["A7"]..(@coordinate_hash["H7"])
			@board_array[i]=Pawn.new(@board_array[i])
			@board_array[i].update("♙",3,0)
		end

	end

	def build_space(color)
		if color==0
			return "███████"
		elsif color==1
			return "       "
		end
	end

	def print_board
		puts "         A      B      C      D      E      F      G      H      "
		puts "    ____________________________________________________________"
		row=0
		#first row
		print "   |  "
		self.board_array.each_with_index do |space, index|
		 
			if (index)%8==0 && index>0
				puts "  |"
				row+=1 

				#print numbers on middle rows
				if (row-1)%3==0 || row-1==0
					print "#{row/3+1}  |  "
				else
					#beginning of line no row number
					print "   |  "
				end
			end

			#print value from array
			print space
		end
		print "  |"

		#end of the board
		puts "\n    ____________________________________________________________"
	end

	def build_hash
		calc_coordinates
		hash={}
		@board_array.each_with_index do |value,index|
			if value.class==Piece
				hash[value.coordinate]=index
			else
				next
			end
		end
		return hash
	end

	def calc_coordinates
		mastercount=1
		subcount=1
		@board_array.each_with_index do |value,index|
			if value.class==Piece
				case subcount
				when 1
					value.coordinate="A#{mastercount}"
					#puts "#{index} #{value.coordinate}"
				when 2
					value.coordinate="B#{mastercount}"
					#puts "#{index} #{value.coordinate}"
				when 3
					value.coordinate="C#{mastercount}"
					#puts "#{index} #{value.coordinate}"
				when 4
					value.coordinate="D#{mastercount}"
					#puts "#{index} #{value.coordinate}"
				when 5
					value.coordinate="E#{mastercount}"
					#puts "#{index} #{value.coordinate}"
				when 6
					value.coordinate="F#{mastercount}"
					#puts "#{index} #{value.coordinate}"
				when 7
					value.coordinate="G#{mastercount}"
					#puts "#{index} #{value.coordinate}"
				when 8
					value.coordinate="H#{mastercount}"
					#puts "#{index} #{value.coordinate}"
				else
					subcount +=1
				end
				subcount+=1
				if subcount>8
					subcount=1
					mastercount+=1
				end
			else 
				
			end
			
		end
	end

	def move(start,destination)
		initial = @board_array[@coordinate_hash[start]]
		target = @board_array[@coordinate_hash[destination]]
		#check if the piece to be move is a real piece
		if @board_array[@coordinate_hash[start]].check_type=="empty"
			puts "You are trying to move an empty space"
			invalid
			return
		#check to see if the move is valid
		elsif @board_array[@coordinate_hash[start]].verify(start,destination,@coordinate_hash)
			if @board_array[@coordinate_hash[destination]].occupied
				if initial.class==Pawn
					if initial.kill_verify(@coordinate_hash[start],@coordinate_hash[destination])
						puts "hello"
						valid_kill
						perform_move
					else
						puts "invalid"
						invalid
					return
					end
				end
				if initial.piece_color==target.piece_color
					puts "you cannot kill your own piece"
					puts "Press Enter to try again"
					wait=gets.chomp
					return
				else
					valid_kill
				end
			end
			perform_move(start,destination)
			#temp = @board_array[@coordinate_hash[start]]
			#start_color=@board_array[@coordinate_hash[start]].color
			#end_color=@board_array[@coordinate_hash[destination]].color
			#@board_array[@coordinate_hash[destination]]=temp
			#@board_array[@coordinate_hash[destination]].update(@board_array[@coordinate_hash[destination]].piece,end_color)
			#puts "appear"+@board_array[@coordinate_hash[destination]].appear
			#@board_array[@coordinate_hash[start]]=Piece.new(start_color)
			#puts "class"+@board_array[@coordinate_hash[start]].class.to_s
		#elsif initial.class==Pawn
		#	if initial.kill_verify(@coordinate_hash[start],@coordinate_hash[destination])
		#		perform_move(start,destination)
		#		valid_kill
		#	else
		#		invalid
		#	end
		#	return
		else
			invalid
			#puts "Invalid move, please consult the rules."
			#puts "Press Enter to try again"
			#wait=gets.chomp
		end
	end
	def perform_move(start,destination)
		temp = @board_array[@coordinate_hash[start]]
		start_color=@board_array[@coordinate_hash[start]].color
		end_color=@board_array[@coordinate_hash[destination]].color
		@board_array[@coordinate_hash[destination]]=temp
		@board_array[@coordinate_hash[destination]].update(@board_array[@coordinate_hash[destination]].piece,end_color)
			#puts "appear"+@board_array[@coordinate_hash[destination]].appear
		@board_array[@coordinate_hash[start]]=Piece.new(start_color)
	end
	def valid_kill
		puts "you killed your opponent's piece"
	end
	def invalid
		puts "Invalid move, please consult the rules."
		puts "Press Enter to try again"
		wait=gets.chomp
	end
 
end


class Piece
	attr_accessor :appear
	attr_accessor :coordinate
	attr_accessor :piece
	attr_accessor :color
	attr_accessor :occupied
	attr_accessor :type
	#0 is for black
	#1 is for white
	attr_accessor :piece_color
	def initialize(color)
		@piece=" "
		@coordinate="blah"
		@occupied=false
		@type=nil
		if color==0
			@appear="██ "+@piece+" ██"
			@color=0
		else
			@appear="   "+@piece+"   "
			@color=1
		end
	end

	def update(value,color=2, piece_color=2)
		@piece_color=piece_color if piece_color<2
		@color=color if color<2
		if value=="empty"
			@piece=" "
			@occupied=false
		else
			@piece=value
			@occupied=true
		end
		if @color==0
			@appear="██ #{@piece} ██"
			
		else
			@appear="   #{@piece}   "
		end
	end

#CHANGE THIS METHOD SO IT JUST SETS THE 
#TYPES WHEN POPULATING
# THIS METHOD IS POINTLESS

	def check_type
		case self.piece
		when "♖","♜"
			@type="rook"
			return "rook"
		when "♝","♗"
			@type="bishop"
			return "bishop"
		when "♘","♞"
			@type="knight"	
			return "knight"
		when "♕","♛"
			@type="king"
			return "king"
		when "♔","♚"
			@type="queen"
			return "queen"
		when "♙","♟"
			@type="pawn"
			return "pawn"
		
		else
			return "empty"
		end
	end

	def to_s
		return @appear
	end

end

class Pawn < Piece

	def initialize(piece)
		@piece=piece.piece
		@coordinate=piece.coordinate
		@type=piece.type
		@color=piece.color
		@appear=piece.appear
	end


	def verify(start,destination, coordinate_hash)
		if (coordinate_hash[destination]-coordinate_hash[start])==24
			if @piece_color==1
				return true
			else
				puts "You can't move a Pawn backwards."
				return false
			end
		elsif (coordinate_hash[destination]-coordinate_hash[start])==-24
			if @piece_color==0
				return true
			else
				puts "You can't move a Pawn backwards."
				return false
			end
		else
			return false
		end
	end

	def kill_verify(start_index, destination_index)
	
		if (destination_index-start_index).abs==25 || (destination_index-start_index).abs==23
			return true
		else
			puts "Pawns can only kill diagnally"
			return false
		end
	end
end

class Rook < Piece

	def initialize(piece)
		@piece=piece.piece
		@coordinate=piece.coordinate
		@type=piece.type
		@color=piece.color
		@appear=piece.appear
	end


	def verify(start,destination, coordinate_hash)
		if (coordinate_hash[destination]-coordinate_hash[start]).abs%24==0
			return true
		elsif check_if_in_row(coordinate_hash[start],coordinate_hash[destination])
			return true
		else
			return false
		end
	end
end

class Knight < Piece

	def initialize(piece)
		@piece=piece.piece
		@coordinate=piece.coordinate
		@type=piece.type
		@color=piece.color
		@appear=piece.appear
	end


	def verify(start,destination, coordinate_hash)

		case (coordinate_hash[destination]-coordinate_hash[start]).abs
		when 22 then return true
		when 26 then return true
		when 47 then return true
		when 49 then return true
		else
			return false
		end
	end
end

class Bishop < Piece

	def initialize(piece)
		@piece=piece.piece
		@coordinate=piece.coordinate
		@type=piece.type
		@color=piece.color
		@appear=piece.appear
	end


	def verify(start,destination, coordinate_hash)
		if ((coordinate_hash[destination]-coordinate_hash[start]).abs)%23==0
			return true
		elsif ((coordinate_hash[destination]-coordinate_hash[start]).abs)%25==0
			return true
		else
			return false
		end
	end
end

class King < Piece
	def initialize(piece)
		@piece=piece.piece
		@coordinate=piece.coordinate
		@type=piece.type
		@color=piece.color
		@appear=piece.appear
	end


	def verify(start,destination, coordinate_hash)
		case (coordinate_hash[destination]-coordinate_hash[start]).abs
		when 1 then return true
		when 24 then return true
		else
			return false
		end
	end
end

class Queen < Piece

	def initialize(piece)
		@piece=piece.piece
		@coordinate=piece.coordinate
		@type=piece.type
		@color=piece.color
		@appear=piece.appear
	end


	def verify(start,destination,coordinate_hash)
		if verify_bishop(start,destination, coordinate_hash)
			return true
		elsif verify_rook(start,destination, coordinate_hash)
			return true
		else 
			return false
		end
	end

	def verify_bishop(start,destination, coordinate_hash)
		if ((coordinate_hash[destination]-coordinate_hash[start]).abs)%23==0
			return true
		elsif ((coordinate_hash[destination]-coordinate_hash[start]).abs)%25==0
			return true
		else
			return false
		end
	end

	def verify_rook(start,destination, coordinate_hash)
		if ((coordinate_hash[destination]-coordinate_hash[start]).abs)%23==0
			return true
		elsif ((coordinate_hash[destination]-coordinate_hash[start]).abs)%25==0
			return true
		else
			return false
		end
	end
end

#--------------
board = Board.new


##ADD VERIFICATION OF TURN
#ADD BUCKETS FOR DEAD PIECES
#CHECK MATTE
while true do
	board.print_board
	puts "White move:"
	move=gets.chomp.upcase.split(",")
	break if move.length==1
	board.move(move[0],move[1])
	board.print_board
	puts "Black move:"
	move=gets.chomp.upcase.split(",")
	break if move.length==1
	board.move(move[0],move[1])
end



