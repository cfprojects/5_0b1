<cfsetting showdebugoutput="true">
<cfimport prefix="view" taglib="/org/gliint/tests/integration/view/">

<html>
<head>
	<title>Gliintegration Tests</title>
</head>
<body>


<h2>Spring Compliance DefaultWebApplicationContext test</h2>
<p>
A defaultWebApplicationContext can 'publish' an event.
It should notify all listeners registered with this application of an application event.
Events may be framework events (such as RequestHandledEvent) or application-specific events.
</p>
<cftrace text="STARTING SPRING COMPLIANCE DEFAULTWEBAPPLICATIONCONTEXT TEST" />
<cfset dispatcher = createObject( 'component', 'org.gliint.framework.Dispatcher' ) />
<cfset dispatcher.setContextClass( 'org.gliint.framework.context.DefaultWebApplicationContext' ) />
<cfset dispatcher.setContextConfigLocation( '/org/gliint/tests/integration/config/publishEvent.gliint.cfg.xml' ) />
<cfset dispatcher['contextScope'] = "request" />
<cfset dispatcher['name'] = "publishEventDispatcher" />
<cfset dispatcher['handler_mapping_bean_name'] = "multiHandlerMapping" />
<cfset wac = dispatcher.createWebApplicationContext() />
<cfset event = structNew() />
<cfset wac.publishEvent( event ) />
<view:publishEventView event="#event#" />


<h2>Gliint Multicasting test</h2>
<cftrace text="STARTING MULTICAST TEST" />
<cfset dispatcher = createObject( 'component', 'org.gliint.framework.Dispatcher' ) />
<cfset dispatcher.setContextClass( 'org.gliint.framework.context.DefaultWebApplicationContext' ) />
<cfset dispatcher.setContextConfigLocation( '/org/gliint/tests/integration/config/multicast.gliint.cfg.xml' ) />
<cfset dispatcher['contextScope'] = "request" />
<cfset dispatcher['name'] = "multicastDispatcher" />
<cfset dispatcher['handler_mapping_bean_name'] = "multiHandlerMapping" />
<cfset wac = dispatcher.createWebApplicationContext() />
<cfset dispatcher.doDispatch( 'onRequestStart' ) />
<cfset dispatcher.doDispatch( 'onRequestEnd' ) />
<cfset dispatcher.render() />


<h2>Gliint Notify (listener) test</h2>
<cftrace text="STARTING LISTENER TEST" />
<cfset dispatcher = createObject( 'component', 'org.gliint.framework.Dispatcher' ) />
<cfset dispatcher.setContextClass( 'org.gliint.framework.context.DefaultWebApplicationContext' ) />
<cfset dispatcher.setContextConfigLocation( '/org/gliint/tests/integration/config/notify.gliint.cfg.xml' ) />
<cfset dispatcher['contextScope'] = "request" />
<cfset dispatcher['name'] = "notifyDispatcher" />
<cfset dispatcher['handler_mapping_bean_name'] = "multiHandlerMapping" />
<cfset wac = dispatcher.createWebApplicationContext() />
<cfset url.event = "message1" />
<cfset dispatcher.doDispatch( 'onRequestStart' ) />
<cfset dispatcher.doDispatch( 'onRequestEnd' ) />
<cfset dispatcher.render() />


<h2>Gliint Name (command) test</h2>
<cfset url.event = "command1" />
<cftrace text="STARTING COMMAND TEST" />
<cfset dispatcher = createObject( 'component', 'org.gliint.framework.Dispatcher' ) />
<cfset dispatcher.setContextClass( 'org.gliint.framework.context.DefaultWebApplicationContext' ) />
<cfset dispatcher.setContextConfigLocation( '/org/gliint/tests/integration/config/name.gliint.cfg.xml' ) />
<cfset dispatcher['contextScope'] = "request" />
<cfset dispatcher['name'] = "nameDispatcher" />
<cfset dispatcher['handler_mapping_bean_name'] = "multiHandlerMapping" />
<cfset wac = dispatcher.createWebApplicationContext() />
<cfset dispatcher.doDispatch( 'onRequestStart' ) />
<cfset dispatcher.doDispatch( 'onRequestEnd' ) />
<cfset dispatcher.render() />

<!---
<cfdump var="#dispatcher.getResponses()#" >
--->

<!--- maximum commands tests reminder --->
</body>
</html>