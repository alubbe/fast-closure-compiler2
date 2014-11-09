install: bin/libNailgunTest.jnilib closure-compiler nailgun

bin/libNailgunTest.jnilib:
	cd bin && javac NailgunTest.java && gcc NailgunTest.c -shared -o libNailgunTest.jnilib -I${JAVA_HOME}/include -I${JAVA_HOME}/include/darwin
closure-compiler:
	rm -fr temp
	mkdir temp
	cd temp && curl -O https://dl.google.com/closure-compiler/compiler-latest.zip && unzip compiler-latest.zip
	mkdir closure-compiler
	mv temp/compiler.jar closure-compiler
	rm -fr temp

nailgun:
	rm -fr temp
	mkdir temp
	cd temp && curl -OL https://github.com/martylamb/nailgun/archive/nailgun-all-0.9.1.zip && unzip nailgun-all-0.9.1.zip
	cd temp/nailgun-nailgun-all-0.9.1 && make ng && cd nailgun-server && mvn package
	mkdir nailgun
	mv temp/nailgun-nailgun-all-0.9.1/nailgun-server/target/nailgun-server-0.9.1.jar nailgun/nailgun.jar
	mv temp/nailgun-nailgun-all-0.9.1/ng nailgun/ng
	rm -fr temp

clean:
	rm -rf bin/libNailgunTest.jnilib bin/libNailgunTest.class closure-compiler nailgun temp
