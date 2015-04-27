<cfcomponent name="HTTPConnectorTest" extends="mxunit.framework.TestCase">
	<!--- Begin specific tests --->

	<cffunction name="testpreHandle" access="public" returnType="void">
		<cfset var r = structNew() />
		<cfset this.myComp.preHandle( 'onRequestStart', r , true ) />
		<cfset assertTrue( structKeyExists( r, '_request' ) ) />
	</cffunction>

	<cffunction name="testpostHandle" access="public" returnType="void">
		<cfset var r = structNew() />
		<cfset this.myComp.postHandle( 'onRequestEnd', r , true ) />
		<cfset assertTrue( structKeyExists( r, '_output', "Test testpostHandle implemented, passes, but loses header in html test suite mode (go figger)") ) />
	</cffunction>

	<cffunction name="testinit" access="public" returnType="void">
		<cfset assertIsTypeOf( this.myComp, 'org.gliint.framework.connector.HTTPConnector' ) />
	</cffunction>

	<!--- setup and teardown --->

	<cffunction name="setUp" returntype="void" access="public">
		<cfset this.myComp = createObject( 'component', 'org.gliint.framework.connector.HTTPConnector' ).init() />
		<cfset this.myComp.setPostHandleWriterResolution( 'include' ) />
		<cfset this.myComp.setPostHandleWriterLocation( '/org/gliint/tests/resources/writer.cfm' ) />
	</cffunction>

	<cffunction name="tearDown" returntype="void" access="public">
		<!--- Any code needed to return your environment to normal goes here --->
	</cffunction>

</cfcomponent>