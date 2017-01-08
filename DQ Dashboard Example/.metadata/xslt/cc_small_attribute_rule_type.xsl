<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
        xmlns:sf="http://www.ataccama.com/xslt/functions"
        xmlns:fn="http://www.w3.org/2005/xpath-functions"
        exclude-result-prefixes="sf fn">
<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>
<xsl:param name="lMAttributeCollContainerOneEntity" select="document('param:lMAttributeCollContainerOneEntity')/*"/>
<xsl:param name="lMAttributeCollContainerMultiEntityParent" select="document('param:lMAttributeCollContainerMultiEntityParent')/*"/>
<xsl:param name="lMAttributeCollContainerMultiEntityChild" select="document('param:lMAttributeCollContainerMultiEntityChild')/*"/>
<xsl:param name="defaultRuleRoot" select="document('param:defaultRuleRoot')/*"/>
<xsl:param name="ruleRoot" select="document('param:ruleRoot')/*"/>
<xsl:param name="dqDimensionRoot" select="document('param:dqDimensionRoot')/*"/>
<xsl:param name="lMTableNode" select="document('param:lMTableNode')/*"/>

<xsl:template match="/">
		<xsl:variable name="ruleCode" select="$lMAttributeCollContainerOneEntity/cc/@ruleCode"/>
		<xsl:variable name="ruleCodeMultiParent" select="$lMAttributeCollContainerMultiEntityParent/cc/@ruleCode"/>
		<xsl:variable name="ruleCodeMultiChild" select="$lMAttributeCollContainerMultiEntityChild/cc/@ruleCode"/>
		<xsl:variable name="ruleColumnCode" select="lMAttributeCollNode/@ruleAttMapping"/>
		<xsl:variable name="ruleChildColumnCode" select="lMAttributeChildCollNode/@ruleAttMapping"/>
		<xsl:variable name="attName" select="lMAttributeCollNode/@attName"/>
		<xsl:variable name="attChildName" select="lMAttributeChildCollNode/@attName"/>
		
		<cc ruleType="{
					$defaultRuleRoot//collectionRulesOptionWrapper/collectionRulesOptionNode/ruleOptionWrapper/*[@code=$ruleCode or 
																												@code=$ruleCodeMultiParent or
																												@code=$ruleCodeMultiChild]//ruleColumnNode[@name=$ruleColumnCode or @name=$ruleChildColumnCode]
																										/@type | 
					$dqDimensionRoot/*//dqCollectionRulesOptionWrapper/dqCollectionRulesOptionNode/dqRuleOptionWrapper/*[@code=$ruleCode or 
																														@code=$ruleCodeMultiParent or 
																														@code=$ruleCodeMultiChild]//ruleColumnNode[@name=$ruleColumnCode or @name=$ruleChildColumnCode]
																													/@type | 
					$ruleRoot//collectionRulesOptionWrapper/collectionRulesOptionNode/ruleOptionWrapper/*[@code=$ruleCode or 
																											@code=$ruleCodeMultiParent or 
																											@code=$ruleCodeMultiChild]//ruleColumnNode[@name=$ruleColumnCode or @name=$ruleChildColumnCode]
																										/@type |
					$defaultRuleRoot//collectionRulesOptionWrapper/collectionRulesOptionNode/ruleOptionWrapper/copyRulesNode[@code=$ruleCode or 
																												@code=$ruleCodeMultiParent or
																												@code=$ruleCodeMultiChild]/@inputColumnType |
					$dqDimensionRoot/*//dqCollectionRulesOptionWrapper/dqCollectionRulesOptionNode/dqRuleOptionWrapper/copyRulesNode[@code=$ruleCode or 
																												@code=$ruleCodeMultiParent or
																												@code=$ruleCodeMultiChild]/@inputColumnType |
					$ruleRoot//collectionRulesOptionWrapper/collectionRulesOptionNode/ruleOptionWrapper/copyRulesNode[@code=$ruleCode or 
																												@code=$ruleCodeMultiParent or
																												@code=$ruleCodeMultiChild]/@inputColumnType
																										}"
																										
		attType="{$lMTableNode/lMAttributeWrapper/lMAttributeNode[@name=$attName or @name=$attChildName]/@type}"/>
		  
</xsl:template>

</xsl:stylesheet>

