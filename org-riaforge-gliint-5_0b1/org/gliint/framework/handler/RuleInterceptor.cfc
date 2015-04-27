<cfcomponent displayname="RuleInterceptor" extends="org.gliint.framework.handler.BaseHandlerInterceptor" output="false" >
<!---
Filled with configuration data typically from the coldspring xml, it can then be
added to a HandlerExecutionChain to influence the processing of a CommandHandler.

Based on configuration, will process rules upon the CommandContext's response structure,
placing new commands into the CommandContext for further processing.

Complex processing, or that specific to a particular CommandHandler should be performed either
by the CommandHandler itself or a preprocessing CommandHandler.

<b>Exposed configuration properties	(including those defined by superclass):</b>
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
		<td>must contain preHandle and postHandle keys whose value is a one dimensional array</td>
	</tr>
	<tr>
		<td>shouldTrace</td>
		<td>false</td>
		<td>if true, when ColdFusion debugging is on traces will be written</td>
	</tr>
	</tbody>
</table>

<b>Since:</b>
April 25, 2009

<b>See Also:</b>
	<br/>&nbsp;
--->
<!---
org.gliint.framework.handler.RuleInterceptor

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
	<cfset variables['properties']['configuration']['preHandle'] = arrayNew(1) />
	<cfset variables['properties']['configuration']['postHandle'] = arrayNew(1) />
	<cfset variables['properties']['shouldTrace'] = false />



	<cffunction name="preHandle" access="public" returntype="boolean" output="false">
		<cfargument name="command" type="org.gliint.framework.command.Command" required="true" />
		<cfargument name="context" type="org.gliint.framework.command.CommandContext" required="true" />
		<cfargument name="handler" type="any" required="false" hint="the handler execution chain currently being processed" />
		<cfreturn applyRules( arguments.command, arguments.context, 'preHandle' ) />
	</cffunction>


	<cffunction name="postHandle" access="public" returntype="void" output="false">
		<cfargument name="command" type="org.gliint.framework.command.Command" required="true" />
		<cfargument name="context" type="org.gliint.framework.command.CommandContext" required="true" />
		<cfargument name="handler" type="any" required="false" hint="the handler execution chain currently being processed" />
		<cfset applyRules( arguments.command, arguments.context, 'postHandle' ) />
	</cffunction>


	<cffunction name="applyRules" access="private" returntype="boolean" output="false">
		<cfargument name="command" type="any" required="true" />
		<cfargument name="context" type="any" required="true" />
		<cfargument name="method" type="string" required="true" />

		<cfset var cmd = arguments.command />
		<cfset var cxt = arguments.context />
		<cfset var conf = getConfiguration() />
		<cfset var r = cxt.getResponses() />
		<cfset var rule = structNew() />
		<cfset var i = 0 />
		<cfset var newCommand = "" />
		<cfset var d = arrayNew(1) />
		<cfset var size = 0 />

		<cfif ( not structKeyExists( conf, arguments.method ) ) >
			<cfreturn true />
		</cfif>
		<cfset d = conf[arguments.method] />

		<cfif ( not isArray(d) ) >
			<cfif getShouldTrace() >
				<cftrace type="warning" text="RuleInterceptor: configuration data is invalid for method #arguments.method# for command #arguments.command.getName()#" />
			</cfif>
			<cfreturn true />
		</cfif>

		<cfif getShouldTrace() >
			<cftrace type="information" text="RuleInterceptor: for method #arguments.method#, command #arguments.command.getName()#, rule application starts" />
		</cfif>

		<cfset rule = processRules( d, cxt ) />

		<cfif ( not isStruct(rule) ) >
			<cfif getShouldTrace() >
				<cftrace type="information" text="RuleInterceptor: no rules qualified for command #arguments.command.getName()#  during method #arguments.method#" />
				<cftrace type="information" text="RuleInterceptor: for method #arguments.method#, command #arguments.command.getName()#, rule application completes" />
			</cfif>
			<cfreturn true />
		</cfif>

		<cfswitch expression="#lCase( rule['onMatch'] )#" >

				<cfcase value="do" >
					<cfif structKeyExists( rule, 'responses' ) >
						<cfset size = arrayLen( rule['responses'] />
						<cfif ( size gt 0 )>
							<cfloop from="1" to="#size#" index="i" >
								<cfif getShouldTrace() >
									<cftrace  type="information" text="RuleInterceptor: DO response #rule['responses'][i]['name']#" />
								</cfif>
								<cfset cxt.setResponse( rule['responses'][i]['name'], rule['responses'][i]['value'] ) />
							</cfloop>
						</cfif>
					</cfif>
					<cfif structKeyExists( rule, 'commands' ) >
						<cfset size = arrayLen( rule['commands'] />
						<cfloop from="1" to="#size#" index="i" >
							<cfif getShouldTrace() >
								<cftrace  type="information" text="RuleInterceptor: DO command #rule['commands'][i]['name']#" />
							</cfif>
							<cfset cxt.do( cxt.newCommand( rule['commands'][i]['name'], rule['commands'][i]['bind'], rule['commands'][i]['args'] )  ) />
						</cfloop>
					</cfif>
					<cfif getShouldTrace() >
						<cftrace  type="information" text="RuleInterceptor: DO completes" />
					</cfif>
				</cfcase>

				<cfcase value="halt" >
					<cfif structKeyExists( rule, 'responses' ) >
						<cfset size = arrayLen( rule['responses'] />
						<cfif ( size gt 0 )>
							<cfloop from="1" to="#size#" index="i" >
								<cfif getShouldTrace() >
									<cftrace  type="information" text="RuleInterceptor: HALT response #rule['responses'][i]['name']#" />
								</cfif>
								<cfset cxt.setResponse( rule['responses'][i]['name'], rule['responses'][i]['value'] ) />
							</cfloop>
						</cfif>
					</cfif>
					<cfset cxt.clear() />
					<cfif getShouldTrace() >
						<cftrace  type="information" text="RuleInterceptor: HALT completes" />
					</cfif>
				</cfcase>

				<cfcase value="clear" >
					<cfif structKeyExists( rule, 'responses' ) >
						<cfset size = arrayLen( rule['responses'] />
						<cfif ( size gt 0 )>
							<cfloop from="1" to="#size#" index="i" >
								<cfif getShouldTrace() >
									<cftrace  type="information" text="RuleInterceptor: CLEAR response #rule['responses'][i]['name']#" />
								</cfif>
								<cfset cxt.setResponse( rule['responses'][i]['name'], rule['responses'][i]['value'] ) />
							</cfloop>
						</cfif>
					</cfif>
					<cfset cxt.clear() />
					<cfif getShouldTrace() >
						<cftrace  type="information" text="RuleInterceptor: CLEAR completes" />
					</cfif>
				</cfcase>

				<!--- we don't need clearthenenstack since it does the same as below --->
				<cfcase value="clearthenenqueue" >
					<cfif structKeyExists( rule, 'responses' ) >
						<cfset size = arrayLen( rule['responses'] />
						<cfif ( size gt 0 )>
							<cfloop from="1" to="#size#" index="i" >
								<cfif getShouldTrace() >
									<cftrace  type="information" text="RuleInterceptor: CLEARTHENENQUEUE response #rule['responses'][i]['name']#" />
								</cfif>
								<cfset cxt.setResponse( rule['responses'][i]['name'], rule['responses'][i]['value'] ) />
							</cfloop>
						</cfif>
					</cfif>
					<cfset cxt.clear() />
					<cfif structKeyExists( rule, 'commands' ) >
						<cfset size = arrayLen( rule['commands'] />
						<cfif ( size gt 0 ) >
							<cfloop from="1" to="#size#" index="i" >
								<cfset cxt.enqueueCommand( cxt.newCommand( rule['commands'][i]['name'], rule['commands'][i]['bind'], rule['commands'][i]['args'] ) ) />
								<cfif getShouldTrace() >
									<cftrace  type="information" text="RuleInterceptor: CLEARTHENENQUEUE #rule['commands'][i]['name']#" />
								</cfif>
							</cfloop>
						</cfif>
					</cfif>
					<cfif getShouldTrace() >
						<cftrace  type="information" text="RuleInterceptor: CLEARTHENENQUEUE completes" />
					</cfif>
				</cfcase>

				<cfcase value="enqueue" >
					<cfif structKeyExists( rule, 'responses' ) >
						<cfset size = arrayLen( rule['responses'] />
						<cfif ( size gt 0 )>
							<cfloop from="1" to="#size#" index="i" >
								<cfif getShouldTrace() >
									<cftrace  type="information" text="RuleInterceptor: ENQUEUE response #rule['responses'][i]['name']#" />
								</cfif>
								<cfset cxt.setResponse( rule['responses'][i]['name'], rule['responses'][i]['value'] ) />
							</cfloop>
						</cfif>
					</cfif>
					<cfif structKeyExists( rule, 'commands' ) >
						<cfset size = arrayLen( rule['commands'] />
						<cfif ( size gt 0 ) >
							<cfloop from="1" to="#size#" index="i" >
								<cfset cxt.enqueueCommand( cxt.newCommand( rule['commands'][i]['name'], rule['commands'][i]['bind'], rule['commands'][i]['args'] ) ) />
								<cfif getShouldTrace() >
									<cftrace  type="information" text="RuleInterceptor: ENQUEUE #rule['commands'][i]['name']#" />
								</cfif>
							</cfloop>
						</cfif>
					</cfif>
					<cfif getShouldTrace() >
						<cftrace  type="information" text="RuleInterceptor: ENQUEUE completes" />
					</cfif>
				</cfcase>

				<cfcase value="enstack" >
					<cfif structKeyExists( rule, 'responses' ) >
						<cfset size = arrayLen( rule['responses'] />
						<cfif ( size gt 0 )>
							<cfloop from="1" to="#size#" index="i" >
								<cfif getShouldTrace() >
									<cftrace  type="information" text="RuleInterceptor: ENSTACK response #rule['responses'][i]['name']#" />
								</cfif>
								<cfset cxt.setResponse( rule['responses'][i]['name'], rule['responses'][i]['value'] ) />
							</cfloop>
						</cfif>
					</cfif>
					<cfif structKeyExists( rule, 'commands' ) >
						<cfset size = arrayLen( rule['commands'] />
						<cfif ( size gt 0 ) >
							<cfloop from="1" to="#size#" index="i" >
								<cfset cxt.enstackCommand( cxt.newCommand( rule['commands'][i]['name'], rule['commands'][i]['bind'], rule['commands'][i]['args'] ) ) />
								<cfif getShouldTrace() >
									<cftrace  type="information" text="RuleInterceptor: ENSTACK #rule['commands'][i]['name']#" />
								</cfif>
							</cfloop>
						</cfif>
					</cfif>
					<cfif getShouldTrace() >
						<cftrace  type="information" text="RuleInterceptor: ENSTACK completes" />
					</cfif>
				</cfcase>

				<cfcase value="next" >
					<cfif structKeyExists( rule, 'responses' ) >
						<cfset size = arrayLen( rule['responses'] />
						<cfif ( size gt 0 )>
							<cfloop from="1" to="#size#" index="i" >
								<cfif getShouldTrace() >
									<cftrace  type="information" text="RuleInterceptor: NEXT response #rule['responses'][i]['name']#" />
								</cfif>
								<cfset cxt.setResponse( rule['responses'][i]['name'], rule['responses'][i]['value'] ) />
							</cfloop>
						</cfif>
					</cfif>
					<cfif getShouldTrace() >
						<cftrace  type="information" text="RuleInterceptor: NEXT completes" />
					</cfif>
				</cfcase>

				<cfdefaultcase>
					<cfif getShouldTrace() >
						<cftrace  type="warning" text="ResponseInterceptor: invalid rule onMatch value: [#rule['onMatch']#], command #arguments.command.getName()#,  method #arguments.method#" />
					</cfif>
				</cfdefaultcase>

		</cfswitch>

		<cfif ( ( lCase( rule['onMatch'] ) eq 'halt' ) and ( lCase( arguments.method ) eq 'prehandle' ) )>
			<cfreturn false >
		</cfif>

		<cfif getShouldTrace() >
			<cftrace type="information" text="RuleInterceptor: for method #arguments.method#, command #arguments.command.getName()#, rule application completes" />
		</cfif>

		<cfreturn true />
	</cffunction>


	<cffunction name="processRules" access="private" returntype="void" output="false">
		<cfargument name="rules" type="array" required="true" />
		<cfargument name="context" type="struct" required="true" />

		<cfset var cxt = arguments.context />
		<cfset var r = cxt.getResponses() />
		<cfset var rule = structNew() />
		<cfset var condition = structNew() />
		<cfset var conditions = arrayNew(1) />
		<cfset var hasValidConditions = false />
		<cfset var i = 0 />
		<cfset var j = 0 />
		<cfset var size = arrayLen( arguments.rules ) />
		<cfset var ruleText = "" />

		<cfif ( size eq 0 ) >
			<cfif getShouldTrace() >
				<cftrace type="information" text="RuleInterceptor: no rules available" />
			</cfif>
			<cfreturn true />
		</cfif>

		<!--- loop through each rule --->
		<cfloop from="1" to="#size#" index="i" >

			<cfif getShouldTrace() >
				<cftrace  type="information" text="RuleInterceptor: trying rule #i#" />
			</cfif>

			<cfset rule = arguments.rules[i] />
			<cfset ruleText = "" />

			<!--- no conditions is true --->
			<cfif ( arrayLen( rule['conditions'] ) eq 0 ) >
				<cfset hasValidConditions = true />
				<cfset ruleText = "unconditional" />
			</cfif>

			<!--- see if the condition(s) match --->
			<cfset j = 1 />
			<cfloop condition="j lte arrayLen( rule['conditions'] )" >
				<!--- cfset ruleText = ruleText & rule['conditions'][j]['conjunction'] & ' ' & rule['conditions'][j]['key'] & ' ' & rule['conditions'][j]['operator'] & ' ' & rule['conditions'][j]['value'] & ' ' / --->
				<cfset ruleText = ruleText & iif(j neq 1, de(' and '), de('') ) & rule['conditions'][j]['key'] & ' ' & rule['conditions'][j]['operator'] & ' ' & rule['conditions'][j]['value'] & ' ' />
				<cfset hasValidConditions = matchCondition( rule['conditions'][j], r, i ) />
				<cfif ( not hasValidConditions ) >
					<cfbreak>
				</cfif>
				<cfset j = j + 1 />
			</cfloop>

			<!--- got a good one --->
			<cfif hasValidConditions >
				<cfif getShouldTrace() >
					<cftrace  type="information" text="RuleInterceptor: matched rule #i# ( #ruleText# )" />
				</cfif>
				<cfreturn rule />
				<cfbreak>
			</cfif>
			<cfif getShouldTrace() >
				<cftrace  type="information" text="RuleInterceptor: did not match rule #i# ( #ruleText# )" />
			</cfif>

		</cfloop>

		<!--- if we got here nothing matched, we're done --->
		<cfreturn true />
	</cffunction>


	<cffunction name="matchCondition" access="private" returntype="boolean" output="false">
		<cfargument name="condition" required="true" type="struct" />
		<cfargument name="responses" required="true" type="struct" />
		<cfargument name="salience" required="true" type="numeric" />

		<cfset var c = arguments.condition />
		<cfset var key = c['key'] />
		<cfset var operator = c['operator']	/>
		<cfset var value = c['value'] />
		<cfset var r = arguments.responses />
		<cfset var index = 0 />

		<cfif ( not compareNoCase( operator, 'exists' ) ) >
			<cfreturn ( structKeyExists( r, key ) ) />
		</cfif>

		<cfif ( not compareNoCase( operator, 'doesNotExist' ) ) >
			<cfreturn ( not structKeyExists( r, key ) ) />
		</cfif>

		<!--- todo typeOf --->
		<cfif ( not compareNoCase( operator, 'typeOf' ) ) >
			<cfabort showerror="RulesEngine typeOf TODO">
		</cfif>

		<!--- missing/incorrect keys do not throw errors --->
		<cfif ( not structKeyExists( r, key ) ) >
			<cfif getShouldTrace() >
				<cftrace  type="warning" text="RuleInterceptor: the response specified (#key#) does not exist" />
			</cfif>
			<cfreturn false />
		</cfif>

		<cfif ( not isSimpleValue( structFind( r, key ) ) ) >
			<cfif getShouldTrace() >
				<cftrace  type="Error" text="RuleInterceptor: the response specified (#key#) is not a simple value" />
			</cfif>
			<cfreturn false />
		</cfif>

		<!---- cfset clause = DE(responseValue) & ' ' & operator & ' ' & DE(conditionValue) / --->
		<!--- doing match() instead of evaluate() gives us the option of future additional operators (LIKE)--->

		<cfreturn match( r[key], operator, value )	/>
	</cffunction>


	<cffunction name="match" access="private" returntype="boolean" output="false">
		<cfargument name="respValue" required="true" type="any" />
		<cfargument name="operator" required="true" type="string" />
		<cfargument name="conditionValue" required="true" type="any" />

		<cfswitch expression="#lcase(arguments.operator)#" >

			<cfcase value="eq">
				<cfreturn ( arguments.respValue eq arguments.conditionValue )	/>
			</cfcase>

			<cfcase value="neq">
				<cfreturn ( arguments.respValue neq arguments.conditionValue ) />
			</cfcase>

			<cfcase value="lt">
				<cfreturn ( arguments.respValue lt arguments.conditionValue ) />
			</cfcase>

			<cfcase value="lte">
				<cfreturn ( arguments.respValue lte arguments.conditionValue ) />
			</cfcase>

			<cfcase value="gt">
				<cfreturn ( arguments.respValue gt arguments.conditionValue ) />
			</cfcase>

			<cfcase value="gte">
				<cfreturn ( arguments.respValue gte arguments.conditionValue ) />
			</cfcase>

			<cfcase value="contains">
				<cfreturn ( arguments.respValue contains arguments.conditionValue ) >
			</cfcase>

			<cfcase value="doesnotcontain">
				<cfreturn ( arguments.respValue does not contain arguments.conditionValue ) >
			</cfcase>

			<cfdefaultcase>
				<cfif getShouldTrace() >
					<cftrace type="Error" text="the operator specified (#arguments.operator#) is invalid" />
				</cfif>
				<cfreturn false />
			</cfdefaultcase>

		</cfswitch>

	</cffunction>


	<!--------------------------------------------------------------------------------->

	<cffunction name="setShouldTrace" access="public" returntype="void" output="false">
		<cfargument name="shouldTrace" type="boolean" required="true" />
		<cfset variables['properties']['shouldTrace'] = arguments.shouldTrace />
	</cffunction>


	<cffunction name="getShouldTrace" access="public" returntype="any" output="false">
		<cfreturn variables['properties']['shouldTrace'] />
	</cffunction>

</cfcomponent>