<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="jcr" uri="http://www.jahia.org/tags/jcr" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="functions" uri="http://www.jahia.org/tags/functions" %>
<%@ taglib prefix="template" uri="http://www.jahia.org/tags/templateLib" %>

<fmt:setLocale value="${currentResource.locale.language}" scope="session"/>
<c:set var="startDate" value="${currentNode.properties['startDate'].time}"/>
<c:set var="endDate" value="${currentNode.properties['endDate'].time}"/>
<c:set var="location" value="${currentNode.properties['location'].string}"/>
<c:set var="eventsType" value="${currentNode.properties['eventsType'].string}"/>
<c:set var="teaser" value="${currentNode.properties['teaser'].string}"/>
<c:set var="body" value="${currentNode.properties['body'].string}"/>
<c:set var="image" value="${currentNode.properties['image'].node}"/>
<c:set var="title" value="${currentNode.properties['jcr:title'].string}"/>
<c:set var="description" value="${currentNode.properties['jcr:description'].string}"/>
<c:set var="buttonLabel" value="${currentNode.properties['buttonLabel'].string}"/>

<jcr:nodeProperty node="${currentNode}" name="j:defaultCategory" var="categories"/>
<c:url value="${url.base}${renderContext.site.home.path}" var="homeUrl"/>

<c:set var="titleEscaped" value="${not empty title ? fn:escapeXml(title) : fn:escapeXml(currentNode.name)}"/>

<fmt:message key="label.eventDate.to" var="at"/>
<fmt:message key="label.eventDate.from" var="from"/>

<fmt:formatDate var="startDate" pattern="dd MMM yyyy" value="${startDate}"/>
<fmt:formatDate var="endDate" pattern="dd MMM yyyy" value="${endDate}"/>

<c:if test="${not empty startDate}">
    <c:set var="formatedDate" value="${from} ${startDate}"/>
</c:if>
<c:if test="${not empty endDate}">
    <c:set var="formatedDate" value="${formatedDate} ${at} ${endDate}"/>
</c:if>
<template:include view="hidden.getLinkToURL" />

<c:set var="imageNode" value="${currentNode.properties['image'].node}"/>
<template:addCacheDependency node="${imageNode}"/>
<c:set var="width" value="${not empty currentResource.moduleParams.mediaWidth ? currentResource.moduleParams.mediaWidth : '1920'}"/>
<c:set var="height" value="${currentResource.moduleParams.mediaHeight}"/>
<c:set var="scale" value="${currentResource.moduleParams.mediaScale}"/>
<c:set var="quality" value="${currentResource.moduleParams.mediaQuality}"/>

<c:catch var ="getUrlException">
    <c:set var="imageURL" value="${imageNode.getUrl(['width:'.concat(width),'height:'.concat(height),'scale:'.concat(scale),'quality:'.concat(quality)])}"/>
</c:catch>
<c:if test = "${getUrlException != null}">
    <c:set var="imageURL" value="${imageNode.getUrl()}"/>
</c:if>

<div class="inner-page">
    <div class="slider-item" style="background-image: url('${imageURL}');">
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
                <span class="author"><i class="fas fa-map-marker-alt text-primary mr-2"></i> ${location}</span>
                <c:if test="${not empty eventsType}">
                    <br/><span class="author"><i class="fas fa-bolt text-primary mr-2"></i> <fmt:message key='seaddonsnt_event.eventsType.${eventsType}'/></span>
                </c:if>
            </div>
        </div>

        <div class="row row-teaser justify-content-center">
            <div class="col-md-10">
                <div class="lead">
                    ${teaser}
                </div>
            </div>
        </div>

        <div class="row row-article justify-content-center">
            <div class="col-md-10">
                ${body}
            </div>
        </div>
    </div>
    <div class="card-bottom d-flex justify-content-center align-items-center text-center">
        <div class="card-text mt-auto">
            <c:choose>
                <c:when test="${not empty moduleMap.linkUrl}">
                    <a href="${moduleMap.linkUrl}"
                       class="btn btn-primary btn-bottom">
                             ${buttonLabel}
                    </a>
                </c:when>
                <c:otherwise>
                    <div class="btn btn-primary btn-bottom a-like">
                            ${buttonLabel}
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</section>