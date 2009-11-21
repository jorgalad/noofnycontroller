c:
del "C:\Program Files (x86)\Ableton\Live 7.0.1\resources\midi remote scripts\NoofnyController\*.*" /F /Q
copy /Y "E:\Workspace\NoofnyController\src\*.py" "C:\Program Files (x86)\Ableton\Live 7.0.1\resources\midi remote scripts\NoofnyController\"
del c:\NoofnyController.log /F /Q
rem cmd /c "C:\Program Files (x86)\Ableton\Live 7.0.1\program\Live 7.0.1.exe"
cmd /c "E:\Songs\Noofny.ProgSet\Noofny.ProgSet.als"
exit