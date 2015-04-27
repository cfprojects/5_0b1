<cfcomponent name="Application" extends="controller.Dispatcher" >

	<cfset this['name'] = "skeleton" />
	<cfset this['sessionManagement'] = false />
	<cfset this['clientManagement'] = false />
	<cfset this['applicationTimeout'] = createTimeSpan(1,0,0,0) />
	<cfset this['sessionTimeout'] = createTimeSpan(0,0,20,0) />
	<cfset this['setClientCookies'] = false />
	<cfset this['scriptProtect'] = true />

	<!--- Gliint Dispatcher overrides --->
	<cfset this['contextClass'] = "org.gliint.framework.context.DefaultWebApplicationContext" />
	<cfset this['contextConfigLocation'] = "/config/coldspring.xml" />
	<cfset this['contextScope'] = "application" />
	<cfset this['handler_mapping_bean_name'] = "simpleHandlerMapping" />
	<cfset this['allowRefresh'] = true />
	<cfset this['refresh_checking_bean_name'] = "refresher" />


	<!--- + = + = + = + = + = + = + = + = + = + = + = + = + = + = + = + = + = + = + = + = + = + = + --->

	<cffunction name="onApplicationStart" access="public" returntype="boolean" output="false" >
		<cfset createWebApplicationContext() />
		<cfset variables.refreshed = true />
		<cfreturn true />
	</cffunction>



	<cffunction name="onRequestStart" access="public" returntype="boolean" output="false" >
		<cfargument name="targetPage" type="string" required="true" />
		<cfparam name="variables.refreshed" default="#false#" />

		<cftry>

			<!--- uncomment to allow the ability to refresh. Please change the password!
			<cfif ( structKeyExists( url, 'refresh' )  and ( url.refresh eq 'password' ) and ( variables.refreshed eq false ) )>
				<cfset createWebApplicationContext() />
				<cfset variables.refreshed = true />
			</cfif>
			--->

			<!--- uncomment to autorefresh the webApplicationContext during development. DO NOT use on production systems
			<cfif ( shouldRefresh() and ( variables.refreshed eq false ) ) >
				<cfset getNamedApplicationContext( this['contextScope'], this['name'] ).refresh() />
				<cfset variables.refreshed = true />
			</cfif>
			--->

			<cfset doDispatch( 'onRequestStart' ) />

			<cfcatch type="handlerMappingException">
				<!--- do nothing --->
			</cfcatch>
		</cftry>

		<cfreturn true />
	</cffunction>



	<!--- onRequest() is intentionally NOT here; in some cases it will break flash remoting or web service calls --->



	<!--- cffunction output must be 'true' where you use the render() method...	--->
	<cffunction name="onRequestEnd" access="public" returntype="boolean" output="true" >
		<cfargument name="targetPage" type="string" required="true" />

		<cftry>

			<cfset doDispatch( 'onRequestEnd' ) />
			<cfset render() />

			<cfcatch type="handlerMappingException">
				<!--- do nothing --->
			</cfcatch>
		</cftry>
		<cfreturn true>
	</cffunction>



	<cffunction name="onError" access="public" output="true" >
		<cfargument name="exception" required="true" />
		<cfargument name="eventname" required="true" type="string" />
		<!--- you should change the below for production usage --->
		<cfdump var="#arguments.exception#" >
	</cffunction>

</cfcomponent>