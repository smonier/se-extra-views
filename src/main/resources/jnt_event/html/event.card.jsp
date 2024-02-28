<%@ taglib prefix="jcr" uri="http://www.jahia.org/tags/jcr" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="utility" uri="http://www.jahia.org/tags/utilityLib" %>
<%@ taglib prefix="template" uri="http://www.jahia.org/tags/templateLib" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<template:addResources type="css" resources="eventCard.css"/>

<div class="event-card">
    <div class="wrapper">
        <div class="date">
            <span class="day"><fmt:formatDate pattern="dd" value="${currentNode.properties.startDate.time}"/></span>
            <span class="month"><fmt:formatDate pattern="MM" value="${currentNode.properties.startDate.time}"/></span>
            <span class="year"><fmt:formatDate pattern="yyyy" value="${currentNode.properties.startDate.time}"/></span>
            <c:if test="${not empty currentNode.properties.endDate}">
                <span><fmt:message key='to'/></span>
                <span class="day"><fmt:formatDate pattern="dd" value="${currentNode.properties.endDate.time}"/></span>
                <span class="month"><fmt:formatDate pattern="MM" value="${currentNode.properties.endDate.time}"/></span>
                <span class="year"><fmt:formatDate pattern="yyyy"
                                                   value="${currentNode.properties.endDate.time}"/></span>
            </c:if>
        </div>
        <div class="data">
            <div class="content">
                <span class="author">${currentNode.properties.location.string}</span>
                <c:if test="${not empty currentNode.properties.eventsType.string}">
                    <span class="author">${currentNode.properties.eventsType.string}</span>
                </c:if>
                <h1 class="title"><a href="#"><jcr:nodeProperty node="${currentNode}" name="jcr:title"/></a></h1>
                <p class="text">
                    ${currentNode.properties.body.string}
                </p>
            </div>
            <input type="checkbox" id="show-menu"/>
            <ul class="menu-content">
                <jcr:nodeProperty node="${currentNode}" name="j:defaultCategory" var="cat"/>
                <c:if test="${cat != null}">
                    <c:forEach items="${cat}" var="category">
                        <li>${category.node.displayableName}</li>
                    </c:forEach>
                </c:if>
            </ul>
        </div>
    </div>
</div>

