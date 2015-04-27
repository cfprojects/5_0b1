<cfcomponent name="StackTest" extends="mxunit.framework.TestCase">
  <!--- Begin specific tests --->

  <cffunction name="testclear" access="public" returnType="void">
    <cfset var anElement = 'element1' />
    <cfset var anotherElement = 'element2' />
    <cfset this.myComp.push( anElement ) />
    <cfset this.myComp.push( anotherElement ) />
    <cfset this.myComp.clear() />
    <cfset assertEqualsNumber( 0, this.myComp.size() ) />
  </cffunction>

  <cffunction name="testinit" access="public" returnType="void">
    <cfset assertIsTypeOf( this.myComp, 'org.gliint.util.Stack' ) />
  </cffunction>

  <cffunction name="testisEmpty" access="public" returnType="void">
    <cfset assertEqualsBoolean( true, this.myComp.isEmpty() ) />
  </cffunction>

  <cffunction name="testpeek" access="public" returnType="void">
    <cfset var anElement = 'element1' />
    <cfset this.myComp.push( anElement ) />
    <cfset assertTrue( 'element1' eq this.myComp.peek() ) />
  </cffunction>

  <cffunction name="testpop" access="public" returnType="void">
    <cfset var anElement = 'element1' />
    <cfset this.myComp.push( anElement ) />
    <cfset assertTrue( 'element1' eq this.myComp.pop() ) />
  </cffunction>

  <cffunction name="testpush" access="public" returnType="void">
    <cfset var anElement = 'element1' />
    <cfset this.myComp.push( anElement ) />
    <cfset assertEqualsNumber( 1, this.myComp.size() ) />
  </cffunction>

  <cffunction name="testsetStack" access="public" returnType="void">
    <cfset fail("Test testsetStack not implemented (private - need mock)")>
  </cffunction>

  <cffunction name="testsize" access="public" returnType="void">
    <cfset assertEqualsNumber( 0, this.myComp.size() ) />
  </cffunction>


  <!--- setup and teardown --->

  <cffunction name="setUp" returntype="void" access="public">
    <cfset this.myComp = createObject( 'component', 'org.gliint.util.Stack' ).init() >
  </cffunction>

  <cffunction name="tearDown" returntype="void" access="public">
    <!--- Any code needed to return your environment to normal goes here --->
  </cffunction>

</cfcomponent>