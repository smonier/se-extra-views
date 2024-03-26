<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="jcr" uri="http://www.jahia.org/tags/jcr" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="functions" uri="http://www.jahia.org/tags/functions" %>
<%@ taglib prefix="template" uri="http://www.jahia.org/tags/templateLib" %>

<fmt:setLocale value="${currentResource.locale.language}" scope="session"/>

<c:set var="title" value="${currentNode.properties['sessionTitle'].string}"/>
<c:set var="titleEscaped" value="${not empty title ? fn:escapeXml(title) : fn:escapeXml(currentNode.name)}"/>


<c:set var="sessionDate" value="${currentNode.properties['sessionDate'].time}" />
<c:set var="sessionTitle" value="${currentNode.properties['sessionTitle'].string}" />
<c:set var="sessionDescription" value="${currentNode.properties['sessionDescription'].string}" />
<c:set var="sessionObjective" value="${currentNode.properties['sessionObjective'].string}" />
<c:set var="startTime" value="${currentNode.properties['startTime'].string}" />
<c:set var="endTime" value="${currentNode.properties['endTime'].string}" />
<c:set var="location" value="${currentNode.properties['location'].string}" />
<c:set var="instructorName" value="${currentNode.properties['instructorName'].string}" />
<c:set var="materialsLink" value="${currentNode.properties['materialsLink'].string}" />
<c:set var="levelOfExpertise" value="${currentNode.properties['levelOfExpertise'].string}" />
<c:set var="buttonLabel" value="${currentNode.properties['buttonLabel'].string}" />
<jcr:nodeProperty node="${currentNode}" name="j:defaultCategory" var="categories"/>

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

<template:include view="hidden.getLinkToURL" />

<fmt:message key="label.date.at" var="at"/>
<fmt:message key="label.time.from" var="from"/>
<fmt:message key="label.time.to" var="to"/>

<fmt:formatDate value="${sessionDate}" pattern="dd MMM yyyy" var="formatedDate"/>
<c:if test="${not empty formatedDate}">
    <c:set var="formatedDate" value="${formatedDate} ${from} ${startTime} ${to} ${endTime}"/>
</c:if>

<c:set var="randomNumber" value="${(Math.random() * 20).intValue() + 1}" />
<c:url value="${url.base}${renderContext.site.home.path}" var="homeUrl"/>
<div class="inner-page">
    <div class="slider-item" style="background-image: url('https://picsum.photos/1600/800.webp?random=${randomNumber}');">
    </div>
</div>

<section class="pb-5">
    <div class="container container-content bg-white">
        <div class="row justify-content-center">
            <div class="col-md-10 mb-5">
                <h1>${titleEscaped}</h1>
                <c:if test="${not empty categories}">
                    <c:forEach items="${categories}" var="category">
                        <span class="badge badge-secondary"><a href="${homeUrl}/category.html?category=${category}">${category.node.displayableName}</a></span>&nbsp;
                    </c:forEach>
                </c:if>
                <div class="border-top border-bottom border-secondary pt-4 pb-4">
                    <i class="far fa-calendar-alt"></i> 
                     ${formatedDate}
                </div>
                <div class="pull-right">
                    <span class="${badgeClass}">
                        <fmt:message
                            key='seaddonsnt_trainingSession.levelOfExpertise.${levelOfExpertise}' />
                    </span>
                </div>
                <i class="fas fa-map-marker-alt text-primary mr-2"></i>
                <strong>
                    <fmt:message key='seaddonsnt_trainingSession.location' />
                </strong>: ${location}<br/>
                <i class="fas fa-chalkboard-teacher text-primary mr-2"></i>
                <strong>
                    <fmt:message key='seaddonsnt_trainingSession.instructorName' />
                </strong>: ${instructorName}
            </div>
        </div>

        <div class="row row-teaser justify-content-center">
            <div class="col-md-10">
                <div class="lead">
                    ${sessionDescription}
                </div>
            </div>
        </div>

        <div class="row row-article justify-content-center">
            <div class="col-md-10">
                ${sessionObjective}
            </div>
        </div>
    </div>
    <div class="card-bottom d-flex justify-content-center align-items-center text-center">
        <div class="card-text mt-auto">
            <c:choose>
            <c:when
                    test="${not empty moduleMap.linkUrl}">
            <a href="${moduleMap.linkUrl}"
               class="btn btn-primary btn-bottom">
                </c:when>
                <c:otherwise>
                <div class="btn btn-primary btn-bottom a-like">
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
</section>