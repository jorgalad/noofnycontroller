c:
del "C:\Program Files (x86)\Ableton\Live 8.0.4\Resources\MIDI Remote Scripts\NoofnyController\*.*" /F /Q
copy /Y "E:\Workspace\NoofnyControllerV2\src\*.py" "C:\Program Files (x86)\Ableton\Live 8.0.4\resources\midi remote scripts\NoofnyController\"
del c:\NoofnyController.log /F /Q
rem cmd /c "C:\Program Files (x86)\Ableton\Live 8.0.4\program\Live 8.0.4.exe"
cmd /c "E:\Songs\Noofny.ProgSet\Noofny.ProgSet.als"
exit