package com.onlineadmission.dao;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.onlineadmission.model.StudentDocuments;

@Repository
public interface StudentDocumentsDao extends JpaRepository<StudentDocuments, Integer>{
	
	StudentDocuments findByStudentId(int studentId);

}
