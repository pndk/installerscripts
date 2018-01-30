# spinner borrowed from http://fitnr.com/showing-a-bash-spinner.html
sudo apt-get install libxslt-dev libxml2-dev -y
INSTALLERFILE=Plone-5.1rc2-UnifiedInstaller.tgz
INSTALLERFOLDER=Plone-5.1rc2-UnifiedInstaller
INSTALLERURL=https://launchpad.net/plone/5.1/5.1rc2/+download/Plone-5.1rc2-UnifiedInstaller.tgz

if [ -z ${C9_USER+x} ]; then
     echo "This is not a C9 based install, this doesn't always work";
     BUILDOUTDIR=$HOME/plone
else
     echo "This is a C9 install. Hi '$C9_USER'";
     BUILDOUTDIR=$HOME/workspace
fi
echo "Your buildout directory will be $BUILDOUTDIR"


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
./install.sh standalone --target=$BUILDOUTDIR &
spinner $!

echo "----> Adding a buildout default.cfg file"
mkdir -p $HOME/.buildout/
cat > $HOME/.buildout/default.cfg << EOF
[buildout]
eggs-directory = $BUILDOUTDIR/buildout-cache/eggs
download-cache = $BUILDOUTDIR/buildout-cache/downloads
extends-cache = $BUILDOUTDIR/buildout-cache/extends
# keep buildout's connection timeout low to speed buildout runs
socket-timeout = 3
EOF

mkdir -p $BUILDOUTDIR/buildout-cache/extends
echo "***********************************"
echo "**                               **"
echo "**  Plone install complete       **"
echo "**                               **"
echo "**  the commands will not work   **"
echo "**  in this console. Close       **"
echo "**  this terminal                **"
echo "**  in a newly opened terminal   **"
echo "**  then and run:                **"
echo "**                               **"
echo "**    cd $BUILDOUTDIR/zinstance  **"
echo "**    bin/instance fg            **"
echo "**                               **"
echo "***********************************"
