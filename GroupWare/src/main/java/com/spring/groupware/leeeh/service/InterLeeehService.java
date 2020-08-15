package com.spring.groupware.leeeh.service;

import java.util.HashMap;
import java.util.List;

import com.spring.groupware.commonVO.ClubVO;
import com.spring.groupware.commonVO.DepartmentVO;
import com.spring.groupware.commonVO.DocumentCategoryVO;
import com.spring.groupware.commonVO.DocumentVO;
import com.spring.groupware.commonVO.EmployeesVO;
import com.spring.groupware.commonVO.TripVO;

public interface InterLeeehService {

	EmployeesVO isUserExist(HashMap<String, String> paraMap);	// 로그인 페이지에서 적은 ID와 비밀번호를 통해 유저가 존재하는지 검사하기

	String getMaxOfEmployeeId(String hireDate);	// 사원 발급을 하기위해 사원 ID에서 max값을 가져오기

	List<DepartmentVO> departmentList();	// 사원 발급을 하기 위해 부서리스트를 가져오기

	void insertEmployeeTable(HashMap<String, String> paraMap);	// 사원발급에서 테이블에 집어 넣기

	List<DocumentCategoryVO> documentCategoryList();	// 문서 결재 카테고리 알아오기

	String getMaxOfGroupno(String regDate);	// 문서 결재를 하기위해 문서번호에서 max값을 가져오기

	List<EmployeesVO> showMemberByDepartment(HashMap<String, String> paraMap);	// 문서 결재 작성 페이지에서 사원들 정보 불러오기

	List<EmployeesVO> approvalList(HashMap<String, Object> paraMap);	// 클릭한 사원들 결재선에 올리기

	List<HashMap<String, String>> tripCatListOfVacation();	// 휴가 종류 받아오기
	
	List<HashMap<String, String>> tripCatListOfBusiness();	// 출장 종류 받아오기

	void insertDocumentTable(DocumentVO dvo);	// 문서 결재 테이블에 정보 집어 넣기

	void insertTripTableOfVacation(HashMap<String, Object> paraMap);	// 휴가 정보를 휴가/출장 테이블에 집어 넣기

	void insertTripTableOfBusiness(HashMap<String, Object> paraMap);	// 출장 정보를 휴가/출장 테이블에 집어 넣기

	void insertSalesTable(HashMap<String, Object> paraMap);	// 매출 정보를 매출 테이블에 집어 넣기

	void insertEquipmentTable(HashMap<String, Object> paraMap);	// 비품 구매 정보를 배품 테이블에 집어 넣기

	String getProjectSeq();	// 프로젝트 seq번호 체번해오

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

	List<DocumentVO> regDocumentList(String fk_employee_seq);	// 문서 결재 신청자의 List 얻어오기

	HashMap<String, String> goDocumentContent(String document_seq);	// 문서 상세 내용 보여주기

	List<DocumentVO> getApproverList(String groupno);	// 문서 결재자들 알아오기

	List<DocumentVO> aproDocumentList(String fk_employee_seq);	// 문서 결재 받는 사람의 List 얻어오기

	List<DocumentVO> allComDocumentList(String fk_employee_seq);	// 신청 완료된 전체 문서 보여주기

	List<DocumentVO> senComDocumentList(String fk_employee_seq);	// 신청 완료된 신청한 문서 보여주기

	List<DocumentVO> recComDocumentList(String fk_employee_seq);	// 신청 완료된 결재한 문서 보여주기

	void updateStatusDocmenetTable(HashMap<String, Object> paraMap);	// 결재 반려 테이블에 status 업데이트 하기

	List<DocumentVO> getDocumentList(HashMap<String, Object> paraMap);	// 결재번호로 groupno와 cateory_seq 알아오기

	void deleteTripTable(String groupno);	// 반려된 휴가/출장 정보 삭제하기

	void deleteSalesTable(String groupno);	// 반려된 매출 정보 삭제하기

	void deleteEquipmentTable(String groupno);	// 반려된 비품 구매 정보 삭제하기

	void deleteProjectTable(String groupno);	// 반려된 프로젝트 정보 삭제하기

	void deleteFireTable(String groupno);	// 반려된 퇴사 정조 삭제하기

	void deleteTATable(String groupno);	// 반려된 인사고과 정보 삭제하기

	void deleteClubTable(String groupno);	// 반려된 동호회 정보 삭제하기

	void deleteClubMemberTable(String groupno);	// 반려된 동호회 회원 정보 삭제하기

	void updateStatusDocmenetTable2(HashMap<String, Object> paraMap);	// 결재 완료 테이블에 status 업데이트 하기

	List<DocumentVO> getDocumentList2(HashMap<String, Object> paraMap);	// 전체 결재 완료된 groupno와 cateory_seq 알아오기

	void updateDocumentStatus(HashMap<String, Object> paraMap);	// 전체 결재 완료된 테이블 documentStatus 업데이트하기

	List<TripVO> getTripList();	// 휴가/출장을 시작한 사람과 끝난 사람을 알아오이

	void getUpdateEmployeeStatusVacation(String employee_seq);	// 휴가 시작한 사람 업데이트하기

	void getUpdateEmployeeStatusBusiness(String employee_seq);	// 출장 시작한 사람 업데이트하기

	void getUpdateEmployeeStatusDefault(String employee_seq);	// 휴가/출장 끝난 사람들 업데이트하기

	void updateFireDate(HashMap<String, Object> paraMap);	// 퇴사 날짜 업데이트하기

	List<EmployeesVO> employeeList();	// 퇴사날짜가 있는 사원 얻어오기

	void getUpdateEmployeeStatusFire(String employee_seq);	// 퇴사인 사람들 업데이트하기

	List<EmployeesVO> getAllEmployeeList();	// 모든 사원 정보 가져오기

	EmployeesVO getOneEmployee(String employee_seq);	// 회원번호로 회원정보 가져오기

}
