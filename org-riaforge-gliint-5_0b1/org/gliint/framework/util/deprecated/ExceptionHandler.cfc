<cfcomponent name="ExceptionHandler" output="false" >
<!---
  org.gliint.framework.handler.ExceptionHandler

  Copyright (c) 2005-2009 Mitchell M. Rose
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


  <cfset variables['logger'] = false />

  <!-------------------------------------------------------------------------->

  <cffunction name="init" access="public" returntype="org.gliint.framework.util.ExceptionHandler" >
    <cfreturn this />
  </cffunction>


  <cffunction name="handleException" access="public" returntype="void" >
    <cfargument name="exception" required="true" />
    <cfargument name="responses" type="struct" required="false" default="#structNew()#" />

    <cfset var e = arguments.exception />
    <cfset var i = 0 />
    <cfset var tagContext3 = "" />
    <cfset var machineName = "" />
    <cfset var instanceName = "" />

    <!---
    note that this method does NOT create and enqueue an exception command, since we cannot
    guarantee that something hasn't gone wrong with initialization or configuration
    and we don't want to get in an endless loop
    In fact, since gliint doesn't write views, we NEVER need to create and enqueue an exception command
    --->

    <!--- we'll ignore this exception, which is thrown when cflocation runs --->
    <cfif ( structKeyExists( e, 'RootCause' ) )
      and  ( structKeyExists( e.RootCause, 'Type' ) )
      and ( e.RootCause.Type eq 'coldfusion.runtime.AbortException' ) >
      <cfreturn>
    </cfif>

    <!--- place in responses --->
    <cfset arguments.responses['_exception'] = arguments.exception />

    <!--- show top three from tagContext for tracing purposes --->
    <cfloop from="1" to="#arrayLen( e.tagContext )#" index="i">
      <cfset tagContext3 = tagContext3 & "<br>" & i & ". " & e.TagContext[i]['TEMPLATE'] & " line " & e.TagContext[i]['LINE']/>
      <cfif i eq 3><cfbreak></cfif>
    </cfloop>

    <!--- log it! --->
    <cfset getLogger().write( 'EXCEPTION #e.message# #e.detail# #tagContext3#' , 'fatal' ) />

    <!--- also trace it --->
    <cftrace gliint" type="fatal information" text="EXCEPTION #e.message# #e.detail# #tagContext3#" />

  </cffunction>


  <cffunction name="getLogger" access="public" returntype="any" >
    <cfreturn variables['logger'] />
  </cffunction>


  <cffunction name="setLogger" access="public" returntype="void" >
    <cfargument name="logger" type="any" required="true" />
    <cfset variables['logger'] = arguments.logger />
  </cffunction>

</cfcomponent>