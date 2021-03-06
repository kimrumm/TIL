<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@ include file="/WEB-INF/views/layout/header.jsp"%>
<title>Insert title here</title>
</head>
<body>
	<div class="container">
		<form id="commentForm" name="commentForm" method="post">
			<input type="hidden" name="postIdx" value="${boardContent.postIdx}"> <br> <br>
			<div>
				<div>
					<span><strong>Comments</strong></span> <span id="cCnt"></span>
				</div>
				<div>
					<table class="table">
						<tr>
							<td>
								<textarea style="width: 1100px" rows="3" cols="30" id="cmContent" name="cmContent" placeholder="댓글을 입력하세요"></textarea>
								<br>
								<input type="text" style="width: 300px" id="cmWriter" name="cmWriter" placeholder="닉네임을 입력하세요"></textarea>
								<div>
									<a href='#' onClick="fn_comment('${result.code}')" class="btn pull-right btn-success">등록</a>
								</div>
							</td>
						</tr>
					</table>
				</div>
			</div>
			<input type="hidden" id="b_code" name="b_code" value="${result.code}" />
		</form>
	</div>
	<div class="container">
		<form id="commentListForm" name="commentListForm" method="post">
			<div id="commentList"></div>
		</form>
	</div>

	<script>
/*
 * 댓글 등록하기(Ajax)
 */
function fn_comment(code){
    
    $.ajax({
        type:'POST',
        url : "<c:url value='/board/insertComm'/>",
        data:$("#commentForm").serialize(),
        success : function(data){
            if(data=="1")
            {
                getCommentList();
                $("#cmContent").val(""); /* 등록 후 초기화 하기 */
                $("#cmWriter").val(""); /* 등록 후 초기화 하기 */
            }
        },
        error:function(request,status,error){
            //alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
       }
        
    });
}
 
/**
 * 초기 페이지 로딩시 댓글 불러오기
 */
$(function(){
    
    getCommentList();
    
   
    
});

 
/**
 * 댓글 불러오기(Ajax)
 */
function getCommentList(){
    
    $.ajax({
        type:'GET',
        url : "<c:url value='/board/selectCommList'/>",
        dataType : "json",
        data:$("#commentForm").serialize(), /* 자주쓰는 기억하기 */
        contentType: "application/x-www-form-urlencoded; charset=UTF-8", 
        success : function(data){
        	console.log(data);
            
            var html = "";
            var cCnt = data.length;
            
            if(data.length > 0){
                
                for(i=0; i<data.length; i++){
                    html += "<div>";
                    html += "<div><table class='table'><h6><strong>"+data[i].cmWriter+"</strong></h6>";
                    html += data[i].cmContent + "<tr><td></td></tr>";
                    html += "</table></div>";
                    html += "</div>";
                }
                
            } else {
                
                html += "<div>";
                html += "<div><table class='table'><h6><strong>등록된 댓글이 없습니다.</strong></h6>";
                html += "</table></div>";
                html += "</div>";
                
            }
            
            $("#cCnt").html(cCnt);
            $("#commentList").html(html);
            
        },
        error:function(request,status,error){
            
       }
        
    });
}
 
</script>

</body>
</html>