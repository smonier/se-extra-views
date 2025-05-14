<%@ taglib prefix="jcr" uri="http://www.jahia.org/tags/jcr" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="utility" uri="http://www.jahia.org/tags/utilityLib" %>
<%@ taglib prefix="template" uri="http://www.jahia.org/tags/templateLib" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

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

<c:set var="datePostedISO">
	<fmt:formatDate value="${currentNode.properties['datePosted'].time}" pattern="yyyy-MM-dd" />
</c:set>
<c:set var="validThroughISO">
	<fmt:formatDate value="${currentNode.properties['validThrough'].time}" pattern="yyyy-MM-dd" />
</c:set>

<script type="application/ld+json">
	{
      "@context": "https://schema.org",
      "@type": "JobPosting",
      "title": "${fn:escapeXml(currentResource.moduleParams.title)}",
  "description": "${fn:escapeXml(currentResource.moduleParams.description)}",
  "identifier": {
    "@type": "PropertyValue",
    "name": "${fn:escapeXml(currentResource.moduleParams.hiringOrganization)}",
    "value": "${fn:escapeXml(currentResource.moduleParams.jobId)}"
  },
  "datePosted": "${datePostedISO}",
	<c:if test="${not empty currentResource.moduleParams.validThrough}">
		"validThrough": "${validThroughISO}",
	</c:if>
	"employmentType": "${currentResource.moduleParams.employmentType}",
  "hiringOrganization": {
    "@type": "Organization",
    "name": "${fn:escapeXml(currentResource.moduleParams.hiringOrganization)}",
    "sameAs": "${currentResource.moduleParams.organizationUrl}"<c:if test="${not empty currentResource.moduleParams.logo}">,
	"logo": "${currentResource.moduleParams.logo}"</c:if>
	},
    "jobLocation": {
      "@type": "Place",
      "address": {
        "@type": "PostalAddress",
        "streetAddress": "${fn:escapeXml(currentResource.moduleParams.locationAddress)}",
      "postalCode": "${currentResource.moduleParams.locationPostalCode}",
      "addressLocality": "${currentResource.moduleParams.locationCity}",
      "addressCountry": "${currentResource.moduleParams.locationCountry}"
    }
  },
	<c:if test="${not empty currentResource.moduleParams.baseSalary}">
		"baseSalary": {
		"@type": "MonetaryAmount",
		"currency": "${currentResource.moduleParams.salaryCurrency}",
		"value": {
		"@type": "QuantitativeValue",
		"value": ${currentResource.moduleParams.baseSalary},
		"unitText": "${currentResource.moduleParams.salaryUnit}"
		}
		},
	</c:if>
	"url": "${currentResource.moduleParams.organizationUrl}"
}
</script>
