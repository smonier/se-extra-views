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
<jcr:nodeProperty node="${currentNode}" name="j:defaultCategory" var="cat"/>

<style>
    .card-${currentNode.identifier} .wrapper {
        background: url(${image.url}) 20% 1% / cover no-repeat;
    }
    /* Assuming $bermuda = #7ddedf, $white = #ffffff, $black = #000000 */
    /* For lighten($black, 50%), I'll use a gray color as an example, e.g., #808080 */

    .card-${currentNode.identifier} .date {
        position: absolute;
        top: 0;
        left: 0;
        background-color: #f81700; /* Placeholder for $bermuda */
        color: #ffffff; /* Placeholder for $white */
        padding: 0.8em;
    }

    .card-${currentNode.identifier} .date span {
        display: block;
        text-align: center;
    }

    .card-${currentNode.identifier} .date .day {
        font-weight: 700;
        font-size: 24px;
        text-shadow: 2px 3px 2px rgba(0, 0, 0, 0.18); /* Placeholder for rgba($black, 0.18) */
    }

    .card-${currentNode.identifier} .date .month {
        text-transform: uppercase;
    }

    .card-${currentNode.identifier} .date .month,
    .card-${currentNode.identifier} .date .year {
        font-size: 12px;
    }

    .card-${currentNode.identifier} .content {
        background-color: #ffffff; /* Placeholder for $white */
        box-shadow: 0 5px 30px 10px rgba(0, 0, 0, 0.3); /* Placeholder for rgba($black, 0.3) */
    }

    .card-${currentNode.identifier} .title a {
        color: #808080; /* Placeholder for lighten($black, 50%) */
    }

    .card-${currentNode.identifier} .menu-button {
        position: absolute;
        z-index: 999;
        top: 16px;
        right: 16px;
        width: 25px;
        text-align: center;
        cursor: pointer;
    }

    .card-${currentNode.identifier} .menu-button span {
        width: 5px;
        height: 5px;
        background-color: #808080; /* Placeholder for lighten($black, 50%) */
        color: #808080; /* Placeholder for lighten($black, 50%) */
        position: relative;
        display: inline-block;
        border-radius: 50%;
    }

    .card-${currentNode.identifier} .menu-button span::after,
    .card-${currentNode.identifier} .menu-button span::before {
        content: '';
        display: block;
        width: 5px;
        height: 5px;
        background-color: currentColor;
        position: absolute;
        border-radius: 50%;
    }

    .card-${currentNode.identifier} .menu-button span::before {
        left: -10px;
    }

    .card-${currentNode.identifier} .menu-button span::after {
        right: -10px;
    }

    .card-${currentNode.identifier} .menu-content {
        text-align: center;
        position: absolute;
        top: 0;
        left: 0;
        width: 100%;
        z-index: -1;
        transition: transform 0.3s;
        transform: translateY(0);
    }

    .card-${currentNode.identifier} .menu-content li {
        width: 33.333333%;
        float: left;
        background-color: #f81700; /* Placeholder for $bermuda */
        height: 60px;
        position: relative;
    }

    .card-${currentNode.identifier} .menu-content a {
        position: absolute;
        top: 50%;
        left: 50%;
        transform: translate(-50%, -50%);
        font-size: 24px;
    }

    .card-${currentNode.identifier} .menu-content span {
        top: -10px;
    }

</style>


<div class="event-card card-${currentNode.identifier}">
    <div class="wrapper">
        <div class="date">
            <span class="day"><fmt:formatDate pattern="dd" value="${startDate}"/></span>
            <span class="month"><fmt:formatDate pattern="MM" value="${startDate}"/></span>
            <span class="year"><fmt:formatDate pattern="yyyy" value="${startDate}"/></span>
            <c:if test="${not empty endDate}">
                <span><fmt:message key='label.eventDate.to'/></span>
                <span class="day"><fmt:formatDate pattern="dd" value="${endDate}"/></span>
                <span class="month"><fmt:formatDate pattern="MM" value="${endDate}"/></span>
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
                <h2 class="title"><a href="#">${title}</a></h2>
                <p class="text">${functions:removeHtmlTags(teaser)}</p>
            </div>
            <input type="checkbox" id="show-menu"/>
            <ul class="menu-content">
                <c:if test="${cat != null}">
                    <c:forEach items="${cat}" var="category">
                        <li>${category.node.displayableName}</li>
                    </c:forEach>
                </c:if>
            </ul>
        </div>
    </div>
</div>

