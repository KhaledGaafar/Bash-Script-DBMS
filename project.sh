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
   
   read -p "please select choice" choise
   case $choise in 
           1)
             createTable
             ;;
         
   esac
}
   
#--------------------------------craete table ------------------------
function createTable {
  echo -e "Table Name: \c"
  read tableName
  if [[ -e $tableName ]]; then
    echo "table already existed ,choose another name"
    menuTable
  fi
  echo -e "Number of Columns: \c"
  read colsNum
  counter=1
  sep="|"
  fSep="\n"
  pKey=""
  metaData="Field"$sep"Type"$sep"key"
  while [ $counter -le $colsNum ]
  do
    read -p "Name of Column No.$counter: " colName
   
    echo -e "Type of Column $colName: "
    select var in "int" "str"
    do
      case $var in
        int ) colType="int";break;;
        str ) colType="str";break;;
        * ) echo "Wrong Choice" ;;
      esac
    done
    if [[ $pKey == "" ]]; then
      echo -e "Make PrimaryKey ? "
      select var in "yes" "no"
      do
        case $var in
          yes ) pKey="PK";
          metaData+=$fSep$colName$sep$colType$sep$pKey;
          break;;
          no )
          metaData+=$fSep$colName$sep$colType$sep""
          break;;
          * ) echo "Wrong Choice" ;;
        esac
      done
      else
      metaData+=$fSep$colName$sep$colType$sep""
    fi
    if [[ $counter == $colsNum ]]; 
    then
      temp=$temp$colName
    else
      temp=$temp$colName$sep
    fi
    ((counter++))
  done
  touch .$tableName
  echo -e $metaData  >> .$tableName
  touch $tableName
  echo -e $temp >> $tableName
  if [[ $? == 0 ]]
  then
    echo "Table Created Successfully"
    menuTable
  else
    echo "Error Creating Table $tableName"
    menuTable
  fi
}


Mainmenu
   
   
