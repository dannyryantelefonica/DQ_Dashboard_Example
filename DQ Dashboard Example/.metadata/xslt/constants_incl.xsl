<?xml version='1.0' encoding='UTF-8'?>
<xsl:stylesheet exclude-result-prefixes="sf" xmlns:sf="http://www.ataccama.com/xslt/functions" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">

<!-- DQC/DQD version that is used in all plans in purity-config version -->
<xsl:variable select="&#39;10.5.0&#39;" name="dqd_version"/>

<!-- Descritpion and name for fallback explanation code='OTHER'-->
<xsl:variable select="&#39;Other reason for invalidity&#39;" name="exp_OTHER_description"/>
<xsl:variable select="&#39;Other reason&#39;" name="exp_OTHER_name"/>

</xsl:stylesheet>