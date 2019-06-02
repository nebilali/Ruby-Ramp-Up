
# Unit Converter (temp, currency, volume, mass and more)

=begin
Converts various units between one another. The user enters the type of
unit being entered, the type of unit they want to convert to and then the 
value. The program will then make the conversion.
=end

class Unit
	def initialize (value, suffix)
		@value = value
		@suffix = suffix
		@convert_map
	end

	def convert (length_unit)
		return @convert_map[length_unit].(@value)
	end

	def to_s 
		"#{@value} #{@suffix}"
	end
end

class Length < Unit
end

class Inch < Length
	def initialize (value, suffix='in')
		super
		@convert_map = {
			'ft' => ->(x){ Feet.new( x.fdiv(12) ) },
			'yd' => ->(x){ Yards.new( x.fdiv(36) ) }
		}
	end
end

class Feet < Length
	def initialize (value, suffix='ft')
		super
		@convert_map = {
			'in' => ->(x){ Inch.new(x * 12) },
			'yd' => ->(x){ Yards.new(x.fdiv(36)) }
		}
	end
end

class Yards < Length
	def initialize (value, suffix='yd')
		super
		@convert_map = {
			'in' => ->(x){ Inch.new(x * 36) },
			'ft' => ->(x){ Yards.new(x * 3) }
		}
	end
end

class Temp < Unit 
end

class Celsius < Temp
	def initialize (value, suffix='C')
		super
		@convert_map = {
			'F' => ->(x){ Fahrenheit.new(x * 9.fdiv(5) + 32) },
		}
	end
end

class Fahrenheit < Temp
	def initialize (value, suffix='F')
		super
		@convert_map = {
			'C' => ->(x){ Celsius.new((x - 32) * 5.fdiv(9)) },
		}
	end
end

class UnitConverter 
	def convert (unit, converting_unit, value)
		init_map = {
			'in' => Inch.new(value),
			'ft' => Feet.new(value), 
			'yds' => Yards.new(value),
			'C' => Celsius.new(value),
			'F' => Fahrenheit.new(value)
		}

		return "Unconvertable input units." unless 
		valid?(init_map[unit], init_map[converting_unit])

		init_map[unit].convert(converting_unit).to_s
	end

	def valid? (unit, converting_unit)
		unit.class.superclass.equal?(converting_unit.class.superclass)
	end
end

if __FILE__ == $0
	unit, converting_unit, value = ARGV
	puts UnitConverter.new.convert(unit, converting_unit, value.to_f)
end