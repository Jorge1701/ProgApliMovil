mkdir build\WebMovil\

cd build\WebMovil\

xcopy /e ..\..\web\* .

del /Q *.xml .\WEB-INF\

mkdir WEB-INF\lib
copy "..\..\lib\*.jar" "WEB-INF\lib"

mkdir WEB-INF\classes
cd WEB-INF\classes
wsimport -keep -p servicios http://localhost:1234/movil?wsdl
wsimport -keep -p servicios http://localhost:1234/downloadfile?wsdl



cd ..\..\..\..\

javac -cp ".\build\WebMovil\WEB-INF\lib\commons-fileupload-1.3.3.jar;.\build\WebMovil\WEB-INF\lib\commons-io-2.5.jar;D:\apache-tomcat-8.0.46\lib\servlet-api.jar" -d build\WebMovil\WEB-INF\classes\ .\build\WebMovil\WEB-INF\classes\servicios\*.java .\src\java\servlets\*.java .\src\java\Configuracion\*.java

cd build\WebMovil\

jar cvf ..\..\WebMovil.war .

