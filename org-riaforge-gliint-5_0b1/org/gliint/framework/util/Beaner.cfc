<cfcomponent displayname="Beaner" output="false" >
<!---
Given a class or factory-bean/factory-method, creates a bean.
Optionally fills the bean with data. If a method argument is provided, attempts to fill the bean by
invoking the method and providing the data using it's fieldCollectionName.
If a method argument is not provided, iterates through the data, and fills a bean field
when 'set' plus the name of a data element is the same as a public mutator (setter) method.

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
		<td>fieldCollectionName</td>
		<td>data</td>
		<td>name of fieldCollection to be provided to method invoked</td>
	</tr>
	<tr>
		<td>beanFactory</td>
		<td>false</td>
		<td>typically ColdSpring's DefaultXmlBeanFactory</td>
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
org.gliint.framework.util.Beaner

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
	<cfset variables['properties']['fieldCollectionName'] = "data" />
	<cfset variables['properties']['beanFactory'] = false />
	<cfset variables['properties']['shouldTrace'] = false />

	<!-------------------------------------------------------------------------->

	<cffunction name="init" access="public" returntype="org.gliint.framework.util.Beaner" output="false">
		<cfreturn this />
	</cffunction>


	<cffunction name="getBeanByClass" access="public" returntype="any" output="false">
		<cfargument name="class" type="string" required="true" />
		<cfargument name="fieldCollection" type="struct" required="false" default="#structNew()#" />
		<cfargument name="method" type="string" required="false" default="" />

		<cfset var b = createObject( 'component', arguments.class ).init() />

		<cfif ( not structIsEmpty( arguments.fieldCollection ) ) >
			<cfset fill( b, fieldCollection, method ) />
		</cfif>

		<cfreturn b />
	</cffunction>


	<cffunction name="getBeanByFactory" access="public" returntype="any" output="false">
		<cfargument name="factoryBean" type="string" required="true" />
		<cfargument name="factoryMethod" type="string" required="false" hint="Factory method to use on factoryBean to create the bean. If not used, ColdSpring will provide the factoryBean instead." />
		<cfargument name="fieldCollection" type="struct" required="false" default="#structNew()#" />
		<cfargument name="method" type="string" required="false" default="" />
		<cfargument name="args" type="struct" required="false" default="#structNew()#">

		<cfset var fb = getBeanFactory().getBean( arguments.factoryBean ) >
		<cfset var b = fb />

		<cfif ( ( structKeyExists( arguments, 'factoryMethod' ) ) and ( len( arguments.factoryMethod ) gt 0 ) ) >
			<cfinvoke component="#fb#" method="#arguments.factoryMethod#" returnvariable="b" argumentcollection="#arguments.args#" />
		</cfif>

		<cfif ( not structIsEmpty( arguments.fieldCollection ) and isObject( b ) ) >
			<cfset fill( b, fieldCollection, method ) />
		</cfif>

		<cfreturn b />
	</cffunction>


	<cffunction name="fill" access="private" returntype="void" output="false">
		<cfargument name="bean" type="any" required="true" />
		<cfargument name="fieldCollection" type="struct" required="true" />
		<cfargument name="method" type="string" required="true" />

		<cfif ( len( arguments.method ) gt 0 ) >
			<cfinvoke component="#arguments.bean#" method="#arguments.method#" >
				<cfinvokeargument name="#getFieldCollectionName()#" value="#arguments.fieldCollection#" />
			</cfinvoke>
		<cfelse>
			<cfset setFields( arguments.bean, arguments.fieldCollection ) />
		</cfif>

	</cffunction>


	<cffunction name="setFields" access="private" returntype="void" output="false">
		<cfargument name="bean" type="any" required="true" />
		<cfargument name="fieldCollection" type="struct" required="true" />

		<cfset var f = ""	/>
		<cfset var md = "" />
		<cfset var funcs = "" />

		<cfif ( structIsEmpty( arguments.fieldCollection ) ) >
			<cfreturn />
		</cfif>

		<!---
			we do check if ancestors contain setNNN methods.
			we don't do anything for those who on CF8 are using onMissingMethod() to provide setters
		--->
		<cfset funcs = listFunctions( getMetadata(arguments.bean) ) />

		<cfloop collection="#arguments.fieldCollection#" item="f" >

			<cfif ( listFindNoCase( funcs, 'set' & f ) neq 0 ) >
				<cfinvoke component="#arguments.bean#" method="set#f#">
					<cfinvokeargument name="#f#" value="#arguments.fieldCollection[f]#" />
				</cfinvoke>
			</cfif>

		</cfloop>

	</cffunction>


	<cffunction name="listFunctions" access="private" returntype="string" output="false">
		<cfargument name="metadata" required="true" type="struct" />
		<cfargument name="list" required="false" type="string" default="" />

		<cfset var md = arguments.metadata />
		<cfset var newList = duplicate( arguments.list ) />
		<cfset var i = 0 />

		<cfif ( structKeyExists( md, 'functions' ) ) >
			<cfloop from="1" to="#arrayLen( md['functions'] )#" index="i" >
				<cfif ( ( ( ( structKeyExists( md['functions'][i], 'access' ) ) and ( compareNoCase( md['functions'][i]['access'], 'public') eq 0 ) )
								 or ( not structKeyExists( md['functions'][i], 'access' ) ) )
										and ( compareNoCase( left( md['functions'][i]['name'], 3), 'set' ) eq 0 ) ) >
					<cfset newList = listAppend( newList, md['functions'][i]['name'] ) />
				</cfif>
			</cfloop>
		</cfif>

		<cfif ( structKeyExists( md, 'extends' ) ) >
			<cfset newList = listFunctions( md.extends, newList ) />
		</cfif>

		<cfreturn newList />
	</cffunction>


	<cffunction name="setFieldCollectionName" access="public" returntype="void" output="false">
		<cfargument name="fieldCollectionName" required="true" type="string" />
		<cfset variables['properties']['fieldCollectionName'] = arguments.fieldCollectionName />
	</cffunction>


	<cffunction name="getFieldCollectionName" access="private" returntype="string" output="false">
		<cfreturn variables['properties']['fieldCollectionName'] />
	</cffunction>


	<cffunction name="setBeanFactory" access="public" returntype="void" output="false">
		<cfargument name="beanFactory" required="true" type="coldspring.beans.BeanFactory" />
		<cfset variables['properties']['beanFactory'] = arguments.beanFactory />
	</cffunction>


	<cffunction name="getBeanFactory" access="private" returntype="any" output="false">
		<cfreturn variables['properties']['beanFactory'] />
	</cffunction>


	<cffunction name="setShouldTrace" access="public" returntype="void" output="false">
		<cfargument name="shouldTrace" type="boolean" required="true" />
		<cfset variables['properties']['shouldTrace'] = arguments.shouldTrace />
	</cffunction>


	<cffunction name="getShouldTrace" access="public" reutrntype="boolean" output="false">
		<cfreturn variables['properties']['shouldTrace'] />
	</cffunction>

</cfcomponent>