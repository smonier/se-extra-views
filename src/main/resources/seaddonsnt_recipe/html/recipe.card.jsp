<%@ taglib prefix="jcr" uri="http://www.jahia.org/tags/jcr" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="utility" uri="http://www.jahia.org/tags/utilityLib" %>
<%@ taglib prefix="template" uri="http://www.jahia.org/tags/templateLib" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<template:addResources type="css" resources="recipeCard.css"/>
<template:addResources type="css" resources="foodCard.css"/>

<c:set var="image" value="${currentNode.properties['image'].node}"/>
<c:set var="title" value="${currentNode.properties['jcr:title'].string}"/>
<c:set var="difficulty" value="${currentNode.properties['difficulty'].long}"/>
<c:set var="serves" value="${currentNode.properties['serves'].long}"/>
<c:set var="preparation" value="${currentNode.properties['preparation'].string}"/>
<c:set var="cooking" value="${currentNode.properties['cooking'].string}"/>
<c:url value="${currentNode.url}" var="contentURL"/>


<div class="food-card">
    <div class="food-card_img">
        <img src="${image.url}" alt="">
    </div>
    <div class="food-card_content">
        <div class="food-card_title-section">
            <a href="${contentURL}" class="food-card_title">${title}</a>
        </div>
        <div class="food-card_author">
            <ul class="list-group list-group-flush text-left">
                <li class="d-flex align-items-center"><i class="fas fa-chart-bar m-3"></i> <strong>Difficulty:</strong>
                    <div class="ml-3">
                        <c:forEach begin="1" end="5" var="i">
                            <c:choose>
                                <c:when test="${i <= difficulty}">
                                    <span class="star filled">&#9733;</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="star">&#9734;</span>
                                </c:otherwise>
                            </c:choose>
                        </c:forEach>
                    </div>
                </li>
                <li class="d-flex align-items-center"><i class="fas fa-users m-3"></i> <strong class="mr-3">Serves:</strong>   ${serves}</li>
                <li class="d-flex align-items-center"><i class="fas fa-clock m-3"></i> <strong class="mr-3">Preparation Time:</strong>   ${preparation}</li>
                <li class="d-flex align-items-center"><i class="fas fa-hourglass-half m-3"></i> <strong class="mr-3">Cooking Time:</strong>   ${cooking}</li>
            </ul>
        </div>
        <div class="food-card_bottom-section">
            <div class="space-between">
                <div class="pull-right">
                    <jcr:nodeProperty node="${currentNode}" name="j:tagList" var="tags"/>
                    <c:if test="${tags != null}">
                        <c:forEach items="${tags}" var="tag">
                            <span class="badge badge-primary">${tag}</span>
                        </c:forEach>
                    </c:if>
                </div>
            </div>
            <hr>
            <div class="btn-container mb-2">
                <a class="btn btn-primary" href="${contentURL}">
                    View recipe
                </a>
            </div>
        </div>
    </div>
</div>
