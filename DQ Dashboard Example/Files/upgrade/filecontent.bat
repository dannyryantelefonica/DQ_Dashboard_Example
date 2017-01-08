@echo on
pushd "../components"

setlocal DisableDelayedExpansion

set "FILENAME=%%~nf"
set "OUTPUT=%%~nxf"
set "PREFIX=EXP_" 
set "REPLACETEXT=result"   
set "TEMP=tmp"

for /R %%f in (*.comp) do (
	for /f "delims=" %%A in (%%f) do (
		SET "string=%%A"
		setlocal EnableDelayedExpansion
		SET modified=!string:%PREFIX%%FILENAME%=%REPLACETEXT%! 
		echo !modified! >> %TEMP%
		endlocal
	)	

del	%OUTPUT%
rename %TEMP% %OUTPUT%
	
)

popd
call move_files.bat