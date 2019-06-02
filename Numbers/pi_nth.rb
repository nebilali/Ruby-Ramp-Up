=begin
Find PI to the Nth Digit - Enter a number and have the program
generate PI up to that many decimal places. Keep a limit to how 
far the program will go.

Implemented using Spigot algorithm 
(https://en.wikipedia.org/wiki/Spigot_algorithm)
=end

def pi_nth (percision, limit=1000)
	# initalize state.
	q, r, t, k, n, l = 1, 0, 1, 1, 3, 3
	precision = [percision, limit].min
	num_digits = 0
	output = ""

	while num_digits <= precision
		if 4 * q + r - t < n * t
			# Add digit to output. 
			output << n.to_s

			# Update state.
			num_digits += 1
			q,r,n = [10*q, 10*(r-n*t), (10*(3*q+r))/t-10*n]

			# Add decimal only after first digit. 
			if (num_digits == 1)
				output << "." 
			end
		else
			# Update state.
			q,r,t,k,n,l = [q*k, (2*q+r)*l, t*l, k+1, 
			    (q*(7*k+2)+r*l)/(t*l), l+2]
		end
	end
	return output
end 

if __FILE__ == $0
	first_arg = ARGV[0]
	puts pi_nth(first_arg.to_i)
end