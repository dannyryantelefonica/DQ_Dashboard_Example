<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
        xmlns:sf="http://www.ataccama.com/xslt/functions"
        xmlns:fn="http://www.w3.org/2005/xpath-functions"
        exclude-result-prefixes="sf fn">
<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>
<xsl:param name="lMRoot" select="document('param:lMRoot')/*"/>
<xsl:param name="lMRelationshipNode" select="document('param:lMRelationshipNode')/*"/>
<xsl:param name="lMForeignKeyNode" select="document('param:lMForeignKeyNode')/*"/>
	<xsl:template match="/">		
		<xsl:variable name="childTable" select="$lMRelationshipNode/@childTable"/>
		<xsl:variable name="parentTable" select="$lMRelationshipNode/@parentTable"/>
		<xsl:variable name="childColumn" select="$lMForeignKeyNode/@childColumn"/>
		<xsl:variable name="parentColumn" select="$lMForeignKeyNode/@parentColumn"/>
		
		<cc childType="{$lMRoot/lMTableWrapper/lMTableNode[@name=$childTable]/lMAttributeWrapper/lMAttributeNode[@name=$childColumn]/@type}" parentType="{$lMRoot/lMTableWrapper/lMTableNode[@name=$parentTable]/lMAttributeWrapper/lMAttributeNode[@name=$parentColumn]/@type}"/>		  
	</xsl:template>

</xsl:stylesheet>

