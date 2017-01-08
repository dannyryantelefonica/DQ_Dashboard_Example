<?xml version='1.0' encoding='UTF-8'?>
<expressionRulesNode ruleType="Validity Rule" ruleTypeLabel="Validity Rule" name="Is Number (Mandatory)" elemId="12054530" code="IS_INT_M" type="ExpressionRule">
	<description>Value is not null integer</description>
	<validity>toInteger(in_input) is not null</validity>
	<ruleColumnWrapper>
		<ruleColumnNode name="in_input" elemId="12054519" type="string"/>
	</ruleColumnWrapper>
	<ruleExpressionWrapper>
		<ruleExpressionNode description="Value is null" elemId="12054525" code="NULL">
			<expression>in_input is null</expression>
		</ruleExpressionNode>
		<ruleExpressionNode description="Value is not null and not integer" elemId="12054526" code="NOT_INTEGER">
			<expression>toString(in_input) is null</expression>
		</ruleExpressionNode>
	</ruleExpressionWrapper>
</expressionRulesNode>