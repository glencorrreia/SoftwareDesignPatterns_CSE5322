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
<div><h1>Welcome NTSS Staff, vents List</h1></div>
<a href="http://localhost:8080/Project-0.0.1-SNAPSHOT/eventProposal">New Event Proposal</a>
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
			    <td>   <a href="http://localhost:8080/Project-0.0.1-SNAPSHOT/reviewEvent?eventId=${event.id}" >Review Event</a>
			          
			    </td>
			  </tr>
      </c:forEach>
  
</table>
</body>
</html>