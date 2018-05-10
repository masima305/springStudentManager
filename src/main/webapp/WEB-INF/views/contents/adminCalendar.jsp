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
		
	var events = []; 
	        
	YUI().use(
	'aui-scheduler',
		function(Y) {
			
			var jsonData = ${listAllSchedulerGson};
			
			//DB에서 받아온 데이터를 events array에 추가
			for(var i=0; i<jsonData.length; i++){
			    var obj = jsonData[i];
			    events.push({'id':obj.SCHE_ID 
			    			,'disabled':true 
			    			,'content':obj.SCHE_CONTENT
			    			,'startDate':new Date(obj.SCHE_STARTDATE)
			    			,'endDate':new Date(obj.SCHE_ENDDATE)
			    			});
			}	
			
			
			var agendaView 		= new Y.SchedulerAgendaView();
			var dayView	 		= new Y.SchedulerDayView();
			var weekView		= new Y.SchedulerWeekView();
			var monthView 		= new Y.SchedulerMonthView();
			var eventRecorder 	= new Y.SchedulerEventRecorder({
	
				//drag and drop 미적용
				disabled: true,
				
				//스케줄러 템플릿 수정
				strings: {
		             'delete'			: '삭제',
		             'description-hint'	: '내용',
		             cancel				: '취소',
		             description		: '보기',
		             edit				: '수정',
		             save				: '저장',
		             when				: '시간'
		         },
				
				on: {
				
					//==========================이벤트 저장=================================
				
				    save: function (event) {
				    	
				    //id 생성
				    var sysdate = new Date().getTime();
				    var nodeId 	= this.generateClientId()+sysdate;	
				    
				    //node에 id attribute 설정
				  	this.set('id',nodeId);	
	
				    //시작 & 끝 날짜 가져오기
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
				   
				   	
				 	//insertData json
				    var insertData = {};
				    
				    insertData.scheId 			= nodeId;
				    insertData.scheContent 		= this.getContentNode().val();
				    insertData.scheStartdate	= completeStartDate;
				    insertData.scheEnddate 		= completeEndDate;
				      
				       
				       $.ajax({
				   	    type	 : 'POST',
				        url		 : '/insertScheduler.do',
				   	    data	 : insertData,
				   		dataType : "json",
				   	    success	 : function(result){
				   	    	alert(result.message);
				   	    },
				   	    error	 : function(result){}
				 	    });
					    }, 
				    
				    
				  //==========================이벤트 수정=================================
					  
				    edit: function (event) {
				        	
				    	var oldNodeId = this.get('event').get('id');
						var newNodeId = this.get('id');
						 
						//updateData json
						var updateData = {};
						updateData.scheContent 	= this.getContentNode().val();
						
						if(oldNodeId == null){		 //현재 페이지에서 새로만든 노드를 바로 삭제하는 경우
							updateData.scheId = newNodeId;
						}else { 					 //DB에서 불러온 노드를 삭제하는 경우
							updateData.scheId = oldNodeId;
						}
				    	
					       $.ajax({
					   	    type	 : 'POST',
					        url		 : '/updateScheduler.do',
					   	    data	 : updateData,
					   		dataType : "json",
					   	    success	 : function(result){
					   	    	alert(result.message);
					   	    },
					   	    error 	 : function(result){}
					 	    });
				    },
				    
				    
				  //==========================이벤트 삭제=================================
					  
				    delete: function (event) {
				 
						 
						var oldNodeId = this.get('event').get('id');
						var newNodeId = this.get('id');
						 
						//deleteData json
						var deleteData = {};
						
						if(oldNodeId==null){ 			//현재 페이지에서 새로만든 노드를 바로 삭제하는 경우
							 deleteData.scheId = newNodeId;
						} else {							//DB에서 불러온 노드를 삭제하는 경우
							 deleteData.scheId = oldNodeId;
						}
					  
					       $.ajax({
					   	    type	 : 'POST',
					        url		 : '/deleteScheduler.do',
					   	    data	 : deleteData,
					   		dataType : "json",
					   	    success	 : function(result){
					   	    	alert(result.message);
					   	    },
					   	    error 	 : function(result){}
					 	    });
				    }
				    
				} // on
				}); //eventRecorder
				
			
			//스케줄러
			new Y.Scheduler({
				activeView		: monthView
				, boundingBox	: '#myScheduler'
				, date			: new Date()
				, eventRecorder	: eventRecorder
				, items			: events
				, render		: true
				, views			: [dayView, weekView, monthView, agendaView]
			});
		}
	
	);

</script>

</body>
</html>