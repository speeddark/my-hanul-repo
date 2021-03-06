<%@page import="java.util.Date"%>


<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!-- tiles 라이브러리를 사용할 수 있도록 선언 -->
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:choose>
	<c:when test="${category eq 'cu' }"><c:set var="title" value="고객관리"/></c:when>
	<c:when test="${category eq 'hr' }"><c:set var="title" value="사원정보"/></c:when>
	<c:when test="${category eq 'no' }"><c:set var="title" value="공지사항"/></c:when>
	<c:when test="${category eq 'bo' }"><c:set var="title" value="방명록"/></c:when>
	<c:when test="${category eq 'da' }"><c:set var="title" value="공공데이터"/></c:when>
	<c:when test="${category eq 'join' }"><c:set var="title" value="회원가입"/></c:when>
</c:choose>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>IoT 과정 > ${title}</title>
<style type="text/css">
	#wrap{
		display: flex; flex-direction: column; height: 100%
	}
</style>
<link rel="icon" type="image/x-icon" href="imgs/hanul.ico" />
<link rel="stylesheet" type="text/css" href="css/common.css?v=<%=new Date().getTime() %>" >
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
	<div id="wrap">
		<tiles:insertAttribute name="header"/>
		<div id="content">
		<tiles:insertAttribute name="content"/>
		</div>
		<tiles:insertAttribute name="footer"/>
	</div>
<body>

</body>
</html>