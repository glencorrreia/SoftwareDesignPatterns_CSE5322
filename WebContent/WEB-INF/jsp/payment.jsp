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

input[type=text], input[type=date],input[type=number] {
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
<h1 style="text-align: center;">Payment Gateway</h1>

	<br>
	<!-- The Modal ref https://www.w3schools.com/howto/tryit.asp?filename=tryhow_css_modal -->
	<div id="sucModel" class="modal">

		<!-- Modal content -->
		<div class="modal-content">
			<span class="close" onclick="closeSucModel();">&times;</span>
			<p>Payment Successful. You will receive mail regarding Payment. </p>
		</div>

	</div>
<div id="errormsg"></div>
	<div style="align-content: center;">
		<form>
			<input type="hidden" id="hid" name="hid">
			<label>Name on Card:</label> 
			<input type="text" name="cardname" id="cardname" required="required"> <br> 
			<label>Card Number:</label> 
			<input type="number" name="cardnum" id="cardnum" required="required"> <br> 
			<label>Expiry Date:</label> 
			<input type="date" name="edate" id="edate" required="required"> <br>
			<label>CVV:</label> 
			<input type="number" name="cvv" id="cvv" required="required"> <br>

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
	
	var cardnum=document.getElementById("cardnum").value;
	var cardname=document.getElementById("cardname").value;
	var edate=document.getElementById("edate").value;
	var cvv=document.getElementById("cvv").value;
	
	var user=JSON.parse(sessionStorage.user);
	const queryString = window.location.search;
	const urlParams = new URLSearchParams(queryString);

	var eventId=urlParams.get("eventId");
	var page=urlParams.get("page");
	if(cardnum==null){
	alert("Event name is requiered");
	}else if(edate==null){
		alert("Expiry date is requiered");
		}else if(cvv==null){
		alert("CVV is requiered");
		}else{

			console.log("test");
			var payment={
					'cardname':cardname,
					'cardnum':cardnum,
					'expirydate':edate,
					'cvv':cvv,
					'eventId':eventId,
					'userId':user['id'],
					'page':page
					}
			fetch ('http://localhost:8080/Project-0.0.1-SNAPSHOT/submitPayment', {
				body:JSON.stringify(payment),
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
	const queryString = window.location.search;
	const urlParams = new URLSearchParams(queryString);

	var page=urlParams.get("page");
	  var user=JSON.parse(sessionStorage.user);
	  var modal= document.getElementById("sucModel");
	  modal.style.display = "block";
	  if(page=="proposal"){
		  location.replace("http://localhost:8080/Project-0.0.1-SNAPSHOT/eventorganizer?userId="+user['id']);
	  }else{
		  location.replace("http://localhost:8080/Project-0.0.1-SNAPSHOT/participanthome?userId="+user['id']);
		}
	  
	  
}
</script>

</body>
</html>