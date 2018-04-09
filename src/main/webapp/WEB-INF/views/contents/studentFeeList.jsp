<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>



<script type="text/javascript">


/*  
 * 학번별로 검색
 * option 동적 추가 기능
 */
   function stuNumberOption(){
      var date = new Date();
      var year = date.getFullYear();
      var selectValue = document.getElementById("searchStuNumber");
      for(var i=year-40; i<=year; i++){
         selectValue.add(new Option(i,i));
      }
   }
   function FeeUpdateBtn(id){
	   //------- 수정 버튼을 누르면, 해당 칸의 정보가 input태그로 바뀐다.(그 칸의 정보는 그대로 value값으로 가지고 있다,.
	   var listAllCommonMap  = ${listAllCommonMap}
	   var feePaidMethodList = listAllCommonMap.feePaidMethodList
	   var feePaidStatusList = listAllCommonMap.feePaidStatusList
	   
	   

	   var paidDate = "<input type='text' size='8' value="+$('#'+id+'paidDate').html() +"></input>";
	   $('#'+id+'paidDate').empty();
	   $('#'+id+'paidDate').append(paidDate);
	   
	   
	   var totalAmount = "<input type='text' size='7' value="+$('#'+id+'totalAmount').html()+"></input>";
	   $('#'+id+'totalAmount').empty();
	   $('#'+id+'totalAmount').append(totalAmount);
	   
	   
	   var paidAmount = "<input type='text' size='7' value="+$('#'+id+'paidAmount').html()+"></input>";
	   $('#'+id+'paidAmount').empty();
	   $('#'+id+'paidAmount').append(paidAmount);
	   
	   
	   var paidContent = "<input type='text' size='12' value="+$('#'+id+'paidContent').html()+"></input>";
	   $('#'+id+'paidContent').empty();
	   $('#'+id+'paidContent').append(paidContent);
	   //------------------------------------------------------------------------------------------
	   
	   //---------------------수정 버튼을 누르면 select항목이 뜬다. (commonList를 가지고 오는 부분이 완성되면 select자동화 할것.)
	      
	   
	   var paidMethod = "<select><option value=''> 선택</option>";
	   for(var i=0; i<feePaidMethodList.length; i++){
		   paidMethod += "<option value='"+ feePaidMethodList[i].COMMON_CODE+"'";
		   if( $('#'+id+'paidMethodValue').val() == feePaidMethodList[i].COMMON_CODE){
			   paidMethod += " selected ";
		   } 
		   paidMethod += ">"+ feePaidMethodList[i].COMMON_VALUE+"</option>";
	   }
	   paidMethod+="</select>";
	  
	   
	   
	   
	   var paidStatus = "<select><option value=''> 선택</option>";
	   for(var i=0; i<feePaidStatusList.length; i++){
		   paidStatus += "<option value='"+ feePaidStatusList[i].COMMON_CODE+"'";
		  
		   if( $('#'+id+'paidStatusValue').val() == feePaidStatusList[i].COMMON_CODE){
			   paidStatus += " selected ";
		   } 
		   paidStatus += ">"+ feePaidStatusList[i].COMMON_VALUE+"</option>";
	   }
	   paidStatus+="</select>";
	  
	   
	 	
	 	
	   $('#'+id+'paidMethod').empty();
	   $('#'+id+'paidMethod').append(paidMethod);
	   
		$('#'+id+'paidStatus').empty();
		$('#'+id+'paidStatus').append(paidStatus);
		//----------------------버튼 변경--------------------------------
		//-----------------------버튼을 누르면 상위 수정된 항목들이 JSON형식으로 만들어져 Ajax콜 해서 넘겨짐.
		var btn = "<button type='button' class='btn btn-small btn-warning'>완료</button>";
	   $('#'+id+'btn').empty();
	   $('#'+id+'btn').append(btn);
   }
   
   /*
   		Ajax콜을 통해 수정된 자료가 넘어가며, 리턴값으로 true를 받게 되면 눌린 버튼의 
   		input값이 다시 수정된 값으로 만들어져서 보여진다.
   
   */
   
</script>


<div class="card">

	<div class="card-header">
		<label class="small">> 검색으로 찾기</label>
		<form id="searchKeyForm">
			<select>
				<option value="선택없음">선택없음</option>
				<option value="stuName">이름</option>
				<option value="stuNumber">학번</option>
			</select> <input type="text" name="searchContent" /> <input type="button"
				value="검색" onclick="" />
		</form>
		<!-- seachKeywordForm -->
		<hr>



		<lable class="small">> 범위로 찾기</lable>
		<form id="searchScopeForm">
			<input type="text" name="input" /> <label>학번별로</label> <select
				id="searchStuNumber" onclick="javascript:stuNumberOption()">
				<option value="선택없음">선택없음</option>
			</select> <label>상태별로</label> <select>
				<option value="선택없음">선택없음</option>
				<option value="">미납</option>
				<option value="">분할</option>
				<option value="">완료</option>
			</select> <input type="button" value="검색" onclick="" />
		</form>

	</div>


	<div class="card-body">
		<div id="memberList" class="table-responsive">
			<table class="table table-striped">
				<thead>
					<tr>
						<th>번호</th>
						<th>학번</th>
						<th>이름</th>
						<th>입금날짜</th>
						<th>회비금액</th>
						<th>납부금액</th>
						<th>입금방식</th>
						<th>상태</th>
						<th>비고</th>
						<th>옵션</th>
					<tr>
				</thead>
				<tbody>
					<c:forEach var="i" items="${list}" varStatus="index">
							<tr>
								<td>${index.count}</td>
								<td>${i.STU_NUMBER}</td>
								<td>${i.STU_NAME}</td>
								<!-- '수정'버튼 누르면 바뀜. -->
								<!--  select값의 경우에는 hidden값으로 그 부분의 value숫자를 가지고 있어야 한다. -->
								<td id="${i.STU_NUMBER}paidDate">
									${i.FEE_PAID_DATE}
								</td>
								
								<td id="${i.STU_NUMBER}totalAmount">
									${i.FEE_TOTAL_AMOUNT}
								</td>
								
								<td id="${i.STU_NUMBER}paidAmount">
									${i.FEE_PAID_AMOUNT}
								</td>
								
								<td id="${i.STU_NUMBER}paidMethod">
									${i.FEE_PAID_METHOD_VALUE}	
								</td>
								<input type="hidden" id="${i.STU_NUMBER}paidMethodValue"  value="${i.FEE_PAID_METHOD}"/>
								
								<td id="${i.STU_NUMBER}paidStatus">
									${i.FEE_PAID_STATUS_VALUE}
									
								</td>
								<input type="hidden" id="${i.STU_NUMBER}paidStatusValue" value="${i.FEE_PAID_STATUS}"/>
								
		
								<td id="${i.STU_NUMBER}paidContent">
									${i.FEE_CONTENT_VALUE}
								</td>
								
								<td id="${i.STU_NUMBER}btn">							
									<button type="button" class="btn btn-small btn-info"
										onclick="javascript:FeeUpdateBtn(''+${i.STU_NUMBER})">
										수정
									</button>
								</td>

							</tr>
					</c:forEach>

				</tbody>

			</table>
		</div>
	</div>

</div>

