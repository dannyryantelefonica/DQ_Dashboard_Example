<?xml version='1.0' encoding='UTF-8'?>
<xsl:stylesheet exclude-result-prefixes="sf" xmlns:sf="http://www.ataccama.com/xslt/functions" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">
<xsl:output indent="yes" encoding="UTF-8" method="xml" version="1.0"/>

<xsl:include href="constants_incl.xsl"/>

	<xsl:template match="/">	
	
		<versionNode version="{$dqd_version}"/>
		
	</xsl:template>
</xsl:stylesheet>