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
<c:set var="categories" value="${currentNode.properties['j:defaultCategory']}"/>

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
            <a href="${contentURL}" class="food-card_title">${title}</a>
        </div>
        <div class="food-card_author">
            <ul class="list-group list-group-flush text-left ml-1 mt-2">
                <li class="d-flex align-items-center"><i class="fas fa-chart-bar m-3"></i> <strong><fmt:message key='seaddonsnt_recipe.difficulty'/>:</strong>
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
                <li class="d-flex align-items-center"><i class="fas fa-users m-3"></i> <strong class="mr-3"><fmt:message key='seaddonsnt_recipe.serves'/>:</strong>   ${serves}</li>
                <li class="d-flex align-items-center"><i class="fas fa-clock m-3"></i> <strong class="mr-3"><fmt:message key='recipe.label.preparation'/>:</strong> <fmt:message key='recipe.label.time.${preparation}'/></li>
                <li class="d-flex align-items-center"><i class="fas fa-hourglass-half m-3"></i> <strong class="mr-3"><fmt:message key='recipe.label.cooking'/>:</strong> <fmt:message key='recipe.label.time.${cooking}'/> </li>
            </ul>
        </div>
        <div class="food-card_bottom-section">
            <div class="space-between">
                <div class="pull-right">
                    <c:if test="${categories != null}">
                        <c:forEach items="${categories}" var="category">
                <span class="badge badge-secondary">
                        ${category.node.displayableName}
                </span>
                        </c:forEach>
                    </c:if>
                    <jcr:nodeProperty node="${currentNode}" name="j:tagList" var="tags"/>
                    <c:if test="${tags != null}">
                        <c:forEach items="${tags}" var="tag">
                            <span class="badge badge-success">${tag}</span>
                        </c:forEach>
                    </c:if>
                </div>
            </div>
            <hr>
            <div class="btn-container mb-2">
                <a class="btn btn-primary" href="${contentURL}">
                    <fmt:message key='recipe.label.view'/>
                </a>
            </div>
        </div>
    </div>
</div>
