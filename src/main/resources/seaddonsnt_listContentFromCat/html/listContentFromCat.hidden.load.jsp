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


<c:set var="type" value="${currentNode.properties['se:type'].string}"/>
<c:set var="criteria" value="${currentNode.properties['se:criteria'].string}"/>
<c:set var="sortDirection" value="${currentNode.properties['se:sortDirection'].string}"/>
<c:set var="maxItems" value="${currentNode.properties['se:maxItems'].long}"/>
<c:set var="startNode" value="${currentNode.properties['se::startNode'].node}"/>
<c:set var="noResultsMessage" value="${currentNode.properties['se::noResultsMessage'].string}"/>
<c:set var="subNodesView" value="${currentNode.properties['se:subNodesView'].string}"/>
<c:set var="title" value="${currentNode.properties['jcr:title'].string}"/>
<c:set var="description" value="${currentNode.properties['jcr:description'].string}"/>

<c:if test="${renderContext.editMode}">
    <legend>${fn:escapeXml(jcr:label(currentNode.primaryNodeType, currentResource.locale))}</legend>
</c:if>
<c:set var="bindedComponent" value="${ui:getBindedComponent(currentNode, renderContext, 'j:bindedComponent')}"/>
<c:if test="${not empty bindedComponent && jcr:isNodeType(bindedComponent, 'tint:content, seaddonsnt::event, seaddonsnt:listContentFromCat')}">
    <c:set var="targetProps" value="${bindedComponent.properties}"/>
</c:if>

<c:set var="categories" value="${targetProps['j:defaultCategory']}"/>
<c:set var="mainItemId" value="${targetProps['jcr:uuid']}"/>

<%-- Display title (if it is skinnable the title is displayed with skin--%>
<c:if test="${not empty title and not empty title.string and not jcr:isNodeType(currentNode, 'jmix:skinnable')}">
    <h3>${title.string}</h3>
</c:if>
<c:if test="${not empty startNode}">
    <c:set var="startNode" value="${startNode.node}"/>
</c:if>
<c:if test="${empty startNode}">
    <c:set var="startNode" value="${renderContext.site}"/>
</c:if>

<%-- Define the query, depending on the selected criteria --%>
<query:definition var="listQuery" limit="${currentResource.moduleParams.queryLoadAllUnsorted == 'true' ? -1 : nbOfResult.long}">
    <query:selector nodeTypeName="${type.string}"/>
    <query:descendantNode path="${startNode.path}"/>
    <query:and>
        <query:notEqualTo propertyName="jcr:uuid" value="${mainItemId}"/>
    </query:and>
    <query:or>
        <c:forEach var="filter" items="${categories}">
            <c:if test="${not empty filter.string}">
                <query:equalTo propertyName="j:defaultCategory" value="${filter.string}"/>
            </c:if>
        </c:forEach>
    </query:or>
    <c:if test="${not currentResource.moduleParams.queryLoadAllUnsorted == 'true'}">
        <query:sortBy propertyName="${criteria.string}" order="${sortDirection.string}"/>
    </c:if>
</query:definition>

<%-- Debug message --%>
<p>Debug > Nb of result from query (Criteria : ${criteria.string} - Nb of result : ${nbOfResult.long} - Mode : ${mode.string}) : ${fn:length(result.nodes)}</p>

<%-- Set variables to store the result --%>
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
<c:set target="${moduleMap}" property="subNodesView" value="${subNodesView.string}" />
<template:addCacheDependency flushOnPathMatchingRegexp="\\\\Q${startNode.path}\\\\E/.*"/>