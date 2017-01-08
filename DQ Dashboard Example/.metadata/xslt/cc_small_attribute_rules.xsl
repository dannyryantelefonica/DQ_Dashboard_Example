<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
        xmlns:sf="http://www.ataccama.com/xslt/functions"
        exclude-result-prefixes="sf">
<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>
<xsl:param name="ruleRoot" select="document('param:ruleRoot')/*"/>
<xsl:param name="dqDimensionRoot" select="document('param:dqDimensionRoot')/*"/>
<xsl:param name="defaultRuleRoot" select="document('param:defaultRuleRoot')/*"/>

<xsl:template match="/">
		<xsl:variable name="ruleCode" select="replace(replace(lMAttributeNode/@ruleName,'(.*):\s',''),'([^\s]+)\s\((.*)\)','$1')"/>
		<cc col="{lMAttributeNode/@name}" ruleCode="{replace(replace(lMAttributeNode/@ruleName,'(.*):\s',''),'([^\s]+)\s\((.*)\)','$1')}" ruleName="{$ruleRoot//collectionRulesOptionWrapper/collectionRulesOptionNode/ruleOptionWrapper/*[@code=$ruleCode]/@name | $dqDimensionRoot//dqCollectionRulesOptionWrapper/dqCollectionRulesOptionNode/dqRuleOptionWrapper/*[@code=$ruleCode]/@name | $defaultRuleRoot//collectionRulesOptionWrapper/collectionRulesOptionNode/ruleOptionWrapper/*[@code=$ruleCode]/@name}">
		<xsl:attribute name="hasRule">
			<xsl:choose>
				<xsl:when test="lMAttributeNode/@ruleName!=''">true</xsl:when>
				<xsl:otherwise>false</xsl:otherwise>
			</xsl:choose>
		</xsl:attribute>  
		</cc>
</xsl:template>
<!-- 
replace(lMAttributeNode/@ruleName, '\s(.*)', '')

replace(lMAttributeNode/@ruleName, '([^\s]+)\s\((.*)\)', '$2')-->

</xsl:stylesheet>

