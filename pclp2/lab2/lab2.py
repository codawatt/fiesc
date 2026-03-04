import os
import math

def separator(value:str,c='=',name="Ex",amount= 25) -> None:
	print(c * amount + name + str(value)+ c* amount)

if __name__ == "__main__":
    
	run = True
	while run:
		
		separator("", c="*", name = "Meniu")

		print(
			"1. Exemplu1\n"
			"2. Ex1a\n"
			"3. Ex1b\n"
			"4. Ex2\n"
			"5. Ex3\n"
			"6. Exemplu2\n"
			"Exercitii propuse\n"
			"7. Ex1\n"
			"8. Ex2\n"
			"9. Ex3\n"
			"10. Ex4\n"
			"11. Ex5\n"
			"12. Ex6\n"
			"13. Ex7\n"
			"14. Ex8\n"
			"15. Ex9\n"
			"16. Ex10\n"
			"17. Ex11\n"
			"99. clear\n"
			"0. exit"
		)
		try:
			alegere = int(input("Alege un exercitiu:"))
			os.system("clear")
			match alegere:
				case 1:
					separator("1", name='Exemplu')
					x=input("x=") 
					y=input("y=")
					print(x,y)
					print(x*5,y*3)
					print(x+y)
					x=float(x)
					y=float(y)
					print("x=%f, y=%f, x ? y = %d" % (x,y,int(x)**int(y)))
					print("%d" % (x/y))
					print(x//y)
					x=int(input("x="))
					y=int(input("y="))
					print(x/y)
					print("%.2f" % (x/y))
				case 2: 
					separator("1a")
					print("+ adunare\n" \
					"* inmultire\n" \
					"** putere\n" \
					"/ impartire\n" \
					"// impartire fara rest" \
					"")
				case 3: 
					separator("1b")

					x = 2
					y = 3

					print(x/y)
					print("%.2f" % (x/y))
				case 4: 
					separator("2")

					sir1 = "Ana"
					sir2 = "are"
					sir3 = "mere"
					sep = "---"

					print(sir1 + sep + sir2 + sep + sir3)
				case 5:
					separator("3")
					caracter = input("Dati un numar intreg de convertit in hex:")
					try:
						print(hex(int(caracter)))

					except ValueError:
						print("Error")
				case 6:
					separator("2", name="Exemplu")
					x=int(input("x="))
					y=(input("y="))
					sum = x+int(y)
					print(sum)
					if sum > 0:
						print("suma este pozitiva")
					else:
						print("suma este negativa")
				case 7: 
					separator("1")
					try:
						a = int(input("Dati un numar intreg: "))
						
						if a >= 100:
							print("Numarul " + str(a) + " in octal: " + str(oct(a)))
						else:
							print("Numarul " + str(a) + " in hexadecimal: " + str(hex(a)))
					except ValueError:
						print("Error")
				case 8: 
					separator("2")
					print("Ecuatie de grad 1: ax + b = 0")

					try:
						a = int(input("Dati valoarea lui a: "))
						b = int(input("Dati valoarea lui b: "))

						if a != 0:
							print(str(a)+"x + " + str(b)+" = 0")
							print("x=" + str(-b/a))
						else:
							print("imposibil")
					except ValueError:
						print("Error")
				case 9: 
					separator("3")
					try:
						
						n1 = int(input("Dati valoarea lui n1: "))
						n2 = int(input("Dati valoarea lui n2: "))
						n3 = int(input("Dati valoarea lui n3: "))
						if n1+1 == n2 and n1+2 == n3:
							print("Numerele sunt consecutive")
						else:
							print("Numerele nu sunt consecutive")
					except ValueError:
						print("Error")

				case 10: 
					separator("4")
					try:
						a = int(input("Dati un numar intreg: "))
						if a % 2 == 0:
							print("Numarul este par")
						else:
							print("Numarul este impar")
					except ValueError:
						pass
				case 11: 
					separator("5")
					try:
						r = float(input("Dati raza unei sfere: "))
						volum = 4/3 * math.pi * (r ** 3)
						aria = 4 * 3.14 * (r**2)
						print("Volum: %.2f" % volum)
						print("Arie totala: %.2f " % aria)
					except ValueError:
						pass
				case 12: 
					separator("6")
	
					try:
						n1 = int(input("Dati n1: "))
						n2 = int(input("Dati n2: "))

						if n1 > n2:
							print("Max:",n1)
							print("Min",n2)
						elif n2 > n1:
							print("Max:",n2)
							print("Min",n1)
						else:
							print("Numerele sunt egale")
					except ValueError:
						pass
				case 13: 
					separator("7")

					try:
						nr = int(input("Dati un numar: "))
						min_interval = int(input("Dati minim interval "))
						max_interval = int(input("Dati maxim interval "))
						
						if  nr >= min_interval and nr <= max_interval:
							print("Numarul ",nr," apartine intervalului (",min_interval,":",max_interval,")." )
						else:
							print("Numarul",nr,"nu apartine intervalului(",min_interval,":",max_interval,")." )
					except ValueError:
						pass
				case 14: 
					separator("8")
					print("Ecuatie de grad 1: ax + b = 0")

					try:
						a = int(input("Dati valoarea lui a: "))
						b = int(input("Dati valoarea lui b: "))

						if a != 0:
							print(str(a)+"x + " + str(b)+" = 0")
							print("x=" + str(-b/a))
						else:
							print("imposibil")
					except ValueError:
						print("Error")
				case 15:
					separator("9")
					print("Ecuatie de gradul 2: ax^2 + bx + c = 0")

					try:
						a = float(input("Dati valoarea lui a: "))
						b = float(input("Dati valoarea lui b: "))
						c = float(input("Dati valoarea lui c: "))

						if a == 0:
							print("imposibil")
						else:
							print(f"{a}x^2 + {b}x + {c} = 0")

							x = b * b - 4 * a * c
							if x > 0:
								x1 = (-b + math.sqrt(x)) / (2 * a)
								x2 = (-b - math.sqrt(x)) / (2 * a)
								print("Doua solutii reale distincte:")
								print("x1 =", x1)
								print("x2 =", x2)
							elif x == 0:
								x = (-b) / (2 * a)
								print("O solutie reala dubla:")
								print("x =", x)
							else:
								x1 = (-b + math.sqrt(x)) / (2 * a)
								x2 = (-b - math.sqrt(x)) / (2 * a)
								print("Doua solutii complexe:")
								print("x1 =", x1)
								print("x2 =", x2)

					except ValueError:
						print("Error")

				case 16:
					separator("10")
					print("Cititi 3 numere si determinati maximul, minimul si ordinea crescatoare.")

					try:
						n1 = int(input("Dati n1: "))
						n2 = int(input("Dati n2: "))
						n3 = int(input("Dati n3: "))

						numar_maxim = max(n1, n2, n3)
						numar_minim = min(n1, n2, n3)

						print("Maxim:", numar_maxim)
						print("Minim:", numar_minim)

						v = [n1, n2, n3]
						v.sort()
						print("In ordine crescatoare:", v[0], v[1], v[2])

					except ValueError:
						print("Error")

				case 17:
					separator("11")
					print("Determinarea cadranului pentru punctul (x, y).")

					try:
						x = float(input("Dati coordonata x: "))
						y = float(input("Dati coordonata y: "))

						if x == 0 and y == 0:
							print("Punctul este in origine (nu apartine niciunui cadran).")
						elif x == 0 or y == 0:
							print("Punctul este pe una dintre axe (nu apartine niciunui cadran).")
						elif x > 0 and y > 0:
							print("Cadranul 1")
						elif x < 0 and y > 0:
							print("Cadranul 2")
						elif x < 0 and y < 0:
							print("Cadranul 3")
						else:  # x > 0 and y < 0
							print("Cadranul 4")
					except ValueError:
						print("Error")
				case 99: 
					os.system('clear')
				case 0:
					run = False
			if run: etr = input("Press enter to continue")
			os.system('clear')
		except ValueError:
			os.system('clear')
			print("Not an int")
