<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

		<!-- Header -->
		<c:import url="/WEB-INF/views/includes/header.jsp"></c:import>
		<!-- /Header -->

		<!-- Main Section -->
            <section id="main">
                <!-- Title, Breadcrumb -->
                <div class="breadcrumb-wrapper">
                    <div class="pattern-overlay">
                        <div class="container">
                            <div class="row">
                                <div class="col-lg-6 col-md-6 col-xs-12 col-sm-6">
                                    <h2 class="title">마이페이지</h2>
                                </div>
                                <div class="col-lg-6 col-md-6 col-xs-12 col-sm-6">
                                    <div class="breadcrumbs pull-right">
                                        <ul>
                                            <li>You are Now on:</li>
                                            <li><a href="${pageContext.request.contextPath}/mypage/history">마이페이지</a></li>
                                            <li><a href="${pageContext.request.contextPath}/mypage/collect/video">내가 올린 영상</a></li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- /Title, Breadcrumb -->
                
                <!-- Main Content -->
                <div class="content margin-top60 margin-bottom60">
                    <div class="container">
                        <div class="row">
                            <div class="sidebar col-lg-3 col-md-3 col-sm-3 col-xs-12">
                                <!-- Left nav Widget Start -->
                                <div class="widget category">
                                    <h3 class="title">My page</h3>
                                    <ul class="category-list slide">
                                        <li><a href="${pageContext.request.contextPath}/mypage/history">진단 히스토리</a></li>
                                        <li><a href="${pageContext.request.contextPath}/mypage/videoclip">영상 관리</a></li>
                                        <li><a href="${pageContext.request.contextPath}/mypage/collect/comment">내가 작성한 댓글</a></li>
                                        <li><a href="${pageContext.request.contextPath}/mypage/collect/video">내가 올린 영상</a></li>
                                        <li><a href="${pageContext.request.contextPath}/mypage/collect/scrap">스크랩 영상</a></li>
                                        <li><a href="${pageContext.request.contextPath}/mypage/beforemodify">회원 정보 수정</a></li>
                                    </ul>
                                </div>
                                <!-- Left nav Widget End -->
                            </div>
                            <!-- Sidebar End -->
                            
                    <!-- 내용 부분 -->
                    <div class="posts-block col-lg-9 col-md-9 col-sm-9 col-xs-12">
                    <h2>내가 올린 영상</h2>
                     <div class="product-grid">
                                    <div class="products-block">
                                        <div class="row product-items">
                                            
                            <div>
                                <!-- post item -->
								<c:forEach items="${videoMap.postList}" var="postVo"> 
                                
                                <div class="col-lg-4 col-md-4 col-sm-4 col-xs-12 product-cols first post-item wow fadeInUp">
                                    <div class="post-img">
                                        <a href="${pageContext.request.contextPath}/post/soiread/${postVo.postNo}"><img alt="" src="${pageContext.request.contextPath}/upload/${postVo.videoThumnail}"></a>
                                    </div>
                                    <div class="post-content blog-post-content" style='padding:10px'>
                                        <h4 style='white-space:nowrap; overflow:hidden; text-overflow:ellipsis;'><a href="${pageContext.request.contextPath}/post/soiread/${postVo.postNo}" style='color:#000000; vertical-align:middle;'>${postVo.postTitle}</a></h4>
                                    </div>
                                    <div class="meta post-meta">
                                        <div class="post-date post-meta-content">
                                            <i title="${postVo.postDate}" class="fa fa-clock-o"></i>
                                        </div>
                                        <div class="post-comment post-meta-content">
                                            <a title="Comments" style='color:#000000'><i class="fa fa-comment-o"></i>${postVo.postCmtCnt}</a>
                                        </div>
                                        <div class="post-like  post-meta-content">
                                            <a title="Likes" style='color:#000000'><i class="fa fa-heart"></i>${postVo.postSoiCnt}</a>
                                        </div>
                                        <div class="post-link post-meta-content">
                                            <a title="Hits" style='color:#000000'><i class="fa fa-user fa-2x"></i>${postVo.postHitCnt}</a>
                                        </div>
                                    </div>
                                </div>
                                
                                </c:forEach>
                             </div>
                             </div>
                                <!-- /post item --> 
                                <div class="pagination-centered padding-bottom30">
								<ul class="pagination">
									<c:if test="${videoMap.prev}"> <!-- 이 값이 false라면 prev 실행 x -->
									<li><a href="${pageContext.request.contextPath}/mypage/collect/video?crtPage=${videoMap.startPageBtnNo-1}">«</a></li>
									</c:if>
						
									<c:forEach begin="${videoMap.startPageBtnNo}" end="${videoMap.endPageBtnNo}" var="idx">
										<li><a href="${pageContext.request.contextPath}/mypage/collect/video?crtPage=${idx}" style="<c:out value="${videoMap.crtPage == idx?'color :#FF0000':' '}"/>">${idx}</a></li>
									</c:forEach>
						
									<c:if test="${videoMap.next}"> <!-- 이 값이 false라면 next 실행 x -->
										<li><a href="${pageContext.request.contextPath}/mypage/collect/video?crtPage=${videoMap.endPageBtnNo+1}">»</a></li>
									</c:if>
								</ul>
							</div>
      					</div>
                    </div>
                    </div>
                </div>
            </div>
        </div>
        </section>
        <!-- /Main Section -->


			<!-- Footer -->
            <c:import url="/WEB-INF/views/includes/footer.jsp"></c:import>
            <!-- /Footer -->


</body>
</html>