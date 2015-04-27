<cfcomponent name="SizedQueueTest" extends="mxunit.framework.TestCase">
  <!--- Begin specific tests --->

  <cffunction name="testgetMaxSize" access="public" returnType="void">
    <cfset assertEqualsNumber( 2, this.myComp.getMaxSize() ) />
  </cffunction>

  <cffunction name="testinit" access="public" returnType="void">
    <cfset assertIsTypeOf( this.myComp, 'org.gliint.util.SizedQueue') />
  </cffunction>

  <cffunction name="testisFull" access="public" returnType="void">
    <cfset var anotherItem = 'item2' />
    <cfset var item = 'item1' />
    <cfset this.myComp.put( item ) />
    <cfset this.myComp.put( anotherItem ) />
    <cfset assertTrue( this.myComp.isFull() ) />
  </cffunction>

  <cffunction name="testput" access="public" returnType="void">
    <cfset var item = 'item1' />
    <cfset this.myComp.put( item ) />
    <cfset assertEqualsNumber( 1, this.myComp.size() ) />
  </cffunction>

  <cffunction name="testsetMaxSize" access="public" returnType="void">
    <cfset fail("Test testsetMaxSize not implemented (private - need mock)")>
  </cffunction>


  <!--- setup and teardown --->

  <cffunction name="setUp" returntype="void" access="public">
    <cfset this.myComp = createObject( 'component', 'org.gliint.util.SizedQueue' ).init(2) />
  </cffunction>

  <cffunction name="tearDown" returntype="void" access="public">
    <!--- Any code needed to return your environment to normal goes here --->
  </cffunction>

</cfcomponent>