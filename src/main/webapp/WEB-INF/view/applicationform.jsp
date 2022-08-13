<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head><style >
body{
 background-image: url("resources/images/docu.jpg");}
</style>
<meta charset="ISO-8859-1">
<title>My Application Form</title>
<%@ include file="./components/common_cs_js.jsp"%>
</head>
<body>
	<%@ include file="./components/navbar.jsp"%>
	<%
	StudentApplication app = applicationDao.findByStudentId(student.getId());
	StudentDocuments doc = documentDao.findByStudentId(student.getId());
	Optional optional = courseDao.findById(app.getCourseId());
	Course course = null;

	if (optional.isPresent()) {
		course = (Course) optional.get();
	}
	%>

	<div class="container-fluid md-5">
		<div class="row mt-2">
			<div class="col-md-4 offset-md-4 admin">
				<div class="card">
					<form>
						<div class="text-center">
							<img src="C:\Users\admin\Desktop\my project\online-admission-system\src\main\resources\studentPics\<%=app.getStudentPhoto()%>"
								class="rounded mx-auto d-block" alt="img" height="90px"
								width="90px">
						</div>
						<div class="row ml-5">
							<div class="form-group">
								<label for="email">First Name</label> <input type="email"
									class="form-control" aria-describedby="emailHelp"
									value="<%=student.getFirstname()%>" readonly required>
							</div>
							<div class="form-group ml-4">
								<label for="email">Last Name</label> <input type="text"
									class="form-control" aria-describedby="emailHelp"
									value="<%=student.getLastname()%>" readonly required>
							</div>
						</div>

						<div class="row ml-5">
							<div class="form-group">
								<label for="email">Mobile No</label> <input type="email"
									class="form-control" aria-describedby="emailHelp"
									value="<%=student.getMobileno()%>" readonly required>
							</div>
							<div class="form-group ml-4">
								<label for="email">Email Id</label> <input type="text"
									class="form-control" aria-describedby="emailHelp"
									value="<%=student.getEmailid()%>" readonly required>
							</div>
						</div>

						<div class="row ml-5">
							<div class="form-group">
								<label for="email">Father Name</label> <input type="text"
									class="form-control" aria-describedby="emailHelp"
									value="<%=app.getFatherName()%>" readonly required>
							</div>
							<div class="form-group ml-4">
								<label for="email">Mother Name</label> <input type="text"
									class="form-control" aria-describedby="emailHelp"
									value="<%=app.getMotherName()%>" readonly required>
							</div>
						</div>

						<div class="row ml-5">
							<div class="form-group">
								<label for="email">City</label> <input type="text"
									class="form-control" aria-describedby="emailHelp"
									value="<%=app.getCity()%>" readonly required>
							</div>
							<div class="form-group ml-4">
								<label for="email">State</label> <input type="text"
									class="form-control" aria-describedby="emailHelp"
									value="<%=app.getState()%>" readonly required>
							</div>
						</div>

						<div class="row ml-5">
							<div class="form-group">
								<label for="email">Country</label> <input type="text"
									class="form-control" aria-describedby="emailHelp"
									value="<%=app.getCountry()%>" readonly required>
							</div>
							<div class="form-group"></div>
						</div>

						<div class="row ml-5">
							<div class="form-group">
								<label for="email">12th Percentage</label> <input type="text"
									class="form-control" aria-describedby="emailHelp"
									value="<%=doc.getPercentage()%>" readonly required>
							</div>
							<div class="form-group ml-4">
								<label for="email">12th Passing Year</label> <input type="text"
									class="form-control" aria-describedby="emailHelp"
									value="<%=doc.getYearOfPassing()%>" readonly required>
							</div>
						</div>

						<div class="text-center md-5">
							<h1>
								Course : <span style="color: green"><%if(course!= null) {%><%=course.getName()%><%} %></span>
							</h1>
							<h2>
								Document Uploaded : <span style="color: green"><%=doc.getIsDocumentUploaded()%></span>
							</h2>

							<h2>
								Amount Paid : <span style="color: green"><%=app.getIsAmountPaid()%></span>
							</h2>
						</div>

						<div class="card-footer bg-white text-center">
							<a href="downloadform?studentId=<%=student.getId()%>"><button
									type="button" class="btn custom-bg text-color">Download Application</button>
						    </a>
						</div>
						
					</form>

				</div>
			</div>
		</div>
	</div>

</body>
</html>