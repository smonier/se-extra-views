<%@ taglib prefix="jcr" uri="http://www.jahia.org/tags/jcr" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="utility" uri="http://www.jahia.org/tags/utilityLib" %>
<%@ taglib prefix="template" uri="http://www.jahia.org/tags/templateLib" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%--@elvariable id="currentNode" type="org.jahia.services.content.JCRNodeWrapper"--%>
<%--@elvariable id="out" type="java.io.PrintWriter"--%>
<%--@elvariable id="script" type="org.jahia.services.render.scripting.Script"--%>
<%--@elvariable id="scriptInfo" type="java.lang.String"--%>
<%--@elvariable id="workspace" type="java.lang.String"--%>
<%--@elvariable id="renderContext" type="org.jahia.services.render.RenderContext"--%>
<%--@elvariable id="currentResource" type="org.jahia.services.render.Resource"--%>
<%--@elvariable id="url" type="org.jahia.services.render.URLGenerator"--%>

<c:if test="${renderContext.editMode}">
	<legend>${fn:escapeXml(jcr:label(currentNode.primaryNodeType, currentResource.locale))}</legend>
</c:if>


<c:set var="description" value="${currentNode.properties['description'].string}"/>
<c:set var="jobId" value="${currentNode.properties['jobId'].string}"/>
<c:set var="employmentType" value="${currentNode.properties['employmentType'].string}"/>
<c:set var="datePosted" value="${currentNode.properties['datePosted'].date}"/>
<c:set var="validThrough" value="${currentNode.properties['validThrough'].date}"/>
<c:set var="hiringOrganization" value="${currentNode.properties['hiringOrganization'].string}"/>
<c:set var="organizationUrl" value="${currentNode.properties['organizationUrl'].string}"/>
<c:set var="logo" value="${currentNode.properties['logo'].node}"/>
<c:set var="locationAddress" value="${currentNode.properties['locationAddress'].string}"/>
<c:set var="locationPostalCode" value="${currentNode.properties['locationPostalCode'].string}"/>
<c:set var="locationCity" value="${currentNode.properties['locationCity'].string}"/>
<c:set var="locationCountry" value="${currentNode.properties['locationCountry'].string}"/>
<c:set var="baseSalary" value="${currentNode.properties['baseSalary'].decimal}"/>
<c:set var="salaryCurrency" value="${currentNode.properties['salaryCurrency'].string}"/>
<c:set var="salaryUnit" value="${currentNode.properties['salaryUnit'].string}"/>
<c:set var="contactEmail" value="${currentNode.properties['contactEmail'].string}"/>
<c:set var="contactPhone" value="${currentNode.properties['contactPhone'].string}"/>
<c:set var="title" value="${currentNode.properties['jcr:title'].string}"/>
<c:url value="${currentNode.url}" var="contentURL"/>

<c:set var="defaultCategory" value="${currentNode.properties['j:defaultCategory']}"/>
<c:set var="keywords" value="${currentNode.properties['j:keywords']}"/>
<c:set var="tagList" value="${currentNode.properties['j:tagList']}"/>
<c:set var="tags" value="${currentNode.properties['j:tags']}"/>

<template:include view="hidden.schema.org">
	<template:param name="title" value="${fn:escapeXml(title)}"/>
	<template:param name="description" value="${fn:escapeXml(description)}"/>
	<template:param name="jobId" value="${jobId}"/>
	<template:param name="employmentType" value="${employmentType}"/>
	<template:param name="datePosted" value="${datePosted.time}"/>
	<template:param name="validThrough" value="${validThrough.time}"/>
	<template:param name="hiringOrganization" value="${hiringOrganization}"/>
	<template:param name="organizationUrl" value="${organizationUrl}"/>
	<template:param name="logoUrl" value="${logo.url}"/>
	<template:param name="locationAddress" value="${locationAddress}"/>
	<template:param name="locationPostalCode" value="${locationPostalCode}"/>
	<template:param name="locationCity" value="${locationCity}"/>
	<template:param name="locationCountry" value="${locationCountry}"/>
	<template:param name="baseSalary" value="${baseSalary}"/>
	<template:param name="salaryCurrency" value="${salaryCurrency}"/>
	<template:param name="salaryUnit" value="${salaryUnit}"/>
	<template:param name="contactEmail" value="${contactEmail}"/>
	<template:param name="contactPhone" value="${contactPhone}"/>
</template:include>

<div class="col-lg-4 col-md-6 mb-4">
	<div class="card h-100 shadow-sm border-0">
		<c:if test="${not empty logo}">
			<img src="<c:url value='${logo.url}'/>" class="card-img-top img-fluid p-3" alt="${title}" style="max-height: 120px; object-fit: contain;">
		</c:if>
		<div class="card-body d-flex flex-column">
			<h5 class="card-title fw-semibold">${title}</h5>
			<p class="card-subtitle text-muted mb-2">${locationCity}, ${locationCountry}</p>

			<p class="mb-2">
        <span class="badge bg-primary">
          <fmt:message key="seaddonsnt_jobPosting.employmentType.${employmentType}" />
        </span>
			</p>

			<c:if test="${not empty baseSalary}">
				<p class="mb-1 small text-dark">
					${baseSalary}
					<fmt:message key="seaddonsnt_jobPosting.salaryCurrency.${salaryCurrency}" /> /
					<fmt:message key="seaddonsnt_jobPosting.salaryUnit.${salaryUnit}" />
				</p>
			</c:if>

			<c:if test="${not empty validThrough}">
				<p class="mb-3 small text-muted">
					<fmt:message key="seaddonsnt_jobPosting.label.closingReminder" /> :
					<fmt:formatDate value="${validThrough.time}" pattern="dd/MM/yyyy" />
				</p>
			</c:if>

			<a href="<c:url value='${contentURL}'/>" class="btn btn-outline-primary mt-auto">
				<fmt:message key="seaddonsnt_jobPosting.label.seeOffer" />
			</a>
		</div>
	</div>
</div>