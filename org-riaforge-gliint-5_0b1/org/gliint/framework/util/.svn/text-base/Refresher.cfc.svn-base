<cfcomponent displayname="Refresher" output="false">
<!---
Using file size and dateLastModified data, checks to see if the file(s) specified in arguments['contextConfigLocation'] has changed.
If they contain &lt;import&gt; tags, checks those files identified by the resource attribute, recursively.

<b>Exposed configuration properties  (including those defined by superclass):</b>
<br/>
None

<b>Since:</b>

<b>See Also:</b>
--->
<!---
org.gliint.framework.util.Refresher

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
	<cfset variables['instance']['locations'] = structNew() />
	<cfset variables['instance']['size'] = 0 />


	<cffunction name="init" access="public" returntype="org.gliint.framework.util.Refresher" output="false">
		<cfreturn this />
	</cffunction>


	<cffunction name="shouldRefresh" access="public" returntype="boolean" output="false">
		<cfargument name="contextConfigLocation" type="string" required="true" />

		<cfset var b = false />
		<cfset var loc = "" />

		<cftrace type="information" text="org.gliint.framework.util.Refresher: shouldRefresh check starts" />

		<cfif ( listLen( arguments.contextConfigLocation ) neq variables['instance']['size'] )>
			<cfset variables['instance']['size'] = listLen( arguments.contextConfigLocation ) />
			<cftrace type="information" text="org.gliint.framework.util.Refresher: contextConfigLocation list has changed (updating)" />
			<cftrace type="information" text="org.gliint.framework.util.Refresher: check completes" />
			<cfreturn true />
		</cfif>

		<cfloop list="#arguments.contextConfigLocation#" index="loc">
			<cfif ( fileChanged( loc ) ) >
				<cfset b = true />
				<cfbreak />
			</cfif>
		</cfloop>

		<cftrace type="information" text="org.gliint.framework.util.Refresher: shouldRefresh check completes" />
		<cfreturn b />
	</cffunction>


	<cffunction name="getInstance" access="public" returntype="struct" output="false" >
		<cfreturn variables['instance'] />
	</cffunction>


	<cffunction name="fileChanged" access="private" returntype="boolean" output="false" >
		<cfargument name="contextConfigLocation" type="string" required="true" />

		<cfset var q = queryNew( 'name,directory,size,type,dateLastModified,attributes,mode' ) />
		<cfset var h = "" />

		<cfdirectory action="list" name="q" directory="#expandPath( getDirectoryFromPath( arguments.contextConfigLocation ) )#" filter="#getFileFromPath( arguments.contextConfigLocation )#" />
		<cfset h = hash(q.size & q.dateLastModified) />

		<cfif ( not structKeyExists( variables['instance']['locations'], arguments.contextConfigLocation ) ) >
			<cfset variables['instance']['locations'][arguments.contextConfigLocation] = 0 />
		</cfif>

		<cfif ( variables['instance']['locations'][arguments.contextConfigLocation] neq h ) >
			<cftrace type="information" text="org.gliint.framework.util.Refresher: refresh needed! #h# is not #variables['instance']['locations'][arguments.contextConfigLocation]#" />
			<cfset variables['instance']['locations'][arguments.contextConfigLocation] = h />
			<cfreturn true />
		</cfif>

		<cfif importsChanged( arguments.contextConfigLocation ) >
			<cfreturn true />
		</cfif>

		<cftrace type="information" text="org.gliint.framework.util.Refresher: no refresh necessary ([#scopeStruct['contextLoader'][n]['refreshHash']#] eq [#h#])" />
		<cfreturn false />
	</cffunction>


	<cffunction name="importsChanged" access="private" returntype="boolean" output="false">
		<cfargument name="contextConfigLocation" type="string" required="true" />

		<cfset var p = expandPath( arguments.contextConfigLocation ) />
		<cfset var x = "" />
		<cfset var arr = arrayNew(1) />
		<cfset var i = 0 />
		<cfset var b = false />

		<cfif ( not fileExists( p ) ) >
			<cftrace  type="error" text="org.gliint.framework.util.Refresher: file #p# is not available" />
			<cfreturn true />
		</cfif>

		<cftry>
			<cfset x = xmlParse( p, true ) />
			<cfcatch type="coldfusion.xml.XmlProcessException" >
				<cftrace  type="error" text="org.gliint.framework.util.Refresher: could not parse file #p#" />
				<cfreturn true />
			</cfcatch>
		</cftry>

		<cfif ( not isXML( x ) ) >
			<cftrace type="error" text="org.gliint.framework.util.Refresher: the xml from #p# is not well-formed XML" />
			<cfreturn true />
		</cfif>

		<cfset arr = XMLsearch( x, 'beans/import' ) />
		<cfloop condition="i lt arrayLen( arr )" >
			<cfset i = i + 1 />
			<cfif fileChanged( arr[i]['xmlAttributes']['resource'] ) >
				<cfset b = true />
				<cfbreak />
			</cfif>
		</cfloop>

		<cfreturn b />
	</cffunction>

</cfcomponent>