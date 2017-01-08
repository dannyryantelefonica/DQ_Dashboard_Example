<?xml version='1.0' encoding='UTF-8'?>
<xsl:stylesheet exclude-result-prefixes="sf fn comm" xmlns:fn="http://www.w3.org/2005/xpath-functions" xmlns:sf="http://www.ataccama.com/xslt/functions" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:comm="http://www.ataccama.com/purity/comment" version="2.0">
<xsl:output indent="yes" encoding="UTF-8" method="xml"/>

<xsl:param select="document(&#39;param:dqDimensionNode&#39;)/*" name="dqDimensionNode"/>

<xsl:include href="constants_incl.xsl"/>

	<xsl:template match="/*">
		<purity-config version="{$dqd_version}">

			<step id="in" className="com.ataccama.dqc.tasks.common.usersteps.io.InputStep" disabled="false" mode="NORMAL" update="true">
		        <properties>
		            <columns>
		           		<xsl:for-each select="ruleColumnWrapper/ruleColumnNode">
		           			<column name="{@name}" type="{@type}"/>
		           		</xsl:for-each>  	
					</columns>
					<shadowColumns>
						<shadowColumnDef name="result" type="STRING"/>
					</shadowColumns>
		        </properties>
		    </step>
		    
			<connection className="com.ataccama.dqc.model.elements.connections.StandardFlowConnection">
				<source step="in" endpoint="out"/>
				<target step="out" endpoint="in"/>
				<visual-constraints>
					<bendpoints/>
				</visual-constraints>
			</connection>			    
		    
			<step id="out" className="com.ataccama.dqc.tasks.common.usersteps.io.OutputStep" disabled="false" mode="NORMAL" update="true">
		        <properties>
		            <requiredColumns>
		            	<requiredColumns name="result" type="STRING"/>  		            	  
					</requiredColumns>			
		        </properties>
		    </step>		

<modelComment update="true" bounds="264,24,385,169" borderColor="183,183,0" backgroundColor="255,255,180" foregroundColor="51,51,51">
Rule name: <xsl:value-of select="@name"/>
Rule description: <xsl:value-of select="description"/>

Expected values in output 'result' attribute:
<xsl:choose>
	<xsl:when test="@ruleType='Validity Rule'">
	VALID
	<xsl:for-each select="ruleExplanationWrapper/ruleExplanationNode">
		<xsl:value-of select="@code"/> (<xsl:value-of select="@description"/>)
	</xsl:for-each>	
	</xsl:when>
	<xsl:otherwise>
	<xsl:for-each select="$dqDimensionNode/dqDimensionResultWrapper/dqDimensionResultNode">
		<xsl:value-of select="@id"/> (<xsl:value-of select="description"/>)
	</xsl:for-each>	
	</xsl:otherwise>
</xsl:choose>

</modelComment>		  
		        
		</purity-config>
	</xsl:template>
</xsl:stylesheet>