<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:sf="http://www.ataccama.com/xslt/functions"
	exclude-result-prefixes="sf">
		<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>	

	<xsl:template match="node()|@*">
		<xsl:copy>
			<xsl:apply-templates select="node()|@*"/>
		</xsl:copy>
	</xsl:template>

	<xsl:template match="text()">
		<xsl:value-of select="."/>
	</xsl:template>

	<xsl:template match="/">
		<defaultRuleRoot ruleType="Validity Rule">
			<collectionRulesOptionWrapper>																															
				<xsl:for-each select="/collectionRulesOptionWrapper/collectionRulesOptionNode">
					<collectionRulesOptionNode name="{@name}">
						<ruleOptionWrapper>
							<xsl:for-each select="ruleOptionWrapper/planRulesNode">
								<planRulesNode ruleType="Validity Rule" ruleTypeLabel="Validity Rule" planFile="{@planFile}" name="{@name}" code="{@code}" type="PlanRule">
									<description><xsl:value-of select="description|@description"/></description>
								</planRulesNode>
							</xsl:for-each>
							<xsl:for-each select="ruleOptionWrapper/expressionRulesNode">
								<expressionRulesNode ruleType="Validity Rule" ruleTypeLabel="Validity Rule" name="{@name}" code="{@code}" type="ExpressionRule">
									<description><xsl:value-of select="description|@description"/></description>
								</expressionRulesNode>
							</xsl:for-each>
							<xsl:for-each select="ruleOptionWrapper/copyRulesNode">
								<copyRulesNode inputColumnType="{@inputColumnType}" ruleType="Validity Rule" ruleTypeLabel="Validity Rule" name="{@name}" inputColumn="{@inputColumn}" code="{@code}" type="CopyRule">
									<description><xsl:value-of select="description|@description"/></description>	
								</copyRulesNode>
							</xsl:for-each>
							<xsl:for-each select="ruleOptionWrapper/multiEntityExpressionRulesNode">
								<multiEntityExpressionRulesNode ruleType="Validity Rule" ruleTypeLabel="Validity Rule" name="{@name}" code="{@code}" type="MultiEntityExpressionRule">
									<description><xsl:value-of select="description|@description"/></description>
								</multiEntityExpressionRulesNode>
							</xsl:for-each>
						</ruleOptionWrapper>
						<!-- LOOP -->
						<xsl:if test="collectionRulesOptionWrapper">
							<xsl:call-template name='defaultRuleNodeLoop'/>
						</xsl:if>					
					</collectionRulesOptionNode>				
				</xsl:for-each>									
			</collectionRulesOptionWrapper>							
		</defaultRuleRoot>	
	</xsl:template>

	<xsl:template name="defaultRuleNodeLoop">
		<collectionRulesOptionWrapper>																															
			<xsl:for-each select="collectionRulesOptionWrapper/collectionRulesOptionNode">
				<collectionRulesOptionNode name="{@name}">
					<ruleOptionWrapper>
						<xsl:for-each select="ruleOptionWrapper/planRulesNode">
							<planRulesNode ruleType="Validity Rule" ruleTypeLabel="Validity Rule" planFile="{@planFile}" name="{@name}" code="{@code}" type="PlanRule">
								<description><xsl:value-of select="description|@description"/></description>
							</planRulesNode>
						</xsl:for-each>
						<xsl:for-each select="ruleOptionWrapper/expressionRulesNode">
							<expressionRulesNode ruleType="Validity Rule" ruleTypeLabel="Validity Rule" name="{@name}" code="{@code}" type="ExpressionRule">
								<description><xsl:value-of select="description|@description"/></description>
							</expressionRulesNode>
						</xsl:for-each>
						<xsl:for-each select="ruleOptionWrapper/copyRulesNode">
							<copyRulesNode inputColumnType="{@inputColumnType}" ruleType="Validity Rule" ruleTypeLabel="Validity Rule" name="{@name}" inputColumn="{@inputColumn}" code="{@code}" type="CopyRule">
								<description><xsl:value-of select="description|@description"/></description>	
							</copyRulesNode>
						</xsl:for-each>
						<xsl:for-each select="ruleOptionWrapper/multiEntityExpressionRulesNode">
							<multiEntityExpressionRulesNode ruleType="Validity Rule" ruleTypeLabel="Validity Rule" name="{@name}" code="{@code}" type="MultiEntityExpressionRule">
								<description><xsl:value-of select="description|@description"/></description>
							</multiEntityExpressionRulesNode>
						</xsl:for-each>
					</ruleOptionWrapper>
					<!-- LOOP -->
					<xsl:if test="collectionRulesOptionWrapper">
						<xsl:call-template name='defaultRuleNodeLoop'/>
					</xsl:if>							
				</collectionRulesOptionNode>				
			</xsl:for-each>									
		</collectionRulesOptionWrapper>	
	</xsl:template>

</xsl:stylesheet>