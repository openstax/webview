#!/usr/bin/env bash
set -Eeuo pipefail

# This file is modeled from https://github.com/docker-library/postgres/blob/3f585c58df93e93b730c09a13e8904b96fa20c58/docker-entrypoint.sh

# usage: file_env VAR [DEFAULT]
#    ie: file_env 'XYZ_DB_PASSWORD' 'example'
# (will allow for "$XYZ_DB_PASSWORD_FILE" to fill in the value of
#  "$XYZ_DB_PASSWORD" from a file, especially for Docker's secrets feature)
file_env() {
	local var="$1"
	local fileVar="${var}_FILE"
	local def="${2:-}"
	if [ "${!var:-}" ] && [ "${!fileVar:-}" ]; then
		echo >&2 "error: both $var and $fileVar are set (but are exclusive)"
		exit 1
	fi
	local val="$def"
	if [ "${!var:-}" ]; then
		val="${!var}"
	elif [ "${!fileVar:-}" ]; then
		val="$(< "${!fileVar}")"
	fi
	export "$var"="$val"
	unset "$fileVar"
}

# Start your command with '-' to extend the existing nginx startup
if [ "${1:0:1}" = '-' ]; then
	set -- nginx "$@"
fi

case "${ENVIRONMENT}" in
	dev) PROJECT_ROOT='/code/src' ;;
	*) PROJECT_ROOT='/code/dist' ;;
esac

if [ "$1" = 'nginx' ]; then
	chown -R "nginx" "$PROJECT_ROOT" 2>/dev/null || :
	chmod 700 "$PROJECT_ROOT" 2>/dev/null || :

	file_env 'ARCHIVE_HOST'   "${ARCHIVE_HOST:-archive.cnx.org}"
	file_env 'ARCHIVE_PORT'   "${ARCHIVE_PORT:-80}"
	file_env 'OPENSTAX_HOST'  "${OPENSTAX_HOST:-openstax.org}"
	file_env 'OPENSTAX_PORT'  "${OPENSTAX_PORT:-443}"
	file_env 'EXERCISES_HOST' "${EXERCISES_HOST:-exercises.openstax.org}"
	file_env 'EXERCISES_PORT' "${EXERCISES_PORT:-443}"
	file_env 'LEGACY_HOST'    "${LEGACY_HOST:-legacy.cnx.org}"
	
	/code/script/gen-settings-from-env > $PROJECT_ROOT/scripts/settings.js

	configure-nginx-from-env.sh $PROJECT_ROOT > /etc/nginx/conf.d/default.conf

	echo
	echo 'CNX webview init process complete; ready for start up.'
	echo
fi

exec "$@"
