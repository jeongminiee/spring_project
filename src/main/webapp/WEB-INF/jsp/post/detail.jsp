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
<title>Insert title here</title>
</head>
<body>
	<div id="wrap">
		<c:import url="/WEB-INF/jsp/include/header.jsp" />
		
		<c:import url="/WEB-INF/jsp/include/menu.jsp" />
		
		<div class="border-top"></div>
		
		<div class="d-flex justify-content-center align-items-center mt-4">
			<div class="timeLine">
				<div class="userInfo d-flex justify-content-between p-2">
					<div>${community.userName }</div>
					<div>
						<c:if test="${community.userId eq userId }">
							<a href="#" class="text-dark morePostBtn" data-toggle="modal" data-target="#PostdeleteModal" data-post-id="${community.id }">
								<i class="bi bi-three-dots mr-2"></i>
							</a>
						</c:if>
					</div>
				</div>
				<div class="border-top"></div>
				<div class="p-2">
					${community.content }
				</div>
				<div class="p-2">
					<c:if test="${not empty community.imagePath }">
						<img src="${community.imagePath }" class="imagePath-size w-100">
					</c:if>
				</div>
				<div class="border-top"></div>
				<div class="d-flex p-2">
					<div class="mr-4">공감하기</div>
					<div>댓글</div>
				</div>
				<div class="border-top"></div>
				
					<c:forEach var="comment" items="${community.commentList }" varStatus="status">					
						<div class="d-flex justify-content-between p-1">
							<div>
								<b>${comment.userName }</b> ${comment.comment }
							</div>
							<div>
								<c:if test="${comment.userId eq userId }">
								<a href="#" class="text-dark moreCommentBtn" data-toggle="modal" data-target="#CommentdeleteModal" data-comment-id="${comment.id }">
									<i class="bi bi-three-dots mr-2"></i>
								</a>
								</c:if>
							</div>
						</div>		
					</c:forEach>
			
				<div class="d-flex">
					<div class="comment-box w-100 d-flex justify-content-center align-items-center" >
						<div>${userName }</div>
						<input type="text" class="form-control col-10" id="commentInput-${community.id }" style="border:none" placeholder="댓글 달기...">
						<button class="btn btn-link btn-sm commentBtn" data-post-id="${community.id }">게시</button>
					</div>
				</div>
			</div>
		</div>
		
	</div>
	
	<div class="modal fade" id="CommentdeleteModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
	  <div class="modal-dialog modal-dialog-centered" role="document">
	    <div class="modal-content">
	      <div class="modal-body text-center">
	        <a href="#" id="commentDeleteBtn">삭제 하기</a>
	      </div>
	    </div>
	  </div>
	</div>
	
	<div class="modal fade" id="PostdeleteModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
	  <div class="modal-dialog modal-dialog-centered" role="document">
	    <div class="modal-content">
	      <div class="modal-body text-center">
	        <a href="#" id="postDeleteBtn">삭제 하기</a>
	      </div>
	    </div>
	  </div>
	</div>
	
	<script>
		$(document).ready(function(){
			$(".commentBtn").on("click", function(){
				var postId = $(this).data("post-id");
				var comment = $("#commentInput-" + postId).val();

				
				if(comment == null || comment == "") {
					alert("댓글을 입력하세요");
					return ;
				}
				
				$.ajax({
					type:"post",
					url:"/post/create_comment",
					data:{"postId":postId, "comment":comment},
					success:function(data) {
						if(data.result == "success") {
							location.reload();
						} else {
							alert("댓글 작성 실패");
						}
					},
					error:function(e) {
						alert("error");
					}	
				});
			});
			
			$(".moreCommentBtn").on("click", function(){
				var commentId = $(this).data("comment-id");
				$("#commentDeleteBtn").data("comment-id", commentId);	
			});
			
			$("#commentDeleteBtn").on("click", function(e){
				e.preventDefault();
				var commentId = $(this).data("comment-id");
				
				$.ajax({
					type:"get",
					url:"/post/delete_comment",
					data:{"commentId":commentId}, 
					success:function(data) {
						if(data.result == "success") {
							location.reload();
						} else {
							alert("실패");
						}
					},
					error:function(e) {
						alert("error");
					}	
					
				});
			});
			
			$(".morePostBtn").on("click", function(){
				var postId = $(this).data("post-id");
				$("#postDeleteBtn").data("post-id", postId);
			});
			
			$("#postDeleteBtn").on("click", function(e){
				e.preventDefault();
				var postId = $(this).data("post-id");
				
				$.ajax({
					type:"get",
					url:"/post/delete_post",
					data:{"postId":postId}, 
					success:function(data) {
						if(data.result == "success") {
							location.reload();
						} else {
							alert("실패");
						}
					},
					error:function(e) {
						alert("error");
					}	
				});
			});
		});
	
	</script>
</body>
</html>