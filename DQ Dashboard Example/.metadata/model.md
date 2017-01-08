<?xml version='1.0' encoding='UTF-8'?>
<md xmlns:ame="http://www.ataccama.com/ame/md">
	<preferenceRoot filterCombLimit="1000" effectiveDate="NowDateProvider" datamart="local_DQD">
		<dataSample outputDir="../data/out" fileNamePattern="dqd_${processing.start:yyMMdd}_${processing.start:HHmmss}_${system}_${model}.csv" sampleSize="100"/>
	</preferenceRoot>
	<dqDimensionRoot>
		<dqDimensionWrapper>
			<dqDimensionNode id="ACCURACY" name="Accuracy" elemId="11429658">
				<description>Record accuracy captures information ...</description>
				<dqDimensionResultWrapper>
					<dqDimensionResultNode id="ACCURATE" name="Accurate" elemId="11429659">
						<description>desc...</description>
					</dqDimensionResultNode>
					<dqDimensionResultNode id="NOT_ACCURATE" name="Not Accurate" elemId="11429660">
						<description></description>
					</dqDimensionResultNode>
					<dqDimensionResultNode id="NULL" name="Null" elemId="11433614">
						<description></description>
					</dqDimensionResultNode>
				</dqDimensionResultWrapper>
				<dqRuleRoot ruleType="Dimension Rule">
					<dqCollectionRulesOptionWrapper>
						<dqCollectionRulesOptionNode name="Basic Accuracy Rules" elemId="12051101">
							<dqRuleOptionWrapper>
								<dqExpressionRulesNode ame:include="md/rules/accuracy_test.md"/>
							</dqRuleOptionWrapper>
							<dqCollectionRulesOptionWrapper/>
						</dqCollectionRulesOptionNode>
					</dqCollectionRulesOptionWrapper>
				</dqRuleRoot>
			</dqDimensionNode>
			<dqDimensionNode id="COMPLETENESS" name="Completeness" elemId="11430503">
				<description></description>
				<dqDimensionResultWrapper>
					<dqDimensionResultNode id="COMPLETE" name="Complete" elemId="11306205">
						<description></description>
					</dqDimensionResultNode>
					<dqDimensionResultNode id="NOT_COMPLETE" name="Not complete" elemId="11306206">
						<description></description>
					</dqDimensionResultNode>
				</dqDimensionResultWrapper>
				<dqRuleRoot ruleType="Dimension Rule">
					<dqCollectionRulesOptionWrapper>
						<dqCollectionRulesOptionNode name="Basic Completeness Rules" elemId="12051103">
							<dqRuleOptionWrapper>
								<dqExpressionRulesNode ame:include="md/rules/completeness_test.md"/>
							</dqRuleOptionWrapper>
							<dqCollectionRulesOptionWrapper/>
						</dqCollectionRulesOptionNode>
					</dqCollectionRulesOptionWrapper>
				</dqRuleRoot>
			</dqDimensionNode>
			<dqDimensionNode id="MATCHING" name="Matching to reference data" elemId="11430504">
				<description></description>
				<dqDimensionResultWrapper>
					<dqDimensionResultNode id="MATCH" name="Matched" elemId="11317954">
						<description>Value was matched to record in reference data</description>
					</dqDimensionResultNode>
					<dqDimensionResultNode id="PARTIAL_MATCH" name="Partialy matched" elemId="11317956">
						<description>Partial matching between record and reference data</description>
					</dqDimensionResultNode>
					<dqDimensionResultNode id="NO_MATCH" name="Not matched" elemId="11317957">
						<description>Record doesn&#39;t correspond to any reference data</description>
					</dqDimensionResultNode>
				</dqDimensionResultWrapper>
				<dqRuleRoot ruleType="Dimension Rule">
					<dqCollectionRulesOptionWrapper>
						<dqCollectionRulesOptionNode name="Basic Matching Rules" elemId="12060185">
							<dqRuleOptionWrapper>
								<dqExpressionRulesNode ame:include="md/rules/MTCH_TAX_ID.md"/>
								<dqExpressionRulesNode ame:include="md/rules/MTCH_CSTMR_TP.md"/>
								<dqExpressionRulesNode ame:include="md/rules/MTCH_BLACKLISTED_SSN.md"/>
							</dqRuleOptionWrapper>
							<dqCollectionRulesOptionWrapper/>
						</dqCollectionRulesOptionNode>
					</dqCollectionRulesOptionWrapper>
				</dqRuleRoot>
			</dqDimensionNode>
		</dqDimensionWrapper>
	</dqDimensionRoot>
	<sourceSystemRoot>
		<sourceSystemWrapper>
			<sourceSystemNode ame:include="md/ss_CIF.md"/>
			<sourceSystemNode ame:include="md/ss_Marketing.md"/>
		</sourceSystemWrapper>
	</sourceSystemRoot>
	<masterEntityRoot>
		<masterEntityWrapper>
			<masterEntityNode name="Retail customer" elemId="12055553" code="Retail customer">
				<masterEntityRelationshipWrapper>
					<masterEntityRelationshipNode name="CIF.retail" elemId="12055554"/>
					<masterEntityRelationshipNode name="Marketing.crm" elemId="12059728"/>
				</masterEntityRelationshipWrapper>
				<masterEntityWrapper>
					<masterEntityNode name="Contact" elemId="12055555" code="Contact">
						<masterEntityRelationshipWrapper>
							<masterEntityRelationshipNode name="CIF.retail.Contact" elemId="12055556"/>
							<masterEntityRelationshipNode name="Marketing.crm.Contact" elemId="12059729"/>
						</masterEntityRelationshipWrapper>
						<masterEntityWrapper/>
					</masterEntityNode>
					<masterEntityNode name="Demographics" elemId="12055557" code="Demographics">
						<masterEntityRelationshipWrapper>
							<masterEntityRelationshipNode name="CIF.retail.Demographics" elemId="12055558"/>
							<masterEntityRelationshipNode name="Marketing.crm.Demographics" elemId="12059730"/>
						</masterEntityRelationshipWrapper>
						<masterEntityWrapper/>
					</masterEntityNode>
				</masterEntityWrapper>
			</masterEntityNode>
			<masterEntityNode name="Corporate customer" elemId="12055559" code="Corporate customer">
				<masterEntityRelationshipWrapper>
					<masterEntityRelationshipNode name="CIF.corporate" elemId="12055560"/>
				</masterEntityRelationshipWrapper>
				<masterEntityWrapper>
					<masterEntityNode name="Contact" elemId="12059736" code="Contact">
						<masterEntityRelationshipWrapper>
							<masterEntityRelationshipNode name="CIF.corporate.Contact" elemId="12059738"/>
						</masterEntityRelationshipWrapper>
						<masterEntityWrapper/>
					</masterEntityNode>
					<masterEntityNode name="Demographics" elemId="12059739" code="Demographics">
						<masterEntityRelationshipWrapper>
							<masterEntityRelationshipNode name="CIF.corporate.Demographics" elemId="12059740"/>
						</masterEntityRelationshipWrapper>
						<masterEntityWrapper/>
					</masterEntityNode>
				</masterEntityWrapper>
			</masterEntityNode>
			<masterEntityNode name="Contact" elemId="12055561" code="Contact">
				<masterEntityRelationshipWrapper>
					<masterEntityRelationshipNode name="CIF.retail.Contact" elemId="12055562"/>
					<masterEntityRelationshipNode name="CIF.corporate.Contact" elemId="12059744"/>
					<masterEntityRelationshipNode name="Marketing.crm.Contact" elemId="12059745"/>
				</masterEntityRelationshipWrapper>
				<masterEntityWrapper/>
			</masterEntityNode>
		</masterEntityWrapper>
	</masterEntityRoot>
	<defaultRuleRoot ruleType="Validity Rule">
		<collectionRulesOptionWrapper>
			<collectionRulesOptionNode name="Customer" elemId="11774602">
				<ruleOptionWrapper>
					<planRulesNode ame:include="md/rules/CSTMR_TP.md"/>
				</ruleOptionWrapper>
				<collectionRulesOptionWrapper>
					<collectionRulesOptionNode name="Personal attributes" elemId="12054533">
						<ruleOptionWrapper>
							<expressionRulesNode ame:include="md/rules/GNDR.md"/>
						</ruleOptionWrapper>
						<collectionRulesOptionWrapper/>
					</collectionRulesOptionNode>
					<collectionRulesOptionNode name="Corporate attributes" elemId="12054534">
						<ruleOptionWrapper>
							<expressionRulesNode ame:include="md/rules/CIF_LGL_NM.md"/>
							<expressionRulesNode ame:include="md/rules/CIF_RGSTR_DT.md"/>
						</ruleOptionWrapper>
						<collectionRulesOptionWrapper/>
					</collectionRulesOptionNode>
				</collectionRulesOptionWrapper>
			</collectionRulesOptionNode>
			<collectionRulesOptionNode name="Contact" elemId="11778303">
				<ruleOptionWrapper>
					<planRulesNode ame:include="md/rules/EmailValid.md"/>
					<planRulesNode ame:include="md/rules/PhoneValid.md"/>
				</ruleOptionWrapper>
				<collectionRulesOptionWrapper/>
			</collectionRulesOptionNode>
			<collectionRulesOptionNode name="Basic" elemId="11779483">
				<ruleOptionWrapper>
					<expressionRulesNode ame:include="md/rules/IS_NOT_NULL.md"/>
					<expressionRulesNode ame:include="md/rules/IS_INT_M.md"/>
					<expressionRulesNode ame:include="md/rules/IS_INT.md"/>
				</ruleOptionWrapper>
				<collectionRulesOptionWrapper/>
			</collectionRulesOptionNode>
			<collectionRulesOptionNode name="Aggregation rules" elemId="12054927">
				<ruleOptionWrapper>
					<multiEntityExpressionRulesNode ame:include="md/rules/HAS_VALID_W_PHN.md"/>
				</ruleOptionWrapper>
				<collectionRulesOptionWrapper/>
			</collectionRulesOptionNode>
		</collectionRulesOptionWrapper>
	</defaultRuleRoot>
</md>