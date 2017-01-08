<?xml version='1.0' encoding='UTF-8'?>
<copyRulesNode ruleType="Validity Rule" ruleTypeLabel="Validity Rule" name="Customer Type" elemId="12059701" inputColumn="Input column containing Explanation" code="cp_exp_cust_type" type="CopyRule">
	<description>Customer type is mandatory attribute with allowed fields &#39;A&#39; (Active), &#39;P&#39; (Prospect), &#39;C&#39; (Closed) as defined in reference file CSTMR_TYPE_2015_01.doc</description>
	<ruleExplanationWrapper>
		<ruleExplanationNode description="The value is empty." elemId="12059702" code="NULL"/>
		<ruleExplanationNode description="The value is outside of the allowed values." elemId="12059703" code="INVALID"/>
	</ruleExplanationWrapper>
</copyRulesNode>