<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<title>Say hello using the People API</title>
<meta charset='utf-8' />
<script src="https://cdn.alloyui.com/3.0.1/aui/aui-min.js"></script>
<link href="https://cdn.alloyui.com/3.0.1/aui-css/css/bootstrap.min.css"
	rel="stylesheet"></link>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>	

</head>
<body>

	<div id="wrapper">
		<div id="myScheduler"></div>
	</div>


<script>
		
		var events = new Array(); 
		var jsonData = ${listAllSchedulerGson};
		 
		for(var i=0; i<jsonData.length; i++){
		    var obj = jsonData[i];
		    events.push({"id":obj.SCHE_ID,"disabled": true, "content":obj.SCHE_CONTENT,"startDate":new Date(obj.SCHE_STARTDATE),"endDate":new Date(obj.SCHE_ENDDATE)});
		}
		     
		
		YUI().use(
		'aui-scheduler',
		function(Y) {
		
		var agendaView = new Y.SchedulerAgendaView();
		var dayView = new Y.SchedulerDayView();
		var weekView = new Y.SchedulerWeekView();
		var monthView = new Y.SchedulerMonthView();
		
		
		var eventRecorder = new Y.SchedulerEventRecorder({
			
			ATTRS:{
	    	disabled: {
				value : true,
			}	}
	    	,
			
			
			strings: {
	             'delete': '삭제',
	             'description-hint': 'Title of Schedule',
	             cancel: '취소',
	             description: '보기',
	             edit: '수정',
	             save: '저장',
	             when: '시간'
	         }
			
		,	
			
			
		on: {
			
		
		    save: function (event) {
		    
		    	
		    this.set('disabled','true');	
		    
		    var start 		= this.get('startDate');
		    var end 		= this.get('endDate');
		    
		    //시간
		    var startTime 	= this._formatDate(start, '%H:%M');
		    var endTime 	= this._formatDate(end, '%H:%M');
		    
		    //년도
		  	var startYear 	= this.get('startDate').getFullYear();
		  	var endYear 	= this.get('endDate').getFullYear();
		    
		  	//요일, 월 일
			var startDay	= this._formatDate(start, this.get('dateFormat'));
			var endDay		= this._formatDate(end, this.get('dateFormat'));
		    
			//형식 (요일, 월 일 년도 시간)
		   	var completeStartDate 	= startDay + " " + startYear + " " + startTime; 
		   	var completeEndDate 	= endDay + " " + endYear + " " + endTime; 
		   
		   	alert("new date : " + new Date);
		   	//insertData json
		   	var sysdate = new Date().getTime();
		   	alert("sysdate : " + sysdate);
		    var insertdata = {};
		    
		       insertdata.scheId 		= this.generateClientId()+sysdate;
		       insertdata.scheContent 	= this.getContentNode().val();
		       insertdata.scheStartdate = completeStartDate;
		       insertdata.scheEnddate 	= completeEndDate;
		      
		       alert(JSON.stringify(insertdata));
		       
		       
		       $.ajax({
		   	    type: 'POST',
		        url: '/insertScheduler.do',
		   	    data: insertdata,
		   		dataType : "json",
		   	    success: function(result){
		   	   		
		   	    	alert(result.message);
		   	    	
		   	    },
		   	    error : function(result){
		   	    	
		   	    }
		 	    });
		   
		      
		    },
		    
		    edit: function (event) {
		        
		  
		      
		      
		    },
		    
		    delete: function (event) {
		    	
		    
		    }
		  
		}
		
		 
		
		});
		
		
		
		
		
		new Y.Scheduler(
		{
		activeView: monthView
		,boundingBox: '#myScheduler'
		,date: new Date()
		,eventRecorder: eventRecorder
		,items: events
		,render: true
		,views: [dayView, weekView, monthView, agendaView]
		}
		);
		
		}
		);
				

</script>



</body>
</html>