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

<c:set var="title" value="${currentNode.properties['jcr:title'].string}"/>
<c:set var="description" value="${currentNode.properties['jcr:description'].string}"/>
<jcr:nodeProperty node="${currentNode}" name="j:defaultCategory" var="categories"/>
<c:set var="noteType" value="${currentNode.primaryNodeType}"/>
<c:url value="${currentNode.url}" var="contentURL" />
<c:url value="${url.base}${renderContext.site.home.path}" var="homeUrl"/>

<c:choose>
    <c:when
            test="${noteType == 'tint:content'}">
        <c:set var="icon"
               value="<i class='far fa-newspaper text-primary'></i>" />
    </c:when>
    <c:when
            test="${noteType == 'seaddonsnt:event'}">
        <c:set var="icon"
               value="<i class='fas fa-calendar-day text-primary'></i>" />
    </c:when>
    <c:when
            test="${noteType == 'seaddonsnt:trainingSession'}">
        <c:set var="icon"
               value="<i class='fas fa-graduation-cap text-primary'></i>" />
    </c:when>
    <c:otherwise>
        <c:set var="icon"
               value="<i class='far fa-file-alt text-primary'></i>" />
    </c:otherwise>
</c:choose>


<c:set var="nodeTypeRB" value="${fn:replace(noteType, ':', '_')}" />

<div class="card">
    <h6 class="card-header">${icon}&nbsp;&nbsp;<fmt:message key='${nodeTypeRB}' /></h6>
    <div class="card-body  d-flex flex-column justify-content-between">
        <h4 class="card-title">${title}</h4>
        <p class="card-text text-end">
            <c:forEach items="${categories}" var="category">
                <span class="badge badge-secondary"><a href="${homeUrl}/category.html?category=${category}">${category.node.displayableName}</a></span>&nbsp;&nbsp;
            </c:forEach>
        </p>
        <a href="${contentURL}" class="btn btn-primary"><fmt:message key='label.readMore' /></a>
    </div>
</div>