<?xml version='1.0' encoding='UTF-8'?>
<multiEntityExpressionRulesNode ruleType="Validity Rule" ruleTypeLabel="Validity Rule" name="Has valid work email" elemId="12054917" code="HAS_VALID_W_EML" type="MultiEntityExpressionRule">
	<description>Customer has at least one valid work email. 
Applicable on Active Customers only</description>
	<validity>count(email_rule_result = &#39;VALID&#39;) &gt; 0
or
parent.src_cust_type != &#39;A&#39;</validity>
	<acceptanceCondition>src_email_type = &#39;work&#39;</acceptanceCondition>
	<ruleColumnWrapper>
		<ruleColumnNode name="src_cust_type" elemId="12054941" type="string"/>
	</ruleColumnWrapper>
	<ruleChildColumnWrapper>
		<ruleColumnNode name="email_rule_result" elemId="12054930" type="string"/>
		<ruleColumnNode name="src_email_type" elemId="12054931" type="string"/>
	</ruleChildColumnWrapper>
	<ruleMultiEntityExpressionWrapper>
		<ruleMultiEntityExpressionNode description="Customer does not have any Work Phone entry." elemId="12054948" code="HAS_NO_W_EMAIL">
			<expression>count(email_rule_result) = 0</expression>
		</ruleMultiEntityExpressionNode>
		<ruleMultiEntityExpressionNode description="All customer&#39;s phone calls are invalid." elemId="12054949" code="ALL_W_EMAILS_INV">
			<expression>count(email_rule_result = &#39;VALID&#39;) = 0</expression>
		</ruleMultiEntityExpressionNode>
	</ruleMultiEntityExpressionWrapper>
	<ruleAggregatingOrderByWrapper/>
</multiEntityExpressionRulesNode>