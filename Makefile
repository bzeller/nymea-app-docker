UID := $(shell id -u)
GID := $(shell id -g)

default: build

build:
	echo -e "UID=${UID}\nGID=${GID}" > .env
	docker compose up --build --wait -d

install: build
	cp nymea.deskop $HOME/.local/share/applications

uninstall:
	docker compose down
	rm $HOME/.local/share/applications/nymea.desktop
