<cfcomponent name="DispatcherTest" extends="mxunit.framework.TestCase">
	<!--- Begin specific tests --->



  <cffunction name="testinit" access="public" returnType="void">
    <cfset assertIsTypeOf( this.myComp, 'org.gliint.framework.Dispatcher' ) />
  </cffunction>

<!---
	<cffunction name="testGetHandler" access="public" returnType="void">
		<cfset fail("Test testGetHandler not implemented; it's effectively an integration test")>
	</cffunction>

	<cffunction name="testDoDispatch" access="public" returnType="void">
		<cfset fail("Test testDoDispatch not implemented; it's effectively an integration test")>
	</cffunction>
--->

	<!--- NOT testing getters and setters --->

	<!--- setup and teardown --->

	<cffunction name="setUp" returntype="void" access="public">
		<cfset this.myComp = createObject("component","org.gliint.framework.Dispatcher") />
	</cffunction>

	<cffunction name="tearDown" returntype="void" access="public">
		<!--- Any code needed to return your environment to normal goes here --->
	</cffunction>

</cfcomponent>