<?xml version='1.0' encoding='UTF-8'?>
<expressionRulesNode ruleType="Validity Rule" ruleTypeLabel="Validity Rule" name="Legal Name" elemId="12054571" code="CIF_LGL_NM" type="ExpressionRule">
	<description>Mandatory, free form text entry.
Must contain at least one character or number.</description>
	<validity>src_legal_name is not null
and
(
find(@&quot;[a-zA-Z]&quot;,src_legal_name)
or
find(@&quot;[0-9]&quot;,src_legal_name)
)</validity>
	<ruleColumnWrapper>
		<ruleColumnNode name="src_legal_name" elemId="12054572" type="string"/>
	</ruleColumnWrapper>
	<ruleExpressionWrapper>
		<ruleExpressionNode description="The value is empty." elemId="12054573" code="NULL">
			<expression>src_legal_name is null</expression>
		</ruleExpressionNode>
		<ruleExpressionNode description="Legal name does not contain any letter or number" elemId="12054574" code="SPECIAL_CHARACTERS_ONLY">
			<expression>not find(@&quot;[a-zA-Z]&quot;,src_legal_name)</expression>
		</ruleExpressionNode>
	</ruleExpressionWrapper>
</expressionRulesNode>