<cfcomponent name="CommandContextTest" extends="mxunit.framework.TestCase">
	<!--- Begin specific tests --->

	<cffunction name="testinit" access="public" returnType="void">
		<cfset assertIsTypeOf( this.myComp, 'org.gliint.framework.command.CommandContext' ) />
	</cffunction>

<!---
	<cffunction name="testdo" access="public" returnType="void">
		<cfset var c = this.myComp.newCommand( 'someCommand' ) />
		<cfset fail("Test testdo not implemented")>
	</cffunction>
--->

	<cffunction name="testenqueueCommand" access="public" returnType="void">
		<cfset var cmd = this.myComp.newCommand( 'someCommand' ) />
		<cfset this.myComp.enqueueCommand( cmd ) />
		<cfset assertTrue( this.myComp.hasCommands() ) />
	</cffunction>

	<cffunction name="testdequeueCommand" access="public" returnType="void">
		<cfset var cmd = this.myComp.newCommand( 'someCommand' ) />
		<cfset var cmd2 = "" />
		<cfset this.myComp.enqueueCommand( cmd ) />
		<cfset cmd2 = this.myComp.dequeueCommand() />
		<cfset assertIsTypeOf( cmd2, 'org.gliint.framework.command.Command' ) />
		<cfset assertTrue( 'someCommand' eq cmd2.getName() ) />
	</cffunction>

	<cffunction name="testhasCommands" access="public" returnType="void">
		<cfset assertFalse( this.myComp.hasCommands() ) />
	</cffunction>

	<cffunction name="testenstackCommand" access="public" returnType="void">
		<cfset var cmd = this.myComp.newCommand( 'someCommand' ) />
		<cfset this.myComp.enstackCommand( cmd ) />
		<cfset assertTrue( this.myComp.hasCommands() ) />
	</cffunction>

	<cffunction name="testdestackCommand" access="public" returnType="void">
		<cfset var cmd = this.myComp.newCommand( 'someCommand' ) />
		<cfset this.myComp.enstackCommand( cmd ) />
		<cfset cmd = this.myComp.destackCommand() />
		<cfset assertIsTypeOf( cmd, 'org.gliint.framework.command.Command' ) />
		<cfset assertTrue( 'someCommand' eq cmd.getName() ) />
	</cffunction>

	<cffunction name="testclear" access="public" returnType="void">
		<cfset var c = this.myComp.newCommand( 'someCommand' ) />
		<cfset var c2 = this.myComp.newCommand( 'anotherCommand' ) />
		<cfset this.myComp.enqueueCommand( c ) />
		<cfset this.myComp.enqueueCommand( c2 ) />
		<cfset this.myComp.clear() />
		<cfset assertFalse( this.myComp.hasCommands() ) />
	</cffunction>

	<cffunction name="testpeek" access="public" returnType="void">
		<cfset var cmd = this.myComp.newCommand( 'someCommand' ) />
		<cfset this.myComp.enstackCommand( cmd ) />
		<cfset cmd = this.myComp.peek() />
		<cfset assertIsTypeOf( cmd, 'org.gliint.framework.command.Command' ) />
		<cfset assertTrue( 'someCommand' eq cmd.getName() ) />
	</cffunction>

	<cffunction name="testsetGetResponse" access="public" returnType="void">
		<cfset this.myComp.setResponse( 'responseName', 'newResponseValue' ) />
		<cfset assertTrue( 'newResponseValue' eq this.myComp.getResponse( 'responseName' ) ) />
	</cffunction>

	<cffunction name="testisResponseDefined" access="public" returnType="void">
		<cfset this.myComp.setResponse( 'responseName', 'newResponseValue' ) />
		<cfset assertTrue( this.myComp.isResponseDefined( 'responseName' ) ) />
	</cffunction>

	<cffunction name="testremoveResponse" access="public" returnType="void">
		<cfset this.myComp.removeResponse( 'responseName' ) />
		<cfset assertFalse( this.myComp.isResponseDefined( 'responseName' ) ) />
	</cffunction>

	<cffunction name="testappendResponses" access="public" returnType="void">
		<cfset var beatles = structNew() />
		<cfset beatles['John'] = 'aBeatle' />
		<cfset beatles['Paul'] = 'aBeatle' />
		<cfset beatles['George'] = 'aBeatle' />
		<cfset beatles['Ringo'] = 'aBeatle' />

		<cfset this.myComp.setResponse( 'John', 'aRollingStone' ) />
		<cfset this.myComp.setResponse( 'Paul', 'aRollingStone' ) />
		<cfset this.myComp.setResponse( 'George', 'aRollingStone' ) />

		<cfset this.myComp.appendResponses( beatles, false ) />
		<cfset assertTrue( this.myComp.getResponse('John') eq 'aRollingStone' ) />
		<cfset assertTrue( this.myComp.getResponse('Paul') eq 'aRollingStone' ) />
		<cfset assertTrue( this.myComp.getResponse('George') eq 'aRollingStone' ) />
		<cfset assertTrue( this.myComp.getResponse('Ringo') eq 'aBeatle' ) />

		<cfset this.myComp.appendResponses( beatles ) />
		<cfset assertTrue( this.myComp.getResponse('John') eq 'aBeatle' ) />
		<cfset assertTrue( this.myComp.getResponse('Paul') eq 'aBeatle' ) />
		<cfset assertTrue( this.myComp.getResponse('George') eq 'aBeatle' ) />
		<cfset assertTrue( this.myComp.getResponse('Ringo') eq 'aBeatle' ) />

	</cffunction>

	<cffunction name="testnewCommand" access="public" returnType="void">
		<cfset var c = this.myComp.newCommand( 'someCommand' ) />
		<cfset assertIsTypeOf( c, 'org.gliint.framework.command.Command' ) />
	</cffunction>

	<!--- NOT testing setResponseBean... methods since they are delegated --->

	<cffunction name="testgetParent" access="public" returnType="void">
		<cfset assertTrue( isObject( this.myComp.getParent() ) ) />
	</cffunction>

	<cffunction name="testgetResponses" access="public" returnType="void">
		<cfset this.myComp.setResponse( 'responseName', 'newResponseValue' ) />
		<cfset assertTrue( structKeyExists( this.myComp.getResponses(), 'responseName' ) ) />
	</cffunction>

	<cffunction name="testNestable" access="public" returnType="void">
		<cfset var cxt = "" />
		<cfset var r = structNew() />
		<cfset cxt = createObject( 'component', 'org.gliint.framework.command.CommandContext' ).init( this.myComp, r, 30, this.bf.getBean('commandFactory'), this.bf.getBean('beaner') ) />
		<cfset assertIsTypeOf( cxt, 'org.gliint.framework.command.CommandContext' ) />
		<cfset assertIsTypeOf( cxt.getParent(), 'org.gliint.framework.GliintController'  ) />
	</cffunction>


	<!--- setup and teardown --->

	<cffunction name="setUp" returntype="void" access="public">
		<cfset var rawXml = "" />
		<cfset var r = structNew() />
		<cfset var bc = createObject( 'component', 'org.gliint.framework.connector.BaseConnector' ).init() />
		<cfset var h = createObject( 'component',  'org.gliint.framework.handler.NopHandler' ).init() />
		<cfset var hec = createObject( 'component', 'org.gliint.framework.HandlerExecutionChain' ).init( h ) />
		<cfset this.bf = createObject( 'component', 'coldspring.beans.DefaultXmlBeanFactory' ).init( structNew(), structNew() ) />
    <cfset this.bf.loadBeansFromXmlFile( '/org/gliint/tests/resources/coldspring.gliint.cfg.xml' ) />

		<cfset bc.preHandle( 'bleah', r, hec ) />

		<cfset this.myComp = createObject( 'component', 'org.gliint.framework.command.CommandContext' ).init( this.bf.getBean('gliintController'), r, 30, this.bf.getBean('commandFactory'), this.bf.getBean('beaner') ) />
	</cffunction>

	<cffunction name="tearDown" returntype="void" access="public">
		<!--- Any code needed to return your environment to normal goes here --->
	</cffunction>

</cfcomponent>

