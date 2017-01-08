<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
        xmlns:sf="http://www.ataccama.com/xslt/functions"
        exclude-result-prefixes="sf">
<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>

<xsl:include href="constants_incl.xsl"/>

	<xsl:template match="/*">
		<dqd-config>
			<xsl:apply-templates select="preferenceRoot"/>
			<xsl:apply-templates select="sourceSystemRoot"/>
      <xsl:apply-templates select="masterEntityRoot"/>   
			<xsl:apply-templates select="defaultRuleRoot"/>
      <xsl:apply-templates select="dqDimensionRoot"/>
		</dqd-config>
	</xsl:template>	

  <!-- =========================================================================== -->

  <!-- PREFERENCES -->
  
	<xsl:template match="preferenceRoot">
		<preferences>
			<datamart><xsl:value-of select="@datamart"/></datamart>
			   <xsl:choose>
			       <xsl:when test="@effectiveDate='ParameterDateProvider'">
			           <effectiveDateProvider class="com.ataccama.dqd.engine.sources.date.ParameterDateProvider" parameter="effective_date" format="yyyy-MM-dd HH:mm:ss" />
			       </xsl:when>
			       <xsl:when test="@effectiveDate='PlanDateProvider'">
			           <effectiveDateProvider class="com.ataccama.dqd.engine.sources.date.PlanDateProvider" planFileName="../engine/load/effective_date.comp" />
			       </xsl:when>
			       <xsl:otherwise></xsl:otherwise>
			   </xsl:choose>	
			   <!--dataSample-->
			   <drillThrough>
			   	  <xsl:if test="dataSample/@outputDir!=''">
				      <fullOutput>         
				          <outputDirectory><xsl:value-of select="dataSample/@outputDir"/></outputDirectory>
				          <fileNamePattern><xsl:value-of select="dataSample/@fileNamePattern"/></fileNamePattern>
				      </fullOutput>
			       </xsl:if>
			       <sampleSize><xsl:value-of select="dataSample/@sampleSize"/></sampleSize>          
			   </drillThrough>
			   <filterCombinationLimit><xsl:value-of select="@filterCombLimit"/></filterCombinationLimit>
			   <!--dataSample-->
		</preferences>
	</xsl:template>
  
  <!-- =========================================================================== -->
  
  <!-- SOURCE SYSTEMS -->	

	<xsl:template match="sourceSystemRoot">
		<systems>
			<xsl:for-each select="sourceSystemWrapper/sourceSystemNode[@enable='true']">
				<system code="{@code}" name="{@name}">
          <xsl:attribute name="description">
            <xsl:value-of select="description|@description"/>
          </xsl:attribute>
          
					<models>
						<xsl:for-each select="modelWrapper/modelNode">
							<model code="{@code}" name="{@name}">
                <xsl:attribute name="description">
                  <xsl:value-of select="description"/>
                </xsl:attribute>
                
                <source class="com.ataccama.dqd.engine.sources.PlanDataSource">
                  <xsl:attribute name="planFileName">
                    <xsl:value-of select="'../engine/load/'" />
                    <xsl:value-of select="../../@code" />
                    <xsl:value-of select="'_'" />
                    <xsl:value-of select="@code" />
                    <xsl:value-of select="'.comp'" />
                  </xsl:attribute>
                </source>
                          
								<entities>
                <!-- columns,rules,multiEntityRules,relationships -->
                  <xsl:call-template name="entityRoot"/>
								</entities>
                
								<filters>
									<xsl:for-each select="dimensionWrapper/dimensionNode">
										<filter name="{@name}" columnName="{cc/@columnName}"/>
									</xsl:for-each>
								</filters>
                
								<aggregations>
									<xsl:call-template name="aggregation"/>
								</aggregations>
                
							</model>
						</xsl:for-each>
					</models>
				</system>
			</xsl:for-each>
		</systems>
	</xsl:template>

  <!-- ============================================= -->  
  <xsl:template name="entityRoot">
   <xsl:for-each select="lMRoot/lMTableWrapper/lMTableNode">  
              
  	<entity name="{@name}">
      
      <xsl:choose>                                          
        <xsl:when test="centralEntityNode/@centralEntity='true'">
          <xsl:attribute name="centralEntity">
            <xsl:value-of select="centralEntityNode/@centralEntity" />
          </xsl:attribute>
        </xsl:when>
        <xsl:otherwise></xsl:otherwise>
      </xsl:choose>  
        
      <xsl:variable name="entity" select="@name"/>

  		<columns>
        <xsl:for-each select="lMAttributeWrapper/lMAttributeNode">  
				   <column name="{@name}" type="{@type}" label="{@businessName}"/>
        </xsl:for-each>
  		</columns>
      
  		<rules>
        
        <xsl:for-each select="lMAttributeWrapper/lMAttributeNode[cc/@hasRule='true']"> 
          <!--<xsl:if test ="not(preceding::lMAttributeNode[cc/@ruleId = current()/cc/@ruleId])">-->
    			  <rule>   
              <xsl:attribute name="code">
                  <xsl:value-of select="../../../../../../../@code" />
                  <xsl:value-of select="'.'" />
                  <xsl:value-of select="../../../../../@code" />
                  <xsl:value-of select="'.'" />
                  <xsl:value-of select="../../@name" />
                  <xsl:value-of select="'.'" />
                  <xsl:value-of select="@name" />                
                  <xsl:value-of select="'.'" />
                  <xsl:value-of select="cc/@ruleCode" />                  
                  
              </xsl:attribute>
              <xsl:attribute name="name">
                <xsl:value-of select="@businessName" />
              </xsl:attribute> 
              <xsl:attribute name="rule">
                <xsl:value-of select="cc/@ruleCode" />
              </xsl:attribute>   
              <!--        
              <xsl:attribute name="mappingType">
                <xsl:value-of select="'column'" />
              </xsl:attribute>  
              -->     			   
              <xsl:variable name="ruleCode" select="cc/@ruleCode"/>	
            
             <mapping>
              	<!--<xsl:for-each select="../lMAttributeNode/cc[@ruleId=$ruleId]">-->
                    
                    <!--<xsl:if test="cc/@hasRule='true'">-->
                               
            					<column entityColumn="{@name}">
                        <xsl:attribute name="ruleColumn">
                            <xsl:value-of select="ancestor::md/defaultRuleRoot//collectionRulesOptionWrapper/collectionRulesOptionNode/ruleOptionWrapper/*[@code=$ruleCode]/ruleColumnWrapper/ruleColumnNode/@name"/>
                            <xsl:value-of select="ancestor::md/dqDimensionRoot//dqDimensionWrapper/dqDimensionNode/dqRuleRoot/dqCollectionRulesOptionWrapper/dqCollectionRulesOptionNode/dqRuleOptionWrapper/*[@code=$ruleCode]/ruleColumnWrapper/ruleColumnNode/@name"/>
                            <xsl:value-of select="ancestor::md/sourceSystemRoot/sourceSystemWrapper/sourceSystemNode/ruleRoot//collectionRulesOptionWrapper/collectionRulesOptionNode/ruleOptionWrapper/*[@code=$ruleCode]/ruleColumnWrapper/ruleColumnNode/@name"/>
                        
                        </xsl:attribute>
                      </column>              
            				
                    
                  
              	<!--</xsl:for-each>--> 
              </mapping>
            </rule>

          <!--</xsl:if>--> 
        </xsl:for-each>
        
        <!-- ATTRIBUTE COLLECTIONS -->
        
        <!-- rules applied in collection (One Entity rules) -->
        <xsl:for-each select="lMAttributeCollContainerWrapper/lMAttributeCollContainerOneEntity">
            <rule>
            
              <xsl:attribute name="code">
                  <xsl:value-of select="../../../../../../../@code" />
                  <xsl:value-of select="'.'" />
                  <xsl:value-of select="../../../../../@code" />
                  <xsl:value-of select="'.'" />
                  <xsl:value-of select="../../@name" />
                  <xsl:value-of select="'.'" />
                  <xsl:value-of select="@code" />
                  <xsl:value-of select="'.'" />
                  <xsl:value-of select="cc/@ruleCode" />
              </xsl:attribute>
              <xsl:attribute name="name">
                <xsl:value-of select="@name" />
              </xsl:attribute> 
              <xsl:attribute name="rule">
                <xsl:value-of select="cc/@ruleCode" />
              </xsl:attribute> 
              <xsl:attribute name="mappingType">
                <xsl:value-of select="'collection'" />
              </xsl:attribute> 
              <xsl:attribute name="collectionCode">
                  <xsl:value-of select="../../../../../../../@code" />
                  <xsl:value-of select="'.'" />
                  <xsl:value-of select="../../../../../@code" />
                  <xsl:value-of select="'.'" />
                  <xsl:value-of select="../../@name" />
                  <xsl:value-of select="'.'" />
                  <xsl:value-of select="@code" />                
              </xsl:attribute> 
              <xsl:attribute name="collectionName">
                <xsl:value-of select="@name" />
              </xsl:attribute>                                   
                  
              <mapping>
                  <xsl:for-each select="lMAttributeCollWrapper/lMAttributeCollNode">
                      <column>
                        <xsl:attribute name="entityColumn">
                            <xsl:value-of select="@attName"/>
                        </xsl:attribute>
                        <xsl:attribute name="ruleColumn">
                            <xsl:value-of select="@ruleAttMapping"/>
                        </xsl:attribute>                          
                      </column>
                  </xsl:for-each> 
              </mapping> 
                  
             </rule>      
          </xsl:for-each>
          

        
  		</rules>
      
  		<multiEntityRules>
         <!-- rules applied in collection (Multi Entity rules) -->
         <xsl:for-each select="lMAttributeCollContainerWrapper/lMAttributeCollContainerMultiEntityParent">
         <xsl:variable name="parentTable" select="ancestor::lMTableNode"/>
            <rule>
            
              <xsl:attribute name="code">
                  <xsl:value-of select="../../../../../../../@code" />
                  <xsl:value-of select="'.'" />
                  <xsl:value-of select="../../../../../@code" />
                  <xsl:value-of select="'.'" />
                  <xsl:value-of select="../../@name" />
                  <xsl:value-of select="'.'" />
                  <xsl:value-of select="@code" />
                  <xsl:value-of select="'.'" />
                  <xsl:value-of select="cc/@ruleCode" />
              </xsl:attribute>
              <xsl:attribute name="name">
                <xsl:value-of select="@name" />
              </xsl:attribute> 
              <xsl:attribute name="rule">
                <xsl:value-of select="cc/@ruleCode" />
              </xsl:attribute> 
              <xsl:attribute name="mappingType">
                <xsl:value-of select="'collection'" />
              </xsl:attribute> 
              <xsl:attribute name="collectionCode">
                  <xsl:value-of select="../../../../../../../@code" />
                  <xsl:value-of select="'.'" />
                  <xsl:value-of select="../../../../../@code" />
                  <xsl:value-of select="'.'" />
                  <xsl:value-of select="../../@name" />
                  <xsl:value-of select="'.'" />
                  <xsl:value-of select="@code" />                
              </xsl:attribute> 
              <xsl:attribute name="collectionName">
                <xsl:value-of select="@name" />
              </xsl:attribute>  
                             
                  
              <mapping>
              	  <columns>
                  <xsl:for-each select="lMAttributeCollWrapper/lMAttributeCollNode">
                      <column>
                        <xsl:attribute name="entityColumn">
                            <xsl:value-of select="@attName"/>
                        </xsl:attribute>
                        <xsl:attribute name="ruleColumn">
                            <xsl:value-of select="@ruleAttMapping"/>
                        </xsl:attribute>                          
                      </column>
                  </xsl:for-each> 
                  </columns>
                  
                  <xsl:for-each select="ancestor::lMTableWrapper/lMTableNode/lMAttributeCollContainerWrapper/lMAttributeCollContainerMultiEntityChild[@parentInstance=concat($parentTable/@name,'.',current()/@code)]">  <!-- it is just one child for now -->
                  <xsl:variable name="childTable" select="ancestor::lMTableNode"/>
                  <childEntities>
                  		<childEntity relationship="{ancestor::lMRoot/lMRelationshipWrapper/lMRelationshipNode[@parentTable=$parentTable/@name and @childTable=$childTable/@name]/@name}">
                  			<columns>
                  				<!-- child column mapping -->
                  				<xsl:for-each select="lMAttributeChildCollWrapper/lMAttributeChildCollNode">
                  					<column entityColumn="{@attName}" ruleColumn="{@ruleAttMapping}"/>
                  				</xsl:for-each>
                  				
                  				 <!-- mapping of rule result on child -->
                  				 <xsl:for-each select="lMAttributeRuleResultWrapper/lMAttributeRuleResultNode">
                  				 	<!-- parse rule code from format 'genericRule: SimpleCopyAddress' -->
                  				 	<xsl:variable name="ruleCode" select="replace(replace(@ruleResult, '(.*):\s', ''),'\s(.*)','')"/> 
                  				 	<xsl:variable name="ruleAttrCode" select="replace(@ruleResult, '.*\((.*)\)', '$1')"/> 
                  				 	<column entityRuleResult="{ancestor::sourceSystemNode/@code}.{ancestor::modelNode/@code}.{ancestor::lMTableNode/@name}.{$ruleAttrCode}.{$ruleCode}" ruleColumn="{@ruleAttMapping}"/>
                  				</xsl:for-each>
                  			</columns>
                  		</childEntity>
                  </childEntities>
                  
                  </xsl:for-each>
                            
                  
              </mapping> 
                  
             </rule>      
             </xsl:for-each>
  		</multiEntityRules>	
   		
  		<relationships>
        <xsl:for-each select="../../lMRelationshipWrapper/lMRelationshipNode[@parentTable=$entity]">
          <xsl:call-template name="entityRelationships"/>
        </xsl:for-each> 
  		</relationships>	
      						
  	</entity> 
    </xsl:for-each>      
  </xsl:template> 
  <!-- ============================================= --> 

  <!--  
  <xsl:template name="multiEntityRules">

		<rule>
      <xsl:attribute name="code">
      </xsl:attribute>
      <xsl:attribute name="name">
      </xsl:attribute> 
      <xsl:attribute name="rule">
      </xsl:attribute>   
                        
			<mapping>
				<columns>
					<column entityColumn="" ruleColumn="" />
				</columns>
				<childEntities>
          <childEntity relationship="">
					  <columns>
					  	<column entityRuleInvalidityReason="" ruleColumn="" />
					  </columns>
          </childEntity>
				</childEntities>
			</mapping>
		</rule>

  </xsl:template> 
  -->
  <!-- ============================================= -->

  <xsl:template name="entityRelationships"> 
      <relationship name="{@name}" childEntity="{@childTable}">
    		<foreignKeys>
            <xsl:for-each select="lMForeignKeyWrapper/lMForeignKeyNode">
    			     <foreignKey parentColumn="{@parentColumn}" foreignKeyColumn="{@childColumn}" />
            </xsl:for-each>
    		</foreignKeys>
    	</relationship>
  </xsl:template>
  <!-- ============================================= -->
  <xsl:template name="aggregation">
    <xsl:for-each select="entityRoot">
    
      <xsl:variable name="system" select="../../../@code"/>
      <xsl:variable name="model" select="../@code"/>

      
			<!--main one aggr-->
      <aggregation name="{@name}" >
      <xsl:attribute name="code">
        <xsl:value-of select="$system" />
        <xsl:value-of select="'.'" />
        <xsl:value-of select="$model" /> 
        <!--<xsl:value-of select="'.'" /> 
        <xsl:value-of select="@code" /> -->
      </xsl:attribute>
      <!--main one aggr--> 
      
          <!--variable code = $system.$model-->
           <xsl:variable name="code" select="concat($system,'.',$model)"/>
           <xsl:variable name="baseCode" select="concat($system,'.',$model)"/>
          
             <xsl:choose>
            <xsl:when test="entityContainerWrapper/entityContainer">   
              <!--loop-->		        
                <aggregations>
                  <xsl:call-template name="aggregationLoop">
                      <xsl:with-param name="code" select="$code"/>
                      <xsl:with-param name="baseCode" select="$baseCode"/>
                  </xsl:call-template>  
                </aggregations>
              <!--loop--> 
            </xsl:when>
            <xsl:otherwise/>
          </xsl:choose>
          <xsl:choose>
            <xsl:when test="entityAttributeWrapper/entityAttributeNode">
                <rules>
                  <xsl:for-each select="entityAttributeWrapper/entityAttributeNode">
    					      <rule>
                        <xsl:attribute name="ruleInstance">
                            <xsl:value-of select="$baseCode" />
                            <xsl:value-of select="'.'" />
                            <xsl:value-of select="cc/@tableName" />
                            <xsl:value-of select="'.'" />
                            <xsl:value-of select="cc/@attributeName" />
                            <xsl:value-of select="'.'" />
                            <xsl:value-of select="cc/@ruleCode" />  
                        </xsl:attribute>
                    </rule>
                  </xsl:for-each>  
  					    </rules>
            </xsl:when>
            <xsl:otherwise/>
         </xsl:choose>      
        
			</aggregation>
    </xsl:for-each>  
  </xsl:template> 
  <!--===============================================================-->
  <xsl:template name="aggregationLoop">
    <xsl:param name="system"/>
    <xsl:param name="model"/> 
    <xsl:param name="code"/>
    <xsl:param name="baseCode"/> 
      <xsl:for-each select="entityContainerWrapper/entityContainer"> 
         
         <aggregation name="{@name}">
          <xsl:attribute name="code">
            <!--<xsl:value-of select="$code" />-->
            <xsl:value-of select="$code" />
            <xsl:value-of select="'.'" />
            <xsl:value-of select="@name" />   
          </xsl:attribute>
                      
            <xsl:choose>
              <xsl:when test="entityContainerWrapper/entityContainer">
                <aggregations>
                  <xsl:call-template name="aggregationLoop">
                      <xsl:with-param name="code" select="concat($code,'.',@name)"/>
                      <xsl:with-param name="baseCode" select="$baseCode"/>
                  </xsl:call-template>
                </aggregations>
              </xsl:when>
              <xsl:otherwise/>
            </xsl:choose>
            <xsl:variable name="ruleCode" select="concat($code,'.',@name)"/>
            <xsl:choose>
              <xsl:when test="entityAttributeWrapper/entityAttributeNode">
                  <rules>
                    <xsl:for-each select="entityAttributeWrapper/entityAttributeNode">
      					      <rule>
                          <xsl:attribute name="ruleInstance">
                            <xsl:value-of select="$baseCode" />
                            <xsl:value-of select="'.'" />
                            <xsl:value-of select="cc/@tableName" />
                            <xsl:value-of select="'.'" />
                            <xsl:value-of select="cc/@attributeName" />
                            <xsl:value-of select="'.'" />
                            <xsl:value-of select="cc/@ruleCode" />  
                          </xsl:attribute>
                      </rule>
                    </xsl:for-each>  
  						    </rules>
              </xsl:when>
              <xsl:otherwise/>
            </xsl:choose>
          </aggregation>
      </xsl:for-each>
  </xsl:template>
   
  <!-- =========================================================================== --> 

  <!-- MASTER ENTITIES -->

  <xsl:template match="masterEntityRoot">
    <masterEntities>
      <xsl:for-each select="masterEntityWrapper/masterEntityNode">
          <masterEntity code="{@code}" name="{@name}">
            <aggregations>
              <xsl:for-each select="masterEntityRelationshipWrapper/masterEntityRelationshipNode[cc/@sourceSystemName=ancestor::md/sourceSystemRoot/sourceSystemWrapper/sourceSystemNode[@enable='true']/@code]">  
  				        <aggregation><xsl:value-of select="@name"/></aggregation>
              </xsl:for-each>
  			    </aggregations>          
            <xsl:choose>
              <xsl:when test="masterEntityWrapper/masterEntityNode">  
              	<subEntities>
                  <xsl:call-template name="masterEntityLoop">
                    <xsl:with-param name="code" select="@code"/>
                  </xsl:call-template>
                </subEntities>
              </xsl:when>
              <xsl:otherwise/>
            </xsl:choose>
          </masterEntity>
       </xsl:for-each>
    </masterEntities>
  </xsl:template>
  <!--=============================================-->
  <xsl:template name="masterEntityLoop">
    <xsl:param name="code"/>
 
      <xsl:for-each select="masterEntityWrapper/masterEntityNode">
        <masterEntity code="{$code}.{@code}" name="{@name}">
			    
          <aggregations>
            <xsl:for-each select="masterEntityRelationshipWrapper/masterEntityRelationshipNode[cc/@sourceSystemName=ancestor::md/sourceSystemRoot/sourceSystemWrapper/sourceSystemNode[@enable='true']/@code]">  
				        <aggregation><xsl:value-of select="@name"/></aggregation>
            </xsl:for-each>
			    </aggregations>

          <xsl:choose>
            <xsl:when test="masterEntityWrapper/masterEntityNode">
		   	      <subEntities>
                  <xsl:call-template name="masterEntityLoop">
                      <xsl:with-param name="code" select="concat($code,'.',@code)"/>
                  </xsl:call-template>
              </subEntities>
            </xsl:when>
            <xsl:otherwise/>
          </xsl:choose>
          
        </masterEntity>
      </xsl:for-each>    
    
  </xsl:template> 
  <!-- =========================================================================== -->
  
  <!-- GENERIC RULES -->	
  
	<xsl:template match="defaultRuleRoot">
		<rules>
    
      <!--plan rules-->
      <!--generic-->
			<xsl:for-each select="../defaultRuleRoot//collectionRulesOptionWrapper/collectionRulesOptionNode/ruleOptionWrapper/planRulesNode">
				<xsl:variable name="planFile">
					<xsl:value-of select="'../engine/rules/'"/>
					<xsl:value-of select="@code"/>
					<xsl:value-of select="'.comp'"/>
				</xsl:variable>
					
				<rule class="com.ataccama.dqd.engine.rules.PlanRule" code="{@code}" name="{@name}" planFileName="{$planFile}" dimension="VALIDITY">
          <description><xsl:value-of select="description"/></description> 
				  <input>
            <xsl:for-each select="ruleColumnWrapper/ruleColumnNode">
				      <column name="{@name}" type="{@type}"/>
            </xsl:for-each>
			    </input>
          <invalidityReasons>
            <xsl:for-each select="ruleExplanationWrapper/ruleExplanationNode">
              <reason code="{@code}" name="{@code}" description="{@description}"/>
            </xsl:for-each>
            	<!-- add 'OTHER' as a reason -->
             	<reason code="OTHER" name="{$exp_OTHER_name}" description="{$exp_OTHER_description}"/>

		      </invalidityReasons>
        </rule>	   
			</xsl:for-each>
      <!--sourceSystem-->         
			<xsl:for-each select="../sourceSystemRoot/sourceSystemWrapper/sourceSystemNode[@enable='true']//collectionRulesOptionWrapper/collectionRulesOptionNode/ruleOptionWrapper/planRulesNode">
				<xsl:variable name="planFile">
					<xsl:value-of select="'../engine/rules/'"/>
					<xsl:value-of select="@code"/>
					<xsl:value-of select="'.comp'"/>
				</xsl:variable>
				<rule class="com.ataccama.dqd.engine.rules.PlanRule" code="{@code}" name="{@name}" planFileName="{$planFile}" dimension="VALIDITY">
          <description><xsl:value-of select="description"/></description> 
				  <input>
            <xsl:for-each select="ruleColumnWrapper/ruleColumnNode">
				      <column name="{@name}" type="{@type}"/>
            </xsl:for-each>
			    </input>
          <invalidityReasons>
            <xsl:for-each select="ruleExplanationWrapper/ruleExplanationNode">
              <reason code="{@code}" name="{@code}" description="{@description}"/>
            </xsl:for-each>
            <!-- add 'OTHER' as a reason -->
             <reason code="OTHER" name="{$exp_OTHER_name}" description="{$exp_OTHER_description}"/>
		      </invalidityReasons>
        </rule>	   
			</xsl:for-each>      
      <!--dimension-->
      <xsl:for-each select="../dqDimensionRoot//dqCollectionRulesOptionWrapper/dqCollectionRulesOptionNode/dqRuleOptionWrapper/dqPlanRulesNode">
				<xsl:variable name="planFile">
					<xsl:value-of select="'../engine/rules/'"/>
					<xsl:value-of select="@code"/>
					<xsl:value-of select="'.comp'"/>
				</xsl:variable>
				<rule class="com.ataccama.dqd.engine.rules.PlanRule" code="{@code}" name="{@name}" planFileName="{$planFile}">
        <xsl:attribute name="dimension">
          <xsl:value-of select="ancestor::dqDimensionNode/@id"/>
        </xsl:attribute>
          <description><xsl:value-of select="description"/></description>
  			  <input>
            <xsl:for-each select="ruleColumnWrapper/ruleColumnNode">
				      <column name="{@name}" type="{@type}"/>
            </xsl:for-each>
  		    </input>				  
          
          <!-- <invalidityReasons>
            <xsl:for-each select="ruleExplanationWrapper/ruleExplanationNode">
              <reason code="{@code}" name="{@code}" description="{@description}"/>
            </xsl:for-each>-->
            <!-- not 'OTHER' for DQ dim rules -->
  	      <!-- </invalidityReasons>--> 
  	      		
  	      <!-- <invalidityReasons>
			<xsl:for-each select="ancestor::dqDimensionNode/dqDimensionResultWrapper/dqDimensionResultNode">
        		<reason code="{@id}" name="{@name}" description="{@description|description}" />
        	</xsl:for-each>       
    	  </invalidityReasons>-->         
				</rule>	
			</xsl:for-each>
      <!--plan rules-->
      
      <!--expression rules-->
      <!--generic-->
			<xsl:for-each select="../defaultRuleRoot//collectionRulesOptionWrapper/collectionRulesOptionNode/ruleOptionWrapper/expressionRulesNode">
				<rule class="com.ataccama.dqd.engine.rules.ExpressionRule" code="{@code}" name="{@name}" dimension="VALIDITY">
          <description><xsl:value-of select="description"/></description> 
				  <input>
            <xsl:for-each select="ruleColumnWrapper/ruleColumnNode">
				      <column name="{@name}" type="{@type}"/>
            </xsl:for-each>
			    </input>
          <expressions>
            <expression result="VALID">
                <expression>
                  <xsl:value-of select="validity"/>
                </expression>
            </expression>
            <xsl:for-each select="ruleExpressionWrapper/ruleExpressionNode">
				      <expression result="{@code}">
              <expression>
                <xsl:value-of select="expression"/>
              </expression>
              </expression>
            </xsl:for-each>            
          </expressions>
          <invalidityReasons>
            <xsl:for-each select="ruleExpressionWrapper/ruleExpressionNode">
              <reason code="{@code}" name="{@code}" description="{@description}"/>                      
            </xsl:for-each>
            <!-- add 'OTHER' as a reason -->
             	<reason code="OTHER" name="{$exp_OTHER_name}" description="{$exp_OTHER_description}"/>
		      </invalidityReasons>         
				</rule>	   
			</xsl:for-each>
      <!--sourceSystem-->
			<xsl:for-each select="../sourceSystemRoot/sourceSystemWrapper/sourceSystemNode[@enable='true']//collectionRulesOptionWrapper/collectionRulesOptionNode/ruleOptionWrapper/expressionRulesNode">
				<rule class="com.ataccama.dqd.engine.rules.ExpressionRule" code="{@code}" name="{@name}" dimension="VALIDITY">
          <description><xsl:value-of select="description"/></description> 
				  <input>
            <xsl:for-each select="ruleColumnWrapper/ruleColumnNode">
				      <column name="{@name}" type="{@type}"/>
            </xsl:for-each>
			    </input>
          <expressions>
            <expression result="VALID">
                <expression>
                  <xsl:value-of select="validity"/>
                </expression>
            </expression>
            <xsl:for-each select="ruleExpressionWrapper/ruleExpressionNode">
				      <expression result="{@code}">
              <expression>
                <xsl:value-of select="expression"/>
              </expression>
              </expression>
            </xsl:for-each>            
          </expressions>
          <invalidityReasons>
            <xsl:for-each select="ruleExpressionWrapper/ruleExpressionNode">
              <reason code="{@code}" name="{@code}" description="{@description}"/>                      
            </xsl:for-each>
            <!-- add 'OTHER' as a reason -->
             	<reason code="OTHER" name="{$exp_OTHER_name}" description="{$exp_OTHER_description}"/>
		      </invalidityReasons>         
				</rule>   
			</xsl:for-each>      
      <!--dimension-->
      <xsl:for-each select="../dqDimensionRoot//dqCollectionRulesOptionWrapper/dqCollectionRulesOptionNode/dqRuleOptionWrapper/dqExpressionRulesNode">
				<rule class="com.ataccama.dqd.engine.rules.ExpressionRule" code="{@code}" name="{@name}">
        <xsl:attribute name="dimension">
          <xsl:value-of select="ancestor::dqDimensionNode/@id"/>
        </xsl:attribute> 
          <description><xsl:value-of select="description"/></description> 
				  <input>
            <xsl:for-each select="ruleColumnWrapper/ruleColumnNode">
				      <column name="{@name}" type="{@type}"/>
            </xsl:for-each>
			    </input>
          <expressions>
            <xsl:for-each select="dqRuleResultWrapper/dqRuleResultNode">
				      <expression result="{@code}">
              <expression>
                <xsl:value-of select="expression"/>
              </expression>
              </expression>
            </xsl:for-each>            
          </expressions>                  
				</rule>	
			</xsl:for-each>            
      <!--expression rules-->
      
      
      <!--Multi Entity expression rules-->
      <!--generic & sourceSystem -->
      	<xsl:for-each select="../defaultRuleRoot//collectionRulesOptionWrapper/collectionRulesOptionNode/ruleOptionWrapper/multiEntityExpressionRulesNode|../sourceSystemRoot/sourceSystemWrapper/sourceSystemNode[@enable='true']//collectionRulesOptionWrapper/collectionRulesOptionNode/ruleOptionWrapper/multiEntityExpressionRulesNode">
		  <rule class="com.ataccama.dqd.engine.rules.MultiEntityExpressionRule" code="{@code}" name="{@name}" dimension="VALIDITY">
          	<description><xsl:value-of select="description"/></description> 
          	<input>
				<columns>
	           		 <xsl:for-each select="ruleColumnWrapper/ruleColumnNode">
					      <column name="{@name}" type="{@type}"/>
	            	 </xsl:for-each>      
				</columns>
				<childEntity>
					<columns>
						<xsl:for-each select="ruleChildColumnWrapper/ruleColumnNode">
					     	 <column name="{@name}" type="{@type}"/>
	           			</xsl:for-each>
	           		</columns>
					<selectionRules>
						<acceptanceCondition><xsl:value-of select="acceptanceCondition"/></acceptanceCondition>
						<aggregatingOrderBy>
							<xsl:for-each select="ruleAggregatingOrderByWrapper/ruleAggregatingOrderByNode">
								<orderBy nullsFirst="{@nullsFirst}" orderDescending="{@orderDescending}">
									<expression>
										<xsl:value-of select="expression"/>
									</expression>
								</orderBy>
							</xsl:for-each>
						</aggregatingOrderBy>
					</selectionRules>
				</childEntity> 
			</input>	        
          <expressions>
            <expression result="VALID">
                <expression>
                  <xsl:value-of select="validity"/>
                </expression>
            </expression>
            <xsl:for-each select="ruleMultiEntityExpressionWrapper/ruleMultiEntityExpressionNode">
				<expression result="{@code}">
			       <expression>
			           <xsl:value-of select="expression"/>
			       </expression>
			    </expression>
            </xsl:for-each>            
          </expressions>
          <invalidityReasons>
            <xsl:for-each select="ruleMultiEntityExpressionWrapper/ruleMultiEntityExpressionNode">
              <reason code="{@code}" name="{@code}" description="{@description}"/>                      
            </xsl:for-each>

            <!-- add 'OTHER' as a reason -->
             	<reason code="OTHER" name="{$exp_OTHER_name}" description="{$exp_OTHER_description}"/>

		 </invalidityReasons>         
		</rule>	   
	</xsl:for-each>
      

      <!--dimension-->
      	<xsl:for-each select="../dqDimensionRoot//dqCollectionRulesOptionWrapper/dqCollectionRulesOptionNode/dqRuleOptionWrapper/dqMultiEntityExpressionRulesNode">
		  <rule class="com.ataccama.dqd.engine.rules.MultiEntityExpressionRule" code="{@code}" name="{@name}">
		     <xsl:attribute name="dimension">
         		 <xsl:value-of select="ancestor::dqDimensionNode/@id"/>
       		 </xsl:attribute> 
          	<description><xsl:value-of select="description"/></description> 
          	<input>
				<columns>
	           		 <xsl:for-each select="ruleColumnWrapper/ruleColumnNode">
					      <column name="{@name}" type="{@type}"/>
	            	 </xsl:for-each>      
				</columns>
				<childEntity>
					<columns>
						<xsl:for-each select="ruleChildColumnWrapper/ruleColumnNode">
					     	 <column name="{@name}" type="{@type}"/>
	           			</xsl:for-each>
	           		</columns>
					<selectionRules>
						<acceptanceCondition><xsl:value-of select="acceptanceCondition"/></acceptanceCondition>
						<aggregatingOrderBy>
							<xsl:for-each select="ruleAggregatingOrderByWrapper/ruleAggregatingOrderByNode">
								<orderBy nullsFirst="{@nullsFirst}" orderDescending="{@orderDescending}">
									<expression>
										<xsl:value-of select="expression"/>
									</expression>
								</orderBy>
							</xsl:for-each>
						</aggregatingOrderBy>
					</selectionRules>
				</childEntity> 
			</input>	        
          <expressions>
            <xsl:for-each select="dqRuleMultiEntityResultWrapper/dqRuleMultiEntityResultNode">
				      <expression result="{@code}">
              <expression>
                <xsl:value-of select="expression"/>
              </expression>
              </expression>
            </xsl:for-each>            
          </expressions>         
		</rule>	   
	</xsl:for-each>
	
      
      
      
      <!--copy rules-->
      <!--default-->
			<xsl:for-each select="../defaultRuleRoot//collectionRulesOptionWrapper/collectionRulesOptionNode/ruleOptionWrapper/copyRulesNode">
				<rule class="com.ataccama.dqd.engine.rules.CopyRule" code="{@code}" name="{@name}" dimension="VALIDITY">
        <description><xsl:value-of select="description"/></description> 
				  <invalidityReasons>
            <xsl:for-each select="ruleExplanationWrapper/ruleExplanationNode">
                      <reason code="{@code}" name="{@code}" description="{@description}"/>
            </xsl:for-each>
            <!-- add 'OTHER' as a reason -->
             	<reason code="OTHER" name="{$exp_OTHER_name}" description="{$exp_OTHER_description}"/>
		      </invalidityReasons>         
				</rule>	   
			</xsl:for-each> 
      <!--sourceSystem-->
			<xsl:for-each select="../sourceSystemRoot/sourceSystemWrapper/sourceSystemNode[@enable='true']//collectionRulesOptionWrapper/collectionRulesOptionNode/ruleOptionWrapper/copyRulesNode">
				<rule class="com.ataccama.dqd.engine.rules.CopyRule" code="{@code}" name="{@name}" dimension="VALIDITY">
        <description><xsl:value-of select="description"/></description> 
				  <invalidityReasons>
            <xsl:for-each select="ruleExplanationWrapper/ruleExplanationNode">
                      <reason code="{@code}" name="{@code}" description="{@description}"/>
            </xsl:for-each>
            <!-- add 'OTHER' as a reason -->
             	<reason code="OTHER" name="{$exp_OTHER_name}" description="{$exp_OTHER_description}"/>
		      </invalidityReasons>         
				</rule>	   
			</xsl:for-each>           
      <!--dimension-->
      <xsl:for-each select="../dqDimensionRoot//dqCollectionRulesOptionWrapper/dqCollectionRulesOptionNode/dqRuleOptionWrapper/dqCopyRulesNode">
				<rule class="com.ataccama.dqd.engine.rules.CopyRule" code="{@code}" name="{@name}">
        <xsl:attribute name="dimension">
          <xsl:value-of select="ancestor::dqDimensionNode/@id"/>
        </xsl:attribute>
        <description><xsl:value-of select="description"/></description>
        <!-- commented out - dim copy rules do not have invalidity reasons
		<invalidityReasons>
            <xsl:for-each select="dqRuleResultWrapper/dqRuleResultNode">
              <xsl:choose>
                  <xsl:when test="@code='OTHER'"></xsl:when>
                  <xsl:otherwise>
                      <reason code="{@code}" name="{@code}" description="{@description}"/>
                  </xsl:otherwise>
              </xsl:choose>
            </xsl:for-each>
            <reason code="OTHER" name="OTHER" description="{@description}"/>
		      </invalidityReasons>    
		        -->  
		<!-- <invalidityReasons>
			<xsl:for-each select="ancestor::dqDimensionNode/dqDimensionResultWrapper/dqDimensionResultNode">
        		<reason code="{@id}" name="{@name}" description="{@description|description}" />        		
        	</xsl:for-each>
        		<reason code="OTHER" name="OTHER" description="{@description}"/>       
    	</invalidityReasons>-->
				</rule>	
			</xsl:for-each>      
      <!--copy rules-->
      
		</rules>
	</xsl:template>

  <!-- =========================================================================== -->

  <!-- DQ DIMENSIONS -->  
  
 	<xsl:template match="dqDimensionRoot"> 
    <dimensions>
    
      <!-- Main dimension -->
  		<dimension mainDimension="true" code="VALIDITY" name="Validity" >
  			<results>
  				<result code="VALID" name="Valid" />
  				<result code="INVALID" name="Invalid" />
  			</results>
  		</dimension>    
      
      <!-- DQ dimensions -->
      <xsl:for-each select="dqDimensionWrapper/dqDimensionNode">
    		<dimension code="{@id}" name="{@name}" description="{@description}">
    			<results>
            <xsl:for-each select="dqDimensionResultWrapper/dqDimensionResultNode">
    				  <result code="{@id}" name="{@name}" description="{@description}"/>
            </xsl:for-each>  
    			</results>
    		</dimension>
      </xsl:for-each>
      
    </dimensions>
	</xsl:template>

  <!-- =========================================================================== -->

</xsl:stylesheet>