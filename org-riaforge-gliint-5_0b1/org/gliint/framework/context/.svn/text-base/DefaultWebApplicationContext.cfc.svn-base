<cfcomponent displayname="DefaultWebApplicationContext" extends="org.gliint.framework.context.AbstractWebApplicationContext">
<!---
Based on Spring framework 1.2 interface WebApplicationContext:

"Central interface to provide configuration for an application.
This is read-only while the application is running, but may be reloaded if the implementation supports this."

"Note: The setters of this interface need to be called before an invocation of the refresh() method
inherited from ConfigurableApplicationContext. They do not cause an initialization of the context on their own."

"Like generic application contexts, web application contexts are hierarchical."

There is a single root context per application, and each subdirectory in the application
(including a Dispatcher component) may optionally have its own child context.
--->
<!---
org.gliint.framework.context.DefaultWebApplicationContext

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
	<cfset variables['properties']['configLocations'] = arrayNew(1) />
	<cfset variables['properties']['displayname'] = "defaultWebApplicationContext" />
	<cfset variables['properties']['identity'] = createUUID() />
	<cfset variables['properties']['namespace'] = false />
	<cfset variables['properties']['parent'] = false />
	<cfset variables['properties']['timestamp'] = now() />

	<cfset this['CONFIG_LOCATION_DELIMITERS'] = "," />

	<!--- name of the root WebApplicationContext --->
	<cfset this['ROOT_WEB_APPLICATION_CONTEXT'] = "root" />

	<!--- name of the ApplicationEventMulticaster bean in the factory --->
	<cfset this['APPLICATION_EVENT_MULTICASTER_BEAN_NAME'] = "simpleApplicationEventMulticaster" />

	<!--- = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = --->

	<cffunction name="init" access="public" returntype="org.gliint.framework.context.DefaultWebApplicationContext" output="false">
		<cfreturn this />
	</cffunction>


	<cffunction name="setBeanFactory" access="public" returntype="void" output="false">
		<cfargument name="beanFactory" required="true" type="coldspring.beans.BeanFactory">
		<cfset variables['properties']['beanFactory'] = arguments.beanFactory />
	</cffunction>


	<!--- from interface ApplicationContext --->
	<cffunction name="setDisplayname" access="public" returntype="void" output="false" >
	<!--- added this setter for convenience even though it's not in the interface --->
		<cfargument name="displayname" type="string" required="true" />
		<cfset variables['properties']['displayname'] = arguments.displayname />
	</cffunction>


	<cffunction name="getDisplayname" access="public" returntype="string" output="false">
		<cfreturn variables['properties']['displayname'] />
	</cffunction>


	<cffunction name="getId" access="public" returntype="any" output="false" hint="Return the unique id of this application context." >
		<cfreturn variables['properties']['identity'] />
	</cffunction>


	<cffunction name="getParent" access="public" returntype="any" output="false">
		<cfreturn variables['properties']['parent'] />
	</cffunction>


	<!--- from interface HierarchicalBeanFactory --->
	<cffunction name="containsLocalBean" access="public" returntype="boolean" output="false">
		<cfargument name="name" type="string" required="true" />
		<cfreturn getBeanFactory().localFactoryContainsBean( arguments.name ) />
	</cffunction>


	<cffunction name="getParentBeanFactory" access="public" returntype="any" output="false" hint="return the parent bean factory, or null if there is none.">
		<cfreturn getParent().getBeanFactory() />
	</cffunction>


	<cffunction name="containsBean" access="public" returntype="boolean" output="false" hint="from interface BeanFactory; does NOT climb the hierarchy, if any, to inspect parents">
		<cfargument name="name" type="string" required="true" />
		<cfreturn getBeanFactory().containsBean( arguments.name ) />
	</cffunction>


	<cffunction name="getBean" access="public" returntype="any" output="false" hint="does NOT climb the hierarchy, if any, to retrieve bean from parents">
		<cfargument name="name" type="string" required="true" />
		<cfreturn getBeanFactory().getBean( arguments.name ) />
	</cffunction>


	<cffunction name="isSingleton" access="public" returntype="boolean" output="false">
		<cfargument name="name" type="string" required="true" />

		<cfset var success = false />

		<cftry>
			<cfset success = getBeanFactory().isSingleton( arguments.name ) />

			<cfcatch type="coldspring.NoSuchBeanDefinitionException">
				<cfif isObject(	getParent() ) >
					<cfset success = getParent().isSingleton( arguments.name ) />
				<cfelse>
					<cfrethrow>
				</cfif>
			</cfcatch>

		</cftry>

		<cfreturn success />
	</cffunction>


	<cffunction name="isPrototype" access="public" returntype="boolean" output="false">
		<cfargument name="name" type="string" required="true" />
		<cfthrow type="Method.NotImplemented">
	</cffunction>


<!--- from interface ApplicationEventPublisher
	/**
	 * Notify all listeners registered with this application of an application
	 * event. Events may be framework events (such as RequestHandledEvent)
	 * or application-specific events.
	 * @param event event to publish
	 * @see org.springframework.web.context.support.RequestHandledEvent
	 */
--->
	<cffunction name="publishEvent" access="public" returntype="void" output="false" hint="Notify all listeners registered with this application of an application event. Events may be framework events (such as RequestHandledEvent) or application-specific events.">
		<cfargument name="event" type="any" required="true" />
		<cfreturn getBean( this['APPLICATION_EVENT_MULTICASTER_BEAN_NAME'] ).multicastEvent( arguments.event ) />
	</cffunction>


<!--- from interface ConfigurableApplicationContext --->
	<cffunction name="addApplicationListener" access="public" returntype="void">
		<cfargument name="listener" type="any" required="true" />
		<cfset getBean( this['APPLICATION_EVENT_MULTICASTER_BEAN_NAME'] ).addApplicationListener( arguments.listener ) />
	</cffunction>


	<cffunction name="getBeanFactory" access="public" returntype="any" output="false">
		<cfreturn variables['properties']['beanFactory'] />
	</cffunction>


	<cffunction name="isActive" access="public" returntype="boolean" output="false">
		<cfif isObject( getBeanFactory() ) >
			<cfreturn true />
		</cfif>
		<cfreturn false />
	</cffunction>


	<cffunction name="refresh" access="public" returntype="void" output="false">
	<!---
	Load or refresh the persistent representation of the configuration,
	which might an XML file, properties file, or relational database schema
	or scanned directories
	--->
		<cfset var c = getConfigLocations() />
		<cfset var size = arrayLen(c) />
		<cfset var i = 1 />
		<cfloop condition="i lte size" >
			<cftrace text="DefaultWebApplicationContext refresh() of #c[i]# starts" />
			<cfset getBeanFactory().loadBeansFromXmlFile( c[i] ) />
			<cftrace text="DefaultWebApplicationContext refresh() of #c[i]# completes" />
			<cfset i = i + 1 />
		</cfloop>
	</cffunction>


	<cffunction name="setParent" access="public" returntype="void" output="false">
		<cfargument name="context" type="org.gliint.framework.context.AbstractWebApplicationContext">
		<cfset variables['properties']['parent'] = arguments.context />
	</cffunction>


<!--- from interface ConfigurableWebApplicationContext --->
	<cffunction name="setConfigLocation" access="public" returntype="void" output="false">
		<cfargument name="location" type="string" required="true" />

		<cfset var i = "" />

		<cfset variables['properties']['configLocations'] = arrayNew(1) />
		<cfif len( arguments.location ) >
			<cfloop list="#arguments.location#" index="i" delimiters="#this['CONFIG_LOCATION_DELIMITERS']#" >
				<cfset arrayAppend( variables['properties']['configLocations'], i ) />
			</cfloop>
		</cfif>

	</cffunction>


	<cffunction name="setConfigLocations" access="public" returntype="void" output="false">
		<cfargument name="locations" type="array" required="true" />
		<cfset variables['properties']['configLocations'] = arguments.locations />
	</cffunction>


	<cffunction name="getConfigLocations" access="public" returntype="array" output="false">
		<cfreturn variables['properties']['configLocations'] />
	</cffunction>


	<cffunction name="setNamespace" access="public" returntype="void" output="false">
		<cfargument name="namespace" type="any" required="true" />
		<cfset variables['properties']['namespace'] = arguments.namespace />
	</cffunction>


	<cffunction name="getNamespace" access="public" returntype="any" output="false">
		<cfreturn variables['properties']['namespace'] />
	</cffunction>

</cfcomponent>