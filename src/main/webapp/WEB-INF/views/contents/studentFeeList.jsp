<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>



<script>

	function ajaxFeeSearchKeyword(formId) {
		
		$('#'+formId).ajaxForm({
			
			type: "post",
			url: "/searchKeywordFee.do",
			datatype: "json",
			success: function(result){
				
				$("#showFeeList").empty();
				var str = "";
				
				$.each(result,function(index,value){
						str+="<tr>"
						str+="<td>" + index + "</td>";
						str+="<td>" + this.STU_NUMBER + "</td>";
					 	str+="<td>"+ this.STU_NAME + "</td>";
						str+="<td>"+ this.FEE_PAID_DATE + "</td>";
						str+="<td>"+ this.FEE_TOTAL_AMOUNT + "</td>";
						str+="<td>"+ this.FEE_PAID_AMOUNT + "</td>";
						str+="<td>"+ this.FEE_PAID_METHOD_VALUE + "</td>";
						str+="<td>"+ this.FEE_PAID_STATUS_VALUE + "</td>";
						str+="<td>"+ this.FEE_CONTENT_VALUE + "</td>";
						str+="<td><button type='button' class='btn btn-small btn-info'>수정</button>"
						str+="<button type='button' class='btn btn-small btn-danger'>보기</button></td>" 
						str+="</tr>"
				});
				$("#showFeeList").append(str);
			},
			error: function(result){}
		}).submit();
	}
	

	function ajaxFeeSearchScope(formId) {
		
		$('#'+formId).ajaxForm({
			
			type: "post",
			url: "/searchScopeFee.do",
			datatype: "json",
			success: function(result){
				
				$("#showFeeList").empty();
				var str = "";
				
				$.each(result,function(index,value){
					str+="<tr>"
						str+="<td>" + index + "</td>";
						str+="<td>" + this.STU_NUMBER + "</td>";
					 	str+="<td>"+ this.STU_NAME + "</td>";
						str+="<td>"+ this.FEE_PAID_DATE + "</td>";
						str+="<td>"+ this.FEE_TOTAL_AMOUNT + "</td>";
						str+="<td>"+ this.FEE_PAID_AMOUNT + "</td>";
						str+="<td>"+ this.FEE_PAID_METHOD_VALUE + "</td>";
						str+="<td>"+ this.FEE_PAID_STATUS_VALUE + "</td>";
						str+="<td>"+ this.FEE_CONTENT_VALUE + "</td>";
						str+="<td><button type='button' class='btn btn-small btn-info'>수정</button>"
						str+="<button type='button' class='btn btn-small btn-danger'>보기</button></td>" 
						str+="</tr>"
				});
				$("#showFeeList").append(str);
			},
			error: function(result){}
		}).submit();
	}


   function FeeUpdateBtn(id){
	   //------- 수정 버튼을 누르면, 해당 칸의 정보가 input태그로 바뀐다.(그 칸의 정보는 그대로 value값으로 가지고 있다,.
	   var listAllCommonJsonMap  = ${listAllCommonJsonMap}
	   var feePaidMethodList = listAllCommonJsonMap.feePaidMethodList
	   var feePaidStatusList = listAllCommonJsonMap.feePaidStatusList
	   
	   

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
			<form id="feeSeachKeywordForm">
			<select name="searchCategory">
				<option value="">선택없음</option>
				<option value="stuName">이름</option>
				<option value="stuNumber">학번</option>
				<option value="stuPhone">연락처</option>
				<option value="stuEmail">이메일</option>
			</select> 
			<input type="text" name="searchContent" />
			<input type="button" value="검색" onclick="javascript:ajaxFeeSearchKeyword('feeSeachKeywordForm')" />
		</form> <!-- seachKeywordForm -->
		<hr>


		<label class="small">> 범위로 찾기</label>
		<form id="feeSearchScopeForm">
		
			<label>학번별로</label> 
			<select name="stuNumber" id="searchStuNumber2" onclick="javascript:stuNumberOption('searchStuNumber2')">
				<option value="null">선택없음</option>
			</select>&nbsp;
				
			
			<label>상태별로</label> 
			<select name="feePaidStatus">
			<option value="null">선택없음</option>
			<c:forEach var="i" items="${listAllCommonObjectMap.feePaidStatusList}">
				<option value="${i.COMMON_CODE}">${i.COMMON_VALUE}</option>
			</c:forEach>
			</select>&nbsp; 
			
			<input type="button" value="검색" onclick="javascript:ajaxFeeSearchScope('feeSearchScopeForm')" />
		</form> <!-- searchScopeForm -->
	</div>


	<div class="card-body">
		<div id="stuListScroll">
			<table class="table table-striped table-sm">
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
				
				<tbody id="showFeeList">
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
		</div> <!-- stuListScroll -->
	</div>

</div>

