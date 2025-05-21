<%@ page language="java" contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="template" uri="http://www.jahia.org/tags/templateLib" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="jcr" uri="http://www.jahia.org/tags/jcr" %>
<%@ taglib prefix="ui" uri="http://www.jahia.org/tags/uiComponentsLib" %>
<%@ taglib prefix="functions" uri="http://www.jahia.org/tags/functions" %>
<%@ taglib prefix="query" uri="http://www.jahia.org/tags/queryLib" %>
<%@ taglib prefix="utility" uri="http://www.jahia.org/tags/utilityLib" %>
<%@ taglib prefix="s" uri="http://www.jahia.org/tags/search" %>
<c:set var="title" value="${currentNode.properties['jcr:title'].string}"/>
<c:set var="items" value="${jcr:getChildrenOfType(currentNode, 'seaddonsnt:statBlock')}"/>

<div class="container-fluid py-5 text-center mt-5 mb-5" style="min-height: 300px; background-color: var(--primary); display: flex; flex-direction: column; justify-content: center; align-items: center;">
	<h2 class="text-white mb-4" style="font-weight: bold;">${title}</h2>
	<div class="row justify-content-center align-items-center w-100">
		<c:forEach items="${items}" var="item" varStatus="status">
			<template:module node="${item}" nodeTypes="seaddonsnt:statBlock" />
		</c:forEach>
	</div>
</div>