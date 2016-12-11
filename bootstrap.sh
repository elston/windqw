#!/bin/bash
# ....
set -e
# ...
if [[ ! $PROJECT ]]; then
    echo 'PROJECT not'
    exit 1
fi
if [[ ! $PROJDIR ]]; then
    echo 'PROJDIR not'
    exit 1
fi
if [[ ! $USER ]]; then
    echo 'USER not'
    exit 1
fi


#......................................


sudo apt-get update
sudo apt-get upgrade -y
#......................................

sudo apt-get -y install \
    python3.5 \
    python3.5-dev \
    python3-pip

#......................................
sudo pip install --upgrade \
    pip \
    virtualenv

sudo pip install \
    virtualenvwrapper

sudo pip install --upgrade \
    virtualenvwrapper

echo '....................Python Install OK'


#...
touch /home/$USER/.bashrc
echo " " >> /home/$USER/.bashrc
echo "source /usr/local/bin/virtualenvwrapper.sh" >> /home/$USER/.bashrc

# ...mkvirtualenv
sudo -u $USER bash -c "
    mkdir -p /$PROJDIR/.env
    ln -s /$PROJDIR/.env /home/$USER/.virtualenvs
    export HOME=/home/$USER/
    source /usr/local/bin/virtualenvwrapper.sh
    mkvirtualenv -p /usr/bin/python3 $PROJECT
"
# ...requirements
sudo -u $USER bash -c "
    export HOME=/home/$USER/
    source /$PROJDIR/.env/$PROJECT/bin/activate     
    pip install -r /$PROJDIR/requirements.txt    
"
#......................................

# .logs
LOGSDIR="/$PROJDIR/.logs/"
rm -rf $LOGSDIR
mkdir $LOGSDIR
echo '' > $LOGSDIR/flask.log

# ..
sudo -u $USER bash -c "
    # ...
    export HOME=/home/$USER/
    source /$PROJDIR/.env/$PROJECT/bin/activate     
    # ..
"

#...
sudo apt-get autoremove
sudo apt-get autoclean
echo 'YaHoo !!!'

exit 0