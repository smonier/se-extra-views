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

<c:if test="${renderContext.editMode}">
<!--     <legend>${fn:escapeXml(jcr:label(currentNode.primaryNodeType, currentResource.locale))}</legend>
 --></c:if>



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
<c:url value="${currentNode.url}" var="contentURL"/>

<style>
    .card-${currentNode.identifier} .wrapper {
        background: url(${image.url}) 20% 1% / cover no-repeat;
    }
</style>
<c:set var="modalId" value="${currentNode.identifier}" />

<template:include
        view="hidden.getLinkToURL" />

<template:include
        view="hidden.modal.description" />

<div class="event-card card-${currentNode.identifier} mb-3">
    <div class="wrapper">
        <div class="date">
            <span class="day"><fmt:formatDate pattern="dd" value="${startDate}"/></span>
            <span class="month"><fmt:formatDate pattern="MMM" value="${startDate}"/></span>
            <span class="year"><fmt:formatDate pattern="yyyy" value="${startDate}"/></span>
            <c:if test="${not empty endDate}">
                <span><fmt:message key='label.eventDate.to'/></span>
                <span class="day"><fmt:formatDate pattern="dd" value="${endDate}"/></span>
                <span class="month"><fmt:formatDate pattern="MMM" value="${endDate}"/></span>
                <span class="year"><fmt:formatDate pattern="yyyy"
                                                   value="${endDate}"/></span>
            </c:if>
        </div>
        <div class="data">
            <div class="content">
                <span class="author"><i class="fas fa-map-marker-alt text-primary mr-2"></i> ${location}</span>
                <c:if test="${not empty eventsType}">
                    <br/><span class="author"><i class="fas fa-bolt text-primary mr-2"></i> <fmt:message key='seaddonsnt_event.eventsType.${eventsType}'/></span>
                </c:if>
                <h4 class="title"><a href="${contentURL}">${title}</a></h4>
                <p class="text">${functions:removeHtmlTags(teaser)}</p>
                <button type="button" class="btn btn-outline-dark btn-sm" data-toggle="modal" data-target="#modal-${modalId}">
                    <fmt:message key='seaddonsnt_event.body' />
                </button>
            </div>

        </div>
    </div>
</div>
