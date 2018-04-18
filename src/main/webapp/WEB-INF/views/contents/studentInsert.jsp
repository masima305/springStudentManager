<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>



<div class="card">

<div class="card-header">학생 등록</div>l
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
<select>
<option name="stuGender" value="1">여</option>
<option name="stuGender" value="2">남</option>
</select>
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
<select>
<option name="stuEntrance" value="1">수시</option>
<option name="stuEntrance" value="2">정시</option>
<option name="stuEntrance" value="3">추합</option>
<option name="stuEntrance" value="4">특별</option>
</select>
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
<option name="stuAuthority" value="5">학회장</option>
<option name="stuAuthority" value="6">예비역 회장</option>
<option name="stuAuthority" value="7">일반</option>
</select>
</div>
</div>

<br><hr>

<div class="row">
<div class="col-sm-3 col-md-6 col-lg-4"><lable>회비금액*</lable></div>
<div class="col-sm-9 col-md-6 col-lg-8"><input type="text" name="feeTotalAmount"/></div>
</div>

<div class="row">
<div class="col-sm-3 col-md-6 col-lg-4"><lable>납부금액</lable></div>
<div class="col-sm-9 col-md-6 col-lg-8"><input type="text" name="feePaidAmount"/></div>
</div>

<div class="row">
<div class="col-sm-3 col-md-6 col-lg-4"><lable>입금방식</lable></div>
<div class="col-sm-9 col-md-6 col-lg-8">
<select>
<option name="feePaidMethod" value="1">계좌이체</option>
<option name="feePaidMethod" value="2">현금</option>
</select>
</div>
</div>

<div class="row">
<div class="col-sm-3 col-md-6 col-lg-4"><lable>상태</lable></div>
<div class="col-sm-9 col-md-6 col-lg-8">
<select>
<option name="feePaidStatus" value="1">분할납부</option>
<option name="feePaidStatus" value="2">입금완료</option>
<option name="feePaidStatus" value="3">미납</option>
</select>
</div>
</div>

<div class="row">
<div class="col-sm-3 col-md-6 col-lg-4"><lable>비고</lable></div>
<div class="col-sm-9 col-md-6 col-lg-8"><input type="text" name="feeContent"/></div>
</div>

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

