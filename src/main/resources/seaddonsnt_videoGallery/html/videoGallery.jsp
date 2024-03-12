<%@ taglib prefix="jcr" uri="http://www.jahia.org/tags/jcr" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="utility" uri="http://www.jahia.org/tags/utilityLib" %>
<%@ taglib prefix="template" uri="http://www.jahia.org/tags/templateLib" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%--@elvariable id="currentNode" type="org.jahia.services.content.JCRNodeWrapper"--%>
<%--@elvariable id="out" type="java.io.PrintWriter"--%>
<%--@elvariable id="script" type="org.jahia.services.render.scripting.Script"--%>
<%--@elvariable id="scriptInfo" type="java.lang.String"--%>
<%--@elvariable id="workspace" type="java.lang.String"--%>
<%--@elvariable id="renderContext" type="org.jahia.services.render.RenderContext"--%>
<%--@elvariable id="currentResource" type="org.jahia.services.render.Resource"--%>
<%--@elvariable id="url" type="org.jahia.services.render.URLGenerator"--%>

<template:addResources type="javascript" resources="videoGallery.js"/>
<template:addResources type="css" resources="videoGallery.css"/>


<c:if test="${renderContext.editMode}">
    <legend>${fn:escapeXml(jcr:label(currentNode.primaryNodeType, currentResource.locale))}</legend>
</c:if>


<c:set var="title" value="${currentNode.properties['jcr:title'].string}"/>
<c:set var="description" value="${currentNode.properties['jcr:description'].string}"/>
<c:set var="videos" value="${jcr:getChildrenOfType(currentNode, 'seaddonsnt:externalVideo,seaddonsnt:internalVideo')}"/>


<!-- Main video/iframe placeholder -->
<div class="video-placeholder" style="width: 100%; height: 500px; background: #000;">
    <!-- Initially empty, will be filled based on selection -->
</div>

<!-- Thumbnails carousel -->
<div class="owl-carousel owl-theme">
    <c:forEach items="${videos}" var="video" varStatus="item">
            <template:module node="${video}" view="thumbnail" editable="true"/>
    </c:forEach>
</div>





<c:if test="${renderContext.editMode}">
    <%--
    As only one child type is defined no need to restrict
    if a new child type is added restriction has to be done
    using 'nodeTypes' attribute
    --%>
    <template:module path="*"/>
</c:if>
<script>
    $(document).ready(function(){
        $(".owl-carousel").owlCarousel({
            // Owl Carousel settings
            loop: true,
            margin: 10,
            nav: true,
            responsive: {
                0: { items: 1 },
                600: { items: 3 },
                1000: { items: 4 }
            }
        });

        $('.owl-carousel .item').click(function(){
            const videoType = $(this).data('video-type');
            const videoSrc = $(this).data('video');
            let playerHtml = '';

            if(videoType === 'self-hosted') {
                playerHtml = '<video controls style="width: 100%; height: 100%;"><source src="' + videoSrc + '" type="video/mp4">Your browser does not support the video tag.</video>';
            } else { // YouTube or Vimeo
                playerHtml = '<iframe src="' + videoSrc +'" style="width: 100%; height: 100%;" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>';
            }

            $('.video-placeholder').html(playerHtml);
        });
    });
</script>