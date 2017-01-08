<?xml version='1.0' encoding='UTF-8'?>
<planRulesNode ruleType="Validity Rule" ruleTypeLabel="Validity Rule" planFile="" name="Full Name" elemId="12054866" code="CIF_FULL_NAME" type="PlanRule">
	<description>First name is a free form entry, mandatory, field. May be composed of letters (A-Z including French accented characters), apostrophes, hyphens, periods, slashes and spaces. 
Last name is a free form entry, mandatory, field. May be composed of letters, apostrophes, hyphens, periods, slashes and spaces. </description>
	<ruleColumnWrapper>
		<ruleColumnNode name="src_first_name" elemId="12054867" type="string"/>
		<ruleColumnNode name="src_last_name" elemId="12054868" type="string"/>
	</ruleColumnWrapper>
	<ruleExplanationWrapper>
		<ruleExplanationNode description="Both first name and last name are null." elemId="12054869" code="NULL"/>
		<ruleExplanationNode description="First name has initial only (i.e. &#39;J.&#39;)" elemId="12054870" code="FN_INITIAL"/>
		<ruleExplanationNode description="First name is null" elemId="12054871" code="FN_NULL"/>
	</ruleExplanationWrapper>
</planRulesNode>