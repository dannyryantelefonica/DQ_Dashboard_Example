<?xml version='1.0' encoding='UTF-8'?>
<sourceSystemNode xmlns:ame="http://www.ataccama.com/ame/md" name="Marketing CRM" enable="true" elemId="11883748" code="Marketing">
	<description></description>
	<modelWrapper>
		<modelNode name="CRM Application" elemId="11883749" code="crm">
			<description>Data exrtract from Company CRM already process by DQ engine.</description>
			<lMRoot>
				<lMTableWrapper>
					<lMTableNode name="customer" elemId="11883750">
						<lMAttributeWrapper>
							<lMAttributeNode businessName="ID" ruleName="" name="ID" elemId="11884999" type="integer" dbType=""/>
							<lMAttributeNode businessName="Customer Type - src" ruleName="Dimension Rule: completeness_test" name="CSTMR_TYPE" elemId="12054217" type="string" dbType=""/>
							<lMAttributeNode businessName="Customer Type" ruleName="Validity Rule: cp_exp_cust_type" name="exp_CSTMR_TYPE" elemId="12059699" type="string" dbType=""/>
							<lMAttributeNode businessName="Name - src" ruleName="Dimension Rule: completeness_test" name="FULL_NM" elemId="11885000" type="string" dbType=""/>
							<lMAttributeNode businessName="Full name" ruleName="Validity Rule: cp_exp_full_name" name="exp_FULL_NM" elemId="12054218" type="string" dbType=""/>
							<lMAttributeNode businessName="Gender - src" ruleName="Dimension Rule: completeness_test" name="GNDR" elemId="11885002" type="string" dbType=""/>
							<lMAttributeNode businessName="Gender" ruleName="Validity Rule: cp_exp_gender" name="exp_GNDR" elemId="12054219" type="string" dbType=""/>
							<lMAttributeNode businessName="Phone Area Code - src" ruleName="Dimension Rule: completeness_test" name="PHONE_AREA_CD" elemId="12054196" type="string" dbType=""/>
							<lMAttributeNode businessName="Phone Number - src" ruleName="Dimension Rule: completeness_test" name="PHONE_NMBR" elemId="12054197" type="string" dbType=""/>
							<lMAttributeNode businessName="Phone Number" ruleName="Validity Rule: cp_exp_phone" name="exp_PHONE" elemId="12054220" type="string" dbType=""/>
							<lMAttributeNode businessName="E-mail - src" ruleName="Dimension Rule: completeness_test" name="EMAIL" elemId="12054198" type="string" dbType=""/>
							<lMAttributeNode businessName="E-mail" ruleName="Validity Rule: cp_exp_email" name="exp_EMAIL" elemId="12054221" type="string" dbType=""/>
						</lMAttributeWrapper>
						<lMAttributeCollContainerWrapper/>
					</lMTableNode>
				</lMTableWrapper>
				<lMRelationshipWrapper/>
			</lMRoot>
			<entityRoot name="CRM Customer" code="crm">
				<entityAttributeWrapper/>
				<entityContainerWrapper>
					<entityContainer name="Demographics" elemId="11888434">
						<entityContainerWrapper/>
						<entityAttributeWrapper>
							<entityAttributeNode name="customer.exp_CSTMR_TYPE: cp_exp_cust_type" elemId="12055549"/>
							<entityAttributeNode name="customer.exp_FULL_NM: cp_exp_full_name" elemId="12059717"/>
							<entityAttributeNode name="customer.exp_GNDR: cp_exp_gender" elemId="12059718"/>
							<entityAttributeNode name="customer.CSTMR_TYPE: completeness_test" elemId="12060354"/>
							<entityAttributeNode name="customer.FULL_NM: completeness_test" elemId="12060355"/>
							<entityAttributeNode name="customer.GNDR: completeness_test" elemId="12060356"/>
							<entityAttributeNode name="customer.PHONE_AREA_CD: completeness_test" elemId="12060357"/>
							<entityAttributeNode name="customer.PHONE_NMBR: completeness_test" elemId="12060358"/>
							<entityAttributeNode name="customer.EMAIL: completeness_test" elemId="12060359"/>
						</entityAttributeWrapper>
					</entityContainer>
					<entityContainer name="Contact" elemId="12059719">
						<entityContainerWrapper/>
						<entityAttributeWrapper>
							<entityAttributeNode name="customer.exp_EMAIL: cp_exp_email" elemId="12059720"/>
							<entityAttributeNode name="customer.exp_PHONE: cp_exp_phone" elemId="12061818"/>
						</entityAttributeWrapper>
					</entityContainer>
				</entityContainerWrapper>
			</entityRoot>
			<dimensionWrapper>
				<dimensionNode name="Customer Type" elemId="12060158" column="crm.customer.CSTMR_TYPE"/>
			</dimensionWrapper>
		</modelNode>
	</modelWrapper>
	<ruleRoot ruleType="Validity Rule">
		<collectionRulesOptionWrapper>
			<collectionRulesOptionNode name="Copy result rules" elemId="12059463">
				<ruleOptionWrapper>
					<copyRulesNode ame:include="md/rules/cp_exp_email.md"/>
					<copyRulesNode ame:include="md/rules/cp_exp_cust_type.md"/>
					<copyRulesNode ame:include="md/rules/cp_exp_gender.md"/>
					<copyRulesNode ame:include="md/rules/cp_exp_full_name.md"/>
					<copyRulesNode ame:include="md/rules/cp_exp_phone.md"/>
				</ruleOptionWrapper>
				<collectionRulesOptionWrapper/>
			</collectionRulesOptionNode>
		</collectionRulesOptionWrapper>
	</ruleRoot>
</sourceSystemNode>