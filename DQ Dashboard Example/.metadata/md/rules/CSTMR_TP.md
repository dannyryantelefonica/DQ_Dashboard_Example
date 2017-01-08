<?xml version='1.0' encoding='UTF-8'?>
<planRulesNode ruleType="Validity Rule" ruleTypeLabel="Validity Rule" planFile="" name="Customer Type" elemId="12059482" code="CSTMR_TP" type="PlanRule">
	<description>Customer type is mandatory attribute with allowed fields &#39;A&#39; (Active), &#39;P&#39; (Prospect), &#39;C&#39; (Closed) as defined in reference file CSTMR_TYPE_2015_01.doc</description>
	<ruleColumnWrapper>
		<ruleColumnNode name="src_customer_type" elemId="12054615" type="string"/>
	</ruleColumnWrapper>
	<ruleExplanationWrapper>
		<ruleExplanationNode description="The value is empty." elemId="12054616" code="NULL"/>
		<ruleExplanationNode description="The value is outside of the allowed values." elemId="12054617" code="INVALID"/>
	</ruleExplanationWrapper>
</planRulesNode>