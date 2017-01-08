<?xml version='1.0' encoding='UTF-8'?>
<xsl:stylesheet exclude-result-prefixes="sf" xmlns:sf="http://www.ataccama.com/xslt/functions" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:fn="http://www.w3.org/2005/xpath-functions" version="2.0">
<xsl:output indent="yes" encoding="UTF-8" method="xml" version="1.0"/>

<xsl:param name="fileName"/>
<xsl:variable name="pattern" select="concat('EXP_',replace($fileName,'.comp$',''))" />

    <!-- <xsl:template match="/">
    	<xsl:variable name="search" select="concat('exp_',replace(replace($filename,'^.*__',''),'.comp',''))"/>
    	<xsl:variable name="replace" select="'result'"/>
        <xsl:analyze-string select="." regex="{$search}">
            <xsl:matching-substring><xsl:value-of select="$replace"/></xsl:matching-substring>
            <xsl:non-matching-substring><xsl:value-of select="."/></xsl:non-matching-substring>
        </xsl:analyze-string>

    </xsl:template>-->
    
	<xsl:template match="*|processing-instruction()">
		<xsl:copy>
			<xsl:apply-templates select="*|@*|text()|processing-instruction()|comment()"/>
		</xsl:copy>
 	</xsl:template>
 	
 	<xsl:template match="text()">
		<xsl:value-of select="replace(., $pattern , 'result')"/>
 	</xsl:template>
 	
 	<xsl:template match="comment()">
		<xsl:comment>
			<xsl:value-of select="replace(., $pattern , 'result')"/>
		</xsl:comment>
 	</xsl:template>
 	
 	<xsl:template match="@*">
 		<xsl:attribute name="{fn:name(.)}">
			<xsl:value-of select="replace(., $pattern , 'result')"/>
		</xsl:attribute>
 	</xsl:template>
 	
</xsl:stylesheet>