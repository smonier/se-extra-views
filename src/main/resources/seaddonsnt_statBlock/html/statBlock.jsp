<%@ page language="java" contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="template" uri="http://www.jahia.org/tags/templateLib" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="jcr" uri="http://www.jahia.org/tags/jcr" %>
<%@ taglib prefix="ui" uri="http://www.jahia.org/tags/uiComponentsLib" %>
<%@ taglib prefix="functions" uri="http://www.jahia.org/tags/functions" %>
<%@ taglib prefix="query" uri="http://www.jahia.org/tags/queryLib" %>
<%@ taglib prefix="utility" uri="http://www.jahia.org/tags/utilityLib" %>
<%@ taglib prefix="s" uri="http://www.jahia.org/tags/search" %>

<c:set var="title" value="${currentNode.properties['jcr:title'].string}"/>
<c:set var="number" value="${currentNode.properties['number'].long}"/>

			<div class="col-6 col-md-3 mb-4">
				<h2 class="display-5 fw-bold count-number text-white" data-target="${number}">0</h2>
				<p class="text-muted text-white">${title}</p>
			</div>


<script>
	document.addEventListener("DOMContentLoaded", () => {
		const counters = document.querySelectorAll(".count-number");

		counters.forEach(counter => {
			const target = +counter.getAttribute("data-target");
			const duration = 1500;
			const frameRate = 30;
			const steps = duration / frameRate;
			const increment = target / steps;

			let count = 0;
			const update = () => {
				count += increment;
				if (count < target) {
					counter.innerText = Math.floor(count);
					requestAnimationFrame(update);
				} else {
					counter.innerText = target;
				}
			};
			update();
		});
	});
</script>