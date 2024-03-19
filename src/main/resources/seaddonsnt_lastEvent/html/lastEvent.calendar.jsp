<%@ taglib prefix="jcr" uri="http://www.jahia.org/tags/jcr" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="utility" uri="http://www.jahia.org/tags/utilityLib" %>
<%@ taglib prefix="template" uri="http://www.jahia.org/tags/templateLib" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="seutils" uri="https://www.se-extra-views.jahia.com/jahia/tags/1.0" %>

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
<template:addResources type="css" resources="fullCalendar.css"/>


<c:set var="teaser" value="${currentNode.properties['teaser'].string}"/>
<c:set var="maxItems" value="${currentNode.properties['maxItems'].long}"/>
<c:set var="folder" value="${currentNode.properties['folder'].node}"/>
<c:set var="filter" value="${currentNode.properties['filter'].node}"/>
<c:set var="subNodesView" value="${currentNode.properties['j:subNodesView'].string}"/>
<c:set var="title" value="${currentNode.properties['jcr:title'].string}"/>
<c:set var="description" value="${currentNode.properties['jcr:description'].string}"/>

<template:include view="hidden.load"/>
<c:set var="listQuery" value="${moduleMap.listQuery}"/>
<jcr:jqom var="result" qomBeanName="listQuery"/>
<c:set var="listQuery2" value="${moduleMap.listQuery2}"/>
<jcr:jqom var="result2" qomBeanName="listQuery2"/>

<c:choose>
    <c:when test="${empty result}">
        <p>${moduleMap.emptyListMessage}</p>
    </c:when>
    <c:otherwise>
        <div class="container">
            <did class="row d-flex">
            <div class="col-md-4">
                <div id="calendar">
                    <div class="header">
                        <span class="prev">&#10094;</span>
                        <span class="month-year"></span>
                        <span class="next">&#10095;</span>
                    </div>
                    <div class="days"></div>
                </div>
            </div>
            <div class="col-md-8">
                <div class="row">
                    <h2>${title}</h2>
                    <c:out value="${not empty teaser ? teaser : ''}" escapeXml="false"/>
                </div>
                <div class="row lastEvent d-flex align-items-stretch mb-3">
                    <c:forEach items="${result.nodes}" var="node">
                        <template:module view="${subNodesView}" node="${node}"/>
                    </c:forEach>
                </div>
            </div>
        </div>
        </div>
    </c:otherwise>
</c:choose>

<script>
    document.addEventListener('DOMContentLoaded', function () {
        const currentDate = new Date();
        let currentMonth = currentDate.getMonth();
        let currentYear = currentDate.getFullYear();

        const monthNames = ["January", "February", "March", "April", "May", "June",
            "July", "August", "September", "October", "November", "December"];

// Example highlighted dates. You would replace this with your actual dates.
        const highlightedDates = [];
        <c:forEach items="${result2.nodes}" var="node">
        highlightedDates.push("<fmt:formatDate pattern="yyyy-MM-dd" value="${node.properties['startDate'].time}"/>");
        highlightedDates.push("<fmt:formatDate pattern="yyyy-MM-dd" value="${node.properties['endDate'].time}"/>");
        </c:forEach>

        console.log(highlightedDates);

        function formatDate(year, month, day) {
            // Ensuring month and day are properly padded with zeros, avoiding backticks
            var monthStr = (month + 1).toString().padStart(2, '0'); // Adding 1 because JavaScript months are 0-indexed
            var dayStr = day.toString().padStart(2, '0');

            return year + '-' + monthStr + '-' + dayStr; // Concatenating strings the ancient way
        }


        function generateCalendar(month, year, highlightedDates) {
            var firstDay = new Date(year, month).getDay();
            var daysInMonth = new Date(year, month + 1, 0).getDate();

            var calendar = document.getElementById('calendar').getElementsByClassName('days')[0];
            calendar.innerHTML = '';

            // Crafting the month and year string without backticks
            var monthYearStr = monthNames[month] + ' ' + year.toString();
            document.querySelector('.month-year').textContent = monthYearStr;

            var date = 1;
            for (var i = 0; i < 6; i++) {
                var row = document.createElement('div');
                row.className = 'week';
                for (var j = 0; j < 7; j++) {
                    if (i === 0 && j < firstDay) {
                        var cell = document.createElement('div');
                        cell.className = 'day';
                        row.appendChild(cell);
                    } else if (date > daysInMonth) {
                        break;
                    } else {
                        var formattedDate = formatDate(year, month, date);
                        var cell = document.createElement('div');
                        cell.className = 'day';
                        if (highlightedDates.includes(formattedDate)) {
                            var link = document.createElement('a');
                            link.href = '?date=' + formattedDate; // Classic string concatenation
                            link.className = 'highlighted';
                            link.textContent = date.toString();
                            cell.appendChild(link);
                        } else {
                            cell.textContent = date.toString();
                        }
                        row.appendChild(cell);
                        date++;
                    }
                }
                calendar.appendChild(row);
                if (date > daysInMonth) {
                    break;
                }
            }
        }


        document.querySelector('.prev').addEventListener('click', function () {
            currentYear = (currentMonth === 0) ? currentYear - 1 : currentYear;
            currentMonth = (currentMonth === 0) ? 11 : currentMonth - 1;
            generateCalendar(currentMonth, currentYear, highlightedDates);
        });

        document.querySelector('.next').addEventListener('click', function () {
            currentYear = (currentMonth === 11) ? currentYear + 1 : currentYear;
            currentMonth = (currentMonth === 11) ? 0 : currentMonth + 1;
            generateCalendar(currentMonth, currentYear, highlightedDates);
        });

        generateCalendar(currentMonth, currentYear, highlightedDates);
    });
</script>