<?xml version='1.0' encoding='UTF-8'?>
<planRulesNode ruleType="Validity Rule" ruleTypeLabel="Validity Rule" planFile="" name="Phone Validity" elemId="12060817" code="PhoneValid" type="PlanRule">
	<description>Phone number must be valid US or Canadian phone number.
Both international (i.e. 001 or +1) prefixes are allowed as well as no prefix.
The number must consists of 10 digits, with the first 3 digits being valid area code from a list-of-values. The only additional characters
allowed are rounded brackets &#39;(&#39; &#39;)&#39; and dash &#39;-&#39;.

Cases of 7 repeated digits after the area code are considered default values entered either by a user or ETL process.</description>
	<ruleColumnWrapper>
		<ruleColumnNode name="src_phone" elemId="12060822" type="string"/>
	</ruleColumnWrapper>
	<ruleExplanationWrapper>
		<ruleExplanationNode description="The value is empty." elemId="12060823" code="NULL"/>
		<ruleExplanationNode description="Phone number consists of repeated characters only (i.e. 203 111-1111)" elemId="12060824" code="DEFAULT"/>
		<ruleExplanationNode description="Phone number contain invalid characters (letters)" elemId="12060825" code="INVALID_CHARS"/>
		<ruleExplanationNode description="Phone number is shorter then 10 digits" elemId="12060826" code="SHORT"/>
		<ruleExplanationNode description="Area code is invalid" elemId="12060827" code="INVALID_AREA_CODE"/>
		<ruleExplanationNode description="Phone number contains more then 10 digits (even after internation prefix separation)" elemId="12060828" code="LONG"/>
	</ruleExplanationWrapper>
</planRulesNode>