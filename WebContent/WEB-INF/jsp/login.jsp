<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<!-- ref w3schools.com/css/tryit.asp?filename=trycss_forms  -->
<style>
body {
	font-family: Arial, Helvetica, sans-serif;
}

/* The Modal (background) */
.modal {
	display: none; /* Hidden by default */
	position: fixed; /* Stay in place */
	z-index: 1; /* Sit on top */
	padding-top: 100px; /* Location of the box */
	left: 0;
	top: 0;
	width: 100%; /* Full width */
	height: 100%; /* Full height */
	overflow: auto; /* Enable scroll if needed */
	background-color: rgb(0, 0, 0); /* Fallback color */
	background-color: rgba(0, 0, 0, 0.4); /* Black w/ opacity */
}

/* Modal Content */
.modal-content {
	background-color: #fefefe;
	margin: auto;
	padding: 20px;
	border: 1px solid #888;
	width: 80%;
}

/* The Close Button */
.close {
	color: #aaaaaa;
	float: right;
	font-size: 28px;
	font-weight: bold;
}

.close:hover, .close:focus {
	color: #000;
	text-decoration: none;
	cursor: pointer;
}

input[type=text], input[type=password]{
	width: 100%;
	padding: 12px 20px;
	margin: 8px 0;
	display: inline-block;
	border: 1px solid #ccc;
	border-radius: 4px;
	box-sizing: border-box;
}

button[type=submit] {
	width: 100%;
	background-color: #4CAF50;
	color: white;
	padding: 14px 20px;
	margin: 8px 0;
	border: none;
	border-radius: 4px;
	cursor: pointer;
}

button[type=submit]:hover {
	background-color: #45a049;
}

div {
	border-radius: 5px;
	background-color: #f2f2f2;
	padding: 20px;
	align-self: center;
}
</style>

<body>
	<div><h1 style="text-align: center;">Login</h1></div>
	<h5>
		Do not have an account? <a
			href="http://localhost:8080/Project-0.0.1-SNAPSHOT/registration.jsp">Registration</a>
	</h5>
	<br>

	<div id="errormsg"></div>
	<div style="align-content: center;">
		<form>

			<label>Username:</label> <input type="text" name="uname" id="uname"
				required="required"> <br> <label>Password:</label> <input
				type="password" name="password" id="password" required="required"><br>
			<button type="submit" id="submit" value="Submit"
				onclick="validate();">submit</button>

		</form>
	</div>

	<script type="text/javascript">
	   document.getElementById("submit").addEventListener("click", function(event){
	    	  event.preventDefault()
	    	});
	   sessionStorage.removeItem('user');
function validate(){
	alert("inside javascript");
	var uname=document.getElementById("uname").value;
	var password=document.getElementById("password").value;
	if(uname==null){
		alert("Username is requiered");
		}else if(password==null){
			alert("Username is requiered");
			}else{
				fetch ('http://localhost:8080/Project-0.0.1-SNAPSHOT/checkuser?uname='+uname+'&password='+password, {
				    method: 'POST',
				    headers: {
				      'Content-Type': 'application/json'
				    }
				  }).then(x => x.json()).then(y =>{

					  if(y['status']==0){ 
						document.getElementById("errormsg").innerHTML =y['response'];

					  }else{
						  	sessionStorage.setItem('user', JSON.stringify(y['data']));
						    console.log(y['data']['id']);
						    if(y['data']['firstlogin']){
							    
						    	location.replace("http://localhost:8080/Project-0.0.1-SNAPSHOT/changepwd")
							 }else{ 
								 if(y['data']['userType']=="Event Organizer"){
									 location.replace("http://localhost:8080/Project-0.0.1-SNAPSHOT/eventorganizer?userId="+y['data']['id']);
									 }else if(y['data']['userType']=="NTSS Staff"){
										 location.replace("http://localhost:8080/Project-0.0.1-SNAPSHOT/staffhome?userId="+y['data']['id']);
								 }else if(y['data']['userType']=="Observer or Participant"){
									 location.replace("http://localhost:8080/Project-0.0.1-SNAPSHOT/participanthome?userId="+y['data']['id']);
									 }
						  	
							 }
						  }
					 });
				  

				 }
	
	
}
</script>
</body>
</html>
