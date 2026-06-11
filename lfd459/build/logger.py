#!/usr/bin/python3
import time
import socket
import os
import random

time.sleep(30)

log_levels = {
  "DEBUG": 2,
  "WARN": 5,
  "ERROR": 10
}

period_seconds = log_levels.get(os.getenv("LOG_LEVEL"), 10) + random.random()

while True :
  host = socket.gethostname()
  date = time.strftime("%Y-%m-%d %H:%M:%S")
  now = str(date)
  uname = os.uname()

  try:
      f = open("logs/date.out", "a")
  except:
      continue
  f.write("v1 " + now + " -- ")
  f.write(host + " -- ")
  f.write(f"{uname.sysname} {uname.release} {uname.version}" + '\n')
  f.close()

  time.sleep(period_seconds)
