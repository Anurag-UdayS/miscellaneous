function compile() {
	echo "Compiling $1.java"
	javac -cp .. -d .. -Xlint -Xdiags:verbose $1.java
	if [[ $? -ne 0 ]]; then
		exit $?;
	fi;
}

compile Assertable
compile Mutable
compile PrinterUtil
compile ScannerUtil
compile Property
compile Reservation
compile CsvReader
compile Menu
compile Main
