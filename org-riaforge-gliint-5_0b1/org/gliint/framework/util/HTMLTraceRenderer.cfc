<cfcomponent displayname="HTMLTraceRenderer" extends="BaseTraceRenderer" output="false" >
<!---
  org.gliint.framework.util.HTMLTraceRenderer

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

  <cfset variables['bgcolors'] = structNew() />
  <cfset variables['bgcolors']['debug'] = '##FFFFFF' />
  <cfset variables['bgcolors']['information'] = '##FFFFFF' />
  <cfset variables['bgcolors']['warning'] = '##FFFFCC' />
  <cfset variables['bgcolors']['error'] = '##FFCC99' />
  <cfset variables['bgcolors']['fatal'] = '##FF99CC' />

  <!-------------------------------------------------------------------------->

  <cffunction name="init" access="public" returntype="org.gliint.framework.util.HTMLTraceRenderer" >
    <cfreturn this />
  </cffunction>


  <cffunction name="render" access="public" returntype="string" >

    <cfset var q = getTraceQuery() />
    <cfset var bgcolor = "" />
    <cfset var output = "" />
    <!--- cfset var n = application[application.applicationName] / --->

  <cfsavecontent variable="output" >
    <cfoutput>
    <br />
     <div>
    <table cellpadding="6" cellspacing="0" width="100%" style="border:1px Solid ##CCC;font-family:verdana;font-size:9pt;text-align:left;">
    <thead style="background:##EAEAEA;">
			<!---
      <tr style="font-family:verdana;">
          <strong>Gliint Debugging</strong>
          <cfif ( structKeyExists( n, 'dateTimeLastLoaded' ) ) >
          &nbsp;loaded: #dateFormat( n['dateTimeLastLoaded'], 'dd mmm yyyy' )# #timeFormat( n['dateTimeLastLoaded'], 'hh:mm:ss:l' )#
          </cfif>
          <cfif ( structKeyExists( n, 'reloadPasswordName' ) and structKeyExists( n, 'reloadPasswordValue' ) ) >
          &nbsp; <a href="?event=reload&#n['reloadPasswordName']#=#n['reloadPasswordValue']#"><button>reload</button></a>
          </cfif>
      </tr>
			--->
      <cfif ( q.recordcount gt 0 ) >
      <tr>
        <th>&nbsp;</th>
        <th><strong>Time</strong></th>
        <th><strong>msec</strong></th>
        <th><strong>Severity</strong></th>
        <th><strong>Text</strong></th>
      </tr>
      </cfif>
    </thead>
    <tbody id="gliintDebuggingTbody">
      <cfloop query="q" >
        <tr style="background:#getBgcolor( priority )#;" bgcolor="#getBgcolor( priority )#" >
          <td>&nbsp;</td>
          <td valign="top">#timeFormat( timestamp, 'hh:mm:ss:l' )#</td>
          <td valign="top" align="right">#numberFormat( delta ,'____')#</td>
          <td valign="top">#priority#</td>
          <td valign="top">#message#</td>
        </tr>
      </cfloop>
      </tbody>
    </table>
    </div>
     </cfoutput>
  </cfsavecontent>

    <cfreturn output />
  </cffunction>


  <cffunction name="getBgcolor" access="private" output="false" returntype="string" >
    <cfargument name="type" type="string" required="true" />
    <cfset var key = listFirst( arguments.type, ' ' ) />
    <cfreturn variables['bgcolors'][key] />
  </cffunction>

</cfcomponent>