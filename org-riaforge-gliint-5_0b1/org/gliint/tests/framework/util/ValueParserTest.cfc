<cfcomponent name="ExprParserTest" extends="mxunit.framework.TestCase">
  <!--- Begin specific tests --->

  <cffunction name="testgetScopedValue" access="public" returnType="void">
    <cfset fail("Test testgetScopedValue not implemented (private - need mock)")>
  </cffunction>

  <cffunction name="testinit" access="public" returnType="void">
    <cfset assertIsTypeOf( this.myComp, 'org.gliint.framework.util.ValueParser' ) />
  </cffunction>

  <cffunction name="testParseValueSimple" access="public" returntype="void" >
      <cfset var data = structNew() />
      <cfset data.item1 = 'anItem' />
      <cfset assertTrue( 'anItem' eq  this.myComp.parseValue( 'anItem', data ) ) />
  </cffunction>

  <cffunction name="testParseValueSimpleSubstitution" access="public" returntype="void" >
      <cfset var data = structNew() />
      <cfset data.item1 = 'anItem' />
      <cfset data['item2.isFound'] = true />
      <cfset assertTrue( 'anItem' eq this.myComp.parseValue( '${item1}', data ) ) />
      <cfset assertEqualsBoolean( true, this.myComp.parseValue( '${item2.isFound}', data ) ) />
  </cffunction>

  <cffunction name="testParseValueComplexSubstitution" access="public" returntype="void" >
      <cfset var data = structNew() />
      <cfset data.st = structNew() />
      <cfset data.st.isFound = true />
      <cfset assertEqualsBoolean( true, this.myComp.parseValue( '?{st.isFound}', data ) ) />
  </cffunction>

  <cffunction name="testGetValueNativeScope" access="public" returntype="void" >
      <cfset request.item1 = 'anotherItem' />
      <cfset assertTrue( 'anotherItem' eq this.myComp.parseValue( 'anotherItem', request ) ) />
  </cffunction>

  <cffunction name="testinspectArray" access="public" returnType="void">
    <cfset fail("Test testinspectArray not implemented (private - need mock)")>
  </cffunction>

  <cffunction name="testinspectStruct" access="public" returnType="void">
    <cfset fail("Test testinspectStruct not implemented (private - need mock)")>
  </cffunction>


  <!--- setup and teardown --->

  <cffunction name="setUp" returntype="void" access="public">
    <cfset this.myComp = createObject("component","org.gliint.framework.util.ValueParser").init() />
  </cffunction>

  <cffunction name="tearDown" returntype="void" access="public">
    <!--- Any code needed to return your environment to normal goes here --->
  </cffunction>

</cfcomponent>

