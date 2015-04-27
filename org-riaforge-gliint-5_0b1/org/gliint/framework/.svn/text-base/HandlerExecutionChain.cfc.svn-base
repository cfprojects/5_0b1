<cfcomponent displayname="HandlerExecutionChain" output="false" >
<!---
based on Spring framework 1.2 org.springframework.web.servlet.HandlerExecutionChain

Handler execution chain, consisting of handler object and any
preprocessing interceptors. Returned by HandlerMapping's getHandler method.

<b>Since:</b>

<b>See Also:</b>
	<br/>&nbsp;
<hr/>
<table class="summaryTable" cellpadding="3" cellspacing="0">
	<tbody>
		<tr><th>&nbsp;</th><th colspan="3">Field Summary</th></tr>
		<tr class="">
			<td class="summaryTablePaddingCol">&nbsp;</td>
			<td class="summaryTablesigCol" nowrap="nowrap"><code>private handler</code></td>
			<td class="summaryTableSignatureCol">
				<div class="summarySignature"><a href="nativetypes.cfm#detail_any">any</a></div>
				<div class="summaryTableDescription">Object that handles a request or command</div>
		</td>
	</tr>
		<tr class="">
			<td class="summaryTablePaddingCol">&nbsp;</td>
			<td class="summaryTablesigCol" nowrap="nowrap"><code>private interceptors</code></td>
			<td class="summaryTableSignatureCol">
				<div class="summarySignature"><a href="nativetypes.cfm#detail_array">array</a></div>
				<div class="summaryTableDescription">A array of handler interceptors to modify processing</div>
		</td>
	</tr>
	</tbody>
</table>
--->
<!---
org.gliint.framework.handler.HandlerExecutionChain

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
	<cfset variables['instance'] = structNew() />
	<cfset variables['instance']['handler'] = false />
	<cfset variables['instance']['interceptors'] = arrayNew(1) />

	<cffunction name="init" access="public" returntype="org.gliint.framework.HandlerExecutionChain" output="false">
		<cfargument name="handler" type="any" required="true" />
		<cfargument name="interceptors" type="array" required="false" />

		<cfset variables['instance']['handler'] = arguments.handler />

		<cfif ( structKeyExists( arguments, 'interceptors' ) ) >
			<cfset variables['instance']['interceptors'] = arguments.interceptors />
		</cfif>

		<cfreturn this />
	</cffunction>


	<cffunction name="addInterceptor" access="public" returntype="void" output="false">
		<cfargument name="interceptor" type="any" required="true" hint="The order of the interceptors may matter, depending on your implementation. This method does something stack-like. If you don't want that, extend this component or use addInterceptors() below." />
		<cfset arrayPrepend( variables['instance']['interceptors'], arguments.interceptor ) />
	</cffunction>


	<cffunction name="addInterceptors" access="public" returntype="void" output="false">
		<cfargument name="interceptors" type="array" required="true" hint="Preserves the order of interceptors. (You probably wanted it that way anyhow)" />
		<cfset var i = 0 />
		<cfloop condition="i lt arrayLen( arguments.interceptors )" >
			<cfset i = i + 1 />
			<cfset arrayAppend( variables['instance']['interceptors'], arguments.interceptors[i] ) />
		</cfloop>
	</cffunction>


	<cffunction name="getHandler" access="public" returntype="any" output="false">
		<cfreturn variables['instance']['handler'] />
	</cffunction>


	<cffunction name="getInterceptors" access="public" returntype="array" output="false">
		<cfreturn variables['instance']['interceptors'] />
	</cffunction>

</cfcomponent>