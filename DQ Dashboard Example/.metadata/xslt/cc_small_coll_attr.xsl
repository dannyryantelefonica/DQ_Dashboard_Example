<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
        xmlns:sf="http://www.ataccama.com/xslt/functions"
        xmlns:fn="http://www.w3.org/2005/xpath-functions"
        exclude-result-prefixes="sf fn">
<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>
<xsl:param name="lMAttributeCollContainerOneEntity" select="document('param:lMAttributeCollContainerOneEntity')/*"/>
<xsl:param name="lMAttributeCollContainerMultiEntityParent" select="document('param:lMAttributeCollContainerMultiEntityParent')/*"/>
<xsl:param name="lMAttributeCollContainerMultiEntityChild" select="document('param:lMAttributeCollContainerMultiEntityChild')/*"/>
<xsl:param name="ruleRoot" select="document('param:ruleRoot')/*"/>
<xsl:param name="dqDimensionRoot" select="document('param:dqDimensionRoot')/*"/>
<xsl:param name="defaultRuleRoot" select="document('param:defaultRuleRoot')/*"/>

<xsl:template match="/">
	<xsl:variable name="ruleCode" select="replace(replace(lMAttributeCollContainerOneEntity/@ruleName | lMAttributeCollContainerMultiEntityParent/@ruleName | lMAttributeCollContainerMultiEntityChild/@ruleName,'(.*):\s',''),'([^\s]+)\s\((.*)\)','$1')"/>
	<cc col="{lMAttributeCollContainerOneEntity/@code | lMAttributeCollContainerMultiEntityParent/@code | lMAttributeCollContainerMultiEntityChild/@code}" ruleCode="{replace(replace(lMAttributeCollContainerOneEntity/@ruleName | lMAttributeCollContainerMultiEntityParent/@ruleName | lMAttributeCollContainerMultiEntityChild/@ruleName,'(.*):\s',''),'([^\s]+)\s\((.*)\)','$1')}" ruleName="{$ruleRoot//collectionRulesOptionWrapper/collectionRulesOptionNode/ruleOptionWrapper/*[@code=$ruleCode]/@name | $dqDimensionRoot//dqCollectionRulesOptionWrapper/dqCollectionRulesOptionNode/dqRuleOptionWrapper/*[@code=$ruleCode]/@name | $defaultRuleRoot//collectionRulesOptionWrapper/collectionRulesOptionNode/ruleOptionWrapper/*[@code=$ruleCode]/@name}"/>
		  
</xsl:template>

</xsl:stylesheet>

