<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>




<div class="card">

	<div class="card-header">

		<label class="small">> 검색으로 찾기</label>
		<form id="stuSeachKeywordForm">
		
			<select name="searchCategory">
				<option value=""		 >선택없음  </option>
				<option value="stuName"	 >이름	</option>
				<option value="stuNumber">학번	</option>
				<option value="stuPhone" >연락처	</option>
				<option value="stuEmail" >이메일	</option>
			</select> 
		
			<input type="text" 	 name="searchContent"/> 
			<input type="button" value="검색" onclick="javascript:ajaxStuSearchKeyword('stuSeachKeywordForm')" />
		
		</form>
		<!-- seachKeywordForm -->
		<hr>

		<label class="small">> 범위로 찾기</label>
		<form id="stuSearchScopeForm">
		
			<label>학번별로</label> 
			<select name="stuNumber" id="searchStuNumber1">
				<!-- javascript onload -->		
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
						<th> 번호		</th>
						<th> 학번		</th>
						<th> 이름		</th>
						<th> 성별		</th>
						<th> 생년월일 	</th>
						<th> 연락처	</th>
						<th> 이메일	</th>
						<th> 입학전형	</th>
						<th> 권한		</th>
						<th> 옵션		</th>
					<tr>
				</thead>


				<tbody id="showStuList">
					<c:forEach var="i" items="${listAllStudent}" varStatus="index">
						<tr>
							<td> ${index.count}				</td>
							<td> ${i.STU_NUMBER}			</td>
							<td> ${i.STU_NAME}				</td>
							<td> ${i.STU_GENDER_VALUE}		</td>
							<td> ${i.STU_BIRTHDAY}			</td>
							<td> ${i.STU_PHONE}				</td>
							<td> ${i.STU_EMAIL}				</td>
							<td> ${i.STU_ENTERANCE_VALUE}	</td>
							<td> ${i.STU_AUTHORITY_VALUE}	</td>
							<td>
								<button type="button" class="btn btn-small btn-info" onclick="javascript:ajaxStuDetail(${i.STU_NUMBER})">보기</button>
							</td>
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

$(document).ready(function(){
	stuNumberOption("searchStuNumber1",undefined)
	});


function ajaxStuDetail(stuNumber){	
	$.ajax({
		url: "/getStudent.do",
		data: {stuNumber: stuNumber},
		method: "post",
		dataType: "json",
		success: function(result) {
			
			//학생 기본 정보
			$("#stuInfoDetail").empty();
			
			//각 정보칸(수정 버튼을 누르면 input태그가 삽입될)의 id룰 : Personal + 컬럼명(낙타표기)
			//									  ex : PersonalStuNumber
			//									앞으로 있을 중복 사용을 방지하기 위해 이름 길게 할게용....
			var str = "<br>";
			str+="<img class='card-img-top' src='../../../resources/common/img/man.png' alt='Card image' style='width:30%'><br><br>";
			str+="<form>"
			str+=	"<table class='table table-bordered'>";
			str+=	"<tbody>";
			str+=		"<tr>";
			str+=			"<th>학번</th><td>"+result[0].STU_NUMBER+"</td>";
			str+=			"<th>이름</th><td id='personalStuName'>"+result[0].STU_NAME+"</td>";
			str+=		"</tr>";
			str+=		"<tr>";
			str+=			"<th>생년월일</th><td id='personalStuBirthday'>"+result[0].STU_BIRTHDAY+"</td>";
			str+=			"<th>성별</th><td id='personalStuGender'>"+result[0].STU_GENDER_VALUE+"</td>";
			str+=		"</tr>";
			str+=		"<tr>";
			str+=			"<th>연락처</th><td id='personalStuPhone' >"+result[0].STU_PHONE+"</td>";
			str+=			"<th>이메일</th><td id='personalStuEmail' >"+result[0].STU_EMAIL+"</td>";
			str+=		"</tr>";
			str+=		"<tr>";
			str+=			"<th>입학전형</th><td id='personalStuEnteranceValue' >"+result[0].STU_ENTERANCE_VALUE+"</td>";
			str+=			"<th>접근권한</th><td id='personalStuAuthorityValue' >"+result[0].STU_AUTHORITY_VALUE+"</td>";
			str+=		"</tr>";
			str+=	"</tbody>";
			str+=	"</table>";
			str+="</form>";
			$("#stuInfoDetail").append(str);
			$("#stuInfoDetail").append("<div id = 'infoBtnArea'><hr><button type='button' onclick='makeInfoInput("+result[0].STU_NUMBER+")' class='btn btn-small btn-info'>수정</button></div>");
			$("#stuInfoDetail").append("<br><br>");
			
			
			//------------------------------------------학생 회비 정보----------------------------------------------------------------------
			$("#stuFeeDetail").empty();
			var str = "<br>";
			str +="<table class='table table-bordered'>";
			str +="	<thead>"
			str +=		"<tr><th>회비금액</th><th>납부금액</th><th>입금날짜</th><th>입금방식</th><th>상태</th><th>비고</th></tr>";
			str +=	"</thead>";
			str +=	"<tbody>";
			str +=		"<tr>";
			str +=			"<td id='personalFeeTotalAmount' >"		+ result[0].FEE_TOTAL_AMOUNT	  +  "</td>";
			str +=			"<td id='personalFeePaidAmount' >"		+ result[0].FEE_PAID_AMOUNT 	  +  "</td>";
			str +=			"<td id='personalFeePaidDate' >"		+ result[0].FEE_PAID_DATE 		  +  "</td>";
			str +=			"<td id='personalFeePaidMethodValue'>"	+ result[0].FEE_PAID_METHOD_VALUE +  "</td>";
			str +=			"<td id='personalFeePaidStatusValue' >"	+ result[0].FEE_PAID_STATUS_VALUE +  "</td>";
			str +=			"<td id='personalFeeContentValue' >"	+ result[0].FEE_CONTENT_VALUE 	  +	 "</td>";
			str +=		"</tr>"
			str +=	"</tbody>"
			str +="</table>"		
			
			$("#stuFeeDetail").append(str);
			
			str  = "<hr>"
			str += "<div id = 'feeBtnArea'>";
			str += 		"<button type='button' onclick='makeFeeInput("+result[0].STU_NUMBER+")' class='btn btn-small btn-info'>수정</button>"
			str += "</div>";
			
			
			
			
			$("#stuFeeDetail").append(str);
			$("#stuFeeDetail").append("<br><br>");
			

			
			//학생 경력 정보
			$("#stuExpDetail").empty();
			var str = "<br>";
			str +="<table class='table table-bordered'>"
			str +=	"<thead>";
			str +=		"<tr><th>년도</th><th>학기</th><th>활동내용</th><th></th></tr>";
			str +=	"</thead>";
			str +=	"<tbody id='ExpContent'>";
			
			$.each(result,function(index,value){
				if(this.EXP_YEAR != undefined ){
			str+=		"<tr>";
			str+=			"<td>"+this.EXP_YEAR + "</td>";
			str+=			"<td>"+this.EXP_SEMESTER + "</td>";
			str+=			"<td>"+this.EXP_CONTENT + "</td>";
			str+=			"<td><button type='button' class='btn btn-small' onclick='javascript:deleteExperience("+result[0].STU_NUMBER+","+this.EXP_YEAR+","+this.EXP_SEMESTER+",\""+this.EXP_CONTENT+"\""+")'><i class='fas fa-trash-alt'></i></button></td>";
								//개별 삭제를 위한 버튼
			str+=		"</tr>";
				}});
			str+=	"</tbody>";
			str+="</table>"	;
			
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
			str+=	"<p>학번 : <strong>" + result[0].STU_NUMBER + "</strong></p>"
			str+=	"<p>이름 : <strong>" + result[0].STU_NAME	  + "</strong></p>"
			str+=	"<div id='deleteCheckArea'>"
				//삭제를 눌렸을 때 이 공간에 삭제 확인칸이 떠야한다.
			str+=	"</div>"
			str+=	"<div id='deleteBtnArea'>"
			str+=		"<button type='button' onclick='javascript:makeDeleteInput("+result[0].STU_NUMBER+",\""+result[0].STU_NAME+"\")' class='btn btn-small btn-danger'>삭제</button><br><br>";
			str+=	"</div>"
			str+="</div>";
			
			
			
			
			$("#stuOptDetail").append(str);
			
			//모달 실행
			$("#stuDetailModal").modal();
		}
	});
}
//======================================학생정보 수정용 script ==========================
function makeInfoInput(stuNumber){
	
	var listAllCommonJsonMap = ${listAllCommonGson};
	var stuGenderList 	 = listAllCommonJsonMap.stuGenderList;
	var stuAuthorityList = listAllCommonJsonMap.stuAuthorityList;
	var stuEnteranceList = listAllCommonJsonMap.stuEnteranceList;
	
	var personalStuName	 			= $("#personalStuName"	 		).html();
	var personalStuBirthday 		= $("#personalStuBirthday"	 	).html();
	var personalStuGender 			= $("#personalStuGender"		).html();
	var personalStuPhone 			= $("#personalStuPhone"			).html();
	var personalStuEmail 			= $("#personalStuEmail"			).html();
	var personalStuEnteranceValue	= $("#personalStuEnteranceValue").html();
	var personalStuAuthorityValue	= $("#personalStuAuthorityValue").html();

	$("#personalStuName"	 		).empty();
	$("#personalStuBirthday"	 	).empty();
	$("#personalStuGender"			).empty();
	$("#personalStuPhone"			).empty();
	$("#personalStuEmail"			).empty();
	$("#personalStuEnteranceValue"	).empty();
	$("#personalStuAuthorityValue"	).empty();
	
	//------------------input tag 입력-----------------------------------------
	
	var str = "";
	str = "<input id='updateStuName' value='"+personalStuName+"'>";
	$("#personalStuName").append(str);
	
	str = "<input id='updateStuBirthday' value='"+personalStuBirthday+"'>";
	$("#personalStuBirthday").append(str);
	
	str = "<input id='updateStuPhone' value='"+personalStuPhone+"'>";
	$("#personalStuPhone").append(str);
	
	str = "<input id='updateStuEmail' value='"+personalStuEmail+"'>";
	$("#personalStuEmail").append(str);
	
	//-------------------select tag 입력 -------------------------------------
	
	str  = "<select id='updateStuGender'>"
		for(var k in stuGenderList) {
	str += 		"<option value='"+stuGenderList[k].COMMON_CODE+"'";   
			if(stuGenderList[k].COMMON_VALUE == personalStuGender) str += " selected ";
	str +=	">" + stuGenderList[k].COMMON_VALUE + "</option>";			
		}
	str += "</select>"
	
	$("#personalStuGender").append(str);
	
	str  = "<select id='updateStuAuthority'>"
		for(var k in stuAuthorityList) {
	str += 		"<option value='"+stuAuthorityList[k].COMMON_CODE+"'";   
			if(stuAuthorityList[k].COMMON_VALUE == personalStuAuthorityValue) str += " selected ";
	str +=	">" + stuAuthorityList[k].COMMON_VALUE + "</option>";			
		}
	str += "</select>"
	
	$("#personalStuAuthorityValue").append(str);
	
	str  = "<select id='updateStuEnterance'>"
		for(var k in stuEnteranceList) {
	str += 		"<option value='"+stuEnteranceList[k].COMMON_CODE+"'";   
			if(stuEnteranceList[k].COMMON_VALUE == personalStuEnteranceValue) str += " selected ";
	str +=	">" + stuEnteranceList[k].COMMON_VALUE + "</option>";			
		}
	str += "</select>"
	
	$("#personalStuEnteranceValue").append(str);
	
	/*------------------------infoBtnArea-----------------------------*/
	
	
	str = "<button type='button' onclick='javascript:updateInfoInput("+stuNumber+")' class='btn btn-small btn-warning'>수정완료</button>"
	$('#infoBtnArea').empty();
	$("#infoBtnArea").append(str);

}

function updateInfoInput(id){
	
	
	var listAllCommonJsonMap = ${listAllCommonGson};
	var stuGenderList 	 = listAllCommonJsonMap.stuGenderList;
	var stuAuthorityList = listAllCommonJsonMap.stuAuthorityList;
	var stuEnteranceList = listAllCommonJsonMap.stuEnteranceList;
	

	//------------------input tag 입력-----------------------------------------
	
	var updateStuName 		= $('#updateStuName'	 ).val();
	var updateStuBirthday 	= $('#updateStuBirthday' ).val();
	var updateStuPhone 		= $('#updateStuPhone'	 ).val();
	var updateStuEmail 		= $('#updateStuEmail'	 ).val();
	var updateStuGender 	= $('#updateStuGender'	 ).val();
	var updateStuAuthority 	= $('#updateStuAuthority').val();
	var updateStuEnterance 	= $('#updateStuEnterance').val();
	
	//-----------------Update를 위한 데이터 json화	-------------------
	var updateData = {};
	
	updateData.stuNumber	= id;
	updateData.stuName 		= updateStuName;
	updateData.stuBirthday 	= updateStuBirthday;
	updateData.stuPhone 	= updateStuPhone;
	updateData.stuEmail 	= updateStuEmail;
	updateData.stuGender 	= updateStuGender;
	updateData.stuAuthority = updateStuAuthority;
	updateData.stuEnterance = updateStuEnterance;

	//--------------------ajax call---------------------------
	//------------------유효성 검사 후 ajax call-----------------------
	
	if(true){ //추후 유효성 검사 메서드를 여기 넣는다. ( validator(paidContentUpdate) )
		
		$.ajax({
			url: "/updateStudent.do",
			data: updateData,
			success: function( result ) {
			
				//------------------------------success 후에 일어나는 변화..
				//-- 각 항목에 있는 input칸을 지워주고 변경될 값을 html에 넣어준다. 
				
				
	
				$("#personalStuPhone"			).html(updateStuPhone	);
				$("#personalStuEmail"			).html(updateStuEmail	);
				$("#personalStuName"	 		).html(updateStuName	);
				$("#personalStuBirthday"	 	).html(updateStuBirthday);
				
				
				//-------------------select tag 입력 -------------------------------------
				
				var gender = "";
				var enterance = "";
				var authority = "";
				
				for(var k in stuGenderList) {
					if(stuGenderList[k].COMMON_CODE == updateStuGender){
						gender += stuGenderList[k].COMMON_VALUE;			
					}
				}
				
				for(var k in stuAuthorityList) {
					if(stuAuthorityList[k].COMMON_CODE == updateStuAuthority){
						authority += stuAuthorityList[k].COMMON_VALUE;			
					}
				}
				for(var k in stuEnteranceList) {
					if(stuEnteranceList[k].COMMON_CODE == updateStuEnterance){
						enterance += stuEnteranceList[k].COMMON_VALUE;			
					}
				}
				
				   
				$('#personalStuGender'			).html(gender	);
				$('#personalStuEnteranceValue'	).html(enterance);
				$('#personalStuAuthorityValue'	).html(authority);
	
				var btn = "<button type='button' class='btn btn-small btn-info' onclick='javascript:makeInfoInput("+id+")'>수정</button>";
				$('#infoBtnArea').empty();
				$('#infoBtnArea').append(btn);	
					
				},//success
			error: function(a,b,c){
				
			}	
		});
						
	}else{
		//유효성 검사에 실패하면 그에 해당하는 alert가 나오고, 전송은 하지 않는체로 종료.
		alert('');
		return;
	}
}
//======================================학생정보 삭제용 script ==========================
function makeDeleteInput(stuNumber,stuName){
	var str = "";
	str += "<hr>"
	str += "<form id='deleteStudentForm' action='deleteStudent.do'>"			
	str +=	 "<p><h4><strong>학번+이름</strong>을 한번 더 입력하세요</h4></p>"
	str +=	 "<div id='deleteKeywordWarning' name='' class='text-danger'></div>"		//삭제 키워드를 쓰지 않거나 옳게 쓰지 않았을때 나오는 경고문이 뜰 칸.		
	str +=	 "<p><input type='text' id='deleteKeyword' placeholder='ex)12341234홍길동'></p>"
	str +=	 "<p><h4>정보 삭제의 <strong>이유</strong>를 입력하세요</h4></p>"		
	str +=	 "<div id='deleteReasonWarning' class='text-danger'></div>"			//삭제 이유를 쓰지 않거나 옳게 쓰지 않았을때 경고문이 나오는 공간 경고문 뜰 칸.	
	str +=	 "<p><input type='text' name='logReason' id='deleteReason' placeholder='ex)타대학 편입'></p>"
	str +=	 "<input type='hidden' name='stuNumber' value="+stuNumber+">"	
	str += "</form>"
							
	$("#deleteCheckArea").html(str)		
	str  = "<button type='button' onclick='javascript:deleteStudent("+stuNumber+",\""+stuName+"\")'"
	str +=	 " class='btn btn-small btn-danger'>입력완료:삭제실행</button><br><br>"
	$("#deleteBtnArea"	).html(str)	
}
function deleteStudent(stuNumber,stuName){
	var inputDeleteKeyword = $("#deleteKeywordWarning").val();
	var originalDeleteKeyword = ""+stuNumber+""+stuName+"";
	
	var typedDeleteKeyword 	= $("#deleteKeyword").val();
	var typedDeleteReason 	= $("#deleteReason"	).val();
	
	if(originalDeleteKeyword == typedDeleteKeyword && typedDeleteReason != undefined){
		$("#deleteStudentForm").submit();
				
	
	}else{
		alert("삭제에 실패하였습니다. 입력칸을 확인해주세요.");
		$("#deleteKeywordWarning").html("학번이름의 조합이 맞지 않습니다. 다시 입력해주세요."			);
		$("#deleteReasonWarning" ).html("이유의 형식이 맞지 않거나, 입력값이 없습니다. 다시 입력해주세요"	);			
	}	
	
	
	
		
		
		
		
	
}	
//======================================학생회비 수정용 script ==========================
function makeFeeInput(stuNumber){
	//학생회비 정보수정 생성해주는 칸
	
	var listAllCommonJsonMap = ${listAllCommonGson}
	alert(JSON.stringify(listAllCommonJsonMap));
	
	var personalFeeTotalAmount	 	= $("#personalFeeTotalAmount"	 ).html();
	var personalFeePaidAmount 		= $("#personalFeePaidAmount"	 ).html();
	var personalFeePaidDate 		= $("#personalFeePaidDate"		 ).html();
	var personalFeePaidMethodValue 	= $("#personalFeePaidMethodValue").html();
	var personalFeePaidStatusValue 	= $("#personalFeePaidStatusValue").html();
	var personalFeeContentValue 	= $("#personalFeeContentValue"	 ).html();
	
	$("#personalFeeTotalAmount"		).empty();
	$("#personalFeePaidAmount"		).empty();
	$("#personalFeePaidDate"		).empty();
	$("#personalFeePaidMethodValue"	).empty();
	$("#personalFeePaidStatusValue"	).empty();
	$("#personalFeeContentValue"	).empty();
	$("#feeBtnArea"					).empty();
	
	
	var str = "";
	str = "<input id='updateFeeTotalAmount' value='"+personalFeeTotalAmount+"' size='6'/>"
	$("#personalFeeTotalAmount").append(str)
	
	str = "<input id='updateFeePaidAmount' value='"+personalFeePaidAmount+"' size='6'/>"
	$("#personalFeePaidAmount").append(str)
	
	//입금날짜 형식 예외처리 필요...
	str = "<input id='updateFeePaidDate' value='"+personalFeePaidDate+"' size='8'/>"
	$("#personalFeePaidDate").append(str)
	
	str  = "<select id='updateFeePaidMethodValue'>"
		for(var k in listAllCommonJsonMap.feePaidMethodList) {
	str += 		"<option value='"+listAllCommonJsonMap.feePaidMethodList[k].COMMON_CODE+"'";   
			if(listAllCommonJsonMap.feePaidMethodList[k].COMMON_CODE == personalFeePaidMethodValue) str += " id='updateFeePaidMethodText' selected ";
	str +=	">" + listAllCommonJsonMap.feePaidMethodList[k].COMMON_VALUE + "</option>";			
		}
	str += "</select>"
			
	$("#personalFeePaidMethodValue").append(str)
	
	
	str = "<select id='updateFeePaidStatusValue'>"
		for(var k in listAllCommonJsonMap.feePaidStatusList) {
	str += 		"<option value='"+listAllCommonJsonMap.feePaidStatusList[k].COMMON_CODE+"'";   
			if(listAllCommonJsonMap.feePaidStatusList[k].COMMON_CODE == personalFeePaidStatusValue) str += "id='updateFeePaidStatusText' selected ";
	str +=	">" + listAllCommonJsonMap.feePaidStatusList[k].COMMON_VALUE + "</option>";			
		}
	str += "</select>"	
	
	$("#personalFeePaidStatusValue").append(str)
	
	str = "<input id='updateFeeContentValue' value='"+personalFeeContentValue+"'>";
	$("#personalFeeContentValue").append(str);
	
	
	
	
	//fee content 수정의 경우 placeholder와 value 모두에 원래 기입정보를 넣어둔 뒤,
	//원래 내용문이 있었는데 ""상태로 업데이트 할때 진짜 이렇게 할지 묻는 예외처리가 있어줬으면 좋겠다.
	str = "<input id='"+stuNumber+"UpdateFeeContentValue' value='"+personalFeeContentValue+"' size='12'/>"
	$("#"+stuNumber+"PersonalFeeContentValue").append(str)
	
	str = "<button type='button' onclick='javascript:updateFeeInput("+stuNumber+")' class='btn btn-small btn-warning'>수정완료</button>"
	$('#feeBtnArea').empty();
	$("#feeBtnArea").append(str)
}

function updateFeeInput(id){
	//-----------------기본적인 값 알아내기 --------------------------
	
	var listAllCommonJsonMap = ${listAllCommonGson}

	var paidDateUpdate 		= $("#updateFeePaidDate"		 ).val();		//변경된 입금날짜
	var totalAmountUpdate 	= $("#updateFeeTotalAmount"	  	 ).val();		//변경된 총액
	var paidAmountUpdate 	= $("#updateFeePaidAmount"	  	 ).val();		//변경된 입금액
	var paidContentUpdate 	= $("#updateFeeContentValue"	 ).val();		//변경된 비고
	var paidMethodUpdate 	= $("#updateFeePaidMethodValue"  ).val();		//변경된 입금방법
	var paidStatusUpdate 	= $("#updateFeePaidStatusValue"	 ).val();		//변경된 입금상태
	
	//-----------------Update를 위한 데이터 json화	-------------------
	var updateData = {};
	
	updateData.feeStudentId 	= id;
	updateData.feePaidDate 		= paidDateUpdate;
	updateData.feeTotalAmount 	= totalAmountUpdate;
	updateData.feePaidAmount 	= paidAmountUpdate;
	updateData.feePaidContent 	= paidContentUpdate;
	updateData.feePaidMethod 	= paidMethodUpdate;
	updateData.feePaidStatus 	= paidStatusUpdate;
	//------------------유효성 검사 후 ajax call-----------------------
	
	if(true){ //추후 유효성 검사 메서드를 여기 넣는다. ( validator(paidContentUpdate) )
		
		$.ajax({
			url: "updateFee.do",
			data: updateData,
			success: function( result ) {
			
				//------------------------------success 후에 일어나는 변화..
				//-- 각 항목에 있는 input칸을 지워주고 변경될 값을 html에 넣어준다. 
				$('#personalFeePaidDate'		).empty();
				$('#personalFeeTotalAmount'	  	).empty();
				$('#personalFeePaidAmount'	  	).empty();
				$('#personalFeeContentValue'	).empty();
				$('#personalFeePaidMethodValue' ).empty();
				$('#personalFeePaidStatusValue'	).empty();
				
				   	
				
				$('#personalFeePaidDate'	).append(paidDateUpdate		);
				$('#personalFeeTotalAmount'	).append(totalAmountUpdate	);
				$('#personalFeePaidAmount'	).append(paidAmountUpdate	);
				$('#personalFeeContentValue').append(paidContentUpdate	);
				
				//-- select 태그의 값같은 경우, 태그 안에 있는 value값과 공통코드의 code값을 비교해서 text불러온다.
				var paidMethod = "";

				for(var k in listAllCommonJsonMap.feePaidMethodList) {
					if(listAllCommonJsonMap.feePaidMethodList[k].COMMON_CODE == paidMethodUpdate){
						paidMethod += listAllCommonJsonMap.feePaidMethodList[k].COMMON_VALUE;			
					}
				}
				   
				var paidStatus = "";
				
				for(var k in listAllCommonJsonMap.feePaidStatusList) {
					if(listAllCommonJsonMap.feePaidStatusList[k].COMMON_CODE == paidStatusUpdate){
						paidStatus += listAllCommonJsonMap.feePaidStatusList[k].COMMON_VALUE;			
					}
				}
				   
				$('#personalFeePaidMethodValue').append(paidMethod);
				$('#personalFeePaidMethodValue').append();
				$('#personalFeePaidStatusValue').append(paidStatus);
				
				var btn = "<button type='button' class='btn btn-small btn-info' onclick='javascript:makeFeeInput("+id+")'>수정</button>";
				$('#feeBtnArea').empty();
				$('#feeBtnArea').append(btn);	
					
				},//success
			error: function(a,b,c){
				
			}	
		});
						
	}else{
		//유효성 검사에 실패하면 그에 해당하는 alert가 나오고, 전송은 하지 않는체로 종료.
		alert('');
		return;
	}
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
	var startYear = (stuNumber.toString()).substr(0,4);
	stuNumberOption("insertExpYear",parseInt(startYear));
}
function resetExpInput(){	

	$("#addInputDiv").empty();
	$("#expBtnArea"	).empty();
	str = "<button type='button' class='btn btn-small btn-info' onclick='javascript:makeExpInput()'>경력추가</button>";
	$("#expBtnArea"	).append(str);
}
function insertExpInput(inputNumber){
	var str = "";
	var stuNumber 	= inputNumber;
	var expYear 	= $("#insertExpYear"	).val();
	var expSemester = $("#insertExpSemester").val();
	var expContent	= $("#insertExpContent"	).val();
	
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
			
			str+=		"<tr id=>";
			str+=			"<td>"+expYear+"</td>";
			str+=			"<td>"+expSemester+ "</td>";
			str+=			"<td>"+expContent + "</td>";
			str+=			"<td><button type='button' class='btn btn-small' onclick='javascript:deleteExperience("+stuNumber+","+expYear+","+expSemester+",\""+expContent+"\""+")'><i class='fas fa-trash-alt'></i></button></td>";
			str+=		"</tr>";
			
			var n = $("#ExpContent").html();
			
			if(n.includes("없음")){
				$("#ExpContent").empty();	
			}
			$("#ExpContent").append(str);
				
			$("#addInputDiv").empty();
			$("#expBtnArea"	).empty();
			str = "<button type='button' class='btn btn-small btn-info' onclick='javascript:makeExpInput(\""+stuNumber+"\")'>경력추가</button>";
			$("#expBtnArea"	).append(str);
		},
		error: function(abc){
			alert(""+abc);
		}//error
	});
}

function deleteExperience(delstuNumber,delExpYear,delExpSemester,delExpContent){
	
	//삭제 확인창에 대한 값이 true일 경우
	if(confirm("해당 경력을 삭제하시겠습니까?")){
		
		var stuNumber 	= delstuNumber;
		var expYear 	= delExpYear;
		var expSemester = delExpSemester;
		var expContent 	= delExpContent;
		
		var sendData ={};			   
		sendData.stuNumber		 = stuNumber;
		sendData.expYear		 = expYear;
		sendData.expSemester	 = expSemester;
		sendData.expContent	 	 = expContent;
		
		//--------------------------------------ajax콜로 delete문을 쏴 보낸다.
		
				$.ajax({
				url: "/deleteExperience.do",
				data: sendData,
				method: "post",
				dataType: "json",
				success: function(result) {
			//--------------------------------------------------success 이후
			
					//학생 경력 정보
					$("#stuExpDetail").empty();
					var str = "<br>";
					str +="<table class='table table-bordered'>"
					str +=	"<thead>";
					str +=		"<tr><th>년도</th><th>학기</th><th>활동내용</th><th></th></tr>";
					str +=	"</thead>";
					str +=	"<tbody id='ExpContent'>";
					
					$.each(result,function(index,value){
						if(this.EXP_YEAR != undefined ){
					str+=		"<tr>";
					str+=			"<td>"+this.EXP_YEAR + "</td>";
					str+=			"<td>"+this.EXP_SEMESTER + "</td>";
					str+=			"<td>"+this.EXP_CONTENT + "</td>";
					str+=			"<td><button type='button' class='btn btn-small' onclick='javascript:deleteExperience("+result[0].STU_NUMBER+","+this.EXP_YEAR+","+this.EXP_SEMESTER+",\""+this.EXP_CONTENT+"\""+")'><i class='fas fa-trash-alt'></i></button></td>";
										//개별 삭제를 위한 버튼
					str+=		"</tr>";
						}});
					str+=	"</tbody>";
					str+="</table>"	;
					
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
			
				},
				error: function(abc){
					alert(""+abc);
				}//error
			});
	}

}

</script>
