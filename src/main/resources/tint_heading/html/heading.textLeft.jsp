<%@ page language="java" contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="template" uri="http://www.jahia.org/tags/templateLib" %>
<%@ taglib prefix="utility" uri="http://www.jahia.org/tags/utilityLib" %>
<%--@elvariable id="currentNode" type="org.jahia.services.content.JCRNodeWrapper"--%>

<%--<template:addResources type="css" resources="bootstrap.min.css" />--%>
<%--<template:addResources type="javascript" resources="jquery.min.js,popper.min.js,bootstrap.min.js"/>--%>
<template:addResources type="css"
                       resources="carouselItemS.css" />
<c:set var="body" value="${currentNode.properties.body.string}"/>

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
        <div class="container">
            <div class="row slider-text align-items-center justify-content-center">
                <div class="col-lg-12 text-left col-sm-12 element-animate">
                    <div class="slider-text-box">
                    <%-- --%>
                        <div class="slider-text-content">
                        ${body}
                        </div>
                    </div>
                 </div>
            </div>
        </div>
    </div>
</div>