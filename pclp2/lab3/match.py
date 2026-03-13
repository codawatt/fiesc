import sys,os


def set_l_r():
    l = int(input(" Dati primul numar: "))
    r = int(input(" Dati al doilea numar: "))
    return l,r
def adunare(l,r):
    print(str(l) + "+" + str(r) + "=" + str(l+r))
def scadere(l,r):
    print(str(l) + "-" + str(r) + "=" + str(l-r))
def inmultire(l,r):
    print(str(l) + "*" + str(r) + "=" + str(l*r))
def impartire(l,r):
    if r != 0:
        print(str(l) + "/" + str(r) + "=" + str(round(l/r,2)))
    else:
        print("Cannot divide by 0")
        


if __name__ == "__main__":

    l = 0
    r = 0
    print(str(l) + "+" + str(r))
    while True:
        print("Operatii cu numere întregi:")
        print("[C] citire 2 nr intregi")
        print("[+] adunare")
        print("[-] scadere")
        print("[*] inmultire")
        print("[/] impartire")
        print("[X] exit")
        enter = ''
        try:
            key = input("Select an option: ")
            key = key.upper()
            match key:
                case "C":
                    l,r  = set_l_r()
                case "+":
                    adunare(l,r)
                    enter = input("Press any key to continue")
                case "-":
                    scadere(l,r)
                    enter = input("Press any key to continue")

                case "*":
                    inmultire(l,r)
                    enter = input("Press any key to continue")

                case "/":
                    impartire(l,r)
                    enter = input("Press any key to continue")

                case "X":
                    break
            os.system("clear")
        except:
            os.system("clear")
            print("Error")