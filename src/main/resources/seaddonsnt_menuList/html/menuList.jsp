<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="jcr" uri="http://www.jahia.org/tags/jcr" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="functions" uri="http://www.jahia.org/tags/functions" %>
<%@ taglib prefix="template" uri="http://www.jahia.org/tags/templateLib" %>

<c:set var="dateFilter" value="${param.date}"/>


<c:set var="title" value="${currentNode.properties['title'].string}"/>
<c:set var="titleEscaped" value="${not empty title ? fn:escapeXml(title) : fn:escapeXml(currentNode.name)}"/>

<c:set var="teaser" value="${currentNode.properties['teaser'].string}"/>

<c:set var="subNodeView" value="${currentNode.properties['j:subNodesView'].string}"/>
<c:if test="${empty subNodeView}">
    <c:set var="subNodeView" value="default"/>
</c:if>

<template:include view="hidden.load"/>
<c:set var="listQuery" value="${moduleMap.listQuery}"/>
<jcr:jqom var="result" qomBeanName="listQuery" />

<c:choose>
    <c:when test="${empty result}">
        <p>${moduleMap.emptyListMessage}</p>
    </c:when>
    <c:otherwise>
        <section class="section">
            <div class="container">
                <div class="row justify-content-center mb-5">
                    <div class="col-md-8 text-center">
                        <c:out value="${not empty title ? '<h2>' + title + '</h2>' : ''}" escapeXml="false"/>
                        <c:out value="${not empty teaser ? teaser : ''}" escapeXml="false"/>
                    </div>
                </div>
                <div class="row">
                    <c:forEach items="${result.nodes}" var="node">
                        <div class="col-md-4  d-flex align-items-stretch mb-3">
                        <template:module view="${subNodeView}" node="${node}"/>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </section>
    </c:otherwise>
</c:choose>