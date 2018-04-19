
//----------------------------학생 년도 출력-------------------------------------
function stuNumberOption(id){
	var selectValue = document.getElementById(id);

	var date = new Date();
    var year = date.getFullYear();
    var yearstr = "";
    
    yearstr += ("<option value='null'>선택없음</option>");
    for(var i=year-40; i<=year; i++){
    
    	yearstr += ("<option value='"+i+"'>"+i+"</option>");
    }
    $("#"+id).html(yearstr);
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
					str+="<td><button type='button' class='btn btn-small btn-info' onclick='javascript:ajaxStuDetail("+this.STU_NUMBER+")'>보기</button></td>" 
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
						str+="<td><button type='button' class='btn btn-small btn-info' onclick='javascript:ajaxStuDetail("+this.STU_NUMBER+")'>보기</button></td>" 
						
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
					str+="<td id='"+this.STU_NUMBER+"paidDate' >"+ this.FEE_PAID_DATE + "</td>";
					str+="<td id='"+this.STU_NUMBER+"totalAmount' >"+ this.FEE_TOTAL_AMOUNT + "</td>";
					str+="<td id='"+this.STU_NUMBER+"paidAmount' >"+ this.FEE_PAID_AMOUNT + "</td>";
					str+="<td id='"+this.STU_NUMBER+"paidMethod' >"+ this.FEE_PAID_METHOD_VALUE + "</td>";
					str+="<input type='hidden' id='"+this.STU_NUMBER+"paidMethodValue' value='"+this.FEE_PAID_METHOD+"'/>";
						
					str+="<td id='"+this.STU_NUMBER+"paidStatus'>"+ this.FEE_PAID_STATUS_VALUE + "</td>";
					str+="<input type='hidden' id='"+this.STU_NUMBER+"paidStatusValue' value='"+this.FEE_PAID_STATUS+"'/>";
				
					str+="<td id='"+this.STU_NUMBER+"paidContent'>"+ this.FEE_CONTENT_VALUE + "</td>";
					str+="<td id='"+this.STU_NUMBER+"btn'><button type='button' class='btn btn-small btn-info' onclick='javascript:FeeUpdateBtn("+this.STU_NUMBER+")' >수정</button>"
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
					str+="<tr>"
						str+="<td>" + index + "</td>";
						str+="<td>" + this.STU_NUMBER + "</td>"; 
					 	str+="<td>"+ this.STU_NAME + "</td>";	
						str+="<td id='"+this.STU_NUMBER+"paidDate' >"+ this.FEE_PAID_DATE + "</td>";
						str+="<td id='"+this.STU_NUMBER+"totalAmount' >"+ this.FEE_TOTAL_AMOUNT + "</td>";
						str+="<td id='"+this.STU_NUMBER+"paidAmount' >"+ this.FEE_PAID_AMOUNT + "</td>";
						str+="<td id='"+this.STU_NUMBER+"paidMethod' >"+ this.FEE_PAID_METHOD_VALUE + "</td>";
						str+="<input type='hidden' id='"+this.STU_NUMBER+"paidMethodValue' value='"+this.FEE_PAID_METHOD+"'/>";
							
						str+="<td id='"+this.STU_NUMBER+"paidStatus'>"+ this.FEE_PAID_STATUS_VALUE + "</td>";
						str+="<input type='hidden' id='"+this.STU_NUMBER+"paidStatusValue' value='"+this.FEE_PAID_STATUS+"'/>";
					
						str+="<td id='"+this.STU_NUMBER+"paidContent'>"+ this.FEE_CONTENT_VALUE + "</td>";
						str+="<td id='"+this.STU_NUMBER+"btn'><button type='button' class='btn btn-small btn-info' onclick='javascript:FeeUpdateBtn("+this.STU_NUMBER+")' >수정</button>"
						str+="</tr>"	
			});
			$("#showFeeList").append(str);
		},
		error: function(result){}
	}).submit();
}