<?xml version='1.0' encoding='UTF-8'?>
<expressionRulesNode ruleType="Validity Rule" ruleTypeLabel="Validity Rule" name="Is Mandatory" elemId="11779484" code="IS_NOT_NULL" type="ExpressionRule">
	<description>Value is not empty/null.</description>
	<validity>in_input is not null</validity>
	<ruleColumnWrapper>
		<ruleColumnNode name="in_input" elemId="11779485" type="string"/>
	</ruleColumnWrapper>
	<ruleExpressionWrapper>
		<ruleExpressionNode description="Value is missing" elemId="11779487" code="CHECK_NULL">
			<expression>in_input is null</expression>
		</ruleExpressionNode>
	</ruleExpressionWrapper>
</expressionRulesNode>