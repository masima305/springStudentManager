<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>







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
      <form id="memberSearchForm">
         <select>
            <option value="선택없음">선택없음</option>
            <option value="stuName">이름</option>
            <option value="stuNumber">학번</option>
            <option value="stuPhone">연락처</option>
            <option value="stuEmail">이메일</option>
         </select>
         <input type="text" name="input"/>
         
         <label>학번별로</label>
         <select id="searchStuNumber" onclick="javascript:stuNumberOption()">
            <option value="선택없음">선택없음</option>
         </select>
         
         <label>입학전형별로</label>
         <select>
            <option value="선택없음">선택없음</option>
            <option value="">수시</option>
            <option value="">정시</option>
            <option value="">추합</option>
            <option value="">특별</option>
         </select>
         
         
         <label>구분별로</label>
         <select>
            <option value="선택없음">선택없음</option>
            <option value="6">일반</option>
            <option value="5">학회장/예비역회장</option>
            <option value="4">집행부</option>
            <option value="3">집행부팀장</option>
         </select>
         
         <label>성별로</label>
         <select>
            <option value="선택없음">선택없음</option>
            <option value="F">여</option>
            <option value="M">남</option>
         </select>
         
         <input type="button" value="검색" onclick=""/>
      </form>
      
   </div>


   <div class="card-body">
      <div id="memberList"  class="table-responsive">
         <table class="table table-striped">
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
                  <th>구분</th>
                  <th>옵션</th>
               <tr>
            </thead>
            
            <tbody>
            </tbody>
            
         </table>
      </div>
   </div>

</div>

