<cfcomponent displayname="BaseHandlerMapping" output="false">
<!---
Based on Spring framework 1.2 org.springframework.web.servlet Interface HandlerMapping

Base class must be implemented by objects that define a mapping between requests and handler objects.

"HandlerMapping implementations can support mapped interceptors but do not have to.
A handler will always be wrapped in a HandlerExecutionChain instance, optionally accompanied
by some HandlerInterceptor instances. The Dispatcher will first call each HandlerInterceptor's
preHandle method in the given order, finally invoking the handler itself if all preHandle
methods have returned true."

"The ability to parameterize this mapping is a powerful and unusual capability of this
MVC framework. For example, it is possible to write a custom mapping based on session state,
cookie state or many other variables. No other MVC framework seems to be equally flexible."

"Note: Implementations can implement the Ordered interface to be able to specify a sorting
order and thus a priority for getting applied by Dispatcher. Non-Ordered instances get
treated as lowest priority.""

Returns a HandlerExecutionChain for a request, based on any arbitrary factors
the implementing class chooses. Returns FALSE if no match is found. Also contains
the setOrder() and getOrder() methods so that the calling object can retrieve the
order from its set of handlerMappings and call them from low to high.

<b>Exposed configuration properties  (including those defined by superclass):</b>
<br/>
	<cfset variables['properties']['defaultHandler'] = false />
<table class="withBorder" cellpadding="3" cellspacing="">
	<tbody>
	<tr class="" style="bottom-border: 1px black solid;">
		<th><b>name</b></th>
		<th><b>default</b></th>
		<th><b>description</b></th>
	</tr>
	<tr>
		<td>order</td>
		<td>0</td>
		<td>the order value for this HandlerMapping bean</td>
	</tr>
	<tr>
		<td>defaultHandler</td>
		<td>false</td>
		<td>the default handler for this handler mapping</td>
	</tr>
	</tbody>
</table>

<b>Since:</b>

<b>See Also:</b>
	<br/>&nbsp;
--->
<!---
org.gliint.framework.handler.mapping.BaseHandlerMapping

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
	<cfset variables['properties']['order'] = 0 />
	<cfset variables['properties']['defaultHandler'] = false />


	<cffunction name="init" access="public" returntype="org.gliint.framework.handler.mapping.BaseHandlerMapping" output="false">
		<cfthrow message="Base CFC cannot be initialized" />
	</cffunction>


	<cffunction name="getHandler" access="public" returntype="any" output="false">

		<cfset var handlerExecutionChain = false />

		<!--- the mapping strategy is applied here in implementing classes --->
		<cfthrow type="Method.NotImplemented">

		<cfreturn handlerExecutionChain />
	</cffunction>


	<cffunction name="setOrder" access="public" returntype="void" output="false">
		<cfargument name="order" type="numeric" required="true" />
		<cfset variables['properties']['order'] = arguments.order />
	</cffunction>


	<cffunction name="getOrder" access="public" returntype="numeric" output="false">
		<cfreturn variables['properties']['order'] />
	</cffunction>


	<cffunction name="setDefaultHandler" access="public" returntype="void" output="false">
		<cfargument name="defaultHandler" type="any" required="true" />
		<cfset variables['properties']['defaultHandler'] = arguments.defaultHandler />
	</cffunction>


	<cffunction name="getDefaultHandler" access="public" returntype="any" output="false">
		<cfreturn variables['properties']['defaultHandler'] />
	</cffunction>

</cfcomponent>