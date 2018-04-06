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
				<c:forEach var="i" items="${list}">

				</c:forEach>
				<tbody>


				</tbody>

			</table>
		</div>
	</div>

</div>

