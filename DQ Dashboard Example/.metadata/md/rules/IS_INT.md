<?xml version='1.0' encoding='UTF-8'?>
<expressionRulesNode ruleType="Validity Rule" ruleTypeLabel="Validity Rule" name="Is Number (Non Mandatory)" elemId="12054510" code="IS_INT" type="ExpressionRule">
	<description>Value is integer (can be null)</description>
	<validity>toInteger(in_input) is not null
or
in_input is null
</validity>
	<ruleColumnWrapper>
		<ruleColumnNode name="in_input" elemId="12054519" type="string"/>
	</ruleColumnWrapper>
	<ruleExpressionWrapper>
		<ruleExpressionNode description="Value is not null and not integer" elemId="12054526" code="NOT_INTEGER">
			<expression>toString(in_input) is null</expression>
		</ruleExpressionNode>
	</ruleExpressionWrapper>
</expressionRulesNode>