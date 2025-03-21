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
<template:addResources type="css" resources="quoteBanner.css"/>

<c:set var="title" value="${currentNode.properties['jcr:title'].string}"/>
<c:set var="quoteText" value="${currentNode.properties['qhoteText'].string}"/>
<c:set var="author" value="${currentNode.properties['author'].string}"/>
<c:set var="bgImgNode" value="${currentNode.properties['backgroundImg'].node}"/>
<template:addCacheDependency node="${bgImgNode}"/>
<style>
    /* Background banner */
    .quote-banner {
        background: url('${bgImgNode.url}') center/cover no-repeat;
    }
</style>

<div class="container-fluid quote-banner">
    <div class="quote-content">
        <p class="mb-3">"${quoteText}"</p>
        <p class="quote-author">— ${author}</p>
    </div>
</div>
