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

input[type=text], input[type=date],input[type=number],textarea {
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
<h1 style="text-align: center;">Submit New Event Proposal</h1>
<h5> <a href="http://localhost:8080/Project-0.0.1-SNAPSHOT/eventorganizer">Home</a></h5>
	<br>
	<!-- The Modal ref https://www.w3schools.com/howto/tryit.asp?filename=tryhow_css_modal -->
	<div id="sucModel" class="modal">

		<!-- Modal content -->
		<div class="modal-content">
			<span class="close" onclick="closeSucModel();">&times;</span>
			<p>Event Submitted Successfully. You will receive Email for Payment. 
			If you want to pay right now , you will be moved to the payment screen, </p>
		</div>

	</div>
	
<div id="errormsg"></div>
	<div style="align-content: center;">
		<form>
			<input type="hidden" id="hid" name="hid">
			<label>Event Name:</label> 
			<input type="text" name="ename" id="ename" required="required"> <br> 
			<label>Event Description:</label> 
			<textarea name="detail" id="detail" rows="5" cols="25"></textarea><br>
			<label>Duration:</label> (in hours)
			<input type="number" name="duration" id="duration" required="required"> <br>
			<label>Location:</label> 
			<input type="text" name="location" id="location" required="required"> <br>
			<label>Date of event:</label> 
			<input type="date" name="edate" id="edate" required="required"> <br>
			<label>Slogan:</label> 
			<input type="text" name="slogan" id="slogan" required="required"> <br>

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
	
	var ename=document.getElementById("ename").value;
	var detail=document.getElementById("detail").value;
	var duration=document.getElementById("duration").value;
	var location=document.getElementById("location").value;
	var edate=document.getElementById("edate").value;
	var slogan=document.getElementById("slogan").value;
	var user=JSON.parse(sessionStorage.user);
	
	if(ename==null){
	alert("Event name is requiered");
	}else if(detail==null){
		alert("Description is requiered");
		}else if(duration==null){
		alert("Duration is requiered");
		}else if(location==null){
		alert("Location is requiered");
		}else if(edate== null){
		alert("Event date is requiered")
		}else if(slogan== null){
		alert("Slogan is requiered")
		}else{

			console.log("test");
			var eventProposaldto={
					'name':ename,
					'detail':detail,
					'date':edate,
					'duration':duration,
					'location':location,
					'slogan':slogan,
					'userId':user['id']
					}
			fetch ('http://localhost:8080/Project-0.0.1-SNAPSHOT/submitEventProposal', {
				body:JSON.stringify(eventProposaldto),
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
						document.getElementById("hid").value=y['data']['id'];
					  }
				 });
			}
	

	  
}
function closeSucModel(){

	  var modal= document.getElementById("sucModel");
	  modal.style.display = "block";
	  var eid=document.getElementById("hid").value
	  location.replace("http://localhost:8080/Project-0.0.1-SNAPSHOT/payment?eventId="+eid+"&page=proposal")
	  
}
</script>

</body>
</html>