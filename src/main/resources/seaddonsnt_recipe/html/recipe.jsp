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
<c:set var="ingredients" value="${currentNode.properties['ingredients']}"/>
<c:set var="instructions" value="${currentNode.properties['instructions']}"/>
<c:set var="categories" value="${currentNode.properties['j:defaultCategory']}"/>

<c:url value="${currentNode.url}" var="contentURL"/>

<template:include view="hidden.schema.org">
    <template:param name="title" value="${title}"/>
    <template:param name="serves" value="${serves}"/>
    <template:param name="image" value="${image.url}"/>
    <template:param name="preparation" value="${preparation}"/>
    <template:param name="cooking" value="${cooking}"/>
    <template:param name="difficulty" value="${currentNode.properties['difficulty'].string}"/>
</template:include>

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
            <div class="space-between mt-5">
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
        </div>

        <!-- Right Column: Ingredients and Instructions -->
        <div class="col-md-6">
<%--            --%>
            <div class="recipe-content">
                <h2><i class="bi bi-list-ul"></i> <fmt:message key='seaddonsnt_recipe.ingredients'/></h2>
                <ul>
                <c:forEach var="ingredient" items="${ingredients}" varStatus="status">
                    <li>${ingredient}</li>
                </c:forEach>
                </ul>
            </div>

<%--            --%>
            <div class="recipe-content">
                <h2 class="mt-4"><i class="bi bi-journal-text"></i> <fmt:message key='seaddonsnt_recipe.instructions'/></h2>
                <ol>
                <c:forEach var="instruction" items="${instructions}" varStatus="status">
                    <li>${instruction}</li>
                </c:forEach>
                </ol>
            </div>
        </div>
    </div>

</div>
<div class="section">
    <div class="container">
        <div class="row justify-content-center mb-5">
            <div class="col-md-8 text-center">
                <h2><fmt:message key='recipe.label.youlike'/></h2>
            </div>
        </div>
        <div class="row">
            <template:include view="hidden.load"/>
            <c:set var="listQuery" value="${moduleMap.listQuery}"/>
            <jcr:jqom var="result" qomBeanName="listQuery" />

            <c:forEach items="${result.nodes}" var="node">
                <c:if test="${node.identifier != currentNode.identifier}">
                    <div class="col-md-4 d-flex align-items-stretch mb-3">
                            <template:module view="queryCard" node="${node}"/>
                    </div>
                </c:if>
            </c:forEach>
        </div>
    </div>
</div>
