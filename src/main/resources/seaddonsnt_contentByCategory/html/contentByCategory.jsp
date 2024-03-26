<%@ taglib prefix="jcr" uri="http://www.jahia.org/tags/jcr" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="utility" uri="http://www.jahia.org/tags/utilityLib" %>
<%@ taglib prefix="template" uri="http://www.jahia.org/tags/templateLib" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="query" uri="http://www.jahia.org/tags/queryLib" %>
<%@ taglib prefix="seutils" uri="https://www.se-extra-views.jahia.com/jahia/tags/1.0" %>
<%--@elvariable id="currentNode" type="org.jahia.services.content.JCRNodeWrapper"--%>
<%--@elvariable id="out" type="java.io.PrintWriter"--%>
<%--@elvariable id="script" type="org.jahia.services.render.scripting.Script"--%>
<%--@elvariable id="scriptInfo" type="java.lang.String"--%>
<%--@elvariable id="workspace" type="java.lang.String"--%>
<%--@elvariable id="renderContext" type="org.jahia.services.render.RenderContext"--%>
<%--@elvariable id="currentResource" type="org.jahia.services.render.Resource"--%>
<%--@elvariable id="url" type="org.jahia.services.render.URLGenerator"--%>


<c:choose>
    <c:when test="${renderContext.editMode}">
        <legend>${fn:escapeXml(jcr:label(currentNode.primaryNodeType, currentResource.locale))}</legend>
        <h2><fmt:message key='label.category.page.edit' /></h2>
    </c:when>
    <c:otherwise>
        <template:include view="hidden.load"/>
        <c:set var="listQuery" value="${moduleMap.listQuery}"/>
        <jcr:jqom var="result" qomBeanName="listQuery"/>

        <c:choose>
            <c:when test="${empty result}">
                <p>${moduleMap.emptyListMessage}</p>
            </c:when>
            <c:otherwise>
                <div class="container">
                    <div class="col-12">
                        <div class="row">
                            <h2>${title}</h2>
                            <c:out value="${not empty teaser ? teaser : ''}" escapeXml="false"/>
                        </div>
                        <div class="row lastEvent ">
                            <c:forEach items="${result.nodes}" var="node">
                                <div class="col-md-4 mb-5 d-flex align-items-stretch mb-3">
                                <template:module view="hidden.categoryCard" node="${node}"/>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                </div>
            </c:otherwise>
        </c:choose>
    </c:otherwise>
</c:choose>