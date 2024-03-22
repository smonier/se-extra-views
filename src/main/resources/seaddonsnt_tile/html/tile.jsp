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
<!-- Tuile verticale avec description -->
<template:addResources type="css"
    resources="tile.css" />

<fmt:setLocale value="${currentResource.locale.language}" scope="session" />

<c:set var="title" value="${currentNode.properties['jcr:title'].string}" />
<c:set var="titleEscaped"
    value="${not empty title ? fn:escapeXml(title) : fn:escapeXml(currentNode.name)}" />

<c:set var="description" value="${currentNode.properties['description'].string}" />
<c:set var="detail" value="${currentNode.properties['detail'].string}" />
<c:if test="${not empty currentNode.properties['picto']}">
     <c:url var="pictoUrl" value="${url.currentModule}/img/pictograms/${currentNode.properties['picto'].string}"/>
</c:if>

<c:set var="imageNode" value="${currentNode.properties['pictoPicker'].node}" />
<template:addCacheDependency node="${imageNode}" />
<c:set var="width"
    value="${not empty currentResource.moduleParams.mediaWidth ? currentResource.moduleParams.mediaWidth : '1920'}" />
<c:set var="height" value="${currentResource.moduleParams.mediaHeight}" />
<c:set var="scale" value="${currentResource.moduleParams.mediaScale}" />
<c:set var="quality" value="${currentResource.moduleParams.mediaQuality}" />

<c:catch var="getUrlException">
    <c:set var="pictoUrl"
        value="${imageNode.getUrl(['width:'.concat(width),'height:'.concat(height),'scale:'.concat(scale),'quality:'.concat(quality)])}" />
</c:catch>
<c:if test="${getUrlException != null}">
    <c:set var="pictoUrl" value="${imageNode.getUrl()}" />
</c:if>

<%--linkTo--%>
<template:include view="hidden.getLinkToURL"/>
<utility:logger level="INFO" value="link : ${moduleMap.linkUrl}"/>

<div class="fr-tile fr-enlarge-link" id="tile-${currentNode.identifier}">
    <div class="fr-tile__body">
        <div class="fr-tile__content">
            <h3 class="fr-tile__title">
                <a href="${moduleMap.linkUrl}" target="${moduleMap.linkTarget}">${title}</a>
            </h3>
            <p class="fr-tile__desc">${description}</p>
            <p class="fr-tile__detail">${detail}</p>
        </div>
    </div>
    <div class="fr-tile__header">
        <div class="fr-tile__pictogram">
            <svg aria-hidden="true" class="fr-artwork --primary" viewBox="0 0 80 80" width="80px" height="80px">
                <use class="fr-artwork-decorative" href="${pictoUrl}#artwork-decorative"></use>
                <use class="fr-artwork-minor" href="${pictoUrl}#artwork-minor"></use>
                <use class="fr-artwork-major" href="${pictoUrl}#artwork-major"></use>
            </svg>
        </div>
    </div>
</div>