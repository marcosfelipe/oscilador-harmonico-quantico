# exemplo com matriz para o oscilador harmonico quantico

M = 2
W = 0.2
N = 1 # n ondas

# common factorial 
#def factorial(n)
#  if n == 0
#    1
#  else
#    n * factorial(n-1)
#  end
#end

# Ramanujan’s factorial approximation 
def factorial(n)
  fact = Math.sqrt(Math::PI)*(n/Math::E)**n
  fact *= (((8*n + 4)*n + 1)*n + 1.to_f/30)**(1.to_f/6)
end

# polinômios de Hermite:
#
# H\left(x,n\right)=\left\{n=0:1,n=1:2x,n=2:4x^{2}-2,n=3:8x^{3}-12x,n=4:16x^{4}-48x^{2}+12,n=5:32x^{5}-160x^{3}+120x,n=6:64x^{6}-480x^{4}+720x^{2}-120,n=7:128x^{7}-1344x^{5}+3360x^{3}-1680x,n=8:256x^{8}-3584x^{6}+13440x^{4}-13440x^{2}+1680,n=9:512x^{9}-9216x^{7}+48484x^{5}-80640x^{3}+30240x,n=10:1024x^{10}-23040x^{8}+161280x^{6}-403200x^{4}+302400x^{2}-30240\right\}
def H(x, n)
  case n
  when 1 
    2 * x
  when 2 
    4 * (x ** 2) - 2
  when 3 
    8 * (x ** 3) - (12 * x)
  when 4 
    16 * (x ** 4) - ((48 * x) ** 2) + 12
  else 
    1
  end
end

# funcao oscilador harmonico quantico
def wave(x, n)
  c1 = ((M * W) / Math::PI) ** (1 / 4)
  c2 = 1 / Math.sqrt((2 ** n) * factorial(n))
  c3 = H(Math.sqrt(M * W) * x, n)
  c4 = Math::E ** (- ((M * W * (x ** 2)) / 2))
  c1 * c2 * c3 * c4
end

def wave_prob(wave)
  wave.abs 
end

size = 4
elems = size * size
matrix = Array.new(size) { Array.new(size, 0) }
debug = []

elem = -(elems / 2).round
elem = -7.5

0.upto size - 1 do |l|
  0.upto size - 1 do |c|
    #matrix[l][c] = '%.2f' %  wave_prob(wave(elem, N))
    wave_value =  wave_prob(wave(elem, N))
    matrix[l][c] = wave_value.round
    debug << ('%.2f' % wave_value).rjust(5, ' ')
    elem += 1
  end
end

matrix.each { |l| puts l.inspect }
puts debug.inspect
puts debug.each_with_index.map { |_d, i| ('%.2f' % i).to_s.rjust(5, ' ') }.inspect


