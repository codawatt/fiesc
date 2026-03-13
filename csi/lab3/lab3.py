#from Crypto.Cipher import DES
#from Crypto.Util.Padding import pad, unpad
#from Crypto.Random import get_random_bytes


#if __name__ == "__main__":
#    print("LAB3")

#    data = b"Lectia de CSI"
#    key = b"DISTINCT"
#    iv = get_random_bytes(16)

#    cipher = DES.new(key, DES.MODE_OFB)

#    msg = cipher.iv + cipher.encrypt(data)

#    print("data:"+ str(data))
#    print("data encrypted:"+ str(msg))
#    msg1 = cipher.iv + cipher.decrypt(msg)
#    print("data encrypted:"+ str(msg1))