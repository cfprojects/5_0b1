<cfcomponent displayname="AbstractWebApplicationContext" extends="coldspring.context.AbstractApplicationContext" output="false">
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
org.gliint.framework.context.AbstractWebApplicationContext

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
	<cfset variables['properties']['identity'] = createUUID() />
	<cfset variables['properties']['timestamp'] = now() />
	<cfset variables['properties']['displayname'] =	"" />
	<cfset variables['properties']['beanFactory'] = false />
	<cfset variables['properties']['parent'] = false />


	<cfset variables['properties']['CONFIG_LOCATION_DELIMITERS'] = "," />
	<cfset variables['properties']['configLocations'] = arrayNew(1) />

	<!--- name of the root WebApplicationContext --->
	<cfset variables['properties']['ROOT_WEB_APPLICATION_CONTEXT'] = "" />

	<!--- name of the ApplicationEventMulticaster bean in the factory --->
	<cfset variables['properties']['APPLICATION_EVENT_MULTICASTER_BEAN_NAME'] = "" />

	<!--- = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = --->

	<cffunction name="init" access="private" output="false">
		<cfthrow type="Method.NotImplemented">
	</cffunction>


	<!--- from interface ApplicationContext --->
	<cffunction name="getDisplayname" access="public" returntype="string" output="false">
		<cfthrow type="Method.NotImplemented">
	</cffunction>

	<cffunction name="getId" access="public" returntype="string" output="false">
		<cfthrow type="Method.NotImplemented">
	</cffunction>

	<cffunction name="getParent" access="public" returntype="org.gliint.framework.context.AbstractWebApplicationContext" output="false">
		<cfthrow type="Method.NotImplemented">
	</cffunction>


<!--- from interface HierarchicalBeanFactory --->
	<cffunction name="containsLocalBean" access="public" returntype="boolean" output="false">
		<cfargument name="name" type="string" required="true" />
		<cfthrow type="Method.NotImplemented">
	</cffunction>


	<cffunction name="getParentBeanFactory" access="public" returntype="any" output="false">
		<cfthrow type="Method.NotImplemented">
	</cffunction>


<!--- from interface BeanFactory --->
	<cffunction name="containsBean" access="public" returntype="boolean" output="false">
		<cfargument name="name" type="string" required="true" />
		<cfthrow type="Method.NotImplemented">
	</cffunction>


	<cffunction name="getBean" access="public" returntype="any" output="false">
		<cfargument name="name" type="string" required="true" />
		<cfthrow type="Method.NotImplemented">
	</cffunction>


	<cffunction name="isSingleton" access="public" returntype="boolean" output="false">
		<cfargument name="name" type="string" required="true" />
		<cfthrow type="Method.NotImplemented">
	</cffunction>


	<cffunction name="isPrototype" access="public" returntype="boolean" output="false">
		<cfargument name="name" type="string" required="true" />
		<cfthrow type="Method.NotImplemented">
	</cffunction>


<!--- from interface ApplicationEventPublisher --->
	<cffunction name="publishEvent" access="public" returntype="void" output="false">
		<cfargument name="event" type="any" required="true" />
		<cfthrow type="Method.NotImplemented">
	</cffunction>


<!--- from interface ConfigurableApplicationContext --->
	<cffunction name="addApplicationListener" access="public" returntype="void" output="false">
		<cfargument name="listener" type="any" required="true" />
		<cfthrow type="Method.NotImplemented">
	</cffunction>


	<cffunction name="getBeanFactory" access="public" returntype="any" output="false">
		<cfthrow type="Method.NotImplemented">
	</cffunction>


	<cffunction name="isActive" access="public" returntype="boolean" output="false">
		<cfthrow type="Method.NotImplemented">
	</cffunction>


	<cffunction name="refresh" access="public" returntype="void" output="false">
		<cfthrow type="Method.NotImplemented">
	</cffunction>


	<cffunction name="setParent" access="public" returntype="void" output="false">
		<cfargument name="context" type="org.gliint.framework.context.AbstractWebAbstractApplicationContext">
		<cfthrow type="Method.NotImplemented">
	</cffunction>


<!--- from interface ConfigurableWebApplicationContext --->
	<cffunction name="setConfigLocation" access="public" returntype="void" output="false">
		<cfargument name="location" type="string" required="true" />
		<cfthrow type="Method.NotImplemented">
	</cffunction>


	<cffunction name="setConfigLocations" access="public" returntype="void" output="false">
		<cfargument name="locations" type="array" required="true" />
		<cfthrow type="Method.NotImplemented">
	</cffunction>


	<cffunction name="getConfigLocations" access="public" returntype="array" output="false">
		<cfthrow type="Method.NotImplemented">
	</cffunction>


	<cffunction name="setNamespace" access="public" returntype="void" output="false">
		<cfargument name="namespace" type="string" required="true" />
		<cfthrow type="Method.NotImplemented">
	</cffunction>


	<cffunction name="getNamespace" access="public" returntype="string" output="false">
		<cfthrow type="Method.NotImplemented">
	</cffunction>

</cfcomponent>