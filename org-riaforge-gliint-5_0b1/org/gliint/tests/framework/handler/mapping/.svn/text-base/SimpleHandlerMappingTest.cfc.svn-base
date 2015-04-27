<cfcomponent name="SimpleHandlerMappingTest" extends="mxunit.framework.TestCase">
  <!--- Begin specific tests --->

  <cffunction name="testgetHandler" access="public" returnType="void">
		<cfset var hec = this.myComp.getHandler() />

		<cfif ( listFindNoCase( 'index.cfm', getFileFromPath( cgi.PATH_TRANSLATED ), '/' ) neq 0 ) >
	    <cfset assertIsTypeOf( hec, 'org.gliint.framework.HandlerExecutionChain' ) />
	  <cfelse>
	  	<cfset assertFalse( hec ) />
	  </cfif>
  </cffunction>

  <cffunction name="testinit" access="public" returnType="void">
    <cfset assertIsTypeOf( this.myComp, 'org.gliint.framework.handler.mapping.SimpleHandlerMapping' ) />
  </cffunction>


  <!--- setup and teardown --->

  <cffunction name="setUp" returntype="void" access="public">
    <cfset this.myComp = createObject( 'component', 'org.gliint.framework.handler.mapping.SimpleHandlerMapping' ).init() />
  </cffunction>

  <cffunction name="tearDown" returntype="void" access="public">
    <!--- Any code needed to return your environment to normal goes here --->
  </cffunction>

</cfcomponent>