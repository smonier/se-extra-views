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

<c:set var="startDate" value="${currentNode.properties['startDate'].time}"/>
<c:set var="endDate" value="${currentNode.properties['endDate'].time}"/>
<c:set var="location" value="${currentNode.properties['location'].string}"/>
<c:set var="eventsType" value="${currentNode.properties['eventsType'].string}"/>
<c:set var="teaser" value="${currentNode.properties['teaser'].string}"/>
<c:set var="body" value="${currentNode.properties['body'].string}"/>
<c:set var="image" value="${currentNode.properties['image'].node}"/>
<c:set var="title" value="${currentNode.properties['jcr:title'].string}"/>
<c:set var="description" value="${currentNode.properties['jcr:description'].string}"/>
<jcr:nodeProperty node="${currentNode}" name="j:defaultCategory" var="categories"/>
<c:url value="${currentNode.url}" var="contentURL"/>


<div class="teaser-card mb-2">
    <div class="row g-0">
        <div class="card-image col-md-4">
            <img src="${image.url}" class="img-fluid rounded-start" alt="${image.name}">
        </div>
        <div class="col-md-8">
            <div class="card-content">
                <h6 class="card-title"><a href="${contentURL}">${title}</a></h6>
                <p class="card-text">
                <c:if test="${not empty categories}">
                    <c:forEach items="${categories}" var="category">
                        <span class="badge badge-secondary">${category.node.displayableName}</span>&nbsp;
                    </c:forEach>
                </c:if>
                </p>
                <p class="card-text">${functions:abbreviate(functions:removeHtmlTags(teaser),400,450,'...')}</p>
                <small class="text-muted">${location}</small>
                <p class="card-text text-right bottom-0 end-0 m-0"><small class="text-muted"><fmt:formatDate pattern="dd MMM yyyy" value="${startDate}"/></small></p>
            </div>
        </div>
    </div>
</div>
