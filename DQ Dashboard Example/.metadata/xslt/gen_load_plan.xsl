<?xml version='1.0' encoding='UTF-8'?>
<xsl:stylesheet 
exclude-result-prefixes="sf fn comm" 
xmlns:fn="http://www.w3.org/2005/xpath-functions" 
xmlns:sf="http://www.ataccama.com/xslt/functions" 
xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
xmlns:comm="http://www.ataccama.com/purity/comment" version="2.0">
<xsl:output indent="yes" encoding="UTF-8" method="xml"/>

<xsl:include href="constants_incl.xsl"/>

	<xsl:template match="/*">
		<purity-config version="{$dqd_version}">
			<xsl:for-each select="lMRoot/lMTableWrapper/lMTableNode">
				<step id="{@name}" className="com.ataccama.dqc.tasks.common.usersteps.io.OutputStep" disabled="false" mode="NORMAL">
			        <properties>
			            <requiredColumns>
			            	<xsl:for-each select="lMAttributeWrapper/lMAttributeNode">
			            		<requiredColumns name="{@name}" type="{@type}"/>  
			            	</xsl:for-each>  	
						</requiredColumns>
			        </properties>
			        <visual-constraints bounds="{48+120*position()},48,-1,-1" layout="vertical" />
		    	</step>
			</xsl:for-each>
		</purity-config>
	</xsl:template>
</xsl:stylesheet>