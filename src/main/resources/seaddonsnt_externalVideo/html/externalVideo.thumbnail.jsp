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

<c:if test="${renderContext.editMode}">
    <legend>${fn:escapeXml(jcr:label(currentNode.primaryNodeType, currentResource.locale))}</legend>
</c:if>


<c:set var="videoSource" value="${currentNode.properties['videoService'].string}"/>
<c:set var="videoId" value="${currentNode.properties['videoId'].string}"/>
<c:set var="videoPoster" value="${currentNode.properties['videoPoster'].node}"/>
<c:set var="videoTeaser" value="${currentNode.properties['videoTeaser'].string}"/>
<c:set var="title" value="${currentNode.properties['jcr:title'].string}"/>
<c:set var="description" value="${currentNode.properties['jcr:description'].string}"/>
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

<div class="item" data-video-type="${fn:toLowerCase(videoSource)}" data-video="${videoURL}">
    <img src="${videoPoster.url}" alt="${title}">
</div>
