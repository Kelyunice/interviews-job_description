
   - after creating your instance, add the name of the instance and chose the size of your machine
   - Port 22 is the default port for ssh connection
   - Create the new key pair, and select the key pair type (RSA) with a .pem extension. if you chose .ppk then you need a puTTy terminal

===============================================================================================================================================

                                     How to connect 2 machines
     - create a key
    - To copy a file which has root access as a regular user==> sudo cp =r (path to file) .
    - copy the public key from your download on your machine and paste in the .ssh directory on the local machine. (sudo ls -l .ssh)
      or   copy the public key on local (sudo cat .ssh/id_rsa.pub) machine, and put it in the .ssh directory on the aws server (vi .ssh/authorized_key)
    -  sudo ssh -i ~/.ssh/id_rsa ubuntu@pub Ip ( name of server @ ip of aws server) or if the key is in the default location ( sudo ssh ubuntu@pub IP)
    - To copy a file from another into another server
             sudo scp -i ~/.ssh/id_rsa filename ubuntu@IP:/path to the directory








                                     
