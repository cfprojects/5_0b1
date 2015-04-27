<cfcomponent displayname="Logger" output="false" >
<!---
  org.gliint.framework.util.Logger

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

  <cfset variables['instance'] = structNew() />
  <cfset variables['instance']['severity'] = "" />
  <cfset variables['instance']['shouldLogToFile'] = "" />
  <cfset variables['instance']['logFilename'] = "" />

  <!--------------------------------------------------------------------------------->

  <cffunction name="init" access="public" returntype="org.gliint.framework.util.Logger" >
    <cfargument name="severity" type="string" required="true" hint="one of: Information|Warning|Error|Fatal|blank (no logging)" />
    <cfargument name="shouldLogToFile" type="boolean" required="true" />
    <cfargument name="logFilename" type="string" required="true" />

    <cfset setSeverity( arguments.severity ) />
    <cfset setShouldLogToFile( arguments.shouldLogToFile ) />
    <cfset setLogFilename( arguments.logFilename ) />

    <cfreturn this />
  </cffunction>


  <cffunction name="write" access="public" returntype="void" >
    <cfargument name="text" type="string" required="true" />
     <cfargument name="type" type="string" required="true" hint="severity of the message" />

    <cfset var st = structNew() />

    <cfif ( getShouldLogToFile() and ( len( getLogFilename() ) gt 0 ) ) >

      <!--- determine if the severity of the entry qualifies --->
      <cfswitch expression="#lcase( getSeverity() )#">

        <cfcase value="fatal" >
          <cfif listFindNoCase( 'fatal', lcase( arguments.type ) ) >
            <cflog text="#arguments.text#" file="#getLogFilename()#" type="#arguments.type#" />
          </cfif>
        </cfcase>

        <cfcase value="error" >
          <cfif listFindNoCase( 'fatal,error', lcase( arguments.type ) ) >
            <cflog text="#arguments.text#" file="#getLogFilename()#" type="#arguments.type#" />
          </cfif>
        </cfcase>

        <cfcase value="warning" >
          <cfif listFindNoCase( 'fatal,error,warning', lcase( arguments.type ) ) >
            <cflog text="#arguments.text#" file="#getLogFilename()#" type="#arguments.type#" />
          </cfif>
        </cfcase>

        <cfcase value="information" >
          <cfif listFindNoCase( 'fatal,error,warning,information', lcase( arguments.type ) ) >
            <cflog text="#arguments.text#" file="#getLogFilename()#" type="#arguments.type#" />
          </cfif>
        </cfcase>

      </cfswitch>

    </cfif>

  </cffunction>


  <!--- getters/setters ------------------------------------------------------------->

  <cffunction name="setSeverity" access="private" returntype="void" >
    <cfargument name="severity" type="string" required="true" />
    <cfset variables['instance']['severity'] = arguments.severity />
  </cffunction>


  <cffunction name="getSeverity" access="public" returntype="string" >
    <cfreturn variables['instance']['severity'] />
  </cffunction>


  <cffunction name="setShouldLogToFile" access="private" returntype="void" >
    <cfargument name="shouldLogToFile" type="boolean" required="true" />
    <cfset variables['instance']['shouldLogToFile'] = arguments.shouldLogToFile />
  </cffunction>


  <cffunction name="getShouldLogToFile" access="public" returntype="boolean" >
    <cfreturn variables['instance']['shouldLogToFile'] />
  </cffunction>


  <cffunction name="setLogFilename" access="private" returntype="void" >
    <cfargument name="logFilename" type="string" required="true" />
    <cfset variables['instance']['logFilename'] = arguments.logFilename />
  </cffunction>


  <cffunction name="getLogFilename" access="public" returntype="string" >
    <cfreturn variables['instance']['logFilename'] />
  </cffunction>

</cfcomponent>