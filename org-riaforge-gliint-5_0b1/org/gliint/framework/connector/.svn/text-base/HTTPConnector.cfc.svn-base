<cfcomponent displayname="HTTPConnector" output="true" extends="org.gliint.framework.connector.BaseConnector" >
<!---
Marshalls url, form, cgi and http header data into the
response to be used as input for processing using configuration guidelines.

Provides the post-processed response and a query of trace data to the coldfusion
component, custom tag, or include configured for view resolution.

Is bean factory aware.

<b>Exposed configuration properties  (including those defined by superclass):</b>
<br/>
<table class="withBorder" cellpadding="3" cellspacing="">
	<tbody>
	<tr style="bottom-border: 1px black solid;">
		<th><b>name</b></th>
		<th><b>default</b></th>
		<th><b>description</b></th>
	</tr>
	<tr>
		<td>beanFactory</td>
		<td>false</td>
		<td>typically ColdSpring's DefaultXmlBeanFactory</td>
	</tr>
	<tr>
		<td>configuration</td>
		<td>#structNew()#</td>
		<td>a structure (map) of configuration data: not used in this version</td>
	</tr>
	<tr>
		<td>preHandleApplicationEvents</td>
		<td>onRequestStart</td>
		<td>a comma delimited list of ColdFusion application events which will cause preHandle() to execute</td>
	</tr>
	<tr>
		<td>preHandleScopeSequence</td>
		<td>url,form,cgi,httpRequestData</td>
		<td>a comma delimited list of ColdFusion scopes which will be inspected in sequence for variables to be copied to the request</td>
	</tr>
	<tr>
		<td>preHandleUrl</td>
		<td>* (all variables)</td>
		<td>a comma delimited list of variable names from the URL scope which will be copied to the request</td>
	</tr>
	<tr>
		<td>preHandleForm</td>
		<td>* (all variables)</td>
		<td>a comma delimited list of variable names from the FORM scope which will be copied to the request</td>
	</tr>
	<tr>
		<td>preHandleCgi</td>
		<td>REMOTE_ADDR,SERVER_PORT,SERVER_PORT_SECURE,SERVER_NAME</td>
		<td>a comma delimited list of variable names from the CGI scope which will be copied to the request</td>
	</tr>
	<tr>
		<td>preHandleHttpRequestData</td>
		<td>headers,method</td>
		<td>a comma delimited list of variable names from the HttpRequestData which will be copied to the request</td>
	</tr>
	<tr>
		<td>postHandleApplicationEvents</td>
		<td>onRequestEnd</td>
		<td>a comma delimited list of ColdFusion application events which will cause postHandle() to execute</td>
	</tr>
	<tr>
		<td>postHandleShowDebugOutput</td>
		<td>false</td>
		<td>when true, debug output will be displayed when ColdFusion debugging output is enabled</td>
	</tr>
	<tr>
		<td>postHandleShowTrace</td>
		<td>false</td>
		<td>when true, ColdFusion traces will be provided to the output view writing delegate</td>
	</tr>
	<tr>
		<td>postHandleWriterResolution</td>
		<td></td>
		<td><One of "include", "module", "component", "bean". View writer delegate type.</td>
	</tr>
	<tr>
		<td>postHandleWriterLocation</td>
		<td></td>
		<td>
			if writerResolution is "include" or "module", location of ColdFusion template,
			<br/>if writerResolution is "component", path to ColdFusion component, must be used in conjunction with postHandleWriterLocation,
			<br/>if writerResolution is "bean", name of bean known to the beanFactory containing this component, must be used in conjunction with postHandleWriterLocation.
		</td>
	</tr>
	<tr>
		<td>postHandleWriterMethod</td>
		<td></td>
		<td>method to be invoked  when postHandleWriterResolution is "component" or "bean"</td>
	</tr>
	<tr>
		<td>shouldClearOutputBuffer</td>
		<td>true</td>
		<td>when true, will clear the output buffer before writing output</td>
	</tr>
	<tr>
		<td>shouldTrace</td>
		<td>false</td>
		<td>when true, and ColdFusion debugging is on, traces will be written</td>
	</tr>
	<tr>
		<td>traceRenderer</td>
		<td>false</td>
		<td>component which will render trace query into acceptable format for configured writer</td>
	</tr>
	<tr>
	</tbody>
</table>

<b>Since:</b>

<b>See Also:</b>
	<br/>&nbsp;
--->
<!---
org.gliint.framework.connector.HTTPConnector

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
	<cfset variables['properties']['beanFactory'] = false />
	<cfset variables['properties']['preHandleApplicationEvents'] = "onRequestStart" />
	<cfset variables['properties']['preHandleScopeSequence'] = "url,form,cgi,httpRequestData" />
	<cfset variables['properties']['preHandleUrl'] = "*" />
	<cfset variables['properties']['preHandleForm'] = "*" />
	<cfset variables['properties']['preHandleCgi'] = "REMOTE_ADDR,SERVER_PORT,SERVER_PORT_SECURE,SERVER_NAME" />
	<cfset variables['properties']['preHandleHttpRequestData'] = "headers,method" />
	<cfset variables['properties']['postHandleApplicationEvents'] = "onRequestEnd" />
	<cfset variables['properties']['postHandleShowDebugOutput'] = "false" />
	<cfset variables['properties']['postHandleShowTrace'] = "false" />
	<cfset variables['properties']['postHandleWriterResolution'] = "" />
	<cfset variables['properties']['postHandleWriterLocation'] = "" />
	<cfset variables['properties']['postHandleWriterMethod'] = "" />
	<cfset variables['properties']['shouldClearOutputBuffer'] = "true" />
	<cfset variables['properties']['shouldTrace'] = false />
	<cfset variables['properties']['traceRenderer'] = false />

	<!-------------------------------------------------------------------------->

	<cffunction name="init" access="public" output="false" returntype="org.gliint.framework.connector.HTTPConnector" >
		<cfreturn this />
	</cffunction>


	<cffunction name="preHandle" access="public" output="false" returntype="boolean" >
		<cfargument name="request" type="string" required="true" />
		<cfargument name="response" type="struct" required="true" />
		<cfargument name="handler" type="any" required="true" hint="handlerExecutionChain" />

		<cfset var r = structNew() />
		<cfset var i = 0 />
		<cfset var j = "" />
		<cfset var sc = structNew() />
		<cfset var st = structNew() />
		<cfset var httpRequestData = structNew() />
		<cfset var cd = structNew() />
		<cfset var seq = getPreHandleScopeSequence() />

		<cfif getShouldTrace() >
			<cftrace type="information" text="HTTPConnector preHandle starts" />
		</cfif>

		<!---
			if the _isPreHandled flag is true, below has already been done, so return
			this also provides a simple way to do a 'reset'
		--->
		<cfif ( structKeyExists( arguments.response, '_isPreHandled' ) and arguments.response['_isPreHandled'] ) >
			<cfif getShouldTrace() >
				<cftrace type="information" text="HTTPConnector preHandle completes (_isPreHandled)" />
			</cfif>
			<cfreturn true />
		</cfif>

		<!--- super.preHandle() sets some defaults --->
		<cfset super.preHandle( arguments.request, arguments.response, arguments.handler ) />

		<!--- only respond to the list of named events in the configuration --->
		<cfif ( listFindNoCase( getPreHandleApplicationEvents(), arguments.request ) eq 0 ) >
			<cfreturn true />
		</cfif>

		<cfset httpRequestData = getHttpRequestData() />

		<cfloop list="#seq#" index="i" >

			<cfset st = structNew() />
			<cfset cd = evaluate( 'getPreHandle' & i & '()' ) />

			<!--- duplicate each scope to remove the hard reference --->
			<cfset sc = duplicate( evaluate(i) ) />

			<cfloop collection="#sc#" item="j">
				<!--- asterisk is a magic word, means 'all' --->
				<cfif ( ( isSimpleValue( cd ) and cd eq '*' ) or ( listFindNoCase( cd, j ) gt 0 ) ) >
					<cfset st[lcase(j)] = sc[j] />
				</cfif>
			</cfloop>

			<!--- now append, overwriting --->
			<cfset structAppend( r, st, true ) />

			<!--- add to the 'reserved' variable for the request
			this will be handy to reference if we need to get the original request data later
			--->
			<cfset r['_request']['_' & i] = duplicate(st) />
			<cfset structAppend( r['_request'], st, true ) />
		</cfloop>

		<cfset arguments.response['_isPreHandled'] = true />
		<cfset structAppend( arguments.response, r, true) />

		<cfif getShouldTrace() >
			<cftrace type="information" text="HTTPConnector preHandle completes" />
		</cfif>

		<cfreturn true />
	</cffunction>


	<cffunction name="postHandle" access="public" returntype="void" output="false">
		<cfargument name="request" type="string" required="true" />
		<cfargument name="response" type="struct" required="true" />
		<cfargument name="handler" type="any" required="true" hint="handlerExecutionChain" />

		<cfset var cd =  structNew() />
		<cfset var showTrace = false />
		<cfset var showDebugOutput = false />
		<cfset var writerResolution = "" />
		<cfset var traceOutput = "" />

		<cfif getShouldTrace() >
			<cftrace type="information" text="HTTPConnector postHandle starts" />
		</cfif>

		<!---
			if the _isPostHandled flag exists and is true, below has already been done, so return
			this also gives us a simple way to do a 'reset'
		--->
		<cfif ( structKeyExists( arguments.response, '_isPostHandled' ) and arguments.response['_isPostHandled'] ) >
			<cfif getShouldTrace() >
				<cftrace type="information" text="HTTPConnector postHandle completes (_isPostHandled)" />
			</cfif>
			<cfreturn />
		</cfif>

		<!--- only respond to the list of named events in the configuration --->
		<cfif ( listFindNoCase( getPostHandleApplicationEvents(), arguments.request ) eq 0 ) >
			<cfif getShouldTrace() >
				<cftrace type="information" text="HTTPConnector postHandle completes" />
			</cfif>
			<cfreturn />
		</cfif>

		<cfif ( getPostHandleShowTrace() and isObject( getTraceRenderer() ) ) >
			<cfset traceOutput = getTraceRenderer().render( getTraceQuery() ) />
		</cfif>

		<cfif getShouldTrace() >
			<cftrace type="information" text="HTTPConnector postHandle writing with #getPostHandleWriterLocation()#" />
		</cfif>

		<!--- we're setting this before rendering so that responses can appear to be 'completed'. Otherwise to some it'll just be confusing --->
		<cfset arguments.response['_isPostHandled'] = true />

		<cfsetting showdebugoutput="#getPostHandleShowDebugOutput()#" />
		<cfinvoke method="#getPostHandleWriterResolution()#" >
			<cfinvokeargument name="response" value="#arguments.response#">
			<cfinvokeargument name="trace" value="#traceOutput#">
		</cfinvoke>

		<cfif getShouldTrace() >
			<cftrace type="information" text="HTTPConnector postHandle completes" />
		</cfif>
	</cffunction>


	<!--- ---------------------------------------------------------------------------- --->

	<cffunction name="getBeanFactory" access="public" returntype="any" output="false">
		<cfreturn variables['properties']['beanFactory'] />
	</cffunction>


	<cffunction name="setBeanFactory" access="public" returntype="void" output="false">
		<cfargument name="beanFactory" required="true" type="coldspring.beans.BeanFactory" />
		<cfset variables['properties']['beanFactory'] = arguments.beanFactory />
	</cffunction>


	<cffunction name="setPreHandleApplicationEvents" access="public" returntype="void" output="false" >
		<cfargument name="preHandleApplicationEvents" type="string" required="true" />
		<cfset variables['properties']['preHandleApplicationEvents'] = arguments.preHandleApplicationEvents />
	</cffunction>


	<cffunction name="getPreHandleApplicationEvents" access="private" returntype="string" output="false" >
		<cfreturn variables['properties']['preHandleApplicationEvents'] />
	</cffunction>


	<cffunction name="setPreHandleScopeSequence" access="public" returntype="void" output="false" >
		<cfargument name="preHandleScopeSequence" type="string" required="true" />
		<cfset variables['properties']['preHandleScopeSequence'] = arguments.preHandleScopeSequence />
	</cffunction>


	<cffunction name="getPreHandleScopeSequence" access="private" returntype="string" output="false" >
		<cfreturn variables['properties']['preHandleScopeSequence'] />
	</cffunction>


	<cffunction name="setPreHandleUrl" access="public" returntype="void" output="false" >
		<cfargument name="preHandleUrl" type="string" required="true" />
		<cfset variables['properties']['preHandleUrl'] = arguments.preHandleUrl />
	</cffunction>


	<cffunction name="getPreHandleUrl" access="private" returntype="string" output="false" >
		<cfreturn variables['properties']['preHandleUrl'] />
	</cffunction>


	<cffunction name="setPreHandleForm" access="public" returntype="void" output="false" >
		<cfargument name="preHandleForm" type="string" required="true" />
		<cfset variables['properties']['preHandleForm'] = arguments.preHandleForm />
	</cffunction>


	<cffunction name="getPreHandleForm" access="private" returntype="string" output="false" >
		<cfreturn variables['properties']['preHandleForm'] />
	</cffunction>


	<cffunction name="setPreHandleCgi" access="public" returntype="void" output="false" >
		<cfargument name="preHandleCgi" type="string" required="true" />
		<cfset variables['properties']['preHandleCgi'] = arguments.preHandleCgi />
	</cffunction>


	<cffunction name="getPreHandleCgi" access="private" returntype="string" output="false" >
		<cfreturn variables['properties']['preHandleCgi'] />
	</cffunction>


	<cffunction name="setPreHandleHttpRequestData" access="public" returntype="void" output="false" >
		<cfargument name="preHandleHttpRequestData" type="string" required="true" />
		<cfset variables['properties']['preHandleHttpRequestData'] = arguments.preHandleHttpRequestData />
	</cffunction>


	<cffunction name="getPreHandleHttpRequestData" access="private" returntype="string" output="false" >
		<cfreturn variables['properties']['preHandleHttpRequestData'] />
	</cffunction>


	<cffunction name="setPostHandleApplicationEvents" access="public" returntype="void" output="false" >
		<cfargument name="postHandleApplicationEvents" type="string" required="true" />
		<cfset variables['properties']['postHandleApplicationEvents'] = arguments.postHandleApplicationEvents />
	</cffunction>


	<cffunction name="getPostHandleApplicationEvents" access="private" returntype="string" output="false" >
		<cfreturn variables['properties']['postHandleApplicationEvents'] />
	</cffunction>


	<cffunction name="setPostHandleShowDebugOutput" access="public" returntype="void" output="false" >
		<cfargument name="postHandleShowDebugOutput" type="boolean" required="true" />
		<cfset variables['properties']['postHandleShowDebugOutput'] = arguments.postHandleShowDebugOutput />
	</cffunction>


	<cffunction name="getPostHandleShowDebugOutput" access="private" returntype="boolean" output="false" >
		<cfreturn variables['properties']['postHandleShowDebugOutput'] />
	</cffunction>


	<cffunction name="setPostHandleShowTrace" access="public" returntype="void" output="false" >
		<cfargument name="postHandleShowTrace" type="boolean" required="true" />
		<cfset variables['properties']['postHandleShowTrace'] = arguments.postHandleShowTrace />
	</cffunction>


	<cffunction name="getPostHandleShowTrace" access="private" returntype="boolean" output="false" >
		<cfreturn variables['properties']['postHandleShowTrace'] />
	</cffunction>


	<cffunction name="setPostHandleWriterResolution" access="public" returntype="void" output="false" >
		<cfargument name="postHandleWriterResolution" type="string" required="true" />
		<cfset variables['properties']['postHandleWriterResolution'] = arguments.postHandleWriterResolution />
	</cffunction>


	<cffunction name="getPostHandleWriterResolution" access="private" returntype="string" output="false" >
		<cfreturn variables['properties']['postHandleWriterResolution'] />
	</cffunction>


	<cffunction name="setPostHandleWriterLocation" access="public" returntype="void" output="false" >
		<cfargument name="postHandleWriterLocation" type="string" required="true" />
		<cfset variables['properties']['postHandleWriterLocation'] = arguments.postHandleWriterLocation />
	</cffunction>


	<cffunction name="getPostHandleWriterLocation" access="private" returntype="string" output="false" >
		<cfreturn variables['properties']['postHandleWriterLocation'] />
	</cffunction>


	<cffunction name="setPostHandleWriterMethod" access="public" returntype="void" output="false" >
		<cfargument name="postHandleWriterMethod" type="string" required="true" />
		<cfset variables['properties']['postHandleWriterMethod'] = arguments.postHandleWriterMethod />
	</cffunction>


	<cffunction name="getPostHandleWriterMethod" access="private" returntype="string" output="false" >
		<cfreturn variables['properties']['postHandleWriterMethod'] />
	</cffunction>


	<cffunction name="setTraceRenderer" access="public" output="false" returntype="void" >
		<cfargument name="traceRenderer" required="true" type="any" />
		<cfset variables['traceRenderer'] = arguments.traceRenderer />
	</cffunction>


	<cffunction name="getTraceRenderer" access="private" output="false" returntype="any" >
		<cfreturn variables['traceRenderer'] />
	</cffunction>


	<cffunction name="setShouldClearOutputBuffer" access="public" returntype="void" output="false" >
		<cfargument name="shouldClearOutputBuffer" type="boolean" required="true" />
		<cfset variables['properties']['shouldClearOutputBuffer'] = arguments.shouldClearOutputBuffer />
	</cffunction>


	<cffunction name="getShouldClearOutputBuffer" access="private" returntype="boolean" output="false" >
		<cfreturn variables['properties']['shouldClearOutputBuffer'] />
	</cffunction>


	<cffunction name="setShouldTrace" access="public" returntype="void" output="false" >
		<cfargument name="shouldTrace" type="boolean" required="true" />
		<cfset variables['properties']['shouldTrace'] = arguments.shouldTrace />
	</cffunction>


	<cffunction name="getShouldTrace" access="private" returntype="boolean" output="false" >
		<cfreturn variables['properties']['shouldTrace'] />
	</cffunction>


<!--- PRIVATE -------------------------------------------------------->

	<cffunction name="include" access="private" returntype="void" output="true">
		<cfargument name="response" type="struct" required="true" />
		<cfargument name="trace" type="string" required="false" default="" />
		<cfset var out = "" />
		<!--- arguments.response is found 'automagically' --->
		<cflock name="httpConnectorWriterLock" type="exclusive" timeout="0" >
			<cfif getShouldClearOutputBuffer() ><cfcontent reset="true"></cfif>
			<cfoutput><cfsavecontent variable="out"><cfinclude template="#getPostHandleWriterLocation()#" /></cfsavecontent></cfoutput>
			<cfset arguments.response['_output'] = out />
		</cflock>
	</cffunction>


	<cffunction name="module" access="private" returntype="void" output="true">
		<cfargument name="response" type="struct" required="true" />
		<cfargument name="trace" type="string" required="false" default="" />
		<cfset var out = "" />
		<cflock name="httpConnectorWriterLock" type="exclusive" timeout="0" >
			<cfif getShouldClearOutputBuffer() ><cfcontent reset="true"></cfif>
			<cfoutput><cfsavecontent variable="out"><cfmodule template="#getPostHandleWriterLocation()#" response="#arguments.response#" trace="#arguments.trace#" /></cfsavecontent></cfoutput>
			<cfset arguments.response['_output'] = out />
		</cflock>
	</cffunction>


	<cffunction name="component" access="private" returntype="void" output="true">
		<cfargument name="response" type="struct" required="true" />
		<cfargument name="trace" type="string" required="false" default="" />
		<cfset var out = "" />
		<cflock name="httpConnectorWriterLock" type="exclusive" timeout="0" >
			<cfif getShouldClearOutputBuffer() ><cfcontent reset="true"></cfif>
			<cfinvoke component="#getPostHandleWriterLocation()#" method="#getPostHandleWriterMethod()#" returnvariable="out">
				<cfinvokeargument name="response" value="#arguments.response#" />
				<cfinvokeargument name="trace" value="#arguments.trace#">
			</cfinvoke>
			<cfset arguments.response['_output'] = out />
		</cflock>
	</cffunction>


	<cffunction name="bean" access="private" returntype="void" output="true">
		<cfargument name="response" type="struct" required="true" />
		<cfargument name="trace" type="string" required="false" default="" />
		<cfset var b = getBeanFactory().getBean( getPostHandleWriterLocation() ) />
		<cfset var out = "" />
		<cflock name="httpConnectorWriterLock" type="exclusive" timeout="0" >
			<cfif getShouldClearOutputBuffer() ><cfcontent reset="true"></cfif>
			<cfinvoke component="#b#" method="#getPostHandleWriterMethod()#" returnvariable="out">
				<cfinvokeargument name="response" value="#arguments.response#" />
				<cfinvokeargument name="trace" value="#arguments.trace#">
			</cfinvoke>
			<cfset arguments.response['_output'] = out />
		</cflock>
	</cffunction>

</cfcomponent>