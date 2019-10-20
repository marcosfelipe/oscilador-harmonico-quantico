## Problema:

Para uma função f(n), n sendo um número Natural, n ∈ {0, 1, 2...}, a função deve imprimir uma matriz quadrada para n (n por n), 
sendo que o número de elementos é n². A característica da matrix deve ser observada nos exemplos a seguir:

## Exemplos de saida: 

f(1) =>

|1|

f(2) => 

|1, 1|  
|1, 1|
 
f(3) =>

|1, 1, 1|  
|1, 2, 1|  
|1, 1, 1|

f(4) =>

|1, 1, 1, 1|  
|1, 2, 2, 1|  
|1, 2, 2, 1|  
|1, 1, 1, 1|

f(5) =>

|1, 1, 1, 1, 1|  
|1, 2, 2, 2, 1|  
|1, 2, 3, 2, 1|  
|1, 2, 2, 2, 1|  
|1, 1, 1, 1, 1|

## Condição para Solução!!
Deve ser utilizada no máximo UMA declaração de condição (if) ao percorrer os elementos. Ou seja, a solução deve ser uma função do elemento, deve-se evitar "conjunto de soluções". 

## Solução

O arquivo ohq_v2_debug.rb contém a solução usando a função de Oscilador Harmônico Quântico modificada. A função se comporta
de forma parecida quando transposto os elementos da matriz numa função, tendo para cada elemento um valor de x. A leitura da
esquerda para direita incrementa o indice, na ultima coluna muda contagem para a linha de baixo, indo para a primeira coluna.
Ex: 

matriz de 2x2:

|1(0), 1(1)|  
|1(2), 1(3)|

o valor entre parênteses representa o indice do elemento na função. De forma que, aplicando na função cada valor do elemento 
representa x em f(x).


## Issues
- A constante PROPAGATION deve ser transformada em função de N;
- A partir do tamanho 8x8 (n = 8) a matriz está incorreta, a equação do Oscilador Harmônico Quântico perde precisão, portanto precisa ser ajustada.
- Os polinômios de Hermite deve ser transformada em função de N;
