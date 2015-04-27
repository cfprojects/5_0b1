<cfcomponent displayname="Result" output="false">
<!---
  org.gliint.framework.util.Result

  Copyright (c) 2009 Mitchell M. Rose
  All rights reserved.

  Licensed under the Apache License, Version 2.0 (the "License");
  you may not use this file except in compliance with the License.
  You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

  Unless required by applicable law or agreed to in writing, software
  distributed under the License is distributed on an "AS IS" BASIS,
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  See the License for the specific language governing permissions and
  limitations under the License.
--->
  <cfset variables['properties'] = structNew() />

  <cfset variables['instance'] = structNew() />
  <cfset variables['instance']['type'] = "" />
  <cfset variables['instance']['message'] = "" />
  <cfset variables['instance']['detail'] = "" />
  <cfset variables['instance']['extendedInfo'] = "" />
  <cfset variables['instance']['code'] = "" />
  <cfset variables['instance']['severity'] = "information" />
  <cfset variables['instance']['data'] = false />

  <!--- = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = --->

  <cffunction name="init" access="public" returntype="org.gliint.framework.util.Result" output="false" >
    <cfargument name="type" type="string" required="false" default="" />
    <cfargument name="message" type="string" required="false" default="" />
    <cfargument name="detail" type="string" required="false" default="" />
    <cfargument name="extendedInfo" type="string" required="false" default="" />
    <cfargument name="code" type="string" required="false" default="200" />
    <cfargument name="data" type="any" required="false" default="#structNew()#" />

    <cfset setType( arguments.type ) />
    <cfset setMessage( arguments.message ) />
    <cfset setDetail( arguments.detail ) />
    <cfset setExtendedInfo( arguments.extendedInfo ) />
    <cfset setCode( arguments.code ) />
    <cfset setData( arguments.data ) />

    <cfreturn this />
  </cffunction>


  <cffunction name="getInstance" access="public" returntype="struct" output="false" >
    <cfreturn variables['instance'] />
  </cffunction>


  <cffunction name="getType" access="public" returntype="string" output="false">
    <cfreturn variables['instance']['type'] />
  </cffunction>


  <cffunction name="setType" access="public" returntype="void" output="false">
    <cfargument name="type" required="true" type="string" />
    <cfset variables['instance']['type'] = arguments.type />
  </cffunction>


  <cffunction name="getMessage" access="public" returntype="string" output="false">
    <cfreturn variables['instance']['message'] />
  </cffunction>


  <cffunction name="setMessage" access="public" returntype="void" output="false">
    <cfargument name="message" required="true" type="string" />
    <cfset variables['instance']['message'] = arguments.message />
  </cffunction>


  <cffunction name="getDetail" access="public" returntype="string" output="false">
    <cfreturn variables['instance']['detail'] />
  </cffunction>


  <cffunction name="setDetail" access="public" returntype="void" output="false">
    <cfargument name="detail" required="true" type="string" />
    <cfset variables['instance']['detail'] = arguments.detail />
  </cffunction>


  <cffunction name="getExtendedInfo" access="public" returntype="string" output="false">
    <cfreturn variables['instance']['extendedInfo'] />
  </cffunction>


  <cffunction name="setExtendedInfo" access="public" returntype="void" output="false">
    <cfargument name="extendedInfo" required="true" type="string" />
    <cfset variables['instance']['extendedInfo'] = arguments.extendedInfo />
  </cffunction>


  <cffunction name="getCode" access="public" returntype="string" output="false">
    <cfreturn variables['instance']['code'] />
  </cffunction>


  <cffunction name="setCode" access="public" returntype="void" output="false">
    <cfargument name="code" required="true" type="string" />
    <cfset variables['instance']['code'] = arguments.code />
  </cffunction>


  <cffunction name="getSeverity" access="public" returntype="string" output="false">
    <cfreturn variables['instance']['severity'] />
  </cffunction>


  <cffunction name="setSeverity" access="public" returntype="void" output="false">
    <cfargument name="severity" required="true" type="string" />
    <cfset variables['instance']['severity'] = arguments.severity />
  </cffunction>


  <cffunction name="getData" access="public" returntype="any" output="false">
    <cfreturn variables['instance']['data'] />
  </cffunction>


  <cffunction name="setData" access="public" returntype="void" output="false">
    <cfargument name="data" required="true" type="any" />
    <cfset variables['instance']['data'] = arguments.data />
  </cffunction>

</cfcomponent>