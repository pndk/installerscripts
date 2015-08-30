python_url=https://www.python.org/ftp/python/2.6.9/Python-2.6.9.tgz
python_file=Python-2.6.9.tgz
python_name=Python-2.6.9

#wget $python_url
#tar xvfz $python_file
##cd $python_name
#./configure
##make
#sudo make install
#cd ..

sudo apt-get install build-essential
sudo apt-get install libssl-dev
sudo apt-get install libxml2-dev
sudo apt-get install libxslt1-dev
sudo apt-get install libbz2-dev
sudo apt-get install zlib1g-dev
sudo apt-get install python-setuptools
sudo apt-get install python-dev
sudo apt-get install libjpeg62-dev
sudo apt-get install libreadline-gplv2-dev
sudo apt-get install python-imaging
sudo apt-get install wv
sudo apt-get install poppler-utils
# spinner borrowed from http://fitnr.com/showing-a-bash-spinner.html

spinner()
{
    local pid=$1
    local delay=0.75
    local spinstr='|/-\'
    while [ "$(ps a | awk '{print $1}' | grep $pid)" ]; do
        local temp=${spinstr#?}
        printf " [%c]  " "$spinstr"
        local spinstr=$temp${spinstr%"$temp"}
        sleep $delay
        printf "\b\b\b\b\b\b"
    done
    printf "    \b\b\b\b"
}

echo "getting the installer"
wget https://launchpad.net/plone/4.1/4.1.6/+download/Plone-4.1.6-UnifiedInstaller.tgz
echo "unpacking the installer"
tar xfz Plone-4.1.6-UnifiedInstaller.tgz
cd Plone-4.1.6-UnifiedInstaller

echo "installing (first pass)"
sudo apt-get install libssl-dev
./install.sh standalone --target=$HOME/workspace --libz=yes  &
spinner $!


echo "***********************************"
echo "**                               **"
echo "** Plone install complete        **"
echo "**                               **"
echo "** the commands will not work in **"
echo "**  this console. Close this     **"
echo "**  terminal                     **"
echo "**  in a newly opened terminal   **"
echo "**  then and run:                **"
echo "**                               **"
echo "**     cd zinstance              **"
echo "**     bin/instance fg           **"
echo "**                               **"
echo "***********************************"
