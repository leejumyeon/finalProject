package com.spring.groupware.leeeh.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.groupware.commonVO.ClubVO;
import com.spring.groupware.commonVO.DepartmentVO;
import com.spring.groupware.commonVO.DocumentCategoryVO;
import com.spring.groupware.commonVO.DocumentVO;
import com.spring.groupware.commonVO.EmployeesVO;
import com.spring.groupware.leeeh.model.InterLeeehDAO;

@Service
public class LeeehService implements InterLeeehService {

	@Autowired
	private InterLeeehDAO dao;

	// === 로그인 페이지에서 적은 ID와 비밀번호를 통해 유저가 존재하는지 검사하기 === //
	@Override
	public EmployeesVO isUserExist(HashMap<String, String> paraMap) {

		EmployeesVO loginEmployee = dao.isUserExist(paraMap);
		
		return loginEmployee;
	}

	// === 사원 발급을 하기위해 사원 ID에서 max값을 가져오기 === //
	@Override
	public String getMaxOfEmployeeId(String hireDate) {

		String max = dao.getMaxOfEmployeeId(hireDate);
		
		return max;
	}

	// === 사원 발급을 하기 위해 부서리스트를 가져오기 === //
	@Override
	public List<DepartmentVO> departmentList() {

		List<DepartmentVO> departmentList = dao.departmentList();
		
		return departmentList;
	}

	// === 사원발급에서 테이블에 집어 넣기 == //
	@Override
	public void insertEmployeeTable(HashMap<String, String> paraMap) {

		dao.insertEmployeeTable(paraMap);
	}

	// === 문서 결재 카테고리 알아오기 === //
	@Override
	public List<DocumentCategoryVO> documentCategoryList() {

		List<DocumentCategoryVO> documentCategoryList = dao.documentCategoryList();
		
		return documentCategoryList;
	}

	// === 문서 결재를 하기위해 문서번호에서 max값을 가져오기 === //
	@Override
	public String getMaxOfGroupno(String regDate) {

		String max = dao.getMaxOfGroupno(regDate);
		
		return max;
	}

	// === 문서 결재 작성 페이지에서 사원들 정보 불러오기 === //
	@Override
	public List<EmployeesVO> showMemberByDepartment(String seq) {

		List<EmployeesVO> employeesByDepartList = dao.showMemberByDepartment(seq);
		
		return employeesByDepartList;
	}

	// === 클릭한 사원들 결재선에 올리기 === //
	@Override
	public List<EmployeesVO> approvalList(HashMap<String, Object> paraMap) {

		List<EmployeesVO> approvalList = dao.approvalList(paraMap);
		
		return approvalList;
	}

	// === 휴가 종류 받아오기 === //
	@Override
	public List<HashMap<String, String>> tripCatListOfVacation() {

		List<HashMap<String, String>> tripCatList = dao.tripCatListOfVacation();
		
		return tripCatList;
	}
	
	// === 출장 종류 받아오기 === //
	@Override
	public List<HashMap<String, String>> tripCatListOfBusiness() {

		List<HashMap<String, String>> tripCatList = dao.tripCatListOfBusiness();
		
		return tripCatList;
	}

	// === 문서 결재 테이블에 정보 집어 넣기 === //
	@Override
	public void insertDocumentTable(DocumentVO dvo) {

		dao.insertDocumentTable(dvo);
		
	}

	// === 휴가 정보를 휴가/출장 테이블에 집어 넣기 === //
	@Override
	public void insertTripTableOfVacation(HashMap<String, Object> paraMap) {

		dao.insertTripTableOfVacation(paraMap);
		
	}

	// === 출장 정보를 휴가/출장 테이블에 집어 넣기 === //
	@Override
	public void insertTripTableOfBusiness(HashMap<String, Object> paraMap) {

		dao.insertTripTableOfBusiness(paraMap);
	}

	// === 매출 정보를 매출 테이블에 집어 넣기 === //
	@Override
	public void insertSalesTable(HashMap<String, Object> paraMap) {

		dao.insertSalesTable(paraMap);
	}

	// === 비품 구매 정보를 배품 테이블에 집어 넣기 === //
	@Override
	public void insertEquipmentTable(HashMap<String, Object> paraMap) {

		dao.insertEquipmentTable(paraMap);
	}

	// === 프로젝트 seq번호 체번해오기 === //
	@Override
	public String getProjectSeq() {

		String project_seq = dao.getProjectSeq();
		
		return project_seq;
	}

	// === 프로젝트 정보를 프로젝트 테이블에 집어 넣기 === //
	@Override
	public void insertProjectTable(HashMap<String, Object> paraMap) {
		
		dao.insertProjectTable(paraMap);
	}

	// === 프로젝트 명단에 들어갈 사원 번호 받아오기 === //
	@Override
	public String getEmployeeSeq(HashMap<String, Object> paraMap) {

		String employee_seq = dao.getEmployeeSeq(paraMap);
		
		return employee_seq;
	}
	
	// === 사원 ID로 사원 번호 알아오기 === //
	@Override
	public String getEmployeeSeqByEmployeeId(String employee_id) {

		String employee_seq = dao.getEmployeeSeqByEmployeeId(employee_id);
		
		return employee_seq;
	}

	// === 프로젝트 명단에 집어 넣기 === //
	@Override
	public void insertProjectMemberTable(HashMap<String, Object> paraMap) {

		dao.insertProjectMemberTable(paraMap);
	}

	// === 프로젝트 중단 정보를 프로젝트 테이블에 업데이트 하기 === //
	@Override
	public void updateProjectTable(HashMap<String, Object> paraMap) {
		
		dao.updateProjectTable(paraMap);
	}

	// === 프로젝트 완료 정보를 프로젝트 테이블에 업데이트 하기 === //
	@Override
	public void updateProjectTableEnd(HashMap<String, Object> paraMap) {

		dao.updateProjectTableEnd(paraMap);
	}

	// === 퇴사 정보를 퇴사 테이블에 집어 넣기 === //
	@Override
	public void insertFireTable(HashMap<String, Object> paraMap) {

		dao.insertFireTable(paraMap);
	}

	// === 근태 정보를 근태관리 테이블에 집어 넣기 === //
	@Override
	public void insertTATable(HashMap<String, Object> paraMap) {

		dao.insertTATable(paraMap);
	}

	// === 동호회 정보를 종호회 테이블에 집어 넣기 === //
	@Override
	public void insertClubTable(HashMap<String, Object> paraMap) {

		dao.insertClubTable(paraMap);
	}

	// === 클럽 모두 가져오기 === //
	@Override
	public List<ClubVO> clubList() {
		
		List<ClubVO> clubList = dao.clubList();
		
		return clubList;
	}

	// === 동호회 명단 정보 테이블에 집어 넣기 === //
	@Override
	public void insertClubMemberTable(HashMap<String, Object> paraMap) {

		dao.insertClubMemberTable(paraMap);
	}

	// === 클럽 번호 채번해오기 === //
	@Override
	public String getClubSeq() {

		String club_seq = dao.getClubSeq();
		
		return club_seq;
	}

	// === 클럽 회장 정보 넣기 === //
	@Override
	public void insertClubMemberTableOfManager(HashMap<String, Object> paraMap) {

		dao.insertClubMemberTableOfManager(paraMap);
	}

	// === 클럽 지우기 === //
	@Override
	public void deleteClub(HashMap<String, Object> paraMap) {

		dao.deleteClub(paraMap);
	}

	// === 문서 결재 신청자의 List 얻어오기 === //
	@Override
	public List<DocumentVO> regDocumentList(String fk_employee_seq) {

		List<DocumentVO> regDocumentList = dao.regDocumentList(fk_employee_seq);
		
		return regDocumentList;
	}

	// === 문서 상세 내용 보여주기 === //
	@Override
	public HashMap<String, String> goDocumentContent(String document_seq) {

		HashMap<String, String> documentContent = dao.goDocumentContent(document_seq);
		
		return documentContent;
	}

	// === 문서 결재자들 알아오기 === //
	@Override
	public List<DocumentVO> getApproverList(String groupno) {

		List<DocumentVO> approverList = dao.getApproverList(groupno);
		
		return approverList;
	}

	// === 문서 결재 받는 사람의 List 얻어오기 === //
	@Override
	public List<DocumentVO> aproDocumentList(String fk_employee_seq) {

		List<DocumentVO> aproDocumentList = dao.aproDocumentList(fk_employee_seq);
		
		return aproDocumentList;
	}

	// === 신청 완료된 전체 문서 보여주기 === //
	@Override
	public List<DocumentVO> allComDocumentList(String fk_employee_seq) {

		List<DocumentVO> comDocumentList = dao.allComDocumentList(fk_employee_seq);
		
		return comDocumentList;
	}

	// === 신청 완료된 신청한 문서 보여주기 === //
	@Override
	public List<DocumentVO> senComDocumentList(String fk_employee_seq) {

		List<DocumentVO> comDocumentList = dao.senComDocumentList(fk_employee_seq);
		
		return comDocumentList;
	}

	// === 신청 완료된 결재한 문서 보여주기 === //
	@Override
	public List<DocumentVO> recComDocumentList(String fk_employee_seq) {

		List<DocumentVO> comDocumentList = dao.recComDocumentList(fk_employee_seq);
		
		return comDocumentList;
	}

}
