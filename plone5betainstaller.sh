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
wget https://launchpad.net/plone/5.0/5.0b3/+download/Plone-5.0b3-UnifiedInstaller.tgz
echo "unpacking the installer"
tar xfz Plone-5.0b3-UnifiedInstaller.tgz
cd Plone-5.0b3-UnifiedInstaller

echo "installing (first pass)"
./install.sh zeo --target=$HOME/workspace &
spinner $!

echo "let's install some convenience commands"
wget https://gist.github.com/pigeonflight/6089807/download -O plonecommands.tgz 
mkdir -p ~/bin
tar xfz plonecommands.tgz
cp `tar tfz plonecommands.tgz |head -1`plone* ~/bin/
chmod +x ~/bin/plone*
rm -rf `tar tfz plonecommands.tgz |head -1`
rm plonecommands.tgz
echo 'PATH=$PATH:$HOME/bin' >> ~/.bashrc
echo 'export PATH' >> ~/.bashrc
PATH=$PATH:$HOME/bin
export PATH
parts install tmux
wget https://gist.githubusercontent.com/pigeonflight/b94d7d078fdc1352b3af/raw/72d3c25af007294cf95c538c15b41c91b44749ed/.codio -O ~/workspace/.codio

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
echo "**     plone-start.sh            **"
echo "**                               **"
echo "**                               **"
echo "***********************************"
