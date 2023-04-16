<%@ page contentType="text/html; charset = UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>
<title>Spring MVC</title>

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

input[type=text], input[type=email], select {
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

<br>
<body>
<h1 style="text-align: center;">Registration</h1>
<h5>Already have an account? <a href="http://localhost:8080/Project-0.0.1-SNAPSHOT/login.jsp">Login</a></h5>
	<br>
	<!-- The Modal ref https://www.w3schools.com/howto/tryit.asp?filename=tryhow_css_modal -->
	<div id="errorModel" class="modal">

		<!-- Modal content -->
		<div class="modal-content">
			<span class="close">&times;</span>
			<p>Some text in the Modal..</p>
		</div>

	</div>
	<!-- The Modal ref https://www.w3schools.com/howto/tryit.asp?filename=tryhow_css_modal -->
	<div id="sucModel" class="modal">

		<!-- Modal content -->
		<div class="modal-content">
			<span class="close" onclick="closeSucModel();">&times;</span>
			<p>Registration successful. You will get an email with temporary password. Using that password you can log-in into your account.</p>
		</div>

	</div>
	
	<div id="errormsg"></div>
	<div style="align-content: center;">
		<form>

			<label>Username:</label> <input type="text" name="uname" id="uname"
				required="required"> <br> <label>First Name:</label> <input
				type="text" name="fname" id="fname" required="required"><br>
			<label>Last Name:</label> <input type="text" name="lname" id="lname"
				required="required"><br> <label>Email:</label> <input
				type="email" name="email" id="email" required="required"><br>
			<label>User Type:</label> <select id="usertype" required="required">
				<option value="Event Organizer">Event Organizer</option>
				<option value="Exhibitor">Exhibitor</option>
				<option value="Speaker">Speaker</option>
				<option value="Observer or Participant">Observer or Participant</option>
				<option value="NTSS Staff">NTSS Staff</option>

			</select>

			<button type="submit" id="submit" value="Submit"
				onclick="validate();">submit</button>

		</form>
	</div>
	<script type="text/javascript">
    document.getElementById("submit").addEventListener("click", function(event){
    	  event.preventDefault()
    	});
    	    
function validate(){

	alert("inside");
	
	var uname=document.getElementById("uname").value;
	var fname=document.getElementById("fname").value;
	var lname=document.getElementById("lname").value;
	var email=document.getElementById("email").value;
	var usertype=document.getElementById("usertype").value;
	var pattern = /^\w+@[a-zA-Z_]+?\.[a-zA-Z]{2,3}$/; 
	
	if(uname==null){
	alert("username is requiered");
	}else if(fname==null){
		alert("firstname is requiered");
		}else if(lname==null){
		alert("lastname is requiered");
		}else if(email==null){
		alert("email is requiered");
		}else if(!pattern.test(email)){
		alert("Invalid email address");
		}else if(usertype== null){
		alert("User type is requiered")
		}else{

			console.log("test");
			var user={
					'firstName':fname,
					'lastName':lname,
					'userName':uname,
					'email':email,
					'userType':usertype
					}
			fetch ('http://localhost:8080/Project-0.0.1-SNAPSHOT/adduser', {
				body:JSON.stringify(user),
			    method: 'POST',
			    headers: {
			      'Content-Type': 'application/json'
			    }
			  }).then(x => x.json()).then(y => {

				  if(y['status']==0){ 
					document.getElementById("errormsg").innerHTML =y['response'];
					
				  }else{
					  var modal= document.getElementById("sucModel");
					  modal.style.display = "block";
						
					  }
				 });
			}
	

	  
}
function closeSucModel(){

	  var modal= document.getElementById("sucModel");
	  modal.style.display = "block";
	  location.replace("http://localhost:8080/Project-0.0.1-SNAPSHOT/login.jsp")
	  
}
</script>

</body>
</html>