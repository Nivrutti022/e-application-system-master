package com.onlineadmission.utility;

import java.awt.Color;
import java.io.IOException;

import javax.servlet.http.HttpServletResponse;

import com.lowagie.text.Chunk;
import com.lowagie.text.Document;
import com.lowagie.text.DocumentException;
import com.lowagie.text.Font;
import com.lowagie.text.FontFactory;
import com.lowagie.text.Image;
import com.lowagie.text.PageSize;
import com.lowagie.text.Paragraph;
import com.lowagie.text.pdf.PdfWriter;
import com.lowagie.text.pdf.draw.VerticalPositionMark;
import com.onlineadmission.model.Course;
import com.onlineadmission.model.Student;
import com.onlineadmission.model.StudentApplication;
import com.onlineadmission.model.StudentDocuments;

public class BillExporter {
	
	private Course course;
	
	private StudentDocuments studentDocument;
	
	private StudentApplication studentApplication;
	
	private Student student;

	public BillExporter(Course course, StudentDocuments studentDocument, StudentApplication studentApplication,
			Student student) {
		super();
		this.course = course;
		this.studentDocument = studentDocument;
		this.studentApplication = studentApplication;
		this.student = student;
	}

	public void export(HttpServletResponse response) throws DocumentException, IOException {
        Document document = new Document(PageSize.A4);
        
        PdfWriter.getInstance(document, response.getOutputStream());
        document.open();
        Image image = Image.getInstance("classpath:images/studentlogo.png");
        image.scalePercent(6.0f, 6.0f);
        document.add(image);
        
        Font headerFont = FontFactory.getFont(FontFactory.HELVETICA_BOLD);
        headerFont.setSize(25);
        headerFont.setColor(new Color(91, 73, 37));
        Paragraph pHeader = new Paragraph("Student Application \n", headerFont);
        pHeader.setAlignment(Paragraph.ALIGN_CENTER);
        document.add(pHeader);
        
        headerFont.setSize(13);
        headerFont.setColor(new Color(215, 196, 158));
        Paragraph pD = new Paragraph("Student Id: "+student.getId(), headerFont);
        pD.setAlignment(Paragraph.ALIGN_RIGHT);
        document.add(pD);
        
        Image imageP = Image.getInstance("classpath:studentPics/"+studentApplication.getStudentPhoto());
        imageP.scalePercent(13.0f, 13.0f);
        document.add(imageP);
        
        headerFont.setSize(18);
        headerFont.setColor(new Color(91, 73, 37));
        Chunk glue = new Chunk(new VerticalPositionMark());
        Paragraph pp = new Paragraph("\nStudent Details:",headerFont);
        pp.add(new Chunk(glue));
        pp.add("Parent Details:");
        document.add(pp);
        
        headerFont.setSize(12);
        headerFont.setColor(Color.BLACK);
        Chunk glueN = new Chunk(new VerticalPositionMark());
        Paragraph pN = new Paragraph("Name: "+student.getFirstname()+" "+student.getLastname(),headerFont);
        pN.add(new Chunk(glueN));
        pN.add("Father Name: "+studentApplication.getFatherName());
        document.add(pN);
        
        headerFont.setSize(12);
        headerFont.setColor(Color.BLACK);
        Chunk glueA = new Chunk(new VerticalPositionMark());
        Paragraph pA = new Paragraph("Email Id: "+student.getEmailid(),headerFont);
        pA.add(new Chunk(glueA));
        pA.add("Mother Name: "+studentApplication.getMotherName());
        document.add(pA);
        
        headerFont.setSize(12);
        headerFont.setColor(Color.BLACK);
        Paragraph pBG = new Paragraph("Mobile No: "+student.getMobileno(), headerFont);
        pBG.setAlignment(Paragraph.ALIGN_LEFT);
        document.add(pBG);
        
        headerFont.setSize(12);
        headerFont.setColor(Color.BLACK);
        Paragraph pE = new Paragraph("Address: "+student.getStreet()+" "+student.getCity()+" "+student.getPincode(), headerFont);
        pE.setAlignment(Paragraph.ALIGN_LEFT);
        document.add(pE);
        
        headerFont.setSize(25);
        headerFont.setColor(new Color(91, 73, 37));
        Paragraph pQHeader = new Paragraph("Qualification \n", headerFont);
        pQHeader.setAlignment(Paragraph.ALIGN_CENTER);
        document.add(pQHeader);
        
        headerFont.setSize(12);
        headerFont.setColor(Color.BLACK);
        Paragraph pper = new Paragraph("12th Percentage : "+studentDocument.getPercentage(), headerFont);
        pper.setAlignment(Paragraph.ALIGN_CENTER);
        document.add(pper);
        
        
        headerFont.setSize(12);
        headerFont.setColor(Color.BLACK);
        Paragraph ppass = new Paragraph("12th Passing Year : "+studentDocument.getYearOfPassing(), headerFont);
        ppass.setAlignment(Paragraph.ALIGN_CENTER);
        document.add(ppass);
        
        headerFont.setSize(13);
        headerFont.setColor(new Color(91, 73, 37));
        Paragraph pTook = new Paragraph("\nDocuments Uploaded : "+studentDocument.getIsDocumentUploaded(), headerFont);
        pTook.setAlignment(Paragraph.ALIGN_RIGHT);
        document.add(pTook);
        
        headerFont.setSize(25);
        headerFont.setColor(new Color(91, 73, 37));
        Paragraph p2Header = new Paragraph("Course Detail \n", headerFont);
        p2Header.setAlignment(Paragraph.ALIGN_CENTER);
        document.add(p2Header);
        
        headerFont.setSize(12);
        headerFont.setColor(Color.BLACK);
        Paragraph p = new Paragraph("Course Name : "+course.getName(), headerFont);
        p.setAlignment(Paragraph.ALIGN_CENTER);
        document.add(p);
        
        headerFont.setSize(13);
        headerFont.setColor(new Color(91, 73, 37));
        Paragraph pMedicines = new Paragraph("\nApplication Form Amount Rs "+DBContants.applicationAmount+"/- : "+studentApplication.getIsAmountPaid() , headerFont);
        pMedicines.setAlignment(Paragraph.ALIGN_RIGHT);
        document.add(pMedicines);
        
        document.close();
         
    }
	
	

}
