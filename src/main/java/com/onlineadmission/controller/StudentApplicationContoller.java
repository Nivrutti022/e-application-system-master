package com.onlineadmission.controller;

import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.Optional;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import com.lowagie.text.DocumentException;
import com.onlineadmission.dao.CourseDao;
import com.onlineadmission.dao.StudentApplicationDao;
import com.onlineadmission.dao.StudentDao;
import com.onlineadmission.dao.StudentDocumentsDao;
import com.onlineadmission.model.Course;
import com.onlineadmission.model.Student;
import com.onlineadmission.model.StudentApplication;
import com.onlineadmission.model.StudentDocuments;
import com.onlineadmission.utility.BillExporter;
import com.onlineadmission.utility.DBContants.IsAmountPaid;
import com.onlineadmission.utility.DBContants.IsDocumentUploaded;
import com.onlineadmission.utility.DBContants.Subject;

@Controller
@MultipartConfig
public class StudentApplicationContoller {
	
	private static Logger LOG = LogManager.getLogger(StudentApplicationContoller.class);

	@Autowired
	private StudentApplicationDao studentApplicationDao;

	@Autowired
	private StudentDocumentsDao studentDocumentsDao;
	
	@Autowired
	private CourseDao courseDao;
	
	@Autowired
	private StudentDao studentDao;

	@GetMapping("/registerStudentApplication")
	public String goToRegisterStudentApplicationPage() {
		LOG.info("Redirecting to Admin Login Page.");
		return "registerstudentapplication";
	}
	
	@PostMapping("/addstudentapplication")
	public ModelAndView addStudentApplication(HttpServletRequest request, HttpSession session) throws IOException, ServletException {
		ModelAndView mv = new ModelAndView();
		
		String fathername=request.getParameter("fathername");
		String mothername=request.getParameter("mothername");
		String city=request.getParameter("city");
		String dob=request.getParameter("dob");
		String state=request.getParameter("state");
		String country=request.getParameter("country");
		String pincode=request.getParameter("pincode");
		String qualification=request.getParameter("qualification");
		String subject=request.getParameter("subject");
		int courseId = Integer.parseInt(request.getParameter("courseId"));
		
		Optional optional = courseDao.findById(courseId);
		
		Course course = null;
		
		if(optional.isPresent()) {
			course = (Course)optional.get();
		}
		
		if(!qualification.equals(course.getMinimumQualification())) {
			mv.addObject("status", "Failed to Add Application, Qualification requirement failed.");
			 mv.setViewName("registerstudentapplication");
			return mv;
		}
		
		else if(!course.getSubjectCriteria().equals(Subject.NONE.value())  && !subject.equals(course.getSubjectCriteria())) {
			mv.addObject("status", "Failed to Add application, Subject Criteria failed.");
			 mv.setViewName("registerstudentapplication");
			return mv;
		}
		
		Part part=request.getPart("studentPic");	
		
		String fileName=part.getSubmittedFileName();
		
		String uploadPath="C:\\Users\\Admin\\Desktop\\online-admission-system-master\\src\\main\\resources\\studentPics\\"+fileName;
		
		try
		{
		FileOutputStream fos=new FileOutputStream(uploadPath);
		InputStream is=part.getInputStream();
		
		byte[] data=new byte[is.available()];
		is.read(data);
		fos.write(data);
		fos.close();
		}
		
		catch(Exception e)
		{
			e.printStackTrace();
		}
		
		StudentApplication application = new StudentApplication();
		Student student = (Student)session.getAttribute("active-user");
	    application.setStudentId(student.getId());
	    application.setCity(city);
	    application.setCountry(country);
	    application.setCourseId(courseId);
	    application.setDob(dob);
	    application.setFatherName(fathername);
	    application.setMotherName(mothername);
	    application.setPinCode(pincode);
	    application.setState(state);
        application.setStudentPhoto(fileName);
        
        session.setAttribute("registering-application", application);
        mv.addObject("status","Please add the document.");
	    mv.setViewName("adddocument");
		return mv;
	    
	
	}
	
	@PostMapping("/addstudentdocument")
	public ModelAndView addStudentDocument(HttpServletRequest request, HttpSession session) throws IOException, ServletException {
		ModelAndView mv = new ModelAndView();
		
		long percentage = Long.parseLong(request.getParameter("percentage"));
		int yearOfPassing= Integer.parseInt(request.getParameter("yearOfPassing"));
		String standard=request.getParameter("standard");
		Student student = (Student)session.getAttribute("active-user");
	    
		Part part=request.getPart("document");	
		
		String fileName=part.getSubmittedFileName();
		
		String uploadPath="C:\\Users\\Admin\\Desktop\\online-admission-system-master\\src\\main\\webapp\\resources\\documents\\"+fileName;
		
		try
		{
		FileOutputStream fos=new FileOutputStream(uploadPath);
		InputStream is=part.getInputStream();
		
		byte[] data=new byte[is.available()];
		is.read(data);
		fos.write(data);
		fos.close();
		}
		
		catch(Exception e)
		{
			e.printStackTrace();
		}
		
		StudentDocuments documents = new StudentDocuments();
		documents.setPercentage(percentage);
		documents.setIsDocumentUploaded(IsDocumentUploaded.YES.value());
		documents.setDocument(fileName);
		documents.setStudentId(student.getId());
		documents.setYearOfPassing(yearOfPassing);
		documents.setStandard(standard);
		
        session.setAttribute("student-document", documents);
        mv.addObject("status","Document Uploaded, Please pay the fee and submit the Application.");
	    mv.setViewName("paymentpage");
		return mv;
	    
	
	}
	
	@PostMapping("/payamount")
	public ModelAndView addStudentDocument(@RequestParam("amount") String amount, HttpSession session) throws IOException, ServletException {
		ModelAndView mv = new ModelAndView();
		
		StudentApplication application = (StudentApplication)session.getAttribute("registering-application");
		application.setIsAmountPaid(IsAmountPaid.YES.value());
		
		StudentDocuments document = (StudentDocuments)session.getAttribute("student-document");
		
		studentApplicationDao.save(application);
		studentDocumentsDao.save(document);
	    
        session.removeAttribute("registering-application");
        session.removeAttribute("student-document");
    
        mv.addObject("status","Application Submitted Successfully:)");
	    mv.setViewName("index");
		
	    return mv;
	
	}
	
	@GetMapping("/myapplication")
	public String goToApplicationPage() {
		LOG.info("Redirecting to My Application Page.");
		return "applicationform";
	}
	
	@GetMapping("/allforms")
	public String goToAllFormPage() {
		LOG.info("Redirecting to All form Page.");
		return "allforms";
	}
	
	@GetMapping("/downloadform")
	public void downloadBill(@RequestParam("studentId") int studentId, HttpServletResponse response) throws DocumentException, IOException {

		Optional optional = studentDao.findById(studentId);
		Student student = null;
		
		if(optional.isPresent()) {
			student = (Student)optional.get();
		}
		
		StudentApplication application = studentApplicationDao.findByStudentId(studentId);
		StudentDocuments document = studentDocumentsDao.findByStudentId(studentId);
		
		response.setContentType("application/pdf");
		String headerKey = "Content-Disposition";
        String headerValue = "attachment; filename="+student.getFirstname()+"_Application.pdf";
        response.setHeader(headerKey, headerValue);
        
        Course course = null;
        
        Optional optionalC = courseDao.findById(application.getCourseId());
		if(optionalC.isPresent()) {
			course = (Course)optionalC.get();
		}
        
        BillExporter exporter = new BillExporter(course, document, application, student);
        exporter.export(response);
	}
	
}
