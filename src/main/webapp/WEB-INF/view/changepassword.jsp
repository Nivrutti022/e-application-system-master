<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<style >
body{
 background-image: url("resources/images/pass.jpg");}
</style>

<meta charset="ISO-8859-1">
<title>Change Password</title>
<%@ include file="./components/common_cs_js.jsp"%>
</head>
<body>
	<%@ include file="./components/navbar.jsp"%>
	<div class="container-fluid">
		<div class="row mt-2">
			<div class="col-md-4 offset-md-4 admin">
				<div class="card">
					<%@ include file="./components/message.jsp"%>
					<div class="card-body px-5">
						<img src="resources/images/registerphoto.jpeg"
							class="rounded mx-auto d-block" alt="img" height="90px"
							width="90px">
						<h3 class="text-center my-3">Student Change Password</h3>
						<form action="changepassword" method="post">
							<div class="form">

								<div class="form-group ">
									<label for="inputPassword4">Email</label> <input type="email"
										class="form-control" id="inputPassword4" name="email"
										value="<%if (userType != null && userType.equals("student")) {%><%=student.getEmailid()%><%}%>"
										readonly>
								</div>
								<div class="form-group">
									<label for="inputPassword4">Password</label> <input
										type="password" class="form-control" id="pass" name="password">
								</div>
								<div class="form-group">
									<label for="inputPassword4">Confirm Password</label> <input
										type="password" class="form-control" id="cpass" name="cpass">
								</div>
							</div>

							<div class="container text-center">

								<input type="submit" class="btn custom-bg text-light"
									value="Change">
								<button type="button" class="btn custom-bg text-light ml-5"
									data-dismiss="modal">Close</button>

							</div>
						</form>
					</div>
				</div>


			</div>
		</div>
	</div>
</body>
</html>