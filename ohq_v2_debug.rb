# exemplo com matriz para o oscilador harmonico quantico

# input
size = 8

# const 
M = 1
#PROPAGATION = 0.866
PROPAGATION = 0.884

# vars
N = size - 3 # n ondas
W = 0.575 * (size - 2.61) ** -1.94 # wave distribution
#W = 0.0326
puts W

#SCALE = 0.72 * (size - 1.77) ** 1.59 # wave scale
#SCALE = (size - 2.5) * 1.8 
#SCALE = (((size - 0) ** 2) / 2.to_f) * 0.344
SCALE = ((size ** 2) / 2.to_f) * 0.412 - 1
#SCALE = 9.1
puts SCALE

#OFFSET = (size - 1) ** 1.74 - (-0.9) # wave offset
OFFSET = (size ** 2) / 2.to_f - 0.5
#puts OFFSET


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
def wave(x)
  c1 = ((M * W) / Math::PI) ** (1 / 4.to_f)
  c2 = 1.to_f / Math.sqrt((2 ** N) * factorial(N))
  c3 = H(Math.sqrt(M * W) * x * PROPAGATION, N)
  c4 = Math::E ** (- ((M * W * (x ** 2)) / 2.to_f))
  c1 * c2 * c3 * c4 * SCALE
end

def wave_prob(wave)
  wave.abs ** 2
end

elems = size * size
matrix = Array.new(size) { Array.new(size, 0) }
debug = []

#elem = -(elems / 2).round
x = 0 - OFFSET

0.upto size - 1 do |l|
  0.upto size - 1 do |c|
    #matrix[l][c] = '%.2f' %  wave_prob(wave(elem, N))
    wave_value =  wave_prob(wave(x))
    matrix[l][c] = wave_value.round
    debug << ('%.2f' % wave_value).rjust(5, ' ')
    x += 1
  end
end

matrix.each { |l| puts l.inspect }

puts debug.inspect
puts debug.each_with_index.map { |_d, i| ('%.2f' % i).to_s.rjust(5, ' ') }.inspect


