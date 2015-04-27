<cfcomponent displayname="BaseHandlerInterceptor" output="false" >
<!---
Base class for Gliint Handler Interceptors; Must be subclassed.

Based on Spring framework 1.2 interface HandlerInterceptor:

"Intercept the execution of a handler. Called after HandlerMapping determined
an appropriate handler object, but before HandlerAdapter invokes the handler."
(Note: the use of concrete HandlerAdapters is optional with Gliint)

"DispatcherServlet processes a handler in an execution chain, consisting
of any number of interceptors, with the handler itself at the end.
With this method, each interceptor can decide to abort the execution chain,
typically sending a HTTP error or writing a custom response."

"Workflow interface that allows for customized handler execution chains.
Applications can register any number of existing or custom interceptors
for certain groups of handlers, to add common preprocessing behavior
without needing to modify each handler implementation."

"A HandlerInterceptor gets called before the appropriate HandlerAdapter
triggers the execution of the handler itself. This mechanism can be used
for a large field of preprocessing aspects, e.g. for authorization checks,
or common handler behavior like locale or theme changes. Its main purpose
is to allow for factoring out repetitive handler code."

"Typically an interceptor chain is defined per HandlerMapping bean,
sharing its granularity. To be able to apply a certain interceptor chain
to a group of handlers, one needs to map the desired handlers via one
HandlerMapping bean. The interceptors themselves are defined as beans in the
application context, referenced by the mapping bean definition via its
"interceptors" property (in XML: a <list> of <ref>)."

BaseHandlerInterceptors are optionally configurable via a 'config' property and
associated accessor and mutator methods and it is expected that subclassing
interceptors will utilize this feature.

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
org.gliint.framework.handler.BaseHandlerInterceptor

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
	<cfset variables['properties']['configuration'] = structNew() />


	<cffunction name="init" access="public" returntype="org.gliint.framework.handler.BaseHandlerInterceptor" >
		<cfreturn this />
	</cffunction>


	<cffunction name="preHandle" access="public" returntype="boolean" output="false">
		<cfargument name="request" type="any" required="true" />
		<cfargument name="response" type="any" required="true" />
		<cfargument name="handler" type="any" required="true" />

			<!--- override as needed --->

		<cfreturn true />
	</cffunction>


	<cffunction name="postHandle" access="public" returntype="void" output="false">
		<cfargument name="request" type="any" required="true" />
		<cfargument name="response" type="any" required="true" />
		<cfargument name="handler" type="any" required="true" />

			<!--- override as needed --->

	</cffunction>


	<cffunction name="afterCompletion" access="public" returntype="void" output="false">
		<cfargument name="request" type="any" required="true" />
		<cfargument name="response" type="any" required="true" />
		<cfargument name="handler" type="any" required="true" />
		<cfargument name="ex" type="any" required="false" hint="Exception" />

			<!--- override as needed --->

	</cffunction>


	<cffunction name="mixin" access="public" returntype="void" output="false">
		<cfargument name="name" required="true" type="string" />
		<cfargument name="func" required="true" type="any" />

		<cfset this[arguments.name] = arguments.func />
		<cfset variables[arguments.name] = arguments.func />

	</cffunction>


	<cffunction name="getProperties" access="public" returntype="struct" output="false">
		<cfreturn variables['properties'] />
	</cffunction>


	<cffunction name="setConfiguration" access="public" returntype="void" output="false">
		<cfargument name="configuration" type="any" required="true" />
		<cfset variables['properties']['configuration'] = arguments.configuration />
	</cffunction>


	<cffunction name="getConfiguration" access="public" returntype="any" output="false">
		<cfreturn variables['properties']['configuration'] />
	</cffunction>

</cfcomponent>