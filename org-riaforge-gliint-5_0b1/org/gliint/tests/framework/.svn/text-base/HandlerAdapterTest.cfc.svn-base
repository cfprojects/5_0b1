<cfcomponent name="HandlerAdapterTest" extends="mxunit.framework.TestCase">
	<!--- Begin specific tests --->


  <cffunction name="testinit" access="public" returnType="void">
    <cfset assertIsTypeOf( this.myComp, 'org.gliint.framework.HandlerAdapter' ) />
  </cffunction>

	<cffunction name="testHandle" access="public" returnType="void">
		<cfset var handler = createObject( 'component' , 'org.gliint.framework.lexicon.Nop' ).init() />
		<cfset var cmd = createObject( 'component' , 'org.gliint.framework.command.Command' ).init( 'Flying', 'name', structNew() ) />
		<cfset var ret = false />
		<cfset this.myComp.setHandler( handler ) />
		<cfset ret = this.myComp.handle( cmd, structNew() ) />
		<cfset assertIsTypeOf( ret, 'org.gliint.framework.util.Result' ) />
	</cffunction>

	<!--- NOT testing getters and setters --->

	<!--- setup and teardown --->

	<cffunction name="setUp" returntype="void" access="public">
		<cfset this.myComp = createObject("component","org.gliint.framework.HandlerAdapter").init() />
	</cffunction>

	<cffunction name="tearDown" returntype="void" access="public">
		<!--- Any code needed to return your environment to normal goes here --->
	</cffunction>

</cfcomponent>