<cfcomponent displayname="BaseTraceRenderer" output="false">
<!---
Provides the getTraceQuery method, which is available only when ColdFusion debugging is on.
Intended to be subclassed for use by renderers for various connectors.

<b>Exposed configuration properties  (including those defined by superclass):</b>
<br/>
None

<b>Since:</b>

<b>See Also:</b>

<b>Special Thanks:</b>
<br/>Includes code adapted from the ColdFire Coldfusion Debugger (http://coldfire.riaforge.org/)
<br/>Thanks Ray, Adam, and Nathan!
--->
<!---
org.gliint.framework.util.BaseTraceRenderer

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

	<cffunction name="init" access="public" returntype="org.gliint.framework.util.BaseTraceRenderer" output="false">
		<cfreturn this />
	</cffunction>


	<cffunction name="getTraceQuery" access="public" returnType="query" output="false">

		<cfset var sf = createObject( 'java', 'coldfusion.server.ServiceFactory' ) />
		<cfset var ds = sf.getDebuggingService() />
		<cfset var qEvents = queryNew('')	/>
		<cfset var result = queryNew('attributes,body,cachedquery,category,datasource,delta,endtime,line,message,name,parent,priority,result,rowcount,stacktrace,starttime,template,timestamp,type,url') />
		<cfset var last = 0 />

		<cfif ds.isEnabled() >
			<cfset qEvents = ds.getDebugger().getData() />
			<cfset qEvents = duplicate( qEvents ) />

			<cfquery dbType="query" name="result" debug="false">
				SELECT *
				FROM qEvents
				WHERE type = 'Trace'
			</cfquery>

			<!--- before we leave, do delta --->
			<cfset queryAddColumn( result, 'delta', arrayNew(1) ) />

			<cfloop query="result">
				<cfif ( currentRow is 1 ) >
					<cfset querySetCell( result, 'delta', 0, currentRow ) />
				<cfelse>
					<cfset querySetCell( result, 'delta', endtime-last, currentRow ) />
				</cfif>

				<cfset last = endtime />
			</cfloop>
		</cfif>

		<cfreturn result>
	</cffunction>

</cfcomponent>