go: build run

build:
	docker build -t setup-prototype .
run:
	docker run -it --mount type=bind,target=/home/mk/code/,source="${PWD}"/code setup-prototype:latest

