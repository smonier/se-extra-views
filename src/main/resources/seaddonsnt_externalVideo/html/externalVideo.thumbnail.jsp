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
<c:choose>
    <c:when test="${renderContext.editMode}">
        <div class="card j-owl-carousel-card-edit">
            <img class="card-img-top" src="${videoPoster.url}" alt="Card image cap">
            <div class="card-body">
                    ${title}
                    <%--                <h5 class="card-title">Card title</h5>--%>
                    <%--                <p class="card-text">Some quick example text to build on the card title and make up the bulk of the card's content.</p>--%>
                    <%--                <a href="#" class="btn btn-primary">Go somewhere</a>--%>
            </div>
        </div>
    </c:when>
    <c:otherwise>
        <div class="item video-thumbnail" data-video-type="${fn:toLowerCase(videoSource)}" data-video="${videoURL}">
            <i class="fas fa-play icon"></i>
            <c:choose>
                <c:when test="${not empty image.url}">
                    <img src="${videoPoster.url}"
                         itemprop="thumbnail"
                         alt="${title}"/>
                </c:when>
                <c:otherwise>
                    <c:choose>
                        <c:when test="${fn:toLowerCase(videoSource) == 'vimeo'}">
                            <img srcset="https://vumbnail.com/${videoId}.jpg 640w, https://vumbnail.com/${videoId}_large.jpg 640w, https://vumbnail.com/${videoId}_medium.jpg 200w, https://vumbnail.com/${videoId}_small.jpg 100w"
                                 sizes="(max-width: 640px) 100vw, 640px"
                                 src="https://vumbnail.com/${videoId}.jpg"
                                 alt="${title}"/>
                        </c:when>
                        <c:when test="${fn:toLowerCase(videoSource) == 'wistia'}">
                            <img data-src="${videoId}"
                                 id="wistia-thumbnail-${videoId}"
                                 alt="${title}"/>

                        </c:when>
                        <c:otherwise>
                            <img src="https://img.youtube.com/vi/${videoId}/maxresdefault.jpg"
                                 alt="${title}"/>
                        </c:otherwise>
                    </c:choose>
                </c:otherwise>
            </c:choose>
            <div class="overlay">${title}</div>
        </div>
    </c:otherwise>
</c:choose>

