<?xml version='1.0' encoding='UTF-8'?>
<dqExpressionRulesNode ruleType="Dimension Rule" ruleTypeLabel="Dimension Rule" description="Tax ID found on blacklist" name="Blacklisted Tax ID" elemId="12060186" code="MTCH_TAX_ID" type="ExpressionRule">
	<ruleColumnWrapper>
		<ruleColumnNode name="in_tax_id" elemId="12060202" type="string"/>
	</ruleColumnWrapper>
	<dqRuleResultWrapper>
		<dqRuleResultNode elemId="12060187" code="MATCH">
			<expression>in_tax_id not in {&#39;55-9500123&#39;, &#39;99-9500123&#39;}</expression>
		</dqRuleResultNode>
		<dqRuleResultNode elemId="12060188" code="PARTIAL_MATCH">
			<expression>in_tax_id in {&#39;99-9500123&#39;}</expression>
		</dqRuleResultNode>
		<dqRuleResultNode elemId="12060189" code="NO_MATCH">
			<expression>in_tax_id is not null</expression>
		</dqRuleResultNode>
	</dqRuleResultWrapper>
</dqExpressionRulesNode>