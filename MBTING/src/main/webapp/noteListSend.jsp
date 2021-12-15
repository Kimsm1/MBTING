<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<title>다양한 사람들의 만남 MBTING  </title>
        <!-- Favicon-->
        <link rel="icon" type="image/x-icon" href="<%=request.getContextPath()%>/resources/assets/img/main/favicon1.png" />
<link href="resources/css/styles.css" rel="stylesheet" />
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Nanum+Pen+Script&display=swap" rel="stylesheet">
<meta charset="UTF-8">
<style>
 .hn{font-family: 'Hanna', sans-serif;}
        .jg{font-family: 'Jeju Gothic', sans-serif;}
        .478{
        
        font-family: 'Nanum Pen Script', cursive;
        }
.btn5 {
   display: inline-block;
  font-weight: 400;
  line-height: 1.5;
  color: white;
  text-align: center;
  text-decoration: none;
  vertical-align: middle;
 
  cursor: pointer;
  -webkit-user-select: none;
     -moz-user-select: none;
      -ms-user-select: none;
          user-select: none;
  background-color: #1266e1;
  border: 1px solid transparent;
  padding: 0.375rem 0.75rem;
  font-size: 1rem;
  border-radius: 0.25rem;
  transition: color 0.15s ease-in-out, background-color 0.15s ease-in-out, border-color 0.15s ease-in-out, box-shadow 0.15s ease-in-out;
}
.btn5 {
  display: inline-block;
  font-weight: 400;
  line-height: 1.5;
  color: white;
  text-align: center;
  text-decoration: none;
  vertical-align: middle;
 
  cursor: pointer;
  -webkit-user-select: none;
     -moz-user-select: none;
      -ms-user-select: none;
          user-select: none;
  background-color: black;
  border: 1px solid transparent;
  padding: 0.375rem 0.75rem;
  font-size: 1rem;
  border-radius: 0.25rem;
  transition: color 0.15s ease-in-out, background-color 0.15s ease-in-out, border-color 0.15s ease-in-out, box-shadow 0.15s ease-in-out;
}
#swant{
	object-fit:cover;
	width:50px;
	height:50px;

}

#nav1{
	height:50px;
	background-color:black;

}
#nav2{
	height:50px;
	position: fixed;
	 bottom: 0;
	  width: 100%;


	background-color:#13aeff;

}
#table1{
	 margin-left:auto; 
    margin-right:auto;
    border-bottom : 1px solid #ccc;
    border-top: 		1px solid #ccc;

}

table {
    margin-left:auto; 
    margin-right:auto;
	
}



.sidenav {
  height: 100%;
  width: 0;
  position: fixed;
  z-index: 1;
  top: 50px;
  left: 0;
  background-color: gray;
  overflow-x: hidden;
  transition: 0.5s;
  padding-top: 60px;
}

.sidenav a {
  padding: 8px 8px 8px 32px;
  text-decoration: none;
  font-size: 20px;
  color: black;
  display: block;
  transition: 0.3s;
}

.sidenav a:hover {
  color: #f1f1f1;
}

.sidenav .closebtn {
  position: absolute;
  top: 0;
  right: 25px;
  font-size: 36px;
  margin-left: 50px;
}


        </style>
        <script>
function openNav() {
  document.getElementById("mySidenav").style.width = "240px";
}

function closeNav() {
  document.getElementById("mySidenav").style.width = "0";
}
</script>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script type="text/javascript">
$.check = function(no){
	var no = no;
	//alert(no);

	$.ajax({
		url : "<%=request.getContextPath()%>/"+no+"/noteDelete.do",
		type : "get",
		dataType: "text",		
		success : function(data){
			if (data.length == 0){
				swal("데이터가 없습니다"," ","warning");
			}else
				swal("삭제되었습니다"," ","success");
				setTimeout('location.reload()',800);
		},
		   error: function( request, status, error ){
			    swal("에러입니다"," ","warning");
			    alert("status : " + request.status + ", message : " + request.responseText + ", error : " + error);
			   }		
	});
}        
</script>
<title>보낸 쪽지함</title>
</head>
<body>
<nav id="nav1">
  <a style=color:white;  >
   <h2>	보낸쪽지함</h2>
  </a>
</nav>
<div id="mySidenav" class="sidenav">
  <a href="javascript:void(0)" class="closebtn" onClick="closeNav()">&times;</a>

  <a href="<%=request.getContextPath()%>/noteSendWant.do">쪽지 쓰기</a>
  <a href="${pageContext.request.contextPath}/noteListRecv.do">받은쪽지함</a>
  
</div>
<span style="font-size:30px;cursor:pointer; color:#3388dd; "  onclick="openNav()"><img src="<%=request.getContextPath()%>/resources/assets/img/001.png" alt="..." id = "swant" name="hit" /></span>

    </div>





<table id="table1" style="width:1200px; height:50px " >
<tr style=background-color:#f9f9f9;>
	 <td style="width:100px;  color:black;  "><h5>쪽지번호 </h5></td>
	 <td style="width:100px; color:black; "><h5>받은사람  </h5></td> 
	 <td style="width:726px; color:black; "><h5>내용 </h5></td>
	 <td style="width:274px; ; "><h5>보낸 날짜</h5></td>
	 <tr>

</table>




	<table class="type09"style="width:1200px;   ">
    <c:forEach var = "nv" items="${alist}">
	 <tr>
	 <td style="width:100px;  padding-left: 15px; " class="478">${nv.no }</td>
	 <td style="width:100px; ">${nv.recv_nick }</td>
	 <td style="width:780px; ">${nv.content }</td>
	 <td style="width:210px; "><li class="date_cnt">${nv.send_time }</li></td>
	 <td colspan=2 style="width:63.5px;  "><input type="button" class="btn5" name="del" id="del+${nv.no}" onClick="$.check(${nv.no});" value="삭제"> </td>

	 </tr>
    
    </c:forEach>
    
    </table>
    
    <table  style="width:1400px;Text-align:center">
<tr>
<td>

<c:if test="${pm.prev == true }">
<a href="${pageContext.request.contextPath}/noteListSend.do?page=${pm.startPage-1}&keyword=${pm.scri.keyword}">이전</a>
</c:if>
</td>
<td>

<c:forEach var="i" begin="${pm.startPage}" end="${pm.endPage}" step="1">
<a href="${pageContext.request.contextPath}/noteListSend.do?page=${i}&keyword=${pm.scri.keyword}">${i}</a>
</c:forEach>
</td>
<td>

<c:if test="${pm.next && pm.endPage >0}">
<a href="${pageContext.request.contextPath}/noteListSend.do?page=${pm.endPage+1}&keyword=${pm.scri.keyword}">다음</a>
</c:if>
</td>
</tr>
</table>
    
    

    
  
    
    
    
    
    
    
    
    
    
    
    
</body>
</html>