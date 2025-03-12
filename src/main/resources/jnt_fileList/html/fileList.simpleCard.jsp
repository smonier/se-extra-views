
<%@ taglib prefix="jcr" uri="http://www.jahia.org/tags/jcr" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="template" uri="http://www.jahia.org/tags/templateLib" %>
<c:set var="targetNodePath" value="${renderContext.mainResource.node.path}"/>
<c:if test="${!empty param.targetNodePath}">
    <c:set var="targetNodePath" value="${param.targetNodePath}"/>
</c:if>
<c:if test="${!empty currentNode.properties['j:target']}">
    <c:set var="target" value="${currentNode.properties['j:target'].string}"/>
</c:if>
<c:if test="${!empty currentNode.properties.folder}">
    <c:set var="targetNodePath" value="${currentNode.properties.folder.node.path}"/>
</c:if>
<jcr:node var="targetNode" path="${targetNodePath}"/>
<div id="fileList${currentNode.identifier}">
    <template:addResources type="css" resources="fileList.css"/>
    <div class="row justify-content-center">
        <c:forEach items="${targetNode.nodes}" var="subchild">
            <c:if test="${jcr:isNodeType(subchild, 'jnt:file')}">
                    <template:module node="${subchild}" view="simpleCard" editable="false">
                        <template:param name="useNodeNameAsTitle" value="${currentNode.properties.useNodeNameAsTitle.boolean}"/>
                        <template:param name="target" value="${target}"/>
                    </template:module>
            </c:if>
        </c:forEach>
    </div>
</div>
<template:addCacheDependency path="${targetNodePath}"/>