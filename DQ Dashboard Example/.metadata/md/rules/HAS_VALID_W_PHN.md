<?xml version='1.0' encoding='UTF-8'?>
<multiEntityExpressionRulesNode ruleType="Validity Rule" ruleTypeLabel="Validity Rule" name="Has at least one valid phone number" elemId="12054928" code="HAS_VALID_W_PHN" type="MultiEntityExpressionRule">
	<description>Party has at least one valid phone number:

Phone number must be valid US or Canadian phone number.
Both international (i.e. 001 or +1) prefixes are allowed as well as no prefix.
The number must consists of 10 digits, with the first 3 digits being valid area code from a list-of-values. The only additional characters
allowed are rounded brackets &#39;(&#39; &#39;)&#39; and dash &#39;-&#39;.

Cases of 7 repeated digits after the area code are considered default values entered either by a user or ETL process.</description>
	<validity>best.phone_rule_result = &#39;VALID&#39;</validity>
	<acceptanceCondition></acceptanceCondition>
	<ruleColumnWrapper>
		<ruleColumnNode name="src_cust_type" elemId="12060858" type="string"/>
	</ruleColumnWrapper>
	<ruleChildColumnWrapper>
		<ruleColumnNode name="phone_rule_result" elemId="12060859" type="string"/>
	</ruleChildColumnWrapper>
	<ruleAggregatingOrderByWrapper>
		<ruleAggregatingOrderByNode orderDescending="false" nullsFirst="false" elemId="12060860">
			<expression>case(
phone_rule_result = &#39;VALID&#39;, 0,
phone_rule_result = &#39;NULL&#39;, 1,
phone_rule_result = &#39;DEFAULT&#39;, 2,
phone_rule_result = &#39;INVALID_CHARS&#39;, 3,
phone_rule_result = &#39;SHORT&#39;, 4,
phone_rule_result = &#39;INVALID_AREA_CODE&#39;, 5,
phone_rule_result = &#39;LONG&#39;, 6,
10
)</expression>
		</ruleAggregatingOrderByNode>
	</ruleAggregatingOrderByWrapper>
	<ruleMultiEntityExpressionWrapper>
		<ruleMultiEntityExpressionNode description="Customer has no associated phone contact." elemId="12061824" code="NO_PHONE">
			<expression>best.phone_rule_result is null</expression>
		</ruleMultiEntityExpressionNode>
		<ruleMultiEntityExpressionNode description="The value is empty." elemId="12060861" code="NULL">
			<expression>best.phone_rule_result = &#39;NULL&#39;</expression>
		</ruleMultiEntityExpressionNode>
		<ruleMultiEntityExpressionNode description="Phone number consists of repeated characters only (i.e. 203 111-1111)" elemId="12060862" code="DEFAULT">
			<expression>best.phone_rule_result = &#39;DEFAULT&#39;</expression>
		</ruleMultiEntityExpressionNode>
		<ruleMultiEntityExpressionNode description="Phone number contain invalid characters (letters)" elemId="12060863" code="INVALID_CHARS">
			<expression>best.phone_rule_result = &#39;INVALID_CHARS&#39;</expression>
		</ruleMultiEntityExpressionNode>
		<ruleMultiEntityExpressionNode description="Phone number is shorter then 10 digits" elemId="12060864" code="SHORT">
			<expression>best.phone_rule_result = &#39;SHORT&#39;</expression>
		</ruleMultiEntityExpressionNode>
		<ruleMultiEntityExpressionNode description="Area code is invalid" elemId="12060865" code="INVALID_AREA_CODE">
			<expression>best.phone_rule_result = &#39;INVALID_AREA_CODE&#39;</expression>
		</ruleMultiEntityExpressionNode>
		<ruleMultiEntityExpressionNode description="Phone number contains more then 10 digits (even after internation prefix separation)" elemId="12060866" code="LONG">
			<expression>best.phone_rule_result = &#39;LONG&#39;</expression>
		</ruleMultiEntityExpressionNode>
	</ruleMultiEntityExpressionWrapper>
</multiEntityExpressionRulesNode>