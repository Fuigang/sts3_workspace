<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta charset="UTF-8">
<title>Title</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<style>
body {
	background-color: #f8f9fa; /* 연한 회색 배경 */
}

.my-page-container {
	width: 100%;
	max-width: 800px;
	margin: 80px auto;
	padding: 25px;
	background-color: #fff;
	border-radius: 8px;
	box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
}

.form-label {
	font-weight: bold;
}
</style>
</head>
<div class="container my-page-container">
	<h3 class="text-center mb-4">마이페이지</h3>
	<hr>

	<div class="row mt-4">
		<!-- 왼쪽 컬럼: 사용자 정보 -->
		<div class="col-md-6">
			<h5>내 정보</h5>
			<form>
				<div class="mb-3 ">
					<label for="userName" class="form-label">이름</label> <input
						type="text" class="form-control" id="userName"
						value="${loginUser.name}" readonly>
				</div>
				<div class="mb-3 ">
					<label for="userPhone" class="form-label">전화번호</label> <input
						type="text" class="form-control" id="userPhone"
						value="${loginUser.phone}" readonly>
				</div>
				<div class="mb-3 ">
					<label for="userEmail" class="form-label">이메일</label> <input
						type="email" class="form-control" id="userEmail"
						value="${loginUser.email}" readonly>
				</div>

				<!-- 우편번호 -->
				<div class="row mb-3">
					<label for="userZipCode" class="col-sm-3 col-form-label">우편번호</label>
					<div class="col-sm-6">
						<input type="text" class="form-control" id="userZipCode"
							name="zipCode" value="${loginUser.zipCode}" readonly>
					</div>
					<div class="col-sm-3 d-grid">
						<button type="button" class="btn btn-outline-dark"
							onclick="searchPostcode()">찾기</button>
					</div>
				</div>

				<!-- 주소 -->
				<div class="row mb-3">
					<label for="userAddress1" class="col-sm-3 col-form-label">주소</label>
					<div class="col-sm-9">
						<input type="text" class="form-control" id="userAddress1"
							name="address1" value="${loginUser.address1}" readonly>
					</div>
				</div>

				<!-- 상세 주소 -->
				<div class="row mb-3 ">
					<label for="userAddress2" class="col-sm-3 col-form-label">상세주소</label>
					<div class="col-sm-9">
						<input type="text" class="form-control" id="userAddress2"
							name="address2" value="${loginUser.address2}" readonly>
					</div>
				</div>

				<div class="d-grid gap-2 mb-3">
					<button id="editInfoBtn" type="button" class="btn btn-secondary">정보수정</button>
					<button id="submitEditBtn" type="button" class="btn btn-primary"
						style="display: none;">수정완료</button>
						<button id="cancelEditBtn" type="button" class="btn btn-danger" style="display: none;">수정 취소</button>
				</div>
			</form>
		</div>

		<!-- 오른쪽 컬럼: 기능 버튼들 -->
		<div class="col-md-6">
			<h5>기능 메뉴</h5>
			<div class="d-grid gap-3">
				<a href="/posts" class="btn btn-primary btn-lg">모든 게시글 보기</a> <a
					href="/members/logout" class="btn btn-outline-dark btn-lg">로그아웃</a>

				<a href="/members/withdraw" class="btn btn-outline-danger btn-lg">회원
					탈퇴</a>
			</div>
		</div>
	</div>
</div>

<!-- Daum Postcode API Script -->
<script
	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
	// Daum Postcode API를 호출하는 함수
	function searchPostcode() {
		new daum.Postcode({
			oncomplete : function(data) {
				// 우편번호와 주소를 필드에 자동 입력
				document.getElementById('userZipCode').value = data.zonecode;
				document.getElementById('userAddress1').value = data.address;
				// 상세 주소 입력 필드에 포커스
				document.getElementById('userAddress2').focus();
			}
		}).open();
	}

	$("#editInfoBtn").on("click", function () {
	    // input에서 readonly 제거
	    $("#userName , #userPhone , #userEmail , #userAddress2").removeAttr("readonly");

	    // 버튼 토글
	    $("#editInfoBtn").hide();
	    $("#submitEditBtn").show();
	});

	// 수정완료 버튼 누르면
	$("#submitEditBtn").on("click", function () {
	    // input에 readonly 다시 설정
	    $("#userName , #userPhone , #userEmail , #userAddress2").attr("readonly", true);

	    // 버튼 토글
	    $("#submitEditBtn").hide();
	    $("#editInfoBtn").show();
	    
	   
	});
	
	$.ajax({
		
	})
	
	
	/* 이따가 수정완료 하고 넣을 거
	// 이메일: @ 포함
	 const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
	 // 이름: 한글 2~6자
	 const nameRegex = /^[가-힣]{2,6}$/;
	 // 전화번호: 010-0000-0000 형식
	 const phoneRegex = /^010-?\d{4}-?\d{4}$/;
	 
	 
	 function checkAllValidation() {
	     const nameVal = $("[name='name']").val();
	     const phoneVal = $("[name='phone']").val();
	     const emailVal = $("[name='email']").val();
	     
	     
	     // 이름 검사
	     if (!nameRegex.test(nameVal)) {
	         alert("이름은 2~6자의 한글만 가능합니다.");
	         $("[name='name']").focus();
	         return false;
	     }
	     
	     // 전화번호 검사
	     if (!phoneRegex.test(phoneVal)) {
	         alert("전화번호 형식이 올바르지 않습니다.");
	         $("[name='phone']").focus();
	         return false;
	     }
	     
	     // 이메일 검사
	     if (!emailRegex.test(emailVal)) {
	         alert("이메일 형식이 올바르지 않습니다.");
	         $("[name='email']").focus();
	         return false;
	     }

	     // 모든 검사 통과
	     return true;
	 }
	 */
</script>
</body>
</html>