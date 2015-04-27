<cfcomponent name="CommandFactoryTest" extends="mxunit.framework.TestCase">
	<!--- Begin specific tests --->

	<cffunction name="testcreateCommand" access="public" returnType="void">
		<cfset var cmd = this.myComp.createCommand( 'LetItBe' ) />
		<cfset assertIsTypeOf( cmd, 'org.gliint.framework.command.Command' ) />
	</cffunction>

	<cffunction name="testgetPublicCommandDefaultValue" access="public" returnType="void">
		<cfset this.myComp.setPublicCommandDefaultValue( 'aBeatlesSong' )/>
		<cfset assertTrue( this.myComp.getPublicCommandDefaultValue() eq "aBeatlesSong" ) />
	</cffunction>

	<cffunction name="testgetPublicCommandName" access="public" returnType="void">
		<cfset this.myComp.setPublicCommandName( 'EleanorRigby' )/>
		<cfset assertTrue( this.myComp.getPublicCommandName() eq "EleanorRigby" ) />
	</cffunction>

	<cffunction name="testinit" access="public" returnType="void">
		<cfset assertIsTypeOf( this.myComp, 'org.gliint.framework.command.CommandFactory' ) />
	</cffunction>

	<cffunction name="testdefaultCommandClass" access="public" returnType="void">
		<cfset c = this.myComp.getCommandClass() />
		<cfset assert( 'org.gliint.framework.command.Command' eq c ) />
	</cffunction>
	<!--- setup and teardown --->

	<cffunction name="setUp" returntype="void" access="public">
		<cfset this.myComp = createObject( 'component', 'org.gliint.framework.command.CommandFactory' ).init() />
	</cffunction>

	<cffunction name="tearDown" returntype="void" access="public">
		<!--- Any code needed to return your environment to normal goes here --->
	</cffunction>

</cfcomponent>