<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt"  uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		<script type="text/javascript" src="<%=application.getContextPath()%>/resources/js/jquery-3.4.1.min.js"></script>
		<link rel="stylesheet" type="text/css" href="<%=application.getContextPath()%>/resources/bootstrap-4.3.1-dist/css/bootstrap.min.css">
		<script type="text/javascript" src="<%=application.getContextPath()%>/resources/bootstrap-4.3.1-dist/js/bootstrap.bundle.min.js"></script>
		<script>
			function showPopup() { 
				var url = 'request/showMap?lat=37.4950924317002&lng=127.12253304316587';
				window.open(url, "showMap", "width=1000, height=800, left=100, top=50"); 
				}
		
			function cancelRequest(order_id) {
				$.ajax({
					url : "request/cancelRequest?order_id=" + order_id,
					success : function(data) {
						
					}
				});
			}
		</script>
		<style>
			div.title {
				float: left;
				box-sizing: border-box;    
				width: 100%;
			}
			div.dropdown {
				float: right;
				box-sizing: border-box;
			}
			/* 수정 */
			#content{
				position:relative;
				height: 740px;
				padding: 50px;

				}
			#content .con-box{
				height:100%;
			}
			.form-control{
				text-align: center;
			}	
			#con_bottom{
				width:100%;
				position:absolute;
				bottom:0px;
				margin-bottom:5px;
				text-align:center;
			}
			#bottom_btn{
				display:inline-block;
				margin:auto;
				text-align: center;
			}
			#bottom_btn .submit_btn{
				position:absolute;
				right:100px;
			}
		</style>
	</head>
	<body>
		<jsp:include page="../common/agencyHeader.jsp"></jsp:include>
		
		<div id="content">
		<div class="title">
			<img style="height: 40px" src="<%=application.getContextPath()%>/resources/image/title/request.png" alt="요청게시판"/>
			<hr style="color: grey; height: 2px;">
			<img style="height: 30px; margin-bottom: 10px;" src="<%=application.getContextPath()%>/resources/image/title/request_list.png" alt="요청목록"/>
		</div>
		<div class="con-box"> 
			<table style="margin: auto; text-align:center;" class="table table-sm">
			  <thead>
			    <tr style="background-color:#dcdcdc">
			      <th scope="col">요청 번호 </th>
			      <th scope="col">필요 시간</th>
			      <th scope="col">요청 기관</th>
			      <th scope="col">접수 날짜</th>
			      <th scope="col">배송 상태</th>
			      <th scope="col">접수 취소</th>
			    </tr>
			  </thead>
			  <tbody>
				
 			  <c:forEach items="${requestList}" var="req">
				    <tr>
				      <td style="width:auto; vertical-align:middle"><a href="javascript:popupOpen(${req.order_id});">${req.order_id}</a></td>
				      <td style="width:auto; vertical-align:middle">${req.order_need_time}</td>
				      <td style="width:auto; vertical-align:middle">${req.order_agency_id}</td>
				      <td style="width:auto; vertical-align:middle"><fmt:formatDate pattern="yyyy-MM-dd hh:mm" value="${req.order_date}"></fmt:formatDate></td>
				      <td style="width:auto; vertical-align:middle">
						<c:if test="${req.order_status == 'REQUESTED'}">
							배송 대기
						</c:if> 
						<c:if test="${req.order_status == 'DELIEVERING'}">
							<button type="button" class="btn btn-outline-info" onclick="showPopup()">배송 중</button>
						</c:if>
						<c:if test="${req.order_status == 'DELIEVERED'}">
							배송 완료
						</c:if>
				      </td>
				      <td style="width:auto; vertical-align:middle">
						<c:if test="${req.order_status == 'REQUESTED'}">
							<button type="button" class="btn btn-outline-danger" onclick="cancelRequest(${req.order_id})">취소</button>
						</c:if> 
				      </td>
				    </tr>
				</c:forEach>
			  </tbody>
			</table>
		</div>
		<div id="con_bottom">
			 <div id="bottom_btn">
				<a href="request?pageNo=1" class="btn btn-outline-dark">처음</a>
				
				<c:if test="${groupNo>1}">
					<a href="request?pageNo=${startPageNo-1}" class="btn btn-outline-info">이전</a>
				</c:if>
				
				<div style="display: inline-block;" class="btn-toolbar" role="toolbar" aria-label="Toolbar with button groups">
				  <div class="btn-group mr-2" role="group" aria-label="First group">
				  	<c:forEach begin="${startPageNo}" end="${endPageNo}" var="i">
				  		<c:if test="${pageNo==i}">
				  			<a href="request?pageNo=${i}" class="btn btn-light active">${i}</a>
				  		</c:if>
				  		<c:if test="${pageNo!=i}">
				  		<a href="request?pageNo=${i}" class="btn btn-light">${i}</a>
				  		</c:if>
				  	</c:forEach>
				  </div>
				</div>							
				<c:if test="${groupNo<totalGroupNum}">
					<a href="request?pageNo=${endPageNo+1}" class="btn btn-outline-info">다음</a>
				</c:if>
				<a href="request?pageNo=${totalPageNum}" class="btn btn-outline-dark">맨끝</a>
				<a href="request/totalRequestList" class="btn btn-secondary submit_btn">요청 등록</a>
			</div>
		</div> 
		</div>
		<jsp:include page="../common/footer.jsp"></jsp:include>
	</body>
	<script type="text/javascript">
	function popupOpen(order_id){
		var popUrl = "<%= request.getContextPath()%>/request/medrequest_popuplist?order_id=" + order_id;
		//html을 하나 더 만들어서 목록을 띄움
		var popOption = "width=370, height=360, resizable=no, scrollbars=no, status=no;";    //팝업창 옵션(optoin)
			window.open(popUrl,"",popOption);
		console.log("1")
		}
	</script>
</html>