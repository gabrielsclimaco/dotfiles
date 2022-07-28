#!/bin/sh
dnf check-update > /dev/null
IS_THERE_UPDATES=$?
# UPDATES_CODE=100

echo $IS_THERE_UPDATES
# if (( $IS_THERE_UPDATES == $UPDATES_CODE )) ; then
#     echo " "
# else
#     echo " "
# fi

# if ! updates=$(yay -Qu 2> /dev/null | wc -l); then
#     updates=0
# fi

# if [ "$updates" -gt 0 ] ; then
#     echo " "
# else
#     echo " "
# fi
