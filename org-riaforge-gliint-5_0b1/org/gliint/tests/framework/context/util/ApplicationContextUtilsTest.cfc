<cfcomponent displayname="ApplicationContextUtilsTest" output="false">



  <cffunction name="testinit" access="public" returnType="void">
    <cfset assertIsTypeOf( this.myComp, 'org.gliint.framework.context.util.ApplicationContextUtils' ) />
  </cffunction>

  <!--- setup and teardown --->

  <cffunction name="setUp" returntype="void" access="public">
    <cfset this.myComp = createObject("component","org.gliint.framework.context.util.AbstractContextUtils")>
  </cffunction>

  <cffunction name="tearDown" returntype="void" access="public">
    <!--- Any code needed to return your environment to normal goes here --->
  </cffunction>

</cfcomponent>