<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<table style="margin: auto; text-align: center;" class="table table-sm">
	<thead>
		<tr style="background-color: #dcdcdc">
			<th scope="col">선택</th>
			<th scope="col">의약품 번호</th>
			<th scope="col">이름</th>
			<th scope="col">무게(g)</th>
			<th scope="col">수량</th>
			<th scope="col">담기</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${bloodList}" var="blood">
			<tr>
				<td width="50" style="vertical-align: middle;"><input
					id="checkbox${blood.sup_id}" type="checkbox"
					name="medicineCheckBox" onclick="checkboxClick(${blood.sup_id});">
				</td>
				<td style="vertical-align: middle;">${blood.sup_id}</td>
				<td style="vertical-align: middle; width: auto">${blood.sup_name}</td>
				<td style="vertical-align: middle; width: auto">${blood.sup_weight}</td>
				<td style="vertical-align: middle; width: auto"><input
					id="sup_amount${blood.sup_id}" type="number" class="form-control"
					placeholder="최대 ${blood.sup_amount}개 선택 가능" readonly></td>
				<td style="vertical-align: middle;">
					<button type="button" class="btn btn-outline-info"
						id="completeBtn${blood.sup_id}"
						onclick="completeBtnClick(${blood.sup_id}, $('#sup_amount${blood.sup_id}').val());" disabled>담기</button>
				</td>
			</tr>
		</c:forEach>
	</tbody>
</table>