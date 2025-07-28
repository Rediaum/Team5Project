<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script>
  $(document).ready(function() {
    // 로그인 폼 제출 처리
    $('#loginForm').submit(function(e) {
      e.preventDefault();

      let email = $('#email').val().trim();
      let pwd = $('#pwd').val().trim();

      // 클라이언트 유효성 검사
      if (!email) {
        alert('이메일을 입력하세요.');
        $('#email').focus();
        return false;
      }

      if (!pwd) {
        alert('비밀번호를 입력하세요.');
        $('#pwd').focus();
        return false;
      }

      // AJAX 로그인 요청
      $.ajax({
        url: '${pageContext.request.contextPath}/loginimpl',
        type: 'POST',
        data: {
          email: email,
          pwd: pwd
        },
        beforeSend: function() {
          $('#loginBtn').prop('disabled', true).html('<i class="fa fa-spinner fa-spin"></i> 로그인 중...');
        },
        success: function(response) {
          // 성공 시 메인 페이지로 리다이렉트
          alert('로그인 성공!');
          window.location.href = '${pageContext.request.contextPath}/';
        },
        error: function(xhr, status, error) {
          // 실패 시 에러 메시지 표시
          alert('로그인에 실패했습니다. 이메일과 비밀번호를 확인하세요.');
          $('#loginBtn').prop('disabled', false).html('<i class="fa fa-sign-in"></i> 로그인');
        }
      });
    });
  });
</script>

<!-- 로그인 섹션 -->
<div class="container">
  <div class="row justify-content-center">
    <div class="col-md-6 col-lg-4">
      <div class="card shadow">
        <div class="card-header text-center">
          <h4><i class="fa fa-lock"></i> 로그인</h4>
        </div>
        <div class="card-body">
          <!-- 로그인 폼 -->
          <form id="loginForm">
            <div class="form-group">
              <label for="email">
                <i class="fa fa-envelope"></i> 이메일
              </label>
              <input type="email" class="form-control" id="email" name="email"
                     placeholder="이메일을 입력하세요" required>
            </div>

            <div class="form-group">
              <label for="pwd">
                <i class="fa fa-lock"></i> 비밀번호
              </label>
              <input type="password" class="form-control" id="pwd" name="pwd"
                     placeholder="비밀번호를 입력하세요" required>
            </div>

            <div class="form-check mb-3">
              <input type="checkbox" class="form-check-input" id="rememberMe">
              <label class="form-check-label" for="rememberMe">
                로그인 상태 유지
              </label>
            </div>

            <button type="submit" id="loginBtn" class="btn btn-primary btn-block">
              <i class="fa fa-sign-in"></i> 로그인
            </button>
          </form>
        </div>

        <div class="card-footer text-center">
          <div class="row">
            <div class="col-6">
              <a href="${pageContext.request.contextPath}/register" class="btn btn-link btn-sm">
                <i class="fa fa-user-plus"></i> 회원가입
              </a>
            </div>
            <div class="col-6">
              <a href="#" class="btn btn-link btn-sm text-muted">
                <i class="fa fa-question-circle"></i> 비밀번호 찾기
              </a>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>