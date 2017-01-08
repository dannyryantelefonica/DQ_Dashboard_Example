<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:sf="http://www.ataccama.com/xslt/functions"
	xmlns:fn="http://www.w3.org/2005/xpath-functions"
	exclude-result-prefixes="sf fn">
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>	
	
	<xsl:template match="/*">
		<md>				
			<preferenceRoot filterCombLimit="10000" effectiveDate="NowDateProvider" datamart="{preferenceRoot/@dmConnection}">
				<dataSample outputDir="" fileNamePattern="dqd_${{processing.start:yyMMdd}}_${{processing.start:HHmmss}}_${{system}}_${{model}}.csv" sampleSize="100"/>
				<versionNode version="10.1.0"/>
			</preferenceRoot>

			<dqDimensionRoot>
				<dqDimensionWrapper>
					<xsl:for-each select="dqDimensionRoot/dqDimensionWrapper/dqDimensionNode">
						<dqDimensionNode id="{@id}" name="{@name}">
						<xsl:variable name="dimensionID" select="@id"/>
							<description></description>
							<dqDimensionResultWrapper>
								<xsl:for-each select="dqDimensionResultWrapper/dqDimensionResultNode">
									<dqDimensionResultNode id="{@id}" name="{@name}">
										<description></description>
									</dqDimensionResultNode>
								</xsl:for-each>
							</dqDimensionResultWrapper>	
							
			              	<dqRuleRoot ruleType="Dimension Rule"> 			              				              					
			              									
								<dqCollectionRulesOptionWrapper>
									<!-- multiEntity --> 
									<dqCollectionRulesOptionNode name="Aggregation rules">
										<dqRuleOptionWrapper>
											<xsl:for-each select="//sourceSystemRoot/sourceSystemWrapper/sourceSystemNode/schemaWrapper/schemaNode/lMRoot/lMTableWrapper/lMTableNode[@name=ancestor::lMRoot/lMRelationshipWrapper/lMRelationshipNode/@childTable]/lMAttributeWrapper/lMAttributeNode[@ruleName!='']">																		
												<xsl:variable name="schemaName" select="ancestor::schemaNode/@name"/>
												<xsl:variable name="tableName" select="ancestor::lMTableNode/@name"/>
												<xsl:variable name="attributeName" select="@name"/>
												<xsl:variable name="ruleCode" select="replace(@ruleName,'\s(.*)','')"/><!-- replace(replace(@ruleName,'(.*):\s',''),'([^\s]+)\s\((.*)\)','$1') -->
												<xsl:variable name="ruleColumnType" select="ancestor::lMAttributeNode[@name=ancestor::lMRoot/lMRelationshipWrapper/lMRelationshipNode[@childTable=$tableName]/lMForeignKeyWrapper/lMForeignKeyNode/@parentColumn]/@type"/>
												
													<xsl:for-each select="//ruleRoot/dimRuleWrapper/dimRuleNode[@id=$ruleCode and @dqDimension=$dimensionID]">
														<dqMultiEntityExpressionRulesNode ruleType="Dimension Rule" ruleTypeLabel="Dimension Rule" name="{@name}" code="{$schemaName}.{$tableName}.{$attributeName}.{$ruleCode}" type="MultiEntityExpressionRule">
															<description><xsl:value-of select="description|@description"/></description>
															<!-- <validity><![CDATA[best.result = 'VALID']]></validity>-->
															<acceptanceCondition></acceptanceCondition>
															<ruleColumnWrapper>
																<ruleColumnNode name="PK" type="{$ruleColumnType}"/>
															</ruleColumnWrapper>
															<ruleChildColumnWrapper>
																<ruleColumnNode name="result" type="string"/>
															</ruleChildColumnWrapper>
															<ruleAggregatingOrderByWrapper>
																<ruleAggregatingOrderByNode orderDescending="false" nullsFirst="false">
																	<expression>
																		<xsl:value-of select="'case('"/><xsl:text>&#10;</xsl:text>
																		<xsl:value-of select="'result = '"/><![CDATA[']]><xsl:value-of select="'VALID'"/><![CDATA[']]><xsl:value-of select="',0,'"/><xsl:text>&#10;</xsl:text>
																		<xsl:for-each select="ruleExplanationWrapper/ruleExplanationNode">																		
																			<xsl:value-of select="'result = '"/><![CDATA[']]><xsl:value-of select="@name"/><![CDATA[']]><xsl:value-of select="','"/>
																			<xsl:value-of select="position()"/>
																			<xsl:value-of select="','"/><xsl:text>&#10;</xsl:text>																		
																		</xsl:for-each>
																		<xsl:value-of select="position()+10"/><xsl:text>&#10;</xsl:text>
																		<xsl:value-of select="')'"/>
																	</expression>
																</ruleAggregatingOrderByNode>
															</ruleAggregatingOrderByWrapper>
															<dqRuleMultiEntityResultWrapper>
																<xsl:for-each select="ruleResultWrapper/ruleResultNode">
																	<dqRuleMultiEntityResultNode code="{@name}">
																		<expression><xsl:value-of select="'best.result = '"/><![CDATA[']]><xsl:value-of select="@name"/><![CDATA[']]></expression>
																	</dqRuleMultiEntityResultNode>
																</xsl:for-each>
															</dqRuleMultiEntityResultWrapper>
														</dqMultiEntityExpressionRulesNode>	
													</xsl:for-each>
										
													<xsl:for-each select="//ruleRoot//ruleContainerWrapper/ruleContainerNode/dimRuleWrapper/dimRuleNode[@id=$ruleCode and @dqDimension=$dimensionID]">			
														<dqMultiEntityExpressionRulesNode ruleType="Dimension Rule" ruleTypeLabel="Dimension Rule" name="{@name}" code="{$schemaName}.{$tableName}.{$attributeName}.{$ruleCode}" type="MultiEntityExpressionRule">
															<description><xsl:value-of select="description|@description"/></description>
															<!-- <validity><![CDATA[best.result = 'VALID']]></validity>-->
															<acceptanceCondition></acceptanceCondition>
															<ruleColumnWrapper>
																<ruleColumnNode name="PK" type="{$ruleColumnType}"/>
															</ruleColumnWrapper>
															<ruleChildColumnWrapper>
																<ruleColumnNode name="result" type="string"/>
															</ruleChildColumnWrapper>
															<ruleAggregatingOrderByWrapper>
																<ruleAggregatingOrderByNode orderDescending="false" nullsFirst="false">
																	<expression>
																		<xsl:value-of select="'case('"/><xsl:text>&#10;</xsl:text>
																		<xsl:value-of select="'result = '"/><![CDATA[']]><xsl:value-of select="'VALID'"/><![CDATA[']]><xsl:value-of select="',0,'"/><xsl:text>&#10;</xsl:text>
																		<xsl:for-each select="ruleExplanationWrapper/ruleExplanationNode">																		
																			<xsl:value-of select="'result = '"/><![CDATA[']]><xsl:value-of select="@name"/><![CDATA[']]><xsl:value-of select="','"/>
																			<xsl:value-of select="position()"/>
																			<xsl:value-of select="','"/><xsl:text>&#10;</xsl:text>																		
																		</xsl:for-each>
																		<xsl:value-of select="position()+10"/><xsl:text>&#10;</xsl:text>
																		<xsl:value-of select="')'"/>
																	</expression>
																</ruleAggregatingOrderByNode>
															</ruleAggregatingOrderByWrapper>
															<dqRuleMultiEntityResultWrapper>
																<xsl:for-each select="ruleResultWrapper/ruleResultNode">
																	<dqRuleMultiEntityResultNode code="{@name}">
																		<expression><xsl:value-of select="'best.result = '"/><![CDATA[']]><xsl:value-of select="@name"/><![CDATA[']]></expression>
																	</dqRuleMultiEntityResultNode>
																</xsl:for-each>
															</dqRuleMultiEntityResultWrapper>
														</dqMultiEntityExpressionRulesNode>
													</xsl:for-each>
													
													<xsl:for-each select="//defaultRuleRoot//defaultRuleContainerWrapper/defaultRuleContainerNode/dimRuleWrapper/dimRuleNode[@id=$ruleCode and @dqDimension=$dimensionID]">			
														<dqMultiEntityExpressionRulesNode ruleType="Dimension Rule" ruleTypeLabel="Dimension Rule" name="{@name}" code="{$schemaName}.{$tableName}.{$attributeName}.{$ruleCode}" type="MultiEntityExpressionRule">
															<description><xsl:value-of select="description|@description"/></description>
															<!-- <validity><![CDATA[best.result = 'VALID']]></validity>-->
															<acceptanceCondition></acceptanceCondition>
															<ruleColumnWrapper>
																<ruleColumnNode name="PK" type="{$ruleColumnType}"/>
															</ruleColumnWrapper>
															<ruleChildColumnWrapper>
																<ruleColumnNode name="result" type="string"/>
															</ruleChildColumnWrapper>
															<ruleAggregatingOrderByWrapper>
																<ruleAggregatingOrderByNode orderDescending="false" nullsFirst="false">
																	<expression>
																		<xsl:value-of select="'case('"/><xsl:text>&#10;</xsl:text>
																		<xsl:value-of select="'result = '"/><![CDATA[']]><xsl:value-of select="'VALID'"/><![CDATA[']]><xsl:value-of select="',0,'"/><xsl:text>&#10;</xsl:text>
																		<xsl:for-each select="ruleExplanationWrapper/ruleExplanationNode">																		
																			<xsl:value-of select="'result = '"/><![CDATA[']]><xsl:value-of select="@name"/><![CDATA[']]><xsl:value-of select="','"/>
																			<xsl:value-of select="position()"/>
																			<xsl:value-of select="','"/><xsl:text>&#10;</xsl:text>																		
																		</xsl:for-each>
																		<xsl:value-of select="position()+10"/><xsl:text>&#10;</xsl:text>
																		<xsl:value-of select="')'"/>
																	</expression>
																</ruleAggregatingOrderByNode>
															</ruleAggregatingOrderByWrapper>
															<dqRuleMultiEntityResultWrapper>
																<xsl:for-each select="ruleResultWrapper/ruleResultNode">
																	<dqRuleMultiEntityResultNode code="{@name}">
																		<expression><xsl:value-of select="'best.result = '"/><![CDATA[']]><xsl:value-of select="@name"/><![CDATA[']]></expression>
																	</dqRuleMultiEntityResultNode>
																</xsl:for-each>
															</dqRuleMultiEntityResultWrapper>
														</dqMultiEntityExpressionRulesNode>
													</xsl:for-each>			
											</xsl:for-each>	

											<xsl:for-each select="//sourceSystemRoot/sourceSystemWrapper/sourceSystemNode/schemaWrapper/schemaNode/lMRoot/lMTableWrapper/lMTableNode[@name=ancestor::lMRoot/lMRelationshipWrapper/lMRelationshipNode/@childTable]/lMAttributeCollContainerWrapper/lMAttributeCollContainer">
												<xsl:variable name="schemaName" select="ancestor::schemaNode/@name"/>
												<xsl:variable name="tableName" select="ancestor::lMTableNode/@name"/>
												<xsl:variable name="attributeName" select="@name"/>
												<xsl:variable name="ruleCode" select="replace(@ruleName,'\s(.*)','')"/><!-- replace(replace(@ruleName,'(.*):\s',''),'([^\s]+)\s\((.*)\)','$1') -->
												<xsl:variable name="ruleColumnType" select="ancestor::lMAttributeNode[@name=ancestor::lMRoot/lMRelationshipWrapper/lMRelationshipNode[@childTable=$tableName]/lMForeignKeyWrapper/lMForeignKeyNode/@parentColumn]/@type"/>

												<xsl:for-each select="//ruleRoot/dimRuleWrapper/dimRuleNode[@id=$ruleCode and @dqDimension=$dimensionID]">
													<dqMultiEntityExpressionRulesNode ruleType="Dimension Rule" ruleTypeLabel="Dimension Rule" name="{@name}" code="{$schemaName}.{$tableName}.{$attributeName}.{$ruleCode}" type="MultiEntityExpressionRule">
														<description><xsl:value-of select="description|@description"/></description>
							
														<acceptanceCondition></acceptanceCondition>
														<ruleColumnWrapper>
															<ruleColumnNode name="PK" type="{$ruleColumnType}"/>
														</ruleColumnWrapper>
														<ruleChildColumnWrapper>
															<ruleColumnNode name="result" type="string"/>
														</ruleChildColumnWrapper>
														<ruleAggregatingOrderByWrapper>
															<ruleAggregatingOrderByNode orderDescending="false" nullsFirst="false">
																<expression>
																	<xsl:value-of select="'case('"/><xsl:text>&#10;</xsl:text>
																	<xsl:value-of select="'result = '"/><![CDATA[']]><xsl:value-of select="'VALID'"/><![CDATA[']]><xsl:value-of select="',0,'"/><xsl:text>&#10;</xsl:text>
																	<xsl:for-each select="ruleExplanationWrapper/ruleExplanationNode">																		
																		<xsl:value-of select="'result = '"/><![CDATA[']]><xsl:value-of select="@name"/><![CDATA[']]><xsl:value-of select="','"/>
																		<xsl:value-of select="position()"/>
																		<xsl:value-of select="','"/><xsl:text>&#10;</xsl:text>																		
																	</xsl:for-each>
																	<xsl:value-of select="position()+10"/><xsl:text>&#10;</xsl:text>
																	<xsl:value-of select="')'"/>
																</expression>
															</ruleAggregatingOrderByNode>
														</ruleAggregatingOrderByWrapper>
														<dqRuleMultiEntityResultWrapper>
															<xsl:for-each select="ruleResultWrapper/ruleResultNode">
																<dqRuleMultiEntityResultNode code="{@name}">
																	<expression><xsl:value-of select="'best.result = '"/><![CDATA[']]><xsl:value-of select="@name"/><![CDATA[']]></expression>
																</dqRuleMultiEntityResultNode>
															</xsl:for-each>
														</dqRuleMultiEntityResultWrapper>			
													</dqMultiEntityExpressionRulesNode>	
												</xsl:for-each>
												
												<xsl:for-each select="//ruleRoot//ruleContainerWrapper/ruleContainerNode/dimRuleWrapper/dimRuleNode[@id=$ruleCode and @dqDimension=$dimensionID]">			
													<dqMultiEntityExpressionRulesNode ruleType="Dimension Rule" ruleTypeLabel="Dimension Rule" name="{@name}" code="{$schemaName}.{$tableName}.{$attributeName}.{$ruleCode}" type="MultiEntityExpressionRule">
														<description><xsl:value-of select="description|@description"/></description>
						
														<acceptanceCondition></acceptanceCondition>
														<ruleColumnWrapper>
															<ruleColumnNode name="PK" type="{$ruleColumnType}"/>
														</ruleColumnWrapper>
														<ruleChildColumnWrapper>
															<ruleColumnNode name="result" type="string"/>
														</ruleChildColumnWrapper>
														<ruleAggregatingOrderByWrapper>
															<ruleAggregatingOrderByNode orderDescending="false" nullsFirst="false">
																<expression>
																	<xsl:value-of select="'case('"/><xsl:text>&#10;</xsl:text>
																	<xsl:value-of select="'result = '"/><![CDATA[']]><xsl:value-of select="'VALID'"/><![CDATA[']]><xsl:value-of select="',0,'"/><xsl:text>&#10;</xsl:text>
																	<xsl:for-each select="ruleExplanationWrapper/ruleExplanationNode">																		
																		<xsl:value-of select="'result = '"/><![CDATA[']]><xsl:value-of select="@name"/><![CDATA[']]><xsl:value-of select="','"/>
																		<xsl:value-of select="position()"/>
																		<xsl:value-of select="','"/><xsl:text>&#10;</xsl:text>																		
																	</xsl:for-each>
																	<xsl:value-of select="position()+10"/><xsl:text>&#10;</xsl:text>
																	<xsl:value-of select="')'"/>
																</expression>
															</ruleAggregatingOrderByNode>
														</ruleAggregatingOrderByWrapper>
														<dqRuleMultiEntityResultWrapper>
															<xsl:for-each select="ruleResultWrapper/ruleResultNode">
																<dqRuleMultiEntityResultNode code="{@name}">
																	<expression><xsl:value-of select="'best.result = '"/><![CDATA[']]><xsl:value-of select="@name"/><![CDATA[']]></expression>
																</dqRuleMultiEntityResultNode>
															</xsl:for-each>
														</dqRuleMultiEntityResultWrapper>
													</dqMultiEntityExpressionRulesNode>
												</xsl:for-each>
												
												<xsl:for-each select="//defaultRuleRoot//defaultRuleContainerWrapper/defaultRuleContainerNode/dimRuleWrapper/dimRuleNode[@id=$ruleCode and @dqDimension=$dimensionID]">			
													<dqMultiEntityExpressionRulesNode ruleType="Dimension Rule" ruleTypeLabel="Dimension Rule" name="{@name}" code="{$schemaName}.{$tableName}.{$attributeName}.{$ruleCode}" type="MultiEntityExpressionRule">
														<description><xsl:value-of select="description|@description"/></description>

														<acceptanceCondition></acceptanceCondition>
														<ruleColumnWrapper>
															<ruleColumnNode name="PK" type="{$ruleColumnType}"/>
														</ruleColumnWrapper>
														<ruleChildColumnWrapper>
															<ruleColumnNode name="result" type="string"/>
														</ruleChildColumnWrapper>
														<ruleAggregatingOrderByWrapper>
															<ruleAggregatingOrderByNode orderDescending="false" nullsFirst="false">
																<expression>
																	<xsl:value-of select="'case('"/><xsl:text>&#10;</xsl:text>
																	<xsl:value-of select="'result = '"/><![CDATA[']]><xsl:value-of select="'VALID'"/><![CDATA[']]><xsl:value-of select="',0,'"/><xsl:text>&#10;</xsl:text>
																	<xsl:for-each select="ruleExplanationWrapper/ruleExplanationNode">																		
																		<xsl:value-of select="'result = '"/><![CDATA[']]><xsl:value-of select="@name"/><![CDATA[']]><xsl:value-of select="','"/>
																		<xsl:value-of select="position()"/>
																		<xsl:value-of select="','"/><xsl:text>&#10;</xsl:text>																		
																	</xsl:for-each>
																	<xsl:value-of select="position()+10"/><xsl:text>&#10;</xsl:text>
																	<xsl:value-of select="')'"/>
																</expression>
															</ruleAggregatingOrderByNode>
														</ruleAggregatingOrderByWrapper>
														<dqRuleMultiEntityResultWrapper>
															<xsl:for-each select="ruleResultWrapper/ruleResultNode">
																<dqRuleMultiEntityResultNode code="{@name}">
																	<expression><xsl:value-of select="'best.result = '"/><![CDATA[']]><xsl:value-of select="@name"/><![CDATA[']]></expression>
																</dqRuleMultiEntityResultNode>
															</xsl:for-each>
														</dqRuleMultiEntityResultWrapper>
													</dqMultiEntityExpressionRulesNode>
												</xsl:for-each>
												
											</xsl:for-each>
																			
										</dqRuleOptionWrapper>
									</dqCollectionRulesOptionNode>
											
				                    <!-- from default rules -->
									<xsl:for-each select="//defaultRuleRoot/defaultRuleContainerWrapper/defaultRuleContainerNode[dimRuleWrapper/dimRuleNode[@dqDimension=$dimensionID]]">
										<dqCollectionRulesOptionNode name="{@name}">
											<dqRuleOptionWrapper>
												<xsl:for-each select="dimRuleWrapper/dimRuleNode[@dqDimension=$dimensionID]">
													<dqPlanRulesNode ruleType="Dimension Rule" ruleTypeLabel="Dimension Rule" description="{@description}" name="{@name}" code="{@id}" type="PlanRule">
														<ruleColumnWrapper>
															<xsl:for-each select="ruleColumnWrapper/ruleColumnNode">
																<ruleColumnNode name="{@name}" type="{@type}"/>
															</xsl:for-each>
														</ruleColumnWrapper>
													</dqPlanRulesNode>
												</xsl:for-each>
											</dqRuleOptionWrapper>
											<!-- LOOP -->
											<xsl:if test="dimRuleWrapper">
												<xsl:call-template name='dimRuleNodeLoop'/>
											</xsl:if>								
										</dqCollectionRulesOptionNode>		
				                    </xsl:for-each>	
                    
                    				<!-- from source system rules -->
									<xsl:for-each select="//sourceSystemRoot/sourceSystemWrapper/*/ruleRoot/ruleContainerWrapper/ruleContainerNode/dimRuleWrapper/dimRuleNode[@dqDimension=$dimensionID]">
										<dqCollectionRulesOptionNode name="{../../@name}">
											<dqRuleOptionWrapper>
												<xsl:for-each select="../dimRuleNode[@dqDimension=$dimensionID]">
													<dqPlanRulesNode ruleType="Dimension Rule" ruleTypeLabel="Dimension Rule" description="{@description}" name="{@name}" code="{@id}" type="PlanRule">
														<ruleColumnWrapper>
															<xsl:for-each select="ruleColumnWrapper/ruleColumnNode">
																<ruleColumnNode name="{@name}" type="{@type}"/>
															</xsl:for-each>
														</ruleColumnWrapper>
													</dqPlanRulesNode>
												</xsl:for-each>
											</dqRuleOptionWrapper>
											<!-- LOOP -->
											<xsl:if test="dimRuleWrapper">
												<xsl:call-template name='dimRuleNodeLoop'/>
											</xsl:if>								
										</dqCollectionRulesOptionNode>
									</xsl:for-each>

                    				<!-- from source system rules without container (root) -->
									<xsl:for-each select="//sourceSystemRoot/sourceSystemWrapper/*/ruleRoot/dimRuleWrapper/dimRuleNode[@dqDimension=$dimensionID]">
										<dqCollectionRulesOptionNode name="root">
											<dqRuleOptionWrapper>
												<xsl:for-each select="../dimRuleNode[@dqDimension=$dimensionID]">
													<dqPlanRulesNode ruleType="Dimension Rule" ruleTypeLabel="Dimension Rule" description="{@description}" name="{@name}" code="{@id}" type="PlanRule">
														<ruleColumnWrapper>
															<xsl:for-each select="ruleColumnWrapper/ruleColumnNode">
																<ruleColumnNode name="{@name}" type="{@type}"/>
															</xsl:for-each>
														</ruleColumnWrapper>
													</dqPlanRulesNode>
												</xsl:for-each>
											</dqRuleOptionWrapper>
											<!-- LOOP -->
											<xsl:if test="dimRuleWrapper">
												<xsl:call-template name='dimRuleNodeLoop'/>
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
						<sourceSystemNode name="{@name}" enable="true" code="{@name}">
							<!-- <xsl:variable name="lMRoot" select="lMRoot"/>-->
							<description></description>
							<modelWrapper>
								<xsl:for-each select="schemaWrapper/schemaNode">
									<modelNode name="{@name}" code="{@name}">
										<xsl:variable name="modelName" select="@name"/>									
										<description></description>
										<lMRoot>
											<!-- <xsl:variable name="lMRoot" select="lMRoot"/>-->										
											<lMTableWrapper>
												<xsl:for-each select="lMRoot/lMTableWrapper/lMTableNode">
													<xsl:variable name="tableName" select="@name"/>
													<lMTableNode name="{@name}">														
														<lMAttributeWrapper>
															<xsl:for-each select="lMAttributeWrapper/lMAttributeNode">
																<xsl:variable name="ruleCode" select="replace(replace(@ruleName,'(.*):\s',''),'\s(.*)','')"/>
																<xsl:choose>
																	<xsl:when test="replace(replace(@ruleName,'(.*):\s',''),'\s(.*)','') = //defaultRuleRoot//defaultRuleContainerWrapper/defaultRuleContainerNode/dimRuleWrapper/dimRuleNode/@id | //sourceSystemRoot/sourceSystemWrapper/*/ruleRoot//dimRuleWrapper/dimRuleNode/@id">
																		<lMAttributeNode businessName="{@businessName}" ruleName="Dimension Rule: {$ruleCode}" name="{@name}" type="{@type}" dbType=""/>
																	</xsl:when>
																	<xsl:when test="replace(replace(@ruleName,'(.*):\s',''),'\s(.*)','') = //defaultRuleRoot//defaultRuleContainerWrapper/defaultRuleContainerNode/defaultRuleWrapper/defaultRuleNode/@id | //sourceSystemRoot/sourceSystemWrapper/*/ruleRoot//ruleWrapper/ruleNode/@id">
																		<lMAttributeNode businessName="{@businessName}" ruleName="Validity Rule: {$ruleCode}" name="{@name}" type="{@type}" dbType=""/>
																	</xsl:when>
																	<xsl:otherwise>
																		<lMAttributeNode businessName="{@businessName}" ruleName="" name="{@name}" type="{@type}" dbType=""/>
																	</xsl:otherwise>
																</xsl:choose>																
															</xsl:for-each>
														</lMAttributeWrapper>
														<lMAttributeCollContainerWrapper>
																														
															<!-- multiEntity -->
															<xsl:variable name="isCentral" select="string(not($tableName = ancestor::lMRoot/lMRelationshipWrapper/lMRelationshipNode/@childTable))"/>
															<xsl:choose>
																<!-- child -->
																<xsl:when test="$isCentral='false'">
																	<xsl:for-each select="lMAttributeWrapper/lMAttributeNode[@ruleName!='']">
																		<xsl:choose>
																			<xsl:when test="replace(replace(@ruleName,'(.*):\s',''),'\s(.*)','') = //defaultRuleRoot//defaultRuleContainerWrapper/defaultRuleContainerNode/dimRuleWrapper/dimRuleNode/@id">
																				<xsl:variable name="ruleCode" select="replace(replace(@ruleName,'(.*):\s',''),'\s(.*)','')"/>
																				<xsl:variable name="ruleName" select="//defaultRuleRoot//defaultRuleContainerWrapper/defaultRuleContainerNode/dimRuleWrapper/dimRuleNode[@id=$ruleCode]/@name"/>
																				<xsl:variable name="notParenth" select="replace(@businessName,'([^\s]+)\s\((.*)\)','$1')"/>																				
																				<lMAttributeCollContainerMultiEntityChild parentInstance="{ancestor::lMRoot/lMTableWrapper/lMTableNode[not(@name = ancestor::lMRoot/lMRelationshipWrapper/lMRelationshipNode/@childTable)]/@name}.{$notParenth}" ruleName="Dimension Rule: {ancestor::schemaNode/@name}.{ancestor::lMTableNode/@name}.{@name}.{replace(@ruleName,'\s(.*)','')}" name="{$notParenth}" code="{ancestor::schemaNode/@name}.{ancestor::lMTableNode/@name}.{@name}">																
																					<lMAttributeChildCollWrapper/>
																					<lMAttributeRuleResultWrapper>
																						<lMAttributeRuleResultNode ruleAttMapping="result" ruleResult="Dimension Rule: {$ruleCode} ({@name})"/>
																					</lMAttributeRuleResultWrapper>
																				</lMAttributeCollContainerMultiEntityChild>
																			</xsl:when>
																			<xsl:when test="replace(replace(@ruleName,'(.*):\s',''),'\s(.*)','') = //sourceSystemRoot/sourceSystemWrapper/*/ruleRoot//dimRuleWrapper/dimRuleNode/@id">
																				<xsl:variable name="ruleCode" select="replace(replace(@ruleName,'(.*):\s',''),'\s(.*)','')"/>
																				<xsl:variable name="ruleName" select="//sourceSystemRoot/sourceSystemWrapper/*/ruleRoot//dimRuleWrapper/dimRuleNode[@id=$ruleCode]/@name"/>
																				<xsl:variable name="notParenth" select="replace(@businessName,'([^\s]+)\s\((.*)\)','$1')"/>
																				<lMAttributeCollContainerMultiEntityChild parentInstance="{ancestor::lMRoot/lMTableWrapper/lMTableNode[not(@name = ancestor::lMRoot/lMRelationshipWrapper/lMRelationshipNode/@childTable)]/@name}.{$notParenth}" ruleName="Dimension Rule: {ancestor::schemaNode/@name}.{ancestor::lMTableNode/@name}.{@name}.{replace(@ruleName,'\s(.*)','')}" name="{$notParenth}" code="{ancestor::schemaNode/@name}.{ancestor::lMTableNode/@name}.{@name}">																
																					<lMAttributeChildCollWrapper/>
																					<lMAttributeRuleResultWrapper>
																						<lMAttributeRuleResultNode ruleAttMapping="result" ruleResult="Dimension Rule: {$ruleCode} ({@name})"/>
																					</lMAttributeRuleResultWrapper>
																				</lMAttributeCollContainerMultiEntityChild>
																			</xsl:when>																			
																			<xsl:when test="replace(replace(@ruleName,'(.*):\s',''),'\s(.*)','') = //defaultRuleRoot//defaultRuleContainerWrapper/defaultRuleContainerNode/defaultRuleWrapper/defaultRuleNode/@id">
																				<xsl:variable name="ruleCode" select="replace(replace(@ruleName,'(.*):\s',''),'\s(.*)','')"/>
																				<xsl:variable name="ruleName" select="//defaultRuleRoot//defaultRuleContainerWrapper/defaultRuleContainerNode/defaultRuleWrapper/defaultRuleNode[@id=$ruleCode]/@name"/>
																				<xsl:variable name="notParenth" select="replace(@businessName,'([^\s]+)\s\((.*)\)','$1')"/>
																				<lMAttributeCollContainerMultiEntityChild parentInstance="{ancestor::lMRoot/lMTableWrapper/lMTableNode[not(@name = ancestor::lMRoot/lMRelationshipWrapper/lMRelationshipNode/@childTable)]/@name}.{$notParenth}" ruleName="Validity Rule: {ancestor::schemaNode/@name}.{ancestor::lMTableNode/@name}.{@name}.{replace(@ruleName,'\s(.*)','')}" name="{$notParenth}" code="{ancestor::schemaNode/@name}.{ancestor::lMTableNode/@name}.{@name}">																
																					<lMAttributeChildCollWrapper/>
																					<lMAttributeRuleResultWrapper>
																						<lMAttributeRuleResultNode ruleAttMapping="result" ruleResult="Validity Rule: {$ruleCode} ({@name})"/>
																					</lMAttributeRuleResultWrapper>
																				</lMAttributeCollContainerMultiEntityChild>
																			</xsl:when>
																			<xsl:when test="replace(replace(@ruleName,'(.*):\s',''),'\s(.*)','') = //sourceSystemRoot/sourceSystemWrapper/*/ruleRoot//ruleWrapper/ruleNode/@id">
																				<xsl:variable name="ruleCode" select="replace(replace(@ruleName,'(.*):\s',''),'\s(.*)','')"/>
																				<xsl:variable name="ruleName" select="//sourceSystemRoot/sourceSystemWrapper/*/ruleRoot//ruleWrapper/ruleNode[@id=$ruleCode]/@name"/>
																				<xsl:variable name="notParenth" select="replace(@businessName,'([^\s]+)\s\((.*)\)','$1')"/>
																				<lMAttributeCollContainerMultiEntityChild parentInstance="{ancestor::lMRoot/lMTableWrapper/lMTableNode[not(@name = ancestor::lMRoot/lMRelationshipWrapper/lMRelationshipNode/@childTable)]/@name}.{$notParenth}" ruleName="Validity Rule: {ancestor::schemaNode/@name}.{ancestor::lMTableNode/@name}.{@name}.{replace(@ruleName,'\s(.*)','')}" name="{$notParenth}" code="{ancestor::schemaNode/@name}.{ancestor::lMTableNode/@name}.{@name}">																
																					<lMAttributeChildCollWrapper/>
																					<lMAttributeRuleResultWrapper>
																						<lMAttributeRuleResultNode ruleAttMapping="result" ruleResult="Validity Rule: {$ruleCode} ({@name})"/>
																					</lMAttributeRuleResultWrapper>
																				</lMAttributeCollContainerMultiEntityChild>
																			</xsl:when>																			
																			<xsl:otherwise></xsl:otherwise>															
																		</xsl:choose>
																	</xsl:for-each>
																	<xsl:for-each select="lMAttributeCollContainerWrapper/lMAttributeCollContainer">
																		<xsl:choose>
																			<xsl:when test="replace(replace(@ruleName,'(.*):\s',''),'\s(.*)','') = //defaultRuleRoot//defaultRuleContainerWrapper/defaultRuleContainerNode/dimRuleWrapper/dimRuleNode/@id">
																				<xsl:variable name="ruleCode" select="replace(replace(@ruleName,'(.*):\s',''),'\s(.*)','')"/>
																				<xsl:variable name="ruleName" select="//defaultRuleRoot//defaultRuleContainerWrapper/defaultRuleContainerNode/dimRuleWrapper/dimRuleNode[@id=$ruleCode]/@name"/>
																				<xsl:variable name="notParenth" select="replace(@name,'([^\s]+)\s\((.*)\)','$1')"/>																		
																				<lMAttributeCollContainerMultiEntityChild parentInstance="{ancestor::lMRoot/lMTableWrapper/lMTableNode[not(@name = ancestor::lMRoot/lMRelationshipWrapper/lMRelationshipNode/@childTable)]/@name}.{$notParenth}" ruleName="Dimension Rule: {ancestor::schemaNode/@name}.{ancestor::lMTableNode/@name}.{$notParenth}.{replace(@ruleName,'\s(.*)','')}" name="{$notParenth}" code="{ancestor::schemaNode/@name}.{ancestor::lMTableNode/@name}.{$notParenth}">																
																					<lMAttributeChildCollWrapper/>
																					<lMAttributeRuleResultWrapper>
																						<lMAttributeRuleResultNode ruleAttMapping="result" ruleResult="Dimension Rule: {$ruleCode} ({$notParenth})"/>
																					</lMAttributeRuleResultWrapper>
																				</lMAttributeCollContainerMultiEntityChild>
																			</xsl:when>
																			<xsl:when test="replace(replace(@ruleName,'(.*):\s',''),'\s(.*)','') = //sourceSystemRoot/sourceSystemWrapper/*/ruleRoot//dimRuleWrapper/dimRuleNode/@id">
																				<xsl:variable name="ruleCode" select="replace(replace(@ruleName,'(.*):\s',''),'\s(.*)','')"/>
																				<xsl:variable name="ruleName" select="//sourceSystemRoot/sourceSystemWrapper/*/ruleRoot//dimRuleWrapper/dimRuleNode[@id=$ruleCode]/@name"/>
																				<xsl:variable name="notParenth" select="replace(@name,'([^\s]+)\s\((.*)\)','$1')"/>
																				<lMAttributeCollContainerMultiEntityChild parentInstance="{ancestor::lMRoot/lMTableWrapper/lMTableNode[not(@name = ancestor::lMRoot/lMRelationshipWrapper/lMRelationshipNode/@childTable)]/@name}.{$notParenth}" ruleName="Dimension Rule: {ancestor::schemaNode/@name}.{ancestor::lMTableNode/@name}.{$notParenth}.{replace(@ruleName,'\s(.*)','')}" name="{$notParenth}" code="{ancestor::schemaNode/@name}.{ancestor::lMTableNode/@name}.{$notParenth}">																
																					<lMAttributeChildCollWrapper/>
																					<lMAttributeRuleResultWrapper>
																						<lMAttributeRuleResultNode ruleAttMapping="result" ruleResult="Dimension Rule: {$ruleCode} ({$notParenth})"/>
																					</lMAttributeRuleResultWrapper>
																				</lMAttributeCollContainerMultiEntityChild>
																			</xsl:when>																			
																			<xsl:when test="replace(replace(@ruleName,'(.*):\s',''),'\s(.*)','') = //defaultRuleRoot//defaultRuleContainerWrapper/defaultRuleContainerNode/defaultRuleWrapper/defaultRuleNode/@id">
																				<xsl:variable name="ruleCode" select="replace(replace(@ruleName,'(.*):\s',''),'\s(.*)','')"/>
																				<xsl:variable name="ruleName" select="//defaultRuleRoot//defaultRuleContainerWrapper/defaultRuleContainerNode/defaultRuleWrapper/defaultRuleNode[@id=$ruleCode]/@name"/>
																				<xsl:variable name="notParenth" select="replace(@name,'([^\s]+)\s\((.*)\)','$1')"/>
																				<lMAttributeCollContainerMultiEntityChild parentInstance="{ancestor::lMRoot/lMTableWrapper/lMTableNode[not(@name = ancestor::lMRoot/lMRelationshipWrapper/lMRelationshipNode/@childTable)]/@name}.{$notParenth}" ruleName="Validity Rule: {ancestor::schemaNode/@name}.{ancestor::lMTableNode/@name}.{$notParenth}.{replace(@ruleName,'\s(.*)','')}" name="{$notParenth}" code="{ancestor::schemaNode/@name}.{ancestor::lMTableNode/@name}.{$notParenth}">																
																					<lMAttributeChildCollWrapper/>
																					<lMAttributeRuleResultWrapper>
																						<lMAttributeRuleResultNode ruleAttMapping="result" ruleResult="Validity Rule: {$ruleCode} ({$notParenth})"/>
																					</lMAttributeRuleResultWrapper>
																				</lMAttributeCollContainerMultiEntityChild>
																			</xsl:when>
																			<xsl:when test="replace(replace(@ruleName,'(.*):\s',''),'\s(.*)','') = //sourceSystemRoot/sourceSystemWrapper/*/ruleRoot//ruleWrapper/ruleNode/@id">
																				<xsl:variable name="ruleCode" select="replace(replace(@ruleName,'(.*):\s',''),'\s(.*)','')"/>
																				<xsl:variable name="ruleName" select="//sourceSystemRoot/sourceSystemWrapper/*/ruleRoot//ruleWrapper/ruleNode[@id=$ruleCode]/@name"/>
																				<xsl:variable name="notParenth" select="replace(@name,'([^\s]+)\s\((.*)\)','$1')"/>
																				<lMAttributeCollContainerMultiEntityChild parentInstance="{ancestor::lMRoot/lMTableWrapper/lMTableNode[not(@name = ancestor::lMRoot/lMRelationshipWrapper/lMRelationshipNode/@childTable)]/@name}.{$notParenth}" ruleName="Validity Rule: {ancestor::schemaNode/@name}.{ancestor::lMTableNode/@name}.{$notParenth}.{replace(@ruleName,'\s(.*)','')}" name="{$notParenth}" code="{ancestor::schemaNode/@name}.{ancestor::lMTableNode/@name}.{$notParenth}">																
																					<lMAttributeChildCollWrapper/>
																					<lMAttributeRuleResultWrapper>
																						<lMAttributeRuleResultNode ruleAttMapping="result" ruleResult="Validity Rule: {$ruleCode} ({$notParenth})"/>
																					</lMAttributeRuleResultWrapper>
																				</lMAttributeCollContainerMultiEntityChild>
																			</xsl:when>																			
																			<xsl:otherwise></xsl:otherwise>															
																		</xsl:choose>
																	</xsl:for-each>
																</xsl:when>
																<!-- parent -->
																<xsl:otherwise>
																	<xsl:for-each select="ancestor::lMRoot/lMTableWrapper/lMTableNode[@name=ancestor::lMRoot/lMRelationshipWrapper/lMRelationshipNode/@childTable]/lMAttributeWrapper/lMAttributeNode[@ruleName!='']">
																		<xsl:variable name="attributeName" select="ancestor::lMTableNode/@name"/>
																		<xsl:variable name="ruleName" select="@ruleName"/>																		
																		<xsl:variable name="notParenth" select="replace(@businessName,'([^\s]+)\s\((.*)\)','$1')"/>
																		<xsl:choose>
																			<xsl:when test="replace(replace($ruleName,'(.*):\s',''),'\s(.*)','') = //defaultRuleRoot//defaultRuleContainerWrapper/defaultRuleContainerNode/dimRuleWrapper/dimRuleNode/@id">																			
																				<xsl:variable name="ruleCode" select="replace(replace(@ruleName,'(.*):\s',''),'\s(.*)','')"/>
																				<xsl:variable name="origRuleName" select="//defaultRuleRoot//defaultRuleContainerWrapper/defaultRuleContainerNode/dimRuleWrapper/dimRuleNode[@id=$ruleCode]/@name"/>
																				<lMAttributeCollContainerMultiEntityParent ruleName="Dimension Rule: {ancestor::schemaNode/@name}.{ancestor::lMTableNode/@name}.{@name}.{replace(@ruleName,'\s(.*)','')}" name="{$notParenth}" code="{ancestor::lMTableNode/@name}.{@name}">																			
																					<lMAttributeCollWrapper>
																						<lMAttributeCollNode ruleAttMapping="PK" attName="{ancestor::lMRoot/lMRelationshipWrapper/lMRelationshipNode[@childTable=$attributeName]/lMForeignKeyWrapper/lMForeignKeyNode/@parentColumn}"/>
																					</lMAttributeCollWrapper>
																				</lMAttributeCollContainerMultiEntityParent>
																			</xsl:when>		
																			<xsl:when test="replace(replace($ruleName,'(.*):\s',''),'\s(.*)','') = //sourceSystemRoot/sourceSystemWrapper/*/ruleRoot//dimRuleWrapper/dimRuleNode/@id">																			
																				<xsl:variable name="ruleCode" select="replace(replace(@ruleName,'(.*):\s',''),'\s(.*)','')"/>
																				<xsl:variable name="origRuleName" select="//sourceSystemRoot/sourceSystemWrapper/*/ruleRoot//dimRuleWrapper/dimRuleNode[@id=$ruleCode]/@name"/>
																				<lMAttributeCollContainerMultiEntityParent ruleName="Dimension Rule: {ancestor::schemaNode/@name}.{ancestor::lMTableNode/@name}.{@name}.{replace(@ruleName,'\s(.*)','')}" name="{$notParenth}" code="{ancestor::lMTableNode/@name}.{@name}">																			
																					<lMAttributeCollWrapper>
																						<lMAttributeCollNode ruleAttMapping="PK" attName="{ancestor::lMRoot/lMRelationshipWrapper/lMRelationshipNode[@childTable=$attributeName]/lMForeignKeyWrapper/lMForeignKeyNode/@parentColumn}"/>
																					</lMAttributeCollWrapper>
																				</lMAttributeCollContainerMultiEntityParent>
																			</xsl:when>	
																			<xsl:when test="replace(replace($ruleName,'(.*):\s',''),'\s(.*)','') = //defaultRuleRoot//defaultRuleContainerWrapper/defaultRuleContainerNode/defaultRuleWrapper/defaultRuleNode/@id">																			
																				<xsl:variable name="ruleCode" select="replace(replace(@ruleName,'(.*):\s',''),'\s(.*)','')"/>
																				<xsl:variable name="origRuleName" select="//defaultRuleRoot//defaultRuleContainerWrapper/defaultRuleContainerNode/defaultRuleWrapper/defaultRuleNode[@id=$ruleCode]/@name"/>
																				<lMAttributeCollContainerMultiEntityParent ruleName="Validity Rule: {ancestor::schemaNode/@name}.{ancestor::lMTableNode/@name}.{@name}.{replace(@ruleName,'\s(.*)','')}" name="{$notParenth}" code="{ancestor::lMTableNode/@name}.{@name}">																			
																					<lMAttributeCollWrapper>
																						<lMAttributeCollNode ruleAttMapping="PK" attName="{ancestor::lMRoot/lMRelationshipWrapper/lMRelationshipNode[@childTable=$attributeName]/lMForeignKeyWrapper/lMForeignKeyNode/@parentColumn}"/>
																					</lMAttributeCollWrapper>
																				</lMAttributeCollContainerMultiEntityParent>
																			</xsl:when>		
																			<xsl:when test="replace(replace($ruleName,'(.*):\s',''),'\s(.*)','') = //sourceSystemRoot/sourceSystemWrapper/*/ruleRoot//ruleWrapper/ruleNode/@id">																			
																				<xsl:variable name="ruleCode" select="replace(replace(@ruleName,'(.*):\s',''),'\s(.*)','')"/>
																				<xsl:variable name="origRuleName" select="//sourceSystemRoot/sourceSystemWrapper/*/ruleRoot//ruleWrapper/ruleNode[@id=$ruleCode]/@name"/>
																				<lMAttributeCollContainerMultiEntityParent ruleName="Validity Rule: {ancestor::schemaNode/@name}.{ancestor::lMTableNode/@name}.{@name}.{replace(@ruleName,'\s(.*)','')}" name="{$notParenth}" code="{ancestor::lMTableNode/@name}.{@name}">																			
																					<lMAttributeCollWrapper>
																						<lMAttributeCollNode ruleAttMapping="PK" attName="{ancestor::lMRoot/lMRelationshipWrapper/lMRelationshipNode[@childTable=$attributeName]/lMForeignKeyWrapper/lMForeignKeyNode/@parentColumn}"/>
																					</lMAttributeCollWrapper>
																				</lMAttributeCollContainerMultiEntityParent>
																			</xsl:when>	
																			<xsl:otherwise></xsl:otherwise>
																		</xsl:choose>
																	</xsl:for-each>	
																	<xsl:for-each select="ancestor::lMRoot/lMTableWrapper/lMTableNode[@name=ancestor::lMRoot/lMRelationshipWrapper/lMRelationshipNode/@childTable]/lMAttributeCollContainerWrapper/lMAttributeCollContainer">
																		<xsl:variable name="attributeName" select="ancestor::lMTableNode/@name"/>
																		<xsl:variable name="ruleName" select="@ruleName"/>
																		<xsl:variable name="notParenth" select="replace(@name,'([^\s]+)\s\((.*)\)','$1')"/>
																		<xsl:choose>
																			<xsl:when test="replace(replace(@ruleName,'(.*):\s',''),'\s(.*)','') = //defaultRuleRoot//defaultRuleContainerWrapper/defaultRuleContainerNode/dimRuleWrapper/dimRuleNode/@id">
																				<xsl:variable name="ruleCode" select="replace(replace(@ruleName,'(.*):\s',''),'\s(.*)','')"/>
																				<xsl:variable name="origRuleName" select="//defaultRuleRoot//defaultRuleContainerWrapper/defaultRuleContainerNode/dimRuleWrapper/dimRuleNode[@id=$ruleCode]/@name"/>
																				<lMAttributeCollContainerMultiEntityParent ruleName="Dimension Rule: {ancestor::schemaNode/@name}.{ancestor::lMTableNode/@name}.{$notParenth}.{replace(@ruleName,'\s(.*)','')}" name="{$notParenth}" code="{ancestor::lMTableNode/@name}.{$notParenth}">																			
																					<lMAttributeCollWrapper>
																						<lMAttributeCollNode ruleAttMapping="PK" attName="{ancestor::lMRoot/lMRelationshipWrapper/lMRelationshipNode[@childTable=$attributeName]/lMForeignKeyWrapper/lMForeignKeyNode/@parentColumn}"/>
																					</lMAttributeCollWrapper>
																				</lMAttributeCollContainerMultiEntityParent>
																			</xsl:when>
																			<xsl:when test="replace(replace(@ruleName,'(.*):\s',''),'\s(.*)','') = //sourceSystemRoot/sourceSystemWrapper/*/ruleRoot//dimRuleWrapper/dimRuleNode/@id">
																				<xsl:variable name="ruleCode" select="replace(replace(@ruleName,'(.*):\s',''),'\s(.*)','')"/>
																				<xsl:variable name="origRuleName" select="//sourceSystemRoot/sourceSystemWrapper/*/ruleRoot//dimRuleWrapper/dimRuleNode[@id=$ruleCode]/@name"/>
																				<lMAttributeCollContainerMultiEntityParent ruleName="Dimension Rule: {ancestor::schemaNode/@name}.{ancestor::lMTableNode/@name}.{$notParenth}.{replace(@ruleName,'\s(.*)','')}" name="{$notParenth}" code="{ancestor::lMTableNode/@name}.{$notParenth}">																			
																					<lMAttributeCollWrapper>
																						<lMAttributeCollNode ruleAttMapping="PK" attName="{ancestor::lMRoot/lMRelationshipWrapper/lMRelationshipNode[@childTable=$attributeName]/lMForeignKeyWrapper/lMForeignKeyNode/@parentColumn}"/>
																					</lMAttributeCollWrapper>
																				</lMAttributeCollContainerMultiEntityParent>
																			</xsl:when>		
																			<xsl:when test="replace(replace(@ruleName,'(.*):\s',''),'\s(.*)','') = //defaultRuleRoot//defaultRuleContainerWrapper/defaultRuleContainerNode/defaultRuleWrapper/defaultRuleNode/@id">
																				<xsl:variable name="ruleCode" select="replace(replace(@ruleName,'(.*):\s',''),'\s(.*)','')"/>
																				<xsl:variable name="origRuleName" select="//defaultRuleRoot//defaultRuleContainerWrapper/defaultRuleContainerNode/defaultRuleWrapper/defaultRuleNode[@id=$ruleCode]/@name"/>																				
																				<lMAttributeCollContainerMultiEntityParent ruleName="Validity Rule: {ancestor::schemaNode/@name}.{ancestor::lMTableNode/@name}.{$notParenth}.{replace(@ruleName,'\s(.*)','')}" name="{$notParenth}" code="{ancestor::lMTableNode/@name}.{$notParenth}">																			
																					<lMAttributeCollWrapper>
																						<lMAttributeCollNode ruleAttMapping="PK" attName="{ancestor::lMRoot/lMRelationshipWrapper/lMRelationshipNode[@childTable=$attributeName]/lMForeignKeyWrapper/lMForeignKeyNode/@parentColumn}"/>
																					</lMAttributeCollWrapper>
																				</lMAttributeCollContainerMultiEntityParent>
																			</xsl:when>
																			<xsl:when test="replace(replace(@ruleName,'(.*):\s',''),'\s(.*)','') = //sourceSystemRoot/sourceSystemWrapper/*/ruleRoot//ruleWrapper/ruleNode/@id">
																				<xsl:variable name="ruleCode" select="replace(replace(@ruleName,'(.*):\s',''),'\s(.*)','')"/>
																				<xsl:variable name="origRuleName" select="//sourceSystemRoot/sourceSystemWrapper/*/ruleRoot//ruleWrapper/ruleNode[@id=$ruleCode]/@name"/>																				
																				<lMAttributeCollContainerMultiEntityParent ruleName="Validity Rule: {ancestor::schemaNode/@name}.{ancestor::lMTableNode/@name}.{$notParenth}.{replace(@ruleName,'\s(.*)','')}" name="{$notParenth}" code="{ancestor::lMTableNode/@name}.{$notParenth}">																			
																					<lMAttributeCollWrapper>
																						<lMAttributeCollNode ruleAttMapping="PK" attName="{ancestor::lMRoot/lMRelationshipWrapper/lMRelationshipNode[@childTable=$attributeName]/lMForeignKeyWrapper/lMForeignKeyNode/@parentColumn}"/>
																					</lMAttributeCollWrapper>
																				</lMAttributeCollContainerMultiEntityParent>
																			</xsl:when>																			
																			<xsl:otherwise></xsl:otherwise>
																		</xsl:choose>
																	</xsl:for-each>	
																</xsl:otherwise>
															</xsl:choose>
															<!-- multiEntity -->
															
															<xsl:for-each select="lMAttributeCollContainerWrapper/lMAttributeCollContainer">
																<xsl:variable name="notParenth" select="replace(@name,'([^\s]+)\s\((.*)\)','$1')"/>
																<xsl:variable name="ruleCode" select="replace(replace(@ruleName,'(.*):\s',''),'\s(.*)','')"/>
																<xsl:choose>
																<xsl:when test="replace(replace(@ruleName,'(.*):\s',''),'\s(.*)','') = //defaultRuleRoot//defaultRuleContainerWrapper/defaultRuleContainerNode/dimRuleWrapper/dimRuleNode/@id | //sourceSystemRoot//sourceSystemWrapper/*/ruleRoot/dimRuleWrapper/dimRuleNode/@id">
																	<lMAttributeCollContainerOneEntity ruleName="Dimension Rule: {$ruleCode}" name="{$notParenth}" code="{$notParenth}">
																		<lMAttributeCollWrapper>
																			<xsl:for-each select="lMAttributeCollWrapper/lMAttributeCollNode">
																				<lMAttributeCollNode ruleAttMapping="{@ruleAttMapping}" attName="{@attName}"/>																				
																			</xsl:for-each>
																		</lMAttributeCollWrapper>
																	</lMAttributeCollContainerOneEntity>
																</xsl:when>
																<xsl:otherwise>
																	<lMAttributeCollContainerOneEntity ruleName="Validity Rule: {$ruleCode}" name="{$notParenth}" code="{$notParenth}">
																		<lMAttributeCollWrapper>
																			<xsl:for-each select="lMAttributeCollWrapper/lMAttributeCollNode">
																				<lMAttributeCollNode ruleAttMapping="{@ruleAttMapping}" attName="{@attName}"/>																				
																			</xsl:for-each>
																		</lMAttributeCollWrapper>
																	</lMAttributeCollContainerOneEntity>
																</xsl:otherwise>	
																</xsl:choose>													
															</xsl:for-each>																																												
														</lMAttributeCollContainerWrapper>														
													</lMTableNode>
												</xsl:for-each>
											</lMTableWrapper>
											<lMRelationshipWrapper>
												<xsl:for-each select="lMRoot/lMRelationshipWrapper/lMRelationshipNode">
													<lMRelationshipNode name="{@name}" parentTable="{@parentTable}" childTable="{@childTable}">
														<lMForeignKeyWrapper>
															<xsl:for-each select="lMForeignKeyWrapper/lMForeignKeyNode">
																<lMForeignKeyNode parentColumn="{@parentColumn}" childColumn="{@childColumn}">
																</lMForeignKeyNode>
															</xsl:for-each>
														</lMForeignKeyWrapper>
													</lMRelationshipNode>
												</xsl:for-each>																							
											</lMRelationshipWrapper>
										</lMRoot>
										<!-- <xsl:variable name="lMRoot" select="lMRoot"/>-->
										<xsl:for-each select="entityRoot">
											<entityRoot name="{@name}" code="{@name}">											
												<entityAttributeWrapper>

													<xsl:for-each select="entityAttributeWrapper/entityAttributeNode">
														<xsl:variable name="entityTableName" select="replace(@name, '(.*)\.(.*)', '$1')"/>
														<xsl:variable name="isCentral" select="string(not($entityTableName = ancestor::lMRoot/lMRelationshipWrapper/lMRelationshipNode/@childTable))"/>																	
														<xsl:variable name="parentCode" select="replace(@name, '(.*):(.*)', '$1')"/>
														<xsl:variable name="ruleCode">
															<xsl:value-of select="ancestor::schemaNode/@name"/>
															<xsl:value-of select="'.'"/>
														 	<xsl:value-of select="replace(@name, ': ', '.')"/>
														</xsl:variable>	
														<xsl:variable name="centralEntity" select="(//lMRoot/lMTableWrapper/lMTableNode[not(@name = //lMRoot/lMRelationshipWrapper/lMRelationshipNode/@childTable)])[last()]/@name"/>													
														<xsl:choose>
															<xsl:when test="$isCentral='true'">
																<entityAttributeNode name="{@name}"/>
															</xsl:when>
															<xsl:otherwise>																
																<entityAttributeNode name="{$centralEntity}.{$parentCode}: {$ruleCode}"/>
															</xsl:otherwise>
														</xsl:choose>																																													
													</xsl:for-each>	
													
												</entityAttributeWrapper>
												<entityContainerWrapper>
													<xsl:for-each select="entityContainerWrapper/entityContainer">
														<xsl:variable name="parentCode" select="replace(entityAttributeWrapper/entityAttributeNode/@name, '(.*):(.*)', '$1')"/>
														<xsl:variable name="ruleCode">
															<xsl:value-of select="ancestor::schemaNode/@name"/>
															<xsl:value-of select="'.'"/>
														 	<xsl:value-of select="replace(entityAttributeWrapper/entityAttributeNode/@name, ': ', '.')"/>
														</xsl:variable>	
														<entityContainer name="{@name}">																													
															<!-- LOOP -->															
															<xsl:if test="entityContainerWrapper/entityContainer">
																<xsl:call-template name='entityContainerLoop'>
																	<!-- <xsl:with-param name="parentCode" select="$parentCode"/>-->
																	<!-- <xsl:with-param name="ruleCode" select="$ruleCode"/>-->
																</xsl:call-template>
															</xsl:if>
															<entityAttributeWrapper>
													
																<xsl:for-each select="entityAttributeWrapper/entityAttributeNode">
																	<xsl:variable name="entityTableName" select="replace(@name, '(.*)\.(.*)', '$1')"/>
																	<xsl:variable name="isCentral" select="string(not($entityTableName = //lMRoot/lMRelationshipWrapper/lMRelationshipNode/@childTable))"/>																	
																	<xsl:variable name="parentCode" select="replace(@name, '(.*):(.*)', '$1')"/>
																	<xsl:variable name="ruleCode">
																		<xsl:value-of select="ancestor::schemaNode/@name"/>
																		<xsl:value-of select="'.'"/>
																	 	<xsl:value-of select="replace(@name, ': ', '.')"/>
																	</xsl:variable>	
																	<xsl:variable name="centralEntity" select="(//lMRoot/lMTableWrapper/lMTableNode[not(@name = //lMRoot/lMRelationshipWrapper/lMRelationshipNode/@childTable)])[last()]/@name"/>		
																	<xsl:choose>
																		<xsl:when test="$isCentral='true'">
																			<entityAttributeNode name="{@name}"/>
																		</xsl:when>
																		<xsl:otherwise>																				
																			<entityAttributeNode name="{$centralEntity}.{$parentCode}: {$ruleCode}"/>																															
																		</xsl:otherwise>
																	</xsl:choose>																																													
																</xsl:for-each>		
																													
															</entityAttributeWrapper>													
														</entityContainer>	
													</xsl:for-each>																							
												</entityContainerWrapper>
											</entityRoot>
										</xsl:for-each>
										<dimensionWrapper>											
											<xsl:for-each select="../../dimensionWrapper/dimensionNode">												
												<xsl:for-each select="columnWrapper/columnNode">
													<xsl:variable name="filterModelName" select="replace(@column,'([^\.]+)\.([^\.]+)\.([^\.]+)', '$1')"/>
														<xsl:if test="$filterModelName=$modelName">
															<dimensionNode name="{../../@name}" column="{@column}"/>
														</xsl:if>
												</xsl:for-each>																													
											</xsl:for-each>										
										</dimensionWrapper>										
									</modelNode>
								</xsl:for-each>
							</modelWrapper>
							<ruleRoot ruleType="Validity Rule">
														
								<collectionRulesOptionWrapper>
									<!-- Aggregation rules -->
									<collectionRulesOptionNode name="Aggregation rules">						
										<ruleOptionWrapper>
											<!-- tables -->
											<xsl:for-each select="schemaWrapper/schemaNode/lMRoot/lMTableWrapper/lMTableNode[@name=ancestor::lMRoot/lMRelationshipWrapper/lMRelationshipNode/@childTable]/lMAttributeWrapper/lMAttributeNode[@ruleName!='']">																		
												<xsl:variable name="schemaName" select="ancestor::schemaNode/@name"/>
												<xsl:variable name="tableName" select="ancestor::lMTableNode/@name"/>
												<xsl:variable name="attributeName" select="@name"/>
												<xsl:variable name="ruleCode" select="replace(@ruleName,'\s(.*)','')"/><!-- replace(replace(@ruleName,'(.*):\s',''),'([^\s]+)\s\((.*)\)','$1') -->
												<xsl:variable name="ruleName" select="replace(@ruleName, '([^\s]+)\s\((.*)\)', '$2')"/>
												<xsl:variable name="ruleColumnType" select="ancestor::lMTableNode/lMAttributeWrapper/lMAttributeNode[@name=ancestor::lMRoot/lMRelationshipWrapper/lMRelationshipNode[@childTable=$tableName]/lMForeignKeyWrapper/lMForeignKeyNode/@parentColumn]/@type"/>
												<xsl:variable name="notParenth" select="replace(@name,'([^\s]+)\s\((.*)\)','$1')"/>
												<xsl:variable name="selectionType" select="ancestor::lMRoot/lMRelationshipWrapper/lMRelationshipNode/lMSortOrderWrapper/lMSortOrderNode[@name=concat($ruleName,' (',$attributeName,')')]/@selectionType"/>
												<xsl:for-each select="//ruleRoot/ruleWrapper/ruleNode[@id=$ruleCode]">
													<multiEntityExpressionRulesNode ruleType="Validity Rule" ruleTypeLabel="Validity Rule" name="{@name}" code="{$schemaName}.{$tableName}.{$notParenth}.{$ruleCode}" type="MultiEntityExpressionRule">
														<description><xsl:value-of select="description|@description"/></description>
														<xsl:choose>
															<xsl:when test="$selectionType='all'">
																<validity><![CDATA[count(result) > 0 and countif(result != 'VALID') = 0]]></validity>
															</xsl:when>
															<xsl:otherwise>
																<validity><![CDATA[best.result = 'VALID']]></validity>
															</xsl:otherwise>
														</xsl:choose>
														<acceptanceCondition></acceptanceCondition>
														<ruleColumnWrapper>
															<ruleColumnNode name="PK" type="{$ruleColumnType}"/>
														</ruleColumnWrapper>
														<ruleChildColumnWrapper>
															<ruleColumnNode name="result" type="string"/>
														</ruleChildColumnWrapper>
														<ruleAggregatingOrderByWrapper>
															<ruleAggregatingOrderByNode orderDescending="false" nullsFirst="false">
																<expression>
																	<xsl:choose>
																		<xsl:when test="$selectionType='all'">
																			<xsl:value-of select="'case('"/><xsl:text>&#10;</xsl:text>																			
																			<xsl:for-each select="ruleExplanationWrapper/ruleExplanationNode">																		
																				<xsl:value-of select="'result = '"/><![CDATA[']]><xsl:value-of select="@name"/><![CDATA[']]><xsl:value-of select="','"/>
																				<xsl:value-of select="position()-1"/>
																				<xsl:value-of select="','"/><xsl:text>&#10;</xsl:text>																		
																			</xsl:for-each>
																			<xsl:value-of select="position()+10"/><xsl:text>&#10;</xsl:text>
																			<xsl:value-of select="')'"/>
																		</xsl:when>
																		<xsl:otherwise>
																			<xsl:value-of select="'case('"/><xsl:text>&#10;</xsl:text>
																			<xsl:value-of select="'result = '"/><![CDATA[']]><xsl:value-of select="'VALID'"/><![CDATA[']]><xsl:value-of select="',0,'"/><xsl:text>&#10;</xsl:text>
																			<xsl:for-each select="ruleExplanationWrapper/ruleExplanationNode">																		
																				<xsl:value-of select="'result = '"/><![CDATA[']]><xsl:value-of select="@name"/><![CDATA[']]><xsl:value-of select="','"/>
																				<xsl:value-of select="position()"/>
																				<xsl:value-of select="','"/><xsl:text>&#10;</xsl:text>																		
																			</xsl:for-each>
																			<xsl:value-of select="position()+10"/><xsl:text>&#10;</xsl:text>
																			<xsl:value-of select="')'"/>
																		</xsl:otherwise>
																	</xsl:choose>
																</expression>
															</ruleAggregatingOrderByNode>
														</ruleAggregatingOrderByWrapper>
														<ruleMultiEntityExpressionWrapper>
															<xsl:for-each select="ruleExplanationWrapper/ruleExplanationNode">
																<ruleMultiEntityExpressionNode description="{@description}" code="{@name}">
																	<expression><xsl:value-of select="'best.result = '"/><![CDATA[']]><xsl:value-of select="@name"/><![CDATA[']]></expression>
																</ruleMultiEntityExpressionNode>
															</xsl:for-each>
														</ruleMultiEntityExpressionWrapper>
													</multiEntityExpressionRulesNode>	
												</xsl:for-each>	
												
												<xsl:for-each select="//ruleRoot//ruleContainerWrapper/ruleContainerNode/ruleWrapper/ruleNode[@id=$ruleCode]">			
													<multiEntityExpressionRulesNode ruleType="Validity Rule" ruleTypeLabel="Validity Rule" name="{@name}" code="{$schemaName}.{$tableName}.{$notParenth}.{$ruleCode}" type="MultiEntityExpressionRule">
														<description><xsl:value-of select="description|@description"/></description>
														<xsl:choose>
															<xsl:when test="$selectionType='all'">
																<validity><![CDATA[count(result) > 0 and countif(result != 'VALID') = 0]]></validity>
															</xsl:when>
															<xsl:otherwise>
																<validity><![CDATA[best.result = 'VALID']]></validity>
															</xsl:otherwise>
														</xsl:choose>
														<acceptanceCondition></acceptanceCondition>
														<ruleColumnWrapper>
															<ruleColumnNode name="PK" type="{$ruleColumnType}"/>
														</ruleColumnWrapper>
														<ruleChildColumnWrapper>
															<ruleColumnNode name="result" type="string"/>
														</ruleChildColumnWrapper>
														<ruleAggregatingOrderByWrapper>
															<ruleAggregatingOrderByNode orderDescending="false" nullsFirst="false">
																<expression>
																	<xsl:choose>
																		<xsl:when test="$selectionType='all'">
																			<xsl:value-of select="'case('"/><xsl:text>&#10;</xsl:text>																			
																			<xsl:for-each select="ruleExplanationWrapper/ruleExplanationNode">																		
																				<xsl:value-of select="'result = '"/><![CDATA[']]><xsl:value-of select="@name"/><![CDATA[']]><xsl:value-of select="','"/>
																				<xsl:value-of select="position()-1"/>
																				<xsl:value-of select="','"/><xsl:text>&#10;</xsl:text>																		
																			</xsl:for-each>
																			<xsl:value-of select="position()+10"/><xsl:text>&#10;</xsl:text>
																			<xsl:value-of select="')'"/>
																		</xsl:when>
																		<xsl:otherwise>
																			<xsl:value-of select="'case('"/><xsl:text>&#10;</xsl:text>
																			<xsl:value-of select="'result = '"/><![CDATA[']]><xsl:value-of select="'VALID'"/><![CDATA[']]><xsl:value-of select="',0,'"/><xsl:text>&#10;</xsl:text>
																			<xsl:for-each select="ruleExplanationWrapper/ruleExplanationNode">																		
																				<xsl:value-of select="'result = '"/><![CDATA[']]><xsl:value-of select="@name"/><![CDATA[']]><xsl:value-of select="','"/>
																				<xsl:value-of select="position()"/>
																				<xsl:value-of select="','"/><xsl:text>&#10;</xsl:text>																		
																			</xsl:for-each>
																			<xsl:value-of select="position()+10"/><xsl:text>&#10;</xsl:text>
																			<xsl:value-of select="')'"/>
																		</xsl:otherwise>
																	</xsl:choose>
																</expression>
															</ruleAggregatingOrderByNode>
														</ruleAggregatingOrderByWrapper>
														<ruleMultiEntityExpressionWrapper>
															<xsl:for-each select="ruleExplanationWrapper/ruleExplanationNode">
																<ruleMultiEntityExpressionNode description="{@description}" code="{@name}">
																	<expression><xsl:value-of select="'best.result = '"/><![CDATA[']]><xsl:value-of select="@name"/><![CDATA[']]></expression>
																</ruleMultiEntityExpressionNode>
															</xsl:for-each>
														</ruleMultiEntityExpressionWrapper>
													</multiEntityExpressionRulesNode>
												</xsl:for-each>
												
												<xsl:for-each select="//defaultRuleRoot//defaultRuleContainerWrapper/defaultRuleContainerNode/defaultRuleWrapper/defaultRuleNode[@id=$ruleCode]">			
													<multiEntityExpressionRulesNode ruleType="Validity Rule" ruleTypeLabel="Validity Rule" name="{@name}" code="{$schemaName}.{$tableName}.{$notParenth}.{$ruleCode}" type="MultiEntityExpressionRule">
														<description><xsl:value-of select="description|@description"/></description>
														<xsl:choose>
															<xsl:when test="$selectionType='all'">
																<validity><![CDATA[count(result) > 0 and countif(result != 'VALID') = 0]]></validity>
															</xsl:when>
															<xsl:otherwise>
																<validity><![CDATA[best.result = 'VALID']]></validity>
															</xsl:otherwise>
														</xsl:choose>
														<acceptanceCondition></acceptanceCondition>
														<ruleColumnWrapper>
															<ruleColumnNode name="PK" type="{$ruleColumnType}"/>
														</ruleColumnWrapper>
														<ruleChildColumnWrapper>
															<ruleColumnNode name="result" type="string"/>
														</ruleChildColumnWrapper>
														<ruleAggregatingOrderByWrapper>
															<ruleAggregatingOrderByNode orderDescending="false" nullsFirst="false">
																<expression>
																	<xsl:choose>
																		<xsl:when test="$selectionType='all'">
																			<xsl:value-of select="'case('"/><xsl:text>&#10;</xsl:text>																			
																			<xsl:for-each select="ruleExplanationWrapper/ruleExplanationNode">																		
																				<xsl:value-of select="'result = '"/><![CDATA[']]><xsl:value-of select="@name"/><![CDATA[']]><xsl:value-of select="','"/>
																				<xsl:value-of select="position()-1"/>
																				<xsl:value-of select="','"/><xsl:text>&#10;</xsl:text>																		
																			</xsl:for-each>
																			<xsl:value-of select="position()+10"/><xsl:text>&#10;</xsl:text>
																			<xsl:value-of select="')'"/>
																		</xsl:when>
																		<xsl:otherwise>
																			<xsl:value-of select="'case('"/><xsl:text>&#10;</xsl:text>
																			<xsl:value-of select="'result = '"/><![CDATA[']]><xsl:value-of select="'VALID'"/><![CDATA[']]><xsl:value-of select="',0,'"/><xsl:text>&#10;</xsl:text>
																			<xsl:for-each select="ruleExplanationWrapper/ruleExplanationNode">																		
																				<xsl:value-of select="'result = '"/><![CDATA[']]><xsl:value-of select="@name"/><![CDATA[']]><xsl:value-of select="','"/>
																				<xsl:value-of select="position()"/>
																				<xsl:value-of select="','"/><xsl:text>&#10;</xsl:text>																		
																			</xsl:for-each>
																			<xsl:value-of select="position()+10"/><xsl:text>&#10;</xsl:text>
																			<xsl:value-of select="')'"/>
																		</xsl:otherwise>
																	</xsl:choose>
																</expression>
															</ruleAggregatingOrderByNode>
														</ruleAggregatingOrderByWrapper>
														<ruleMultiEntityExpressionWrapper>
															<xsl:for-each select="ruleExplanationWrapper/ruleExplanationNode">
																<ruleMultiEntityExpressionNode description="{@description}" code="{@name}">
																	<expression><xsl:value-of select="'best.result = '"/><![CDATA[']]><xsl:value-of select="@name"/><![CDATA[']]></expression>
																</ruleMultiEntityExpressionNode>
															</xsl:for-each>
														</ruleMultiEntityExpressionWrapper>
													</multiEntityExpressionRulesNode>
												</xsl:for-each>
												
											</xsl:for-each>
											<!-- collections -->
									
											<xsl:for-each select="schemaWrapper/schemaNode/lMRoot/lMTableWrapper/lMTableNode[@name=ancestor::lMRoot/lMRelationshipWrapper/lMRelationshipNode/@childTable]/lMAttributeCollContainerWrapper/lMAttributeCollContainer">																		
												<xsl:variable name="schemaName" select="ancestor::schemaNode/@name"/>
												<xsl:variable name="tableName" select="ancestor::lMTableNode/@name"/>
												<xsl:variable name="attributeName" select="@name"/>
												<xsl:variable name="ruleCode" select="replace(@ruleName,'\s(.*)','')"/><!-- replace(replace(@ruleName,'(.*):\s',''),'([^\s]+)\s\((.*)\)','$1') -->
												<xsl:variable name="ruleName" select="replace(@ruleName, '([^\s]+)\s\((.*)\)', '$2')"/>
												<xsl:variable name="ruleColumnType" select="ancestor::lMAttributeNode[@name=ancestor::lMRoot/lMRelationshipWrapper/lMRelationshipNode[@childTable=$tableName]/lMForeignKeyWrapper/lMForeignKeyNode/@parentColumn]/@type"/>
												<xsl:variable name="notParenth" select="replace(@name,'([^\s]+)\s\((.*)\)','$1')"/>
												<xsl:variable name="selectionType" select="ancestor::lMRoot/lMRelationshipWrapper/lMRelationshipNode/lMSortOrderWrapper/lMSortOrderNode[@name=concat($ruleName,' (',$attributeName,')')]/@selectionType"/>
												<xsl:for-each select="//ruleRoot/ruleWrapper/ruleNode[@id=$ruleCode]">
													<multiEntityExpressionRulesNode ruleType="Validity Rule" ruleTypeLabel="Validity Rule" name="{@name}" code="{$schemaName}.{$tableName}.{$notParenth}.{$ruleCode}" type="MultiEntityExpressionRule">
														<description><xsl:value-of select="description|@description"/></description>
														<xsl:choose>
															<xsl:when test="$selectionType='all'">
																<validity><![CDATA[count(result) > 0 and countif(result != 'VALID') = 0]]></validity>
															</xsl:when>
															<xsl:otherwise>
																<validity><![CDATA[best.result = 'VALID']]></validity>
															</xsl:otherwise>
														</xsl:choose>
														<acceptanceCondition></acceptanceCondition>
														<ruleColumnWrapper>
															<ruleColumnNode name="PK" type="{$ruleColumnType}"/>
														</ruleColumnWrapper>
														<ruleChildColumnWrapper>
															<ruleColumnNode name="result" type="string"/>
														</ruleChildColumnWrapper>
														<ruleAggregatingOrderByWrapper>
															<ruleAggregatingOrderByNode orderDescending="false" nullsFirst="false">
																<expression>
																	<xsl:choose>
																		<xsl:when test="$selectionType='all'">
																			<xsl:value-of select="'case('"/><xsl:text>&#10;</xsl:text>																			
																			<xsl:for-each select="ruleExplanationWrapper/ruleExplanationNode">																		
																				<xsl:value-of select="'result = '"/><![CDATA[']]><xsl:value-of select="@name"/><![CDATA[']]><xsl:value-of select="','"/>
																				<xsl:value-of select="position()-1"/>
																				<xsl:value-of select="','"/><xsl:text>&#10;</xsl:text>																		
																			</xsl:for-each>
																			<xsl:value-of select="position()+10"/><xsl:text>&#10;</xsl:text>
																			<xsl:value-of select="')'"/>
																		</xsl:when>
																		<xsl:otherwise>
																			<xsl:value-of select="'case('"/><xsl:text>&#10;</xsl:text>
																			<xsl:value-of select="'result = '"/><![CDATA[']]><xsl:value-of select="'VALID'"/><![CDATA[']]><xsl:value-of select="',0,'"/><xsl:text>&#10;</xsl:text>
																			<xsl:for-each select="ruleExplanationWrapper/ruleExplanationNode">																		
																				<xsl:value-of select="'result = '"/><![CDATA[']]><xsl:value-of select="@name"/><![CDATA[']]><xsl:value-of select="','"/>
																				<xsl:value-of select="position()"/>
																				<xsl:value-of select="','"/><xsl:text>&#10;</xsl:text>																		
																			</xsl:for-each>
																			<xsl:value-of select="position()+10"/><xsl:text>&#10;</xsl:text>
																			<xsl:value-of select="')'"/>
																		</xsl:otherwise>
																	</xsl:choose>
																</expression>
															</ruleAggregatingOrderByNode>
														</ruleAggregatingOrderByWrapper>
														<ruleMultiEntityExpressionWrapper>
															<xsl:for-each select="ruleExplanationWrapper/ruleExplanationNode">
																<ruleMultiEntityExpressionNode description="{@description}" code="{@name}">
																	<expression><xsl:value-of select="'best.result = '"/><![CDATA[']]><xsl:value-of select="@name"/><![CDATA[']]></expression>
																</ruleMultiEntityExpressionNode>
															</xsl:for-each>
														</ruleMultiEntityExpressionWrapper>
													</multiEntityExpressionRulesNode>								
												</xsl:for-each>
												
												<xsl:for-each select="//ruleRoot//ruleContainerWrapper/ruleContainerNode/ruleWrapper/ruleNode[@id=$ruleCode]">			
													<multiEntityExpressionRulesNode ruleType="Validity Rule" ruleTypeLabel="Validity Rule" name="{@name}" code="{$schemaName}.{$tableName}.{$notParenth}.{$ruleCode}" type="MultiEntityExpressionRule">
														<description><xsl:value-of select="description|@description"/></description>
														<xsl:choose>
															<xsl:when test="$selectionType='all'">
																<validity><![CDATA[count(result) > 0 and countif(result != 'VALID') = 0]]></validity>
															</xsl:when>
															<xsl:otherwise>
																<validity><![CDATA[best.result = 'VALID']]></validity>
															</xsl:otherwise>
														</xsl:choose>
														<acceptanceCondition></acceptanceCondition>
														<ruleColumnWrapper>
															<ruleColumnNode name="PK" type="{$ruleColumnType}"/>
														</ruleColumnWrapper>
														<ruleChildColumnWrapper>
															<ruleColumnNode name="result" type="string"/>
														</ruleChildColumnWrapper>
														<ruleAggregatingOrderByWrapper>
															<ruleAggregatingOrderByNode orderDescending="false" nullsFirst="false">
																<expression>
																	<xsl:choose>
																		<xsl:when test="$selectionType='all'">
																			<xsl:value-of select="'case('"/><xsl:text>&#10;</xsl:text>																			
																			<xsl:for-each select="ruleExplanationWrapper/ruleExplanationNode">																		
																				<xsl:value-of select="'result = '"/><![CDATA[']]><xsl:value-of select="@name"/><![CDATA[']]><xsl:value-of select="','"/>
																				<xsl:value-of select="position()-1"/>
																				<xsl:value-of select="','"/><xsl:text>&#10;</xsl:text>																		
																			</xsl:for-each>
																			<xsl:value-of select="position()+10"/><xsl:text>&#10;</xsl:text>
																			<xsl:value-of select="')'"/>
																		</xsl:when>
																		<xsl:otherwise>
																			<xsl:value-of select="'case('"/><xsl:text>&#10;</xsl:text>
																			<xsl:value-of select="'result = '"/><![CDATA[']]><xsl:value-of select="'VALID'"/><![CDATA[']]><xsl:value-of select="',0,'"/><xsl:text>&#10;</xsl:text>
																			<xsl:for-each select="ruleExplanationWrapper/ruleExplanationNode">																		
																				<xsl:value-of select="'result = '"/><![CDATA[']]><xsl:value-of select="@name"/><![CDATA[']]><xsl:value-of select="','"/>
																				<xsl:value-of select="position()"/>
																				<xsl:value-of select="','"/><xsl:text>&#10;</xsl:text>																		
																			</xsl:for-each>
																			<xsl:value-of select="position()+10"/><xsl:text>&#10;</xsl:text>
																			<xsl:value-of select="')'"/>
																		</xsl:otherwise>
																	</xsl:choose>
																</expression>
															</ruleAggregatingOrderByNode>
														</ruleAggregatingOrderByWrapper>
														<ruleMultiEntityExpressionWrapper>
															<xsl:for-each select="ruleExplanationWrapper/ruleExplanationNode">
																<ruleMultiEntityExpressionNode description="{@description}" code="{@name}">
																	<expression><xsl:value-of select="'best.result = '"/><![CDATA[']]><xsl:value-of select="@name"/><![CDATA[']]></expression>
																</ruleMultiEntityExpressionNode>
															</xsl:for-each>
														</ruleMultiEntityExpressionWrapper>
													</multiEntityExpressionRulesNode>
												</xsl:for-each>
												
												<xsl:for-each select="//defaultRuleRoot//defaultRuleContainerWrapper/defaultRuleContainerNode/defaultRuleWrapper/defaultRuleNode[@id=$ruleCode]">			
													<multiEntityExpressionRulesNode ruleType="Validity Rule" ruleTypeLabel="Validity Rule" name="{@name}" code="{$schemaName}.{$tableName}.{$notParenth}.{$ruleCode}" type="MultiEntityExpressionRule">
														<description><xsl:value-of select="description|@description"/></description>
														<xsl:choose>
															<xsl:when test="$selectionType='all'">
																<validity><![CDATA[count(result) > 0 and countif(result != 'VALID') = 0]]></validity>
															</xsl:when>
															<xsl:otherwise>
																<validity><![CDATA[best.result = 'VALID']]></validity>
															</xsl:otherwise>
														</xsl:choose>
														<acceptanceCondition></acceptanceCondition>
														<ruleColumnWrapper>
															<ruleColumnNode name="PK" type="{$ruleColumnType}"/>
														</ruleColumnWrapper>
														<ruleChildColumnWrapper>
															<ruleColumnNode name="result" type="string"/>
														</ruleChildColumnWrapper>
														<ruleAggregatingOrderByWrapper>
															<ruleAggregatingOrderByNode orderDescending="false" nullsFirst="false">
																<expression>
																	<xsl:choose>
																		<xsl:when test="$selectionType='all'">
																			<xsl:value-of select="'case('"/><xsl:text>&#10;</xsl:text>																			
																			<xsl:for-each select="ruleExplanationWrapper/ruleExplanationNode">																		
																				<xsl:value-of select="'result = '"/><![CDATA[']]><xsl:value-of select="@name"/><![CDATA[']]><xsl:value-of select="','"/>
																				<xsl:value-of select="position()-1"/>
																				<xsl:value-of select="','"/><xsl:text>&#10;</xsl:text>																		
																			</xsl:for-each>
																			<xsl:value-of select="position()+10"/><xsl:text>&#10;</xsl:text>
																			<xsl:value-of select="')'"/>
																		</xsl:when>
																		<xsl:otherwise>
																			<xsl:value-of select="'case('"/><xsl:text>&#10;</xsl:text>
																			<xsl:value-of select="'result = '"/><![CDATA[']]><xsl:value-of select="'VALID'"/><![CDATA[']]><xsl:value-of select="',0,'"/><xsl:text>&#10;</xsl:text>
																			<xsl:for-each select="ruleExplanationWrapper/ruleExplanationNode">																		
																				<xsl:value-of select="'result = '"/><![CDATA[']]><xsl:value-of select="@name"/><![CDATA[']]><xsl:value-of select="','"/>
																				<xsl:value-of select="position()"/>
																				<xsl:value-of select="','"/><xsl:text>&#10;</xsl:text>																		
																			</xsl:for-each>
																			<xsl:value-of select="position()+10"/><xsl:text>&#10;</xsl:text>
																			<xsl:value-of select="')'"/>
																		</xsl:otherwise>
																	</xsl:choose>
																</expression>
															</ruleAggregatingOrderByNode>
														</ruleAggregatingOrderByWrapper>
														<ruleMultiEntityExpressionWrapper>
															<xsl:for-each select="ruleExplanationWrapper/ruleExplanationNode">
																<ruleMultiEntityExpressionNode description="{@description}" code="{@name}">
																	<expression><xsl:value-of select="'best.result = '"/><![CDATA[']]><xsl:value-of select="@name"/><![CDATA[']]></expression>
																</ruleMultiEntityExpressionNode>
															</xsl:for-each>
														</ruleMultiEntityExpressionWrapper>
													</multiEntityExpressionRulesNode>
												</xsl:for-each>
												
											</xsl:for-each>										
										</ruleOptionWrapper>						
									</collectionRulesOptionNode>
									<!-- Aggregation rules -->
								
									<!-- rules in root without container -->
									<xsl:for-each select="ruleRoot">
										<collectionRulesOptionNode name="root">
											<ruleOptionWrapper>
												<xsl:for-each select="ruleWrapper/ruleNode">
													<planRulesNode ruleType="Validity Rule" ruleTypeLabel="Validity Rule" planFile="" name="{@name}" code="{@id}" type="PlanRule">
														<description><xsl:value-of select="description|@description"/></description>
														<ruleColumnWrapper>
															<xsl:for-each select="ruleColumnWrapper/ruleColumnNode">
																<ruleColumnNode name="{@name}" type="{@type}"/>
															</xsl:for-each>
														</ruleColumnWrapper>
														<ruleExplanationWrapper>
															<xsl:for-each select="ruleExplanationWrapper/ruleExplanationNode">
																<ruleExplanationNode description="{@description}" code="{@name}"/>								
															</xsl:for-each>
														</ruleExplanationWrapper>
													</planRulesNode>
												</xsl:for-each>
											</ruleOptionWrapper>
											<!-- tady uz LOOP --> <!-- rules in container -->
											<xsl:if test="ruleContainerWrapper">
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

			<masterEntityRoot>
				<masterEntityWrapper>
					<xsl:for-each select="masterEntityRoot/masterEntityWrapper/masterEntityNode">
						<masterEntityNode name="{@name}" code="{@name}">
							<masterEntityRelationshipWrapper>
								<xsl:for-each select="masterEntityRelationshipWrapper/masterEntityRelationshipNode">
									<xsl:variable name="businessEntityName" select="replace(@name,'([^\.]+)\.([^\.]+)\.([^\.]+)','$3')"/>
									<xsl:variable name="first" select="replace(@name,'([^\.]+)\.([^\.]+)\.([^\.]+)','$1')"/>
									<xsl:variable name="second" select="replace(@name,'([^\.]+)\.([^\.]+)\.([^\.]+)','$2')"/>
									<xsl:variable name="withoutBusinessEntityName">
										<xsl:value-of select="$first"/>
										<xsl:value-of select="'.'"/>
										<xsl:value-of select="$second"/>
									</xsl:variable>
									<xsl:variable name="entityRootName" select="//sourceSystemRoot/sourceSystemWrapper/sourceSystemNode[@name=$first]/schemaWrapper/schemaNode[@name=$second]/entityRoot/@name"/>								
									<xsl:variable name="entityRoot" select="//sourceSystemRoot/sourceSystemWrapper/sourceSystemNode[@name=$first]/schemaWrapper/schemaNode[@name=$second]/entityRoot"/>
									<xsl:choose>										
										<xsl:when test="$businessEntityName=$entityRootName">
											<masterEntityRelationshipNode name="{$withoutBusinessEntityName}"/>
										</xsl:when>
										<xsl:otherwise>
											<xsl:call-template name='masterEntityRelationshipNodeName'>
												<xsl:with-param name="name" select="@name"/>
												<xsl:with-param name="entityRootName" select="$entityRootName"/>
												<xsl:with-param name="entityRoot" select="$entityRoot"/>
											</xsl:call-template>
										</xsl:otherwise>
									</xsl:choose>								
								</xsl:for-each>
							</masterEntityRelationshipWrapper>
							<!-- LOOP -->	
							<xsl:if test="masterEntityWrapper">
								<xsl:call-template name='masterEntityLoop'/>
							</xsl:if>					
						</masterEntityNode>
					</xsl:for-each>
				</masterEntityWrapper>
			</masterEntityRoot>
													
			<defaultRuleRoot ruleType="Validity Rule">
				<collectionRulesOptionWrapper>																															
					<xsl:for-each select="defaultRuleRoot/defaultRuleContainerWrapper/defaultRuleContainerNode">
						<xsl:if test="defaultRuleWrapper/defaultRuleNode">
							<collectionRulesOptionNode name="{@name}">
								<ruleOptionWrapper>
									<xsl:for-each select="defaultRuleWrapper/defaultRuleNode">
										<planRulesNode ruleType="Validity Rule" ruleTypeLabel="Validity Rule" planFile="" name="{@name}" code="{@id}" type="PlanRule">
											<description><xsl:value-of select="description|@description"/></description>
											<ruleColumnWrapper>
												<xsl:for-each select="ruleColumnWrapper/ruleColumnNode">
													<ruleColumnNode name="{@name}" type="{@type}"/>
												</xsl:for-each>
											</ruleColumnWrapper>
											<ruleExplanationWrapper>
												<xsl:for-each select="ruleExplanationWrapper/ruleExplanationNode">
													<ruleExplanationNode description="{@description}" code="{@name}"/>								
												</xsl:for-each>
											</ruleExplanationWrapper>
										</planRulesNode>
									</xsl:for-each>
								</ruleOptionWrapper>
								<!-- LOOP -->
								<xsl:if test="defaultRuleContainerWrapper">
									<xsl:call-template name='defaultRuleNodeLoop'/>
								</xsl:if>							
							</collectionRulesOptionNode>
						</xsl:if>
					</xsl:for-each>									
				</collectionRulesOptionWrapper>							
			</defaultRuleRoot>	
		 </md>
	</xsl:template>
	
	<xsl:template name="masterEntityLoop">
		<masterEntityWrapper>
			<xsl:for-each select="masterEntityWrapper/masterEntityNode">
				<masterEntityNode name="{@name}" code="{@name}">
					<masterEntityRelationshipWrapper>
						<xsl:for-each select="masterEntityRelationshipWrapper/masterEntityRelationshipNode">
							<xsl:variable name="businessEntityName" select="replace(@name,'([^\.]+)\.([^\.]+)\.([^\.]+)','$3')"/>
							<xsl:variable name="first" select="replace(@name,'([^\.]+)\.([^\.]+)\.([^\.]+)','$1')"/>
							<xsl:variable name="second" select="replace(@name,'([^\.]+)\.([^\.]+)\.([^\.]+)','$2')"/>
							<xsl:variable name="withoutBusinessEntityName">
								<xsl:value-of select="$first"/>
								<xsl:value-of select="'.'"/>
								<xsl:value-of select="$second"/>
							</xsl:variable>
							<xsl:variable name="entityRootName" select="//sourceSystemRoot/sourceSystemWrapper/sourceSystemNode[@name=$first]/schemaWrapper/schemaNode[@name=$second]/entityRoot/@name"/>
							<xsl:variable name="entityRoot" select="//sourceSystemRoot/sourceSystemWrapper/sourceSystemNode[@name=$first]/schemaWrapper/schemaNode[@name=$second]/entityRoot"/>
							<xsl:choose>										
								<xsl:when test="$businessEntityName=$entityRootName">
									<masterEntityRelationshipNode name="{$withoutBusinessEntityName}"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:call-template name='masterEntityRelationshipNodeName'>
										<xsl:with-param name="name" select="@name"/>
										<xsl:with-param name="entityRootName" select="$entityRootName"/>
										<xsl:with-param name="entityRoot" select="$entityRoot"/>
									</xsl:call-template>
								</xsl:otherwise>
							</xsl:choose>	
						</xsl:for-each>
					</masterEntityRelationshipWrapper>
					<!-- LOOP -->	
					<xsl:if test="masterEntityWrapper">
						<xsl:call-template name='masterEntityLoop'/>
					</xsl:if>					
				</masterEntityNode>
			</xsl:for-each>
		</masterEntityWrapper>
	</xsl:template>
	
	<xsl:template name="masterEntityRelationshipNodeName">
		<xsl:param name="name"/>
		<xsl:param name="entityRootName"/>
		<xsl:param name="entityRoot"/>
		<xsl:variable name="businessEntityName" select="replace($name,'([^\.]+)\.([^\.]+)\.([^\.]+)','$3')"/>
		<xsl:variable name="first" select="replace($name,'([^\.]+)\.([^\.]+)\.([^\.]+)','$1')"/>
		<xsl:variable name="second" select="replace($name,'([^\.]+)\.([^\.]+)\.([^\.]+)','$2')"/>
		<xsl:for-each select="$entityRoot/entityContainerWrapper/entityContainer">		
			<xsl:choose>
				<xsl:when test="$businessEntityName=@name">
					<masterEntityRelationshipNode name="{concat($first,'.',$second,'.',$businessEntityName)}"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:call-template name="masterEntityRelationshipNodeNameLoop">
						<xsl:with-param name="concat" select="@name"/>
						<xsl:with-param name="parent" select="@name"/>
						<xsl:with-param name="entityContainer" select="$entityRoot/entityContainerWrapper/entityContainer"/>
						<xsl:with-param name="name" select="$name"/>
					</xsl:call-template>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:for-each>	
	</xsl:template>
	
	<xsl:template name="masterEntityRelationshipNodeNameLoop">
		<xsl:param name="concat"/>
		<xsl:param name="parent"/>
		<xsl:param name="entityContainer"/>
		<xsl:param name="name"/>
		<xsl:variable name="businessEntityName" select="replace($name,'([^\.]+)\.([^\.]+)\.([^\.]+)','$3')"/>
		<xsl:variable name="first" select="replace($name,'([^\.]+)\.([^\.]+)\.([^\.]+)','$1')"/>
		<xsl:variable name="second" select="replace($name,'([^\.]+)\.([^\.]+)\.([^\.]+)','$2')"/>
				
		<xsl:for-each select="$entityContainer[@name=$parent]/entityContainerWrapper/entityContainer">
			<xsl:choose>
				<xsl:when test="$businessEntityName=@name">
					<masterEntityRelationshipNode name="{concat($first,'.',$second,'.',$concat,'.',$businessEntityName)}"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:call-template name="masterEntityRelationshipNodeNameLoop">
						<xsl:with-param name="concat" select="concat($concat,'.',@name)"/>
						<xsl:with-param name="parent" select="@name"/>
						<xsl:with-param name="entityContainer" select="$entityContainer/entityContainerWrapper/entityContainer"/>
						<xsl:with-param name="name" select="$name"/>
					</xsl:call-template>
				</xsl:otherwise>
			</xsl:choose>		
		</xsl:for-each>
		
	</xsl:template>

	<xsl:template name="entityContainerLoop">
		<!-- <xsl:param name="parentCode"/>-->
		<!-- <xsl:param name="ruleCode"/>-->
		<entityContainerWrapper>		
			<xsl:for-each select="entityContainerWrapper/entityContainer">
				<xsl:variable name="parentCode" select="replace(entityAttributeWrapper/entityAttributeNode/@name, '(.*):(.*)', '$1')"/>
				<xsl:variable name="ruleCode">
					<xsl:value-of select="ancestor::schemaNode/@name"/>
					<xsl:value-of select="'.'"/>
				 	<xsl:value-of select="replace(entityAttributeWrapper/entityAttributeNode/@name, ': ', '.')"/>
				</xsl:variable>	
				<entityContainer name="{@name}">					
					<!-- LOOP -->	
					<xsl:if test="entityContainerWrapper">
						<xsl:call-template name='entityContainerLoop'>
							<!-- <xsl:with-param name="parentCode" select="$parentCode"/>-->
							<!--<xsl:with-param name="ruleCode" select="$ruleCode"/>-->
						</xsl:call-template>
					</xsl:if>					
				</entityContainer>				
			</xsl:for-each>
		</entityContainerWrapper>
		<entityAttributeWrapper>
			<xsl:for-each select="entityAttributeWrapper/entityAttributeNode">
				<xsl:variable name="entityTableName" select="replace(@name, '(.*)\.(.*)', '$1')"/>
				<xsl:variable name="isCentral" select="string(not($entityTableName = //lMRoot/lMRelationshipWrapper/lMRelationshipNode/@childTable))"/>																	
				<xsl:variable name="centralEntity" select="(//lMRoot/lMTableWrapper/lMTableNode[not(@name = //lMRoot/lMRelationshipWrapper/lMRelationshipNode/@childTable)])[last()]/@name"/>
				<xsl:variable name="parentCode" select="replace(@name, '(.*):(.*)', '$1')"/>
				<xsl:variable name="ruleCode">
					<xsl:value-of select="ancestor::schemaNode/@name"/>
					<xsl:value-of select="'.'"/>
				 	<xsl:value-of select="replace(@name, ': ', '.')"/>
				</xsl:variable>
				<xsl:choose>
					<xsl:when test="$isCentral='true'">
						<entityAttributeNode name="{@name}"/>
					</xsl:when>
					<xsl:otherwise>	
						<entityAttributeNode name="{$centralEntity}.{$parentCode}: {$ruleCode}"/>
					</xsl:otherwise>
				</xsl:choose>																																													
			</xsl:for-each>																
		</entityAttributeWrapper>	
	</xsl:template>

	<xsl:template name="ruleNodeLoop">
		<collectionRulesOptionWrapper>
			<xsl:for-each select="ruleContainerWrapper/ruleContainerNode">
				<collectionRulesOptionNode name="{@name}">
					<ruleOptionWrapper>
						<xsl:for-each select="ruleWrapper/ruleNode">
							<planRulesNode ruleType="Validity Rule" ruleTypeLabel="Validity Rule" planFile="" name="{@name}" code="{@id}" type="PlanRule">
								<description><xsl:value-of select="description|@description"/></description>
								<ruleColumnWrapper>
									<xsl:for-each select="ruleColumnWrapper/ruleColumnNode">
										<ruleColumnNode name="{@name}" type="{@type}"/>
									</xsl:for-each>
								</ruleColumnWrapper>
								<ruleExplanationWrapper>
									<xsl:for-each select="ruleExplanationWrapper/ruleExplanationNode">
										<ruleExplanationNode description="{@description}" code="{@name}"/>								
									</xsl:for-each>
								</ruleExplanationWrapper>
							</planRulesNode>
						</xsl:for-each>
					</ruleOptionWrapper>
					<!-- LOOP -->
					<xsl:if test="ruleContainerWrapper">
						<xsl:call-template name='ruleNodeLoop'/>
					</xsl:if>																								
				</collectionRulesOptionNode>
			</xsl:for-each>
		</collectionRulesOptionWrapper>
	</xsl:template>

	<xsl:template name="dimRuleNodeLoop">
		<dqCollectionRulesOptionWrapper>
			<xsl:for-each select="ruleContainerWrapper/ruleContainerNode">
				<dqCollectionRulesOptionNode name="{@name}">
					<dqRuleOptionWrapper>
						<xsl:for-each select="dimRuleWrapper/dimRuleNode">
							<dqPlanRulesNode ruleType="Dimension Rule" ruleTypeLabel="Dimension Rule" description="{@description}" name="{@name}" code="{@id}" type="PlanRule">
								<ruleColumnWrapper>
									<xsl:for-each select="ruleColumnWrapper/ruleColumnNode">
										<ruleColumnNode name="{@name}" type="{@type}"/>
									</xsl:for-each>
								</ruleColumnWrapper>
							</dqPlanRulesNode>
						</xsl:for-each>
					</dqRuleOptionWrapper>
					<!-- LOOP -->
					<xsl:if test="dimRuleWrapper">
						<xsl:call-template name='dimRuleNodeLoop'/>
					</xsl:if>								
				</dqCollectionRulesOptionNode>
			</xsl:for-each>
		</dqCollectionRulesOptionWrapper>
	</xsl:template>

	<xsl:template name="defaultRuleNodeLoop">
		<collectionRulesOptionWrapper>
			<xsl:for-each select="defaultRuleContainerWrapper/defaultRuleContainerNode">
				<xsl:if test="defaultRuleWrapper/defaultRuleNode">
					<collectionRulesOptionNode name="{@name}">
						<ruleOptionWrapper>
							<xsl:for-each select="defaultRuleWrapper/defaultRuleNode">
								<planRulesNode ruleType="Validity Rule" ruleTypeLabel="Validity Rule" planFile="" name="{@name}" code="{@id}" type="PlanRule">
									<description><xsl:value-of select="description|@description"/></description>
									<ruleColumnWrapper>
										<xsl:for-each select="ruleColumnWrapper/ruleColumnNode">
											<ruleColumnNode name="{@name}" type="{@type}"/>
										</xsl:for-each>
									</ruleColumnWrapper>
									<ruleExplanationWrapper>
										<xsl:for-each select="ruleExplanationWrapper/ruleExplanationNode">
											<ruleExplanationNode description="{@description}" code="{@name}"/>								
										</xsl:for-each>
									</ruleExplanationWrapper>
								</planRulesNode>
							</xsl:for-each>
						</ruleOptionWrapper>
						<!-- LOOP -->
						<xsl:if test="defaultRuleContainerWrapper">
							<xsl:call-template name='defaultRuleNodeLoop'/>
						</xsl:if>							
					</collectionRulesOptionNode>
				</xsl:if>
			</xsl:for-each>					
		</collectionRulesOptionWrapper>
	</xsl:template>

</xsl:stylesheet>
