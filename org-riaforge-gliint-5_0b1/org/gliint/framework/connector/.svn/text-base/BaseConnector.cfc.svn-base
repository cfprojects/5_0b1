<cfcomponent displayname="BaseConnector" extends="org.gliint.framework.handler.BaseHandlerInterceptor" >
<!---
Provides methods common to all connectors; authors wishing to create their own connectors
should extend this component.

Provides a query of trace results (when CF debugging is on) to subclassing components.

Optionally configurable via a 'configuration' property and
associated accessor and mutator methods and it is expected that subclassing
connectors will utilize this feature. They are also bean-factory aware.

<b>Exposed configuration properties  (including those defined by superclass):</b>
<br/>
<table class="withBorder" cellpadding="3" cellspacing="">
	<tbody>
	<tr class="" style="bottom-border: 1px black solid;">
		<th><b>name</b></th>
		<th><b>default</b></th>
		<th><b>description</b></th>
	</tr>
	<tr>
		<td>configuration</td>
		<td>#structNew()#</td>
		<td>a structure (map) of configuration data</td>
	</tr>

	</tbody>
</table>

<b>Since:</b>

<b>See Also:</b>
	<br/>&nbsp;
--->
<!---
org.gliint.framework.connector.BaseConnector

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

	<cfset variables['properties'] = structNew() />
	<cfset variables['properties']['configuration'] = structNew() />

	<!-------------------------------------------------------------------------->

	<cffunction name="init" access="public" returntype="org.gliint.framework.connector.BaseConnector" output="false">
		<cfreturn this />
	</cffunction>


	<cffunction name="preHandle" access="public" returntype="boolean" output="false">
		<cfargument name="request" type="string" required="true" />
		<cfargument name="response" type="struct" required="true" />
		<cfargument name="handler" type="any" required="true" hint="handlerExecutionChain" />

		<!--- the name of the application event being processed --->
		<cfset arguments.response['_applicationEvent'] = arguments.request />

		<!--- an internal reference to the handlerExecutionChain for later modification, if necessary --->
		<cfparam name="arguments.response['_connectors']" default="#arguments.handler#" />

		<cfparam name="arguments.response['_timestamp']" default="#now()#" />

		<!--- an id to track this request, for any internal metrics you might create --->
		<cfparam name="arguments.response['_identity']" default="#createUUID()#" />

		<!--- a placeholder for the latest exception, for reference --->
		<cfparam name="arguments.response['_exception']" default="" />

		<!--- a placeholder for request arguments --->
		<cfparam name="arguments.response['_request']" default="#structNew()#" />

		<!--- a placeholder for an optional result object (see framework.util.Result) --->
		<cfparam name="arguments.response['_result']" default="#structNew()#" />

		<!--- a placeholder for the output stream --->
		<cfparam name="arguments.response['_output']" default="" />

		<!--- a preprocessor flag --->
		<cfparam name="arguments.response['_isPrehandled']" default="#false#" />

		<!--- a postprocessor flag --->
		<cfparam name="arguments.response['_isPosthandled']" default="#false#" />

		<cfreturn false />
	</cffunction>


	<cffunction name="postHandle" access="public" returntype="void" output="false">
		<cfargument name="request" type="string" required="true" />
		<cfargument name="response" type="struct" required="true" />
		<cfargument name="handler" type="any" required="true" hint="handlerExecutionChain" />
		<cfthrow type="Method.NotImplemented" message="abstract method must be overridden">
	</cffunction>


	<cffunction name="getTraceQuery" access="public" returnType="query" output="false">

		<cfset var sf = false />
		<cfset var ds = false />
		<cfset var qEvents = queryNew('') />
		<cfset var result = queryNew('') />
		<cfset var last = 0 />

		<cftry>

			<cfset sf = createObject( 'java', 'coldfusion.server.ServiceFactory' ) />
			<cfset ds = sf.getDebuggingService() />
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

			<cfcatch type="any">
				<cfset result = queryNew('attributes,body,cachedquery,category,datasource,delta,endtime,line,message,name,parent,priority,result,rowcount,stacktrace,starttime,template,timestamp,type,url') />
			</cfcatch>

		</cftry>

		<cfreturn result>
	</cffunction>


	<cffunction name="hasProperty" access="public" returntype="boolean">
		<cfargument name="propertyName" required="true" type="string" />
		<cfreturn structKeyExists( variables['properties']['configuration'], arguments.propertyName ) />
	</cffunction>


	<cffunction name="getProperty" access="public" returntype="any" output="false">
		<cfargument name="propertyName" required="true" type="string" />
		<cfreturn variables['properties']['configuration'][arguments.propertyName] />
	</cffunction>

</cfcomponent>