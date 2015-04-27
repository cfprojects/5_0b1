<cfcomponent displayname="HandlerAdapter" output="false">
<!---
based on Spring framework 1.2 org.springframework.web.servlet.HandlerAdapter interface

"MVC framework SPI interface, allowing parameterization of core MVC workflow."

"Interface that must be implemented for each handler type to handle a request. This interface is used to allow the DispatcherServlet to be indefinitely extensible. The DispatcherServlet accesses all installed handlers through this interface, meaning that it does not contain code specific to any handler type."

"Note that a handler can be of type Object. This is to enable handlers from other frameworks to be integrated with this framework without custom coding."

"This interface is not intended for application developers. It is available to handlers who want to develop their own web workflow."

"Note: Implementations can implement the Ordered interface to be able to specify a sorting order and thus a priority for getting applied by Dispatcher. Non-Ordered instances get treated as lowest priority."

This component is a concrete Gliint based Decorator that can also be used as a mixin.

<b>Since:</b>
April 27, 2009

<b>See Also:</b>
	<br/>&nbsp;
<hr/>
<table class="summaryTable" cellpadding="3" cellspacing="0">
	<tbody>
		<tr><th>&nbsp;</th><th colspan="3">Field Summary</th></tr>
		<tr class="">
			<td class="summaryTablePaddingCol">&nbsp;</td>
			<td class="summaryTablesigCol" nowrap="nowrap"><code>public order</code></td>
			<td class="summaryTableSignatureCol">
				<div class="summarySignature"><a href="nativetypes.cfm#detail_numeric">numeric</a></div>
				<div class="summaryTableDescription">The priority for getting applied, defaults to 0</div>
			</td>
		</tr>
		<tr class="">
			<td class="summaryTablePaddingCol">&nbsp;</td>
			<td class="summaryTablesigCol" nowrap="nowrap"><code>private handlingMethod</code></td>
			<td class="summaryTableSignatureCol">
				<div class="summarySignature"><a href="nativetypes.cfm#detail_string">string</a></div>
				<div class="summaryTableDescription">Method to be run on the handler, defaults to 'execute'</div>
			</td>
		</tr>
		<tr class="">
			<td class="summaryTablePaddingCol">&nbsp;</td>
			<td class="summaryTablesigCol" nowrap="nowrap"><code>private handler</code></td>
			<td class="summaryTableSignatureCol">
				<div class="summarySignature"><a href="nativetypes.cfm#detail_any">any</a></div>
				<div class="summaryTableDescription">Component to execute the handlingMethod.</div>
			</td>
		</tr>
	</tbody>
</table>
--->
<!---
org.gliint.framework.handler.HandlerAdapter

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
	<cfset variables['properties']['handler'] = false />
	<cfset variables['properties']['order'] = 0 />
	<cfset variables['properties']['handlingMethod'] = "execute" />


	<cffunction name="init" access="public" returntype="org.gliint.framework.HandlerAdapter" output="false">
		<cfreturn this />
	</cffunction>


	<cffunction name="handle" access="public" returntype="any" output="false">
		<cfargument name="request" type="any" required="true" />
		<cfargument name="response" type="any" required="true" />
		<cfargument name="handler" type="any" required="false" default="#getHandler()#">
		<cfargument name="handlingMethod" type="string" required="false" default="#getHandlingMethod()#">
		<cfset var ret = structNew() />
		<cfinvoke component="#arguments.handler#" method="#arguments.handlingMethod#" returnvariable="ret">
			<cfinvokeargument name="command" value="#arguments.request#" />
			<cfinvokeargument name="context" value="#arguments.response#" />
		</cfinvoke>
		<cfreturn ret />
	</cffunction>


	<cffunction name="setHandlingMethod" access="public" returntype="any" output="false">
		<cfargument name="handlingMethod" type="string" required="true" />
		<cfset variables['properties']['handlingMethod'] = arguments.handlingMethod />
		<cfreturn this />
	</cffunction>


	<cffunction name="getHandlingMethod" access="private" returntype="string" output="false">
		<cfreturn variables['properties']['handlingMethod'] />
	</cffunction>


	<cffunction name="setHandler" access="public" returntype="any" output="false">
		<cfargument name="handler" type="any" required="true" />
		<cfset variables['properties']['handler'] = arguments.handler />
		<cfreturn this />
	</cffunction>


	<cffunction name="getHandler" access="private" returntype="any" output="false">
		<cfreturn variables['properties']['handler'] />
	</cffunction>


	<cffunction name="setOrder" access="public" returntype="void" output="false">
		<cfargument name="order" type="numeric" required="true" />
		<cfset variables['properties']['order'] = arguments.order />
	</cffunction>


	<cffunction name="getOrder" access="public" returntype="numeric" output="false">
		<cfreturn variables['properties']['order'] />
	</cffunction>

</cfcomponent>