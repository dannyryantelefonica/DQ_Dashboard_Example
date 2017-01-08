<?xml version='1.0' encoding='UTF-8'?>
<expressionRulesNode ruleType="Validity Rule" ruleTypeLabel="Validity Rule" name="Permission Flag" elemId="12054604" code="CIF_PERM" type="ExpressionRule">
	<description>Mandatory. List of valid values: Y,N</description>
	<validity>src_permission_to_market is not null
and
src_permission_to_market in {&#39;Y&#39;, &#39;N&#39;}</validity>
	<ruleColumnWrapper>
		<ruleColumnNode name="src_permission_to_market" elemId="12054605" type="string"/>
	</ruleColumnWrapper>
	<ruleExpressionWrapper>
		<ruleExpressionNode description="Value is empty." elemId="12054606" code="NULL">
			<expression>src_permission_to_market is null</expression>
		</ruleExpressionNode>
		<ruleExpressionNode description="Value is outside of valid list-of-values." elemId="12054607" code="INVALID">
			<expression>//fallback
true</expression>
		</ruleExpressionNode>
	</ruleExpressionWrapper>
</expressionRulesNode>