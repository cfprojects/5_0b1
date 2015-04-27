<cfcomponent displayname="ContextLoader" output="false" >
<!---
A transient component that creates a web application context. In addition to its init() method,
it provides mutator methods for the setting of the application context class, it's configuration file, and,
optionally, a parent application context.

Based on Spring framework 1.2  org.springframework.web.context.ContextLoader:

"Performs the actual initialization work for the root application context. Called by ContextLoaderListener.
Looks for a "contextClass" parameter at the web.xml context-param level to specify the context class type,
falling back to the default of XmlWebApplicationContext if not found.
With the default ContextLoader implementation, any context class specified needs to
implement the ConfigurableWebApplicationContext interface."

"Processes a "contextConfigLocation" context-param and passes its value to the context instance,
parsing it into potentially multiple file paths which can be separated by any number of commas and spaces,
e.g. "WEB-INF/applicationContext1.xml, WEB-INF/applicationContext2.xml".
Ant-style path patterns are supported as well,
e.g. "WEB-INF/*Context.xml,WEB-INF/spring*.xml" or "WEB-INF/**/*Context.xml".
If not explicitly specified, the context implementation is supposed to use a default location
(with XmlWebApplicationContext: "/WEB-INF/applicationContext.xml")."

"Note: In case of multiple config locations, later bean definitions will override ones defined in
previously loaded files, at least when using one of Spring's default ApplicationContext implementations.
This can be leveraged to deliberately override certain bean definitions via an extra XML file."

"Above and beyond loading the root application context, this class can optionally load or
obtain and hook up a shared parent context to the root application context.
See the loadParentContext(ServletContext) method for more information."

<b>Exposed configuration properties  (including those defined by superclass):</b>
<br/>
	<cfset variables['properties']['contextConfigLocation'] = "" />
	<cfset variables['properties']['parentContextKey'] = "" />
	<cfset variables['properties']['beanFactoryClass'] = "coldspring.beans.DefaultXmlBeanFactory" />

<table class="withBorder" cellpadding="3" cellspacing="">
	<tbody>
	<tr class="" style="bottom-border: 1px black solid;">
		<th><b>name</b></th>
		<th><b>default</b></th>
		<th><b>description</b></th>
	</tr>
	<tr>
		<td>contextClass</td>
		<td>XmlWebApplicationContext</td>
		<td>Dotted path notation to the WebApplicationContext implementation class to use</td>
	</tr>
	<tr>
		<td>contextConfigLocation</td>
		<td>&nbsp;</td>
		<td>Parameter that can specify the config location for the context,</td>
	</tr>
	<tr>
		<td>parentContextKey</td>
		<td>&nbsp;</td>
		<td>Optional parameter used to obtaining a parent context</td>
	</tr>
	<tr>
		<td>beanFactoryClass</td>
		<td>coldspring.beans.DefaultXmlBeanFactory</td>
		<td>Dotted path notation to the ColdSpring DefaultXmlBeanFactory implementation class to use</td>
	</tr>
	</tbody>
</table>

<b>Since:</b>

<b>See Also:</b>
	<br/>org.gliint.framework.Dispatcher
<hr/>
<table class="summaryTable" cellpadding="3" cellspacing="0">
	<tbody>
		<tr><th>&nbsp;</th><th colspan="3">Field Summary</th></tr>
		<tr class="">
			<td class="summaryTablePaddingCol">&nbsp;</td>
			<td class="summaryTablesigCol" nowrap="nowrap"><code>private webApplicationContext</code></td>
			<td class="summaryTableSignatureCol">
				<div class="summarySignature">org.gliint.framework.context.DefaultWebApplicationContext</div>
				<div class="summaryTableDescription">The root WebApplicationContext instance that this loader manages</div>
		</td>
	</tr>
	</tbody>
</table>
--->
<!---
org.gliint.framework.context.ContextLoader

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
	<cfset variables['properties']['contextClass'] = "org.gliint.framework.context.DefaultWebApplicationContext" />
	<cfset variables['properties']['contextConfigLocation'] = "" />
	<cfset variables['properties']['parentContextKey'] = "" />
	<cfset variables['properties']['beanFactoryClass'] = "coldspring.beans.DefaultXmlBeanFactory" />

	<!--- the root WebApplicationContext instance that this loader manages --->
	<cfset variables['properties']['webApplicationContext'] = false />

	<!--- holds BeanFactoryReference when loading parent factory via ContextSingletonBeanFactoryLocator
	<cfset variables['properties']['parentContextRef'] = "" />
	--->


	<cffunction name="init" access="public" returntype="org.gliint.framework.context.ContextLoader" output="false">
		<cfargument name="contextClass" type="string" required="false" default="#getContextClass()#" />
		<cfargument name="contextConfigLocation" type="string" required="false" default="#getContextConfigLocation()#" />
		<cfargument name="parentContextKey" type="string" required="false" default="#getParentContextKey()#" />
		<cfargument name="beanFactoryClass" type="string" required="false" default="#getBeanFactoryClass()#" />

		<cfset setContextClass( arguments.contextClass ) />
		<cfset setContextConfigLocation( arguments.contextConfigLocation ) />
		<cfset setParentContextKey( arguments.parentContextKey ) />
		<cfset setBeanFactoryClass( arguments.beanFactoryClass ) />

		<cftrace type="information" text="A ContextLoader has been created for class [#arguments.contextClass#] using configuration location [#arguments.contextConfigLocation#]" />

		<cfreturn this />
	</cffunction>


	<cffunction name="createWebApplicationContext" access="public" returntype="any" output="false">
		<cfargument name="scope" type="string" required="true" hint="the name of the scope that the context will exist in" />
		<cfargument name="name" type="string" required="false" default="" hint="a unique name for the context; if not supplied or blank, will default to the WebApplicationContext's ROOT_WEB_APPLICATION_CONTEXT property" />
		<cfargument name="defaultAttributes" type="struct" required="false" default="#structnew()#" hint="default behaviors for undefined bean attributes"/>
		<cfargument name="defaultProperties" type="struct" required="false" default="#structnew()#" hint="any default properties, which can be refernced via ${key} in your bean definitions"/>

		<cfset var bf = createObject( 'component', getBeanFactoryClass() ).init( arguments.defaultAttributes, arguments.defaultProperties ) />
		<cfset var c = createObject( 'component', getContextClass() ).init() />
		<cfset var scopeStruct = getScope( arguments.scope ) />
		<cfset var n = arguments.name />

		<!--- if n is blank, use the webApplicationContext's ROOT_WEB_APPLICATION_CONTEXT --->
		<cfif ( len(n) eq 0 ) >
			<cfset n = c['ROOT_WEB_APPLICATION_CONTEXT'] />
		</cfif>
<!---
		<cfset var loc = getContextConfigLocation() />
		<cfif ( len( loc ) eq 0 ) >
			<cfthrow message="Context Loader is missing the configuration location" />
		</cfif>
--->

		<cfset c.setDisplayName( n ) />
		<cfset c.setConfigLocation( getContextConfigLocation() ) />
		<cfset c.setNamespace( arguments.scope ) />
		<cfset c.setBeanFactory( bf ) />

		<!--- load Parent Context --->
		<cfif ( len( getParentContextKey() gt 0 ) ) >
			<cfif c.containsBean( getParentContextKey() ) >
				<cfset c.setParent( c.getBean( getParentContextKey() ) ) />
			</cfif>
		</cfif>

		<cfif ( not structKeyExists( scopeStruct, 'contextLoader' ) ) >
			<cfset scopeStruct['contextLoader'] = structNew() />
		</cfif>

		<cfif ( not structKeyExists( scopeStruct['contextLoader'], n ) ) >
			<cfset scopeStruct['contextLoader'][n] = structNew() />
		</cfif>

		<cfif ( not structKeyExists( scopeStruct['contextLoader'][n], 'isLoading' ) ) >
			<cfset scopeStruct['contextLoader'][n]['isLoading'] = false />
		</cfif>

		<cfif ( not scopeStruct['contextLoader'][n]['isLoading'] ) >
			<cflock name="contextLoader-#n#-Lock" timeout="300" throwontimeout="no" type="exclusive">
				<cfif ( not scopeStruct['contextLoader'][n]['isLoading'] ) >

					 <cftry>

						 <cfset scopeStruct['contextLoader'][n]['isLoading'] = true />
						 <cfset scopeStruct['contextLoader'][n]['isLoaded'] = false />
						 <cfset variables['properties']['webApplicationContext']	= c />
						 <cfset structDelete( scopeStruct, n ) />
						 <cfset scopeStruct[n] = c />
						 <cfset scopeStruct['contextLoader'][n]['isLoaded'] = true />
						 <cfset scopeStruct['contextLoader'][n]['isLoading'] = false />

						 <cfcatch type="any" >
							 <cfset structDelete( scopeStruct, n ) />
							 <cfrethrow>
						 </cfcatch>

					</cftry>

				</cfif>
			</cflock>
		</cfif>

		<cftrace type="information" text="WebApplicationContext '#n#' (#getContextClass()#) has been loaded into the #arguments.scope# scope" />

		<cfreturn c />
	</cffunction>


	<cffunction name="setContextClass" access="public" returntype="void" output="false">
		<cfargument name="contextClass" type="string" required="true" />
		<cfset variables['properties']['contextClass'] = arguments.contextClass />
	</cffunction>


	<cffunction name="getContextClass" access="public" returntype="string" output="false">
		<cfreturn variables['properties']['contextClass'] />
	</cffunction>


	<cffunction name="setContextConfigLocation" access="public" returntype="void" output="false">
		<cfargument name="contextConfigLocation" type="string" required="true" />
		<cfset variables['properties']['contextConfigLocation'] = arguments.contextConfigLocation />
	</cffunction>


	<cffunction name="getContextConfigLocation" access="public" returntype="string" output="false">
		<cfreturn variables['properties']['contextConfigLocation'] />
	</cffunction>


	<cffunction name="setParentContextKey" access="public" returntype="void" output="false">
		<cfargument name="parentContextKey" type="string" required="true" />
		<cfset variables['properties']['parentContextKey'] = arguments.parentContextKey />
	</cffunction>


	<cffunction name="getParentContextKey" access="public" returntype="string" output="false">
		<cfreturn variables['properties']['parentContextKey'] />
	</cffunction>


	<cffunction name="setBeanFactoryClass" access="public" returntype="void" output="false">
		<cfargument name="beanFactoryClass" type="string" required="true" />
		<cfset variables['properties']['beanFactoryClass'] = arguments.beanFactoryClass />
	</cffunction>


	<cffunction name="getBeanFactoryClass" access="public" returntype="string" output="false">
		<cfreturn variables['properties']['beanFactoryClass'] />
	</cffunction>


	<cffunction name="getScope" access="private" returntype="struct" output="false">
		<cfargument name="scope" type="string" required="true" />
		 <cfswitch expression="#lCase( arguments.scope )#">
			<cfcase value="application"><cfreturn application /></cfcase>
			<cfcase value="request"><cfreturn request /></cfcase>
			<cfcase value="server"><cfreturn server /></cfcase>
			<cfcase value="session"><cfreturn session /></cfcase>
			<cfcase value="this"><cfreturn this /></cfcase>
			<cfcase value="variables"><cfreturn variables /></cfcase>
			<cfdefaultcase><cfreturn structNew() /></cfdefaultcase>
		</cfswitch>
	</cffunction>

</cfcomponent>