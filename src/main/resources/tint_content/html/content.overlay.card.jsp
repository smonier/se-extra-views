<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="jcr" uri="http://www.jahia.org/tags/jcr" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="functions" uri="http://www.jahia.org/tags/functions" %>
<%@ taglib prefix="template" uri="http://www.jahia.org/tags/templateLib" %>

<template:addResources type="css"
                       resources="overlayCard.css" />

<fmt:setLocale value="${currentResource.locale.language}" scope="session"/>

<c:set var="title" value="${currentNode.properties['jcr:title'].string}"/>

<c:set var="teaser" value="${currentNode.properties['teaser'].string}"/>

<fmt:message key="label.date.at" var="at"/>
<c:set var="date" value="${currentNode.properties['date'].date}"/>
<fmt:formatDate value="${date.time}" pattern="dd" var="day"/>
<fmt:formatDate value="${date.time}" pattern="yyyy" var="year"/>
<fmt:formatDate value="${date.time}" pattern="MMM" var="month"/>

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

<div class="item item-article pb-4">
    <div class="container mt-4">
        <div class="row">
            <div class="col">
                <!-- Wrap the entire card in a link -->
                <a href="${contentURL}" class="card text-white text-decoration-none article-card">
                    <!-- Card image -->
                    <img src="${imageURL}" class="card-img" alt="Article Image">

                    <!-- Overlay -->
                    <div class="card-img-overlay d-flex flex-column justify-content-end">
                        <h5 class="card-title">${title}</h5>
                        <p class="card-text">
                            ${functions:abbreviate(functions:removeHtmlTags(teaser),200,250,'...')}
                        </p>
                    </div>
                </a>
            </div>
        </div>
    </div>
</div>