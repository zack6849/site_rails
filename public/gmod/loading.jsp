<%@ page import="com.zack6849.website.SourceMap" %>
<%--
  Created by IntelliJ IDEA.
  User: zack6849
  Date: 8/27/14
  Time: 7:28 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Loading</title>
    <link href="/css/foundation.css" rel="stylesheet">
    <link href="/css/main.css" rel="stylesheet">
    <link rel='stylesheet' type='text/css'
          href='http://fonts.googleapis.com/css?family=Titillium+Web:400,600italic,600,300italic,400italic'>
</head>
<body>
<div class="row" style="margin-top: 5em;">
    <%
        SourceMap map = SourceMap.getByName(request.getParameter("map"));
    %>
    <div class="large-10 columns">
        <div id="content" class="panel">
            <p>

            <div style="float: left;">
                Welcome to Prop Hunt [US]!
            </div>
            <div style="float: right;">
                Please wait while we load some things for you.
            </div>
            <hr>
            Current Map: <code><% out.println(map.getRealName()); %></code>
            <hr>
            <img src="<%= map.getUrl() %>" alt="<%= map.getName() %>"/>

            <div style="float: right; margin-right: 1em; margin-left: 2em; width: 50%;">
                <div id="status" style="float: left; text-align: left; direction: ltr; width: 100%">
                    <div id="status"></div>
                    <div id="currentfile"></div>
                    <div class="progress large-6 success round" style="width: 100%;">
                        <span style="width: 0;" class="meter"></span>
                    </div>
                    <div id="log"></div>
                </div>
            </div>
            </p>
        </div>
    </div>
</div>
</body>
<script src="/js/gmod.js"></script>
<script src="/js/vendor/jquery.js"></script>
<script src="/js/foundation/foundation.js"></script>
</html>
