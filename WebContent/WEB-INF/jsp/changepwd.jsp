<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
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
<div> <h3 id="greet"></h3></div>
<input id="uname" type="hidden" value=${username} >
<div> Change your password</div>
	<div id="errormsg"></div>
	<div style="align-content: center;">
		<form>

			<label>Password:</label> 
			<input type="password" name="pwd" id="pwd" required="required"><br> 
			<label>Re-Type Password:</label> <input
				type="password" name="retypepwd" id="retypepwd" required="required"><br>
			<button type="submit" id="submit" value="Submit"
				onclick="validate();">submit</button>

		</form>
	</div>
	<script type="text/javascript">
    document.getElementById("submit").addEventListener("click", function(event){
    	  event.preventDefault()
    	});
    var user=JSON.parse(sessionStorage.user);  
    document.getElementById("greet").innerHTML ="Hello "+user['firstName']+", ";
    console.log(user);  
function validate(){
	var user=JSON.parse(sessionStorage.user);
	alert("inside");
	var pattern =  /^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])[0-9a-zA-Z]{8,}$/

	 
	var pwd=document.getElementById("pwd").value;
	var uname=user['userName'];//document.getElementById("uname").value;
	var retypepwd=document.getElementById("retypepwd").value;
	if(pwd==null){
		alert("Password is requiered");
		}else if(retypepwd==null){
		alert("Retype Password is requiered");
		}else if(!pattern.test(pwd)){
		alert("Password Requiernment: Minimum eight characters, at least one letter and one number");
		}else if(pwd!=retypepwd){
		alert("password and retype password should match");
		}else{
			fetch ('http://localhost:8080/Project-0.0.1-SNAPSHOT/updatepwd?uname='+uname+'&password='+pwd, {
			    method: 'POST',
			    headers: {
			      'Content-Type': 'application/json'
			    }
			  }).then(x => x.json()).then(y =>{

				  if(y['status']==0){ 
					document.getElementById("errormsg").innerHTML =y['response'];

				  }else{
					    console.log(y['data']['id']);
					    if(y['data']['userType']=="Event Organizer"){
					    	location.replace("http://localhost:8080/Project-0.0.1-SNAPSHOT/eventorganizer?userId="+y['data']['id'])
						 }else{ 
						    	location.replace("http://localhost:8080/Project-0.0.1-SNAPSHOT/eventorganizer?userId="+y['data']['id'])									 
							 }
					  	
						
					  }
				 });
			
			}
}
	</script>
	
</body>
</html>