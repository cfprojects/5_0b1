<cfcomponent displayname="ResponseInterceptor" extends="org.gliint.framework.handler.BaseHandlerInterceptor" output="false" >
<!---
Filled with configuration data typically from the coldspring xml, it can then be
added to a HandlerExecutionChain to influence the processing of a CommandHandler.

Based on configuration, will create arbitrary simple variables, structures (maps),
arrays, beans and place them in the Context's responses structure.

Delegates to it's beaner to create beans.

Delegates to it's valueParser to copy values from responses, scopes, and beans.

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
		<td>beaner</td>
		<td>false</td>
		<td>creates beans based on configuration values</td>
	</tr>
	<tr>
		<td>configuration</td>
		<td>#structNew()#</td>
		<td>must contain preHandle and postHandle keys whose value is a one dimensional array</td>
	</tr>
	<tr>
		<td>shouldTrace</td>
		<td>false</td>
		<td>if true, when ColdFusion debugging is on traces will be written</td>
	</tr>
	<tr>
		<td>valueParser</td>
		<td>false</td>
		<td>creates response values from responses, scopes, and beans </td>
	</tr>
	</tbody>
</table>

<b>Since:</b>

<b>See Also:</b>
	<br/>&nbsp;
--->
<!---
org.gliint.framework.handler.ResponseInterceptor

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
	<cfset variables['properties']['beaner'] = false />
	<cfset variables['properties']['configuration'] = structNew() />
	<cfset variables['properties']['configuration']['preHandle'] = arrayNew(1) />
	<cfset variables['properties']['configuration']['postHandle'] = arrayNew(1) />
	<cfset variables['properties']['shouldTrace'] = false />
	<cfset variables['properties']['valueParser'] = false />


	<cffunction name="preHandle" access="public" returntype="boolean" output="false">
		<cfargument name="command" type="org.gliint.framework.command.Command" required="true" />
		<cfargument name="context" type="org.gliint.framework.command.CommandContext" required="true" />
		<cfargument name="handler" type="any" required="false" hint="the handler execution chain currently being processed" />
		<cfset applyResponses( arguments.command, arguments.context, 'preHandle' ) />
		<cfreturn true />
	</cffunction>


	<cffunction name="postHandle" access="public" returntype="void" output="false">
		<cfargument name="command" type="org.gliint.framework.command.Command" required="true" />
		<cfargument name="context" type="org.gliint.framework.command.CommandContext" required="true" />
		<cfargument name="handler" type="any" required="false" hint="the handler execution chain currently being processed" />
		<cfset applyResponses( arguments.command, arguments.context, 'postHandle' ) />
	</cffunction>


	<cffunction name="applyResponses" access="private" returntype="void" output="false">
		<cfargument name="command" type="any" required="true" />
		<cfargument name="context" type="any" required="true" />
		<cfargument name="method" type="string" required="true" />

		<cfset var cmd = arguments.command />
		<cfset var cxt = arguments.context />
		<cfset var conf = getConfiguration() />
		<cfset var r = cxt.getResponses() />
		<cfset var i = 0 />
		<cfset var fc = structNew() />
		<cfset var f = "" />
		<cfset var x = "" />
		<cfset var args = structNew() />
		<cfset var t = "" />
		<cfset var sz = 0 />
		<cfset var d = arrayNew(1) />

		<cfif ( not structKeyExists( conf, arguments.method) ) >
			<cfreturn />
		</cfif>
		<cfset d = conf[arguments.method] />

		<cfif ( not isArray(d) ) >
			<cfreturn />
		</cfif>
		<cfset sz = arrayLen( d ) />

		<cfif ( sz eq 0 ) >
			<cfreturn />
		</cfif>

		<cfloop condition="i lt sz" >
			<cfset i = i + 1 />

			<!--- current d: (a single response)
				d[i] = structNew()
				d[i]['name']
				d[i]['value']
				d[i]['class']
				d[i]['factoryBean']
				d[i]['factoryMethod']
				d[i]['fields']
				d[i]['method']
				d[i]['args']
			--->
			<cfparam name="d[i]['name']" default="" />
			<cfparam name="d[i]['value']" default="" />
			<cfparam name="d[i]['class']" default="" />
			<cfparam name="d[i]['factory-bean']" default="" />
			<cfparam name="d[i]['factory-method']" default="" />
			<cfparam name="d[i]['fields']" default="" />
			<cfparam name="d[i]['method']" default="" />
			<cfparam name="d[i]['args']" default="#structNew()#" />

			<!--- 't', for type: value, class, & factory-bean are mutually exclusive --->
			<cfset t = "value" />
			<cfif ( len( d[i]['class'] ) gt 0 ) >
				<cfset t = "class" />
			</cfif>
			<cfif ( len( d[i]['factory-bean'] ) gt 0 ) >
				<cfset t = "factory" />
			</cfif>

			<!--- create field collection --->
			<cfif ( len( d[i]['fields'] ) gt 0 ) >
				<cfif ( d[i]['fields'] eq '*' ) >
					<cfset fc = r />
				<cfelse>
					<cfloop list="#d[i]['fields']#" index="f" >
						<cfif structKeyExists( r, f ) >
							<cfset fc[f] = r[f] />
						</cfif>
					</cfloop>
				</cfif>
			</cfif>

			<!--- create method args --->
			<cfif ( structCount( d[i]['args'] ) gt 0 ) >
				<cfloop collection="#d[i]['args']#" item="f" >
					<cfset args[f] = getValueParser().parseValue( d[i]['args'][f], r ) />
				</cfloop>
			</cfif>

			<!--- resolve response references --->
			<cfswitch expression="#t#">

				<cfcase value="class" >
					<cfset x = getBeaner().getBeanByClass( d[i]['class'], fc, d[i]['method'], args ) />
				</cfcase>

				<cfcase value="factory" >
					<cfset x = getBeaner().getBeanByFactory( d[i]['factory-bean'], d[i]['factory-method'], fc, d[i]['method'], args ) />
				</cfcase>

				<!--- default is "value", which defaults to a zero length string --->
				<cfdefaultcase>
					<cfset x = getValueParser().parseValue( d[i]['value'], r ) />
				</cfdefaultcase>

			</cfswitch>

			<cfif getShouldTrace() >
				<cfif ( structKeyExists( r, d[i]['name'] ) ) >
					<cfif ( isSimpleValue( x ) ) >
						<cftrace type="warning" text="ResponseInterceptor: Overwriting existing #t# response #d[i]['name']#: [#x#]" />
					<cfelse>
						<cftrace type="warning" text="ResponseInterceptor: Overwriting existing #t# response #d[i]['name']#: (complex value)" />
					</cfif>
				<cfelse>
					<cfif ( isSimpleValue( x ) ) >
						<cftrace type="information" text="ResponseInterceptor: Created #t# response #d[i]['name']#: [#x#]" />
					<cfelse>
						<cftrace type="information" text="ResponseInterceptor: Created #t# response #d[i]['name']#: (complex value)" />
					</cfif>
				</cfif>
			</cfif>

			<cfset cxt.setResponse( d[i]['name'], x ) />

		</cfloop>
	</cffunction>


	<cffunction name="getBeaner" access="private" returntype="any" output="false">
		<cfreturn variables['properties']['beaner'] />
	</cffunction>


	<cffunction name="setBeaner" access="public" returntype="void" output="false">
		<cfargument name="beaner" type="any" required="true" />
		<cfset variables['properties']['beaner'] = arguments.beaner />
	</cffunction>


	<cffunction name="getValueParser" access="private" returntype="any" output="false">
		<cfreturn variables['properties']['valueParser'] />
	</cffunction>


	<cffunction name="setValueParser" access="public" returntype="void" output="false">
		<cfargument name="valueParser" type="any" required="true" />
		<cfset variables['properties']['valueParser'] = arguments.valueParser />
	</cffunction>


	<cffunction name="setShouldTrace" access="public" returntype="void" output="false">
		<cfargument name="shouldTrace" type="boolean" required="true" />
		<cfset variables['properties']['shouldTrace'] = arguments.shouldTrace />
	</cffunction>


	<cffunction name="getShouldTrace" access="public" returntype="any" output="false">
		<cfreturn variables['properties']['shouldTrace'] />
	</cffunction>

</cfcomponent>