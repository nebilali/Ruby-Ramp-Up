# Prime Factorization

=begin
Have the user enter a number and find all Prime Factors (if there are any)
and display them.
=end

def prime_factorization(n)
	p = 2 # initialize to first prime number.
	factors = []
	until n == 1
		if n % p == 0
			n /= p
			factors << p
		else
			p += 1
		end
	end
	factors
end

if __FILE__ == $0
	num = ARGV.first.to_i
	p prime_factorization(num)
end