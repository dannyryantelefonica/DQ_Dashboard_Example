<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
        xmlns:sf="http://www.ataccama.com/xslt/functions"
        exclude-result-prefixes="sf">
<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>
<xsl:param name="preferenceRoot" select="document('param:preferenceRoot')/*"/>
<xsl:param name="dataSources" select="document('param:dataSources')/*"/>
	<xsl:template match="/">

<runtimeconfig>
		<!--
	  Configuration for named url resources (used in steps like Soap Call, etc.)
	-->
	<contributedConfigs>
	<!--
	    <config class="com.ataccama.dqc.processor.support.UrlResourceContributor">
	    <!- - Optional authorization: user, password - ->
	      <urls>
		<url name="localhost" url="localhost:7777" user="test" password="crypted:DES:NsuAku14ipInv4Z7FZAFKRjAVIxjqxmTpX8HwSTGUlE=" />
	      </urls>
	    </config>
	-->
	</contributedConfigs>


<!-- List of database connection definitions.
	  These optional attributes are available (configuration of the pooling behaviour):
                 -  minSize
                 -  maxAge
                 -  maxIdleSize	 
	-->
	<dataSources>
		<!--
		  name		  - unique identifier of the data source connection.
		  url		  - connection string to data source (JDBC)
		  driverClass - java class name of the driver used for connection (JDBC)
		  user		  - name of the data source user (DB schema)
		  password	  - password used for data source connection
		  minSize	  - minimum number of connections in the connection pool
		  maxAge	  - if the connection is not used for specified time (in miliseconds) the connection will be closed
		-->

		<!-- <xsl:for-each select="$dataSources/dataSource[@name=$preferenceRoot/@datamart]">  = alternative where only datamart connection is generated to runtimeConfig-->
		<xsl:for-each select="$dataSources/dataSource"> 
			<dataSource name="{@name}" driverclass="{@driverClass}" user="{@user}" password="{@password}" url="{@url}"/>
		</xsl:for-each>

	</dataSources>
	<!--
	  Bellow you can define path variables. You can use path variables in configuration files like 
	  configuration plans as shortcuts to folders which may be on each system on different path location.
	-->
	<pathVariables>
		<pathVariable name="EXT" value="../data/ext"/>
		<pathVariable name="DATA" value="../data"/>
		<pathVariable name="DATA_IN" value="../data/in"/>
	</pathVariables>

	<parallelismLevel>1</parallelismLevel>
	<!--
	<loggingConfig>runtimeConfigLogging.xml</loggingConfig>
	-->
</runtimeconfig>

	</xsl:template>
</xsl:stylesheet>
