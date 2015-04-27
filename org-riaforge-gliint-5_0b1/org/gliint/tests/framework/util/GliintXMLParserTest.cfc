<cfcomponent name="GliintXMLParserTest" extends="mxunit.framework.TestCase">
  <!--- Begin specific tests --->

  <cffunction name="testinit" access="public" returnType="void">
    <cfset assertTrue( isObject( this.myComp.init() ) ) />
  </cffunction>

  <cffunction name="testgetCommandHandlerConfigData" access="public" returnType="void">
    <cfset var parsed = structNew() />
 		<cfset this.myComp.setConfigSource( '/org/gliint/tests/resources/gliint.xml' ) />
    <cfset parsed = this.myComp.getCommandHandlerConfigData('mockCommandHandler') />
    <cfset fail("Test testgetCommandHandlerConfigData not implemented")>
  </cffunction>

  <cffunction name="testcreateConfigData" access="public" returnType="void">
 		<cfset var handRolled = structNew() />
    <cfset var parsed = structNew() />
 		<cfset this.myComp.setConfigSource( '/org/gliint/tests/resources/gliint.xml' ) />
 		<cfset handRolled = createObject( 'component', 'org.gliint.tests.resources.TestConfigGenerator').init().getTestStruct() />
    <cfset parsed = this.myComp.createConfigData() />
		<cfset assertEquals( handRolled['commandHandlers'], parsed['commandHandlers'] ) />
  </cffunction>

  <cffunction name="testhasConfigChanged" access="public" returnType="void">
    <cfset fail("Test testhasConfigChanged not implemented")>
  </cffunction>

  <cffunction name="testgetInstanceData" access="public" returnType="void">
    <cfset fail("Test testgetInstanceData not implemented")>
  </cffunction>


  <!--- setup and teardown --->

  <cffunction name="setUp" returntype="void" access="public">
    <cfset this.myComp = createObject( 'component','org.gliint.framework.context.GliintXMLParser').init() />
  </cffunction>

  <cffunction name="tearDown" returntype="void" access="public">
    <!--- Any code needed to return your environment to normal goes here --->
  </cffunction>

</cfcomponent>

