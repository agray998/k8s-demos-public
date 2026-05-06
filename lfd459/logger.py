#!/usr/bin/python3
import time
import socket
import os

while True :
  host = socket.gethostname()
  date = time.strftime("%Y-%m-%d %H:%M:%S")
  now = str(date)
  uname = os.uname()

  try:
      f = open("logs/date.out", "a")
  except:
      continue
  f.write("v3 " + now + " -- ")
  f.write(host + " -- ")
  f.write(f"{uname.sysname} {uname.release} {uname.version}" + '\n')
  f.close()

  time.sleep(5)
