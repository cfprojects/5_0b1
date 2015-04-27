<cfcomponent displayname="Dispatcher" extends="org.gliint.framework.context.util.ApplicationContextUtils" output="false" >
<!---
Provides application event dispatching and request handling, typically extended by Application.cfc.
As such the onError() method of Application.cfc is expected to handle uncaught exceptions, and
an init() constructor for this component is NOT provided.

When the Dispatcher has received a request it tries to resolve a controller
using a HandlerMapping, which returns a HandlerExecutionChain which encapsulates
the resolved controller and zero or more Interceptors. The Gliint framework provides the GliintController
 (org.gliint.framework.GliintController) for this purpose; authors wishing to augment the framework
may create their own controllers or interceptors and could also write a HandlerMapping and wire it in.

From Spring framework 1.2:

"Central dispatcher for HTTP request handlers/controllers, e.g. for web UI controllers
or HTTP-based remote service exporters. Dispatches to registered handlers for processing a web request,
providing convenient mapping and exception handling facilities."

"Uses a (single, persistent) WebApplicationContext to access a BeanFactory.
The servlet's configuration is determined by beans in the servlet's namespace.
Publishes events on request processing, whether or not a request is successfully handled."

"Note: In case of multiple config locations, later bean definitions will override ones defined
in earlier loaded files, at least when using one of Spring's default ApplicationContext implementations.
This can be leveraged to deliberately override certain bean definitions via an extra XML file."


<b>Exposed configuration properties  (including those defined by superclass):</b>
<br/>none.

<b>Since:</b>

<b>See Also:</b>
	<br/>org.gliint.framework.handler.mapping.BaseHandlerMapping, org.gliint.framework.GliintController
<hr/>
<table class="summaryTable" cellpadding="3" cellspacing="0">
	<tbody>
		<tr><th>&nbsp;</th><th colspan="3">Field Summary</th></tr>
		<tr class="">
			<td class="summaryTablePaddingCol">&nbsp;</td>
			<td class="summaryTablesigCol" nowrap="nowrap"><code>public contextClass</code></td>
			<td class="summaryTableSignatureCol">
				<div class="summarySignature"><a href="nativetypes.cfm#detail_string">string</a></div>
				<div class="summaryTableDescription">dotted path notation to the component to be used as a WebApplicationContext</div>
			</td>
		</tr>
		<tr class="">
			<td class="summaryTablePaddingCol">&nbsp;</td>
			<td class="summaryTablesigCol" nowrap="nowrap"><code>public contextConfigLocation</code></td>
			<td class="summaryTableSignatureCol">
				<div class="summarySignature"><a href="nativetypes.cfm#detail_string">string</a></div>
				<div class="summaryTableDescription">a comma delimited list of configuration file locations</div>
			</td>
		</tr>
		<tr class="">
			<td class="summaryTablePaddingCol">&nbsp;</td>
			<td class="summaryTablesigCol" nowrap="nowrap"><code>public contextScope</code></td>
			<td class="summaryTableSignatureCol">
				<div class="summarySignature"><a href="nativetypes.cfm#detail_string">string</a></div>
				<div class="summaryTableDescription">ColdFusion scope which will hold the instantiated WebApplicationClass</div>
			</td>
		</tr>
		<tr class="">
			<td class="summaryTablePaddingCol">&nbsp;</td>
			<td class="summaryTablesigCol" nowrap="nowrap"><code>public handler_mapping_bean_name</code></td>
			<td class="summaryTableSignatureCol">
				<div class="summarySignature"><a href="nativetypes.cfm#detail_string">string</a></div>
				<div class="summaryTableDescription">name of bean to be used for Handler mapping</div>
			</td>
		</tr>
		<tr class="">
			<td class="summaryTablePaddingCol">&nbsp;</td>
			<td class="summaryTablesigCol" nowrap="nowrap"><code>public allowRefresh</code></td>
			<td class="summaryTableSignatureCol">
				<div class="summarySignature"><a href="nativetypes.cfm#detail_boolean">boolean</a></div>
				<div class="summaryTableDescription">flag to determine if autorefresh check is performed</div>
			</td>
		</tr>
		<tr class="">
			<td class="summaryTablePaddingCol">&nbsp;</td>
			<td class="summaryTablesigCol" nowrap="nowrap"><code>public refresh_checking_bean_name</code></td>
			<td class="summaryTableSignatureCol">
				<div class="summarySignature"><a href="nativetypes.cfm#detail_string">string</a></div>
				<div class="summaryTableDescription">name of bean to be used for autorefresh</div>
			</td>
		</tr>
		<tr class="">
			<td class="summaryTablePaddingCol">&nbsp;</td>
			<td class="summaryTablesigCol" nowrap="nowrap"><code>private responses</code></td>
			<td class="summaryTableSignatureCol">
				<div class="summarySignature"><a href="nativetypes.cfm#detail_struct">struct</a></div>
				<div class="summaryTableDescription">ColdFusion structure required to retain responses from applicationEvent to applicationEvent</div>
			</td>
		</tr>
	</tbody>
</table>
--->
<!---
	org.gliint.framework.Dispatcher

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

	<cfset this['name'] = "someApplicationName" />

	<cfset this['contextClass'] = "org.gliint.framework.context.DefaultWebApplicationContext" />

	<cfset this['contextConfigLocation'] = "/config/coldspring.xml" />

	<cfset this['contextScope'] = "application" />

	<cfset this['handler_mapping_bean_name'] = "simpleHandlerMapping" />

	<cfset this['allowRefresh'] = true />
	<cfset this['refresh_checking_bean_name'] = "refresher" />

	<cfset variables['responses'] = structNew() />

	<!-------------------------------------------------------------------------->


	<!--- follows class org.springframework.web.servlet.DispatcherServlet, more or less --->
	<cffunction name="doDispatch" access="public" returntype="void" output="false"
		hint="Process the actual dispatching to the handler.">
		<cfargument name="request" type="string" required="true" hint="the name of the application event" />
		<cfargument name="response" type="struct" required="false" default="#variables['responses']#" />

		<cfset var i = 0 />
		<cfset var interceptors = arrayNew(1) />
		<cfset var size = 0 />
		<cfset var ret = true />
		<cfset var hec = false />
		<cfset var wac = false />

		<cftrace type="information" text="Dispatcher: doDispatch(#arguments.request#) starts" />

		<!--- determine handler for the current request --->
		<cftry>
			<cfset hec = getHandler( arguments.request ) />

			<cfif ( ( not isObject( hec ) ) or ( not isObject( hec.getHandler() ) ) ) >
				<cfthrow message="Mapped HandlerExecutionChain is NOT an object. Dispatch aborted." >
			</cfif>

			<cfcatch type="any">
				<cftrace type="error" text="#cfcatch.message#" />
				<cfset arguments.response['_exception'] = cfcatch.message />
				<cfreturn />
			</cfcatch>
		</cftry>

		<!--- apply preHandle methods of registered interceptors. --->
		<cfset interceptors = hec.getInterceptors() />
		<cfset size = arrayLen( interceptors ) />
		<cfset i = 0 />
		<cfloop condition="i lt size" >
			<cfset i = i + 1 />
			<cfset ret = interceptors[i].preHandle( arguments.request, arguments.response, hec ) />
			<cfif ( not ret ) >
				<!--- the preHandle has returned FALSE, indicating that we should not continue --->
				<cfset triggerAfterCompletion( hec, i, arguments.request, arguments.response ) />
				<cfbreak />
			</cfif>
			<!--- we will not recalculate the size variable here to determine if the current interceptor
				has added another interceptor to the hec, since doing so would also introduce the possiblilty
				of a never ending loop. Besides, spring doesn't do it, either.
			--->
		</cfloop>
		<cfif ( not ret ) >
			<cfreturn />
		</cfif>

		<!--- actually invoke the handler. With Gliint, arguments.response takes the place of ModelAndView. --->
		<cfset arguments.response = hec.getHandler().handle( arguments.request, arguments.response, hec ) />

		<!--- Apply postHandle methods of registered interceptors.
			we'll do as in version 3, processing in backwards order, so the last interceptor that processes is
			the first processed when we applied the preHandle() methods. This also means that any interceptors
			that were added by the handler invocation will be processed first.
		--->
		<cfset interceptors = hec.getInterceptors() />
		<cfset i = arrayLen( interceptors ) />
		<cfloop condition="i gt 0" >
			<cfset interceptors[i].postHandle( arguments.request, arguments.response, hec ) />
			<cfset i = i - 1 />
		</cfloop>
		<cftrace type="information" text="Dispatcher: doDispatch(#arguments.request#) completes" />
	</cffunction>


	<cffunction name="render" access="public" returntype="void" output="true" >
		<cfargument name="response" type="struct" required="false" default="#variables['responses']#" />
		<cfparam name="arguments.response['_output']" default="" />
		<cfoutput>#arguments.response['_output']#</cfoutput>
	</cffunction>


	<cffunction name="getHandler" access="public" returntype="any" output="false" hint="Return the HandlerExecutionChain for this request">
		<cfargument name="request" type="string" required="true" />
		<cfset var hec = getHandlerMapping().getHandler( arguments.request ) />
		<cfif ( isBoolean( hec ) and not hec ) >
			<cfthrow type="handlerMappingException" message="Bean #this['handler_mapping_bean_name']# could not map a handler" />
		</cfif>
		<cfreturn hec />
	</cffunction>


	<!--- from class org.springframework.web.servlet.FrameworkServlet --->
	<cffunction name="createWebApplicationContext" access="public" returntype="org.gliint.framework.context.DefaultWebApplicationContext" output="false"
		hint="Instantiate the WebApplicationContext for this servlet, either a default XmlWebApplicationContext or a custom context class if set.">
		<cfargument name="parent" type="org.gliint.framework.context.DefaultWebApplicationContext" required="false" />

		<cfset var cl = createObject( 'component', 'org.gliint.framework.context.ContextLoader' ) />
		<cfset var wac = false />

		<cftrace type="information" text="Dispatcher: creating WebApplicationContext for contextScope [#this['contextScope']#], named [#this['name']#]" />

		<cfif ( structKeyExists( arguments, 'parent' ) )>
			<cfset cl.init( getContextClass(), getContextConfigLocation(), arguments.parent ) />
		<cfelse>
			<cfset cl.init( getContextClass(), getContextConfigLocation() ) />
		</cfif>
		<cfset wac = cl.createWebApplicationContext( this['contextScope'], this['name'] ) />
		<cfset wac.refresh() />

		<cfreturn wac />
	</cffunction>


	<cffunction name="setContextClass" access="public" returntype="void" output="false">
		<cfargument name="contextClass" type="string" required="true" />
		<cfset this['contextClass'] = arguments.contextClass />
	</cffunction>


	<cffunction name="getContextClass" access="public" returntype="string" output="false"
		hint="Return the explicit context class path">
		<cfreturn this['contextClass'] />
	</cffunction>


	<cffunction name="setContextConfigLocation" access="public" returntype="void" output="false">
		<cfargument name="contextConfigLocation" type="string" required="true" />
		<cfset this['contextConfigLocation'] = arguments.contextConfigLocation />
	</cffunction>


	<cffunction name="getContextConfigLocation" access="public" returntype="string" output="false"
		hint="Return the explicit context config location, if any">
		<cfreturn this['contextConfigLocation'] />
	</cffunction>


	<!---
	although typically this Dispatcher component is extended by Application.cfc,
	the getResponses() method below allows it to be used in a more freestanding manner.
	--->
	<cffunction name="getResponses" access="public" returntype="struct" output="false">
		<cfreturn variables['responses'] />
	</cffunction>

	<!--- PRIVATE -------------------------------------------------------------->

	<cffunction name="getHandlerMapping" access="private" returntype="org.gliint.framework.handler.mapping.BaseHandlerMapping" output="false">
		<!--- keeping it simple, but you can extend for fun --->
		<cfreturn getNamedApplicationContext( this['contextScope'], this['name'] ).getBean( this['handler_mapping_bean_name'] ) />
	</cffunction>


	<cffunction name="triggerAfterCompletion" access="private" returntype="void" output="false" >
		<cfargument name="handler" type="org.gliint.framework.HandlerExecutionChain" required="true" />
		<cfargument name="interceptorIndex" type="numeric" required="true" />
		<cfargument name="request" type="string" required="true" />
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


	<cffunction name="shouldRefresh" access="private" returntype="boolean" output="false">

		<cfset var b = false />
		<cfset var checker = false />
		<cfset var text = "" />

		<!--- are we allowed? --->
		<cfif ( not this['allowRefresh'] ) >
			<cftrace type="information" text="Dispatcher: no refresh allowed">
			<cfreturn false />
		</cfif>

		<!--- only the persistent scopes apply --->
		<cfif ( listFindNoCase( 'application,server,session', this['contextScope'] ) eq 0 ) >
			<cftrace type="information" text="Dispatcher: no refresh for scope #this['contextScope']#">
			<cfreturn false />
		</cfif>

		<!--- refresh checking bean must be named --->
		<cfif ( len( this['refresh_checking_bean_name'] ) eq 0 ) >
			<cftrace type="warning" text="Dispatcher: no refresh: this['refresh_checking_bean_name'] is empty">
			<cfreturn false />
		</cfif>

		<cftry>
			<cfset checker = getNamedApplicationContext( this['contextScope'], this['name'] ).getBean( this['refresh_checking_bean_name'] ) />
			<cfif isObject( checker) >
				<cfset b = checker.shouldRefresh( this['contextConfigLocation'] ) />
			</cfif>

			<cfcatch type="any">
				<cfset text = "Dispatcher: for shouldRefresh()," />
				<cfif ( len( cfcatch.message ) gt 0 ) >
					<cfset text = text & ' ' & cfcatch.message />
				</cfif>
				<cfif ( len( cfcatch.detail ) gt 0 ) >
					<cfset text = text & ' ' & cfcatch.detail />
				</cfif>
				<cftrace type="error" text="#text#" />
				<cfset arguments.response['_exception'] = text />
				<cfreturn false />
			</cfcatch>
		</cftry>

		<cfreturn b />
	</cffunction>

</cfcomponent>