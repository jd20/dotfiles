source utils.sh

if test ! $(which spoof)
then
  sudo npm install spoof -g
fi