<cfcomponent displayname="Comment" extends="org.gliint.framework.handler.BaseCommandHandler" output="false" >

	<cfset variables['properties'] = structNew() />
	<cfset variables['properties']['access'] = "public" />
	<cfset variables['properties']['beanFactory'] = false />
	<cfset variables['properties']['comment'] = "" />
	<cfset variables['properties']['name'] = "#getMetaData( this ).name#" />
	<cfset variables['properties']['resultClass'] = "org.gliint.framework.util.Result" />
	<cfset variables['properties']['shouldTrace'] = false />


	<cffunction name="init" access="public" output="false">
		<cfset super.init() />
		<cfreturn this />
	</cffunction>


	<cffunction name="execute" access="public" returntype="any" output="false">
		<cfargument name="command" type="any" required="true" />
		<cfargument name="context" type="any" required="true" />

		<cfset var result = newResult() />

		<cfif getShouldTrace() >
			<cftrace type="information" text="integrationTests.controller.listeners.Comment: Started" />
		</cfif>

		<cfset arguments.context.setResponse( '#getName()#', '#getComment()#' ) />

		<cfif getShouldTrace() >
			<cftrace type="information" text="integrationTests.controller.listeners.Comment: Completed" />
		</cfif>

		<cfreturn result />
	</cffunction>

</cfcomponent>