PORT=8080

all:

server:
	python -m http.server $(PORT)
