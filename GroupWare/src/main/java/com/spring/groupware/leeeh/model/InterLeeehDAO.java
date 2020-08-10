package com.spring.groupware.leeeh.model;

import java.util.HashMap;
import java.util.List;

import com.spring.groupware.commonVO.ClubVO;
import com.spring.groupware.commonVO.DepartmentVO;
import com.spring.groupware.commonVO.DocumentCategoryVO;
import com.spring.groupware.commonVO.DocumentVO;
import com.spring.groupware.commonVO.EmployeesVO;

public interface InterLeeehDAO {

	EmployeesVO isUserExist(HashMap<String, String> paraMap);	// 로그인 페이지에서 적은 ID와 비밀번호를 통해 유저가 존재하는지 검사하기

	String getMaxOfEmployeeId(String hireDate);	// 사원 발급을 하기위해 사원 ID에서 max값을 가져오기

	List<DepartmentVO> departmentList();	// 사원 발급을 하기 위해 부서리스트를 가져오기

	void insertEmployeeTable(HashMap<String, String> paraMap);	// 사원발급에서 테이블에 집어 넣기

	List<DocumentCategoryVO> documentCategoryList();	// 문서 결재 카테고리 알아오기

	String getMaxOfGroupno(String regDate);	// 문서 결재를 하기위해 문서번호에서 max값을 가져오기

	List<EmployeesVO> showMemberByDepartment(String seq);	// 문서 결재 작성 페이지에서 사원들 정보 불러오기

	List<EmployeesVO> approvalList(HashMap<String, Object> paraMap);	// 클릭한 사원들 결재선에 올리기

	List<HashMap<String, String>> tripCatListOfVacation();	// 휴가 종류 받아오기
	
	List<HashMap<String, String>> tripCatListOfBusiness();	// 출장 종류 받아오기

	void insertDocumentTable(DocumentVO dvo);	// 문서 결재 테이블에 정보 집어 넣기

	void insertTripTableOfVacation(HashMap<String, Object> paraMap);	// 휴가 정보를 휴가/출장 테이블에 집어 넣기

	void insertTripTableOfBusiness(HashMap<String, Object> paraMap);	// 출장 정보를 휴가/출장 테이블에 집어 넣기

	void insertSalesTable(HashMap<String, Object> paraMap);	// 매출 정보를 매출 테이블에 집어 넣기

	void insertEquipmentTable(HashMap<String, Object> paraMap);	// 비품 구매 정보를 배품 테이블에 집어 넣기

	String getProjectSeq();	// 프로젝트 seq번호 체번해오기

	void insertProjectTable(HashMap<String, Object> paraMap);	// 프로젝트 정보를 프로젝트 테이블에 집어 넣기

	String getEmployeeSeq(HashMap<String, Object> paraMap);	// 프로젝트 명단에 들어갈 사원 번호 받아오기
	
	String getEmployeeSeqByEmployeeId(String employee_id);	// 사원 ID로 사원 번호 알아오기

	void insertProjectMemberTable(HashMap<String, Object> paraMap);	// 프로젝트 명단에 집어 넣기

	void updateProjectTable(HashMap<String, Object> paraMap);	// 프로젝트 중단 정보를 프로젝트 테이블에 업데이트 하기

	void updateProjectTableEnd(HashMap<String, Object> paraMap);	// 프로젝트 완료 정보를 프로젝트 테이블에 업데이트 하기

	void insertFireTable(HashMap<String, Object> paraMap);	// 퇴사 정보를 퇴사 테이블에 집어 넣기

	void insertTATable(HashMap<String, Object> paraMap);	// 근태 정보를 근태관리 테이블에 집어 넣기

	void insertClubTable(HashMap<String, Object> paraMap);	// 동호회 정보를 종호회 테이블에 집어 넣기

	List<ClubVO> clubList();	// 클럽 모두 가져오기

	void insertClubMemberTable(HashMap<String, Object> paraMap);	// 동호회 명단 정보 테이블에 집어 넣기

	String getClubSeq();	// 클럽 번호 채번해오기

	void insertClubMemberTableOfManager(HashMap<String, Object> paraMap);	// 클럽 회장 정보 넣기

	void deleteClub(HashMap<String, Object> paraMap);	// 클럽 지우기


	
	
}
