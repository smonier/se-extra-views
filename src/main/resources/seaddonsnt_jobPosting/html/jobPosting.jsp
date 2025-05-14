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

<div class="container py-5">
	<div class="row align-items-center mb-4">
		<div class="col-md-2">
			<c:if test="${not empty logo}">
				<img class="img-fluid rounded shadow-sm" width="200px" src="<c:url value='${logo.url}'/>" alt="${hiringOrganization} logo"/>
			</c:if>
		</div>
		<div class="col-md-10">
			<h1 class="display-5 fw-bold mb-1">${title}</h1>
			<p class="text-muted mb-0">${hiringOrganization}</p>
			<c:if test="${not empty organizationUrl}">
				<p><a href="${organizationUrl}" target="_blank" rel="noopener noreferrer">
					<fmt:message key="seaddonsnt_jobPosting.label.organizationWebsite"/>
				</a></p>
			</c:if>
		</div>
	</div>

	<div class="row gy-4">
		<div class="col-md-8">
			<div class="mb-4">
				<h4 class="fw-semibold text-primary">
					<fmt:message key="seaddonsnt_jobPosting.label.description"/>
				</h4>
				<div class="text-body">${description}</div>
			</div>

			<div class="mb-4">
				<h5 class="fw-semibold">
					<fmt:message key="seaddonsnt_jobPosting.label.title"/>
				</h5>
				<ul class="list-group list-group-flush">
					<li class="list-group-item">
						<strong><fmt:message key="seaddonsnt_jobPosting.label.jobId"/> :</strong> ${jobId}
					</li>
					<li class="list-group-item">
						<strong><fmt:message key="seaddonsnt_jobPosting.label.employmentType"/> :</strong> <fmt:message key="seaddonsnt_jobPosting.employmentType.${employmentType}"/>
					</li>
					<li class="list-group-item">
						<strong><fmt:message key="seaddonsnt_jobPosting.label.datePosted"/> :</strong>
						<fmt:formatDate value="${datePosted.time}" pattern="dd/MM/yyyy"/>
					</li>
					<c:if test="${not empty validThrough}">
						<li class="list-group-item">
							<strong><fmt:message key="seaddonsnt_jobPosting.label.validThrough"/> :</strong>
							<fmt:formatDate value="${validThrough.time}" pattern="dd/MM/yyyy"/>
						</li>
					</c:if>
				</ul>
			</div>

			<div class="mb-4">
				<h5 class="fw-semibold">
					<fmt:message key="seaddonsnt_jobPosting.label.salary"/>
				</h5>
				<p>
					<c:if test="${not empty baseSalary}">
						${baseSalary} <fmt:message key="seaddonsnt_jobPosting.salaryCurrency.${salaryCurrency}"/> / <fmt:message key="seaddonsnt_jobPosting.salaryUnit.${salaryUnit}"/>
					</c:if>
				</p>
			</div>
		</div>

		<div class="col-md-4">
			<div class="card shadow-sm">
				<div class="card-body">
					<h5 class="card-title text-primary">
						<fmt:message key="seaddonsnt_jobPosting.label.address"/>
					</h5>
					<p class="card-text">
						${locationAddress}<br/>
						${locationPostalCode} ${locationCity}<br/>
						${locationCountry}
					</p>

					<h5 class="card-title mt-4 text-primary">
						<fmt:message key="seaddonsnt_jobPosting.label.contact"/>
					</h5>
					<p class="card-text">
						<c:if test="${not empty contactEmail}">
							<fmt:message key="seaddonsnt_jobPosting.label.email"/> :
							<a href="mailto:${contactEmail}">${contactEmail}</a><br/>
						</c:if>
						<c:if test="${not empty contactPhone}">
							<fmt:message key="seaddonsnt_jobPosting.label.phone"/> :
							${contactPhone}
						</c:if>
					</p>

					<c:if test="${not empty validThrough}">
						<div class="alert alert-warning mt-4" role="alert">
							<fmt:message key="seaddonsnt_jobPosting.label.closingReminder"/> :
							<fmt:formatDate value="${validThrough.time}" pattern="dd MMMM yyyy" />
						</div>
					</c:if>
				</div>
			</div>
		</div>
	</div>
</div>