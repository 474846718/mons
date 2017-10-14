

	
/**
  *package: js/page/common_date.js
  *function:im_common_date_getLocal()
  *params:  
  *description: 获取当前日期,时间
  *author:tianbin 
  *email:tianbin@adtec.com.cn
  *Date:2013年11月04日 16:25:25
 **/
function  im_common_date_getLocalDateAndTime(){
   var myDate = new Date();
	myDate.getYear();        //获取当前年份(2位)
	myDate.getFullYear();    //获取完整的年份(4位,1970-????)
	myDate.getMonth();       //获取当前月份(0-11,0代表1月)
	myDate.getDate();        //获取当前日(1-31)
	myDate.getDay();         //获取当前星期X(0-6,0代表星期天)
	myDate.getTime();        //获取当前时间(从1970.1.1开始的毫秒数)
	myDate.getHours();       //获取当前小时数(0-23)
	myDate.getMinutes();     //获取当前分钟数(0-59)
	myDate.getSeconds();     //获取当前秒数(0-59)
	myDate.getMilliseconds();    //获取当前毫秒数(0-999)
	myDate.toLocaleDateString();     //获取当前日期
	var mytime=myDate.toLocaleTimeString();     //获取当前时间  日期格式:2013年11月5日 14:44:00
	myDate.toLocaleString( );        //获取日期与时间
	return mytime;
}

/**
  *package: js/page/common_date.js
  *function:im_common_date_getLocalTime()
  *params:  
  *description: 获取当前时间   14:56:18 
  *author:tianbin 
  *email:tianbin@adtec.com.cn
  *Date:2013年11月04日 16:25:25
 **/
function  im_common_date_getLocalTime(){ 
        var myDate = new Date();
	    var hours = myDate.getHours();
	    var minutes = myDate.getMinutes();
	    var seconds = myDate.getSeconds();
	    var time = hours+":"+minutes+":"+seconds;
	    return time;
}