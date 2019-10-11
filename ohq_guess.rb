# exemplo com matriz para o oscilador harmonico quantico

# input
$size = 8

# const 
M = 1

# vars
N = $size - 3 # n ondas

#OFFSET = ($size - 1) ** 1.74 - (-0.9) # wave offset
OFFSET = ($size ** 2) / 2.to_f - 0.5
#puts OFFSET

elems = $size * $size
$matrix = Array.new($size) { Array.new($size, 0) }
$debug = []

#elem = -(elems / 2).round
$start_x = 0 - OFFSET

$assert_matrix = [[0, 0, 0, 0, 0, 0, 0, 0],
				 [0, 1, 1, 1, 1, 1, 1, 0],
				 [0, 1, 2, 2, 2, 2, 1, 0],
				 [0, 1, 2, 3, 3, 2, 1, 0],
				 [0, 1, 2, 3, 3, 2, 1, 0],
				 [0, 1, 2, 2, 2, 2, 1, 0],
				 [0, 1, 1, 1, 1, 1, 1, 0],
				 [0, 0, 0, 0, 0, 0, 0, 0]]
$assert_matrix1 = [[0, 0, 0, 0], 
				  [0, 1, 1, 0], 
				  [0, 1, 1, 0],
				  [0, 0, 0, 0]]

$max_asserts = 0

# Ramanujan’s factorial approximation 
def factorial(n)
  fact = Math.sqrt(Math::PI)*(n/Math::E)**n
  fact *= (((8*n + 4)*n + 1)*n + 1.to_f/30)**(1.to_f/6)
end


# polinômios de Hermite:
#
# H\left(x,n\right)=\left\{n=0:1,n=1:2x,n=2:4x^{2}-2,n=3:8x^{3}-12x,

#n=4:16x^{4}-48x^{2}+12,

# n=5:32x^{5}-160x^{3}+120x,

#n=6:64x^{6}-480x^{4}+720x^{2}-120,

#n=7:128x^{7}-1344x^{5}+3360x^{3}-1680x,

#n=8:256x^{8}-3584x^{6}+13440x^{4}-13440x^{2}+1680,n=9:512x^{9}-9216x^{7}+48484x^{5}-80640x^{3}+30240x,n=10:1024x^{10}-23040x^{8}+161280x^{6}-403200x^{4}+302400x^{2}-30240\right\}
def H(x, n)
  case n
  when 1 
    2 * x
  when 2 
    4 * x ** 2 - 2
  when 3 
    8 * x ** 3 - (12 * x)
  when 4 
    #n=4:16x^{4}-48x^{2}+12,
    16 * x ** 4 - (48 * x ** 2) + 12
  when 5 
    32 * x ** 5 - (160 * x ** 3) + (120 * x)
  when 6
    64 * x ** 6 - (480 * x ** 4 ) + (720 * x ** 2) - 120
  when 7 
    256 * x ** 7 - (1344 * x ** 5) + (3360 * x ** 3) - (1680 * x)
  else 
    1
  end
end

# funcao oscilador harmonico quantico
def wave(x, m, w, s, p)
  c1 = ((m * w) / Math::PI) ** (1 / 4.to_f)
  c2 = 1.to_f / Math.sqrt((2 ** N) * factorial(N))
  c3 = H(Math.sqrt(m * w) * x * p, N)
  c4 = Math::E ** (- ((m * w * (x ** 2)) / 2.to_f))
  c1 * c2 * c3 * c4 * s
end

def wave_prob(wave)
  wave.abs ** 2
end

$p0 = 0.87
$p1 = 0.93
$w0 = 0.001
$w1 = 0.04
$s0 = 9
$s1 = 15

def guess_matrix(p, w, s)
	
	#PROPAGATION = 0.866
	#PROPAGATION = 0.884
	#PROPAGATION = p
	puts "p: #{p}"

	
	#W = 0.575 * ($size - 2.61) ** -1.94 # wave distribution
	#W = 0.0326
	#W = w
	puts "w: #{w}"

	#SCALE = 0.72 * ($size - 1.77) ** 1.59 # wave scale
	#SCALE = ($size - 2.5) * 1.8 
	#SCALE = ((($size - 0) ** 2) / 2.to_f) * 0.344
	#SCALE = (($size ** 2) / 2.to_f) * 0.412 - 1
	#SCALE = 9.1
	#SCALE = s
	puts "s: #{s}"

	asserts = 0

	$x = $start_x
	0.upto $size - 1 do |l|
	  0.upto $size - 1 do |c|
	    #matrix[l][c] = '%.2f' %  wave_prob(wave(elem, N))
	    wave_value =  wave_prob(wave($x, M, w, s, p))
	    $matrix[l][c] = wave_value.round
	    if $matrix[l][c] != $assert_matrix[l][c]
	    	puts "asserts: #{asserts}"
	    	if asserts > $max_asserts
	    		$max_asserts = asserts 
	    		$p0 = $p0 + ($p0 * 0.05)
	    		$p1 = $p1 - ($p1 * 0.05)
	    		$w0 = $w0 + ($w0 * 0.05)
	    		$w1 = $w1 - ($w1 * 0.05)
	    		$s0 = $s0 + ($s0 * 0.05)
	    		$s1 = $s1 - ($s1 * 0.05)
	    	end	
	    	return false
	    end

	    $debug << ('%.2f' % wave_value).rjust(5, ' ')
	    $x += 1
	    asserts += 1
	  end
	end

	$matrix.each { |l| puts l.inspect }

	puts $debug.inspect
	puts $debug.each_with_index.map { |_d, i| ('%.2f' % i).to_s.rjust(5, ' ') }.inspect

	true
end

def random(min, max)
	rand * (max - min) + min
end

find = false


while !find
	p = random($p0, $p1)
	w = random($w0, $w1)
	s = random($s0, $s1)
	find = guess_matrix(p, w, s)
	# p += 0.0000001
	# w += 0.000001
	# s += 0.000008
end

