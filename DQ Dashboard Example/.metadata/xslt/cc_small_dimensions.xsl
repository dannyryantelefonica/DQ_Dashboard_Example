<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
        xmlns:sf="http://www.ataccama.com/xslt/functions"
        exclude-result-prefixes="sf">
<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>

<xsl:template match="/">
		<cc modelName="{replace(dimensionNode/@column, '([^\.]+)\.([^\.]+)\.([^\.]+)', '$1')}" tableName="{replace(dimensionNode/@column, '([^\.]+)\.([^\.]+)\.([^\.]+)', '$2')}" columnName="{replace(dimensionNode/@column, '([^\.]+)\.([^\.]+)\.([^\.]+)', '$3')}"/>  
</xsl:template>

</xsl:stylesheet>

