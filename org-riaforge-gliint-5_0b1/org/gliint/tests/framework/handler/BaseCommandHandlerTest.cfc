<cfcomponent name="BaseCommandHandlerTest" extends="mxunit.framework.TestCase">
	<!--- Begin specific tests --->

	<cffunction name="testexecute" access="public" returnType="void">
		<cfset var success = false />
		<cftry>
			<cfset this.myComp.execute( 'command', 'context' ) />
			<cfcatch type="Method.NotImplemented" >
				<!--- should throw exception --->
				<cfset success = true />
			</cfcatch>
		</cftry>
		<cfset assert(success) />
	</cffunction>

<!---
	<cffunction name="testgetAccess" access="public" returnType="void">
		<cfset fail("Test testgetAccess not implemented")>
	</cffunction>

	<cffunction name="testgetComment" access="public" returnType="void">
		<cfset fail("Test testgetComment not implemented")>
	</cffunction>

	<cffunction name="testgetInstance" access="public" returnType="void">
		<cfset fail("Test testgetInstance not implemented")>
	</cffunction>

	<cffunction name="testgetName" access="public" returnType="void">
		<cfset fail("Test testgetName not implemented")>
	</cffunction>
--->

	<cffunction name="testgetProperties" access="public" returnType="void">
		<cfset this.myComp.setProperty( 'property1', 'value1') />
		<cfset assertTrue( structKeyExists( this.myComp.getProperties(), 'property1' ) ) />
		<cfset assertTrue( structKeyExists( this.myComp.getProperties(), 'access' ) ) />
		<cfset assertTrue( structKeyExists( this.myComp.getProperties(), 'beanFactory' ) ) />
		<cfset assertTrue( structKeyExists( this.myComp.getProperties(), 'comment' ) ) />
		<cfset assertTrue( structKeyExists( this.myComp.getProperties(), 'name' ) ) />
		<cfset assertTrue( structKeyExists( this.myComp.getProperties(), 'resultClass' ) ) />
		<cfset assertTrue( structKeyExists( this.myComp.getProperties(), 'shouldTrace' ) ) />

	</cffunction>


	<cffunction name="testgetProperty" access="public" returnType="void">
		<cfset this.myComp.setProperty( 'property1', 'value1') />
		<cfset assertTrue( 'value1' eq this.myComp.getProperty( 'property1' ) ) />
	</cffunction>

	<cffunction name="testinit" access="public" returnType="void">
		<cfset assertIsTypeOf( this.myComp, 'org.gliint.framework.handler.BaseCommandHandler' ) />
	</cffunction>

	<cffunction name="testisPropertyDefined" access="public" returnType="void">
		<cfset assertTrue( this.myComp.isPropertyDefined( 'access' ) ) />
		<cfset this.myComp.setProperty( 'property1', 'value1') />
		<cfset assertTrue( this.myComp.isPropertyDefined( 'property1' ) ) />
	</cffunction>

	<cffunction name="testNotIsPropertyDefined" access="public" returnType="void">
		<cfset assertFalse( this.myComp.isPropertyDefined( 'property2' ) ) />
	</cffunction>

	<cffunction name="testnewResult" access="public" returnType="void">
		<cfset assertIsTypeOf( this.myComp.newResult(), 'org.gliint.framework.util.Result' ) />
	</cffunction>

	<cffunction name="testmixin" access="public" returnType="void">
		<cfset this.myComp.mixin( 'sing', sing ) />
		<cfset assert( this.myComp.sing() eq 'GlassOnion' ) />
	</cffunction>

	<!--- this is the function used for testmixin --->
	<cffunction name="sing" access="private" returntype="string">
		<cfreturn 'GlassOnion' />
	</cffunction>

<!---
	<cffunction name="testsetAccess" access="public" returnType="void">
		<cfset fail("Test testsetAccess not implemented")>
	</cffunction>

	<cffunction name="testsetComment" access="public" returnType="void">
		<cfset fail("Test testsetComment not implemented")>
	</cffunction>

	<cffunction name="testsetName" access="public" returnType="void">
		<cfset fail("Test testsetName not implemented")>
	</cffunction>

	<cffunction name="testsetProperties" access="public" returnType="void">
		<cfset fail("Test testsetProperties not implemented")>
	</cffunction>

	<cffunction name="testsetProperty" access="public" returnType="void">
		<cfset fail("Test testsetProperty not implemented")>
	</cffunction>
--->

	<!--- setup and teardown --->

	<cffunction name="setUp" returntype="void" access="public">
		<cfset var properties = structNew() />
		<cfset properties.serviceFactory =	'' />
		<cfset properties.property1 = 'value1' />
		<cfset this.myComp = createObject( 'component', 'org.gliint.framework.handler.BaseCommandHandler' ).init() />
	</cffunction>

	<cffunction name="tearDown" returntype="void" access="public">
		<!--- Any code needed to return your environment to normal goes here --->
	</cffunction>

</cfcomponent>
