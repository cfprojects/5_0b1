<cfcomponent output="false" extends="mxunit.framework.TestSuite">
	<!--- these tests MUST be performed in the sequence below --->
	<cfscript>
		// first test the classes that derive from spring
//		dispatcher tests are really integration tests - need mocks
//		addAll("org.gliint.tests.framework.DispatcherTest");
		addAll("org.gliint.tests.framework.HandlerAdapterTest");
		addAll("org.gliint.tests.framework.HandlerExecutionChainTest");
		addAll("org.gliint.tests.framework.context.AbstractWebApplicationContextTest");
		addAll("org.gliint.tests.framework.context.BaseApplicationListenerTest");
		addAll("org.gliint.tests.framework.context.ContextLoaderTest");
		addAll("org.gliint.tests.framework.context.DefaultWebApplicationContextTest");
		addAll("org.gliint.tests.framework.context.event.SimpleApplicationEventMulticasterTest");
//		addAll("org.gliint.tests.framework.context.util.ApplicationContextUtilsTest");
		addAll("org.gliint.tests.framework.handler.BaseHandlerInterceptorTest");
		addAll("org.gliint.tests.framework.handler.mapping.BaseHandlerMappingTest");
		addAll("org.gliint.tests.framework.handler.mapping.SimpleHandlerMappingTest");
		addAll("org.gliint.tests.framework.handler.NopHandlerTest");


		addAll("org.gliint.tests.framework.command.CommandTest");
		addAll("org.gliint.tests.framework.command.CommandFactoryTest");
		addAll("org.gliint.tests.framework.connector.BaseConnectorTest");
		addAll("org.gliint.tests.framework.connector.HTTPConnectorTest");
		addAll("org.gliint.tests.framework.command.CommandContextTest");
		addAll("org.gliint.tests.framework.handler.mapping.GliintCommandHandlerMappingTest");
		addAll("org.gliint.tests.framework.handler.BaseCommandHandlerTest");
//	addAll("org.gliint.tests.framework.handler.ResponseInterceptorTest");
//		addAll("org.gliint.tests.framework.handler.RuleInterceptorTest");
		addAll("org.gliint.tests.framework.GliintControllerTest");
	</cfscript>
</cfcomponent>