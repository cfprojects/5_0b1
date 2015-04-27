<cfcomponent displayname="ValueParser" output="false" >
<!---
Parses replacement requests like the ColdSpring framework (e.g. spring)
using similar (but configurable) syntax to determine that a substitution is needed: g${}. So, for example,
g${aaa.bbb} is just a dotted string property which should be found in the data provided
to the VP. Additionally, g${aaa.getFoo()} should return the value of
the getFoo method of the aaa instance found in the data provided to the VP.

Additionally, the VP also attempts to find a value or method return on any arbitrarily nested group of
scopes, structures, or arrays, similar to the ColdFusion function structFindKey(). To clearly
distinguish the two parsing models, the sytax g?{} is used for requests of this type.
Thus the VP should be able to find g?{application.foo.bar}, where bar is a value of the foo struct found
in application scope. Similarly as above, g?{session.aaa.getFoo()} should return the value of the getFoo
method of the aaa instance found in the ColdFusion session scope, and g?{aaa.bbb.getFoo()} should return
the value of the getFoo method of the bbb struct found in the aaa struct found in the data provided
to the VP.

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
		<td>substitutionPrefix</td>
		<td>g${</td>
		<td>string used to determine the start of a value substitution</td>
	</tr>
	<tr>
		<td>substitutionSuffix</td>
		<td>}</td>
		<td>string used to determine the end of a value substitution</td>
	</tr>
	<tr>
		<td>scopedPrefix</td>
		<td>g?{</td>
		<td>string used to determine the start of a scoped substitution</td>
	</tr>
	<tr>
		<td>scopedSuffix</td>
		<td>}</td>
		<td>string used to determine the end of a scoped substitution</td>
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
org.gliint.framework.util.ValueParser

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
	<cfset variables['properties']['substitutionPrefix'] = "g${" />
	<cfset variables['properties']['substitutionSuffix'] = "}" />
	<cfset variables['properties']['namedPrefix'] = "g?{" />
	<cfset variables['properties']['namedSuffix'] = "}" />
	<cfset variables['properties']['shouldTrace'] = false />


	<!-------------------------------------------------------------------------->

	<cffunction name="init" access="public" returntype="org.gliint.framework.util.ValueParser" >
		<cfreturn this />
	</cffunction>


	<!--- opening up a huge can 'o worms with returntype="any" :) --->
	<cffunction name="parseValue" access="public" returntype="any" >
		<cfargument name="value" type="any" required="true" />
		<cfargument name="data" type="struct" required="true" />

		<cfset var v = arguments.value />
		<cfset var sc = arguments.data />

		<!--- structs and arrays need to be inspected for substitutions --->
		<cfif ( isStruct( v ) ) >
			<cfreturn inspectStruct( v, sc ) />
		</cfif>

		<cfif ( isArray( v) ) >
			<cfreturn inspectArray( v, sc ) />
		</cfif>

		<!--- any other complex values are returned as-is --->
		<cfif ( not ( isSimpleValue( v ) ) ) >
			<cfreturn v />
		</cfif>

		<!--- resolve replacement requests: REFindNoCase("\g${(.)*?}" --->
		<cfif ( ( left( v, 2 ) eq getSubstitutionPrefix() ) and ( right( v, 1 ) eq getSubstitutionSuffix() ) ) >

			<cfset v = mid( v, 3, len( v ) - 3 ) />

			<cfif structKeyExists( sc , v )>
				<cfset v = sc[v] />
			<cfelse>
				<!--- note that if it's not found, we return the unparsed value instead of an empty string
				intending to alert the developer that the expected substitution did not occur
				--->
				<cfif getShouldTrace() >
					<cftrace type="warning"	text="ValueParser: could not find substitution data for #arguments.value#" />
				</cfif>
				<cfset v = arguments.value />
			</cfif>

		</cfif>


		<cfif ( ( left( v, 2 ) eq 'g?{' ) and ( right( v, 1 ) eq '}' ) ) >

			<cfset v = mid( v, 3, len( v ) - 3 ) />

			<cfif ( not find( '.', v ) ) >

				<cfif structKeyExists( sc , v )>
					<cfset v = sc[v] />
				<cfelse>
					<!--- throw warning if not exists --->
					<cfif getShouldTrace() >
						<cftrace type="warning"	text="ValueParser: could not find substitution data for #arguments.value#" />
					</cfif>
				</cfif>

			<cfelse>

				<cfif ( listFindNoCase( 'server,application,session,request', listFirst( v, '.' ) ) ) >
					<!--- it is cf scoped --->
					<cfset sc = evaluate( listFirst( v, '.' ) ) />
					<cfset v = listDeleteAt( v, 1, '.' ) />
				</cfif>

				<cfset v = getScopedValue( sc, v ) />

			</cfif>

		</cfif>

		<cfreturn v />
	</cffunction>


	<cffunction name="getScopedValue" access="private" returntype="any" >
		<cfargument name="scope" type="any" required="true" />
		<cfargument name="key" type="string" required="true" />

		<cfset var sc = arguments.scope />
		<cfset var k = arguments.key />
		<cfset var v = arguments.key />
		<cfset var x = "" />

		<cfif ( not find( '.', k ) ) >

				<cfif ( right( k, 1 ) eq ')' ) >
					<!--- it's a function call.
						Only no-arg function calls are allowed for now;
						in the future we might parse what's in the parens for args to the cfinvoke below
					 --->

					<cfset k = left( k, len(k)-2 ) />
					<cfinvoke component="#sc#" method="#k#" returnvariable="v" />
				<cfelse>

					<cfif ( structKeyExists( sc, k ) ) >
						<cfset v = sc[k] />
					<cfelse>
						<cfif getShouldTrace() >	
							<cftrace type="warning"	text="ValueParser: could not find substitution data for #arguments.key#" />
						</cfif>
					</cfif>

				</cfif>

		<cfelse>

			<cfset x = listFirst( k, '.' ) />
			<cfif ( structKeyExists( sc, x ) ) >
				<cfset k = listDeleteAt( k, 1, '.' ) />
				<cfset v = getScopedValue( sc[x], k ) />
			<cfelse>
				<cfif getShouldTrace() >	
					<cftrace type="warning"	text="ValueParser: could not find substitution data for #arguments.key#" />
				</cfif>
			</cfif>

		</cfif>

		<cfreturn v />
	</cffunction>


	<cffunction name="inspectStruct" access="private" returntype="struct">
		<cfargument name="value" type="struct" required="true" />
		<cfargument name="data" type="struct" required="true" />

		<cfset var i = "" />
		<cfset var v = duplicate( arguments.value ) />

		<cfloop collection="#v#" item="i" >
			<cfset v[i] = parseValue( v[i], arguments.data ) />
		</cfloop>

		<cfreturn v />
	</cffunction>


	<cffunction name="inspectArray" access="private" returntype="array">
		<cfargument name="value" type="array" required="true" />
		<cfargument name="data" type="struct" required="true" />

		<cfset var i = 0 />
		<cfset var v = duplicate( arguments.value ) />
		<cfset var sz = arrayLen( v ) />

		<cfloop condition="i lt sz" >
			<cfset i = i + 1 />
			<cfset v[i] = parseValue( v[i], arguments.data ) />
		</cfloop>

		<cfreturn v />
	</cffunction>


	<cffunction name="setSubstitutionPrefix" access="public" returntype="void" output="false">
		<cfargument name="substitutionPrefix" required="true" type="string" />
		<cfset variables['properties']['substitutionPrefix'] = arguments.substitutionPrefix />
	</cffunction>
	
	
	<cffunction name="getSubstitutionPrefix" access="public" returntype="string" output="false">
		<cfreturn variables['properties']['substitutionPrefix'] />
	</cffunction>


	<cffunction name="setSubstitutionSuffix" access="public" returntype="void" output="false">
		<cfargument name="substitutionSuffix" required="true" type="string" />
		<cfset variables['properties']['substitutionSuffix'] = arguments.substitutionSuffix />
	</cffunction>
	
	
	<cffunction name="getSubstitutionSuffix" access="public" returntype="string" output="false">
		<cfreturn variables['properties']['substitutionSuffix'] />
	</cffunction>


	<cffunction name="setScopedPrefix" access="public" returntype="void" output="false">
		<cfargument name="scopedPrefix" required="true" type="string" />
		<cfset variables['properties']['scopedPrefix'] = arguments.scopedPrefix />
	</cffunction>
	
	
	<cffunction name="getScopedPrefix" access="public" returntype="string" output="false">
		<cfreturn variables['properties']['scopedPrefix'] />
	</cffunction>


	<cffunction name="setScopedSuffix" access="public" returntype="void" output="false">
		<cfargument name="scopedSuffix" required="true" type="string" />
		<cfset variables['properties']['scopedSuffix'] = arguments.scopedSuffix />
	</cffunction>
	
	
	<cffunction name="getScopedSuffix" access="public" returntype="string" output="false">
		<cfreturn variables['properties']['scopedSuffix'] />
	</cffunction>


	<cffunction name="setShouldTrace" access="public" returntype="void" output="false">
		<cfargument name="shouldTrace" type="boolean" required="true" />
		<cfset variables['properties']['shouldTrace'] = arguments.shouldTrace />
	</cffunction>


	<cffunction name="getShouldTrace" access="public" reutrntype="boolean" output="false">
		<cfreturn variables['properties']['shouldTrace'] />
	</cffunction>
	
</cfcomponent>