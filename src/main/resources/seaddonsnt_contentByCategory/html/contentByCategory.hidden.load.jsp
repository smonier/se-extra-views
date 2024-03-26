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

<c:if test="${renderContext.editMode}">
    <legend>${fn:escapeXml(jcr:label(currentNode.primaryNodeType, currentResource.locale))}</legend>
</c:if>

<c:set var="catFilter" value="${param.category}"/>
<c:set var="ntFilter" value="${param.nodetype}"/>
<c:set var="startNode" value="${renderContext.site.path}"/>
<c:set var="queryConstraint" value="and contents.[j:defaultCategory]='${catFilter}'"/>
<utility:logger level="INFO" value="ntFilter : ${ntFilter}"/>


<c:set var="sqlStatement" value="select * from [jmix:mainResource] as contents where ISDESCENDANTNODE(contents,'${startNode}') ${queryConstraint} order by contents.[j:lastPublished] desc"/>

<utility:logger level="INFO" value="sqlStatement : ${sqlStatement}"/>

<query:definition var="listQuery" statement="${sqlStatement}"/>

<c:set target="${moduleMap}" property="editable" value="false" />
<c:set target="${moduleMap}" property="listQuery" value="${listQuery}" />
<c:set target="${moduleMap}" property="emptyListMessage">
    <c:choose>
        <c:when test="${not empty noResultsMessage}">
            ${noResultsMessage.string}
        </c:when>
        <c:otherwise>
            <fmt:message key='noResults.message'/>
        </c:otherwise>
    </c:choose>
</c:set>