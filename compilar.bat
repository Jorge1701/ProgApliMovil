mkdir build\web
cd build\web
xcopy /s /y ..\..\web\* .
xcopy /s /y ..\..\lib\* WEB-INF\lib\

mkdir WEB-INF\classes\

mkdir ..\generated-sources\
cd ..\generated-sources\

wsimport -keep -Xnocompile -p servicios http://localhost:1234/movil?wsdl
wsimport -keep -Xnocompile -p servicios http://localhost:1234/downloadfile?wsdl
wsimport -keep -Xnocompile -p servicios http://localhost:1234/contadores?wsdl


cd ..\..\
javac -cp "lib\*" -d .\build\web\WEB-INF\classes\ .\src\java\servlet\*.java .\src\java\Configuracion\*.java .\src\java\Services\*.java .\build\generated-sources\servicios\*.java


cd build\web
jar cvf ..\..\WebMovil.war .