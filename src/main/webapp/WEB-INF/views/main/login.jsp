<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


<!DOCTYPE html>
<html>
<head>
  <title>W3.CSS Template</title>
   <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

   <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
   
    <style type="text/css">
      /*div {border: 1px solid black;}*/
      
      .full {height: 100%;}
      .eight{height: 80%;}
      .five{height: 50%;}
      .three{height: 30%;}
      #nameSection{
        text-align: right;
      }
      #login{
        text-align:center;
      }
      
      html, body {
        height: 100%;
        margin: 0;
      }
    </style>
  </head>
  
  
  <body>
  <!------------------------->
    <div id="main" class="container-fluid full">
      
      <div class="row align-items-center full">
        <div class="col">
          
        </div>
        <div class="col-8 eight">
          <div class="row five">
            <!--이미지 들어가는 곳-->
            
          </div>
          <div class="row five">
            
            <div class="col">
            </div>
            <div class="col-6">
              <div class="row three">
              </div>
              <form>
              <div class="row three">
                <!--아이디 비밀번호 칸.-->
                  <div id="nameSection" class="col-4">
                    <p> 아 이 디 : </p> 
                    <p> 비밀번호 : </p>
                  </div>
                  
                  
                  <div id="inputSection" class="col-8">
                  
                    <p><input type="text" name=""/></p>
                  
                    <p><input type="password" name=""/></p>
                  
                  </div>
              </div>
              
              <div class="row three">
                <!--로그인 버튼칸. 나중에 회원가입이나 다른거 넣고싶으면 col태그 하나 지울것.-->
                  <div class="col">
                      
                  </div>
                  <div id="login" class="col">
                      <p>
                        <input type="button" value="login"/>
                      </p>
                      
                      <a href = "/adminMain" >관리자페이지로 이동</a>
                      
                   
                  </div>
                  <div class="col">
              <a href = "./main/studentMain.jsp" >유저메인페이지로 이동</a>
                  </div>
              </div>
              
              </form>
                
              
        
            </div>
            <div class="col">
            </div>
            
          </div>
          
        </div>
        <div class="col">
          
        </div>
        
        
        
      </div>
    
    </div>
    
  </body>
</html>