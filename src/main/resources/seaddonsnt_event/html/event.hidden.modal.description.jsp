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


<c:set var="startDate" value="${currentNode.properties['startDate'].date}"/>
<c:set var="endDate" value="${currentNode.properties['endDate'].date}"/>
<c:set var="location" value="${currentNode.properties['location'].string}"/>
<c:set var="eventsType" value="${currentNode.properties['eventsType'].string}"/>
<c:set var="eventTeaser" value="${currentNode.properties['teaser'].string}"/>
<c:set var="eventDescription" value="${currentNode.properties['body'].string}"/>
<c:set var="image" value="${currentNode.properties['image'].node}"/>
<c:set var="buttonLabel" value="${currentNode.properties['buttonLabel'].string}"/>
<c:set var="eventTitle" value="${currentNode.properties['jcr:title'].string}"/>
<c:set var="description" value="${currentNode.properties['jcr:description'].string}"/>
<jcr:nodeProperty node="${currentNode}" name="j:defaultCategory" var="categories"/>


<c:set var="modalId" value="${currentNode.identifier}" />

<div class="modal fade" id="modal-${modalId}" tabindex="-1" role="dialog" aria-labelledby="objectiveModal" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">
                    <fmt:message key='seaddonsnt_event.body' /><br/>
                    <em class="text-primary">${eventTitle}</em>

                </h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <p>${eventTeaser}</p>
                ${eventDescription}
                <hr>
                <c:if test="${not empty categories}">
                    <c:forEach items="${categories}" var="category">
                        <span class="badge badge-secondary">${category.node.displayableName}</span>&nbsp;
                    </c:forEach>
                </c:if>
            </div>
            <c:if test="${not empty moduleMap.linkUrl}">
                <a href="${moduleMap.linkUrl}"
                   class="btn btn-primary btn-bottom">
                        ${buttonLabel}
                </a>
            </c:if>
        </div>
    </div>
</div>