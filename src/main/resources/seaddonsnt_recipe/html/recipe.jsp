<%@ taglib prefix="jcr" uri="http://www.jahia.org/tags/jcr" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="utility" uri="http://www.jahia.org/tags/utilityLib" %>
<%@ taglib prefix="template" uri="http://www.jahia.org/tags/templateLib" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<template:addResources type="css" resources="recipeCard.css"/>
<c:set var="image" value="${currentNode.properties['image'].node}"/>
<c:set var="title" value="${currentNode.properties['jcr:title'].string}"/>
<c:set var="difficulty" value="${currentNode.properties['difficulty'].long}"/>
<c:set var="serves" value="${currentNode.properties['serves'].long}"/>
<c:set var="preparation" value="${currentNode.properties['preparation'].string}"/>
<c:set var="cooking" value="${currentNode.properties['cooking'].string}"/>


<div class="recipe-card">
    <div class="wrapper">
        <div class="image">
            <c:if test="${not empty image}">
                <img class="card-img-top" src="${image.url}" alt="${currentNode.displayableName}" />
            </c:if>
        </div>
        <div class="data">
            <div class="content">
                <h1 class="title"><a href="${currentNode.path}.fullView.html">${title}</a></h1>
                <ul class="list-group list-group-flush">
                    <li class="list-group-item"><strong>Difficulty:</strong>
                        <div class="star-rating">
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
                    <li class="list-group-item"><strong>Serves:</strong> ${serves}</li>
                    <li class="list-group-item"><strong>Preparation Time:</strong>${preparation}</li>
                    <li class="list-group-item"><strong>Cooking Time:</strong>${cooking}</li>
                </ul>
            </div>
            <ul class="menu-content">
                <jcr:nodeProperty node="${currentNode}" name="j:defaultCategory" var="cat"/>
                <c:if test="${cat != null}">
                    <c:forEach items="${cat}" var="category">
                        <li>${category.node.displayableName}</li>
                    </c:forEach>
                </c:if>
            </ul>
            <a href="${currentNode.path}.fullView.html" class="btn btn-primary mt-3">View Full Recipe</a>
        </div>
    </div>
</div>

