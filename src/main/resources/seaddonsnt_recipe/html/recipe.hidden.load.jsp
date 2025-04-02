<%@ taglib prefix="jcr" uri="http://www.jahia.org/tags/jcr" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="utility" uri="http://www.jahia.org/tags/utilityLib" %>
<%@ taglib prefix="template" uri="http://www.jahia.org/tags/templateLib" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="query" uri="http://www.jahia.org/tags/queryLib" %>
<%@ taglib prefix="seutils" uri="https://www.se-extra-views.jahia.com/jahia/tags/1.0" %>


<c:set var="maxItems" value="4"/>
<c:set var="folderPath" value="${currentNode.resolveSite.path}"/>
<c:set var="categories" value="${currentNode.properties['j:defaultCategory']}"/>

<c:set var="queryConstraint" value=""/>

<c:if test="${not empty categories}">
    <c:forEach items="${categories}" var="category" varStatus="status">
        <c:set var="categoryCondition" value="[j:defaultCategory] = '${category}'"/>
        <c:if test="${status.first}">
            <!-- For the first category, set queryConstraint directly -->
            <c:set var="queryConstraint" value="${categoryCondition}"/>
        </c:if>
        <c:if test="${not status.first}">
            <!-- For subsequent categories, append with 'or' -->
            <c:set var="queryConstraint" value="${queryConstraint} or ${categoryCondition}"/>
        </c:if>
    </c:forEach>
    <!-- Wrap queryConstraint with 'and (...)' -->
    <c:set var="queryConstraint" value="and (${queryConstraint})"/>
</c:if>

<c:set var="lastContentsStatement"
       value="select * from [seaddonsnt:recipe] as recipes where ISDESCENDANTNODE(recipes,'${folderPath}') ${queryConstraint}"/>
<query:definition var="listQuery" statement="${lastContentsStatement}" limit="${maxItems}"/>

<c:set target="${moduleMap}" property="editable" value="false"/>
<c:set target="${moduleMap}" property="emptyListMessage"><fmt:message key="recipe.label.query.notFound"/></c:set>
<c:set target="${moduleMap}" property="listQuery" value="${listQuery}"/>
<c:set target="${moduleMap}" property="subNodesView" value="queryCard"/>