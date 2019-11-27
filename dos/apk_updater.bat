@echo off

for %%G in (*.apk) do call :generateMD5 %%G
rem for %%G in (*.apk) do call :pushArtifactory %%G
echo.&pause&goto:eof

:generateMD5
set _orgname=%~1
set _hashname=%_orgname:~0,-4%.md5
for /f %%i in ('sha1sum %_orgname%') do set _hashvalue=%%i
echo %_hashvalue%
call :pushArtifactory %_orgname%
goto:eof

:pushArtifactory
set _orgname=%~1
set _hashname=%_orgname:~0,-4%.md5
curl -i -s -u [ID:PWD] -X PUT -H "X-Checksum-Sha1:%_hashvalue%"  "URL/REPO/PATH"  -T %_orgname%

goto:eof