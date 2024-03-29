<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="shortcut icon" type="image/x-icon" href="<%=application.getContextPath()%>/resources/image/favicon.ico" />
<script type="text/javascript"
	src="<%=application.getContextPath()%>/resources/js/jquery-3.4.1.min.js"></script>
<link rel="stylesheet" type="text/css"
	href="<%=application.getContextPath()%>/resources/bootstrap-4.3.1-dist/css/bootstrap.min.css">
<script type="text/javascript"
	src="<%=application.getContextPath()%>/resources/bootstrap-4.3.1-dist/js/bootstrap.min.js"></script>
<script>
	function showPopup(lat, lng) { 
		var url = 'showMap?lat=' + lat + '&lng=' + lng;
		window.open(url, "showMap", "width=800, height=500, left=100, top=50"); 
		}
</script>
<style>
/* 수정 */
div.title {
	float: left;
	box-sizing: border-box;
	width: 100%;
}
.content{
	height: 740px;
	padding: 50px;
	}
#agencyAddressLink {
	color: #398AD7; 
	cursor:pointer;
}
</style>
</head>
<body>
	<jsp:include page="../common/agencyHeader.jsp"></jsp:include>
	<div class="content">
		<div class="title">
				<img style="height: 40px" src="<%=application.getContextPath()%>/resources/image/title/member.png" alt="회원 관리"/>
				<hr style="color: grey; height: 2px;">
			</div>
		<div>
			<table class="table table-sm">
				<thead>
					<tr style="background-color: #dcdcdc">
						<th scope="col">회원 ID</th>
						<th scope="col">보건소 명</th>
						<th scope="col">보건소 주소</th>
						<th scope="col" style="text-align: center;">거리</th>
						<th scope="col" style="text-align: center;">접수 날짜</th>
						<th scope="col" style="text-align: center;">승인</th>
						<th scope="col" style="text-align: center;">거절</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${managementList}" var="mana">
						<tr>
							<td style="vertical-align: middle;">${mana.agency_id}</td>
							<td style="vertical-align: middle;">${mana.agency_name}</td>
							<td style="vertical-align: middle;">
								<a id="agencyAddressLink" onclick="showPopup(${mana.agency_latitude}, ${mana.agency_longitude});">${mana.agency_address}</a>
							</td>
							<td style="vertical-align: middle; text-align: center;"><h6 data-lat="${mana.agency_latitude}" data-lng="${mana.agency_longitude}"> </h6></td>
							<td style="vertical-align: middle; text-align: center;"><fmt:formatDate value="${mana.agency_date}"
									pattern="yyyy-MM-dd" /></td>
							<td style="text-align: center;">
							<c:if test="${mana.agency_status=='N'}">
								<a href="updateManagement?agency_id=${mana.agency_id}"
									class="btn btn-mint">승인</a>
							</c:if>
							<c:if test="${mana.agency_status=='Y'}">
								승인 완료
							</c:if>
							</td>
							<td style="text-align: center;">
							<c:if test="${mana.agency_status=='N'}">
								<a href="deleteManagement?agency_id=${mana.agency_id}"
									class="btn btn-pink">거절</a>
							</c:if>
							</td>
							
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
		<div style="display: flex;">
			<div style="flex-grow: 1; margin: auto; text-align: center;">
				<a href="managementList?pageNo=1" class="btn btn-outline-dark">처음</a>

				<c:if test="${groupNo>1}">
					<a href="managementList?pageNo=${startPageNo-1}"
						class="btn btn-outline-info">이전</a>
				</c:if>

				<div style="display: inline-block;" class="btn-toolbar"
					role="toolbar" aria-label="Toolbar with button groups">
					<div class="btn-group mr-2" role="group" aria-label="First group">
						<c:forEach begin="${startPageNo}" end="${endPageNo}" var="i">
							<c:if test="${pageNo==i}">
								<a href="managementList?pageNo=${i}"
									class="btn btn-light active">${i}</a>
							</c:if>
							<c:if test="${pageNo!=i}">
								<a href="managementList?pageNo=${i}" class="btn btn-light">${i}</a>
							</c:if>
						</c:forEach>
					</div>
				</div>
				<c:if test="${groupNo<totalGroupNum}">
					<a href="managementList?pageNo=${endPageNo+1}"
						class="btn btn-outline-info">다음</a>
				</c:if>
				<a href="managementList?pageNo=${totalPageNum}"
					class="btn btn-outline-dark">맨끝</a>
			</div>
		</div>
	</div>
	<jsp:include page="../common/footer.jsp"></jsp:include>

</body>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=0cef5f118d942254be778baadfb2acb4&libraries=services"></script>
  <script>
  function meter(){

     
      var list = $('h6');
           for(var i = 0; i < list.length; i++){
              var lat = "37.5475514728";
              var lng = "127.1199171344";
              var lat2 = list.eq(i).data("lat");
              var lng2 = list.eq(i).data("lng");
              var result = meter1(lat,lng,lat2,lng2);
              console.log(result);
              $('h6').eq(i).text(result);
 
           }
     
       }
    function meter1(lat,lng,lat2,lng2){
        var polyline = new daum.maps.Polyline({
            path: [
                new daum.maps.LatLng(lat, lng),
                new daum.maps.LatLng(lat2, lng2)
            ]
        });
        var distance = " (약 " + Math.round(polyline.getLength()) + "m)";
        
         return distance;//$("#distance").html("distance");
        
    }
    $(function(){
          meter();
       })
</script>
</html>