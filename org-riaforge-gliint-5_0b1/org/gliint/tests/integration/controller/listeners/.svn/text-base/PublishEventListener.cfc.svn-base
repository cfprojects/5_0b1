<cfcomponent displayname="PublishEventListener" extends="org.gliint.framework.context.BaseApplicationListener" output="false">

	<cffunction name="onApplicationEvent" access="public" returntype="void" output="false">
		<cfargument name="event" type="struct" required="true" />
		<cfparam name="arguments.event.count" type="numeric" default="0" />
		<cfset arguments.event.count = arguments.event.count + 1 />
		<cfset arguments.event['listener' & arguments.event.count] = "listener#arguments.event.count# is here" />
	</cffunction>

</cfcomponent>