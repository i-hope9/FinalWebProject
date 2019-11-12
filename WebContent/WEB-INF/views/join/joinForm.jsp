<%@ page contentType="text/html; charset=UTF-8"%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		<script type="text/javascript" src="<%=application.getContextPath()%>/resources/js/jquery-3.4.1.min.js"></script>
		<link rel="stylesheet" type="text/css" href="<%=application.getContextPath()%>/resources/bootstrap-4.3.1-dist/css/bootstrap.css">
		<script type="text/javascript" src="<%=application.getContextPath()%>/resources/bootstrap-4.3.1-dist/js/bootstrap.min.js"></script>
		<style type="text/css">
			.content{
					height: 1500px;
					padding: 50px;
					}
		</style>
		<script type="text/javascript">
			function checkForm() {
				var result = true;
				//모든 error내용 지우기
				$(".error").text("");
				$(".error").css("color", "red");
				//입력값 검사
				if($("#agency_id").val() == ""){
					$("#agency_idError").text("* 아이디를 입력하세요.");
					result = false;
				}		
				if($("#agency_password").val() == ""){
					$("#agency_passwordError").text("* 비밀번호를 입력하세요.");
					result = false;
				}
				if($("#agency_name").val() == ""){
					$("#agency_nameError").text("* 보건소 이름을 입력하세요.");
					result = false;
				}
				if($("#agency_tel").val() == ""){
					$("#agency_telError").text("* 보건소 전화번호를 입력하세요.");
					result = false;
				}
				if($("#agency_address").val() == ""){
					$("#agency_addressError").text("* 보건소 주소을 입력하세요.");
					result = false;
				}
				if($("#agency_latitude").val() == ""){
					$("#agency_latitudeError").text("* 보건소 위도을 입력하세요.");
					result = false;
				}
				if($("#agency_longitude").val() == ""){
					$("#agency_longitudeError").text("* 보건소 경도을 입력하세요.");
					result = false;
				}
				if($("#manager_id").val() == ""){
					$("#manager_idError").text("* 담당자 사번을 입력하세요.");
					result = false;
				}
				if($("#manager_name").val() == ""){
					$("#manager_nameError").text("* 담당자 이름을 입력하세요.");
					result = false;
				}
				if($("#manager_email").val() == ""){
					$("#manager_emailError").text("* 담당자 이메일을 입력하세요.");
					result = false;
				}
				if($("#manager_tel").val() == ""){
					$("#manager_telError").text("* 담당자 전화번호을 입력하세요.");
					result = false;
				}
				if(!$("#checkbox1").prop("checked")){
					$("#checkbox1Error").text("* 개인정보 동의 해주세요.");
					result = false;
				}
				if(!$("#checkbox2").prop("checked")){
					$("#checkbox2Error").text("* 이용약관 동의 해주세요.");
					result = false;
				}
								
				return result;
								
			}	
			
			function checkAgencyId() {	
				if($("#agency_id").val() == "") {
					$("#agency_idError").text("* 아이디를 입력하세요.");
					$("#agency_idError").css("color", "red");
				}
				if($("#agency_id").val() != "")
				$.ajax({
					url: "checkAgencyId",
					data: {agency_id:$("#agency_id").val()},
					success: function(data) {
						if(data.result) {							
							$("#agency_idError").text("* 사용할 수 있는 아이디 입니다.");
							$("#agency_idError").css("color", "green");
						} else {
							$("#agency_idError").text("* 사용할 수 없는 아이디 입니다.");
							$("#agency_idError").css("color", "red");
						}
					}
					
				});				
			}			
			$(function(){ 
				$("#alert-success").hide(); 
				$("#alert-danger").hide(); 
				$("input").keyup(function(){ 
					var agency_password=$("#agency_password").val(); 
					var agency_password2=$("#agency_password2").val(); 
					if(agency_password != "" || agency_password2 != ""){ 
						if(agency_password == agency_password2){ 
							$("#alert-success").show(); 
							$("#alert-danger").hide(); 
							$("#submit").removeAttr("disabled");
							}else{ 
								$("#alert-success").hide(); 
								$("#alert-danger").show(); 
								$("#submit").attr("disabled", "disabled"); 
								} 
						} 
					}); 
				});				
		</script>
		
		<!-- 지도 검색 -->
		<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
			<script>
			function execDaumPostcode() {
		        new daum.Postcode({
		            oncomplete: function(data) {
		                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

		                // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
		                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
		                var roadAddr = data.roadAddress; // 도로명 주소 변수
		                var extraRoadAddr = ''; // 참고 항목 변수

		                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
		                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
		                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
		                    extraRoadAddr += data.bname;
		                }
		                // 건물명이 있고, 공동주택일 경우 추가한다.
		                if(data.buildingName !== '' && data.apartment === 'Y'){
		                   extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
		                }
		                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
		                if(extraRoadAddr !== ''){
		                    extraRoadAddr = ' (' + extraRoadAddr + ')';
		                }

		                // 우편번호와 주소 정보를 해당 필드에 넣는다.
		                document.getElementById('postcode').value = data.zonecode;
		                document.getElementById("roadAddress").value = roadAddr;
		                //document.getElementById("jibunAddress").value = data.jibunAddress;
		                
		                // 참고항목 문자열이 있을 경우 해당 필드에 넣는다.
		                if(roadAddr !== ''){
		                    document.getElementById("extraAddress").value = extraRoadAddr;
		                } else {
		                    document.getElementById("extraAddress").value = '';
		                }

		                var guideTextBox = document.getElementById("guide");
		                // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
		                if(data.autoRoadAddress) {
		                    var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
		                    guideTextBox.innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';
		                    guideTextBox.style.display = 'block';

		                } else if(data.autoJibunAddress) {
		                    var expJibunAddr = data.autoJibunAddress;
		                    guideTextBox.innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';
		                    guideTextBox.style.display = 'block';
		                } else {
		                    guideTextBox.innerHTML = '';
		                    guideTextBox.style.display = 'none';
		                }
		                
		                var agencyAddr = roadAddr + " " + extraRoadAddr;
		                document.getElementById("agency_address").value = agencyAddr;
		            }
		        }).open();
		    }
			
			
			</script>
			
			
	</head>
	<body>
		<jsp:include page="../common/header.jsp"></jsp:include>
		<div class="content">
			<img style="height: 40px" src="<%=application.getContextPath()%>/resources/image/title/join.png" alt="회원가입"/>
			<hr style="color: grey; height: 2px;">
			<form method="post" action="joinSuccess" onsubmit="return checkForm()">
	  			<div class="form-row">
	    			<div class="form-group col-md-6">
	      				<label for="agency_id">아이디</label>
	      				<div class="input-group mb-3">		  	
	  				<input id="agency_id" name="agency_id" type="text" class="form-control" placeholder="아이디를 입력하세요." >
	  				<div class="input-group-append">
	    				<input onclick="checkAgencyId()" type="button" class="btn btn-outline-mint" value="중복확인"/>   				
	  		   		</div>
	  		   		
			  		</div>
			  		<span id="agency_idError" class="error" style="color:red"></span>
	    			</div>
	    			
	    		</div>
	    	
		    	<div class="form-row">
		    		<div class="form-group col-md-6">
		     		 	<label for="agency_password">비밀번호</label>
		 	      		<input id="agency_password" name="agency_password" type="password" class="form-control" placeholder="비밀번호">
		    			   			
		    		</div>
		    		<div class="form-group col-md-6">
		      			<label for="agency_password2">비밀번호 재확인</label>	    
		      			<input id="agency_password2" name="agency_password2" type="password" class="form-control" placeholder="비밀번호 재확인">
		      			<div class="alert alert-success" id="alert-success">비밀번호가 일치합니다.</div>
		      			<div class="alert alert-danger" id="alert-danger">비밀번호가 일치하지 않습니다.</div>
		    			</div>
		    		</div>
		  		
		  		
		  		<div class="form-row">
		    		<div class="form-group col-md-6">
		     		 	<label for="agency_name">보건소 이름</label>
		      			<input id="agency_name" name="agency_name" type="text" class="form-control" placeholder="보건소 이름을 입력하세요.">
		    			<span id="agency_nameError" class="error" style="color:red"></span>
		    		</div>	    		
		    		<div class="form-group col-md-6">
		      			<label for="agency_tel">보건소 전화번호</label>
		      			<input id="agency_tel" name="agency_tel" type="text" class="form-control" placeholder="보건소 전화번호를 입력하세요.">
		    			<span id="agency_telError" class="error" style="color:red"></span>
		    		</div>	    		
		  		</div>
		  		
		  		<div class="form-row">
		  			<div class="form-group col-md-6">
		  				<label>주소 </label> <br/>
				  		<input type="text" id="postcode" placeholder="우편번호">
						<input type="button" onclick="execDaumPostcode()" value="우편번호 찾기" class="btn btn-outline-mint"><br>
						<div style="margin-top: 5px;">
							<input style="width: 300px" type="text" id="roadAddress" placeholder="도로명주소"> <!-- roadAddr -->
							<span id="guide" style="color:#999; display:none"></span>	
							<input style="width: 200px" type="text" id="extraAddress" placeholder="나머지주소"><!-- extraAddr -->
						</div>
						<input style="width: 505px; margin-top: 5px;" type="text" id="agency_address" name="agency_address" value=""> <!-- agencyAddr -->
					
					 </div>	
				</div>
				
		  		<div class="form-row" >
				    <input type="button" value="위도, 경도 설정" onclick="SearchLatLng()" class="btn btn-outline-dark"/>    
				    <h6 style="margin-top: 8px; margin-left: 3px">👈버튼을 클릭한 후, 드론의 착륙 지점을 지도에서 클릭하여 주십시오.</h6>
				</div>
				
				<div id="map" style="width:50%;height:350px;"></div>
				<div class="form-row">
				    <div class="form-group col-md-6">
				      	<label for="agency_latitude">위도</label>
				      	<input id="agency_latitude" name="agency_latitude" type="text" class="form-control" placeholder="드론 착륙 위도">
		    			<span id="agency_latitudeError" class="error" style="color:red"></span>
				    </div>
				    <div class="form-group col-md-6">
				      	<label for="agency_longitude">경도</label>
				      	<input id="agency_longitude" name="agency_longitude" type="text" class="form-control" placeholder="드론 착륙 경도">
		    			<span id="agency_longitudeError" class="error" style="color:red"></span>
				    </div>			    
				</div>	  		  		
		  		<div class="form-row">
		    		<div class="form-group col-md-6">
		     		 	<label for="manager_id">담당자 사번</label>	      			
		      			<input id="manager_id" name="manager_id" type="text" class="form-control" placeholder="담당자 사번을 입력하세요.">
						<span id="manager_idError" class="error" style="color:red"></span>	    		
		    		</div>
		    		<div class="form-group col-md-6">
		      			<label for="manager_name">담당자 이름</label>
		      			<input id="manager_name" name="manager_name" type="text" class="form-control" placeholder="담당자 이름을 입력하세요.">
		    			<span id="manager_nameError" class="error" style="color:red"></span>
		    		</div>
		  		</div>
		  		
		  		<div class="form-row">
		    		<div class="form-group col-md-6">
		     		 	<label for="manager_email">담당자 이메일</label>
		      			<input id="manager_email" name="manager_email" type="email" class="form-control" placeholder="담당자 이메일을 입력하세요.">
		    			<span id="manager_emailError" class="error" style="color:red"></span>
		    		</div>
		    		<div class="form-group col-md-6">
		      			<label for="manager_tel">담당자 전화번호</label>
		      			<input id="manager_tel" name="manager_tel" type="text" class="form-control" placeholder="담당자 전화번호를 입력하세요.">
		    			<span id="manager_telError" class="error" style="color:red"></span>
		    		</div>
		  		</div>
		  		
		    	<div class="form-row">
		    		<div class="form-group col-md-6">
		     		 	<label>개인정보 처리 방침</label>
		      			<textarea class="form-control" rows="4" readonly>개인정보 영구 보관합니다.</textarea>
		      			<div class="form-check form-check-inline">
						  <input class="form-check-input" type="checkbox" id="checkbox1" value="option1">
						  <label class="form-check-label" for="checkbox1">개인정보 동의</label>
						  <span id="checkbox1Error" class="error" style="color:red"></span>
						</div>																
		    		</div>
		    		<div class="form-group col-md-6">
		      			<label>이용 약관</label>
		      			<textarea class="form-control" rows="4" readonly>드론 한대 날리는데 1천만원.</textarea>
		      			<div class="form-check form-check-inline">
						  <input class="form-check-input" type="checkbox" id="checkbox2" value="option1">
						  <label class="form-check-label" for="checkbox2">이용약관 동의</label>
						  <span id="checkbox2Error" class="error" style="color:red"></span>
						</div>
		    		</div>
		    	</div>	
		  		<div class="form-group">
			  		<input type="submit" style="float: right" class="btn btn-pink" value="회원가입"/>
			  	</div>		  			  	
	    	</form>  
			</div>    	
    	
    	

		<jsp:include page="../common/footer.jsp"></jsp:include>
	</body>
</html>