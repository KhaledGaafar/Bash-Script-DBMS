#!/usr/bin/bash
shopt -s extglob


                                 #-------------main Menu ----------------------------
                                 
Mainmenu() {
   echo  -e "\n+------------MainMenu------------+"
   echo "| 1. connectDB                  |"
   echo "| 2. createDB                   |"
   echo "| 3. ListDB                     |"
   echo "| 4. dropDB                     |"
   
   read -p "please select the choice " choice
   
   case $choice in
         1) 
           connectDB 
           ;;
         2)
           createDB
           ;;
         3)
           listDB
           ;;
         4)
           dropDB
           ;;
   esac
             
 }
 
 
                                    #-----------------cnnect database --------------------------- 
                                    
connectDB() {
   read -p "please enter name of DB " nameDB
   cd ./disk/$nameDB 2>/dev/null
   
   if [[ $? == 0 ]]
   then
       echo "connected----"
       menuTable
   else
       echo "there is not such a database "
       Mainmenu
   fi
}

                                     #------------------create database -----------------------------
                                     
createDB (){
read -p "enter the name of your dabase name: " dbname
    if [[ $dbname == "" ]]
    then
    echo "your database name can not be empty, please try again"
    elif [[ -e ~/disk/$dbname ]]
    then
    echo "this database already exists! please try a different name"
    else
        mkdir ~/disk/$dbname; echo "yourdatbase was created succefully"
    fi
}

                                    #--------------------list databases------------------------------------
                                    
listDB (){
    ls ~/disk
}


                                   #---------------------drop databases-------------------------------------
                                   
function dropDB {
    read -p "please enter name of droppedDb " nameDB
    rm -r ./disk/$nameDB 2>/dev/null
    
    if [[ $? == 0 ]]
   then
       echo "database dropped"
   else
       echo "there is not such a database "
   fi
   Mainmenu
}

                                 #---------------------menu table-----------------------------------------------

function menuTable {
   echo  -e "\n+------------Maintable------------+"
   echo "| 1. create Table                 |"
   echo "| 2. List Table                   |"
   echo "| 3. Drop Table                   |"
   echo "| 4. insert Into Table            |"
   echo "| 5. select from Table            |"
   echo "| 6. delete from Table            |"
   echo "| 7. update Table                 |"
}
   
    

Mainmenu
   
   
