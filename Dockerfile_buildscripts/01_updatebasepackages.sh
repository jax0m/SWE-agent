echo "----------------------------------- !!! Stage 01A: Updating Packages !!! -----------------------------------"
apt-get update
apt-get upgrade -y
echo "----------------------------------- !!! Stage 01A: Updated Base packages !!! -----------------------------------"
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
echo "----------------------------------- !!! Stage 01B-1: Installing common files !!! -----------------------------------"
apt-get install -y apt-utils bc build-essential curl git software-properties-common wget 
#echo "----------------------------------- !!! Stage 01B-2: Install Python !!! -----------------------------------"
#apt-get install -y python3 python3.10-venv python3-pip
#echo "----------------------------------- !!! Stage 01B-3: Setup Python !!! -----------------------------------"
# ln -s /bin/python3 /bin/python
echo "----------------------------------- !!! Stage 01B: Installed common files !!! -----------------------------------"
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
echo "----------------------------------- !!! Stage 01C-1: Installing dependencies !!! -----------------------------------"
apt-get install -y nodejs npm libcairo2-dev
echo "----------------------------------- !!! Stage 01C-2: Cleaning up !!! -----------------------------------"
apt-get autoremove -y
apt-get clean -y
echo "----------------------------------- !!! Stage 01C: Installed base dependencies !!! -----------------------------------"
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
echo " EOF "
