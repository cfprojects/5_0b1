
<cfcomponent name="QueueTest" extends="mxunit.framework.TestCase">
  <!--- Begin specific tests --->

  <cffunction name="testclear" access="public" returnType="void">
    <cfset var item = 'item1' />
    <cfset var anotherItem = 'item2' />
    <cfset this.myComp.put( item ) />
    <cfset this.myComp.put( anotherItem ) />
    <cfset this.myComp.clear() />
    <cfset assertEqualsNumber( 0, this.myComp.size() ) />
  </cffunction>

  <cffunction name="testget" access="public" returnType="void">
    <cfset var item = 'anItem' />
    <cfset this.myComp.put( item ) />
    <cfset assertTrue( 'anItem' eq this.myComp.get() ) />
  </cffunction>

  <cffunction name="testinit" access="public" returnType="void">
    <cfset assertIsTypeOf( this.myComp, 'org.gliint.util.Queue' ) />
  </cffunction>

  <cffunction name="testisEmpty" access="public" returnType="void">
    <cfset assertEqualsBoolean( true, this.myComp.isEmpty() ) />
  </cffunction>

  <cffunction name="testpeek" access="public" returnType="void">
    <cfset var item = 'anItem' />
    <cfset this.myComp.put( item ) />
    <cfset assertTrue( 'anItem' eq this.myComp.peek() ) />
  </cffunction>

  <cffunction name="testput" access="public" returnType="void">
    <cfset var item = 'anItem' />
    <cfset this.myComp.put( item ) />
    <cfset assertEqualsNumber( 1, this.myComp.size() ) />
  </cffunction>

  <cffunction name="testsetQueue" access="public" returnType="void">
    <cfset fail("Test testsetQueue not implemented (private - need mock)")>
  </cffunction>

  <cffunction name="testsize" access="public" returnType="void">
    <cfset assertEqualsNumber( 0, this.myComp.size() ) />
  </cffunction>

  <cffunction name="teststate" access="public" returnType="void">
    <cfset var v = structNew() />
    <cfset v['queue'] = arrayNew(1) />
    <cfset assertEquals( v, this.myComp.state() ) />
  </cffunction>


  <!--- setup and teardown --->

  <cffunction name="setUp" returntype="void" access="public">
    <cfset this.myComp = createObject("component","org.gliint.util.Queue").init() />
  </cffunction>

  <cffunction name="tearDown" returntype="void" access="public">
    <!--- Any code needed to return your environment to normal goes here --->
  </cffunction>

</cfcomponent>

