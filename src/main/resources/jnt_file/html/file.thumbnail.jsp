<%@ page import="org.jahia.utils.FileUtils" %>
<%@ page import="org.jahia.services.content.JCRNodeWrapper" %>
<%@ taglib prefix="jcr" uri="http://www.jahia.org/tags/jcr" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="template" uri="http://www.jahia.org/tags/templateLib" %>


<template:addResources type="css"
    resources="eventCard.css" />
<jcr:nodeProperty node="${currentNode}" name="jcr:title" var="title" />
<jcr:nodeProperty node="${currentNode}" name="jcr:description" var="description" />
<jcr:nodeProperty node="${currentNode}" name="jcr:created" var="created" />
<fmt:formatDate value="${created.time}" dateStyle="full" var="displayDate" />


<div class="card col-md-3 d-flex align-items-stretch m-2">
    <img class="card-img-top" src="${currentNode.url}?t=thumbnail" alt="Card image" style="width:100%">
    <div class="card-body">
        <h5 class="card-title">
           ${title ? title : currentNode.name}
        </h5>
        <p class="card-text">
            <ul>
                <li>${displayDate}</li>
                <li>${currentNode.fileContent.contentType}</li>
                <li>${currentNode.fileContent.contentLength}&nbsp;bytes</li>
            </ul>
        </p>
        <p class="card-footer"> 
            <a href="${currentNode.url}" class="btn btn-primary btn-bottom">
                <fmt:message key='label.file.download' />
            </a>
        </p>
    </div>
</div>