from enum import Enum
from random import randrange
from math import sqrt
class Strategy(Enum):
	AUTO = 1
	INPUT = 2

def print_separator(ex:str):

	separator = "=" * 25 + ex + "=" * 25
	print(separator)

def exemplu3(strategy=Strategy.AUTO):
	x = ""
	y = ""

	match strategy:
		case Strategy.AUTO:
			x = str(randrange(1,10)) # de la 1 pana la 9
			y = str(randrange(1,10)) # de la 1 pana la 9
		case Strategy.INPUT:
			x = input("x=")
			y = input("y=")

	print("Concatenare prin \",\"")
	print(x,y)
	print("Concatenare prin operatorul \"+\"")
	print(x+y)
	print("Cast din tipul de date string in tip float")
	x=float(x)
	y=float(y)
	print("Suma de tip float")
	print(x+y)		
	
def suplimentar1(strategy=Strategy.AUTO):
	arr = []
	n_input = ""
	message = ""
	n = 1
	match strategy:
		case Strategy.AUTO:
			n = str(randrange(1,10))
			for i in range(int(n)):
				message = "arr["+str(i)+"]="
				arr.append(randrange(1,10))
				print(message + str(arr[i]))

		case Strategy.INPUT:
			n_input =  input("Dimensiune array= ")
			n = str(n_input)

			for i in range(int(n)):
				message = "arr["+str(i)+"]="
				arr.append(input(message))

	print(arr)

def suplimentar2(strategy=Strategy.AUTO):
	a = 1
	b = 1

	match strategy:
		case Strategy.AUTO:
			incercari = randrange(1,30)
			for i in range(incercari+1):
				a = randrange(-9,10) 
				b = randrange(-9,10) 
				rezultat = ecuatie_grad1(a,b)
				rezultat_f = "%.2f" % rezultat if type(rezultat) is float else rezultat
				message =str(a)+"x" + str(b) +" = 0, " + "x="+ str(rezultat_f)
				if a >= 0:
					print(" " + message)
				else:
					print(message)

		case Strategy.INPUT:
			print("INPUT not implemented")

def suplimentar3(strategy=Strategy.AUTO):
	a = 1
	b = 1

	match strategy:
		case Strategy.AUTO:
			incercari = randrange(1,30)
			for i in range(incercari+1):
				a = randrange(-9,10) 
				b = randrange(-9,10) 
				rezultat = ecuatie_grad1(a,b)
				rezultat_f = "%.2f" % rezultat if type(rezultat) is float else rezultat
				message =str(a)+"x" + str(b) +" = 0, " + "x="+ str(rezultat_f)
				if a >= 0:
					print(" " + message)
				else:
					print(message)

		case Strategy.INPUT:
			print("INPUT not implemented")

def ecuatie_grad1(a,b):

	if a == 0 and b != 0:
		return "Imposibil"
	if a == 0 and b == 0:
		return "Orice x real posibil"
	return -(b/a)

def ecuatie_grad2(a,b,c):
	
	rezultate = []

	x1 = (-b + sqrt(b**2 - 4*a*c))/ (2*a)
	x2 = (-b - sqrt(b**2 - 4*a*c))/ (2*a)
	
	rezultate.append(x1)
	rezultate.append(x2)

print_separator("Exemplu 1")
print("Print prin separare linii cu \";\"")
print("Hello"); print("world")
print("Print prin separare linii cu \"\\\"")
print("Welcome to" \
	  " PCLP2 Course "\
	  "Enjoy!")

print_separator("Exemplu 2")

print("Acest print a fost scris cu functia \"print()\" deoarece \"prinT()\" rezulta in eroare sintactica")

print_separator("Exercitiu 1")
print("PCLP2 - laborator 1!")
print("Rezultatul operatiei 7 x 5 - 5:2 este: ")
print(7*5 - 5/2)
print("Sfarsit")
print_separator("Exemplu 3")
print("Preluare de date de tip \"sir de caracter/string\"")
exemplu3(Strategy.AUTO)

print_separator("Suplimentar 1")
suplimentar1(Strategy.AUTO)

print_separator("Suplimentar 2 Ecuatii de gradul 1")
suplimentar2()

print_separator("Suplimentar 3 Ecuatii de gradul 2")
suplimentar3()
