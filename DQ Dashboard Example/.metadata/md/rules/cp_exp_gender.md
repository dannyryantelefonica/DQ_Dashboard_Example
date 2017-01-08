<?xml version='1.0' encoding='UTF-8'?>
<copyRulesNode ruleType="Validity Rule" ruleTypeLabel="Validity Rule" name="Gender code" elemId="12059707" inputColumn="Input column containing Explanation" code="cp_exp_gender" type="CopyRule">
	<description>Gender code has to be 0 (male) or 1 (female).</description>
	<ruleExplanationWrapper>
		<ruleExplanationNode description="Empty value" elemId="12059708" code="NULL"/>
		<ruleExplanationNode description="Code is different than 0, 1" elemId="12059709" code="OUT_OF_DOMAIN"/>
	</ruleExplanationWrapper>
</copyRulesNode>