#!/bin/sh
set -e -u

show_help() {
	cat << 'EOF'
Usage: pkg command [arguments]
 
A tool for managing packages. Commands:
 
  files <packages>
  install <packages>
  list-all
  list-installed
  reinstall <packages>
  search <query>
  show <packages>
  uninstall <packages>
  upgrade
EOF
	exit 1
}

pkg_update() {
	if test -z "$(find /var/cache/apt/pkgcache.bin -mmin -5)"; then
		sudo apt update
	fi
}

main() {
	if test $# = 0; then
		show_help
	fi

	CMD="$1"
	shift 1

	case "$CMD" in
	f*) dpkg -L "$@" ;;
	h*) show_help ;;
	add | i*)
		pkg_update
		sudo apt install "$@"
		;;
	list-a*) apt list "$@" ;;
	list-i*) apt list --installed "$@" ;;
	rei*) apt install --reinstall "$@" ;;
	se*)
		pkg_update
		apt search "$@"
		;;
	sh*) apt show "$@" ;;
	un* | rem* | rm | del*) sudo apt remove "$@" ;;
	up*)
		pkg_update
		sudo apt upgrade
		;;
	*)
		echo "Unknown command: '$CMD' (run 'pkg help' for usage information)"
		exit 1
		;;
	esac
}

main "$@"
