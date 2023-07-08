#!/bin/bash

function clone_mojito () {
        read -p "Select branch name : " BRANCH ; echo ""
        DM=$PWD/device/xiaomi/mojito
        VM=$PWD/vendor/xiaomi/mojito
        KM=$PWD/kernel/xiaomi/mojito
        echo "Cloning resources for mojito"
        git clone https://github.com/axsrog/device_xiaomi_mojito -b $BRANCH $DM
        echo ""
        git clone https://github.com/axsrog/vendor_xiaomi_mojito -b $BRANCH $VM
        echo ""
        git clone https://github.com/axsrog/kernel_xiaomi_mojito -b $BRANCH $KM
        echo ""
}

function clone_lavender () {
        read -p "Select branch name : " BRANCH ; echo ""
        DL=$PWD/device/xiaomi/lavender
        VL=$PWD/vendor/xiaomi/lavender
        KL=$PWD/kernel/xiaomi/lavender

        read -p "Clone bionic? (y/n) : " bionic
        if [[ $bionic == y ]]
        then
        rm -rf bionic ; echo "Cloning bionic" ;
        git clone https://github.com/axsrog/bionic
        else
        echo "Not cloning bionic"
        fi

        echo "Cloning resources for lavender"
        git clone https://github.com/axsrog/device_xiaomi_lavender -b $BRANCH $DL
        echo ""
        git clone https://github.com/axsrog/vendor_xiaomi_lavender -b $BRANCH $VL
        echo ""
        git clone https://github.com/axsrog/kernel_xiaomi_lavender -b $BRANCH $KL
        echo ""

}

read -p "Select required device (1=mojito, 2=lavender) : " DEVICE
      case $DEVICE in
          1 )
                   echo ""
                   echo "cloning resources for mojito"
                   echo ""
                   clone_mojito ;;

          2 )
                   echo ""
                   echo "cloning resources for lavender"
                   echo ""
                   clone_lavender ;;

          * )
                   echo "error: 404"

      esac
exit 0
