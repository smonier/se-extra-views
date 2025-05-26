<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="jcr" uri="http://www.jahia.org/tags/jcr" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="functions" uri="http://www.jahia.org/tags/functions" %>
<%@ taglib prefix="template" uri="http://www.jahia.org/tags/templateLib" %>

<template:addResources type="css"
                       resources="smo.teaserCard.css" />



<fmt:setLocale value="${currentResource.locale.language}" scope="session"/>

<c:set var="title" value="${currentNode.properties['jcr:title'].string}"/>

<c:set var="teaser" value="${currentNode.properties['teaser'].string}"/>

<fmt:message key="label.date.at" var="at"/>
<c:set var="date" value="${currentNode.properties['date'].date}"/>
<fmt:formatDate value="${date.time}" pattern="dd" var="day"/>
<fmt:formatDate value="${date.time}" pattern="yyyy" var="year"/>
<fmt:formatDate value="${date.time}" pattern="MMM" var="month"/>
<jcr:nodeProperty node="${currentNode}" name="j:defaultCategory" var="cat"/>

<%--<c:url value="${url.server}${url.context}${url.base}${currentNode.path}.html" var="itemUrl"/>--%>
<c:url value="${currentNode.url}" var="contentURL"/>

<c:set var="imageNode" value="${currentNode.properties['images'][0].node}"/>
<template:addCacheDependency node="${imageNode}"/>
<c:set var="width" value="${currentResource.moduleParams.mediaWidth}"/>
<c:set var="height" value="${currentResource.moduleParams.mediaHeight}"/>
<c:set var="scale" value="${currentResource.moduleParams.mediaScale}"/>
<c:set var="quality" value="${currentResource.moduleParams.mediaQuality}"/>

<c:catch var ="getUrlException">
    <c:set var="imageURL" value="${imageNode.getUrl(['width:'.concat(width),'height:'.concat(height),'scale:'.concat(scale),'quality:'.concat(quality)])}"/>
</c:catch>
<c:if test = "${getUrlException != null}">
    <c:set var="imageURL" value="${imageNode.getUrl()}"/>
</c:if>

<div class="news-card">
    <a href="${contentURL}">
        <div class="news-image-container">
            <img src="${imageURL}" alt="News" class="news-image" />
            <c:forEach items="${cat}" var="category">
                <span class="news-tag">${category.node.displayableName}</span>
            </c:forEach>
        </div>
        <div class="news-content">
            <p class="news-date">${day}&nbsp;${month}&nbsp;${year}</p>
            <h3 class="news-title">${title}</h3>
            <p class="news-description">
                ${functions:abbreviate(functions:removeHtmlTags(teaser),200,250,'...')}
            </p>
        </div>
        <div class="news-arrow"><i class="fas fa-arrow-right"></i></div>
    </a>
</div>
