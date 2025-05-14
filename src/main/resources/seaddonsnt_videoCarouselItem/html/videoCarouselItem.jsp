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

<c:set var="title" value="${currentNode.properties['jcr:title'].string}"/>
<c:set var="caption" value="${currentNode.properties['caption'].string}"/>
<c:url var="video" value="${currentNode.properties['video'].node.url}"/>

<c:choose>
	<c:when test="${renderContext.editMode}">
		<div class="card j-owl-carousel-card-edit">
			<img class="card-img-top" src="${url.currentModule}/images/videoPlaceholder.png" style="opacity: 0.2;" alt="Card image cap">

			<div class="card-body">
				<h3>${title}</h3>

			${caption}
					<%--                <h5 class="card-title">Card title</h5>--%>
					<%--                <p class="card-text">Some quick example text to build on the card title and make up the bulk of the card's content.</p>--%>
					<%--                <a href="#" class="btn btn-primary">Go somewhere</a>--%>
			</div>
		</div>
	</c:when>
	<c:otherwise>
		<div class="video-slide">
			<video autoplay muted loop playsinline>
				<source src="${video}" type="video/mp4">
				Your browser does not support the video tag.
			</video>
			<div class="overlay-text">
				<h2>${title}</h2>
				<p>${caption}</p>
			</div>
		</div>
	</c:otherwise>
</c:choose>