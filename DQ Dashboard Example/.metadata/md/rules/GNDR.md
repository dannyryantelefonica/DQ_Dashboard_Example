<?xml version='1.0' encoding='UTF-8'?>
<expressionRulesNode ruleType="Validity Rule" ruleTypeLabel="Validity Rule" name="Gender" elemId="12055600" code="GNDR" type="ExpressionRule">
	<description>Gender is mandatory attribute with allowed values &#39;M&#39; and &#39;F&#39;</description>
	<validity>src_gender is not null
and 
src_gender in {&#39;M&#39;, &#39;F&#39;}</validity>
	<ruleColumnWrapper>
		<ruleColumnNode name="src_gender" elemId="12054879" type="string"/>
	</ruleColumnWrapper>
	<ruleExpressionWrapper>
		<ruleExpressionNode description="Gender is null." elemId="12054880" code="NULL">
			<expression>src_gender is null</expression>
		</ruleExpressionNode>
		<ruleExpressionNode description="Gender is &#39;unknown&#39;." elemId="12054881" code="DEFAULT">
			<expression>lower(src_gender) = &#39;unknow&#39;</expression>
		</ruleExpressionNode>
		<ruleExpressionNode description="Gender is outside of allowed list of values (&#39;M&#39;,&#39;F&#39;,&#39;unknown&#39;)." elemId="12054882" code="INVALID">
			<expression>true</expression>
		</ruleExpressionNode>
	</ruleExpressionWrapper>
</expressionRulesNode>