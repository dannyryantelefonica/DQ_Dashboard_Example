<?xml version='1.0' encoding='UTF-8'?>
<copyRulesNode ruleType="Validity Rule" ruleTypeLabel="Validity Rule" name="Email" elemId="12059691" inputColumn="Input column containing Explanation" code="cp_exp_email" type="CopyRule">
	<description>Email is valid</description>
	<ruleExplanationWrapper>
		<ruleExplanationNode description="Empty field." elemId="12059693" code="EMAIL_EMPTY"/>
		<ruleExplanationNode description="Input e-mail address has an invalid format or has an unknown TLD." elemId="12059694" code="EMAIL_INVALID"/>
		<ruleExplanationNode description="Input e-mail address contains only a TLD after @ (corresponding to the RFC 2822 standard), however the domain is considered suspicious." elemId="12059695" code="EMAIL_AMBIGUOUS_DOMAIN"/>
		<ruleExplanationNode description="Email address is valid, however, the input value needs to be somewhat cleansed (brackets removed, i.e. &lt;email&gt; -&gt; email ). " elemId="12059696" code="EMAIL_CLEANSED"/>
	</ruleExplanationWrapper>
</copyRulesNode>