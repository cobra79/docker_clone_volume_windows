@echo off
if "%1"=="" (
	ECHO Please provide source volume
	goto :EOF
)

if "%2"=="" (
	ECHO Please provide destination volume
	goto :EOF
)

docker volume inspect %1

if %errorlevel%==1 (
	ECHO No such source volume
	goto :EOF
)

docker volume inspect %2

if %errorlevel%==0 (
	ECHO Volume %2 already exits
	goto :EOF
)


ECHO Creating destination volume %2 ...
docker volume create --name %2
ECHO Copying data from %1 to %2 ...
docker run --rm -i -t -v %1:/from -v %2:/to alpine ash -c "cd /from ; cp -av . /to"
