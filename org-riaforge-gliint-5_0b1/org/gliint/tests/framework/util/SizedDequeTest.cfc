<cfcomponent name="SizedDequeTest" extends="mxunit.framework.TestCase">
  <!--- Begin specific tests --->

  <cffunction name="testgetMaxSize" access="public" returnType="void">
    <cfset assertEqualsNumber( 2, this.myComp.getMaxSize() ) />
  </cffunction>

  <cffunction name="testinit" access="public" returnType="void">
    <cfset assertIsTypeOf( this.myComp, 'org.gliint.util.Deque' ) />
  </cffunction>

  <cffunction name="testisFull" access="public" returnType="void">
    <cfset var anotherItem = 'item2' />
    <cfset var item = 'item1' />
    <cfset this.myComp.put( item ) />
    <cfset this.myComp.put( anotherItem ) />
    <cfset assertEqualsBoolean( true, this.myComp.isFull() ) />
  </cffunction>

  <cffunction name="testpush" access="public" returnType="void">
    <cfset var item = 'anItem' />
    <cfset this.myComp.push( item ) />
    <cfset assertEqualsNumber( 1, this.myComp.size() ) />
  </cffunction>

  <cffunction name="testput" access="public" returnType="void">
    <cfset var item = 'item1' />
    <cfset this.myComp.put( item ) />
    <cfset assertEqualsNumber( 1, this.myComp.size() ) />
  </cffunction>


  <!--- setup and teardown --->

  <cffunction name="setUp" returntype="void" access="public">
    <cfset this.myComp = createObject("component","org.gliint.util.SizedDeque").init(2) />
  </cffunction>

  <cffunction name="tearDown" returntype="void" access="public">
    <!--- Any code needed to return your environment to normal goes here --->
  </cffunction>

</cfcomponent>