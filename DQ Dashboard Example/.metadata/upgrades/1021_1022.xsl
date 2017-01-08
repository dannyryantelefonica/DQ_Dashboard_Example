<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:sf="http://www.ataccama.com/xslt/functions"
	xmlns:fn="http://www.w3.org/2005/xpath-functions"
	exclude-result-prefixes="sf fn">
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>	
	
	<xsl:template match="/*">
		<md>	
			<xsl:copy-of select="preferenceRoot"/>
			<xsl:copy-of select="dqDimensionRoot"/>
			<sourceSystemRoot>			
				<sourceSystemWrapper>
					<xsl:for-each select="sourceSystemRoot/sourceSystemWrapper/sourceSystemNode">
						<sourceSystemNode name="{@name}" enable="{@enable}" code="{@code}">
							<!-- <xsl:variable name="lMRoot" select="lMRoot"/>-->
							<description><xsl:value-of select="description|@description"/></description>
							<modelWrapper>
								<xsl:for-each select="modelWrapper/modelNode">
									<modelNode name="{@name}" code="{@code}">
										<xsl:variable name="modelName" select="@name"/>									
										<description><xsl:value-of select="description|@description"/></description>
										<lMRoot>									
											<lMTableWrapper>
												<xsl:variable name="centralEntity" select="lMRoot/lMTableWrapper/lMTableNode[not(@name = ancestor::lMRoot/lMRelationshipWrapper/lMRelationshipNode/@childTable)]/@name"/>
												<xsl:for-each select="lMRoot/lMTableWrapper/lMTableNode">
													<xsl:variable name="tableName" select="@name"/>													
													<lMTableNode name="{@name}">
														<xsl:copy-of select="lMAttributeWrapper"/>																												
														<lMAttributeCollContainerWrapper>																																																																																							
															<xsl:copy-of select="lMAttributeCollContainerWrapper/lMAttributeCollContainerMultiEntityParent"/>																
															<xsl:for-each select="lMAttributeCollContainerWrapper/lMAttributeCollContainerMultiEntityChild">
																<xsl:variable name="parentRuleName" select="replace(replace(@parentInstance,'([^\s]+)\.',''),'([^\s]+)\s\((.*)\)','$1')"/>																
																<xsl:variable name="parentRuleCode" select="ancestor::lMRoot/lMTableWrapper/lMTableNode/lMAttributeCollContainerWrapper/lMAttributeCollContainerMultiEntityParent[@name=$parentRuleName]/@code"/>
																<lMAttributeCollContainerMultiEntityChild ruleName="{@ruleName}" name="{@name}" code="{@code}">
																	<xsl:attribute name="parentInstance">
																		<xsl:value-of select="$centralEntity"/>
																		<xsl:value-of select="'.'"/>
																		<xsl:value-of select="$parentRuleCode"/>
																		<xsl:value-of select="' ('"/>
																		<xsl:value-of select="@ruleName"/>
																		<xsl:value-of select="')'"/>
																	</xsl:attribute>
																	<xsl:copy-of select="lMAttributeChildCollWrapper"/>
																	<xsl:copy-of select="lMAttributeRuleResultWrapper"/>
																</lMAttributeCollContainerMultiEntityChild>																
															</xsl:for-each>
															<xsl:copy-of select="lMAttributeCollContainerWrapper/lMAttributeCollContainerOneEntity"/>																																																																					
														</lMAttributeCollContainerWrapper>														
													</lMTableNode>
												</xsl:for-each>
											</lMTableWrapper>
											<xsl:copy-of select="lMRoot/lMRelationshipWrapper"/>
										</lMRoot>
										<!-- <xsl:variable name="lMRoot" select="lMRoot"/>-->
										<xsl:copy-of select="entityRoot"/>
										<xsl:copy-of select="dimensionWrapper"/>																			
									</modelNode>
								</xsl:for-each>
							</modelWrapper>
							<xsl:copy-of select="ruleRoot"/>								
						</sourceSystemNode>
					</xsl:for-each>
				</sourceSystemWrapper>
			</sourceSystemRoot>
			<xsl:copy-of select="masterEntityRoot"/>
			<xsl:copy-of select="defaultRuleRoot"/>								
		 </md>
	</xsl:template>

</xsl:stylesheet>
