<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
        xmlns:sf="http://www.ataccama.com/xslt/functions"
        exclude-result-prefixes="sf">
<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>
	<xsl:template match="/">
	


<server>
	<!--
	  Internal communication port. It is used the server is being stopped, or when asking for 
	  server status, etc...
	-->
	<port>7799</port>
	
  	<!-- List of folders used for storage of temporary files. -->
	<!-- 
	<tempFolders>
		<tempFolder path="/tmp" />
	</tempFolders>
	-->

	<!--
	  Runtime configuration defines shared resources like Data Source connections (DB) and Path Variables.
	  Path to the runtimeConfiguration can be either absolute or relative. When the path is relative then it is 
	  calculated against the folder containing the serverConfig.xml file.

	  Runtime configuration can be changed from the server-side. 
	  In such case the changes are written down to the original runtimeConfiguration definition file (attributes 
	  not used in the server are preserved/not changed).
	-->
	<runtimeConfiguration>dqd.runtimeConfig</runtimeConfiguration>
	      	
	<!--
	  List of components deployed in the online server. Components are started in order of 
	  appearance in this configuration file. Some components require to be started before other
	  can use them, so be careful to put them in correct order.
	-->
	<serverComponents>
		
		<!--
		  Logging component is used to inject the logging configuration to the server.
		  In relation to runtimeConfiguration, the order of logging configuration processing is following:
		  1) if the 'configFile' attribute is defined on the LoggingComponent then it is used
		     (and overrides possible logging configuration from the runtimeConfiguration)
		  2) if 'configFile' is not defined or points to the invalid/unparsable logging configuration, then logging 
		    configuration defined in the runtimeConfiguration is used  
		  3) if logging configuration is not defined in the runtimeConfiguration, the default logging setup is used 

		  If the LoggingComponent is not defined in the server configuration, the server implicitly uses configuration 
		  specified in the runtimeConfiguration. The logging component then only brings some additional features, such as:
		  - logging health monitoring in the console
		  - ability to modify logging setup via console 
		    (it is ensured that proper logging configuration file is updated after change)
		-->
		<!--
      <component class="com.ataccama.dqc.web.logging.LoggingComponent" configFile="logging.xml"/>
    -->
	
		<!--
		  Basic component that enables the communication by HTTP protocol and responds to HTTP 
		  requests. The component is required by many others which register themselves into 
		  HttpDispatcher on a specified URL path so the HttpDispatcher may redirect handling of 
		  requests.
		  It is also possible to define filters and their mapping for URLs. Filters will be applied 
		  on the incoming HTTP requests before they will invoke the service itself.
		  - The listeners section is used to define listener threads that will receive requests on
		    specified TCP ports and specify if the listener should communicate via SSL or not.
		  - In the filters section you can define parameters for individual filters. Of course it 
		    is possible to define several filters of the same type (f.e. different loggers).
		  - In the mappings section, there is defined mapping of the filters to the request path. In case
		    there are several filters mapped to some location, they will be executed in the order of 
		    appearance in the mapping section.
		  - In workerQueues section it is possible to define dedicated worker threads for incoming
		    requests. All requests that meet the URL pattern and listener defined in the mappings
		    section will be handled by the queue defined. It is possible to set the number of threads
		    that will handle the requests, maximum size of the queue of requests waiting for the 
		    thread, maximum time each request may wait for the thread and how long
		    it should wait until the worker queue is killed when the server is going to shutdown. 
		-->
		<component class="com.ataccama.dqc.web.HttpDispatcher">
			<listeners>
				<listener name="default" port="8888" threads="10" ssl="false" />
				<!--
				<listener name="console" port="8887" threads="5" ssl="false" />
				<listener name="ssl" port="443" threads="10" ssl="true" keyStoreFile="c:\keystore" keyStorePassword="secret"/>
				-->
			</listeners>
			<!-- 
			<filters>
				<filterDef>
					<filter name="MyRequestLog" class="com.ataccama.dqc.web.filters.RequestResponseTimeLogger">
						<headers>
							<header>soapAction</header>
							<header>host</header>
						</headers>
						<level>INFO</level>
						<appendClientInfo>false</appendClientInfo>
					</filter>
				</filterDef>
				<filterDef>
				    <filter class="com.ataccama.dqc.web.filters.LoggingFilter"> 
				    	<logFile>../logs/request.log</logFile>
				    	<maxRequestLogSize>10000</maxRequestLogSize>
				    	<maxResponseLogSize>10000</maxResponseLogSize>
				    	<appendLog>false</appendLog>
				    </filter>
					<mappings>
						<mapping listeners="default,ssl" urlPattern="/"/>
					</mappings>
			 </filterDef>
			 <filterDef>
				<filter class="com.ataccama.dqc.web.filters.RequiredRoleFilter">
						<requiredRole>admin</requiredRole>
					</filter>
					<mappings>
						<mapping listeners="default" urlPattern="/console"/>
					</mappings>
				</filterDef>
			</filters>
			<workerQueues>
				<worker name="myQueue" maxQueueSize="10" threadNumber="5" timeout="5000" shutdownTimeout="10000" 
						healthStateRefreshRate="60000" healthStateRecoveryTimeout="3600000">
					<mappings>
						<mapping listeners="default" urlPattern="/"/>
					</mappings>
				</worker>
			</workerQueues>
			-->
		</component>

	   <!-- 
	    JmsProviderComponent is needed to define JMS connections and filters that should be applied
	    during connections. The connections section contains the definition of connection to 
	    the JMS server. The name attribute defines the identifier that will be used in references 
	    to the connection definition.

	    There are several messaging providers available (sample configurations shown below): MQ, Tibco, WebSphere.
	
	    The filters section (optional) contains filter definitions and their mapping to connections and input 
	    or output destinations. The following filters are available:
	        com.ataccama.dqc.jms.filters.JmsLoggingFilter
	           - logs contents of the request/response to a file
	        com.ataccama.dqc.jms.filters.JmsResponseTimeLogger
		   - logs request processing time to the logger
		   
	    Authorization options:	
	     - optional authorization on the connection level: specified in userName, password attributes (both unencrypted/encrypted forms are possible for password)
	     - optional authorization on the context level (used for search in JNDI registry): specified in java.naming.security.principal, java.naming.security.credentials parameters
	-->
	<!--
	     MQ:
	-->
	<!--
		<component class="com.ataccama.dqc.jms.JmsProviderComponent">
			<connections>
				<connection name="ActiveMQ" connectionFactory="ConnectionFactory" userName="user" password="crypted:DESede:666XoDDgpwqug9C+4Y0nfQyaYvyjTSyMaCrH6K/d4NE=">
					<contextParams>
						<param name="java.naming.factory.initial" value="org.apache.activemq.jndi.ActiveMQInitialContextFactory"/>
						<param name="java.naming.provider.url" value="tcp://localhost:61616"/>
						<param name="java.naming.security.principal" value="principal"/>
						<param name="java.naming.security.credentials" value="secret"/>
					</contextParams>
				</connection>
			</connections>
			<filters>
			<!- -
				<filter>
					<filter class="com.ataccama.dqc.jms.filters.JmsLoggingFilter">
						<logFile>request.log</logFile>
						<maxRequestLogSize>10000</maxRequestLogSize>
						<maxResponseLogSize>10000</maxResponseLogSize>
						<appendLog>false</appendLog>
					</filter>
					<mappings>
						<mapping connection="ActiveMQ" destination="MQ_in1"/>
					</mappings>
				</filter>
			- ->
			</filters>
		</component>
	-->

	<!--
	     Tibco:
	-->
	<!--
		<component class="com.ataccama.dqc.jms.JmsProviderComponent">
			<connections>
				<connection name="Tibco" connectionFactory="QueueConnectionFactory" userName="user" password="crypted:DESede:666XoDDgpwqug9C+4Y0nfQyaYvyjTSyMaCrH6K/d4NE=">
					<contextParams>
						<param name="java.naming.factory.initial" value="com.tibco.tibjms.naming.TibjmsInitialContextFactory"/>
						<param name="java.naming.provider.url" value="tcp://localhost:7222"/>
						<param name="java.naming.security.principal" value="principal"/>
						<param name="java.naming.security.credentials" value="secret"/>
					</contextParams>
				</connection>
			</connections>
			<filters>
			</filters>
		</component>
	-->
    
 
		<!--
		  Provides the requests by the identity of the request originator. The component may be used
		  for internal communication requests as well as for requests going to web service port. In 
		  the second case you have to use FilterComponent and Authorization filter.
		  AuthorizationService may have defined several different authentication methods. For 
		  identity resolution are asked all defined methods one by one until one of them returns 
		  some identity. Therefore it is important to put the methods in correct order.   
		-->
		<component class="com.ataccama.dqc.server.services.AuthenticationService">
			<methods>
				<!-- Uncomment the following element for password-protected access -->
				<!--
				  PasswordServerMethod provides the identity based on the username and password. You
				  can use different identity providers for different kind of sources, like LDAP and files, etc. 				  database, files, etc.   
				-->
				<!--
				<method class="com.ataccama.dqc.communication.auth.server.PasswordServerMethod">
					<!- -
					  FileBasedIdentityProvider reads identity definitions from the specified file.
					  The file contains list of users, their passwords and roles which will be 
					  assigned to the user. Roles may be assigned also based on IP address of the
					  client.
					- ->
					<provider class="com.ataccama.dqc.communication.auth.server.FileBasedIdentityProvider">
						<configFile>users.xml</configFile>
					</provider>
				</method>
				-->
				
				<!--
				  Use the TrustServerMethod if you don't need to check the identity and you always 
				  want to assign the same identity as defined in the 'identity' element
				-->
				<!--
				<method class="com.ataccama.dqc.communication.auth.server.TrustServerMethod">
					<identity class="com.ataccama.dqc.communication.auth.server.TrustIdentity">
						<name>Trusted Joseph</name>
					</identity>
				</method>
				-->

				<!--
				  SecretServerMethod can be used only for internal communication. It is the very 
				  simple method which assigns always the same defined identity to the requests which
				  will send correct secret passphrase.    
				-->
				<!--
				<method class="com.ataccama.dqc.communication.auth.server.SecretServerMethod">
					<secret>secret_word</secret>
					<identity class="com.ataccama.dqc.communication.auth.server.StandardIdentity">
						<name>Secret Joseph</name>
						<roles>
							<role>users</role>
							<role>admin</role>
						</roles>
					</identity>
				</method>
				-->
			</methods>
			
			<!--
			  Role mapping provider is good to assign additional roles based on client's IP address 
			  and/or combination of already assigned roles.
			-->
			<!--
      <roleMappingProvider class="com.ataccama.dqc.communication.auth.server.FileRoleMapping">
				<configFile>role-mapping.xml</configFile>
			</roleMappingProvider>
      -->
		</component>

		<!--
		  The following part enables access to Derby database.
		-->
		<!--
		<component class="com.ataccama.server.component.derby.DerbyServerComponent">
			<port>1527</port>
			<dataDir>../storage/derby</dataDir>
		</component>
		-->
	
		<!--
		  The following part enables access to server filesystem from the GUI. 
		  This component defines root folders for the remote filesystem (at least one root must be defined).
		  Defined paths:
		  - are not restricted any way (e.g. you can refer to c:/) 
		  - can be defined either as absolute or relative ones. If the path is relative then it is resolved against the 
		  server's default path (folder which contains serverConfig.xml)
		  - path variables from the runtime configuration are supported
		-->
		<!--		
		<component class="com.ataccama.dqc.server.services.ServerFilesystemServiceComponent">
			<roots>
				<root>d:/opt</root>
				<root>pathvar://data/ext</root>
			</roots>
		</component>
		-->
		
		<!--
		  HealthStateProviders component adds several sensors that will report health status 
		  of the server's parts such as the path variables and database connections.
		-->
		<component class="com.ataccama.dqc.server.services.HealthStateProviders" 
				pathVariableRefreshRate="60" dataSourceRefreshRate="60"/>
		
		<!--
		  The following part enables the WebConsole component. Currently it has no parameters.
		  The OnlineServicesComponent requires the HttpDispatcher component to be started.
		-->
		<component class="com.ataccama.dqc.web.console.WebConsoleComponent"/>

		<!--
		  HealthStateWebConsole component adds section to the web console that will display 
		  all server's health sensor statuses.
		-->
		<component class="com.ataccama.dqc.web.health.HealthStateWebConsole"/>
		
		<!--
		  VersionedFileSystemComponent is used to monitor configuration file changes in order to be
		  able to reload the new configuration without restarting of the server. Just put the path
		  to the folder that should be monitored to 'versionedFolder' section. 
		-->		
    <!-- 		
    <component class="com.ataccama.dqc.server.services.VersionedFileSystemComponent">
			<versionedFolders>
				<versionedFolder>../services/data1</versionedFolder>
				<versionedFolder>../services/data2</versionedFolder>
			</versionedFolders>
		</component>
		-->
		<!--
		  OnlineServicesComponent will start configurations and expose them as web services. The 
		  component has one parameter and that is the configuration folder where are location 
		  *.online files which contains definition of online services. All *.online files from that
		  configuration folder will be processed and the defined services started.
		  
		  The OnlineServicesComponent requires the HttpDispatcher component to be started.
		  
		  If you need more folders to be monitored for changes add folder paths to 'versionedFolders'
		  section. If you don't need any additional folders, you can leave it empty or remove the
		  'versionedFolders' section.
		
		<component class="com.ataccama.dqc.online.OnlineServicesComponent">
			<serviceLookupFolders>
				<configFolder>../services</configFolder>
			</serviceLookupFolders>
		</component>
-->
		<!--
		  The following part enables workflow component; multiple sources of workflow can be defined.
		  Each source/path points where .ewf files are stored.
		-->
		<!--
		<component class="com.ataccama.adt.web.WorkflowServerComponent">
			<sources>
				<source>
					<path>..\workflows\workflow1</path> 
					<id>WF1</id> 
				</source>
				<source>
					<path>..\workflows\workflow2</path>
					<id>WF2</id>
				</source>
			</sources>
    <!- -
			<resourcesConfiguration>
				<resources>
					<resource id="db-oracle" units="4" name="DB Oracle (connections)"/>
					<resource id="cpu" units="16" name="CPU usage (cores)" />
					<resource id="memory" units="1000" name="Memory (MB)" />
					<resource id="storage" name="Storage device (MB)" />
				</resources>
			</resourcesConfiguration>
			- ->
			<resourcesFolder>..\workflows\resources</resourcesFolder>
			<stateStorageProvider class="com.ataccama.adt.runtime.state.storage.FileStateStorageProvider"/>         
			 <!- -
			 <stateStorageProvider class="com.ataccama.adt.runtime.state.storage.DbStateStorageProvider">
			    <dialectFile>../../db/modules/oracle</dialectFile>
					<dataSource>oracle</dataSource>
					<prefix>WF_</prefix>
			 </stateStorageProvider>
			 - ->
		 </component>
		-->

		<!--
		  The following part enables scheduler component; multiple sources of scheduler can be defined.
		  Each source/path points where .sch files are stored.
		-->
		<!--
		<component class="com.ataccama.adt.scheduler.server.SchedulerServerComponent">
			<sources>
				<source>
					<path>../scheduler/schedules</path>
					<id>S1</id>  
				</source>
	   			<source> 
					<path>../scheduler/schedules2</path> 
					<id>S2</id> 
				</source>
			</sources>
			<resourcesFolder>../scheduler/resources</resourcesFolder>
			<resultPersister class="com.ataccama.adt.scheduler.persister.FileStateResultPersister"/>  
			 <!- -
			 <resultPersister class="com.ataccama.adt.scheduler.persister.DbStateResultPersister">
				<dialectFile>../../db/modules/pgsql</dialectFile>
				<dataSource>db-postgres</dataSource>
			</resultPersister>
			- ->
		 </component>
		-->



		<component class="com.ataccama.dqd.engine.DqdServerComponent">
			<configFile>dqd-config.xml</configFile>
		</component>
		
		
		


	</serverComponents>
</server>	
	
	
	
	
	
	</xsl:template>
</xsl:stylesheet>	
	

