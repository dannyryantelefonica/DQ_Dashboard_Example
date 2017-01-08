<?xml version='1.0' encoding='UTF-8'?>
<dqExpressionRulesNode ruleType="Dimension Rule" ruleTypeLabel="Dimension Rule" description="General completeness test" name="General completeness test" elemId="12060163" code="completeness_test" type="ExpressionRule">
	<ruleColumnWrapper>
		<ruleColumnNode name="in_column" elemId="12060164" type="string"/>
	</ruleColumnWrapper>
	<dqRuleResultWrapper>
		<dqRuleResultNode elemId="12060165" code="COMPLETE">
			<expression>in_column is not null</expression>
		</dqRuleResultNode>
		<dqRuleResultNode elemId="12060166" code="NOT_COMPLETE">
			<expression>in_column is null</expression>
		</dqRuleResultNode>
	</dqRuleResultWrapper>
</dqExpressionRulesNode>