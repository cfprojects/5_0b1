<cfcomponent name="HandlerExecutionChainTest" extends="mxunit.framework.TestCase">
	<!--- Begin specific tests --->

	<cffunction name="testaddInterceptor" access="public" returnType="void">
		<cfset var interceptor = createObject( 'component' , 'org.gliint.framework.handler.BaseHandlerInterceptor' ).init() />
		<cfset var interceptors = arrayNew(1) />
		<cfset this.myComp.addInterceptor( interceptor ) />
		<cfset interceptors = this.myComp.getInterceptors() />
		<cfset assertIsTypeOf( interceptors[1] , 'org.gliint.framework.handler.BaseHandlerInterceptor') />
	</cffunction>

	<cffunction name="testaddInterceptors" access="public" returnType="void">
		<cfset var returnedInterceptors = arrayNew(1) />
		<cfset var interceptors = arrayNew(1) />
		<cfset interceptors[1] = createObject( 'component' , 'org.gliint.framework.handler.BaseHandlerInterceptor' ).init() />
		<cfset this.myComp.addInterceptors( interceptors ) />
		<cfset returnedInterceptors = this.myComp.getInterceptors() />
		<cfset assertIsTypeOf( returnedInterceptors[1], 'org.gliint.framework.handler.BaseHandlerInterceptor' ) />
	</cffunction>

	<cffunction name="testgetHandler" access="public" returnType="void">
		<cfset assertTrue( this.myComp.getHandler() ) />
	</cffunction>

	<cffunction name="testgetInterceptors" access="public" returnType="void">
		<cfset assertTrue( arrayIsEmpty( this.myComp.getInterceptors() ) ) />
	</cffunction>

	<cffunction name="testinit" access="public" returnType="void">
		<cfset assertIsTypeOf( this.myComp, 'org.gliint.framework.HandlerExecutionChain' ) />
	</cffunction>


	<!--- setup and teardown --->

	<cffunction name="setUp" returntype="void" access="public">
		<cfset var handler = true />
		<cfset this.myComp = createObject("component","org.gliint.framework.HandlerExecutionChain").init( handler ) />
	</cffunction>

	<cffunction name="tearDown" returntype="void" access="public">
		<!--- Any code needed to return your environment to normal goes here --->
	</cffunction>

</cfcomponent>

