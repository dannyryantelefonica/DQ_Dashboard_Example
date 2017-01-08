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
														<lMAttributeWrapper>
															<xsl:for-each select="lMAttributeWrapper/lMAttributeNode">
																<lMAttributeNode businessName="{@businessName}" ruleName="{replace(@ruleName,'([^\s]+)\s\((.*)\)','$1')}" name="{@name}" type="{@type}" dbType="{@dbType}"/>																												
															</xsl:for-each>
														</lMAttributeWrapper>
														<lMAttributeCollContainerWrapper>
															<xsl:for-each select="lMAttributeCollContainerWrapper/lMAttributeCollContainerMultiEntityParent">
																<lMAttributeCollContainerMultiEntityParent ruleName="{replace(@ruleName,'([^\s]+)\s\((.*)\)','$1')}" name="{@name}" code="{@code}">
																	<lMAttributeCollWrapper>
																		<xsl:for-each select="lMAttributeCollWrapper/lMAttributeCollNode">
																			<lMAttributeCollNode ruleAttMapping="{@ruleAttMapping}" attName="{@attName}"/>
																		</xsl:for-each>
																	</lMAttributeCollWrapper>
																</lMAttributeCollContainerMultiEntityParent>															
															</xsl:for-each>
															<xsl:for-each select="lMAttributeCollContainerWrapper/lMAttributeCollContainerMultiEntityChild">
																<lMAttributeCollContainerMultiEntityChild parentInstance="{replace(@parentInstance,'([^\s]+)\s\((.*)\)','$1')}" ruleName="{replace(@ruleName,'([^\s]+)\s\((.*)\)','$1')}" name="{@name}" code="{@code}">
																	<lMAttributeChildCollWrapper>
																		<xsl:for-each select="lMAttributeChildCollWrapper/lMAttributeChildCollNode">
																			<lMAttributeChildCollNode ruleAttMapping="{@ruleAttMapping}" attName="{@attName}"/>
																		</xsl:for-each>
																	</lMAttributeChildCollWrapper>
																	<lMAttributeRuleResultWrapper>
																		<xsl:for-each select="lMAttributeRuleResultWrapper/lMAttributeRuleResultNode">
																			<lMAttributeRuleResultNode ruleAttMapping="{@ruleAttMapping}" ruleResult="{concat(replace(@ruleResult,'([^\s]+)\s\((.*)\s\((.*)\)','$1'),' (',replace(replace(@ruleResult,'(.*):\s',''),'([^\s]+)\s\((.*)\s\((.*)\)','$3'),')')}"/>
																		</xsl:for-each>
																	</lMAttributeRuleResultWrapper>
																</lMAttributeCollContainerMultiEntityChild>							
															</xsl:for-each>															
															<xsl:for-each select="lMAttributeCollContainerWrapper/lMAttributeCollContainerOneEntity">
																<lMAttributeCollContainerOneEntity ruleName="{replace(@ruleName,'([^\s]+)\s\((.*)\)','$1')}" name="{@name}" code="{@code}">
																	<lMAttributeCollWrapper>
																		<xsl:for-each select="lMAttributeCollWrapper/lMAttributeCollNode">
																			<lMAttributeCollNode ruleAttMapping="{@ruleAttMapping}" attName="{@attName}"/>
																		</xsl:for-each>
																	</lMAttributeCollWrapper>
																</lMAttributeCollContainerOneEntity>														
															</xsl:for-each>
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
