//----------------------------학생 년도 출력-------------------------------------
function stuNumberOption(id){
	var selectValue = document.getElementById(id);
	$("#"+id).empty();
	
	var date = new Date();
    var year = date.getFullYear();
    
    for(var i=year-40; i<=year; i++){
    	$("#"+id).append(new Option(i,i));
    }
 } 

//-------------------------------Student List---------------------------------
$("#showStuList").empty();

function ajaxStuSearchKeyword(formId) {
	
	$('#'+formId).ajaxForm({
		
		type: "post",
		url: "/searchKeywordStudent.do",
		datatype: "json",
		success: function(result){
			
			$("#showStuList").empty();
			var str = "";
			
			$.each(result,function(index,value){
					str+="<tr>"
					str+="<td>" + index + "</td>";
					str+="<td>" + this.STU_NUMBER + "</td>";
				 	str+="<td>"+ this.STU_NAME + "</td>";
					str+="<td>"+ this.STU_GENDER_VALUE + "</td>";
					str+="<td>"+ this.STU_BIRTHDAY + "</td>";
					str+="<td>"+ this.STU_PHONE + "</td>";
					str+="<td>"+ this.STU_EMAIL + "</td>";
					str+="<td>"+ this.STU_ENTERANCE_VALUE + "</td>";
					str+="<td>"+ this.STU_AUTHORITY_VALUE + "</td>";
					str+="<td><button type='button' class='btn btn-small btn-info'>수정</button>"
					str+="<button type='button' class='btn btn-small btn-danger'>보기</button></td>" 
					str+="</tr>"
			});
			$("#showStuList").append(str);
		},
		error: function(result){}
	}).submit();
}

function ajaxStuSearchScope(formId) {
		
		
		$('#'+formId).ajaxForm({
			
			type: "post",
			url: "/searchScopeStudent.do",
			datatype: "json",
			success: function(result){
				
				$("#showStuList").empty();
				var str = "";
				
				$.each(result,function(index,value){
						str+="<tr>"
						str+="<td>" + index + "</td>";
						str+="<td>" + this.STU_NUMBER + "</td>";
					 	str+="<td>"+ this.STU_NAME + "</td>";
						str+="<td>"+ this.STU_GENDER_VALUE + "</td>";
						str+="<td>"+ this.STU_BIRTHDAY + "</td>";
						str+="<td>"+ this.STU_PHONE + "</td>";
						str+="<td>"+ this.STU_EMAIL + "</td>";
						str+="<td>"+ this.STU_ENTERANCE_VALUE + "</td>";
						str+="<td>"+ this.STU_AUTHORITY_VALUE + "</td>";
						str+="<td><button type='button' class='btn btn-small btn-info'>수정</button>"
						str+="<button type='button' class='btn btn-small btn-danger'>보기</button></td>" 
						str+="</tr>"
				});
				$("#showStuList").append(str);
			},
			error: function(result){}
		}).submit();
	}

//--------------------------------Student Fee--------------------------------

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