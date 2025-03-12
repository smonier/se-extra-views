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
<template:addResources type="css" resources="agencyBanner.css"/>

<c:set var="title" value="${currentNode.properties['jcr:title'].string}"/>
<c:set var="description" value="${currentNode.properties['description'].string}"/>
<c:set var="bgImgNode" value="${currentNode.properties['backgroundImg'].node}"/>
<template:addCacheDependency node="${bgImgNode}"/>
<c:set var="posterImgNode" value="${currentNode.properties['posterImg'].node}"/>
<template:addCacheDependency node="${posterImgNode}"/>

<div class="banner"  style="background-image: url('${bgImgNode.url}');">
    <div class="banner-content">
        <div class="banner-title">${title}</div>
        <div class="banner-description">${description}</div>
    </div>
    <c:if test="${posterImgNode != null}">
        <img src="${posterImgNode.url}" alt="Side Image" class="banner-image"> <!-- Replace with your image -->
    </c:if>
</div>

