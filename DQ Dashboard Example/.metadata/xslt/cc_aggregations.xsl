<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
        xmlns:sf="http://www.ataccama.com/xslt/functions"
        xmlns:fn="http://www.w3.org/2005/xpath-functions"
        exclude-result-prefixes="sf fn">
<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>
<xsl:param name="parentEntityContainers" select="document('param:parentEntityContainers')/*" />
<xsl:param name="entityRoot" select="document('param:entityRoot')/*" />

	<xsl:template match="/entityContainer">	
	<!--main one aggr-->	
			
		<ccAggregation>
	    	<xsl:attribute name="aggregationCode">
	    		
	    		<!-- <xsl:if test="not(starts-with($parentEntityContainers/ccAggregation/@aggregationCode, $entityRoot/@code))">
	        		<xsl:value-of select="$entityRoot/@code"/>
	        	</xsl:if>-->	        	
	        	<xsl:value-of select="$parentEntityContainers/ccAggregation/@aggregationCode" />
	        	<xsl:for-each select="reverse($parentEntityContainers)">
	        	</xsl:for-each>
	        	<xsl:text>.</xsl:text>
	        	<xsl:value-of select="@name" /> 
      		</xsl:attribute>
<!--       		<xsl:copy-of select="$parentEntityContainers"/> -->
		</ccAggregation>
    <!--main one aggr--> 
     
	</xsl:template>
</xsl:stylesheet>

