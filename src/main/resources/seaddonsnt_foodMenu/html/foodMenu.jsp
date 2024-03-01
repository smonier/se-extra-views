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
<%--@elvariable id="currentNode" type="org.jahia.services.content.JCRNodeWrapper"--%>
<%--@elvariable id="out" type="java.io.PrintWriter"--%>
<%--@elvariable id="script" type="org.jahia.services.render.scripting.Script"--%>
<%--@elvariable id="scriptInfo" type="java.lang.String"--%>
<%--@elvariable id="workspace" type="java.lang.String"--%>
<%--@elvariable id="renderContext" type="org.jahia.services.render.RenderContext"--%>
<%--@elvariable id="currentResource" type="org.jahia.services.render.Resource"--%>
<%--@elvariable id="url" type="org.jahia.services.render.URLGenerator"--%>

<template:addResources type="css" resources="eventCard.css"/>

<c:set var="date" value="${currentNode.properties['date'].time}"/>
<c:set var="title" value="${currentNode.properties['title'].string}"/>
<c:set var="course" value="${currentNode.properties['course'].string}"/>
<c:set var="type" value="${currentNode.properties['type'].string}"/>
<c:set var="image" value="${currentNode.properties['image'].node}"/>



<c:choose>
    <c:when test="${type == 'veggie'}">
        <c:set var="badgeClass" value="badge badge-success" />
    </c:when>
    <c:when test="${type == 'meat'}">
        <c:set var="badgeClass" value="badge badge-danger" />
    </c:when>
    <c:when test="${type == 'fish'}">
        <c:set var="badgeClass" value="badge badge-info" />
    </c:when>
    <c:otherwise>
        <c:set var="badgeClass" value="badge badge-secondary" />
    </c:otherwise>
</c:choose>


<div class="food-card">
    <div class="food-card_img">
        <img src="${image.url}" alt="">
    </div>
    <div class="food-card_content">
        <div class="food-card_title-section">
            <a href="#!" class="food-card_title">${title}</a>
            <a href="#!" class="food-card_author"><fmt:message key='seaddonsnt_foodMenu.course.${course}'/></a>
        </div>
        <div class="food-card_bottom-section">
            <div class="space-between">
                <div class="pull-right">
                    <span class="${badgeClass}"><fmt:message key='seaddonsnt_foodMenu.type.${type}'/></span>
                </div>
            </div>
            <hr>
            <div class="space-between">
                <div class="food-card_price">
                    <span><fmt:formatDate pattern="dd MMM yyyy" value="${date}"/>
                    </span>
                </div>
                
            </div>
        </div>
    </div>
</div>
