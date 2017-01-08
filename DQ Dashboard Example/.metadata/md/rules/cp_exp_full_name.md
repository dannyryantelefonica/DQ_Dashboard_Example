<?xml version='1.0' encoding='UTF-8'?>
<copyRulesNode ruleType="Validity Rule" ruleTypeLabel="Validity Rule" name="Full Name" elemId="12059711" inputColumn="Input column containing Explanation" code="cp_exp_full_name" type="CopyRule">
	<description>Name contains valid first name and last name</description>
	<ruleExplanationWrapper>
		<ruleExplanationNode description="Name contains unknown word" elemId="12059712" code="NAME_UNKNOWN_WORD"/>
		<ruleExplanationNode description="Initial instead of first name" elemId="12060149" code="NAME_INITIAL_FOUND"/>
		<ruleExplanationNode description="Name contains title" elemId="12060151" code="NAME_TITLE_REMOVED"/>
	</ruleExplanationWrapper>
</copyRulesNode>