<cfcomponent displayname="Dispatch" extends="org.gliint.framework.handler.BaseCommandHandler" output="false">
<!---
A Gliint commandHandler which performs dispatcher functions; similar to Spring's DispatcherServlet;

Uses a (single transient) CommandContext

Uses a (single permanent) BeanFactory.

"Publishes events on request processing, whether or not a request is successfully handled."

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
		<td>access</td>
		<td>public</td>
		<td>determines if it can be used as an event handler</td>
	</tr>
	<tr>
		<td>beanFactory</td>
		<td>false</td>
		<td>typically ColdSpring's DefaultXmlBeanFactory</td>
	</tr>
	<tr>
		<td>comment</td>
		<td>&nbsp;</td>
		<td>optional; a description of the functionality provided</td>
	</tr>
	<tr>
		<td>handlerMapping</td>
		<td>false</td>
		<td></td>
	</tr>
	<tr>
		<td>name</td>
		<td>#getMetaData( this ).name#</td>
		<td>the name of this commandHandler</td>
	</tr>
	<tr>
		<td>resultClass</td>
		<td>org.gliint.framework.util.Result</td>
		<td>dotted path notation to the component to be instantiated for Result objects</td>
	</tr>
	<tr>
		<td>shouldTrace</td>
		<td>false</td>
		<td>if true, when ColdFusion debugging is on traces will be written</td>
	</tr>
	</tbody>
</table>

<b>Since:</b>

<b>See Also:</b>
	<br/>&nbsp;
--->
<!---
org.gliint.framework.lexicon.Dispatch

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
	<cfset variables['properties']['access'] = "public" />
	<cfset variables['properties']['beanFactory'] = false />
	<cfset variables['properties']['comment'] = "" />
	<cfset variables['properties']['handlermapping'] = false />
	<cfset variables['properties']['name'] = "#getMetaData( this ).name#" />
	<cfset variables['properties']['resultClass'] = "org.gliint.framework.util.Result" />
	<cfset variables['properties']['shouldTrace'] = false />



	<cffunction name="init" access="public" returntype="org.gliint.framework.lexicon.Dispatch" output="false" >
		<cfreturn this />
	</cffunction>


	<cffunction name="execute" access="public" returntype="any" output="false">
		<cfargument name="command" type="any" required="true" />
		<cfargument name="context" type="any" required="true" />

		<cfset var result = newResult() />
		<cfset var i = 0 />
		<cfset var interceptors = arrayNew(1) />
		<cfset var size = 0 />
		<cfset var ret = true />
		<cfset var hec = false />

		<cfif getShouldTrace() >
			<cftrace type="information" text="org.gliint.framework.lexicon.Dispatch: Command #arguments.command.getName()# starts" />
		</cfif>

		<cftry>

			<!--- determine handler for the current command --->
			<cfset hec = getHandler( arguments.command ) />

			<!--- apply preHandle methods of registered interceptors. --->
			<cfset interceptors = hec.getInterceptors() />
			<cfset size = arrayLen( interceptors ) />
			<cfset i = 0 />
			<cfloop condition="i lt size" >
				<cfset i = i + 1 />
				<cfset ret = interceptors[i].preHandle( arguments.command, arguments.context, hec ) />
				<cfif ( not ret ) >
					<!--- the preHandle has returned FALSE, indicating that we should not continue --->
					<cfset triggerAfterCompletion( hec, i, arguments.command, arguments.context ) />
					<cfbreak />
				</cfif>
			</cfloop>
			<cfif ( not ret ) >
				<cfreturn />
			</cfif>

			<!--- actually invoke the handler. --->
			<cfinvoke component="#hec.getHandler()#" method="#hec.getHandler().getHandlingMethod()#" returnvariable="result">
				<cfinvokeargument name="command" value="#arguments.command#">
				<cfinvokeargument name="context" value="#arguments.context#">
			</cfinvoke>

			<!--- Apply postHandle methods of registered interceptors. --->
			<cfset interceptors = hec.getInterceptors() />
			<cfset size = arrayLen( interceptors ) />
			<cfset i = 0 />
			<cfloop condition="i lt size" >
				<cfset i = i + 1 />
				<cfset interceptors[i].postHandle( arguments.command, arguments.context, hec ) />
			</cfloop>

			<cfcatch type="any" >
				<cfset handleException( cfcatch, result, arguments.context ) />
			</cfcatch>
		</cftry>

		<cfif getShouldTrace() >
			<cftrace type="information" text="org.gliint.framework.lexicon.Dispatch: Command #arguments.command.getName()# completes" />
		</cfif>

		<cfreturn result />
	</cffunction>


	<cffunction name="setHandlerMapping" access="public" returntype="void" output="false">
		<cfargument name="handlerMapping" type="org.gliint.framework.handler.mapping.BaseHandlerMapping" required="true" />
		<cfset variables['properties']['handlerMapping'] = arguments.handlerMapping />
	</cffunction>


	<!--- PRIVATE -------------------------------------------------------------->

	<cffunction name="getHandler" access="private" returntype="org.gliint.framework.HandlerExecutionChain"
		hint="Return the HandlerExecutionChain for this request" output="false">
		<cfargument name="command" type="any" required="true" />
		<cfset var hm = getHandlerMapping() />
		<cfset var hec = hm.getHandler( arguments.command ) />
		<cfif ( isBoolean( hec ) and not hec ) >
			<cfthrow type="handlerMappingException" message="Bean #getHandler_mapping_bean_name()# couldn not map a handler" />
		</cfif>
		<cfreturn hec />
	</cffunction>


	<cffunction name="getHandlerMapping" access="private" returntype="any" output="false">
		<cfreturn variables['properties']['handlerMapping'] />
	</cffunction>


	<cffunction name="triggerAfterCompletion" access="private" returntype="void" output="false">
		<cfargument name="handler" _type="org.gliint.framework.HandlerExecutionChain" required="true" />
		<cfargument name="interceptorIndex" type="numeric" required="true" />
		<cfargument name="response" type="struct" required="true" />
		<cfargument name="ex" type="any" required="false" hint="Exception" />

		<!--- Apply afterCompletion methods of registered interceptors.
		N.B. we use the interceptorIndex to go backwards through the interceptors that have already
		been called, but NOT the one that triggered this method call
		this implies that the interceptor which triggered this method call should be smart enough
		to call it's own afterCompletion() method.
		--->

		<cfset var i = arguments.interceptorIndex />
		<cfset var interceptors = arguments.handler.getInterceptors() />

		<cfloop condition="i gte 2" >
			<cfset i = i - 1 />
			<cfif structKeyExists( arguments, 'ex' ) >
				<cfset interceptors[i].afterCompletion( arguments.request, arguments.response, hec, ex ) />
			<cfelse>
				<cfset interceptors[i].afterCompletion( arguments.request, arguments.response, hec ) />
			</cfif>
		</cfloop>

	</cffunction>

</cfcomponent>