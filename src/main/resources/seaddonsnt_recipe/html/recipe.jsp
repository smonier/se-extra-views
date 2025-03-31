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
<c:set var="ingredients" value="${currentNode.properties['ingredients'].string}"/>
<c:set var="instructions" value="${currentNode.properties['instructions'].string}"/>

<c:url value="${currentNode.url}" var="contentURL"/>

<div class="inner-page">
    <div class="slider-item" style="background-image: url('${image.url}');">
        <div class="container">
            <div class="row slider-text align-items-center justify-content-center">
                <div class="col-md-8 text-center col-sm-12 pt-5 element-animate">
                    <h1 class="pt-5"><span>${title}</span></h1>
                    <%-- --%>
                    <div>
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
                    </div>                    <%--                    <h1 class="pt-5"><span>About Us</span></h1>--%>
                    <%--                    <p class="mb-5 w-75">Lorem ipsum dolor sit amet, consectetur adipisicing elit. Vero sit, saepe? Rem, libero repellendus eum.</p>--%>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="container recipe-full-view mt-4">
    <div class="row">
        <!-- Left Column: Image and Recipe Details -->
        <div class="col-md-6 text-center">
            <c:if test="${not empty image}">
                <img class="img-fluid rounded shadow mb-3" src="${image.url}" alt="${currentNode.displayableName}" />
            </c:if>
            <h3 class="pt-5"><span>${title}</span></h3>

            <ul class="list-group list-group-flush text-left ml-5 mt-5">
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
            <div class="space-between mt-5">
                <div class="pull-right">
                    <jcr:nodeProperty node="${currentNode}" name="j:tagList" var="tags"/>
                    <c:if test="${tags != null}">
                        <c:forEach items="${tags}" var="tag">
                            <span class="badge badge-success">${tag}</span>
                        </c:forEach>
                    </c:if>
                </div>
            </div>
        </div>

        <!-- Right Column: Ingredients and Instructions -->
        <div class="col-md-6">
<%--            <h2><i class="bi bi-list-ul"></i> Ingredients</h2>--%>
            <div class="recipe-content">
                ${ingredients}
            </div>

<%--            <h2 class="mt-4"><i class="bi bi-journal-text"></i> Instructions</h2>--%>
            <div class="recipe-content">
                ${instructions}
            </div>
        </div>
    </div>
</div>
