<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    <!DOCTYPE html>
<html>
  <title>W3.CSS Template</title>
   <!-- Required meta tags -->
    <meta charset="utf-8">

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <style type="text/css">
      /*div {border: 1px solid black;}
      */html, body {
        height: 100%;
        margin: 0;
      }
      
      #info-img{
        background-image: url("w3images/coffee.jpg");
        border-radius: 25px; 
        background-repeat: no-repeat;
        background-size: auto;
      }
      
      #nametag{
        text-align:right;
      }
      #infotag{
        text-align:left;
      }
      
      
      .full {height: 100%;}
      .eight{height: 80%;}
      .five{height: 50%;}
      .seven{height: 70%;}
      .three{height: 30%;}
      
      
    </style>
  
  <body>
  <!------------------------->
    <div id="main" class="container-fluid full">
      
      
      <div class="row align-items-center seven">

        <div class="col-3 seven">

          <div class="row align-items-center full">
            <div class="col-1 five">
            </div>
            <div class="col-10 seven">
              <div class="row full">
                <div id="nametag" class="col-4 full">
                  <!-- TODO: DB를 통한 반복문 처리-->
                  <p>이름 : </p>
                  <p>학번 : </p>
                  <p>권한 : </p>
                  <p>소속 : </p>
                  <!-- TODO: DB를 통한 반복문 처리-->

                </div>
                <div id="infotag" class="col-8 full">
                  <!-- TODO: DB를 통한 반복문 처리-->
                  <p>이 정 훈</p>                  
                  <p>2010042465</p>
                  <p>회    장</p>
                  <p>영 문 과</p>                  
                
                
                
                </div>
              </div>
              
              
            </div>
            <div class="col-1 five">
            </div>
            


          
          </div>

        </div>


        <div id="info-img" class="col seven">
        </div>
        <div class="col-3 five">
            
        </div>
      </div>
      
      <div class="row align-items-center three">
        <div class="col full">
            
        </div>
        <div class="col full">
            
        </div>
        <div class="col full">
            
        </div>
        <div class="col full">
            
        </div>
      
      </div>
    
    </div>
    
    
     <!-- Optional JavaScript -->
    <!-- jQuery first, then Popper.js, then Bootstrap JS -->
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
 
  </body>
</html>