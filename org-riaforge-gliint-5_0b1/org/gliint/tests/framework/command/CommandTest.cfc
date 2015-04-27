<cfcomponent name="CommandTest" extends="mxunit.framework.TestCase">
	<!--- Begin specific tests --->


	<cffunction name="testgetArg" access="public" returnType="void">
		<cfset assertTrue( 'hello' eq this.myComp.getArg( 'myArg' ) ) />
	</cffunction>

	<cffunction name="testgetArgs" access="public" returnType="void">
		<cfset var args = structNew() />
		<cfset args['myArg'] = 'hello' />
		<cfset assertEquals( args, this.myComp.getArgs() ) />
	</cffunction>

	<cffunction name="testgetBind" access="public" returnType="void">
		<cfset assertTrue( 'verb' eq this.myComp.getBind() ) />
	</cffunction>

	<cffunction name="testgetInstance" access="public" returnType="void">
		<cfset var st = structNew() />
		<cfset st.name = "myName" />
		<cfset st.bind = "verb" />
		<cfset st.isPublic = "#false#" />
		<cfset st.args = structNew() />
		<cfset st.args['myArg'] = 'hello' />
		<cfset assertEquals( st, this.myComp.getInstance() ) />
	</cffunction>

	<cffunction name="testgetIsPublic" access="public" returnType="void">
		<cfset assertFalse( this.myComp.getIsPublic() ) />
	</cffunction>

	<cffunction name="testgetName" access="public" returnType="void">
		<cfset assertTrue( 'myName' eq this.myComp.getName() ) />
	</cffunction>

	<cffunction name="testinit" access="public" returnType="void">
		<cfset assertIsTypeOf( this.myComp, 'org.gliint.framework.command.Command' ) />
	</cffunction>

	<cffunction name="testNotIsArgDefined" access="public" returnType="void">
		<cfset assertFalse( this.myComp.isArgDefined( 'no' ), 'hasArg() returned true but arg does not exist' ) />
	</cffunction>

<!----
	<cffunction name="testsetArgs" access="public" returnType="void">
		<cfset fail("Test testsetArgs not implemented")>
	</cffunction>

	<cffunction name="testsetBind" access="public" returnType="void">
		<cfset fail("Test testsetBind not implemented")>
	</cffunction>

	<cffunction name="testsetIsPublic" access="public" returnType="void">
		<cfset fail("Test testsetIsPublic not implemented")>
	</cffunction>

	<cffunction name="testsetName" access="public" returnType="void">
		<cfset fail("Test testsetName not implemented")>
	</cffunction>
--->

	<!--- setup and teardown --->

	<cffunction name="setUp" returntype="void" access="public">
		<cfset var class = 'org.gliint.command.Command' />
		<cfset var name = "myName" />
		<cfset var bind = "verb" />
		<cfset var args = structNew() />
		<cfset args['myArg'] = 'hello' />
		<cfset this.myComp = createObject( 'component', 'org.gliint.framework.command.Command' ).init( name, bind, args ) />
	</cffunction>

	<cffunction name="tearDown" returntype="void" access="public">
		<!--- Any code needed to return your environment to normal goes here --->
	</cffunction>

</cfcomponent>

