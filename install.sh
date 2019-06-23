#!/bin/bash
#############

# colorful echos
###################################

black='\E[30m'
red='\E[31m'
green='\E[32m'
yellow='\E[33m'
blue='\E[1;34m'
magenta='\E[35m'
cyan='\E[36m'
white='\E[37m'
reset_color='\E[00m'
COLORIZE=1

cecho()  {
    # Color-echo
    # arg1 = message
    # arg2 = color
    local default_msg="No Message."
    message=${1:-$default_msg}
    color=${2:-$green}
    [ "$COLORIZE" = "1" ] && message="$color$message$reset_color"
    echo -e "$message"
    return
}

echo_error()   { cecho "$*" $red          ;}
echo_fatal()   { cecho "$*" $red; exit -1 ;}
echo_warning() { cecho "$*" $yellow       ;}
echo_success() { cecho "$*" $green        ;}
echo_info()    { cecho "$*" $blue         ;}

echo_info "###########################################################"
echo_info "# The building process it started.Please wait"
echo_info "###########################################################"
ORIGIN_PATH=$PWD
LOG_DIR=$ORIGIN_PATH/logs
BUILD_DIR=$ORIGIN_PATH/build
#change directory in order to build 
echo_info "Installing the required software packages"
echo_info "###########################################################"
sudo apt-get install cmake libfftw3-dev libmbedtls-dev libboost-program-options-dev libconfig++-dev libsctp-dev -y
echo_info "###########################################################"
echo_info "# The build subdirectory it is created"
echo_info "###########################################################"
echo_info "# Checking if the build and logs directory exists, if there"
echo_info "are not it will be created"
echo_info "###########################################################"
if [ ! -d "$BUILD_DIR" ]; then
	# Control will enter here if $BUILD_DIR doesnt exists.
	mkdir $ORIGIN_PATH/build
fi
if [ ! -d "$LOG_DIR" ]; then
	# Control will enter here if $LOG_DIR doesnt exists.
	mkdir $ORIGIN_PATH/logs
fi
cd $ORIGIN_PATH/build
echo_info "# The CMAKE process it will start!"
echo_info "###########################################################"
# cmake the files and feed the logfile into cmake.log
cmake .. > ../logs/cmake.log 2>&1
echo_info "# The CMAKE process has finished!"
echo_info "###########################################################"
echo_info "# The MAKE process it will start!"
echo_info "# To observe a real time log, use the command bellow :"
echo_info "# $ tail -f ../../../logs/make.log"
make > ../logs/make.log 2>&1
echo_info "###########################################################"
echo_info "# The MAKE process has finihed!"
echo_info "###########################################################"
echo_info " The MAKE TEST process it will start!"
make test > ../logs/make_test.log 2>&1
echo_info "###########################################################"
echo_info " The MAKE TEST process has finihed!"
echo_info "###########################################################"
echo_info " The MAKE INSTALLATION process it will start!"
sudo make install
echo_info "###########################################################"
sudo srslte_install_configs.sh

