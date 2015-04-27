<cfcomponent name="BaseHandlerInterceptorTest" extends="mxunit.framework.TestCase">
	<!--- Begin specific tests --->

	<cffunction name="testinit" access="public" returnType="void">
		<cfset assertIsTypeOf( this.myComp , 'org.gliint.framework.handler.BaseHandlerInterceptor' ) />
	</cffunction>

	<cffunction name="testpreHandle" access="public" returnType="void">
		<cfset assert( true ) >
	</cffunction>

	<cffunction name="testpostHandle" access="public" returnType="void">
		<cfset assert( true ) >
	</cffunction>

	<cffunction name="testafterCompletion" access="public" returnType="void">
		<cfset assert( true ) >
	</cffunction>

	<cffunction name="testmixin" access="public" returnType="void">
		<cfset this.myComp.mixin( 'sing', sing ) />
		<cfset assert( this.myComp.sing() eq 'FromMeToYou' ) />
	</cffunction>

	<!--- this is the function used for testmixin --->
	<cffunction name="sing" access="private" returntype="string">
		<cfreturn 'FromMeToYou' />
	</cffunction>



	<cffunction name="setUp" returntype="void" access="public">
		<cfset this.myComp = createObject( 'component', 'org.gliint.framework.handler.BaseHandlerInterceptor' ).init() />
	</cffunction>

	<cffunction name="tearDown" returntype="void" access="public">
		<!--- Any code needed to return your environment to normal goes here --->
	</cffunction>

</cfcomponent>