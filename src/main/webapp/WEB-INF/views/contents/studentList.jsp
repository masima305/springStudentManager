<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>


<div class="card">

	<div class="card-header">

		<label class="small">> 검색으로 찾기</label>
		<form id="stuSeachKeywordForm">
			<select name="searchCategory">
				<option value="">선택없음</option>
				<option value="stuName">이름</option>
				<option value="stuNumber">학번</option>
				<option value="stuPhone">연락처</option>
				<option value="stuEmail">이메일</option>
			</select> 
			<input type="text" name="searchContent"/> 
			<input type="button" value="검색" onclick="javascript:ajaxStuSearchKeyword('stuSeachKeywordForm')" />
		</form>
		<!-- seachKeywordForm -->
		<hr>

		<label class="small">> 범위로 찾기</label>
		<form id="stuSearchScopeForm">
		
			<label>학번별로</label> 
			<select name="stuNumber" id="searchStuNumber1">
				
			</select>&nbsp;
			
			<label>입학전형별로</label> 
			<select name="stuEnterance">
			<option value="null">선택없음</option>
			<c:forEach var="i" items="${listAllCommonMap.stuEnteranceList}">
				<option value="${i.COMMON_CODE}">${i.COMMON_VALUE}</option>
			</c:forEach>
			</select>&nbsp; 
			
			<label>접근권한별로</label> 
			<select name="stuAuthority">
			<option value="null">선택없음</option>
			<c:forEach var="i" items="${listAllCommonMap.stuAuthorityList}">
				<option value="${i.COMMON_CODE}">${i.COMMON_VALUE}</option>
			</c:forEach>	
			</select>&nbsp; 
			
			<label>성별로</label> 
			<select name="stuGender">
			<option value="null">선택없음</option>
			<c:forEach var="i" items="${listAllCommonMap.stuGenderList}">
				<option value="${i.COMMON_CODE}">${i.COMMON_VALUE}</option>
			</c:forEach>	
			</select> 
			
			<input type="button" value="검색" onclick="javascript:ajaxStuSearchScope('stuSearchScopeForm')" />
		</form>
		
		<!-- searchScopeForm -->
	</div>
	<!-- card-header -->

	<div class="card-body">

		<div id="stuListScroll">
			<table class="table table-striped table-sm">
				<thead>
					<tr>
						<th>번호</th>
						<th>학번</th>
						<th>이름</th>
						<th>성별</th>
						<th>생년월일</th>
						<th>연락처</th>
						<th>이메일</th>
						<th>입학전형</th>
						<th>권한</th>
						<th>옵션</th>
					<tr>
				</thead>


				<tbody id="showStuList">
					<c:forEach var="i" items="${listAllStudent}" varStatus="index">
						<tr>
							<td>${index.count}</td>
							<td>${i.STU_NUMBER}</td>
							<td>${i.STU_NAME}</td>
							<td>${i.STU_GENDER_VALUE}</td>
							<td>${i.STU_BIRTHDAY}</td>
							<td>${i.STU_PHONE}</td>
							<td>${i.STU_EMAIL}</td>
							<td>${i.STU_ENTERANCE_VALUE}</td>
							<td>${i.STU_AUTHORITY_VALUE}</td>
							<td>
							<button type="button" class="btn btn-small btn-info" onclick="javascript:ajaxStuDetail(${i.STU_NUMBER})">보기</button>
						</tr>
					</c:forEach>

				</tbody>
			</table>
		</div>
		<!-- stuListScroll -->
	</div>
	<!-- card-body -->

</div>
<!-- card -->

<!-- Modal -->
  <div class="modal fade" id="stuDetailModal" role="dialog">
    <div class="modal-dialog modal-lg">
    
      <!-- Modal content-->
      <div class="modal-content">
      
        <div class="modal-header">
      	  <h4 class="modal-title">학생 상세 보기</h4>
          <button type="button" class="close" data-dismiss="modal">&times;</button>
        </div>
			        
		<!-- Nav tabs -->
	  	<ul class="nav nav-tabs nav-justified" role="tablist">
		    <li class="nav-item">
		      <a class="nav-link active" data-toggle="tab" href="#stuInfoDetail">기본정보</a>
		    </li>
		    <li class="nav-item">
		      <a class="nav-link" data-toggle="tab" href="#stuFeeDetail">학생회비</a>
		    </li>
		    <li class="nav-item">
		      <a class="nav-link" data-toggle="tab" href="#stuExpDetail">학생경력</a>
		    </li>
		    <li class="nav-item">
		      <a class="nav-link" data-toggle="tab" href="#stuOptDetail">옵션</a>
		    </li>
	  	</ul>
			  
	     <!-- Tab panes -->
	  	<div class="tab-content">
		    <div id="stuInfoDetail" class="container tab-pane active"><br>
		    </div>
		    <div id="stuFeeDetail" class="container tab-pane fade"><br>
		    </div>
		    <div id="stuExpDetail" class="container tab-pane fade"><br>
		    </div>
		    <div id="stuOptDetail" class="container tab-pane fade"><br>
		    </div>
	 	</div>
        
    <!--     <div class="modal-footer" id="modalFooter">
        	
        </div> -->
        
      </div>
    </div>
  </div>


<script>

function ajaxStuDetail(stuNumber){	
	$.ajax({
		url: "/getStudent.do",
		data: {stuNumber: stuNumber},
		method: "post",
		dataType: "json",
		success: function(result) {
			
			//학생 기본 정보
			$("#stuInfoDetail").empty();
			
			//각 정보칸(수정 버튼을 누르면 input태그가 삽입될)의 id룰 : 학번 + Personal + 컬럼명(낙타표기)
			//									  ex : 2010042465PersonalStuNumber
			//									앞으로 있을 중복 사용을 방지하기 위해 이름 길게 할게용....
			var str = "<br>";
			str+="<img class='card-img-top' src='../../../resources/common/img/man.png' alt='Card image' style='width:30%'><br><br>";
			str+="<form>"
			str+=	"<table class='table table-bordered'>"
			str+=	"<tbody>"
			str+=		"<tr>"
			str+=			"<th>학번</th><td>"+result[0].STU_NUMBER+"</td>"
			str+=			"<th>이름</th><td id='"+result[0].STU_NUMBER+"PersonalStuName'>"+result[0].STU_NAME+"</td>";
			str+=		"</tr>"
			str+=		"<tr>"
			str+=			"<th>생년월일</th><td id='"+result[0].STU_NUMBER+"PersonalStuBirthday'>"+result[0].STU_BIRTHDAY+"</td>"
			str+=			"<th>성별</th><td id='"+result[0].STU_NUMBER+"PersonalStuGender'>"+result[0].STU_GENDER_VALUE+"</td>";
			str+=		"</tr>"
			str+=		"<tr>"
			str+=			"<th>연락처</th><td id='"+result[0].STU_NUMBER+"PersonalStuPhone' >"+result[0].STU_PHONE+"</td>"
			str+=			"<th>이메일</th><td id='"+result[0].STU_NUMBER+"PersonalStuEmail' >"+result[0].STU_EMAIL+"</td>"
			str+=		"</tr>";
			str+=		"<tr>"
			str+=			"<th>입학전형</th><td id='"+result[0].STU_NUMBER+"PersonalStuEnteranceValue' >"+result[0].STU_ENTERANCE_VALUE+"</td>"
			str+=			"<th>접근권한</th><td id='"+result[0].STU_NUMBER+"PersonalStuAuthorityValue' >"+result[0].STU_AUTHORITY_VALUE+"</td>"
			str+=		"</tr>";
			str+=	"</tbody>"
			str+=	"</table>"
			str+="</form>"
			$("#stuInfoDetail").append(str);
			$("#stuInfoDetail").append("<hr><button type='button' class='btn btn-small btn-info'>수정</button>");
			$("#stuInfoDetail").append("<br><br>");
			
			
			//학생 회비 정보
			$("#stuFeeDetail").empty();
			var str = "<br>";
			str+="<table class='table table-bordered'>"
			str+="	<thead>"
			str+=		"<tr><th>회비금액</th><th>납부금액</th><th>입금날짜</th><th>입금방식</th><th>상태</th><th>비고</th></tr>"
			str+=	"</thead>"	
			str+=	"<tbody>";
			str+=		"<tr>"
			str+=			"<td id='"+result[0].STU_NUMBER+"PersonalFeeTotalAmount' >"		+ result[0].FEE_TOTAL_AMOUNT	  +  "</td>";
			str+=			"<td id='"+result[0].STU_NUMBER+"PersonalFeePaidAmount' >"		+ result[0].FEE_PAID_AMOUNT 	  +  "</td>";
			str+=			"<td id='"+result[0].STU_NUMBER+"PersonalFeePaidDate' >"		+ result[0].FEE_PAID_DATE 		  +  "</td>";
			str+=			"<td id='"+result[0].STU_NUMBER+"PersonalFeePaidMethodValue'>"	+ result[0].FEE_PAID_METHOD_VALUE +  "</td>";
			str+=			"<td id='"+result[0].STU_NUMBER+"PersonalFeeStatusValue' >"		+ result[0].FEE_PAID_STATUS_VALUE +  "</td>";
			str+=			"<td id='"+result[0].STU_NUMBER+"PersonalFeeContentValue' >"	+ result[0].FEE_CONTENT_VALUE 	  +	 "</td>";
			str+=		"</tr>"
			str+=	"</tbody>"
			str+="</table>"		
			$("#stuFeeDetail").append(str);
			
			str = "<hr>"
			str += "<div id = 'feeBtnArea'>";
			str += 		"<button type='button' onclick='makeFeeInput("+result[0].STU_NUMBER+")' class='btn btn-small btn-info'>수정</button>"
			str += "</div>";
			
			
			
			
			$("#stuFeeDetail").append(str);
			$("#stuFeeDetail").append("<br><br>");
			

			
			//학생 경력 정보
			$("#stuExpDetail").empty();
			var str = "<br>";
			str+="<table class='table table-bordered'>"
			str+=	"<thead>"
			str+=		"<tr><th>년도</th><th>학기</th><th>활동내용</th><th></th></tr>"
			str+=	"</thead>"
			str+=	"<tbody id='ExpContent'>";
			
			$.each(result,function(index,value){
				if(this.EXP_YEAR != undefined ){
			str+=		"<tr>"
			str+=			"<td>"+this.EXP_YEAR + "</td>";
			str+=			"<td>"+this.EXP_SEMESTER + "</td>";
			str+=			"<td>"+this.EXP_CONTENT + "</td>";
			str+=			"<td><button type='button' class='btn btn-small'><i class='fas fa-trash-alt'></i></button></td>"
								//개별 삭제를 위한 버튼
			str+=		"</tr>"
				}});
			str+=	"</tbody>"
			str+="</table>"	
			
			str+="<div id='addInputDiv'></div>";
			// 경력 추가란이 생성 될 자리.
			
			$("#stuExpDetail").append(str);
			// 추가하기 버튼을 누르면 인풋란이 새로 생성된다.
			
			str  = "<hr>";
			str += "<div id = 'expBtnArea'>";
			str += 		"<button type='button' class='btn btn-small btn-info' onclick='javascript:makeExpInput("+result[0].STU_NUMBER+")'>경력추가</button>";
			str += "</div>";
			
			
			$("#stuExpDetail").append(str);
			$("#stuExpDetail").append("<br><br>");
			
			
			
			
			//학생 관리 옵션
			$("#stuOptDetail").empty();
			var str = "<br>";
			str+="<div>";
			str+=	"<p>이 학생의 정보를 삭제합니다.<p>";
			str+=	"<p>학번 : <strong>"+result[0].STU_NUMBER+"</strong></p>"
			str+=	"<p>이름 : <strong>"+result[0].STU_NAME+"</strong></p>"
			str+="<div id='deleteCheckArea'></div>"
					//삭제를 눌렸을 때 이 공간에 삭제 확인칸이 떠야한다.
			str+="<button type='button' class='btn btn-small btn-danger'>삭제</button><br><br>"	;
			str+="</div>";
			
			$("#stuOptDetail").append(str);
			
			//모달 실행
			$("#stuDetailModal").modal();
		}
	});
}
//======================================학생회비 수정용 script ==========================
function makeFeeInput(stuNumber){
	//학생회비 정보수정 생성해주는 칸
	var personalFeeTotalAmount	 	= $("#"+stuNumber+"PersonalFeeTotalAmount").html()
	var personalFeePaidAmount 		= $("#"+stuNumber+"PersonalFeePaidAmount").html()
	var personalFeePaidDate 		= $("#"+stuNumber+"PersonalFeePaidDate").html()
	var personalFeePaidMethodValue 	= $("#"+stuNumber+"PersonalFeePaidMethodValue").html()
	var personalFeeStatusValue 		= $("#"+stuNumber+"PersonalFeeStatusValue").html()
	var personalFeeContentValue 	= $("#"+stuNumber+"PersonalFeeContentValue").html()
	
	$("#"+stuNumber+"PersonalFeeTotalAmount").empty()
	$("#"+stuNumber+"PersonalFeePaidAmount").empty()
	$("#"+stuNumber+"PersonalFeePaidDate").empty()
	$("#"+stuNumber+"PersonalFeePaidMethodValue").empty()
	$("#"+stuNumber+"PersonalFeeStatusValue").empty()
	$("#"+stuNumber+"PersonalFeeContentValue").empty()
	$("#feeBtnArea").empty()
	
	
	var str = "";
	str = "<input id='"+stuNumber+"UpdateFeeTotalAmount' value='"+personalFeeTotalAmount+"' size='6'/>"
	$("#"+stuNumber+"PersonalFeeTotalAmount").append(str)
	
	str = "<input id='"+stuNumber+"UpdateFeePaidAmount' value='"+personalFeePaidAmount+"' size='6'/>"
	$("#"+stuNumber+"PersonalFeePaidAmount").append(str)
	
	//입금날짜 형식 예외처리 필요...
	str = "<input id='"+stuNumber+"UpdateFeePaidDate' value='"+personalFeePaidDate+"' size='8'/>"
	$("#"+stuNumber+"PersonalFeePaidDate").append(str)
	
	//commonCode 처리좀 해줘.....(귀찮....)
	str = "<select id='"+stuNumber+"UpdateFeePaidMethodValue size='8'>"
	str += 	"<option value='1' "
		if( personalFeePaidMethodValue == '계좌이체')	str+="selected ";		
	str += ">계좌이체</option>"
	
	str += 	"<option value='2' "
		if( personalFeePaidMethodValue == '현금')	str+="selected ";		
	str += ">현금</option>"
	str += "</select>"
	
	$("#"+stuNumber+"PersonalFeePaidMethodValue").append(str)
	
	//이거도 commonCode처리좀.......
	str = "<select id='"+stuNumber+"UpdateFeeStatusValue size='8'>"
	str += 	"<option value='1' "
		if( personalFeeStatusValue == '입금완료')	str+="selected ";		
	str += ">입금완료</option>"
	
	str += 	"<option value='2' "
		if( personalFeeStatusValue  == '분할입금')	str+="selected ";		
	str += ">분할입금</option>"
	
	str += 	"<option value='3' "
		if( personalFeeStatusValue == '미납')	str+="selected ";		
	str += ">미납</option>"
	str += "</select>"
		
	
	$("#"+stuNumber+"PersonalFeeStatusValue").append(str)
	
	//fee content 수정의 경우 placeholder와 value 모두에 원래 기입정보를 넣어둔 뒤,
	//원래 내용문이 있었는데 ""상태로 업데이트 할때 진짜 이렇게 할지 묻는 예외처리가 있어줬으면 좋겠다.
	str = "<input id='"+stuNumber+"UpdateFeeContentValue' value='"+personalFeeContentValue+"' size='12'/>"
	$("#"+stuNumber+"PersonalFeeContentValue").append(str)
	
	str = "<button type='button' onclick='updateFeeInput("+stuNumber+")' class='btn btn-small btn-warning'>수정완료</button>"
	$("#feeBtnArea").append(str)
}
function updateFeeInput(stuNumber){
	//여기 수정 하세요
	/* function updateFeeInput(id){
	//-----------------기본적인 값 알아내기 --------------------------
	var paidDateUpdate = $("#"+id+"paidDateUpdate").val();			//변경된 입금날짜
	var totalAmountUpdate = $("#"+id+"totalAmountUpdate").val();	//변경된 총액
	var paidAmountUpdate = $("#"+id+"paidAmountUpdate").val();		//변경된 입금액
	var paidContentUpdate = $("#"+id+"paidContentUpdate").val();	//변경된 비고
	var paidMethodUpdate = $("#"+id+"paidMethodUpdate").val();		//변경된 입금방법
	var paidStatusUpdate = $("#"+id+"paidStatusUpdate").val();		//변경된 입금상태
	
	//-----------------Update를 위한 데이터 json화	-------------------
	var updateData = {};
	
	updateData.feeStudentId = id;
	updateData.feePaidDate = paidDateUpdate;
	updateData.feeTotalAmount = totalAmountUpdate;
	updateData.feePaidAmount = paidAmountUpdate;
	updateData.feePaidContent = paidContentUpdate;
	updateData.feePaidMethod = paidMethodUpdate;
	updateData.feePaidStatus = paidStatusUpdate;
	//------------------유효성 검사 후 ajax call-----------------------
	
	if(true){ //추후 유효성 검사 메서드를 여기 넣는다. ( validator(paidContentUpdate) )
		
		$.ajax({
			url: "updateFee.do",
			data: updateData,
			success: function( result ) {
	
				//------------------------------success 후에 일어나는 변화..
				
				 //------- 수정 버튼을 누르면, 해당 칸의 정보가 input태그로 바뀐다.(그 칸의 정보는 그대로 value값으로 가지고 있다,.
				   var listAllCommonJsonMap  = ${listAllCommonJsonMap}
				   var feePaidMethodList = listAllCommonJsonMap.feePaidMethodList
				   var feePaidStatusList = listAllCommonJsonMap.feePaidStatusList
				   
				   //---------- 표 내용물의 <td>태그 안에 <input>태그를 만들어서 내용을 그대로 넣어준다.
				   $('#'+id+'paidDate').empty();
				   $('#'+id+'paidDate').append(paidDateUpdate);
				   
				   $('#'+id+'totalAmount').empty();
				   $('#'+id+'totalAmount').append(totalAmountUpdate);
				   
				   $('#'+id+'paidAmount').empty();
				   $('#'+id+'paidAmount').append(paidAmountUpdate);
				   
				   $('#'+id+'paidContent').empty();
				   $('#'+id+'paidContent').append(paidContentUpdate);
				   //------------------------------------------------------------------------------------------
				   
				   //---------------------수정 버튼을 누르면 select항목이 뜬다. (commonList를 가지고 오는 부분이 완성되면 select자동화 할것.)
				   var paidMethod = "";
				   for(var i=0; i<feePaidMethodList.length; i++){
					   if( paidMethodUpdate == feePaidMethodList[i].COMMON_CODE){
						   paidMethod += feePaidMethodList[i].COMMON_VALUE;
					   } 
				   }
				   paidMethod += "<input type='hidden' id='"+id+"paidMethodValue'  value='"+paidMethodUpdate+"'/>"
						
				   
				   var paidStatus = "";
				   for(var i=0; i<feePaidStatusList.length; i++){
					   if( paidStatusUpdate == feePaidStatusList[i].COMMON_CODE){
						   paidStatus += feePaidStatusList[i].COMMON_VALUE;
					   } 
				   }
				   paidStatus += "<input type='hidden' id='"+id+"paidStatusValue'  value='"+paidStatusUpdate+"'/>"

				   
				   $('#'+id+'paidMethod').empty();
				   $('#'+id+'paidMethod').append(paidMethod);
				   $('#'+id+'paidMethod').append();
				   
				   
					$('#'+id+'paidStatus').empty();
					$('#'+id+'paidStatus').append(paidStatus);
					//----------------------버튼 변경--------------------------------
					//-----------------------버튼을 누르면 상위 수정된 항목들이 JSON형식으로 만들어져 Ajax콜 해서 넘겨짐.
					var btn = "<button type='button' class='btn btn-small btn-info' onclick='javascript:FeeUpdateBtn("+id+")'>수정</button>";
				   $('#'+id+'btn').empty();
				   $('#'+id+'btn').append(btn);	
				
				},//success
			error: function(a,b,c){
				alert("오류 발생");
				console.log("====== > A : "+ JSON.stringify(a))
				console.log("====== > B : "+ b)
				console.log("====== > C : "+ c)
			}	
		});
						
	}else{
		//유효성 검사에 실패하면 그에 해당하는 alert가 나오고, 전송은 하지 않는체로 종료.
		alert('');
		return;
	}
} */
}

//======================================경력 수정용 script ==========================
function makeExpInput(stuNumber){
	//경력 추가란을 생성해주는 칸
	
	
	var inputstr = "";
	inputstr += "<table class='table table-bordered'>"						
	inputstr += 	"<tbody>"												
	inputstr += 		"<tr>"		
	inputstr += 			"<td>"
	inputstr += 				"<select id='insertExpYear'>"	
	inputstr += 				"</select>&nbsp";
	inputstr += 			"</td>"
	inputstr += 			"<td>"		
	inputstr += 				"<select id='insertExpSemester'>"
	inputstr +=						"<option value='1'>1학기</option>"
	inputstr +=						"<option value='2'>2학기</option>"
	inputstr += 				"</select>&nbsp";
	inputstr += 			"</td>"
	inputstr += 			"<td>"
	inputstr += 				"<input type='text' id='insertExpContent' placeholder='활동내용'/>"
	inputstr += 			"</td>"
	inputstr += 		"</tr>"		
	inputstr += 	"</tbody>"
	inputstr += "</table>"
	$("#addInputDiv").append(inputstr);
	
	
	var str = "<button type='button' class='btn btn-small btn-warning' onclick='javascript:insertExpInput(\""+stuNumber+"\")'>기입완료</button>	&nbsp"
		str += "<button type='button' class='btn btn-small btn-danger' onclick='javascript:resetExpInput()'>취소</button>";
	
	$("#expBtnArea").empty();
	$("#expBtnArea").append(str);
	
	stuNumberOption("insertExpYear");
}
function resetExpInput(){
	$("#addInputDiv").empty();
	$("#expBtnArea").empty();
	str = "<button type='button' class='btn btn-small btn-info' onclick='javascript:makeExpInput()'>경력추가</button>";
	$("#expBtnArea").append(str);
}
function insertExpInput(inputNumber){
	var str = "";
	var stuNumber 	= inputNumber;
	var expYear 	= $("#insertExpYear").val();
	var expSemester = $("#insertExpSemester").val();
	var expContent	= $("#insertExpContent").val();
	
	//예외처리 사항 : 위의 경력사항과 하나라도 겹치는 것이 있는지?
	// 처리방법 : 각  input 4개를 모두 String으로 합친뒤 일치하는지 확인.
	// 일치한다면 예외처리 되어서 alert날려주삼..
	
	
	//--------------------AJAX콜을 위한 JSON 데이터 화 -------------------
	
	var sendData ={};			   
	sendData.stuNumber		 = stuNumber;
	sendData.expYear		 = expYear;
	sendData.expSemester	 = expSemester;
	sendData.expContent		 = expContent;
		
	//--------------------------------------ajax콜로 insert문을 쏴 보낸다.
	
		$.ajax({
		url: "/insertExperience.do",
		data: sendData,
		method: "post",
		dataType: "json",
		success: function(result) {
	//--------------------------------------------------success 이후
			
			str+=		"<tr>"
			str+=			"<td>"+expYear+"</td>";
			str+=			"<td>"+expSemester+ "</td>";
			str+=			"<td>"+expContent + "</td>";
			str+=			"<td><button type='button' class='btn btn-small'><i class='fas fa-trash-alt'></i></button></td>"
			str+=		"</tr>"
			
			var n = $("#ExpContent").html();
			
			if(n.includes("없음")){
				$("#ExpContent").empty();	
			}
			$("#ExpContent").append(str);
				
			$("#addInputDiv").empty();
			$("#expBtnArea").empty();
			str = "<button type='button' class='btn btn-small btn-info' onclick='javascript:makeExpInput(\""+stuNumber+"\")'>경력추가</button>";
			$("#expBtnArea").append(str);
		},
		error: function(abc){
			alert(""+abc)
		}
	});
}








</script>
