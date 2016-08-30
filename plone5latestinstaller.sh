# spinner borrowed from http://fitnr.com/showing-a-bash-spinner.html
sudo apt-get install libxslt-dev libxml2-dev -y

INSTALLERFILE=Plone-5.0.5-UnifiedInstaller.tgz
INSTALLERFOLDER=Plone-5.0.5-UnifiedInstaller
INSTALLERURL=https://launchpad.net/plone/5.0/5.0.5/+download/Plone-5.0.5-UnifiedInstaller.tgz

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
if [ -s $INSTALLERFILE ]  
then  
    echo "----> We already have the installer file"
else  
    echo "----> Downloading the installer file"
    wget $INSTALLERURL
fi
echo "unpacking the installer"
tar xfz $INSTALLERFILE
cd $INSTALLERFOLDER


echo "installing (first pass)"
./install.sh standalone --target=$HOME/workspace &
spinner $!

echo "----> Adding a buildout default.cfg file"
mkdir -p $HOME/.buildout/
wget https://raw.githubusercontent.com/pndk/installerscripts/master/c9.buildout.defaults.cfg -O $HOME/.buildout/default.cfg
mkdir -p $HOME/workspace/buildout-cache/extends
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
