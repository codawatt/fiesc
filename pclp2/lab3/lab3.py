import os
from random import randrange



def separator(num="1", char="=", msg="Ex", en=""):
    print( char * 50 + msg + num + char * 50)
    print(en)

def set_val(val, name="N"):
    print (name + " = " + str(val))
    return val

def main():
    os.system('clear')
    separator (num="",msg="For")
    separator(num="1",en="Executați și analizați scriptul de la Ex. 1")
    n = set_val(15)
    for i in range(n):
        print(i, end=' ')
    print("\n")

    separator('2a', en="Primele n numere naturale în ordine descrescătoare")
    for i in range(n):
        print(n-i, end= ' ')
    print("\n")

    separator('2b', en="Toate numerele impare în intervalul (0,n)")
    for i in range(n):
        if i % 2 == 1:
            print(i, end= ' ')
    print("\n")

    separator('2c', en="produsul primelor n numere naturale (factorialul unui număr)")
    factor = 1 
    n = set_val(randrange(5,10))
    for i in range(1,n+1):
        factor *= i
    print( str(n) + "!= " + str(factor))
    print("\n")

    separator('2d', en="Suma numerelor din intervalul (0,n] divizibile cu un număr x citit de la tastatură")
    n = set_val(15)
    x = set_val(randrange(2,6),name="X")
    suma = 0
    print("Numerele divizibile cu", x, ":")
    for i in range(n):
        if i % x == 0:
            print(i, end=' ')
            suma += i
    print("\n")
    print("Suma numerelor divizibile cu", x, "este =", suma)

    print("\n")

    separator("3", en="Se citește de la tastatura un număr natural. Să se calculeze suma cifrelor sale")
    n = set_val(randrange(1000,10000))
    suma = 0

    for i in range(len(str(n))):
        suma = suma + n % 10
        n = n // 10

    print(suma)
    print("\n")

    separator("4", en="Scrieți un program pentru a calcula suma serielor unui numar x, citit de la tastatura, până la n termeni")
    n = set_val(randrange(2,5)) 
    x = set_val(randrange(1,10), "X")
    char = '1'
    suma = 0
    msg = ""
    for i in range(1,n+1):
        msg = msg + "+" +  str(int(char * i) * x)
    msg = msg[1:]

    for i in range(1,n+1):
        product = int(char * i) * x 
        suma += product
    print(msg +"="+str(suma))


    separator (num="",msg="While")
    
    separator (num="1" ,en="Să se citească de la tastatură un șir de numere încheiat cu numărul 0 și să se calculeze suma lor.")
    
    n = randrange(1,10)
    msg = ""
    suma = 0
    while n > 0:
        msg = msg + '+' +str(n)
        suma += n
        n = randrange(0,10)
    msg = msg[1:]
    print(msg + "=" + str(suma))

    separator (num="2" ,en="Scrieți un program pentru a introduce un număr și afisati reversul acestuia")

    n = set_val(randrange(100,1000))
    reverse = ""
    while n > 0:
        digit = n % 10
        reverse += str(digit)
        n = n // 10
    print(reverse) 

    separator (num="3" ,en="Să se scrie un program care calculează şi afişează valoarea polinomului p(x)=3x2-7x-10 pentru x=1,2,....,10.")
    
    #x = set_val(1, "X")
    x = 1
    while x <= 10:
        rez = 3 * x ** 2 - 7 * x - 10
        print (f"p{x}=3*{x}^2-7*{x}-10={rez}")
        x += 1

    separator(num='', msg='Extra')
    separator(num="1",en="Care este valoarea expresiei")

    k = 1
    suma = 0
    while k <= 20:
        putere = k ** k
        suma += putere
        k += 1
    print(suma)

    separator(num="2",en="Scrie un program in Python care va afisa pe consola caracterele ca in figura de mai jos.")
    n = set_val(6)
    i = 1
    msg = ''
    while i < n*2:
        if (n *2)  % i == 0:
            msg += "*"
        if (n * 2) % i != 0:
            msg = msg[-1:]
        print(msg)
        i += 1


if __name__ == "__main__":
    main()