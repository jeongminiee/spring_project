<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">

  	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
  	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
  	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.3.0/font/bootstrap-icons.css">
  	<link rel="stylesheet" href="/css/style.css">
<title>메인</title>
</head>
<body>
	<div id="wrap">
		<c:import url="/WEB-INF/jsp/include/header.jsp" />
		
		<c:import url="/WEB-INF/jsp/include/menu.jsp" />
		
		<div class="border-top"></div>
		<a style="display:scroll;position:fixed;bottom:10px;right:450px;" href="/post/create" title=”top"><img src="/image/write.png" class="writeImage-size"></a>

		<section>
			<c:forEach var="postWithComment" items="${postWithComments }" varStatus="status">
				<div class="d-flex justify-content-center align-items-center p-4">
					<div class="timeLine">
						<div class="userInfo d-flex justify-content-between p-2">
							<div>${postWithComment.community.userName }</div>
							<div>
								<c:if test="${postWithComment.community.userId eq userId }">
									<i class="bi bi-three-dots mr-2"></i>
								</c:if>
							</div>
						</div>
						<div class="d-flex align-items-center ml-2">
							<div class="categoryStyle border-radius mr-2 text-secondary d-flex justify-content-center align-items-center">${postWithComment.community.category }</div>
						</div>
						<div class="text-flow p-2">
							<a href="/post/detail_view?id=${postWithComment.community.id }" class="text-dark">${postWithComment.community.content }</a>						
						</div>
						<div class="p-2">
							<c:if test="${not empty postWithComment.community.imagePath }">
								<img src="${postWithComment.community.imagePath }" class="imagePath-size w-100">
							</c:if>
						</div>
						<div class="border-top"></div>
						<div class="d-flex align-items-center" >
							<div class="mr-4 ml-2 d-flex align-items-center">
								<a href="#" class="sympathyBtn" data-post-id="${postWithComment.community.id }">
									<i class="bi bi-suit-heart mr-1"></i><small class="text-secondary">공감하기</small>
									${postWithComment.existSympathy }
								</a>
							</div>
							<div class="d-flex align-items-center">
							 	<c:choose>
									<c:when test="${postWithComment.commentTotalCount eq 0}" >
										<div class="d-flex align-items-center justify-content-center">
											<i class="bi bi-chat mr-1"></i>
											<a href="/post/detail_view?id=${postWithComment.community.id }"><small class="text-secondary">댓글쓰기</small></a>		
										</div>							
									</c:when>
									<c:otherwise>
										<div class="d-flex align-items-center justify-content-center">
											<i class="bi bi-chat mr-1"></i>
											<a href="/post/detail_view?id=${postWithComment.community.id }"><small class="text-secondary">댓글 ${postWithComment.commentTotalCount }개</small></a>	
										</div>
									</c:otherwise>
								</c:choose>
							</div>			
						</div>
					</div>
				</div>
			</c:forEach>
		
		
		</section>
			
		<c:import url="/WEB-INF/jsp/include/footer.jsp" />
	</div>
	
	<script>
		$(document).ready(function(){		
			$(".sympathyBtn").on("click", function(e){
				e.preventDefault();
				
				var postId = $(this).data("post-id");
				
				$.ajax({
					type:"get",
					url:"/post/sympathy",
					data:{"postId":postId},
					success:function(data) {
						if(data.result == "success"){
							alert("성공")
						} else {
							alert("실패")
						}
					}
				});
			});
		});
	
	</script>
</body>
</html>