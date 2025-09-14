<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>회원가입</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <style>
        body {
            background-color: #f8f9fa;
        }
        .container {
            max-width: 600px;
            margin-top: 50px;
            margin-bottom: 50px;
            padding: 30px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }
        .form-label {
            font-weight: bold;
        }
        .text-feedback {
            font-size: 0.875em;
            color: #dc3545; /* Bootstrap's red color for error messages */
            display: none;
            margin-top: 0.25rem;
        }
        .reg-buttons {
            display: flex;
            gap: 10px;
            justify-content: center;
        }
    </style>
</head>
<body>

<div class="container">
    <h3 class="text-center mb-4">회원 가입 정보 입력</h3>
    <form action="/members/register" method="post" id="registerForm">
        
        <div class="row mb-3">
            <label for="userId" class="col-sm-3 col-form-label">아이디</label>
            <div class="col-sm-6">
                <input type="text" class="form-control" id="userId" name="id" placeholder="아이디를 입력하세요.">
            </div>
            <div class="col-sm-3 d-grid">
                <button type="button" class="btn btn-outline-primary" id="checkIdDuplBtn">중복확인</button>
            </div>
            <div class="col-sm-9 offset-sm-3">
                <small class="text-feedback" id="idFeedback">아이디는 4~12자의 소문자, 숫자, _만 가능합니다.</small>
                <small class="text-success text-feedback" id="idDuplSuccess">사용 가능한 아이디입니다.</small>
                <small class="text-danger text-feedback" id="idDuplFail">이미 사용 중인 아이디입니다.</small>
            </div>
        </div>
        
        <div class="row mb-3">
            <label for="userPw" class="col-sm-3 col-form-label">비밀번호</label>
            <div class="col-sm-9">
                <input type="password" class="form-control" id="userPw" name="pw" placeholder="비밀번호를 입력하세요." required>
                <small class="text-feedback" id="pwFeedback">영문, 숫자, 특수문자를 포함하여 8~16자로 입력하세요.</small>
            </div>
        </div>
        
        <div class="row mb-3">
            <label for="userPwCheck" class="col-sm-3 col-form-label">비밀번호 확인</label>
            <div class="col-sm-9">
                <input type="password" class="form-control" id="userPwCheck" placeholder="비밀번호를 다시 입력하세요." required>
                <small class="text-feedback" id="pwCheckFeedback">입력된 비밀번호가 서로 다릅니다.</small>
            </div>
        </div>
        
        <div class="row mb-3">
            <label for="userName" class="col-sm-3 col-form-label">이름</label>
            <div class="col-sm-9">
                <input type="text" class="form-control" id="userName" name="name" placeholder="이름을 입력하세요.(한글 2~6자)" required>
            </div>
        </div>
        
        <div class="row mb-3">
            <label for="userPhone" class="col-sm-3 col-form-label">전화번호</label>
            <div class="col-sm-9">
                <input type="tel" class="form-control" id="userPhone" name="phone" placeholder="전화번호를 입력하세요. (010-1234-5678)" required>
            </div>
        </div>
        
        <div class="row mb-3">
            <label for="userEmail" class="col-sm-3 col-form-label">이메일</label>
            <div class="col-sm-9">
                <input type="email" class="form-control" id="userEmail" name="email" placeholder="이메일을 입력하세요." required>
            </div>
        </div>
        
        <div class="row mb-3">
            <label for="userZipCode" class="col-sm-3 col-form-label">우편번호</label>
            <div class="col-sm-6">
                <input type="text" class="form-control" id="userZipCode" name="zipCode" placeholder="우편번호" readonly required>
            </div>
            <div class="col-sm-3 d-grid">
                <button type="button" class="btn btn-outline-dark" onclick="searchPostcode()">찾기</button>
            </div>
        </div>
        
        <div class="row mb-3">
            <label for="userAddress1" class="col-sm-3 col-form-label">주소</label>
            <div class="col-sm-9">
                <input type="text" class="form-control" id="userAddress1" name="address1" placeholder="주소" readonly required>
            </div>
        </div>
        
        <div class="row mb-4">
            <label for="userAddress2" class="col-sm-3 col-form-label">상세주소</label>
            <div class="col-sm-9">
                <input type="text" class="form-control" id="userAddress2" name="address2" placeholder="상세주소를 입력하세요." required>
            </div>
        </div>
        
        <div class="reg-buttons">
            <button type="button" class="btn btn-outline-secondary" onclick="history.back()">돌아가기</button>
            <button type="reset" class="btn btn-outline-danger">다시입력</button>
            <button type="submit" class="btn btn-primary">회원가입</button>
        </div>
    </form>
</div>

<script>
    // 다음 우편번호 찾기 API
    function searchPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                document.getElementById('userZipCode').value = data.zonecode;
                document.getElementById('userAddress1').value = data.address;
                document.getElementById('userAddress2').focus();
            }
        }).open();
    }
    const idRegex = /^[A-Za-z0-9]{6,12}$/;
 // 비밀번호: 8~16자, 특수문자 1회 이상 포함
 const passwordRegex = /^(?=.*[^\w\s]).{8,16}$/;
 // 이메일: @ 포함
 const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
 // 이름: 한글 2~6자
 const nameRegex = /^[가-힣]{2,6}$/;
 // 전화번호: 010-0000-0000 형식
 const phoneRegex = /^010-?\d{4}-?\d{4}$/;

 


 $(document).ready(function() {
     // 폼 제출 이벤트
     $("#registerFrm").on("submit", function (event) {
         // 모든 유효성 검사 수행
         if (!checkAllValidation()) {
             event.preventDefault(); // 유효성 검사 실패 시 폼 제출 막기
         }
     });

     // 아이디 입력 필드 이벤트
     $("[name='id']").on("keyup", function() {
         // 아이디가 변경되면 중복확인 상태 초기화
         isIdDuplChecked = false;
         $("#checkIdDupl").css("display", "block").text("아이디 중복확인을 해주세요.");
         $("#checkIdDupl").removeClass("text-success text-danger");
     });

     

     // 모든 유효성 검사 함수
     function checkAllValidation() {
         const idVal = $("[name='id']").val();
         const nameVal = $("[name='name']").val();
         const phoneVal = $("[name='phone']").val();
         const emailVal = $("[name='email']").val();
         
         // 아이디 검사
         if (!idRegex.test(idVal)) {
             alert("아이디 형식이 올바르지 않습니다.");
             $("[name='id']").focus();
             return false;
         }
         if (!isIdDuplChecked) {
             alert("아이디 중복확인을 해주세요.");
             return false;
         }
         if (!isIdAvailable) {
             alert("이미 사용 중인 아이디입니다.");
             return false;
         }

         // 비밀번호 검사
         if (!checkPassword()) {
             alert("비밀번호를 다시 확인해주세요.");
             return false;
         }
         
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

     // 비밀번호와 비밀번호 확인 일치 및 규칙 검사 함수
     function checkPassword() {
         const passwordVal = $("[name='pw']").val();
         const passwordCheckVal = $("[name='pwCheck']").val();

         // 비밀번호 규칙 검사
         if (passwordVal.length > 0 && !passwordRegex.test(passwordVal)) {
             $("#passwordRule").css("display", "block").text("패스워드는 특수문자를 1회 이상 포함하여 8~16자로 입력해야 합니다.");
             $("#passwordDuplicate").css("display", "none");
             return false;
         } else {
             $("#passwordRule").css("display", "none");
         }

         // 비밀번호 일치 검사
         if (passwordCheckVal.length > 0 && passwordVal !== passwordCheckVal) {
             $("#passwordDuplicate").css("display", "block").text("입력된 패스워드가 서로 다릅니다.");
             return false;
         } else {
             $("#passwordDuplicate").css("display", "none");
         }

         // 모두 통과
         return true;
     }

     // 다음 우편번호 찾기 API
     window.searchPostcode = function() {
         new daum.Postcode({
             oncomplete: function(data) {
                 $("[name='zipCode']").val(data.zonecode);
                 $("[name='address1']").val(data.address);
                 $("[name='address2']").focus();
             }
         }).open();
     };

     // 스페이스바 입력 방지 (비밀번호 필드)
     $("[name='pw'], [name='pwCheck']").on("keydown", function(event) {
         if (event.key === ' ' || event.keyCode === 32) {
             event.preventDefault();
         }
     });

 });
    
 $("#checkIdDuplBtn").on("click",()=> {
	 $.ajax({
			url:"/members/ajax",
			data: { userId: $("#userId").val() }
			//2.dataType : json
		})
		.done((isDuplicated) => {
			console.log(isDuplicated);
			  // 일단 다 숨기고 시작
			  $(".text-feedback").hide();

			  if (isDuplicated) {
			    // 이미 사용 중
			    $("#idDuplFail").show();
			  } else {
			    // 사용 가능
			    $("#idDuplSuccess").show();
			  }
			});
 });
    
</script>

</body>
</html>