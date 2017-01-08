@echo on
pushd "../components" || exit /b
for /f "eol=: delims=" %%F in ('dir /b /a-d __*.comp') do (
  for /f "tokens=1* delims=__" %%A in ("%%F") do ren "%%F" "%%~nA%%~xF"
)
for /f "eol=: delims=" %%F in ('dir /b /a-d *__*.comp') do (
  for /f "tokens=1* delims=__" %%A in ("%%F") do ren "%%F" "%%~nB%%~xF"
)
popd
call filecontent.bat