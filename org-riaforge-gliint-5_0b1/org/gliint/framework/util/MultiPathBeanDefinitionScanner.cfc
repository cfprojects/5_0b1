<cfcomponent displayname="MultiPathBeanDefinitionScanner" output="false" >
<!---
org.gliint.framework.context.MultiPathBeanDefinitionScanner

Scans multiple paths for cfc components, registering bean definitions with it's beanFactory. Does NOT recurse, so
folders below a path are NOT scanned.

Copyright (c) 2008-2009 Mitchell M. Rose
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
	<cfset variables['properties']['beanFactory'] = false />
	<cfset variables['properties']['prefixDelimiter'] = "." />
	<cfset variables['properties']['paths'] = "" />
	<cfset variables['properties']['beanDefDefaults'] = structNew() />

	<!-------------------------------------------------------------------------->

	<cffunction name="init" access="public" returntype="org.gliint.context.MultiPathBeanDefinitionScanner" output="false">
		<cftrace  type="information" text="Gliint MultiPathBeanDefinitionScanner has been initialized" />
		<cfreturn this />
	</cffunction>


	<cffunction name="scan" access="public" returntype="numeric" output="false"
		hint="Perform a scan within the specified paths, registering each bean with the given registry (beanFactory).">

		<cfargument name="paths" type="string" required="false" default="#getPaths()#" />
		<cfargument name="prefixDelimiter" type="string" required="false" default="#getPrefixDelimiter()#" />

		<cfset var p = "" />
		<cfset var q = queryNew( 'directory,name,type,' ) />
		<cfset var dir = "" />
		<cfset var n = "" />
		<cfset var componentName = "" />
		<cfset var args = structNew() />
		<cfset var count = 0 />

		<cfloop list="#arguments.paths#" index="p" >

			<!--- remove trailing slash if it exists, yes there are easier ways... --->
			<cfif ( right( p, 1 ) eq '/' ) >
				<cfset p = left( p, len(p) -1 ) />
			</cfif>
			<cfset dir = expandPath( p ) />

			<cftrace  type="information" text="MultiPathBeanDefinitionScanner: scanning #dir#" />

			<cfdirectory action="list" name="q" filter="*.cfc" directory="#dir#" />
			<cfloop query="q" >
				<cfset n = left( name, len( name ) - 4 ) />
				<cfset componentName = n />
				<cfif ( len( arguments.prefixDelimiter ) neq 0 ) >
					<cfset componentName = listLast( p, '/\' ) & arguments.prefixDelimiter & componentName />
				</cfif>

				<cfset args = getBeanDefDefaults() />
				<cfset args['beanID'] = componentName />
				<cfset args['beanClass'] = listChangeDelims( p, '.',	'/\') & '.' & n />
				<cfset args['children'] = arrayNew(1) />

				<cfparam name="args['isSingleton']" default="#true#" />
				<cfparam name="args['isInnerBean']" default="#false#" />
				<cfparam name="args['isLazyInit']" default="#false#" />

				<cfset getBeanFactory().createBeanDefinition( argumentCollection = args ) />

				<!--- for Jamie: adding 1 to count ;) --->
				<cfset count = count + 1 />
				<cftrace  type="information" text="MultiPathBeanDefinitionScanner: added #n# (#componentName#)" />
			</cfloop>

		</cfloop>
		<cfreturn count />
	</cffunction>




	<cffunction name="setBeanFactory" access="public" returntype="void" output="false">
		<cfargument name="beanFactory" required="true" type="coldspring.beans.BeanFactory" />
		<cfset variables['properties']['beanFactory'] = arguments.beanFactory />
	</cffunction>


	<cffunction name="getBeanFactory" access="public" returntype="any" output="false">
		<cfreturn variables['properties']['beanFactory'] />
	</cffunction>


	 <cffunction name="setPrefixDelimiter" access="public" returntype="void" output="false">
		<cfargument name="prefixDelimiter" required="true" type="string" />
		<cfset variables['properties']['prefixDelimiter'] = arguments.prefixDelimiter />
	</cffunction>


	<cffunction name="getPrefixDelimiter" access="public" returntype="string" output="false">
		<cfreturn variables['properties']['prefixDelimiter'] />
	</cffunction>


	<cffunction name="setPaths" access="public" returntype="void" output="false">
		<cfargument name="paths" required="true" type="string" />
		<cfset variables['properties']['paths'] = arguments.paths />
	</cffunction>


	<cffunction name="getPaths" access="public" returntype="string" output="false">
		<cfreturn variables['properties']['paths'] />
	</cffunction>


	<cffunction name="setBeanDefDefaults" access="public" returntype="void" output="false">
		<cfargument name="beanDefDefaults" type="struct" required="true" />
		<cfset variables['properties']['beanDefDefaults'] = arguments.beanDefDefaults />
	</cffunction>


	<cffunction name="getBeanDefDefaults" access="private" returntype="struct" output="false">
		<cfreturn variables['properties']['beanDefDefaults'] />
	</cffunction>

</cfcomponent>