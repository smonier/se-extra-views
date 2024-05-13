<%@ page language="java" contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="template" uri="http://www.jahia.org/tags/templateLib" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="jcr" uri="http://www.jahia.org/tags/jcr" %>
<%@ taglib prefix="seutils" uri="https://www.se-extra-views.jahia.com/jahia/tags/1.0" %>

<%--@elvariable id="currentNode" type="org.jahia.services.content.JCRNodeWrapper"--%>
<%--@elvariable id="out" type="java.io.PrintWriter"--%>
<%--@elvariable id="script" type="org.jahia.services.render.scripting.Script"--%>
<%--@elvariable id="scriptInfo" type="java.lang.String"--%>
<%--@elvariable id="workspace" type="java.lang.String"--%>
<%--@elvariable id="renderContext" type="org.jahia.services.render.RenderContext"--%>
<%--@elvariable id="currentResource" type="org.jahia.services.render.Resource"--%>
<%--@elvariable id="url" type="org.jahia.services.render.URLGenerator"--%>

<template:addResources type="css" resources="videoGallery.css"/>

<c:set var="image" value="${currentNode.properties['videoPoster'].node}"/>
<template:module path='${image.path}' editable='false' view='hidden.contentURL' var="imageUrl"/>
<template:module path='${image.path}' editable='false' view='hidden.imageSize' var="imageSize"/>

<c:set var="caption" value="${currentNode.properties['jcr:title'].string}"/>
<c:set var="itemWidth" value="${currentNode.parent.properties['itemWidth'].string}"/>
<c:set var="videoId" value="${currentNode.properties['videoId'].string}"/>
<c:set var="videoSource" value="${currentNode.properties['videoService'].string}"/>
<c:set var="rand">
    <%= java.lang.Math.round(java.lang.Math.random() * 10000) %>
</c:set>
<c:set var="modalId" value="modal-${rand}"/>

<c:if test="${empty itemWidth}">
    <c:set var="itemWidth" value="100%"/>
</c:if>
<!--Modal: Name-->
<div class="modal fade" id="${modalId}" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg" role="document">
        <!--Content-->
        <div class="modal-content">
            <!--Body-->
            <div class="modal-body mb-0 p-0">
                <c:choose>
                    <c:when test="${fn:toLowerCase(videoSource) == 'vimeo'}">
                        <c:set var="videoURL" value="https://player.vimeo.com/video/${videoId}"/>
                    </c:when>
                    <c:when test="${fn:toLowerCase(videoSource) == 'wistia'}">
                        <c:set var="videoURL" value="https://fast.wistia.net/embed/iframe/${videoId}"/>
                    </c:when>
                    <c:otherwise>
                        <c:set var="videoURL" value="https://www.youtube.com/embed/${videoId}"/>
                    </c:otherwise>
                </c:choose>
                <div class="embed-responsive embed-responsive-16by9 z-depth-1-half">
                    <iframe class="embed-responsive-item" src="${videoURL}"
                            allowfullscreen></iframe>
                </div>

            </div>
            <!--Footer-->
            <div class="modal-footer justify-content-center">
                <button type="button" class="btn btn-outline-primary btn-rounded btn-md ml-4" data-dismiss="modal">
                    Close
                </button>
            </div>
        </div>
        <!--/.Content-->
    </div>
</div>
<!--Modal: Name-->
<div class="thumb">
    <a class="video-thumbnail ">
        <i class="fas fa-play icon" data-toggle="modal"
        data-target="#${modalId}"></i>
        <c:choose>
            <c:when test="${not empty image.url}">
                <img class="img-fluid thumb zoom"
                     src="${image.url}"
                     itemprop="thumbnail"
                     alt="${caption}"
                     style="width: ${itemWidth}px"
                     data-toggle="modal"
                     data-target="#${modalId}"/>
            </c:when>
            <c:otherwise>
                <c:choose>
                    <c:when test="${fn:toLowerCase(videoSource) == 'vimeo'}">
                        <img class="img-fluid thumb zoom"
                             srcset="https://vumbnail.com/${videoId}.jpg 640w, https://vumbnail.com/${videoId}_large.jpg 640w, https://vumbnail.com/${videoId}_medium.jpg 200w, https://vumbnail.com/${videoId}_small.jpg 100w"
                             sizes="(max-width: 640px) 100vw, 640px"
                             src="https://vumbnail.com/${videoId}.jpg"
                             itemprop="thumbnail" alt="${caption}"
                             style="width: ${itemWidth}px"
                             data-toggle="modal"
                             data-target="#${modalId}"/>
                    </c:when>
                    <c:when test="${fn:toLowerCase(videoSource) == 'wistia'}">

                        <img class="img-fluid thumb zoom"
                             src="${seutils:fetchThumbnailUrl(videoId)}"
                             id="wistia-thumbnail-${videoId}"
                             itemprop="thumbnail" alt="${caption}"
                             style="width: ${itemWidth}px"
                             data-toggle="modal"
                             data-target="#${modalId}"/>

                    </c:when>
                    <c:otherwise>

                        <img class="img-fluid thumb zoom"
                             src="https://img.youtube.com/vi/${videoId}/maxresdefault.jpg"
                             itemprop="thumbnail"
                             alt="${caption}"
                             style="width: ${itemWidth}px"
                             data-toggle="modal"
                             data-target="#${modalId}"/>
                    </c:otherwise>
                </c:choose>
            </c:otherwise>

        </c:choose>
        <figcaption class="figure-caption">${caption}</figcaption>
    </a>
</div>
<!-- Grid column -->

<script>

    $(function(){
        $('#${modalId}').on('hidden.bs.modal', function (e) {
            $iframe = $(this).find("iframe");
            $iframe.attr("src", $iframe.attr("src"));
        });
    });
</script>