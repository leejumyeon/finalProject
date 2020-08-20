package com.spring.groupware.leeeh.model;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.spring.groupware.commonVO.AttendanceVO;
import com.spring.groupware.commonVO.ClubVO;
import com.spring.groupware.commonVO.DepartmentVO;
import com.spring.groupware.commonVO.DocumentCategoryVO;
import com.spring.groupware.commonVO.DocumentVO;
import com.spring.groupware.commonVO.EmployeesVO;
import com.spring.groupware.commonVO.TimeAndAttVO;
import com.spring.groupware.commonVO.TripVO;

@Repository
public class LeeehDAO implements InterLeeehDAO {

	@Resource
	private SqlSessionTemplate sqlsession;

	// === 로그인 페이지에서 적은 ID와 비밀번호를 통해 유저가 존재하는지 검사하기 === //
	@Override
	public EmployeesVO isUserExist(HashMap<String, String> paraMap) {

		EmployeesVO loginEmployee = sqlsession.selectOne("leeeh.isUserExist", paraMap);
		
		return loginEmployee;
	}

	// === 사원 발급을 하기위해 사원 ID에서 max값을 가져오기 === //
	@Override
	public String getMaxOfEmployeeId(String hireDate) {

		String max = sqlsession.selectOne("leeeh.getMaxOfEmployeeId", hireDate);
		
		return max;
	}

	// === 사원 발급을 하기 위해 부서리스트를 가져오기 === //
	@Override
	public List<DepartmentVO> departmentList() {

		List<DepartmentVO> departmentList = sqlsession.selectList("leeeh.departmentList");
		
		return departmentList;
	}

	// === 사원발급에서 테이블에 집어 넣기 === //
	@Override
	public void insertEmployeeTable(HashMap<String, String> paraMap) {

		sqlsession.insert("leeeh.insertEmployeeTable", paraMap);
	}

	// === 문서 결재 카테고리 알아오기 === //
	@Override
	public List<DocumentCategoryVO> documentCategoryList() {

		List<DocumentCategoryVO> documentCategoryList = sqlsession.selectList("leeeh.documentCategoryList");
		
		return documentCategoryList;
	}

	// === 문서 결재를 하기위해 문서번호에서 max값을 가져오기 === //
	@Override
	public String getMaxOfGroupno(String regDate) {

		String max = sqlsession.selectOne("leeeh.getMaxOfGroupno", regDate);
		
		return max;
	}

	// === 문서 결재 작성 페이지에서 사원들 정보 불러오기 === //
	@Override
	public List<EmployeesVO> showMemberByDepartment(HashMap<String, String> paraMap) {

		List<EmployeesVO> employeesByDepartList = sqlsession.selectList("leeeh.showMemberByDepartment", paraMap);
		
		return employeesByDepartList;
	}

	// === 클릭한 사원들 결재선에 올리기 === //
	@Override
	public List<EmployeesVO> approvalList(HashMap<String, Object> paraMap) {

		List<EmployeesVO> approvalList = sqlsession.selectList("leeeh.approvalList", paraMap);
		
		return approvalList;
	}

	// === 휴가 종류 받아오기 === //
	@Override
	public List<HashMap<String, String>> tripCatListOfVacation() {

		List<HashMap<String, String>> tripCatList = sqlsession.selectList("leeeh.tripCatListOfVacation");
		
		return tripCatList;
	}

	// === 출장 종류 받아오기 === //
	@Override
	public List<HashMap<String, String>> tripCatListOfBusiness() {

		List<HashMap<String, String>> tripCatList = sqlsession.selectList("leeeh.tripCatListOfBusiness");
		
		return tripCatList;
	}
	
	// === 문서 결재 테이블에 정보 집어 넣기 === //
	@Override
	public void insertDocumentTable(DocumentVO dvo) {

		sqlsession.insert("leeeh.insertDocumentTable", dvo);
	}

	// === 휴가 정보를 휴가/출장 테이블에 집어 넣기 === //
	@Override
	public void insertTripTableOfVacation(HashMap<String, Object> paraMap) {

		sqlsession.insert("leeeh.insertTripTableOfVacation", paraMap);
	}

	// === 휴가 정보를 휴가/출장 테이블에 집어 넣기 === //
	@Override
	public void insertTripTableOfBusiness(HashMap<String, Object> paraMap) {

		sqlsession.insert("leeeh.insertTripTableOfBusiness", paraMap);
	}

	// === 매출 정보를 매출 테이블에 집어 넣기 === //
	@Override
	public void insertSalesTable(HashMap<String, Object> paraMap) {

		sqlsession.insert("leeeh.insertSalesTable", paraMap);
	}

	// === 비품 구매 정보를 배품 테이블에 집어 넣기 === //
	@Override
	public void insertEquipmentTable(HashMap<String, Object> paraMap) {

		sqlsession.insert("leeeh.insertEquipmentTable", paraMap);
	}

	// === 프로젝트 seq번호 체번해오기 === //
	@Override
	public String getProjectSeq() {

		String project_seq = sqlsession.selectOne("leeeh.getProjectSeq");
		
		return project_seq;
	}

	// === 프로젝트 정보를 프로젝트 테이블에 집어 넣기 === //
	@Override
	public void insertProjectTable(HashMap<String, Object> paraMap) {

		sqlsession.insert("leeeh.insertProjectTable", paraMap);
	}

	// === 프로젝트 명단에 들어갈 사원 번호 받아오기 === //
	@Override
	public String getEmployeeSeq(HashMap<String, Object> paraMap) {

		String employee_seq = sqlsession.selectOne("leeeh.getEmployeeSeq", paraMap);
		
		return employee_seq;
	}

	// === 사원 ID로 사원 번호 알아오기 === //
	@Override
	public String getEmployeeSeqByEmployeeId(String employee_id) {
		
		String employee_seq = sqlsession.selectOne("leeeh.getEmployeeSeqByEmployeeId", employee_id);
		
		return employee_seq;
	}
	
	// === 프로젝트 명단에 집어 넣기 === //
	@Override
	public void insertProjectMemberTable(HashMap<String, Object> paraMap) {

		sqlsession.insert("leeeh.insertProjectMemberTable", paraMap);
	}

	// === 프로젝트 중단 정보를 프로젝트 테이블에 업데이트 하기 === //
	@Override
	public void updateProjectTable(HashMap<String, Object> paraMap) {

		sqlsession.update("leeeh.updateProjectTable", paraMap);
	}

	// === 프로젝트 완료 정보를 프로젝트 테이블에 업데이트 하기 === //
	@Override
	public void updateProjectTableEnd(HashMap<String, Object> paraMap) {

		sqlsession.update("leeeh.updateProjectTableEnd", paraMap);
	}

	// === 퇴사 정보를 퇴사 테이블에 집어 넣기 === //
	@Override
	public void insertFireTable(HashMap<String, Object> paraMap) {

		sqlsession.insert("leeeh.insertFireTable", paraMap);
	}

	// === 근태 정보를 근태관리 테이블에 집어 넣기 === //
	@Override
	public void insertTATable(HashMap<String, Object> paraMap) {

		sqlsession.insert("leeeh.insertTATable", paraMap);
	}

	// === 동호회 정보를 종호회 테이블에 집어 넣기 === //
	@Override
	public void insertClubTable(HashMap<String, Object> paraMap) {

		sqlsession.insert("leeeh.insertClubTable", paraMap);
	}

	// === 클럽 모두 가져오기 === //
	@Override
	public List<ClubVO> clubList() {

		List<ClubVO> clubList = sqlsession.selectList("leeeh.clubList");
		
		return clubList;
	}

	// === 동호회 명단 정보 테이블에 집어 넣기 === //
	@Override
	public void insertClubMemberTable(HashMap<String, Object> paraMap) {

		sqlsession.insert("leeeh.insertClubMemberTable", paraMap);
	}

	// === 클럽 번호 채번해오기 === //
	@Override
	public String getClubSeq() {
		
		String club_seq = sqlsession.selectOne("leeeh.getClubSeq");
		
		return club_seq;
	}

	// === 클럽 회장 정보 넣기 === //
	@Override
	public void insertClubMemberTableOfManager(HashMap<String, Object> paraMap) {

		sqlsession.insert("leeeh.insertClubMemberTableOfManager", paraMap);
	}

	// === 클럽 지우기 === //
	@Override
	public void deleteClub(HashMap<String, Object> paraMap) {

		sqlsession.update("leeeh.deleteClub", paraMap);
	}

	// === 문서 결재 신청자의 List 얻어오기 === //
	@Override
	public List<DocumentVO> regDocumentList(String fk_employee_seq) {

		List<DocumentVO> regDocumentList = sqlsession.selectList("leeeh.regDocumentList", fk_employee_seq);
		
		return regDocumentList;
	}

	// === 문서 상세 내용 보여주기 === //
	@Override
	public HashMap<String, String> goDocumentContent(String document_seq) {
		
		HashMap<String, String> documentContent = sqlsession.selectOne("leeeh.goDocumentContent", document_seq);
		
		return documentContent;
	}

	// === 문서 결재자들 알아오기 === //
	@Override
	public List<DocumentVO> getApproverList(String groupno) {

		List<DocumentVO> approverList = sqlsession.selectList("leeeh.getApproverList", groupno);
		
		return approverList;
	}

	// === 문서 결재 받는 사람의 List 얻어오기 === //
	@Override
	public List<DocumentVO> aproDocumentList(String fk_employee_seq) {

		List<DocumentVO> aproDocumentList = sqlsession.selectList("leeeh.aproDocumentList", fk_employee_seq);
		
		return aproDocumentList;
	}

	// === 신청 완료된 전체 문서 보여주기 === //
	@Override
	public List<DocumentVO> allComDocumentList(String fk_employee_seq) {

		List<DocumentVO> comDocumentList = sqlsession.selectList("leeeh.allComDocumentList", fk_employee_seq);
		
		return comDocumentList;
	}

	// === 신청 완료된 신청한 문서 보여주기 === //
	@Override
	public List<DocumentVO> senComDocumentList(String fk_employee_seq) {

		List<DocumentVO> comDocumentList = sqlsession.selectList("leeeh.senComDocumentList", fk_employee_seq);
		
		return comDocumentList;
	}

	// === 신청 완료된 결재한 문서 보여주기 === //
	@Override
	public List<DocumentVO> recComDocumentList(String fk_employee_seq) {

		List<DocumentVO> comDocumentList = sqlsession.selectList("leeeh.recComDocumentList", fk_employee_seq);
		
		return comDocumentList;
	}

	// === 결재 반려 테이블에 status 업데이트 하기 === //
	@Override
	public void updateStatusDocmenetTable(HashMap<String, Object> paraMap) {
		
		sqlsession.update("leeeh.updateStatusDocmenetTable", paraMap);
	}

	// === 결재번호로 groupno와 cateory_seq 알아오기 === //
	@Override
	public List<DocumentVO> getDocumentList(HashMap<String, Object> paraMap) {

		List<DocumentVO> documentVOList = sqlsession.selectList("leeeh.getDocumentList", paraMap);
		
		return documentVOList;
	}

	// === 반려된 휴가/출장 정보 삭제하기 === //
	@Override
	public void deleteTripTable(String groupno) {

		sqlsession.delete("leeeh.deleteTripTable", groupno);
	}

	// === 반려된 매출 정보 삭제하기 === //
	@Override
	public void deleteSalesTable(String groupno) {

		sqlsession.delete("leeeh.deleteSalesTable", groupno);
	}

	// === 반려된 비품 구매 정보 삭제하기 === //
	@Override
	public void deleteEquipmentTable(String groupno) {

		sqlsession.delete("leeeh.deleteEquipmentTable", groupno);
	}

	// === 반려된 프로젝트 정보 삭제하기 === //
	@Override
	public void deleteProjectTable(String groupno) {

		sqlsession.delete("leeeh.deleteProjectTable", groupno);
	}

	// === 반려된 퇴사 정조 삭제하기 === //
	@Override
	public void deleteFireTable(String groupno) {

		sqlsession.delete("leeeh.deleteFireTable", groupno);
	}

	// === 반려된 인사고과 정보 삭제하기 === //
	@Override
	public void deleteTATable(String groupno) {

		sqlsession.delete("leeeh.deleteTATable", groupno);
	}

	// === 반려된 동호회 정보 삭제하기 === //
	@Override
	public void deleteClubTable(String groupno) {

		sqlsession.delete("leeeh.deleteClubTable", groupno);
	}

	// === 반려된 동호회 회원 정보 삭제하기 === //
	@Override
	public void deleteClubMemberTable(String groupno) {

		sqlsession.delete("leeeh.deleteClubMemberTable", groupno);
	}

	// === 결재 완료 테이블에 status 업데이트 하기 === //
	@Override
	public void updateStatusDocmenetTable2(HashMap<String, Object> paraMap) {

		sqlsession.update("leeeh.updateStatusDocmenetTable2", paraMap);
	}

	// === 전체 결재 완료된 groupno와 cateory_seq 알아오기 === //
	@Override
	public List<DocumentVO> getDocumentList2(HashMap<String, Object> paraMap) {
		
		List<DocumentVO> documentVOList = sqlsession.selectList("leeeh.getDocumentList2", paraMap);
		
		return documentVOList;
	}

	// === 전체 결재 완료된 테이블 documentStatus 업데이트하기 === //
	@Override
	public void updateDocumentStatus(HashMap<String, Object> paraMap) {

		sqlsession.update("leeeh.updateDocumentStatus", paraMap);
	}
	
	// === 휴가/출장을 시작한 사람과 끝난 사람을 알아오이 === //
	@Override
	public List<TripVO> getTripList() {

		List<TripVO> tripEmployeeList = sqlsession.selectList("leeeh.getTripList");
		
		return tripEmployeeList;
	}

	// === 휴가 시작한 사람 업데이트하기 === //
	@Override
	public void getUpdateEmployeeStatusVacation(String employee_seq) {

		sqlsession.update("leeeh.getUpdateEmployeeStatusVacation", employee_seq);
	}

	// === 출장 시작한 사람 업데이트하기 === //
	@Override
	public void getUpdateEmployeeStatusBusiness(String employee_seq) {

		sqlsession.update("leeeh.getUpdateEmployeeStatusBusiness", employee_seq);
	}

	// === 휴가/출장 끝난 사람들 업데이트하기 === //
	@Override
	public void getUpdateEmployeeStatusDefault(String employee_seq) {

		sqlsession.update("leeeh.getUpdateEmployeeStatusDefault", employee_seq);
	}

	// === 퇴사 날짜 업데이트하기 === //
	@Override
	public void updateFireDate(HashMap<String, Object> paraMap) {

		sqlsession.update("leeeh.updateFireDate", paraMap);
	}

	// === 퇴사날짜가 있는 사원 얻어오기 === //
	@Override
	public List<EmployeesVO> employeeList() {

		List<EmployeesVO> fireEmployeeList = sqlsession.selectList("leeeh.employeeList");
		
		return fireEmployeeList;
	}

	// === 퇴사인 사람들 업데이트하기 === //
	@Override
	public void getUpdateEmployeeStatusFire(String employee_seq) {

		sqlsession.update("leeeh.getUpdateEmployeeStatusFire", employee_seq);
	}

	// === 모든 회원 정보 가져오기 === //
	@Override
	public List<EmployeesVO> getAllEmployeeList() {

		List<EmployeesVO> allEmployeeList = sqlsession.selectList("leeeh.getAllEmployeeList");
		
		return allEmployeeList;
	}

	// === 회원번호로 회원정보 가져오기 === //
	@Override
	public EmployeesVO getOneEmployee(String employee_seq) {
		
		EmployeesVO oneEmployee = sqlsession.selectOne("leeeh.getOneEmployee", employee_seq);
		
		return oneEmployee;
	}

	// === 사원 정보 업데이트하기 === //
	@Override
	public void employeeUpdate(HashMap<String, String> paraMap) {

		sqlsession.update("leeeh.employeeUpdate", paraMap);
	}

	// === 사원 grade 업데이트하기 === //
	@Override
	public int updateGrade(HashMap<String, String> paraMap) {

		int result = sqlsession.update("leeeh.updateGrade", paraMap);
				
		return result;
	}

	// === 사원 부서 변경하기 === //
	@Override
	public int updateDepartment(HashMap<String, String> paraMap) {

		int result = sqlsession.update("leeeh.updateDepartment", paraMap);
		
		return result;
	}

	// === 사원 직위 변경하기 === //
	@Override
	public int updatePosition(HashMap<String, String> paraMap) {

		int result = sqlsession.update("leeeh.updatePosition", paraMap);
		
		return result;
	}

	// === 인사고과 리스트 얻어오기 === //
	@Override
	public List<TimeAndAttVO> getTAList() {

		List<TimeAndAttVO> TAList = sqlsession.selectList("leeeh.getTAList");
		
		return TAList;
	}

	// === 결재 현황 모든 결재 리스트 얻어오기 === //
	@Override
	public List<DocumentVO> allDocumentList() {

		List<DocumentVO> allDocumentList = sqlsession.selectList("leeeh.allDocumentList");
		
		return allDocumentList;
	}

	// === 결재 완료된 모든 결재 리스트 얻어오기 === //
	@Override
	public List<DocumentVO> getAllComDocumentList() {

		List<DocumentVO> allComDocumentList = sqlsession.selectList("leeeh.getAllComDocumentList");
		
		return allComDocumentList;
	}

	// === 문서함 휴지통으로 보내기 === //
	@Override
	public void updateDocumentTableStatus(String groupno) {

		sqlsession.update("leeeh.updateDocumentTableStatus", groupno);
	}

	// === 휴지통에 있는 문서들 불러오기 === //
	@Override
	public List<DocumentVO> delDocumentList() {

		List<DocumentVO> delDocumentList = sqlsession.selectList("leeeh.delDocumentList");
		
		return delDocumentList;
	}

	// === 휴지통에 있는 문서 복구하기 === //
	@Override
	public void rollbackDocument(String groupno) {

		sqlsession.update("leeeh.rollbackDocument", groupno);
	}

	// === 휴지통에 있는 문서 영구 삭제하기 === //
	@Override
	public void shiftDelDocument(String groupno) {

		sqlsession.delete("leeeh.shiftDelDocument", groupno);
	}

	// === 모든 클럽 정보 가져오기 === //
	@Override
	public List<HashMap<String, String>> allClubList() {

		List<HashMap<String, String>> clubList = sqlsession.selectList("leeeh.allClubList");
		
		return clubList;
	}

	// === 클럽 회장 업데이트 하기 === //
	@Override
	public void updateClubManager(HashMap<String, Object> paraMap) {

		sqlsession.update("leeeh.updateClubManager", paraMap);
	}

	// === 문서 결재 알람 받아오기 === //
	@Override
	public int getCntOfPayment(String fk_employee_seq) {

		int result = sqlsession.selectOne("leeeh.getCntOfPayment", fk_employee_seq);
		
		return result;
	}

	// === 오늘 처음 로그인 한 건지 알아오기 === //
	@Override
	public String getIsAttendance(HashMap<String, String> paraMap) {

		String fk_employee_seq = sqlsession.selectOne("leeeh.getIsAttendance", paraMap);
		
		return fk_employee_seq;
	}

	// === 출퇴 테이블에 출근 인서트 하기 === //
	@Override
	public int insertAttendanceTable(String fk_employee_seq) {

		int result = sqlsession.insert("leeeh.insertAttendanceTable", fk_employee_seq);
		
		return result;
	}

	// === 출퇴 테이블에 퇴근 업데이트 하기 === //
	@Override
	public int updateAttendanceTable(String fk_employee_seq) {

		int result = sqlsession.update("leeeh.updateAttendanceTable", fk_employee_seq);
		
		return result;
	}

	// === 인사고과 저번달 고과와 이번달 고과, 사유 얻어오기 === //
	@Override
	public TimeAndAttVO getDetailTA(HashMap<String, String> paraMap) {

		TimeAndAttVO detailTA = sqlsession.selectOne("leeeh.getDetailTA", paraMap);
		
		return detailTA;
	}

	// === 부서별 인원 수 % 얻어오기 === //
	@Override
	public List<HashMap<String, String>> getDepartmentMenberCnt() {

		List<HashMap<String, String>> departmentMenberCnt = sqlsession.selectList("leeeh.getDepartmentMenberCnt");
		
		return departmentMenberCnt;
	}

	// === 검색한 사원의 정보 급여정보 알아오기 === //
	@Override
	public EmployeesVO getEmployeeSalary(String employee_seq) {

		EmployeesVO employeeInfo = sqlsession.selectOne("leeeh.getEmployeeSalary", employee_seq);
		
		return employeeInfo;
	}

	// === 출퇴근 테이블 가져오기 === //
	@Override
	public List<AttendanceVO> getAttendenceInfo(String employee_seq) {

		List<AttendanceVO> attendanceList = sqlsession.selectList("leeeh.getAttendenceInfo", employee_seq);
		
		return attendanceList;
	}

}
