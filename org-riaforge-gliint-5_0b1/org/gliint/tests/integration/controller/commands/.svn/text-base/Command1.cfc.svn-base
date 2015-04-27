<cfcomponent displayname="Command1" extends="org.gliint.framework.handler.CommandHandlingExecutionChain" output="false" >
<!---
A commandHandlingExecutionChain that writes a simple, known response
--->
	<cfset variables['properties'] = structNew() />
	<cfset variables['properties']['access'] = "public" />
	<cfset variables['properties']['beanFactory'] = false />
	<cfset variables['properties']['comment'] = "" />
	<cfset variables['properties']['name'] = "#getMetaData( this ).name#" />
	<cfset variables['properties']['resultClass'] = "org.gliint.framework.util.Result" />
	<cfset variables['properties']['shouldTrace'] = false />


	<cffunction name="execute" access="public" returntype="any" output="false">
		<cfargument name="command" type="any" required="true" />
		<cfargument name="context" type="any" required="true" />

		<cfset var result = newResult() />

		<cfif getShouldTrace() >
			<cftrace type="information" text="#getName()# assigned to command #arguments.command.getName()# started" />
		</cfif>

		<!--- this should never happen --->
		<cfif ( not compareNoCase( arguments.command.getName(), 'command1' ) eq 0 ) >
			<cfset result.setCode(500) />
			<cfset result.setType( 'gliint.commandExecution' ) />
			<cfset result.setMessage( 'invalid command name [#arguments.command.getName()#] for command1' ) />
		</cfif>

		<cfset arguments.context.setResponse( '#getName()#', '#getComment()#' ) />
		<cfif getShouldTrace() >
			<cftrace type="information" text="set response [#getName()#] to [#getComment()#]" />
		</cfif>

		<cfif getShouldTrace() >
			<cftrace type="information" text="#getName()# assigned to command #arguments.command.getName()# completed" />
		</cfif>

		<cfreturn result />
	</cffunction>

</cfcomponent>