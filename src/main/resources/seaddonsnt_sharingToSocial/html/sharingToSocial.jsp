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
<%--@elvariable id="currentNode"
type="org.jahia.services.content.JCRNodeWrapper" --%>
<%--@elvariable id="out" type="java.io.PrintWriter" --%>
<%--@elvariable id="script"
type="org.jahia.services.render.scripting.Script" --%>
<%--@elvariable id="scriptInfo" type="java.lang.String" --%>
<%--@elvariable id="workspace" type="java.lang.String" --%>
<%--@elvariable id="renderContext"
type="org.jahia.services.render.RenderContext" --%>
<%--@elvariable id="currentResource"
type="org.jahia.services.render.Resource" --%>
<%--@elvariable id="url"
type="org.jahia.services.render.URLGenerator"
--%>

<c:set var="title"
    value="${currentNode.properties['jcr:title'].string}" />
    <c:set var="facebookLink"
    value="${currentNode.properties['facebookLink'].boolean}" />
    <c:set var="twitterLink"
    value="${currentNode.properties['twitterLink'].boolean}" />
    <c:set var="linkedinLink"
    value="${currentNode.properties['linkedin'].boolean}" />
    <c:set var="mailTo"
    value="${currentNode.properties['mailTo'].boolean}" />
    <c:set var="copyToClipboard"
    value="${currentNode.properties['copyToClipboard'].boolean}" />

    <%--Retrieve the parent page--%>
<!--     <c:set var="parentPage" value="${jcr:getParentOfType(renderContext.mainResource.node, 'jnt:page')}"/>
    <c:if test="${empty parentPage}">
    </c:if> -->
    <c:set var="parentPage" value="${renderContext.mainResource.node}"/>

    <c:url var="parentPageUrl" value="${url.baseLive}${parentPage.path}.html"/>
    <c:set var="parentPageFullUrl" value="${url.server}${parentPageUrl}"/>
    <c:set var="parentPageTitle" value="${parentPage.properties['jcr:title'].string}"/>
    <c:set var="parentPageDesc" value="${parentPage.properties['jcr:description'].string}"/>


 <div class="d-flex justify-content-around align-items-center m-5">

    <!-- Facebook -->
    <c:if test="${facebookLink}">
        <a href="https://www.facebook.com/sharer/sharer.php?u=${parentPageFullUrl}"
            target="_blank"
            class="btn btn-outline-secondary">
            <i
                class="fab fa-facebook-f"></i>
        </a>
    </c:if>
    <!-- Twitter -->
    <c:if test="${twitterLink}">
        <a href="https://twitter.com/intent/tweet?text=${parentPageTitle}&url=${parentPageFullUrl}"
            target="_blank"
            class="btn btn-outline-secondary">
            <i class="fab fa-twitter"></i>
        </a>
    </c:if>
    <!-- LinkedIn -->
    <c:if test="${linkedinLink}">
        <a href="https://www.linkedin.com/shareArticle?mini=true&url=${parentPageFullUrl}&title=${parentPageTitle}&summary=${parentPageDesc}"
            target="_blank"
            class="btn btn-outline-secondary">
            <i
                class="fab fa-linkedin-in"></i>
        </a>
    </c:if>
    <!-- Email -->
    <c:if test="${mailTo}">
        <a href="mailto:?subject=${parentPageTitle}&body=${parentPageDesc}%20${parentPageFullUrl}"
            class="btn btn-outline-secondary">
            <i class="fas fa-envelope"></i>
        </a>
    </c:if>
    <!-- Copy to Clipboard -->
    <c:if test="${copyToClipboard}">

        <button
            class="btn btn-outline-secondary"
            id="copyToClipboard-${currentNode.identifier}">
            <i class="fas fa-copy"></i>
        </button>
    </c:if>
</div>


<script>
    // Copy current URL to clipboard
    document.getElementById('copyToClipboard-${currentNode.identifier}').addEventListener('click', function () {
        navigator.clipboard.writeText(window.location.href).then(() => {
            alert('URL copied to clipboard!');
        }).catch(err => {
            console.error('Could not copy text: ', err);
        });
    });
</script>