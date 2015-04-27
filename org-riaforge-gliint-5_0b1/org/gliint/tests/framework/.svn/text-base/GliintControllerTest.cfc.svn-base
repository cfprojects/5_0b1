<cfcomponent name="GliintControllerTest" extends="mxunit.framework.TestCase">
	<!--- Begin specific tests --->


	<cffunction name="testhandleRequest" access="public" returnType="void">
		<cfset var d = createObject( 'component', 'org.gliint.framework.lexicon.Nop' ).init() />
		<cfset var r = false />
		<cfset this.myComp.setCommandDispatcher(d) />
		<cfset r = this.myComp.handleRequest( 'AnyTimeAtAll', structNew() ) />
		<cfset assert( isStruct(r) ) >
		<cfset assert( structKeyExists( r, 'event' ) ) />
		<cfset assert( r.event eq 'default' ) />
	</cffunction>

	<cffunction name="testinit" access="public" returnType="void">
		<cfset assertIsTypeOf( this.myComp, 'org.gliint.framework.GliintController' ) />
	</cffunction>

<!--- since handle() delegates to handleRequest, we're not testing it
	<cffunction name="testhandle" access="public" returnType="void">
		<cfset fail("Test testhandle not implemented since")>
	</cffunction>
--->


<!--- NOT testing getters and setters
	<cffunction name="testsetShouldTrace" access="public" returnType="void">
		<cfset fail("Test testsetShouldTrace not implemented")>
	</cffunction>

	<cffunction name="testgetShouldTrace" access="public" returnType="void">
		<cfset fail("Test testgetShouldTrace not implemented")>
	</cffunction>

	<cffunction name="testsetMaximumCommands" access="public" returnType="void">
		<cfset fail("Test testsetMaximumCommands not implemented")>
	</cffunction>

	<cffunction name="testgetMaximumCommands" access="public" returnType="void">
		<cfset fail("Test testgetMaximumCommands not implemented")>
	</cffunction>

	<cffunction name="testsetDefaultEvent" access="public" returnType="void">
		<cfset fail("Test testsetDefaultEvent not implemented")>
	</cffunction>

	<cffunction name="testgetDefaultEvent" access="public" returnType="void">
		<cfset fail("Test testgetDefaultEvent not implemented")>
	</cffunction>

	<cffunction name="testsetCommandDispatcher" access="public" returnType="void">
		<cfset fail("Test testsetCommandDispatcher not implemented")>
	</cffunction>

	<cffunction name="testgetCommandDispatcher" access="public" returnType="void">
		<cfset fail("Test testgetCommandDispatcher not implemented")>
	</cffunction>

	<cffunction name="testsetCommandFactory" access="public" returnType="void">
		<cfset fail("Test testsetCommandFactory not implemented")>
	</cffunction>

	<cffunction name="testgetCommandFactory" access="public" returnType="void">
		<cfset fail("Test testgetCommandFactory not implemented")>
	</cffunction>

--->

	<!--- setup and teardown --->

	<cffunction name="setUp" returntype="void" access="public">
		<cfset this.myComp = createObject( 'component', 'org.gliint.framework.GliintController' ) .init() />
		<cfset this.myComp.setCommandFactory( createObject( 'component', 'org.gliint.framework.command.CommandFactory' ).init() ) />
	</cffunction>

	<cffunction name="tearDown" returntype="void" access="public">
		<!--- Any code needed to return your environment to normal goes here --->
	</cffunction>

</cfcomponent>