<?xml version='1.0' encoding='UTF-8'?>
<planRulesNode ruleType="Validity Rule" ruleTypeLabel="Validity Rule" planFile="../engine/rules/email.comp" name="Email Validity" elemId="11778304" code="EmailValid" type="plan">
	<description>Email is valid.</description>
	<ruleColumnWrapper>
		<ruleColumnNode name="in_email" elemId="11778305" type="string"/>
	</ruleColumnWrapper>
	<ruleExplanationWrapper>
		<ruleExplanationNode description="Empty field." elemId="12059647" code="EMAIL_EMPTY"/>
		<ruleExplanationNode description="Input e-mail address has an invalid format or has an unknown TLD." elemId="12059648" code="EMAIL_INVALID"/>
		<ruleExplanationNode description="Input e-mail address contains only a TLD after @ (corresponding to the RFC 2822 standard), however the domain is considered suspicious." elemId="12059649" code="EMAIL_AMBIGUOUS_DOMAIN"/>
		<ruleExplanationNode description="Email address is valid, however, the input value needs to be somewhat cleansed (brackets removed, i.e. &lt;email&gt; -&gt; email ). " elemId="12059650" code="EMAIL_CLEANSED"/>
	</ruleExplanationWrapper>
</planRulesNode>