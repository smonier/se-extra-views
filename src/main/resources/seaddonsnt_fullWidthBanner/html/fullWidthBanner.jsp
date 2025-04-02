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

<c:set var="bgImgNode" value="${currentNode.properties['backgroundImg'].node}"/>
<template:addCacheDependency node="${bgImgNode}"/>

<style>
    .fullWidthBanner {
        background-image: url('${bgImgNode.url}'); /* Replace with your image */
        background-size: cover;
        background-position: center;
        height: 600px;
        display: flex;
        align-items: center;
        justify-content: center;
        color: white;
        text-shadow: 1px 1px 4px rgba(0, 0, 0, 0.7);
    }
</style>

<div class="container-fluid p-0">
    <div class="fullWidthBanner text-center">
        <div>
            &nbsp;
        </div>
    </div>
</div>