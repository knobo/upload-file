
Please check if this works for you

''' sh
cd ~/usr/src
git clone https://github.com/knobo/upload-file.git
ln -s ~/usr/src/upload-file ~/.roswell/local-projects/
'''

''' cl
(ql:quickload "upload-file")
(upload-file:start)
'''

Increase the upload size until you se '400 Bad Request' and tell me how if you got the 400 response or not. 
I'd also like to know which platform you are running on, and if you have a fast or slow computer.
