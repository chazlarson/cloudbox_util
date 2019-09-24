#!/bin/bash

# SCRIPT TO DO STUFF

package=""  # Default to empty package
target=""  # Default to empty target

# Parse options to the `pip` command
while getopts ":h" opt; do
  case ${opt} in
    h )
      echo "Usage:"
      echo "    cb -h                  Display this help message."
      echo "    cb install <package>   Install <package>."
      echo "    cb remove <package>    Install <package>."
      echo "    cb logs  <package>     Display logs for <package>."
      echo "    cb certs renew         Force-renew all certs."
      echo "    cb certs status        Display certs status."
      echo "    cb ncdu all            opens ncdu at / with /opt/plex excluded"
      echo "    cb ncdu all-with-plex  opens ncdu at /"
      echo "    cb usage sync          Space used by Plex sync directory"
      echo "    cb usage local         Space used by /mnt/local directory"
      echo "    cb update [os]         Update local cloudbox files"
      echo "    cb upgrade             Run cloudbox tag to upgrade"
      echo "    cb bench               Run nench benchmark"
      echo "    cb plex token          Retrieve plex token"
      echo "    cb plex fix-trash      Fix plex trash"

      exit 0
      ;;
   \? )
     echo "Invalid Option: -$OPTARG" 1>&2
     exit 1
     ;;
  esac
done
shift $((OPTIND -1))


# 8) Renew Necessary Certificates
# 9) Force Renew ALL Certificates
# 6) Show Certificate Information

# 3) NCDU /opt (excluding Plex)	  
# 10) NCDU Local Mount
# 4) NCDU /opt (including Plex)	  

subcommand=$1; shift  # Remove 'pip' from the argument list
case "$subcommand" in

  # Parse options to the various sub commands

  certs)
    cmd=$1; shift
    case "$cmd" in
	  token)
        echo "Retrieve plex token"
		;;
	  "fix-trash" )
        echo "Fix plex trash"
		;;
	  * )
        echo "INVALID:" $cmd
		;;
	esac
    ;;

  plex)
    cmd=$1; shift
    case "$cmd" in
	  token)
		echo -e "\e[96mLaunching Plex Token Script. \e[39m"
		/opt/scripts/plex/plex_token.sh
		;;
	  "fix-trash" )
		echo -e "\e[96mRunning Plex Trash Fixer Script. \e[39m"
		/opt/scripts/plex/plex_trash_fixer.py
		;;
	  * )
        echo "INVALID:" $cmd
		;;
	esac
    ;;

  nench)
	echo -e "\e[96mLaunching Nench Benchmark. \e[39m"
	echo
	curl -s wget.racing/nench.sh | bash
    ;;
    
  update)
    echo "updating Cloudbox core files"
    ;;
    
  upgrade)
    area=$1; shift
    case "$area" in
	  os)
		echo -e "\e[96mUpdating OS \e[39m"
		sudo apt-get update
		sudo apt-get dist-upgrade -y
		sudo apt-get autoremove -y
		sudo apt-get autoclean -y
		;;
	  '' )
        echo "upgrading Cloudbox"
		;;
	  * )
        echo "Don't know how to upgrade" $area
		;;
	esac
    ;;
    
  usage)
    area=$1; shift
    case "$area" in
	  sync)
		currSize=$(sudo du -sh '/opt/plex/Library/Application Support/Plex Media Server/Cache/Transcode' | awk '{print $1}')
		echo -e "\e[96mSync Folder Size is: $currSize \e[39m"
		;;
	  local)
		currSize=$(sudo du -sh '/mnt/local' | awk '{print $1}')
		echo -e "\e[96mLocal Data Size is: $currSize \e[39m"
		;;
	  * )
		echo "INVALID usage parameter:" $area
		echo "Valid parameters are:"
		echo "  sync"
		echo "  local"
		;;
	esac
    ;;
    
  ncdu)
    area=$1; shift
    case "$area" in
	  all)
		echo -e "\e[96mLaunching NCDU (excluding Plex). \e[39m"
		echo
		ncdu -x / --exclude=/opt/plex
		;;
	  all-with-plex)
		echo -e "\e[96mLaunching NCDU (including Plex). \e[39m"
		echo
		ncdu -x /
		;;
	  * )
		echo "INVALID ncdu parameter:" $area
		echo "Valid parameters are:"
		echo "  all"
		echo "  all-with-plex"
		;;
	esac
    ;;
    
  certs)
    cmd=$1; shift
    case "$cmd" in
	  renew)
		echo -e "\e[96mForcing Renew of all Necessary Cerificates. \e[39m"
		docker exec letsencrypt /app/signal_le_service
		;;
	  status)
		echo -e "\e[96mLaunching Certificate Information. \e[39m"
		docker exec letsencrypt /app/cert_status
		;;
	  * )
		echo "INVALID usage parameter"
		;;
	esac
    ;;
    
  logs)
    package=$1; shift
    case "$package" in
	  autoscan)
		echo -e "\e[96mLaunching Plex Autoscan Log Tail. \e[39m"
		echo
		tail -f /opt/plex_autoscan/plex_autoscan.log -n 30
		;;
	  cloudplow)
		echo -e "\e[96mLaunching Cloudplow Log Tail. \e[39m"
		echo
		tail -f /opt/cloudplow/cloudplow.log -n 30
		;;
	  * )
		echo "INVALID log parameter:" $area
		echo "Valid parameters are:"
		echo "  autoscan"
		echo "  cloudplow"
		;;
	esac
    ;;
    
  install)
    package=$1; shift

    # Process package options
    while getopts ":t:" opt; do
      case ${opt} in
        t )
          target=$OPTARG
          ;;
        \? )
          echo "Invalid Option: -$OPTARG" 1>&2
          exit 1
          ;;
        : )
          echo "Invalid Option: -$OPTARG requires an argument" 1>&2
          exit 1
          ;;
      esac
    done
    shift $((OPTIND -1))
    ;;
esac


# case "$subcommand" in
#   update)
#     echo "updating Cloudbox core files"
#     ;;
#   : )
#     echo "INVALID"
#     ;;
# esac


