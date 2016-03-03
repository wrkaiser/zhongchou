package com.xiaoyou.util; 

import java.util.*; 

public class FileUploadStatus { 
	
public static final String Upload_New_File_Success = "credateSuccess";

public static final String Upload_New_File_Failed = "credateError";

public static final String Delete_Remote_Faild = "delError";


public static final String Upload_From_Break_Success = "updateBreakSuccess";

public static final String Upload_From_Break_Failed = "Upload_From_Break_Failed";

public static final String Remote_Bigger_Local = "remoteLocal";

public static final String File_Exits = "fileExits";

public static final String Create_Directory_Fail = "newDirError";

//上传用户地址 
private String uploadAddr; 
//上传总量 
private long uploadTotalSize = 0; 
//读取上传总量 
private long readTotalSize = 0; 
//当前上传文件号 
private int currentUploadFileNum = 0; 
//成功读取上传文件数 
private int successUploadFileCount = 0; 
//状态 
private String status = ""; 
//处理起始时间 
private long processStartTime = 0l; 
//处理终止时间 
private long processEndTime = 0l; 
//处理执行时间 
private long processRunningTime = 0l; 
//上传文件URL列表 
private List uploadFileUrlList = new ArrayList(); 
//取消上传 
private boolean cancel = false; 
//上传base目录 
private String baseDir = ""; 

public FileUploadStatus() { 

} 

public String getBaseDir() { 
return baseDir; 
} 

public void setBaseDir(String baseDir) { 
this.baseDir = baseDir; 
} 

public boolean getCancel() { 
return cancel; 
} 

public void setCancel(boolean cancel) { 
this.cancel = cancel; 
} 

public List getUploadFileUrlList() { 
return uploadFileUrlList; 
} 

public void setUploadFileUrlList(List uploadFileUrlList) { 
this.uploadFileUrlList = uploadFileUrlList; 
} 

public long getProcessRunningTime() { 
return processRunningTime; 
} 

public void setProcessRunningTime(long processRunningTime) { 
this.processRunningTime = processRunningTime; 
} 

public long getProcessEndTime() { 
return processEndTime; 
} 

public void setProcessEndTime(long processEndTime) { 
this.processEndTime = processEndTime; 
} 

public long getProcessStartTime() { 
return processStartTime; 
} 

public void setProcessStartTime(long processStartTime) { 
this.processStartTime = processStartTime; 
} 

public long getReadTotalSize() { 
return readTotalSize; 
} 

public void setReadTotalSize(long readTotalSize) { 
this.readTotalSize = readTotalSize; 
} 

public int getSuccessUploadFileCount() { 
return successUploadFileCount; 
} 

public void setSuccessUploadFileCount(int successUploadFileCount) { 
this.successUploadFileCount = successUploadFileCount; 
} 

public int getCurrentUploadFileNum() { 
return currentUploadFileNum; 
} 

public void setCurrentUploadFileNum(int currentUploadFileNum) { 
this.currentUploadFileNum = currentUploadFileNum; 
} 

public String getStatus() { 
return status; 
} 

public void setStatus(String status) { 
this.status = status; 
} 

public long getUploadTotalSize() { 
return uploadTotalSize; 
} 

public String getUploadAddr() { 
return uploadAddr; 
} 

public void setUploadTotalSize(long uploadTotalSize) { 
this.uploadTotalSize = uploadTotalSize; 
} 

public void setUploadAddr(String uploadAddr) { 
this.uploadAddr = uploadAddr; 
} 

public String toJSon() { 
StringBuffer strJSon = new StringBuffer(); 
strJSon.append("{UploadTotalSize:").append(getUploadTotalSize()).append( 
",") 
.append("ReadTotalSize:").append(getReadTotalSize()).append(",") 
.append("CurrentUploadFileNum:").append(getCurrentUploadFileNum()). 
append(",") 
.append("SuccessUploadFileCount:").append( 
getSuccessUploadFileCount()).append(",") 
.append("Status:'").append(getStatus()).append("',") 
.append("ProcessStartTime:").append(getProcessStartTime()). 
append(",") 
.append("ProcessEndTime:").append(getProcessEndTime()).append( 
",") 
.append("ProcessRunningTime:").append(getProcessRunningTime()). 
append(",") 
.append("Cancel:").append(getCancel()).append("}"); 
return strJSon.toString(); 

} 


} 