all:
	mkdir -p bin/
	find src/ -type f -name *.java | javac -d bin/ -classpath "lib/antlr-4.5.3-complete.jar" @/dev/stdin
clean:
	rm -rf bin/
