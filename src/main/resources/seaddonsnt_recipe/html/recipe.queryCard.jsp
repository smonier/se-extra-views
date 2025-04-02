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

<template:include view="hidden.schema.org">
    <template:param name="title" value="${title}"/>
    <template:param name="serves" value="${serves}"/>
    <template:param name="image" value="${image.url}"/>
    <template:param name="preparation" value="${preparation}"/>
    <template:param name="cooking" value="${cooking}"/>
    <template:param name="difficulty" value="${currentNode.properties['difficulty'].string}"/>
</template:include>

<div class="food-card">
    <div class="food-card_img">
        <img src="${image.url}" alt="">
    </div>
    <div class="food-card_content">
        <div class="food-card_title-section">
            <a href="${contentURL}" class="food-card_title" style="font-size: 1.2rem;color: #E02923">${title}</a>
        </div>
        <div class="food-card_bottom-section">
                    <i class="fas fa-chart-bar m-3"></i>

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
            <br/>
            <i class="fas fa-clock m-3"></i> <fmt:message key='recipe.label.time.${preparation}'/>
            <br/>
            <i class="fas fa-hourglass-half m-3"></i> <fmt:message key='recipe.label.time.${cooking}'/>
            <hr>
            <div class="btn-container mb-2">
                <a class="btn btn-primary" href="${contentURL}">
                    <fmt:message key='recipe.label.view'/>
                </a>
            </div>
        </div>
    </div>
</div>
