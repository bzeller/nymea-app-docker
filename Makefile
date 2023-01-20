UID := $(shell id -u)
GID := $(shell id -g)
AUTHFILE := $(shell env LC_ALL=C xauth info | grep "Authority file:" | sed -E "s|^Authority file\:(\s)+(.*)\$$|\2|" )

default: build

build:
	echo -e "UID=${UID}\nGID=${GID}\nXAUTH=${AUTHFILE}" > .env
	docker compose up --build --wait -d

install: build
	cp nymea.deskop $HOME/.local/share/applications

uninstall:
	docker compose down
	rm $HOME/.local/share/applications/nymea.desktop
