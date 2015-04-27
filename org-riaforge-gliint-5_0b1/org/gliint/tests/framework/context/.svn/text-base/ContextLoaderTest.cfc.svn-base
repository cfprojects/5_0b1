<cfcomponent name="ContextLoaderTest" extends="mxunit.framework.TestCase">
    <!--- Begin specific tests --->

  <cffunction name="testinit" access="public" returnType="void">
    <cfset this.myComp.init( 'org.gliint.framework.context.DefaultWebApplicationContext', 'contextConfigLocation', 'parentContextKey' ) />
    <cfset assertIsTypeOf( this.myComp, 'org.gliint.framework.context.ContextLoader' ) />
    <cfset assertTrue( 'org.gliint.framework.context.DefaultWebApplicationContext' eq this.myComp.getContextClass() ) />
    <cfset assertTrue( 'contextConfigLocation' eq this.myComp.getContextConfigLocation() ) />
    <cfset assertTrue( 'parentContextKey' eq this.myComp.getParentContextKey() ) />
  </cffunction>


  <cffunction name="testcreateDefaultWebApplicationContext" access="public" returnType="void">
    <cfset var c = false />
    <cfset this.myComp.setContextClass( 'org.gliint.framework.context.DefaultWebApplicationContext' ) />
    <cfset c = this.myComp.createWebApplicationContext( 'local', 'testContext' ) />
    <cfset assertIsTypeOf( c, 'org.gliint.framework.context.DefaultWebApplicationContext' ) />
  </cffunction>


<!--- NOT testing getters and setters
  <cffunction name="testgetContextClass" access="public" returnType="void">
    <cfset fail("Test testgetContextClass not implemented")>
  </cffunction>

  <cffunction name="testgetContextConfigLocation" access="public" returnType="void">
    <cfset fail("Test testgetContextConfigLocation not implemented")>
  </cffunction>

  <cffunction name="testgetParentContextKey" access="public" returnType="void">
    <cfset fail("Test testgetParentContextKey not implemented")>
  </cffunction>

  <cffunction name="testsetContextClass" access="public" returnType="void">
    <cfset fail("Test testsetContextClass not implemented")>
  </cffunction>

  <cffunction name="testsetContextConfigLocation" access="public" returnType="void">
    <cfset fail("Test testsetContextConfigLocation not implemented")>
  </cffunction>

  <cffunction name="testsetParentContextKey" access="public" returnType="void">
    <cfset fail("Test testsetParentContextKey not implemented")>
  </cffunction>
--->

  <!--- setup and teardown --->

  <cffunction name="setUp" returntype="void" access="public">
    <cfset this.myComp = createObject( 'component', 'org.gliint.framework.context.ContextLoader' ) />
  </cffunction>

  <cffunction name="tearDown" returntype="void" access="public">
    <!--- Any code needed to return your environment to normal goes here --->
  </cffunction>

</cfcomponent>

