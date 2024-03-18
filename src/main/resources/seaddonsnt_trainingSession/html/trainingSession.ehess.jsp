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
<%--@elvariable id="currentNode"
type="org.jahia.services.content.JCRNodeWrapper" --%>
<%--@elvariable id="out" type="java.io.PrintWriter" --%>
<%--@elvariable id="script"
type="org.jahia.services.render.scripting.Script" --%>
<%--@elvariable id="scriptInfo" type="java.lang.String" --%>
<%--@elvariable id="workspace" type="java.lang.String" --%>
<%--@elvariable id="renderContext"
type="org.jahia.services.render.RenderContext" --%>
<%--@elvariable id="currentResource"
type="org.jahia.services.render.Resource" --%>
<%--@elvariable id="url"
type="org.jahia.services.render.URLGenerator"
--%>

<template:addResources type="css"
    resources="eventCard.css" />

<c:set var="sessionDate"
    value="${currentNode.properties['sessionDate'].time}" />
<c:set var="sessionTitle"
    value="${currentNode.properties['sessionTitle'].string}" />
<c:set var="sessionDescription"
    value="${currentNode.properties['sessionDescription'].string}" />
<c:set var="sessionObjective"
    value="${currentNode.properties['sessionObjective'].string}" />
<c:set var="startTime"
    value="${currentNode.properties['startTime'].string}" />
<c:set var="endTime"
    value="${currentNode.properties['endTime'].string}" />
<c:set var="location"
    value="${currentNode.properties['location'].string}" />
<c:set var="instructorName"
    value="${currentNode.properties['instructorName'].string}" />
<c:set var="materialsLink"
    value="${currentNode.properties['materialsLink'].string}" />
<c:set var="levelOfExpertise"
    value="${currentNode.properties['levelOfExpertise'].string}" />
<c:set var="buttonLabel"
    value="${currentNode.properties['buttonLabel'].string}" />


<c:choose>
    <c:when
        test="${levelOfExpertise == 'Beginner'}">
        <c:set var="badgeClass"
            value="badge badge-success" />
    </c:when>
    <c:when
        test="${levelOfExpertise == 'Intermediate'}">
        <c:set var="badgeClass"
            value="badge badge-danger" />
    </c:when>
    <c:when
        test="${levelOfExpertise == 'Advanced'}">
        <c:set var="badgeClass"
            value="badge badge-info" />
    </c:when>
    <c:otherwise>
        <c:set var="badgeClass"
            value="badge badge-secondary" />
    </c:otherwise>
</c:choose>

<template:include
    view="hidden.getLinkToURL" />

<div
    class="card training-card d-flex flex-column">
    <div class="card-body">
        <h3 class="card-title">
            ${sessionTitle}</h3>
        <h6
            class="card-subtitle mb-2 text-muted">
            ${sessionObjective}</h6>
        <p class="card-text">
            ${sessionDescription}</p>
        <hr>
        <!-- <div class="pull-right">
            <span class="${badgeClass}">
                <fmt:message
                    key='seaddonsnt_trainingSession.levelOfExpertise.${levelOfExpertise}' />
            </span>
        </div> -->
        <!-- <p class="card-text"><span>
                <fmt:formatDate
                    pattern="dd MMM yyyy"
                    value="${sessionDate}" />
                &nbsp;
                <fmt:message
                    key='label.time.from' />
                &nbsp; ${startTime} &nbsp;
                <fmt:message
                    key='label.time.to' />
                &nbsp;${endTime}
            </span></p> -->
        <p class="card-text"><strong>
                <fmt:message
                    key='seaddonsnt_trainingSession.level' />
            </strong>: ${location}</p>
        <p class="card-text"><strong>
                <fmt:message
                    key='seaddonsnt_trainingSession.teacher' />
            </strong>: ${instructorName}</p>
        <br />
    </div>
    <div
        class="card-bottom d-flex justify-content-center align-items-center text-center">
        <div class="card-text mt-auto">
            <c:choose>
                <c:when
                    test="${not empty moduleMap.linkUrl}">
                    <a href="${moduleMap.linkUrl}"
                        class="btn btn-primary btn-bottom">
                </c:when>
                <c:otherwise>
                    <div
                        class="btn btn-primary btn-bottom a-like">
                </c:otherwise>
            </c:choose>
            ${buttonLabel}
            <c:choose>
                <c:when
                    test="${not empty moduleMap.linkUrl}">
                    </a>
                </c:when>
                <c:otherwise>
                    </div>
                </c:otherwise>
             </c:choose>
        </div>
    </div>
</div>
