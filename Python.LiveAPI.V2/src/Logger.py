import time
    
class Logger:
    
    # Adds the given message string to the log file defined within, adding date stamp. 
    def log(self, msg):
        dtNow = time.localtime()
        time_now_sec = time.mktime(time.localtime())
        time_now_mic = time.time()
        time_str = time.asctime()
        milli = time_now_mic - time_now_sec
        
        myFile = open('c:\\NoofnyController.log', 'a')
        myFile.write(time.strftime("%d.%m.%Y %H:%M:%S", time.localtime()) + "." + str(milli) + '\t' + msg + '\n')
        myFile.close()
        pass
    

    # Util for dumping the given class reference to the log file. 
    def dumpClassInfo(self, classReference):
        dirs = dir(classReference)
        for c in range(0, len(dirs)):
            self.log(dirs[c])




