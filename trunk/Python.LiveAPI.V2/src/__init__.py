import sys, os
from NoofnyController import NoofnyController

# Some Python path crap - don't think I need this anymore. Leaving for now.
pythonInstallDir = 'C:\\Python25'
if pythonInstallDir not in sys.path:
    sys.path.append(pythonInstallDir)
    
# Some more Python path crap - don't think I need this anymore. Leaving for now.
defaultPythonPaths = ['.\\', '\\DLLs', '\\lib', '\\lib\\lib-tk', '\\lib\\site-packages', '\\lib\\site-packages\\win32', '\\lib\\plat-win', '\\lib\\site-packages\\win32\\pythonwin', '\\lib\\site-packages\\win32\\pywin32_system32', '\\lib\\site-packages\\win32\\win32com']
for dir in defaultPythonPaths:
    path = pythonInstallDir + dir
    if path not in sys.path:
        sys.path.append(path)

# This is called when Live tries to fire up this script. Just returns an instance of my controller class.
def create_instance(appInstance):
    return NoofnyController(appInstance)
