<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:sf="http://www.ataccama.com/xslt/functions"
	xmlns:fn="http://www.w3.org/2005/xpath-functions"
	exclude-result-prefixes="sf fn">
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>	
	
	<xsl:template match="/*">
		<md>	
			<preferenceRoot filterCombLimit="{preferenceRoot/@filterCombLimit}" effectiveDate="{preferenceRoot/@effectiveDate}" datamart="{preferenceRoot/@datamart}">
				<dataSample outputDir="{preferenceRoot/dataSample/@outputDir}" fileNamePattern="{preferenceRoot/dataSample/@fileNamePattern}" sampleSize="{preferenceRoot/dataSample/@sampleSize}"/>
				<versionNode version="{preferenceRoot/versionNode/@version}"/>
			</preferenceRoot>
			<dqDimensionRoot>
				<dqDimensionWrapper>
					<xsl:for-each select="dqDimensionRoot/dqDimensionWrapper/dqDimensionNode">
						<dqDimensionNode id="{@id}" name="{@name}">
							<xsl:copy-of select="description"/>
							<xsl:copy-of select="dqDimensionResultWrapper"/>
							<dqRuleRoot ruleType="{dqRuleRoot/@ruleType}">
								<dqCollectionRulesOptionWrapper>
									<xsl:for-each select="dqRuleRoot/dqCollectionRulesOptionWrapper/dqCollectionRulesOptionNode">
										<dqCollectionRulesOptionNode name="{@name}">
											<dqRuleOptionWrapper>
												<xsl:for-each select="dqRuleOptionWrapper/dqPlanRulesNode">
													<dqPlanRulesNode ruleType="{@ruleTypeLabel}" ruleTypeLabel="{@ruleTypeLabel}" description="{@description}" name="{@name}" code="{@code}" type="{@type}">
														<xsl:copy-of select="ruleColumnWrapper"/>
													</dqPlanRulesNode>							
												</xsl:for-each>
												<xsl:for-each select="dqRuleOptionWrapper/dqExpressionRulesNode">
													<dqExpressionRulesNode ruleType="{@ruleTypeLabel}" ruleTypeLabel="{@ruleTypeLabel}" description="{@description}" name="{@name}" code="{@code}" type="{@type}">
														<xsl:copy-of select="ruleColumnWrapper"/>
														<xsl:copy-of select="dqRuleResultWrapper"/>
													</dqExpressionRulesNode>
												</xsl:for-each>
												<xsl:for-each select="dqRuleOptionWrapper/dqMultiEntityExpressionRulesNode">
													<dqMultiEntityExpressionRulesNode ruleType="{@ruleTypeLabel}" ruleTypeLabel="{@ruleTypeLabel}" description="{@description}" name="{@name}" code="{@code}" type="{@type}">
														<xsl:copy-of select="acceptanceCondition"/>
														<xsl:copy-of select="ruleColumnWrapper"/>
														<xsl:copy-of select="ruleChildColumnWrapper"/>
														<xsl:copy-of select="ruleAggregatingOrderByWrapper"/>
														<xsl:copy-of select="dqRuleMultiEntityResultWrapper"/>
													</dqMultiEntityExpressionRulesNode>				
												</xsl:for-each>
												<xsl:for-each select="dqRuleOptionWrapper/dqCopyRulesNode">
													<dqCopyRulesNode ruleType="{@ruleTypeLabel}" ruleTypeLabel="{@ruleTypeLabel}" description="{@description}" name="{@name}" inputColumn="{@inputColumn}" code="{@code}" type="{@type}"/>				
												</xsl:for-each>
											</dqRuleOptionWrapper>					
											<!-- LOOP -->
											<xsl:if test="dqCollectionRulesOptionWrapper">
												<xsl:call-template name='dqRuleNodeLoop'/>
											</xsl:if>							
										</dqCollectionRulesOptionNode>				
									</xsl:for-each>					
								</dqCollectionRulesOptionWrapper>						
							</dqRuleRoot>
						</dqDimensionNode>	
					</xsl:for-each>	
				</dqDimensionWrapper>
			</dqDimensionRoot>
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
																<xsl:variable name="ruleType" select="replace(@ruleName,'(.*):\s(.*)','$1')"/>
																<xsl:variable name="ruleCode" select="replace(@ruleName,'(.*):\s(.*)','$2')"/>
																<xsl:variable name="ruleName" select="//ruleRoot//collectionRulesOptionWrapper/collectionRulesOptionNode/ruleOptionWrapper/*[@code=$ruleCode]/@name | //dqDimensionRoot//dqCollectionRulesOptionWrapper/dqCollectionRulesOptionNode/dqRuleOptionWrapper/*[@code=$ruleCode]/@name | //defaultRuleRoot//collectionRulesOptionWrapper/collectionRulesOptionNode/ruleOptionWrapper/*[@code=$ruleCode]/@name"/>
																<xsl:variable name="newRuleType" select="if($ruleType='genericRule') then 'Validity Rule' else 'Dimension Rule'"/>
																<lMAttributeNode businessName="{@businessName}" name="{@name}" type="{@type}" dbType="{@dbType}">
																	<xsl:attribute name="ruleName">
																		<xsl:if test="@ruleName!=''">
																			<xsl:value-of select="$newRuleType"/>
																			<xsl:value-of select="': '"/>
																			<xsl:value-of select="$ruleCode"/>
																			<xsl:value-of select="' ('"/>
																			<xsl:value-of select="$ruleName"/>
																			<xsl:value-of select="')'"/>
																		</xsl:if>
																	</xsl:attribute>
																</lMAttributeNode>															
															</xsl:for-each>
														</lMAttributeWrapper>																											
														<lMAttributeCollContainerWrapper>			
															<xsl:for-each select="lMAttributeCollContainerWrapper/lMAttributeCollContainerMultiEntityParent">
																<lMAttributeCollContainerMultiEntityParent name="{@name}" code="{@code}">
																	<xsl:variable name="ruleType" select="replace(@ruleName,'(.*):\s(.*)','$1')"/>
																	<xsl:variable name="ruleCode" select="replace(@ruleName,'(.*):\s(.*)','$2')"/>
																	<xsl:variable name="ruleName" select="//ruleRoot//collectionRulesOptionWrapper/collectionRulesOptionNode/ruleOptionWrapper/*[@code=$ruleCode]/@name | //dqDimensionRoot//dqCollectionRulesOptionWrapper/dqCollectionRulesOptionNode/dqRuleOptionWrapper/*[@code=$ruleCode]/@name | //defaultRuleRoot//collectionRulesOptionWrapper/collectionRulesOptionNode/ruleOptionWrapper/*[@code=$ruleCode]/@name"/>
																	<xsl:variable name="newRuleType" select="if($ruleType='genericRule') then 'Validity Rule' else 'Dimension Rule'"/>
																	<xsl:attribute name="ruleName">	
																		<xsl:if test="@ruleName!=''">
																			<xsl:value-of select="$newRuleType"/>
																			<xsl:value-of select="': '"/>
																			<xsl:value-of select="$ruleCode"/>
																			<xsl:value-of select="' ('"/>
																			<xsl:value-of select="$ruleName"/>
																			<xsl:value-of select="')'"/>
																		</xsl:if>
																	</xsl:attribute>
																	<xsl:copy-of select="lMAttributeCollWrapper"/>
																</lMAttributeCollContainerMultiEntityParent>																																																																																					
															</xsl:for-each>															
															<xsl:for-each select="lMAttributeCollContainerWrapper/lMAttributeCollContainerMultiEntityChild">
																<xsl:variable name="parentRuleName" select="replace(replace(@parentInstance,'([^\s]+)\.',''),'([^\s]+)\s\((.*)\)','$1')"/>																
																<xsl:variable name="parentRuleCode" select="ancestor::lMRoot/lMTableWrapper/lMTableNode/lMAttributeCollContainerWrapper/lMAttributeCollContainerMultiEntityParent[@name=$parentRuleName]/@code"/>
																<lMAttributeCollContainerMultiEntityChild name="{@name}" code="{@code}">
																	<xsl:variable name="ruleType" select="replace(@ruleName,'(.*):\s(.*)','$1')"/>
																	<xsl:variable name="ruleCode" select="replace(@ruleName,'(.*):\s(.*)','$2')"/>
																	<xsl:variable name="ruleName" select="//ruleRoot//collectionRulesOptionWrapper/collectionRulesOptionNode/ruleOptionWrapper/*[@code=$ruleCode]/@name | //dqDimensionRoot//dqCollectionRulesOptionWrapper/dqCollectionRulesOptionNode/dqRuleOptionWrapper/*[@code=$ruleCode]/@name | //defaultRuleRoot//collectionRulesOptionWrapper/collectionRulesOptionNode/ruleOptionWrapper/*[@code=$ruleCode]/@name"/>
																	<xsl:variable name="newRuleType" select="if($ruleType='genericRule') then 'Validity Rule' else 'Dimension Rule'"/>
																	<xsl:attribute name="ruleName">	
																		<xsl:if test="@ruleName!=''">
																			<xsl:value-of select="$newRuleType"/>
																			<xsl:value-of select="': '"/>
																			<xsl:value-of select="$ruleCode"/>
																			<xsl:value-of select="' ('"/>
																			<xsl:value-of select="$ruleName"/>
																			<xsl:value-of select="')'"/>
																		</xsl:if>
																	</xsl:attribute>
																	<xsl:variable name="parentRuleName" select="replace(@parentInstance, '(.*)\.(.*)', '$2')"/>
																	<xsl:variable name="parentRuleCode" select="ancestor::lMRoot/lMTableWrapper/lMTableNode/lMAttributeCollContainerWrapper/lMAttributeCollContainerMultiEntityParent[@name=$parentRuleName]/@ruleName"/>
																	<xsl:variable name="realRuleCode" select="replace($parentRuleCode,'(.*):\s(.*)','$2')"/>																	
																	<xsl:variable name="ruleCode" select="//ruleRoot//collectionRulesOptionWrapper/collectionRulesOptionNode/ruleOptionWrapper/*[@code=$realRuleCode]/@code | //dqDimensionRoot//dqCollectionRulesOptionWrapper/dqCollectionRulesOptionNode/dqRuleOptionWrapper/*[@code=$realRuleCode]/@code | //defaultRuleRoot//collectionRulesOptionWrapper/collectionRulesOptionNode/ruleOptionWrapper/*[@code=$realRuleCode]/@code"/>
																	<xsl:variable name="ruleType" select="replace($parentRuleCode,'(.*):\s(.*)','$1')"/>
																	<xsl:variable name="newRuleType" select="if($ruleType='genericRule') then 'Validity Rule' else 'Dimension Rule'"/>
																	<xsl:attribute name="parentInstance">
																		<xsl:value-of select="@parentInstance"/>
																		<xsl:value-of select="' ('"/>
																		<xsl:value-of select="$newRuleType"/>
																		<xsl:value-of select="': '"/>
																		<xsl:value-of select="$ruleCode"/>
																		<xsl:value-of select="' ('"/>
																		<xsl:value-of select="$ruleName"/>
																		<xsl:value-of select="')'"/>
																		<xsl:value-of select="')'"/>
																	</xsl:attribute>
																	<xsl:copy-of select="lMAttributeChildCollWrapper"/>
																	<lMAttributeRuleResultWrapper>
																		<xsl:for-each select="lMAttributeRuleResultWrapper/lMAttributeRuleResultNode">
																			<lMAttributeRuleResultNode ruleAttMapping="{@ruleAttMapping}">
																				<xsl:attribute name="ruleResult">
																					<xsl:variable name="ruleType" select="replace(replace(@ruleResult,'(.*):\s(.*)\s(.*)\s(.*)\s(.*)','$1'), '(.*):\s(.*)','$1')"/>
																					<xsl:variable name="newRuleType" select="if($ruleType='genericRule') then 'Validity Rule' else 'Dimension Rule'"/>
																					<xsl:variable name="ruleCode" select="replace(replace(@ruleResult,'(.*):\s',''),'([^\s]+)\s\((.*)\)','$1')"/>
																					<xsl:variable name="ruleName" select="//ruleRoot//collectionRulesOptionWrapper/collectionRulesOptionNode/ruleOptionWrapper/*[@code=$ruleCode]/@name | //dqDimensionRoot//dqCollectionRulesOptionWrapper/dqCollectionRulesOptionNode/dqRuleOptionWrapper/*[@code=$ruleCode]/@name | //defaultRuleRoot//collectionRulesOptionWrapper/collectionRulesOptionNode/ruleOptionWrapper/*[@code=$ruleCode]/@name"/>
																					<xsl:variable name="colName" select="replace(replace(replace(@ruleResult,'(.*):\s',''),'(.*)\(',''),'\)','')"/>
																					<xsl:value-of select="if($ruleType='genericRule') then 'Validity Rule' else 'Dimension Rule'"/>
																					<xsl:value-of select="': '"/>
																					<xsl:value-of select="$ruleCode"/>
																					<xsl:value-of select="' ('"/>
																					<xsl:value-of select="$ruleName"/>
																					<xsl:value-of select="') '"/>
																					<xsl:value-of select="'('"/>
																					<xsl:value-of select="$colName"/>
																					<xsl:value-of select="')'"/>
																				</xsl:attribute>
																			</lMAttributeRuleResultNode>
																		</xsl:for-each>
																	</lMAttributeRuleResultWrapper>
																</lMAttributeCollContainerMultiEntityChild>																
															</xsl:for-each>
															<xsl:for-each select="lMAttributeCollContainerWrapper/lMAttributeCollContainerOneEntity">
																<lMAttributeCollContainerOneEntity name="{@name}" code="{@code}">
																	<xsl:variable name="ruleType" select="replace(@ruleName,'(.*):\s(.*)','$1')"/>
																	<xsl:variable name="ruleCode" select="replace(@ruleName,'(.*):\s(.*)','$2')"/>
																	<xsl:variable name="ruleName" select="//ruleRoot//collectionRulesOptionWrapper/collectionRulesOptionNode/ruleOptionWrapper/*[@code=$ruleCode]/@name | //dqDimensionRoot//dqCollectionRulesOptionWrapper/dqCollectionRulesOptionNode/dqRuleOptionWrapper/*[@code=$ruleCode]/@name | //defaultRuleRoot//collectionRulesOptionWrapper/collectionRulesOptionNode/ruleOptionWrapper/*[@code=$ruleCode]/@name"/>
																	<xsl:variable name="newRuleType" select="if($ruleType='genericRule') then 'Validity Rule' else 'Dimension Rule'"/>
																	<xsl:attribute name="ruleName">	
																		<xsl:if test="@ruleName!=''">
																			<xsl:value-of select="$newRuleType"/>
																			<xsl:value-of select="': '"/>
																			<xsl:value-of select="$ruleCode"/>
																			<xsl:value-of select="' ('"/>
																			<xsl:value-of select="$ruleName"/>
																			<xsl:value-of select="')'"/>
																		</xsl:if>
																	</xsl:attribute>
																	<xsl:copy-of select="lMAttributeCollWrapper"/>
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
							<ruleRoot ruleType="{ruleRoot/@ruleType}">
								<collectionRulesOptionWrapper>
									<xsl:for-each select="ruleRoot/collectionRulesOptionWrapper/collectionRulesOptionNode">
										<collectionRulesOptionNode name="{@name}">
											<ruleOptionWrapper>
												<xsl:for-each select="ruleOptionWrapper/planRulesNode">
													<planRulesNode ruleType="{@ruleTypeLabel}" ruleTypeLabel="{@ruleTypeLabel}" planFile="{@planFile}" name="{@name}" code="{@code}" type="{@type}">
														<xsl:copy-of select="description"/>
														<xsl:copy-of select="ruleColumnWrapper"/>
														<xsl:copy-of select="ruleExplanationWrapper"/>
													</planRulesNode>
												</xsl:for-each>
												<xsl:for-each select="ruleOptionWrapper/expressionRulesNode">
													<expressionRulesNode ruleType="{@ruleTypeLabel}" ruleTypeLabel="{@ruleTypeLabel}" name="{@name}" code="{@code}" type="{@type}">
													<xsl:copy-of select="description"/>
													<xsl:copy-of select="ruleColumnWrapper"/>
													<xsl:copy-of select="ruleExplanationWrapper"/>					
												</expressionRulesNode>
												</xsl:for-each>
												<xsl:for-each select="ruleOptionWrapper/multiEntityExpressionRulesNode">
													<multiEntityExpressionRulesNode  ruleType="{@ruleTypeLabel}" ruleTypeLabel="{@ruleTypeLabel}" name="{@name}" code="{@code}" type="{@type}">
														<xsl:copy-of select="description"/>
														<xsl:copy-of select="validity"/>
														<xsl:copy-of select="acceptanceCondition"/>
														<xsl:copy-of select="ruleColumnWrapper"/>
														<xsl:copy-of select="ruleChildColumnWrapper"/>
														<xsl:copy-of select="ruleAggregatingOrderByWrapper"/>
														<xsl:copy-of select="ruleMultiEntityExpressionWrapper"/>															
													</multiEntityExpressionRulesNode>						
												</xsl:for-each>
												<xsl:for-each select="ruleOptionWrapper/copyRulesNode">
													<copyRulesNode ruleType="{@ruleTypeLabel}" ruleTypeLabel="{@ruleTypeLabel}" name="{@name}" inputColumn="{@inputColumn}" code="{@code}" type="{@type}">
														<xsl:copy-of select="description"/>
														<xsl:copy-of select="ruleExplanationWrapper"/>
													</copyRulesNode>						
												</xsl:for-each>
											</ruleOptionWrapper>					
											<!-- LOOP -->
											<xsl:if test="collectionRulesOptionWrapper">
												<xsl:call-template name='ruleNodeLoop'/>
											</xsl:if>							
										</collectionRulesOptionNode>
									</xsl:for-each>					
								</collectionRulesOptionWrapper>					
							</ruleRoot>							
						</sourceSystemNode>
					</xsl:for-each>
				</sourceSystemWrapper>
			</sourceSystemRoot>
			<xsl:copy-of select="masterEntityRoot"/>
			<defaultRuleRoot ruleType="{defaultRuleRoot/@ruleType}">
				<collectionRulesOptionWrapper>
					<xsl:for-each select="//defaultRuleRoot/collectionRulesOptionWrapper/collectionRulesOptionNode">
						<collectionRulesOptionNode name="{@name}">
							<ruleOptionWrapper>
								<xsl:for-each select="ruleOptionWrapper/planRulesNode">
									<planRulesNode ruleType="{@ruleTypeLabel}" ruleTypeLabel="{@ruleTypeLabel}" planFile="{@planFile}" name="{@name}" code="{@code}" type="{@type}">
										<xsl:copy-of select="description"/>
										<xsl:copy-of select="ruleColumnWrapper"/>
										<xsl:copy-of select="ruleExplanationWrapper"/>
									</planRulesNode>
								</xsl:for-each>
								<xsl:for-each select="ruleOptionWrapper/expressionRulesNode">
									<expressionRulesNode ruleType="{@ruleTypeLabel}" ruleTypeLabel="{@ruleTypeLabel}" name="{@name}" code="{@code}" type="{@type}">
									<xsl:copy-of select="description"/>
									<xsl:copy-of select="ruleColumnWrapper"/>
									<xsl:copy-of select="ruleExplanationWrapper"/>					
								</expressionRulesNode>
								</xsl:for-each>
								<xsl:for-each select="ruleOptionWrapper/multiEntityExpressionRulesNode">
									<multiEntityExpressionRulesNode  ruleType="{@ruleTypeLabel}" ruleTypeLabel="{@ruleTypeLabel}" name="{@name}" code="{@code}" type="{@type}">
										<xsl:copy-of select="description"/>
										<xsl:copy-of select="validity"/>
										<xsl:copy-of select="acceptanceCondition"/>
										<xsl:copy-of select="ruleColumnWrapper"/>
										<xsl:copy-of select="ruleChildColumnWrapper"/>
										<xsl:copy-of select="ruleAggregatingOrderByWrapper"/>
										<xsl:copy-of select="ruleMultiEntityExpressionWrapper"/>															
									</multiEntityExpressionRulesNode>						
								</xsl:for-each>
								<xsl:for-each select="ruleOptionWrapper/copyRulesNode">
									<copyRulesNode ruleType="{@ruleTypeLabel}" ruleTypeLabel="{@ruleTypeLabel}" name="{@name}" inputColumn="{@inputColumn}" code="{@code}" type="{@type}">
										<xsl:copy-of select="description"/>
										<xsl:copy-of select="ruleExplanationWrapper"/>
									</copyRulesNode>						
								</xsl:for-each>
							</ruleOptionWrapper>					
							<!-- LOOP -->
							<xsl:if test="collectionRulesOptionWrapper">
								<xsl:call-template name='ruleNodeLoop'/>
							</xsl:if>							
						</collectionRulesOptionNode>
					</xsl:for-each>					
				</collectionRulesOptionWrapper>					
			</defaultRuleRoot>								
		 </md>
	</xsl:template>
	
	<xsl:template name="ruleNodeLoop">
		<collectionRulesOptionWrapper>
			<xsl:for-each select="collectionRulesOptionWrapper/collectionRulesOptionNode">
				<collectionRulesOptionNode name="{@name}">
					<ruleOptionWrapper>
						<xsl:for-each select="ruleOptionWrapper/planRulesNode">
							<planRulesNode ruleType="{@ruleTypeLabel}" ruleTypeLabel="{@ruleTypeLabel}" planFile="{@planFile}" name="{@name}" code="{@code}" type="{@type}">
								<xsl:copy-of select="description"/>
								<xsl:copy-of select="ruleColumnWrapper"/>
								<xsl:copy-of select="ruleExplanationWrapper"/>
							</planRulesNode>
						</xsl:for-each>
						<xsl:for-each select="ruleOptionWrapper/expressionRulesNode">
							<expressionRulesNode ruleType="{@ruleTypeLabel}" ruleTypeLabel="{@ruleTypeLabel}" name="{@name}" code="{@code}" type="{@type}">
							<xsl:copy-of select="description"/>
							<xsl:copy-of select="ruleColumnWrapper"/>
							<xsl:copy-of select="ruleExplanationWrapper"/>					
						</expressionRulesNode>
						</xsl:for-each>
						<xsl:for-each select="ruleOptionWrapper/multiEntityExpressionRulesNode">
							<multiEntityExpressionRulesNode  ruleType="{@ruleTypeLabel}" ruleTypeLabel="{@ruleTypeLabel}" name="{@name}" code="{@code}" type="{@type}">
								<xsl:copy-of select="description"/>
								<xsl:copy-of select="validity"/>
								<xsl:copy-of select="acceptanceCondition"/>
								<xsl:copy-of select="ruleColumnWrapper"/>
								<xsl:copy-of select="ruleChildColumnWrapper"/>
								<xsl:copy-of select="ruleAggregatingOrderByWrapper"/>
								<xsl:copy-of select="ruleMultiEntityExpressionWrapper"/>															
							</multiEntityExpressionRulesNode>						
						</xsl:for-each>
						<xsl:for-each select="ruleOptionWrapper/copyRulesNode">
							<copyRulesNode ruleType="{@ruleTypeLabel}" ruleTypeLabel="{@ruleTypeLabel}" name="{@name}" inputColumn="{@inputColumn}" code="{@code}" type="{@type}">
								<xsl:copy-of select="description"/>
								<xsl:copy-of select="ruleExplanationWrapper"/>
							</copyRulesNode>						
						</xsl:for-each>
					</ruleOptionWrapper>					
					<!-- LOOP -->
					<xsl:if test="collectionRulesOptionWrapper">
						<xsl:call-template name='ruleNodeLoop'/>
					</xsl:if>							
				</collectionRulesOptionNode>				
			</xsl:for-each>					
		</collectionRulesOptionWrapper>
	</xsl:template>
	
	<xsl:template name="dqRuleNodeLoop">
		<dqCollectionRulesOptionWrapper>
			<xsl:for-each select="dqCollectionRulesOptionWrapper/dqCollectionRulesOptionNode">
				<dqCollectionRulesOptionNode name="{@name}">
					<dqRuleOptionWrapper>
						<xsl:for-each select="dqRuleOptionWrapper/dqPlanRulesNode">
							<dqPlanRulesNode ruleType="{@ruleTypeLabel}" ruleTypeLabel="{@ruleTypeLabel}" description="{@description}" name="{@name}" code="{@code}" type="{@type}">
								<xsl:copy-of select="ruleColumnWrapper"/>
							</dqPlanRulesNode>							
						</xsl:for-each>
						<xsl:for-each select="dqRuleOptionWrapper/dqExpressionRulesNode">
							<dqExpressionRulesNode ruleType="{@ruleTypeLabel}" ruleTypeLabel="{@ruleTypeLabel}" description="{@description}" name="{@name}" code="{@code}" type="{@type}">
								<xsl:copy-of select="ruleColumnWrapper"/>
								<xsl:copy-of select="dqRuleResultWrapper"/>
							</dqExpressionRulesNode>
						</xsl:for-each>
						<xsl:for-each select="dqRuleOptionWrapper/dqMultiEntityExpressionRulesNode">
							<dqMultiEntityExpressionRulesNode ruleType="{@ruleTypeLabel}" ruleTypeLabel="{@ruleTypeLabel}" description="{@description}" name="{@name}" code="{@code}" type="{@type}">
								<xsl:copy-of select="acceptanceCondition"/>
								<xsl:copy-of select="ruleColumnWrapper"/>
								<xsl:copy-of select="ruleChildColumnWrapper"/>
								<xsl:copy-of select="ruleAggregatingOrderByWrapper"/>
								<xsl:copy-of select="dqRuleMultiEntityResultWrapper"/>
							</dqMultiEntityExpressionRulesNode>				
						</xsl:for-each>
						<xsl:for-each select="dqRuleOptionWrapper/dqCopyRulesNode">
							<dqCopyRulesNode ruleType="{@ruleTypeLabel}" ruleTypeLabel="{@ruleTypeLabel}" description="{@description}" name="{@name}" inputColumn="{@inputColumn}" code="{@code}" type="{@type}"/>				
						</xsl:for-each>
					</dqRuleOptionWrapper>					
					<!-- LOOP -->
					<xsl:if test="dqCollectionRulesOptionWrapper">
						<xsl:call-template name='dqRuleNodeLoop'/>
					</xsl:if>							
				</dqCollectionRulesOptionNode>				
			</xsl:for-each>					
		</dqCollectionRulesOptionWrapper>
	</xsl:template>

</xsl:stylesheet>
