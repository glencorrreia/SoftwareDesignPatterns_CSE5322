<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix = "c" %>
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
#tabid {
  font-family: Arial, Helvetica, sans-serif;
  border-collapse: collapse;
  width: 100%;
}

#tabid td, #tabid th {
  border: 1px solid #ddd;
  padding: 8px;
}

#tabid tr:nth-child(even){background-color: #f2f2f2;}

#tabid tr:hover {background-color: #ddd;}

#tabid th {
  padding-top: 12px;
  padding-bottom: 12px;
  text-align: left;
  background-color: #04AA6D;
  color: white;
}
div {
	border-radius: 5px;
	background-color: #f2f2f2;
	padding: 20px;
	align-self: center;
}
</style>

<body>
<div><h1>Welcome Participant, </h1><br>
<h3>Bellow is list of events</h3></div>
<!-- The Modal ref https://www.w3schools.com/howto/tryit.asp?filename=tryhow_css_modal -->
	<div id="sucModel" class="modal">

		<!-- Modal content -->
		<div class="modal-content">
			<span class="close" onclick="closeSucModel();">&times;</span>
			<p>Registered for an Event Successfully. You will receive Email for Payment. 
			If you want to pay right now , you will be moved to the payment screen, </p>
		</div>

	</div>
<input type="hidden" id="hid" name="hid">
<div id="errormsg"></div>
<table id="tabid">
  <tr>
    <th>Name</th>
    <th>Detail</th>
    <th>Date of event</th>
    <th>Duration</th>    
    <th>Location</th>
    <th>Slogan</th> 
    <th>Review Link</th> 
  </tr>
        <c:forEach items = "${eventlist}" var="event">
         
	         <tr>
			    <td><c:out value = "${event.name}"/></td>
			    <td><c:out value = "${event.detail}"/></td>
			    <td><c:out value = "${event.date}"/></td>
			    <td><c:out value = "${event.duration}"/></td>
			    <td><c:out value = "${event.location}"/></td>
			    <td><c:out value = "${event.slogan}"/></td>
			    <td>   <input type="button" value="Register Event" onclick="register(${event.id})"> 
			          
			    </td>
			  </tr>
      </c:forEach>
  
</table>
<script>

function register(eventId){

	
		var user=JSON.parse(sessionStorage.user);
		var event={
			'userId':user['id'],
			'eventId':eventId
			}
		document.getElementById("hid").value=eventId;
		fetch ('http://localhost:8080/Project-0.0.1-SNAPSHOT/registerParticipant', {
			body:JSON.stringify(event),
		    method: 'POST',
		    headers: {
		      'Content-Type': 'application/json'
		    }
		  }).then(x => x.json()).then(y =>{

			  if(y['status']==0){ 
				document.getElementById("errormsg").innerHTML =y['response'];

			  }else{									 
						
				  	var modal= document.getElementById("sucModel");
					modal.style.display = "block";
				  }
			 });
	
}
function closeSucModel(){

	  var modal= document.getElementById("sucModel");
	  modal.style.display = "block";
	  var eid=document.getElementById("hid").value
	  location.replace("http://localhost:8080/Project-0.0.1-SNAPSHOT/payment?eventId="+eid+"&page=participant")
	  
}
</script>
</body>
</html>