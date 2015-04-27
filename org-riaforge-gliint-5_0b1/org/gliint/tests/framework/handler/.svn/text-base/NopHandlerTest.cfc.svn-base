<cfcomponent name="NopHandlerTest" extends="mxunit.framework.TestCase">
	<!--- Begin specific tests --->

	<cffunction name="testinit" access="public" returnType="void">
		<cfset assertIsTypeOf( this.myComp, 'org.gliint.framework.handler.NopHandler' ) />
	</cffunction>

	<cffunction name="testhandle" access="public" returnType="void">
		<cfset var r = structNew() />
		<cfset var r2 = 0 />
		<cfset r.key = 'value' />
		<cfset r2 = this.myComp.handle( 'someApplicationEvent', r ) />
		<cfset assertTrue( structKeyExists( r2, 'key' ) ) />
	</cffunction>


	<cffunction name="setUp" returntype="void" access="public">
		<cfset this.myComp = createObject( 'component', 'org.gliint.framework.handler.NopHandler' ).init() />
	</cffunction>

	<cffunction name="tearDown" returntype="void" access="public">
		<!--- Any code needed to return your environment to normal goes here --->
	</cffunction>

</cfcomponent>