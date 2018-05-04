<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
  <head>
    <title>Say hello using the People API</title>
    <meta charset='utf-8' />
<script src="https://cdn.alloyui.com/3.0.1/aui/aui-min.js"></script>
<link href="https://cdn.alloyui.com/3.0.1/aui-css/css/bootstrap.min.css" rel="stylesheet"></link>
  </head>
  <body>

<div id="wrapper"> 
<div id="myScheduler"></div>
</div>

   
<script>

YUI().use(
		  'aui-scheduler',
		  function(Y) {
		    var events = [
		    	
		      {
		        content: 'AllDay',
		        endDate: new Date(2013, 1, 5, 23, 59),
		        startDate: new Date(2013, 1, 5, 0)
		      },
		      {
		        color: '#8D8',
		        content: 'Colorful',
		        endDate: new Date(2013, 1, 6, 6),
		        startDate: new Date(2013, 1, 6, 2)
		      },
		      {
		        content: 'MultipleDays',
		        endDate: new Date(2013, 1, 8),
		        startDate: new Date(2013, 1, 4)
		      },
		      {
		        content: 'Disabled',
		        disabled: true,
		        endDate: new Date(2013, 1, 8, 5),
		        startDate: new Date(2013, 1, 8, 1)
		      },
		      {
		        content: 'Meeting',
		        endDate: new Date(2013, 1, 7, 7),
		        meeting: true,
		        startDate: new Date(2013, 1, 7, 3)
		      },
		      {
		        color: '#88D',
		        content: 'Overlap',
		        endDate: new Date(2013, 1, 5, 4),
		        startDate: new Date(2013, 1, 5, 1)
		      },
		      {
		        content: 'Reminder',
		        endDate: new Date(2013, 1, 4, 4),
		        reminder: true,
		        startDate: new Date(2013, 1, 4, 0)
		      }
		    ];

		    var agendaView = new Y.SchedulerAgendaView();
		    var dayView = new Y.SchedulerDayView();
		    var eventRecorder = new Y.SchedulerEventRecorder();
		    var monthView = new Y.SchedulerMonthView();
		    var weekView = new Y.SchedulerWeekView();

		    var eventRecorder = new Y.SchedulerEventRecorder({
		        on: {
		            save: function(event) {
		                alert('Save Event:' + this.isNew() + ' --- ' + this.getContentNode().val());
		            },
		            edit: function(event) {
		                alert('Edit Event:' + this.isNew() + ' --- ' + this.getContentNode().val());
		            },
		            delete: function(event) {
		                alert('Delete Event:' + this.isNew() + ' --- ' + this.getContentNode().val());
		    // Note: The cancel event seems to be buggy and occurs at the wrong times, so I commented it out.
//		          },
//		          cancel: function(event) {
//		              alert('Cancel Event:' + this.isNew() + ' --- ' + this.getContentNode().val());
		            }
		        }
		    });
		    
		    
		    
		    new Y.Scheduler(
		      {
		        activeView: weekView,
		        boundingBox: '#myScheduler',
		        date: new Date(2013, 1, 4),
		        eventRecorder: eventRecorder,
		        items: events,
		        render: true,
		        views: [dayView, weekView, monthView, agendaView]
		      }
		    );
		  }
		);
		
		
		

</script>   
   
   
   
  </body>
</html>