<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Home- Online Application</title>
<%@ include file="./components/common_cs_js.jsp"%>
</head>
<body >
	<%@ include file="./components/navbar.jsp"%>
	<div id="carouselExampleIndicators" class="carousel slide"
		data-ride="carousel">
		<ol class="carousel-indicators">
			<li data-target="#carouselExampleIndicators" data-slide-to="0"
				class="active"></li>
			<li data-target="#carouselExampleIndicators" data-slide-to="1"></li>
			<li data-target="#carouselExampleIndicators" data-slide-to="2"></li>
		</ol>
		<div class="carousel-inner" style="width: 100%">
			<div class="carousel-item active">
				<img class="d-block w-100" src="resources/images/car.jpeg" alt="First slide">
			</div>
			<div class="carousel-item">
				<img class="d-block w-100" src="resources/images/car.jpeg" alt="Second slide">
			</div>
			<div class="carousel-item">
				<img class="d-block w-100" src="resources/images/car.jpeg" alt="Third slide">
			</div>
		</div>
		<a class="carousel-control-prev" href="#carouselExampleIndicators"
			role="button" data-slide="prev"> <span
			class="carousel-control-prev-icon" aria-hidden="true"></span> <span
			class="sr-only">Previous</span>
		</a> <a class="carousel-control-next" href="#carouselExampleIndicators"
			role="button" data-slide="next"> <span
			class="carousel-control-next-icon" aria-hidden="true"></span> <span
			class="sr-only">Next</span>
		</a>
	</div>
	<%@ include file="./components/message.jsp"%>

	<div class="card-group mt-5 md-5">
  <div class="card custom-bg ml-5 mr-3 mb-5">
    <img class="card-img-top" src="resources/images/doctors.png" alt="Card image cap">
    <div class="card-body">
      <h2 class="card-title text-center text-color">Our Doctors</h2>
      <p class="card-text">The job of a doctor is to diagnose and treat illness and injury.</p>
    </div>
  </div>
  <div class="card custom-bg ml-3 mr-3 mb-5">
    <img class="card-img-top mt-4" src="resources/images/nurses.png" alt="Card image cap">
    <div class="card-body">
      <h2 class="card-title text-center text-color mt-3">Our Engineers</h2>
      <p class="card-text">Engineers create the world. Enhancing the future. Excellence and innovation built into every design. Excellence in every experience.</p>
    </div>
  </div>
  <div class="card custom-bg ml-3 mr-5 mb-5">
    <img class="card-img-top" src="resources/images/medicines.png" alt="Card image cap">
    <div class="card-body">
      <h2 class="card-title text-center text-color">Our Pharmacist</h2>
      <p class="card-text">Medicines are chemicals or compounds used to cure, halt, or prevent disease</p>
    </div>
  </div>
</div>
    

</body>
</html>