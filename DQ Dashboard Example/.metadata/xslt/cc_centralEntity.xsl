<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
        xmlns:sf="http://www.ataccama.com/xslt/functions"
        exclude-result-prefixes="sf">
<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>
<xsl:param name="lMRoot" select="document('param:lMRoot')/*"/> 

	<xsl:template match="/">	
	
		<centralEntityNode centralEntity="{string(not(lMTableNode/@name = $lMRoot/lMRelationshipWrapper/lMRelationshipNode/@childTable))}"/>
		
	</xsl:template>
</xsl:stylesheet>

