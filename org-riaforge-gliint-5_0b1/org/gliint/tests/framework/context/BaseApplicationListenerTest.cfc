<cfcomponent name="BaseApplicationListenerTest" extends="mxunit.framework.TestCase">
    <!--- Begin specific tests --->

  <cffunction name="testinit" access="public" returnType="void">
    <cfset assertIsTypeOf( this.myComp, 'org.gliint.framework.context.BaseApplicationListener' ) />
  </cffunction>

  <cffunction name="testgetClass" access="public" returnType="void">
    <cfset assertTrue( this.myComp.class() eq 'org.gliint.framework.context.BaseApplicationListener' ) />
  </cffunction>

  <!--- setup and teardown --->

  <cffunction name="setUp" returntype="void" access="public">
    <cfset this.myComp = createObject( 'component', 'org.gliint.framework.context.BaseApplicationListener' ).init() />
  </cffunction>

  <cffunction name="tearDown" returntype="void" access="public">
    <!--- Any code needed to return your environment to normal goes here --->
  </cffunction>

</cfcomponent>

