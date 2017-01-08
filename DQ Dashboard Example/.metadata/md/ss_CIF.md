<?xml version='1.0' encoding='UTF-8'?>
<sourceSystemNode xmlns:ame="http://www.ataccama.com/ame/md" name="CIF" enable="true" elemId="11882665" code="CIF">
	<description>Customer Information File</description>
	<modelWrapper>
		<modelNode name="Retail Cutomer Details" elemId="11882727" code="retail">
			<description>Model with Retail Cutomer related data elements</description>
			<lMRoot>
				<lMTableWrapper>
					<lMTableNode name="customer" elemId="11882728">
						<lMAttributeWrapper>
							<lMAttributeNode businessName="Customer ID" ruleName="" name="id" elemId="11882729" type="integer" dbType=""/>
							<lMAttributeNode businessName="Customer Type" ruleName="Validity Rule: CSTMR_TP" name="cust_type" elemId="11882730" type="string" dbType=""/>
							<lMAttributeNode businessName="First name" ruleName="" name="first_name" elemId="11882731" type="string" dbType=""/>
							<lMAttributeNode businessName="Last name" ruleName="" name="last_name" elemId="11882732" type="string" dbType=""/>
							<lMAttributeNode businessName="Social Security Number" ruleName="" name="ssn" elemId="11882733" type="string" dbType=""/>
							<lMAttributeNode businessName="Gender" ruleName="Validity Rule: GNDR" name="gender" elemId="12054117" type="string" dbType=""/>
							<lMAttributeNode businessName="Date of Birth" ruleName="" name="dob" elemId="12054118" type="day" dbType=""/>
							<lMAttributeNode businessName="Permission to Market" ruleName="Validity Rule: CIF_PERM" name="pref_market" elemId="12054119" type="string" dbType=""/>
							<lMAttributeNode businessName="Permission to Share" ruleName="Validity Rule: CIF_PERM" name="pref_share" elemId="12054120" type="string" dbType=""/>
						</lMAttributeWrapper>
						<lMAttributeCollContainerWrapper>
							<lMAttributeCollContainerMultiEntityParent ruleName="Validity Rule: HAS_VALID_W_EML" name="Work Email" elemId="12054952" code="has_work_email">
								<lMAttributeCollWrapper>
									<lMAttributeCollNode ruleAttMapping="src_cust_type" attName="cust_type" elemId="12055148"/>
								</lMAttributeCollWrapper>
							</lMAttributeCollContainerMultiEntityParent>
							<lMAttributeCollContainerMultiEntityParent ruleName="Validity Rule: HAS_VALID_W_PHN" name="Phone" elemId="12060872" code="has_phone">
								<lMAttributeCollWrapper>
									<lMAttributeCollNode ruleAttMapping="src_cust_type" attName="cust_type" elemId="12060923"/>
								</lMAttributeCollWrapper>
							</lMAttributeCollContainerMultiEntityParent>
							<lMAttributeCollContainerOneEntity ruleName="Validity Rule: CIF_FULL_NAME" name="Full name" elemId="12055661" code="full_name">
								<lMAttributeCollWrapper>
									<lMAttributeCollNode ruleAttMapping="src_first_name" attName="first_name" elemId="12055681"/>
									<lMAttributeCollNode ruleAttMapping="src_last_name" attName="last_name" elemId="12055682"/>
								</lMAttributeCollWrapper>
							</lMAttributeCollContainerOneEntity>
							<lMAttributeCollContainerOneEntity ruleName="Validity Rule: CIF_DOB" name="Birth date" elemId="12055683" code="DOB">
								<lMAttributeCollWrapper>
									<lMAttributeCollNode ruleAttMapping="src_birth_date" attName="dob" elemId="12055694"/>
									<lMAttributeCollNode ruleAttMapping="src_customer_type" attName="cust_type" elemId="12055695"/>
								</lMAttributeCollWrapper>
							</lMAttributeCollContainerOneEntity>
							<lMAttributeCollContainerOneEntity ruleName="Dimension Rule: accuracy_test" name="Full name" elemId="12060230" code="acc_name">
								<lMAttributeCollWrapper>
									<lMAttributeCollNode ruleAttMapping="in_column" attName="first_name" elemId="12060236"/>
									<lMAttributeCollNode ruleAttMapping="in_date" attName="dob" elemId="12060237"/>
								</lMAttributeCollWrapper>
							</lMAttributeCollContainerOneEntity>
							<lMAttributeCollContainerOneEntity ruleName="Dimension Rule: accuracy_test" name="Gender" elemId="12060231" code="acc_gender">
								<lMAttributeCollWrapper>
									<lMAttributeCollNode ruleAttMapping="in_column" attName="gender" elemId="12060238"/>
									<lMAttributeCollNode ruleAttMapping="in_date" attName="dob" elemId="12060239"/>
								</lMAttributeCollWrapper>
							</lMAttributeCollContainerOneEntity>
							<lMAttributeCollContainerOneEntity ruleName="Dimension Rule: accuracy_test" name="Social Security Number" elemId="12060232" code="acc_ssn">
								<lMAttributeCollWrapper>
									<lMAttributeCollNode ruleAttMapping="in_column" attName="ssn" elemId="12060248"/>
									<lMAttributeCollNode ruleAttMapping="in_date" attName="dob" elemId="12060249"/>
								</lMAttributeCollWrapper>
							</lMAttributeCollContainerOneEntity>
							<lMAttributeCollContainerOneEntity ruleName="Dimension Rule: completeness_test" name="Full name" elemId="12060266" code="cmpl_name">
								<lMAttributeCollWrapper>
									<lMAttributeCollNode ruleAttMapping="in_column" attName="first_name" elemId="12060271"/>
								</lMAttributeCollWrapper>
							</lMAttributeCollContainerOneEntity>
							<lMAttributeCollContainerOneEntity ruleName="Dimension Rule: completeness_test" name="Gender" elemId="12060267" code="cmpl_gender">
								<lMAttributeCollWrapper>
									<lMAttributeCollNode ruleAttMapping="in_column" attName="gender" elemId="12060272"/>
								</lMAttributeCollWrapper>
							</lMAttributeCollContainerOneEntity>
							<lMAttributeCollContainerOneEntity ruleName="Dimension Rule: completeness_test" name="Social Security Number" elemId="12060261" code="cmpl_ssn">
								<lMAttributeCollWrapper>
									<lMAttributeCollNode ruleAttMapping="in_column" attName="ssn" elemId="12060273"/>
								</lMAttributeCollWrapper>
							</lMAttributeCollContainerOneEntity>
							<lMAttributeCollContainerOneEntity ruleName="Dimension Rule: MTCH_BLACKLISTED_SSN" name="Blacklisted SSN" elemId="12060289" code="blacklisted_ssn">
								<lMAttributeCollWrapper>
									<lMAttributeCollNode ruleAttMapping="in_ssn" attName="ssn" elemId="12060296"/>
								</lMAttributeCollWrapper>
							</lMAttributeCollContainerOneEntity>
						</lMAttributeCollContainerWrapper>
					</lMTableNode>
					<lMTableNode name="email" elemId="11882811">
						<lMAttributeWrapper>
							<lMAttributeNode businessName="Customer ID" ruleName="" name="customer_id" elemId="11882812" type="integer" dbType=""/>
							<lMAttributeNode businessName="Email" ruleName="Validity Rule: EmailValid" name="email" elemId="11882813" type="string" dbType=""/>
							<lMAttributeNode businessName="Type" ruleName="" name="type" elemId="11882814" type="string" dbType=""/>
							<lMAttributeNode businessName="Mention rate" ruleName="" name="mention_rate" elemId="11882815" type="integer" dbType=""/>
						</lMAttributeWrapper>
						<lMAttributeCollContainerWrapper>
							<lMAttributeCollContainerMultiEntityChild parentInstance="customer.has_work_email" ruleName="Validity Rule: HAS_VALID_W_EML" name="-" elemId="12055154" code="-">
								<lMAttributeChildCollWrapper>
									<lMAttributeChildCollNode ruleAttMapping="src_email_type" attName="type" elemId="12055170"/>
								</lMAttributeChildCollWrapper>
								<lMAttributeRuleResultWrapper>
									<lMAttributeRuleResultNode ruleAttMapping="email_rule_result" elemId="12055171" ruleResult="Validity Rule: EmailValid (email)"/>
								</lMAttributeRuleResultWrapper>
							</lMAttributeCollContainerMultiEntityChild>
						</lMAttributeCollContainerWrapper>
					</lMTableNode>
					<lMTableNode name="contract" elemId="11882816">
						<lMAttributeWrapper>
							<lMAttributeNode businessName="ID" ruleName="" name="id" elemId="11882817" type="integer" dbType=""/>
							<lMAttributeNode businessName="Customer ID" ruleName="" name="customer_id" elemId="11882818" type="integer" dbType=""/>
							<lMAttributeNode businessName="SalePoint" ruleName="" name="salepoint_id" elemId="11882819" type="string" dbType=""/>
							<lMAttributeNode businessName="Status" ruleName="" name="status" elemId="12054164" type="string" dbType=""/>
							<lMAttributeNode businessName="Type" ruleName="" name="type" elemId="12054165" type="string" dbType=""/>
							<lMAttributeNode businessName="Date From" ruleName="" name="dt_from" elemId="12054166" type="string" dbType=""/>
							<lMAttributeNode businessName="Date To" ruleName="" name="dt_to" elemId="12054167" type="string" dbType=""/>
							<lMAttributeNode businessName="Product" ruleName="" name="prdct" elemId="12054168" type="string" dbType=""/>
							<lMAttributeNode businessName="Amount" ruleName="" name="amt" elemId="12054181" type="string" dbType=""/>
							<lMAttributeNode businessName="Currency" ruleName="" name="crncy" elemId="12054182" type="string" dbType=""/>
						</lMAttributeWrapper>
						<lMAttributeCollContainerWrapper/>
					</lMTableNode>
					<lMTableNode name="phone" elemId="11882825">
						<lMAttributeWrapper>
							<lMAttributeNode businessName="Customer ID" ruleName="" name="customer_id" elemId="11882826" type="integer" dbType=""/>
							<lMAttributeNode businessName="Phone Number" ruleName="Validity Rule: PhoneValid" name="phone" elemId="11882828" type="string" dbType=""/>
							<lMAttributeNode businessName="Type" ruleName="" name="type" elemId="12054909" type="string" dbType=""/>
						</lMAttributeWrapper>
						<lMAttributeCollContainerWrapper>
							<lMAttributeCollContainerMultiEntityChild parentInstance="customer.has_phone" ruleName="Validity Rule: HAS_VALID_W_PHN" name="-" elemId="12060927" code="-">
								<lMAttributeChildCollWrapper/>
								<lMAttributeRuleResultWrapper>
									<lMAttributeRuleResultNode ruleAttMapping="phone_rule_result" elemId="12060931" ruleResult="Validity Rule: PhoneValid (phone)"/>
								</lMAttributeRuleResultWrapper>
							</lMAttributeCollContainerMultiEntityChild>
						</lMAttributeCollContainerWrapper>
					</lMTableNode>
				</lMTableWrapper>
				<lMRelationshipWrapper>
					<lMRelationshipNode name="Customer has Email" elemId="11882829" parentTable="customer" childTable="email">
						<lMForeignKeyWrapper>
							<lMForeignKeyNode parentColumn="id" elemId="11883074" childColumn="customer_id"/>
						</lMForeignKeyWrapper>
					</lMRelationshipNode>
					<lMRelationshipNode name="Customer has Contract" elemId="11882830" parentTable="customer" childTable="contract">
						<lMForeignKeyWrapper>
							<lMForeignKeyNode parentColumn="id" elemId="11883075" childColumn="customer_id"/>
						</lMForeignKeyWrapper>
					</lMRelationshipNode>
					<lMRelationshipNode name="Customer has Phone" elemId="11883079" parentTable="customer" childTable="phone">
						<lMForeignKeyWrapper>
							<lMForeignKeyNode parentColumn="id" elemId="11883080" childColumn="customer_id"/>
						</lMForeignKeyWrapper>
					</lMRelationshipNode>
				</lMRelationshipWrapper>
			</lMRoot>
			<entityRoot name="CIF Retail Customer" code="cif_customer_retail">
				<entityAttributeWrapper/>
				<entityContainerWrapper>
					<entityContainer name="Demographics" elemId="11887326">
						<entityContainerWrapper/>
						<entityAttributeWrapper>
							<entityAttributeNode name="customer.cust_type: CSTMR_TP" elemId="12055273"/>
							<entityAttributeNode name="customer.gender: GNDR" elemId="12055274"/>
							<entityAttributeNode name="customer.DOB: CIF_DOB" elemId="12055700"/>
							<entityAttributeNode name="customer.full_name: CIF_FULL_NAME" elemId="12055701"/>
							<entityAttributeNode name="customer.cmpl_name: completeness_test" elemId="12060281"/>
							<entityAttributeNode name="customer.cmpl_gender: completeness_test" elemId="12060282"/>
							<entityAttributeNode name="customer.cmpl_ssn: completeness_test" elemId="12060283"/>
							<entityAttributeNode name="customer.acc_name: accuracy_test" elemId="12060284"/>
							<entityAttributeNode name="customer.acc_gender: accuracy_test" elemId="12060285"/>
							<entityAttributeNode name="customer.acc_ssn: accuracy_test" elemId="12060286"/>
							<entityAttributeNode name="customer.blacklisted_ssn: MTCH_BLACKLISTED_SSN" elemId="12060287"/>
						</entityAttributeWrapper>
					</entityContainer>
					<entityContainer name="Preferences" elemId="12055530">
						<entityContainerWrapper/>
						<entityAttributeWrapper>
							<entityAttributeNode name="customer.pref_market: CIF_PERM" elemId="12055531"/>
							<entityAttributeNode name="customer.pref_share: CIF_PERM" elemId="12055532"/>
						</entityAttributeWrapper>
					</entityContainer>
					<entityContainer name="Contact" elemId="11887330">
						<entityContainerWrapper>
							<entityContainer name="Email" elemId="12055533">
								<entityContainerWrapper/>
								<entityAttributeWrapper>
									<entityAttributeNode name="customer.has_work_email: HAS_VALID_W_EML" elemId="12055534"/>
								</entityAttributeWrapper>
							</entityContainer>
							<entityContainer name="Phone" elemId="12055535">
								<entityContainerWrapper/>
								<entityAttributeWrapper>
									<entityAttributeNode name="customer.has_phone: HAS_VALID_W_PHN" elemId="12055536"/>
								</entityAttributeWrapper>
							</entityContainer>
						</entityContainerWrapper>
						<entityAttributeWrapper/>
					</entityContainer>
				</entityContainerWrapper>
			</entityRoot>
			<dimensionWrapper>
				<dimensionNode name="Customer Type" elemId="11883342" column="retail.customer.cust_type"/>
				<dimensionNode name="Customer Gender" elemId="11883564" column="retail.customer.gender"/>
			</dimensionWrapper>
		</modelNode>
		<modelNode name="Corporate Cutomer Details" elemId="12051214" code="corporate">
			<description>Model with Corporate Cutomer related data elements</description>
			<lMRoot>
				<lMTableWrapper>
					<lMTableNode name="customer" elemId="12054227">
						<lMAttributeWrapper>
							<lMAttributeNode businessName="Customer ID" ruleName="" name="id" elemId="12054272" type="integer" dbType=""/>
							<lMAttributeNode businessName="Customer Type" ruleName="Validity Rule: CSTMR_TP" name="cust_type" elemId="12054273" type="string" dbType=""/>
							<lMAttributeNode businessName="Legal Name" ruleName="Validity Rule: CIF_LGL_NM" name="legal_name" elemId="12054274" type="string" dbType=""/>
							<lMAttributeNode businessName="Tax id" ruleName="" name="tx_id" elemId="12054275" type="string" dbType=""/>
							<lMAttributeNode businessName="Registration Date" ruleName="Validity Rule: CIF_RGSTR_DT" name="reg_dt" elemId="12054276" type="day" dbType=""/>
							<lMAttributeNode businessName="Permission to Market" ruleName="Validity Rule: CIF_PERM" name="pref_market" elemId="12054277" type="string" dbType=""/>
							<lMAttributeNode businessName="Permission to Share" ruleName="Validity Rule: CIF_PERM" name="pref_share" elemId="12054278" type="string" dbType=""/>
						</lMAttributeWrapper>
						<lMAttributeCollContainerWrapper>
							<lMAttributeCollContainerMultiEntityParent ruleName="Validity Rule: HAS_VALID_W_EML" name="Work Email" elemId="12059681" code="has_work_email">
								<lMAttributeCollWrapper>
									<lMAttributeCollNode ruleAttMapping="src_cust_type" attName="cust_type" elemId="12055148"/>
								</lMAttributeCollWrapper>
							</lMAttributeCollContainerMultiEntityParent>
							<lMAttributeCollContainerMultiEntityParent ruleName="Validity Rule: HAS_VALID_W_PHN" name="Phone" elemId="12060936" code="has_phone">
								<lMAttributeCollWrapper>
									<lMAttributeCollNode ruleAttMapping="src_cust_type" attName="cust_type" elemId="12060970"/>
								</lMAttributeCollWrapper>
							</lMAttributeCollContainerMultiEntityParent>
							<lMAttributeCollContainerOneEntity ruleName="Dimension Rule: MTCH_TAX_ID" name="Blacklisted Tax ID" elemId="12060302" code="blacklisted_tax_id">
								<lMAttributeCollWrapper>
									<lMAttributeCollNode ruleAttMapping="in_tax_id" attName="tx_id" elemId="12060306"/>
								</lMAttributeCollWrapper>
							</lMAttributeCollContainerOneEntity>
							<lMAttributeCollContainerOneEntity ruleName="Dimension Rule: accuracy_test" name="Tax ID" elemId="12060317" code="acc_tax_id">
								<lMAttributeCollWrapper>
									<lMAttributeCollNode ruleAttMapping="in_column" attName="tx_id" elemId="12060313"/>
									<lMAttributeCollNode ruleAttMapping="in_date" attName="reg_dt" elemId="12060314"/>
								</lMAttributeCollWrapper>
							</lMAttributeCollContainerOneEntity>
							<lMAttributeCollContainerOneEntity ruleName="Dimension Rule: accuracy_test" name="Legal Name" elemId="12060307" code="acc_legal_name">
								<lMAttributeCollWrapper>
									<lMAttributeCollNode ruleAttMapping="in_column" attName="legal_name" elemId="12060313"/>
									<lMAttributeCollNode ruleAttMapping="in_date" attName="reg_dt" elemId="12060314"/>
								</lMAttributeCollWrapper>
							</lMAttributeCollContainerOneEntity>
							<lMAttributeCollContainerOneEntity ruleName="Dimension Rule: completeness_test" name="Tax ID" elemId="12060328" code="compl_tax_id">
								<lMAttributeCollWrapper>
									<lMAttributeCollNode ruleAttMapping="in_column" attName="tx_id" elemId="12060325"/>
								</lMAttributeCollWrapper>
							</lMAttributeCollContainerOneEntity>
							<lMAttributeCollContainerOneEntity ruleName="Dimension Rule: completeness_test" name="Legal Name" elemId="12060318" code="compl_legal_name">
								<lMAttributeCollWrapper>
									<lMAttributeCollNode ruleAttMapping="in_column" attName="legal_name" elemId="12060325"/>
								</lMAttributeCollWrapper>
							</lMAttributeCollContainerOneEntity>
						</lMAttributeCollContainerWrapper>
					</lMTableNode>
					<lMTableNode name="email" elemId="12054235">
						<lMAttributeWrapper>
							<lMAttributeNode businessName="Customer ID" ruleName="" name="customer_id" elemId="11882812" type="integer" dbType=""/>
							<lMAttributeNode businessName="Email" ruleName="Validity Rule: EmailValid" name="email" elemId="11882813" type="string" dbType=""/>
							<lMAttributeNode businessName="Type" ruleName="" name="type" elemId="11882814" type="string" dbType=""/>
							<lMAttributeNode businessName="Mention rate" ruleName="" name="mention_rate" elemId="11882815" type="integer" dbType=""/>
						</lMAttributeWrapper>
						<lMAttributeCollContainerWrapper>
							<lMAttributeCollContainerMultiEntityChild parentInstance="customer.has_work_email" ruleName="Validity Rule: HAS_VALID_W_EML" name="-" elemId="12059677" code="-">
								<lMAttributeChildCollWrapper>
									<lMAttributeChildCollNode ruleAttMapping="src_email_type" attName="type" elemId="12055170"/>
								</lMAttributeChildCollWrapper>
								<lMAttributeRuleResultWrapper>
									<lMAttributeRuleResultNode ruleAttMapping="email_rule_result" elemId="12055171" ruleResult="Validity Rule: EmailValid (email)"/>
								</lMAttributeRuleResultWrapper>
							</lMAttributeCollContainerMultiEntityChild>
						</lMAttributeCollContainerWrapper>
					</lMTableNode>
					<lMTableNode name="contract" elemId="12054243">
						<lMAttributeWrapper>
							<lMAttributeNode businessName="Customer ID" ruleName="" name="customer_id" elemId="11882818" type="integer" dbType=""/>
							<lMAttributeNode businessName="SalePoint" ruleName="" name="salepoint_id" elemId="11882819" type="string" dbType=""/>
							<lMAttributeNode businessName="Status" ruleName="" name="status" elemId="12054164" type="string" dbType=""/>
							<lMAttributeNode businessName="Type" ruleName="" name="type" elemId="12054165" type="string" dbType=""/>
							<lMAttributeNode businessName="Date From" ruleName="" name="dt_from" elemId="12054166" type="string" dbType=""/>
							<lMAttributeNode businessName="Date To" ruleName="" name="dt_to" elemId="12054167" type="string" dbType=""/>
							<lMAttributeNode businessName="Product" ruleName="" name="prdct" elemId="12054168" type="string" dbType=""/>
							<lMAttributeNode businessName="Amount" ruleName="" name="amt" elemId="12054181" type="string" dbType=""/>
							<lMAttributeNode businessName="Currency" ruleName="" name="crncy" elemId="12054182" type="string" dbType=""/>
						</lMAttributeWrapper>
						<lMAttributeCollContainerWrapper/>
					</lMTableNode>
					<lMTableNode name="phone" elemId="12054251">
						<lMAttributeWrapper>
							<lMAttributeNode businessName="Customer ID" ruleName="" name="customer_id" elemId="11882826" type="integer" dbType=""/>
							<lMAttributeNode businessName="Phone Number" ruleName="Validity Rule: PhoneValid" name="phone" elemId="11882828" type="string" dbType=""/>
							<lMAttributeNode businessName="Type" ruleName="" name="type" elemId="12059672" type="string" dbType=""/>
						</lMAttributeWrapper>
						<lMAttributeCollContainerWrapper>
							<lMAttributeCollContainerMultiEntityChild parentInstance="customer.has_phone" ruleName="Validity Rule: HAS_VALID_W_PHN" name="-" elemId="12061008" code="-">
								<lMAttributeChildCollWrapper/>
								<lMAttributeRuleResultWrapper>
									<lMAttributeRuleResultNode ruleAttMapping="phone_rule_result" elemId="12061017" ruleResult="Validity Rule: PhoneValid (phone)"/>
								</lMAttributeRuleResultWrapper>
							</lMAttributeCollContainerMultiEntityChild>
						</lMAttributeCollContainerWrapper>
					</lMTableNode>
				</lMTableWrapper>
				<lMRelationshipWrapper>
					<lMRelationshipNode name="Customer has Email" elemId="12054259" parentTable="customer" childTable="email">
						<lMForeignKeyWrapper>
							<lMForeignKeyNode parentColumn="id" elemId="11883074" childColumn="customer_id"/>
						</lMForeignKeyWrapper>
					</lMRelationshipNode>
					<lMRelationshipNode name="Customer has Contract" elemId="12054263" parentTable="customer" childTable="contract">
						<lMForeignKeyWrapper>
							<lMForeignKeyNode parentColumn="id" elemId="11883075" childColumn="customer_id"/>
						</lMForeignKeyWrapper>
					</lMRelationshipNode>
					<lMRelationshipNode name="Customer has Phone" elemId="12054267" parentTable="customer" childTable="phone">
						<lMForeignKeyWrapper>
							<lMForeignKeyNode parentColumn="id" elemId="11883080" childColumn="customer_id"/>
						</lMForeignKeyWrapper>
					</lMRelationshipNode>
				</lMRelationshipWrapper>
			</lMRoot>
			<entityRoot name="CIF Corporate Customer" code="cif_customer_corp">
				<entityAttributeWrapper/>
				<entityContainerWrapper>
					<entityContainer name="Demographics" elemId="12059361">
						<entityContainerWrapper/>
						<entityAttributeWrapper>
							<entityAttributeNode name="customer.cust_type: CSTMR_TP" elemId="12059687"/>
							<entityAttributeNode name="customer.legal_name: CIF_LGL_NM" elemId="12059688"/>
							<entityAttributeNode name="customer.reg_dt: CIF_RGSTR_DT" elemId="12059689"/>
							<entityAttributeNode name="customer.acc_tax_id: accuracy_test" elemId="12060337"/>
							<entityAttributeNode name="customer.acc_legal_name: accuracy_test" elemId="12060338"/>
							<entityAttributeNode name="customer.compl_tax_id: completeness_test" elemId="12060339"/>
							<entityAttributeNode name="customer.compl_legal_name: completeness_test" elemId="12060340"/>
							<entityAttributeNode name="customer.blacklisted_tax_id: MTCH_TAX_ID" elemId="12060341"/>
						</entityAttributeWrapper>
					</entityContainer>
					<entityContainer name="Preferences" elemId="12059362">
						<entityContainerWrapper/>
						<entityAttributeWrapper>
							<entityAttributeNode name="customer.pref_market: CIF_PERM" elemId="12055531"/>
							<entityAttributeNode name="customer.pref_share: CIF_PERM" elemId="12055532"/>
						</entityAttributeWrapper>
					</entityContainer>
					<entityContainer name="Contact" elemId="12059363">
						<entityContainerWrapper>
							<entityContainer name="Email" elemId="12055533">
								<entityContainerWrapper/>
								<entityAttributeWrapper>
									<entityAttributeNode name="customer.has_work_email: HAS_VALID_W_EML" elemId="12055534"/>
								</entityAttributeWrapper>
							</entityContainer>
							<entityContainer name="Phone" elemId="12055535">
								<entityContainerWrapper/>
								<entityAttributeWrapper>
									<entityAttributeNode name="customer.has_phone: HAS_VALID_W_PHN" elemId="12055536"/>
								</entityAttributeWrapper>
							</entityContainer>
						</entityContainerWrapper>
						<entityAttributeWrapper/>
					</entityContainer>
				</entityContainerWrapper>
			</entityRoot>
			<dimensionWrapper>
				<dimensionNode name="Customer Type" elemId="12059663" column="corporate.customer.cust_type"/>
			</dimensionWrapper>
		</modelNode>
	</modelWrapper>
	<ruleRoot ruleType="Validity Rule">
		<collectionRulesOptionWrapper>
			<collectionRulesOptionNode name="Customer" elemId="11995436">
				<ruleOptionWrapper>
					<expressionRulesNode ame:include="md/rules/CIF_PERM.md"/>
				</ruleOptionWrapper>
				<collectionRulesOptionWrapper>
					<collectionRulesOptionNode name="Retail" elemId="12054864">
						<ruleOptionWrapper>
							<expressionRulesNode ame:include="md/rules/CIF_DOB.md"/>
							<planRulesNode ame:include="md/rules/CIF_FULL_NAME.md"/>
						</ruleOptionWrapper>
						<collectionRulesOptionWrapper/>
					</collectionRulesOptionNode>
					<collectionRulesOptionNode name="Aggregation rules" elemId="12054916">
						<ruleOptionWrapper>
							<multiEntityExpressionRulesNode ame:include="md/rules/HAS_VALID_W_EML.md"/>
						</ruleOptionWrapper>
						<collectionRulesOptionWrapper/>
					</collectionRulesOptionNode>
				</collectionRulesOptionWrapper>
			</collectionRulesOptionNode>
		</collectionRulesOptionWrapper>
	</ruleRoot>
</sourceSystemNode>