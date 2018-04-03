<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>



<div class="card">

 <div class="card-header">학생 등록</div>

<div class="card-body">

<div class="container">
<form id="memberInsertForm">

<div class="row">
<div class="col-sm-3 col-md-6 col-lg-4"><lable>이름</lable></div>
<div class="col-sm-9 col-md-6 col-lg-8"><input type="text" name="stuName"/></div>
</div>

<div class="row">
<div class="col-sm-3 col-md-6 col-lg-4"><lable>학번</lable></div>
<div class="col-sm-9 col-md-6 col-lg-8"><input type="text" name="stuNumber"/></div>
</div>

<div class="row">
<div class="col-sm-3 col-md-6 col-lg-4"><lable>생년월일</lable></div>
<div class="col-sm-9 col-md-6 col-lg-8"><input type="date" name="stuBirthday"/></div>
</div>

<div class="row">
<div class="col-sm-3 col-md-6 col-lg-4"><lable>성별</lable></div>
<div class="col-sm-9 col-md-6 col-lg-8">
<input type="radio" name="stuGender" value="F"/>여
<input type="radio" name="stuGender" value="M"/>남
</div>
</div>

<div class="row">
<div class="col-sm-3 col-md-6 col-lg-4"><lable>연락처</lable></div>
<div class="col-sm-9 col-md-6 col-lg-8"><input type="text" name="stuPhone"/></div>
</div>

<div class="row">
<div class="col-sm-3 col-md-6 col-lg-4"><lable>이메일</lable></div>
<div class="col-sm-9 col-md-6 col-lg-8"><input type="text" name="stuEmail"/></div>
</div>


<div class="row">
<div class="col-sm-3 col-md-6 col-lg-4"><lable>입학전형</lable></div>
<div class="col-sm-9 col-md-6 col-lg-8">
<input type="radio" name="stuEntrance" value="수시"/>수시
<input type="radio" name="stuEntrance" value="정시"/>정시
<input type="radio" name="stuEntrance" value="추합"/>추합
<input type="radio" name="stuEntrance" value="특별"/>특별
</div>
</div>

<div class="row">
<div class="col-sm-3 col-md-6 col-lg-4"><lable>접근권한</lable></div>
<div class="col-sm-9 col-md-6 col-lg-8">
<select>
<option name="stuAuthority" value="1">회장</option>
<option name="stuAuthority" value="2">부회장</option>
<option name="stuAuthority" value="3">학생회 팀장</option>
<option name="stuAuthority" value="4">학생회</option>
<option name="stuAuthority" value="5">학회/예비역 회장</option>
<option name="stuAuthority" value="6">일반</option>
</select>
</div>
</div>

<br>

<div class="row">

<div class="col-sm-12 col-md-12 col-lg-12">
<input type="reset" value="다시작성"/>
<input type="button" value="저장" onclick=""/>
</div>
</div>

</form>
</div>

</div>
</div>

