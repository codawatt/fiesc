import string

def playfair(password='') -> list:
    alphabet = "ABCDEFGHIKLMNOPQRSTUVWXYZ" 
    password = password.upper().replace('J', 'I')

    key = ""
    for c in password:
        if c in alphabet and c not in key:
            key += c

    for c in alphabet:
        if c not in key:
            key += c

    matrix = []
    k = 0
    for _ in range(5):
        row = []
        for _ in range(5):
            row.append(key[k])
            k += 1
        matrix.append(row)

    return matrix


def find_position(matrix, ch):
    for i in range(5):
        for j in range(5):
            if matrix[i][j] == ch:
                return i, j
    raise ValueError(f"Character {ch} not found in matrix")

def prepare_text(text):
    text = text.upper().replace('J', 'I')
    cleaned = ""

    for ch in text:
        if ch in string.ascii_uppercase:
            cleaned += ch

    result = ""
    i = 0
    while i < len(cleaned):
        a = cleaned[i]

        if i + 1 < len(cleaned):
            b = cleaned[i + 1]
            if a == b:
                result += a + 'X'
                i += 1
            else:
                result += a + b
                i += 2
        else:
            result += a + 'X'
            i += 1

    return result


def encrypt_playfair(text, matrix):
    text = prepare_text(text)
    encrypted = ""

    for i in range(0, len(text), 2):
        a = text[i]
        b = text[i + 1]

        row1, col1 = find_position(matrix, a)
        row2, col2 = find_position(matrix, b)

        if row1 == row2:
            encrypted += matrix[row1][(col1 + 1) % 5]
            encrypted += matrix[row2][(col2 + 1) % 5]
        elif col1 == col2:
            encrypted += matrix[(row1 + 1) % 5][col1]
            encrypted += matrix[(row2 + 1) % 5][col2]
        else:
            encrypted += matrix[row1][col2]
            encrypted += matrix[row2][col1]

    return encrypted


def decrypt_playfair(text, matrix):
    text = text.upper()
    cleaned = ""

    for ch in text:
        if ch in string.ascii_uppercase:
            cleaned += ch

    decrypted = ""

    for i in range(0, len(cleaned), 2):
        a = cleaned[i]
        b = cleaned[i + 1]

        row1, col1 = find_position(matrix, a)
        row2, col2 = find_position(matrix, b)

        if row1 == row2:
            decrypted += matrix[row1][(col1 - 1) % 5]
            decrypted += matrix[row2][(col2 - 1) % 5]
        elif col1 == col2:
            decrypted += matrix[(row1 - 1) % 5][col1]
            decrypted += matrix[(row2 - 1) % 5][col2]
        else:
            decrypted += matrix[row1][col2]
            decrypted += matrix[row2][col1]

    return decrypted

def separator(nr=1):
    s = "=" * 25
    print( s + "Ex" + str(nr) + s )
if __name__ == "__main__":
	separator()
	password = "MALICIOUS"
	matrix = playfair(password)

	print("Matrix:")
	for row in matrix:
		print(row)
	print("Password: " + password)
	message = "AUTONOMOUS ATTACK AGENTS"
	encrypted = encrypt_playfair(message, matrix)
	decrypted = decrypt_playfair(encrypted, matrix)

	print("\nOriginal:", message)
	print("Encrypted:", encrypted)
	print("Decrypted:", decrypted)

	separator(2)
	password = "SECRET KEY"
	matrix = playfair(password)

	print("Matrix:")
	for row in matrix:
		print(row)
	print("Password: " + password)
	message = "THE ART OF PROGRAMMING"
	encrypted = encrypt_playfair(message, matrix)
	decrypted = decrypt_playfair(encrypted, matrix)

	print("\nOriginal:", message)
	print("Encrypted:", encrypted)
	print("Decrypted:", decrypted)

	separator(3)
	password = "PASSWORD"
	matrix = playfair(password)

	print("Matrix:")
	for row in matrix:
		print(row)
	print("Password: " + password)
	message = "RFRBD ONU"
	decrypted = decrypt_playfair(message, matrix)
	encrypted = encrypt_playfair(decrypted, matrix)

	print("\nOriginal:", message)
	print("Encrypted:", encrypted)
	print("Decrypted:", decrypted)
     
	separator(4)
	password = "SECRET KEY"
	matrix = playfair(password)

	print("Matrix:")
	for row in matrix:
		print(row)
	print("Password: " + password)
	message = "RFGPRTPXCQIEKHGRCDRCTCYCESCYXS"
	decrypted = decrypt_playfair(message, matrix)
	encrypted = encrypt_playfair(decrypted, matrix)

	print("\nOriginal:", message)
	print("Encrypted:", encrypted)
	print("Decrypted:", decrypted)