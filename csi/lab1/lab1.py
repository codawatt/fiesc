import string
from enum import Enum

class Encryption(Enum):
    ENCRYPT = 1,
    DECRYPT = 2
     
class Cypher(Enum):
    CAESAR = 1,
    VIGENERE = 2



def encrypt(m,k,e=Encryption.ENCRYPT, cyp = Cypher.CAESAR):
    encrypted_message = []
    i = 0
    k_list = list(k) if cyp == Cypher.VIGENERE else []
    for l in m:
        if l in alphabet:
            idx = alphabet.index(l)
            match e:
                case Encryption.ENCRYPT:
                    if cyp == Cypher.VIGENERE:
                        k = alphabet.index(k_list[i % len(k_list)])
                    new_idx = (idx + k) % 26
                    i += 1
                case Encryption.DECRYPT:
                    if cyp == Cypher.VIGENERE:
                        k = alphabet.index(k_list[i % len(k_list)])
                    new_idx = (idx - k) % 26                
            encrypted_message.append(alphabet[new_idx])
        else:
            encrypted_message.append(l)

    return "".join(encrypted_message) 


def crypt_ceasar(m,k):
    encrypted_message = []

    for l in m:
        if l in alphabet:
            idx = alphabet.index(l)
            new_idx = (idx + k) % 26
            encrypted_message.append(alphabet[new_idx])
        else:
            encrypted_message.append(l)

    return "".join(encrypted_message) 


def decrypt_ceasar(m,k):
    decrypted_message = []

    for l in m:
        if l in alphabet:
            idx = alphabet.index(l)
            new_idx = (idx - k) % 26
            decrypted_message.append(alphabet[new_idx])
        else:
            decrypted_message.append(l)

    return "".join(decrypted_message)


def crypt_vigenere(m,k):
    decrypted_message = []
    i = 0
    k_list = list(k)
    for l in m:
        if l in alphabet:
            m_idx = alphabet.index(l)
            k_idx = alphabet.index(k_list[i % len(k_list)])

            new_idx = (m_idx + k_idx) % 26
            decrypted_message.append(alphabet[new_idx])
            i += 1
        else:
            decrypted_message.append(l)

    return "".join(decrypted_message)


def decrypt_vigenere(m,k):
    decrypted_message = []
    i = 0
    k_list = list(k)
    for l in m:
        if l in alphabet:
            m_idx = alphabet.index(l)
            k_idx = alphabet.index(k_list[i % len(k_list)])

            new_idx = (m_idx - k_idx) % 26
            decrypted_message.append(alphabet[new_idx])
            i += 1
        else:
            decrypted_message.append(l)

    return "".join(decrypted_message)

def print_separator(n):
     sep = "=" * n
     print(sep)

if __name__ == "__main__":
    
    alphabet = list(string.ascii_uppercase)
    
    cuvant1 = "CALCULATOR" # k = 9
    cuvant2 = "DIGITAL SIGNATURE" # k = 3
    cuvant3 = "WIGYVMXEXIMR JSVQEXMSREPE" # k = 4
    cuvant4 = "YZKBKPUHY" # k = 6
     
    print_separator(100)
    k =  9
    message = list(cuvant1)
    print(cuvant1 , " este cryptat cu k=" , k , " in mesajul: " ,encrypt(cuvant1,k,Encryption.ENCRYPT,Cypher.CAESAR))
     
    print_separator(100)
    k = 3
    message = list(cuvant2)
    print(cuvant2 , " este cryptat cu k =" , k , " in mesajul:" ,crypt_ceasar(cuvant2,k))
     
    print_separator(100)
    message = list(cuvant3)
    # brute force 
    for i in range(20):
        k = i
        print(cuvant3 , " este decryptat cu k =" , k , " in mesajul:" ,decrypt_ceasar(cuvant3,k))
          
    print_separator(100)
    message = list(cuvant4)
    # brute force 
    for i in range(20):
        k = i
        print(cuvant4 , " este decryptat cu k =" , k , " in mesajul:" ,decrypt_ceasar(cuvant4,k))

    print_separator(100)
     
    print(crypt_vigenere("NU POT VENI AZI","FOCAR"))
    
    print_separator(100)
     
    print(crypt_vigenere("CRIPTOGRAFIE","TEST"))
     
    print_separator(100)
     
    print(crypt_vigenere("THE ART OF PROGRAMMING","PYTHON"))

    print_separator(100)
     
    print(decrypt_vigenere("PCWKPOVVIEMFPSOWROVABWTDI","PASSWORD"))
     
    print_separator(100)
     
    print(decrypt_vigenere("WRKADIXNBKUNJBZSMTMBVGXA","ENIGMA"))
