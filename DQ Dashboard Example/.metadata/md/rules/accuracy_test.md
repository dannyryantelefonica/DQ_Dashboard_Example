<?xml version='1.0' encoding='UTF-8'?>
<dqExpressionRulesNode ruleType="Dimension Rule" ruleTypeLabel="Dimension Rule" description="" name="General accuracy test" elemId="12060216" code="accuracy_test" type="ExpressionRule">
	<ruleColumnWrapper>
		<ruleColumnNode name="in_column" elemId="12060217" type="string"/>
		<ruleColumnNode name="in_date" elemId="12060219" type="day"/>
	</ruleColumnWrapper>
	<dqRuleResultWrapper>
		<dqRuleResultNode elemId="12060220" code="ACCURATE">
			<expression>in_column is not null and in_date is not null
	and
in_date &lt;= today()
	and
in_date is not toDate(&#39;1900-01-01&#39;,&#39;yyyy-MM-dd&#39;)</expression>
		</dqRuleResultNode>
		<dqRuleResultNode elemId="12060221" code="NOT_ACCURATE">
			<expression>in_column is not null</expression>
		</dqRuleResultNode>
		<dqRuleResultNode elemId="12060222" code="NULL">
			<expression>in_column is null</expression>
		</dqRuleResultNode>
	</dqRuleResultWrapper>
</dqExpressionRulesNode>