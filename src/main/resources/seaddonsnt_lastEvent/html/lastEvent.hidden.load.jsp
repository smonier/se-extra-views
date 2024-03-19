<%@ taglib prefix="jcr" uri="http://www.jahia.org/tags/jcr" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="utility" uri="http://www.jahia.org/tags/utilityLib" %>
<%@ taglib prefix="template" uri="http://www.jahia.org/tags/templateLib" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="query" uri="http://www.jahia.org/tags/queryLib" %>
<%@ taglib prefix="seutils" uri="https://www.se-extra-views.jahia.com/jahia/tags/1.0" %>

<c:set var="title" value="${currentNode.properties['jcr:title'].string}"/>
<c:set var="titleEscaped" value="${not empty title ? fn:escapeXml(title) : fn:escapeXml(currentNode.name)}"/>

<c:set var="maxItems" value="${currentNode.properties['maxItems'].long}"/>
<c:set var="filterId" value="${currentNode.properties['filter'].string}"/>
<c:set var="folderPath" value="${currentNode.properties['folder'].node.path}"/>
<c:if test="${empty folderPath}">
    <c:set var="folderPath" value="${currentNode.resolveSite.path}"/>
</c:if>

<c:set var="queryConstraint" value=""/>
<c:if test="${not empty filterId}">
    <c:set var="queryConstraint" value="and events.[j:defaultCategory]='${filterId}'"/>
</c:if>
<c:if test="${not empty param.date}">
    <c:set var="dateFilter" value="${param.date}"/>
</c:if>

<c:if test="${not empty dateFilter}">
    <utility:logger level="INFO" value="dateFilter : ${dateFilter}"/>
    <c:set var="formatedDate" value="${seutils:transformDateString(dateFilter)}"/>
    <c:set var="formatedDatePlusOne" value="${seutils:addOneDay(formatedDate)}"/>
    <utility:logger level="INFO" value="formatedDate : ${formatedDate}"/>
    <c:set var="queryConstraint2" value="and events.[startDate]>='${formatedDate}' and events.[startDate]<='${formatedDatePlusOne}'"/>
</c:if>
<c:set var="lastContentsStatement" value="select * from [seaddonsnt:event] as events where ISDESCENDANTNODE(events,'${folderPath}') ${queryConstraint} ${queryConstraint2} order by events.[startDate] asc"/>
<c:set var="eventsStatementAll" value="select * from [seaddonsnt:event] as events where ISDESCENDANTNODE(events,'${folderPath}') ${queryConstraint} order by events.[startDate] asc"/>

<utility:logger level="INFO" value="lastContentsStatement : ${lastContentsStatement}"/>
<utility:logger level="INFO" value="maxItems : ${maxItems}"/>

<query:definition var="listQuery" statement="${lastContentsStatement}" limit="${maxItems}"  />
<query:definition var="listQuery2" statement="${eventsStatementAll}" limit="${maxItems}"  />

<c:set target="${moduleMap}" property="editable" value="false" />
<c:set target="${moduleMap}" property="emptyListMessage"><fmt:message key="label.content.notFound"/></c:set>
<c:set target="${moduleMap}" property="listQuery" value="${listQuery}" />
<c:set target="${moduleMap}" property="listQuery2" value="${listQuery2}" />
<c:set target="${moduleMap}" property="subNodesView" value="${currentNode.properties['j:subNodesView'].string}" />