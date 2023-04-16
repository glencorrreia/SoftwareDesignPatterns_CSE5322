<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<style>

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

div {
	border-radius: 5px;
	background-color: #f2f2f2;
	padding: 20px;
	align-self: center;
}

textarea, select {
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


</style>
<body>
	<!-- The Modal ref https://www.w3schools.com/howto/tryit.asp?filename=tryhow_css_modal -->
	<div id="sucModel" class="modal">

		<!-- Modal content -->
		<div class="modal-content">
			<span class="close" onclick="closeSucModel();">&times;</span>
			<p>Your review has been submitted. Event Organizer will get an email regarding a status change. </p>
		</div>

	</div>
<div>
<h3>Welcome NTSS Staff, <br> Event Details</h3>
<p> Event Name: ${event.name}</p>
<p> Event Description: ${event.detail}</p>
<p> Date of Event: ${event.date}</p>
<p> Duration of Event: ${event.duration}</p>
<p> Location of Event: ${event.location}</p>
<p> Slogan of Event: ${event.slogan}</p>
</div>

	<div id="errormsg"></div>
	<div style="align-content: center;">
		<form>

			<label>Feedback:</label> 
			<textarea name="feedback" id="feedback" rows="5" cols="25"></textarea><br><br>
		
			<label>Accept/Reject:</label> 
			<select id="status" required="required">
				<option value="Accept">Accept</option>
				<option value="Reject">Reject</option>
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
	
	var feedback=document.getElementById("feedback").value;
	var status=document.getElementById("status").value;
	const queryString = window.location.search;
	const urlParams = new URLSearchParams(queryString);

	var eventId=urlParams.get("eventId");
	var user=JSON.parse(sessionStorage.user);
	if(feedback==null){
	alert("Feedback is requiered");
	}else if(status==null){
		alert("Status is requiered");
		}else{

			console.log("test");
			var event={
					'id':eventId,
					'reviewedBy':user['id'],
					'feedback':feedback,
					'status':status
					}
			fetch ('http://localhost:8080/Project-0.0.1-SNAPSHOT/submitEventReview', {
				body:JSON.stringify(event),
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

	var user=JSON.parse(sessionStorage.user);
	  var modal= document.getElementById("sucModel");
	  modal.style.display = "block";
	  location.replace("http://localhost:8080/Project-0.0.1-SNAPSHOT/staffhome?userId="+user['id']);
	  
}
</script>

</body>
</html>