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


<c:set var="sessionTitle" value="${currentNode.properties['sessionTitle'].string}"/>
<c:set var="sessionDescription" value="${currentNode.properties['sessionDescription'].string}"/>
<c:set var="sessionObjective" value="${currentNode.properties['sessionObjective'].string}"/>
<c:set var="sessionDate" value="${currentNode.properties['sessionDate'].date}"/>
<c:set var="startTime" value="${currentNode.properties['startTime'].string}"/>
<c:set var="endTime" value="${currentNode.properties['endTime'].string}"/>
<c:set var="location" value="${currentNode.properties['location'].string}"/>
<c:set var="levelOfExpertise" value="${currentNode.properties['levelOfExpertise'].string}"/>
<c:set var="instructorName" value="${currentNode.properties['instructorName'].string}"/>
<c:set var="buttonLabel" value="${currentNode.properties['buttonLabel'].string}"/>
<c:set var="title" value="${currentNode.properties['jcr:title'].string}"/>
<c:set var="description" value="${currentNode.properties['jcr:description'].string}"/>
<jcr:nodeProperty node="${currentNode}" name="j:defaultCategory" var="categories"/>
<c:set var="noteType" value="${currentNode.primaryNodeType}"/>
<c:url value="${currentNode.url}" var="contentURL" />

<c:set var="nodeTypeRB" value="${fn:replace(noteType, ':', '_')}" />

<div class="card">
    <h5 class="card-header"><fmt:message key='${nodeTypeRB}' /></h5>
    <div class="card-body">
        <h5 class="card-title">${title}</h5>
        <p class="card-text">
            <c:forEach items="${categories}" var="category">
                <span class="badge badge-secondary">${category.node.displayableName}</span> &nbsp;
            </c:forEach>
        </p>
        <a href="${contentURL}" class="btn btn-primary"><fmt:message key='label.readMore' /></a>
    </div>
</div>