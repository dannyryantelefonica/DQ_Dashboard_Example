<?xml version='1.0' encoding='UTF-8'?>
<expressionRulesNode ruleType="Validity Rule" ruleTypeLabel="Validity Rule" name="Birth Date" elemId="12054859" code="CIF_DOB" type="ExpressionRule">
	<description>Mandatory for Active Customers. Optional for Prospects. Cannot be more than 150 years prior to the current date. Cannot be a future date.

The date 1900-01-01 is considered default and introduced by ETL.</description>
	<validity>src_birth_date is not null
	and
	src_birth_date &gt;= dateAdd(today(),-150,&#39;YEAR&#39;)
	and
	src_birth_date &lt;= today()
	and
	src_birth_date is not toDate(&#39;1900-01-01&#39;,&#39;yyyy-MM-dd&#39;)</validity>
	<ruleColumnWrapper>
		<ruleColumnNode name="src_birth_date" elemId="12054889" type="day"/>
		<ruleColumnNode name="src_customer_type" elemId="12054890" type="string"/>
	</ruleColumnWrapper>
	<ruleExpressionWrapper>
		<ruleExpressionNode description="The value is empty (Active Customers only)." elemId="12054891" code="NULL">
			<expression>src_birth_date is null</expression>
		</ruleExpressionNode>
		<ruleExpressionNode description="The Birth date is in the future." elemId="12054892" code="IN_FUTURE">
			<expression>src_birth_date &gt; today()</expression>
		</ruleExpressionNode>
		<ruleExpressionNode description="The Birth date is more then 150 years in the past." elemId="12054893" code="IN_PAST">
			<expression>src_birth_date &lt; dateAdd(today(),-150,&#39;YEAR&#39;)</expression>
		</ruleExpressionNode>
		<ruleExpressionNode description="The Birth date is 1900-01-01." elemId="12054894" code="DEFAULT">
			<expression>src_birth_date is toDate(&#39;1900-01-01&#39;,&#39;yyyy-MM-dd&#39;)</expression>
		</ruleExpressionNode>
	</ruleExpressionWrapper>
</expressionRulesNode>