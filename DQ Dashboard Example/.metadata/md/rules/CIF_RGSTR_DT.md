<?xml version='1.0' encoding='UTF-8'?>
<expressionRulesNode ruleType="Validity Rule" ruleTypeLabel="Validity Rule" name="Registration Date" elemId="12054568" code="CIF_RGSTR_DT" type="ExpressionRule">
	<description>Mandatory for Customers. Optional for Prospects. Cannot be a future date.

The date 1900-01-01 is considered default and introduced by ETL.</description>
	<validity>src_registration_date is not null
	and
src_registration_date &lt;= today()
	and
src_registration_date is not toDate(&#39;1900-01-01&#39;,&#39;yyyy-MM-dd&#39;)
</validity>
	<ruleColumnWrapper>
		<ruleColumnNode name="src_registration_date" elemId="12054589" type="day"/>
	</ruleColumnWrapper>
	<ruleExpressionWrapper>
		<ruleExpressionNode description="Registration date is empty" elemId="12054590" code="NULL">
			<expression>src_registration_date is null</expression>
		</ruleExpressionNode>
		<ruleExpressionNode description="Date is in future" elemId="12054591" code="IN_FUTURE">
			<expression>src_registration_date &gt; today()</expression>
		</ruleExpressionNode>
		<ruleExpressionNode description="Date value is populated with default value 1900-01-01" elemId="12054592" code="DEFAULT">
			<expression>src_registration_date is toDate(&#39;1900-01-01&#39;,&#39;yyyy-MM-dd&#39;)</expression>
		</ruleExpressionNode>
	</ruleExpressionWrapper>
</expressionRulesNode>