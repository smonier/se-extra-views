<%@ page language="java" contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%--<c:set var="host" value="${url.server}"/>--%>
<c:set var="tags" value="${currentNode.properties['j:tagList']}"/>
<c:set var="seoKeywords" value="${currentNode.properties['seoKeywords']}"/>

<c:set var="categories" value=""/>
<c:set var="nodeCategories" value="${currentNode.properties['j:defaultCategory']}"/>
<c:forEach var="category" items="${nodeCategories}" varStatus="status">
    <c:set var="categories" value="${categories}${category.node.displayableName}"/>
    <c:if test="${!status.last}">
        <c:set var="categories" value="${categories} > "/>
    </c:if>
</c:forEach>
<c:set var="ingredients" value="${currentNode.properties['ingredients']}"/>
<c:set var="instructions" value="${currentNode.properties['instructions']}"/>
<script type="application/ld+json">
{
    "@context": "https://schema.org/",
    "@type": "Recipe",
    "name": "${currentResource.moduleParams.title}",
    <c:if test="${not empty currentResource.moduleParams.image}">
        "image": "${currentResource.moduleParams.image}",
    </c:if>
    "recipeYield":"${currentResource.moduleParams.serves}",
    "prepTime":"${currentResource.moduleParams.preparation}",
    "cookTime":"${currentResource.moduleParams.cooking}",
    "recipeIngredient": [
    <c:forEach var="ingredient" items="${ingredients}" varStatus="status">
            {
              "@value": "${ingredient}",
              "inLanguage": "${currentResource.locale.language}"
            }<c:if test="${!status.last}"> </c:if>
    </c:forEach>
    ],
    "recipeInstructions": {
        "@type": "ItemList",
        "itemListElement": [
            <c:forEach var="instruction" items="${instructions}" varStatus="status">
                {
                    "@type": "HowToStep",
                    "position": ${status.index + 1},
                    "text": "${instruction}"
                }<c:if test="${!status.last}"> </c:if>
            </c:forEach>
        ]
      },
      "additionalProperty": [
        {
            "@type": "PropertyValue",
            "name": "difficulty",
            "value": "${currentResource.moduleParams.difficulty}"
        }
    ],
    <c:if test="${tags != null}">
        "keywords": [
        <c:forEach var="tag" items="${tags}" varStatus="status">
            "${tag}"<c:if test="${!status.last}"> </c:if>
        </c:forEach>
        ]
    </c:if>
}
</script>
