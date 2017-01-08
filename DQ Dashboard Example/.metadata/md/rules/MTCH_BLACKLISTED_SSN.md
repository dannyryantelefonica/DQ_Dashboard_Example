<?xml version='1.0' encoding='UTF-8'?>
<dqExpressionRulesNode ruleType="Dimension Rule" ruleTypeLabel="Dimension Rule" description="SSN found on list of restricted SSNs" name="Restricted SSN" elemId="12060178" code="MTCH_BLACKLISTED_SSN" type="ExpressionRule">
	<ruleColumnWrapper>
		<ruleColumnNode name="in_ssn" elemId="12060194" type="string"/>
	</ruleColumnWrapper>
	<dqRuleResultWrapper>
		<dqRuleResultNode elemId="12060195" code="MATCH">
			<expression>right(in_ssn,1)=&#39;1&#39;</expression>
		</dqRuleResultNode>
		<dqRuleResultNode elemId="12060196" code="PARTIAL_MATCH">
			<expression>right(in_ssn,1)=&#39;0&#39;</expression>
		</dqRuleResultNode>
		<dqRuleResultNode elemId="12060197" code="NO_MATCH">
			<expression>true</expression>
		</dqRuleResultNode>
	</dqRuleResultWrapper>
</dqExpressionRulesNode>