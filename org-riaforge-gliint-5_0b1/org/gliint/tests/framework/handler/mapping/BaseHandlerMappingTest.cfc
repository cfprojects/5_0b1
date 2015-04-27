<cfcomponent name="BaseHandlerMappingTest" extends="mxunit.framework.TestCase">
  <!--- Begin specific tests --->

  <cffunction name="testgetHandler" access="public" returnType="void">
    <cfset var success = false />
    <cftry>
      <cfset this.myComp.getHandler() />
      <cfcatch type="Method.NotImplemented" >
        <!--- should throw exception --->
        <cfset success = true />
      </cfcatch>
    </cftry>
    <cfset assert(success) />
  </cffunction>


  <cffunction name="testinit" access="public" returnType="void">
    <cfset var success = false />
    <cftry>
      <cfset this.myComp.init() />
      <cfcatch type="any" >
        <!--- should throw exception --->
        <cfset success = true />
      </cfcatch>
    </cftry>
    <cfset assert(success) />
  </cffunction>

<!--- NOT testing getters and setters

  <cffunction name="testsetDefaultHandler" access="public" returnType="void">
    <cfset fail("Test testsetDefaultHandler not implemented")>
  </cffunction>


  <cffunction name="testgetDefaultHandler" access="public" returnType="void">
    <cfset fail("Test testgetDefaultHandler not implemented")>
  </cffunction>


  <cffunction name="testsetOrder" access="public" returnType="void">
    <cfset fail("Test testsetOrder not implemented")>
  </cffunction>


  <cffunction name="testgetOrder" access="public" returnType="void">
    <cfset fail("Test testgetOrder not implemented")>
  </cffunction>
--->

  <!--- setup and teardown --->

  <cffunction name="setUp" returntype="void" access="public">
    <cfset this.myComp = createObject("component","org.gliint.framework.handler.mapping.BaseHandlerMapping") />
  </cffunction>

  <cffunction name="tearDown" returntype="void" access="public">
    <!--- Any code needed to return your environment to normal goes here --->
  </cffunction>

</cfcomponent>

