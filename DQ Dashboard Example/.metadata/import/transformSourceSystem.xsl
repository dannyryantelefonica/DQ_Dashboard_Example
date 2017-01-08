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
	<sourceSystemRoot>
		<sourceSystemWrapper>
			<xsl:for-each select="/sourceSystemWrapper/sourceSystemNode">
				<sourceSystemNode code="{@code}" name="{@name}">
					<modelWrapper>
						<xsl:for-each select="modelWrapper/modelNode">
							<modelNode code="{@code}" name="{@name}">
								<lMRoot>
									<lMTableWrapper>
										<xsl:for-each select="lMRoot/lMTableWrapper/lMTableNode">
											<lMTableNode name="{@name}">
												<lMAttributeWrapper>
													<xsl:for-each select="lMAttributeWrapper/lMAttributeNode">
														<lMAttributeNode businessName="{@businessName}" ruleName="{@ruleName}" name="{@name}" type="{@type}" dbType="{@dbType}">															
														</lMAttributeNode>
													</xsl:for-each>								
												</lMAttributeWrapper>
												<lMAttributeCollContainerWrapper>
													<xsl:for-each select="lMAttributeCollContainerWrapper/lMAttributeCollContainerOneEntity">
														<lMAttributeCollContainerOneEntity>
															<xsl:attribute name="name">
																<xsl:value-of select="@name"/>
															</xsl:attribute>
															<xsl:attribute name="code">
																<xsl:value-of select="@code"/>
															</xsl:attribute>
															<xsl:attribute name="ruleName">
																<xsl:value-of select="@ruleName"/>
															</xsl:attribute>
														</lMAttributeCollContainerOneEntity>	
													</xsl:for-each>						
												</lMAttributeCollContainerWrapper>
											</lMTableNode>
										</xsl:for-each>
									</lMTableWrapper>
								</lMRoot>
							</modelNode>
						</xsl:for-each>
					</modelWrapper>
					<ruleRoot ruleType="Validity Rule">
						<collectionRulesOptionWrapper>																															
							<xsl:for-each select="ruleRoot/collectionRulesOptionWrapper/collectionRulesOptionNode">
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
									</ruleOptionWrapper>									<!-- LOOP -->
									<xsl:if test="collectionRulesOptionWrapper">
										<xsl:call-template name='defaultRuleNodeLoop'/>
									</xsl:if>					
								</collectionRulesOptionNode>				
							</xsl:for-each>									
						</collectionRulesOptionWrapper>								
					</ruleRoot>
				</sourceSystemNode>
			</xsl:for-each>
		</sourceSystemWrapper>
	</sourceSystemRoot>
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