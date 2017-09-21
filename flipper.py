#!/usr/bin/python
import os,struct,sys

ori_filename = sys.argv[1]
ih=open(ori_filename,'rb')

new_filename = os.path.splitext(ih.name)[0] + '.wma'
oh=open(new_filename,'wb')

while True:
  element = ih.read(1)
  if len(element) > 0:
    mybyte = struct.unpack("<b",element)[0]
    inverted_data = ~ mybyte
    oh.write(struct.pack(">b",inverted_data))
  else: break
oh.close()
ih.close()
sys.stdout.write('Flipped.\n')
