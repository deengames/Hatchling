require 'ostruct'

class InputSystem	

	def initialize(entities, player)
		@player = player
		@entities = entities
	end	
	
	def destroy
	end

	def get_input
		Keys.read_character
	end
	
	def get_and_process_input		
		input = Keys.read_character
		target = OpenStruct.new({ x: @player.x, y: @player.y })
		if (input == 'up') then
			target.y -= 1
		elsif (input == 'down') then
			target.y += 1
		elsif (input == 'left') then
			target.x -= 1
		elsif (input == 'right')
			target.x += 1
		end
		
		if is_movable?(target.x, target.y)
			@player.x = target.x
			@player.y = target.y
		end
		
		return input
	end
	
	def is_movable?(x, y)
		map = Game.instance.current_map
		player = @player
		
		return false if map['perimeter'] == true && (x == 0 || x == map['width'] - 1 || y == 0 || y == map['height'] - 1)
		return false if (x < 0 || x >= map['width'] || y < 0 || y >= map['height'])
				
		@entities.each do |e|
			return false if x == e.x && y == e.y && (!e.has?(:solid) || e.solid == true)
		end		
		
		return true
	end
end
