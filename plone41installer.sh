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
wget http://launchpad.net/plone/4.1/4.1/+download/Plone-4.1-UnifiedInstaller-20110907.tgz
echo "unpacking the installer"
tar xfz Plone-4.1-UnifiedInstaller-20110907.tgz
cd Plone-4.1-UnifiedInstaller

echo "installing (first pass)"
./install.sh standalone --target=$HOME/workspace &
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
