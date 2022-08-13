<%@ page import ="com.onlineadmission.model.*"%>
<%@ page import ="com.onlineadmission.dao.*"%>
<%@ page import="com.onlineadmission.utility.*"%>
<%@ page import ="org.springframework.context.ApplicationContext"%>
<%@ page import ="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@ page import ="java.sql.*"%>
<%@ page import ="java.util.*"%>


<%

String userType=(String)session.getAttribute("user-login");
Admin admin = null;
Student student = null ;
if(userType != null && userType.equals("admin")){
	 admin = (Admin) session.getAttribute("active-user");
}

else if(userType != null && userType.equals("student")){
	 student= (Student)session.getAttribute("active-user");
}

ApplicationContext context =  WebApplicationContextUtils.getWebApplicationContext(getServletContext());
StudentDao studentDao = context.getBean(StudentDao.class);
AdminDao adminDao = context.getBean(AdminDao.class);
CourseDao courseDao = context.getBean(CourseDao.class);
StudentApplicationDao applicationDao= context.getBean(StudentApplicationDao.class);
StudentDocumentsDao documentDao= context.getBean(StudentDocumentsDao.class);

%>

<nav class="navbar navbar-expand-lg navbar-dark custom-bg">

<div class="container-fluid">
  <img src="resources/images/studentlogo.png" width="35" height="35" class="d-inline-block align-top" alt="">
  <a class="navbar-brand" href="/"><h3 class="text-color"><i>e-Application System</i></h3></a>
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
  </button>

  <div class="collapse navbar-collapse" id="navbarSupportedContent">
    <ul class="navbar-nav mr-auto">
    
    
    <%
        	 if(userType != null && userType.equals("admin"))
        	 {
    %>
                 <li class="nav-item active">
                    <a class="nav-link" href="allforms"><b class="text-color">All Application Form</b> <span class="sr-only">(current)</span></a>
                 </li>
                 
                  <li class="nav-item active">
                    <a class="nav-link" href="addcourse"><b class="text-color">Add Course</b></a>
                 </li>
    <%
        	 }
    %>
    
     <%
           if(userType == null) {
        %>
              <li class="nav-item active">
                    <a class="nav-link" href="adminlogin"><b class="text-color">Admin Login</b> <span class="sr-only">(current)</span></a>
                 </li>
        <%
           }
        %>
      
      <li class="nav-item active text-color ml-2" data-toggle="modal" data-target=".aboutusmodal">
          <div class="nav-link" ><b class="text-color">About us</b></div>
      </li>
      
      <li class="nav-item active text-color ml-2" data-toggle="modal" data-target=".contactusmodal">
          <div class="nav-link" ><b class="text-color">Contact us</b></div>
      </li>
     
    </ul>
       
        <%
           if(userType != null && userType.equals("student")) {
        %>
          <ul class="navbar-nav ml-auto">
          
          <li class="nav-item active">
                    <a class="nav-link" href="registerStudentApplication"><b class="text-color">Register Application</b></a>
                 </li> 
                 
                 <li class="nav-item active">
                    <a class="nav-link" href="myapplication"><b class="text-color">My Application</b></a>
                 </li> 
                
               <li class="nav-item active">
                    <a class="nav-link" href="myprofile"><b class="text-color">Show My Profile</b></a>
                 </li> 
              
            <li class="nav-item active">
                    <a class="nav-link" href="changepassword"><b class="text-color">Change Password</b> <span class="sr-only">(current)</span></a>
                 </li>
             
             <li class="nav-item active text-color" data-toggle="modal" data-target=".logout-modal">
               <a class="nav-link" href="#" ><b>Logout</b></a>
             </li> 
              
               
               
              <%
             
           }     
            
           else if((userType != null && userType.equals("admin"))){
        	   
        	   
        	  %>
        	  <li class="nav-item active text-color" data-toggle="modal" data-target=".logout-modal">
               <a class="nav-link" href="#" ><b>Logout</b></a>
             </li> 
              
        	  <% 
           }
                    
        else
        {
    %>
      
    
      <li class="nav-item active text-color">
        <a class="nav-link" href="studentregister"><b class="text-color">Register</b></a>
      </li>  
      
      <li class="nav-item text-color active">
        <a class="nav-link" href="studentlogin"><b class="text-color">Login</b></a>
      </li>    
    </ul>
    
    <%
        }
    %>     
    
  </div>
  </div>
</nav>

<!-- Logout modal -->

<div class="modal fade logout-modal" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-sm">
    <div class="modal-content">
    <div class="modal-header custom-bg text-white text-center">
        <h5 class="modal-title" id="exampleModalLongTitle" >Log Out</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
    </div>
    <div class="modal-body text-center">
            <h5>Do you want to logout?</h5>
          
          <div class="text-center">
            <a href="logout"><button type="button" class="btn custom-bg text-white">Yes</button></a>
            <button type="button" class="btn btn-secondary ml-5" data-dismiss="modal">No</button>
          </div> 
     </div>     
    </div>
  </div>
</div>

<!-- *********** -->

<!-- About us modal -->

<div class="modal fade aboutusmodal" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
       <div class="modal-header custom-bg text-white text-center">
        <h5 class="modal-title" id="exampleModalLongTitle" >About Us</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div> 
      <div class="modal-body">
        <div class="container">
        <p style="font-size:20px;">
          <b>
             We all are aware that the Covid-19 virus spreads in various different ways. But the main carriers are the humans themselves. Due to this reason, reducing human contact became essential and so were the imposition of social distancing norms.

The pace of the educational activities slowed down for some time.  But then the mighty Technology made an appearance in the education sector and the educational activities regained the pace. 

Following the social distancing norms was crucial and so was carrying out the educational activities. Thus, all the educational activities started taking place indoors in an online mode. Since then online admissions became the new normal.
          </b>
        </p>
        </div>
      </div>
      <div class="modal-footer">
       <div class="text-center">
        <button type="button" class="btn custom-bg text-white" data-dismiss="modal">Close</button>
       </div>
      </div>
    </div>
  </div>
</div>
<!-- ********** -->

<!-- Contact us modal -->

<div class="modal fade contactusmodal" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
       <div class="modal-header custom-bg text-white text-center">
        <h5 class="modal-title" id="exampleModalLongTitle" >Contact Us</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div> 
      <div class="modal-body">
        <div class="container text-center">
        <p style="font-size:23px;">
            <b>
                <img src="resources/images/phone.png" style="width:27px;" alt="img">+91 7972986283 / +91 7021599272<br>
                <img src="resources/images/mail.png" style="width:29px;" alt="img">bhaveshsonawane77@gmail.com
            </b>
        </p>
        </div>
      </div>
      <div class="modal-footer">
       <div class="text-center">
        <button type="button" class="btn custom-bg text-white" data-dismiss="modal">Close</button>
       </div>
      </div>
    </div>
  </div>
</div>
<!-- ********** -->