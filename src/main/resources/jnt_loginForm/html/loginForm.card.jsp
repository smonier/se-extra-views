<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="ui" uri="http://www.jahia.org/tags/uiComponentsLib" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="template" uri="http://www.jahia.org/tags/templateLib" %>
<%@ taglib prefix="jcr" uri="http://www.jahia.org/tags/jcr" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%--@elvariable id="currentNode" type="org.jahia.services.content.JCRNodeWrapper" --%>
<%--@elvariable id="out" type="java.io.PrintWriter" --%>
<%--@elvariable id="script" type="org.jahia.services.render.scripting.Script" --%>
<%--@elvariable id="scriptInfo" type="java.lang.String" --%>
<%--@elvariable id="workspace" type="java.lang.String" --%>
<%--@elvariable id="renderContext"
type="org.jahia.services.render.RenderContext" --%>
<%--@elvariable id="currentResource"
type="org.jahia.services.render.Resource" --%>
<%--@elvariable id="url"
type="org.jahia.services.render.URLGenerator" --%>
<%--@elvariable id="currentAliasUser"
type="org.jahia.services.usermanager.JahiaUser" --%>

<template:addResources type="css"
    resources="loginForm.css" />

<c:if
    test="${!renderContext.loggedIn || currentAliasUser.username eq 'guest'}">
    <ui:loginArea class="loginForm p-4"
        onsubmit="loginButton.disabled = true; return true;">
        <h3 class="loginicon">
            ${fn:escapeXml(currentNode.displayableName)}
        </h3>
        <ui:isLoginError var="loginResult">
            <span class="error">
                <fmt:message
                    key="${loginResult == 'account_locked' ? 'message.accountLocked' : 'message.invalidUsernamePassword'}" />
            </span>
        </ui:isLoginError>
        <c:if test="${not empty param['loginError']}">
            <span class="error">
                <fmt:message
                    key="${param['loginError'] == 'account_locked' ? 'message.accountLocked' : 'message.invalidUsernamePassword'}" />
            </span>
        </c:if>


        <p>
            <label class="left" for="username">
                <fmt:message key="label.username" />
            </label>
            <input class="full form-control" type="text" value=""
                tabindex="1" maxlength="250" name="username"
                id="username" />
        </p>

        <p>
            <label class="left" for="password">
                <fmt:message key="label.password" />
            </label>
            <input class="full form-control" type="password" tabindex="2"
                maxlength="250" name="password"
                id="password" autocomplete="off" />
        </p>

        <p>
            <input type="checkbox" id="rememberme"
                name="useCookie" />
            <label for="rememberme" class="rememberLabel">
                <fmt:message
                    key="loginForm.rememberMe.label" />
            </label>

        </p>

        <div class="divButton">
            <input type="submit" name="loginButton"
                class="btn btn-primary"
                value="<fmt:message key='loginForm.loginbutton.label'/>" />
            &nbsp;&nbsp;
            <c:if test="${jcr:isNodeType(currentNode, 'seaddonsmix:withRegistration')}">
                <c:set var="linkedNode" value="${currentNode.properties['registrationPage'].node}"/>
                <c:set var="linkUrl" value="${linkedNode.getUrl()}"/>
                <a href="${linkUrl}" class="btn btn-primary" target="_self">${currentNode.properties['buttonLabel'].string}</a>
            </c:if>
        </div>

    </ui:loginArea>
        
</c:if>
<c:if
    test="${renderContext.loggedIn &&  !(currentAliasUser.username eq 'guest')}">
    <jcr:node var="user"
        path="${renderContext.user.localPath}" />
    <jcr:nodeProperty node="${user}"
        name="j:publicProperties" var="publicProperties" />
    <c:set var="publicPropertiesAsString" value="" />

    <c:forEach items="${publicProperties}" var="value">
        <c:set var="publicPropertiesAsString"
            value="${value.string} ${publicPropertiesAsString}" />
    </c:forEach>

    <div class="loginForm p-4">

        <jcr:nodeProperty var="firstName" node="${user}"
            name="j:firstName" />
        <jcr:nodeProperty var="lastName" node="${user}"
            name="j:lastName" />
        <jcr:nodeProperty var="function" node="${user}"
            name="j:function" />
        <jcr:nodeProperty var="email" node="${user}"
            name="j:email" />
        <jcr:nodeProperty var="title" node="${user}"
            name="j:title" />

        <section class="about-section gray-bg"
            id="about">
            <div class="container">
                <div
                    class="row align-items-center flex-row-reverse">
                    <div class="col-lg-9">
                        <div class="about-text go-to">
                            <h3 class="dark-color">
                                <c:if test="${not empty title}">
                                        <fmt:message key='jnt_user.j_title.${title}'/>&nbsp;
                                </c:if>
                                ${firstName}&nbsp;${lastName}
                            </h3>
                            <h6 class="theme-color lead">
                                ${function}</h6>
                            <p>${email}</p>

                        </div>
                        <div class="counter">
                            <div class="row">
                                <div class="col-12">
                                    <p><a class="aButton btn btn-primary"
                                            href='<c:url value="${url.logout}"/>'><span>
                                                <fmt:message
                                                    key="label.logout" />
                                            </span></a></p>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-3">
                        <div class="about-avatar">
                            <c:choose>
                                <c:when
                                    test="${fn:contains(publicPropertiesAsString, 'j:picture')}">
                                    <jcr:nodeProperty
                                        var="picture"
                                        node="${user}"
                                        name="j:picture" />
                                    <c:if
                                        test="${not empty picture}">
                                        <img src="${picture.node.url}"
                                            alt="${renderContext.user.username}" class="img-fluid"/>
                                    </c:if>
                                    <c:if
                                        test="${empty picture}">
                                        <img src="<c:url value='${url.currentModule}/images/avatar.png'/>"
                                            alt="${renderContext.user.username}"
                                            border="0" />
                                    </c:if>
                                </c:when>
                                <c:otherwise>
                                    <img src="<c:url value='${url.currentModule}/images/avatar.png'/>"
                                        alt="${renderContext.user.username}"
                                        border="0" />
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                    
                </div>
            </div>
        </section>
    </div>
</c:if>