
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
============================================================================================================================================
                                How to use environment variables
    - When you copy a file or script from a server to another , you cannot run it because you are not in the path of the file or script
    - All commands we run have their env stored in the .bashrc dir
    - To be able to run a copied file without using the path to the file you need to set the env in the .bashrc directory as well
    - vi .bashrc and at the extreme bottom ==> add a line after fi (PATH=$PATH: plus the path to that file/filename)
    - on your terminal set the information by typing the command ===>> source ~/.bashrc
            cat /etc/environment
    - sometimes when developers are working on a java script they might request you add java to the PATh so that they can run the script anywhere
    - To see all env var available ===>> printenv
    - Env var can be set at different levels
                   - terminal level which will not be persisted
                   -  individual level which will persisted at for that individual (.bashrc file) once done reinitialize it
                   - Glosbl level so that every use locked into the system can use it (/etc/environment





                                     
