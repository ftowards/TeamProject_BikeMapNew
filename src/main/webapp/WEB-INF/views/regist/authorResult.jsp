<%@ page language="java" contentType="text/html; charset=UTF-8"    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<script>
	toast("${msg}",1500);
	setTimeout(function(){location.href="/home/"},1500);
</script>