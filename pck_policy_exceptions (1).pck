CREATE OR REPLACE PACKAGE PROJECT_DEV_07.pck_policy_exceptions AS
/*******************************************************************************************
- File Name        : pck_policy_exceptions
- Description      : Package to produce policy level exceptions for GPS renewals
- Author           : Angela Dougan
- Date             : 9 November 2006
- Version          : 0.1
- Modification History :
- Date              Version    Modified by    Brief Description of Modification
-------------------------------------------------------------------------------------------
- $Log:   //vm1/PICCSDB/archives/life/database/headers/pck_policy_exceptions.spc-arc  $
--
--   Rev 1.61   Jan 30 2020 15:21:52   SourceSafe
--Integrated version 1.60.1.0 from project OST
--
--   Rev 1.60.1.0   13 Jan 2020 15:21:56   dmcneil
--OST Call 167146 - chnge to HC781 to omit CPS
--
--   Rev 1.60   Sep 12 2018 15:13:12   SourceSafe
--Integrated version 1.59.1.0 from project TALISKER_EXISTING_BUSINESS
--
--   Rev 1.59.1.0   Jul 13 2018 15:30:04   pdhanpal1
--Talisker Existing Business - Healthcheck Changes
--
--   Rev 1.59   Apr 11 2018 10:30:10   SourceSafe
--Integrated version 1.58.1.2 from project GST_RENEWALS_CYCLE_THREE
--
--   Rev 1.58.1.2   Apr 09 2018 15:33:34   psundar
--Minor code review changes
--
--   Rev 1.58.1.1   Mar 05 2018 16:29:14   psundar
--Minor parameter change in p_retirement_age_check procedure
--
--   Rev 1.58.1.0   Mar 05 2018 14:53:42   psundar
--Added parameters in p_retirement_age_check procedure
--
--   Rev 1.58   May 19 2017 15:45:18   SourceSafe
--Integrated version 1.57.1.0 from project PROFITSHARE_CRS
--
--   Rev 1.57.1.0   May 19 2017 15:31:52   rhegganni
--Same as 1.57 - Dummy check in
--
--   Rev 1.57   May 19 2017 14:37:36   SourceSafe
--Integrated version 1.56.1.0 from project PROFITSHARE_CRS
--
--   Rev 1.56.1.0   Apr 07 2017 14:52:20   KAnala
--Code change related to LIVE_BUG_FIX_116745
--
--   Rev 1.56   Jan 12 2017 14:58:30   SourceSafe
--Integrated version 1.55.1.0 from project PROFITSHARE_RECOGNITION
--
--   Rev 1.55.1.0   Oct 29 2016 23:08:02   susingh
--ProfitShare Change
--
--   Rev 1.55   Jun 03 2016 14:04:24   SourceSafe
--Integrated version 1.54.1.2 from project AT_RET_AGE_SEVENTY_FIVE
--
--   Rev 1.54.1.2   Mar 08 2016 09:29:18   SPatlolla
--Age 75 Health checks.
--
--   Rev 1.54.1.0   Mar 07 2016 10:41:18   SPatlolla
--Age 75 health checks.
--
--   Rev 1.54   Jan 15 2016 11:07:14   SourceSafe
--Integrated version 1.53.2.0 from project COMMISSION_SWITCH_OFF
--
--   Rev 1.53.2.0   Jan 12 2016 18:57:00   rhegganni
--Added healthchecks for Invalid Commission movements
--
--   Rev 1.53   Sep 16 2014 15:43:42   SourceSafe
--Integrated version 1.52.1.2 from project GPS_RS_LINKS
--
--   Rev 1.52.1.2   Sep 12 2014 12:38:30   rhegganni
--Fixed review comments
--
--   Rev 1.52.1.1   Sep 09 2014 21:59:00   rhegganni
--Added new procedure to validate linked GPS/RS policies
--
--   Rev 1.52   Jun 17 2014 15:04:08   SourceSafe
--Integrated version 1.51.1.0 from project RDR_CHANGE_DETAILS_PHASE_III
--
--   Rev 1.51.1.0   Apr 17 2014 08:42:56   KLWilson
--Remove checks 148, 153 and 155.
--
--   Rev 1.51   Apr 24 2013 11:03:48   SourceSafe
--Integrated version 1.50.1.0 from project RDR_HEALTHCHECKS
--
--   Rev 1.50.1.0   Apr 11 2013 10:05:28   KLWilson
--Add reporting period end date as an input paramter to p_ac_cc_policy_discr_check.
--
--   Rev 1.50   Apr 02 2013 14:52:10   SourceSafe
--Integrated version 1.49.1.0 from project GENDER_TM_I
--
--   Rev 1.49.1.0   Mar 26 2013 11:04:42   RSannanagari
--Back Out BOPS Changes
--
--   Rev 1.49   Oct 24 2012 14:50:00   SourceSafe
--Integrated version 1.48.1.5 from project RDR_HEALTHCHECKS
--
--   Rev 1.48.1.5   Sep 17 2012 15:39:40   KLWilson
--Add new discrepancy checks 147 and 148.
--
--   Rev 1.48.1.4   Sep 11 2012 08:16:54   KLWilson
--Changes to correct the doc tags after code review.
--
--   Rev 1.48.1.3   Sep 03 2012 14:52:34   KLWilson
--New suspended AC/CC UDCTL trigger checks added and new check on stakeholder policies added.
--
--   Rev 1.48.1.2   Aug 14 2012 10:37:50   KLWilson
--Removed healthcheck 159.
--
--   Rev 1.48.1.1   Apr 25 2012 11:05:48   KLWilson
--Added in checks 158, 159 and 160.
--
--   Rev 1.48.1.0   Apr 13 2012 14:18:02   KLWilson
--RDR changes - add new healthchecks 149 to 157.
--
--   Rev 1.48   Feb 07 2012 15:00:10   SourceSafe
--Integrated version 1.47.1.1 from project ANNUITY_ADJUSTMENT
--
--   Rev 1.47.1.1   Jan 24 2012 15:23:26   dcarter
--Change to BOP annuity procedure
--
--   Rev 1.47   Mar 03 2011 12:12:16   SourceSafe
--Integrated version 1.46.1.0 from project QOPR_FIVE
--
--   Rev 1.46.1.0   Feb 14 2011 13:45:48   dblowman
--Added health check 144 ITR FAF Discrepancy
--
--   Rev 1.46   Jul 23 2010 17:04:58   SourceSafe
--Integrated version 1.44.1.1 from project TV_INS
--
--   Rev 1.44.1.1   Jul 06 2010 17:20:18   betregidgo
--integrate 1.45 post imp
--
--   Rev 1.45   Jun 25 2010 16:24:46   SourceSafe
--Integrated version 1.44.2.0 from project THIRTY_FIVE_FUNDS_POST_IMP
--
--   Rev 1.44.2.0   Jun 23 2010 16:53:04   rhegganni
--Added procedure for healthcheck 141
--
--   Rev 1.44   Feb 04 2010 09:47:08   SourceSafe
--Integrated version 1.43.1.2 from project HEALTHCHECKS_II
--
--   Rev 1.43.1.2   Jan 28 2010 08:56:12   smacdonald
--p_incr_holding_inconsistency ¿ corrected procedure name in PLSQLDOC header.
--
--   Rev 1.43.1.1   Jan 26 2010 12:23:50   ETiglao
--Changes for new check 136 and 137
--
--   Rev 1.43.1.0   Jan 18 2010 16:07:32   smacdonald
--p_fund_holding_inconsistency broken up into p_fund_holding_inconsistency, p_incr_holding_inconsistency and p_bonus_holding_inconsistency
--
--   Rev 1.43   Jan 14 2010 10:33:46   SourceSafe
--Integrated version 1.42.1.0 from project HEALTHCHECKS
--
--   Rev 1.42.1.0   Jan 13 2010 15:02:32   dcarter
--Changed to accept parameter of end date rather than system date
--
--   Rev 1.42   Jan 06 2010 15:56:06   SourceSafe
--Integrated version 1.41.1.0 from project HEALTHCHECKS
--
--   Rev 1.41.1.0   Dec 22 2009 15:45:48   ETiglao
--Changes to add new check 133
--
--   Rev 1.41   Dec 10 2009 12:23:18   ETiglao
--Added new checks 130 to 131 (split from check 117)
--
--   Rev 1.38   Dec 09 2009 13:41:12   ETiglao
--Added the product reference as input to p_negative_fund_holdings_check
--
--   Rev 1.37   Nov 18 2009 13:51:26   dblowman
--Added p_faf_discrepancy check 129
--
--   Rev 1.36   Nov 10 2009 13:39:52   ETiglao
--Remove the 2 input information for check 761 as this no longer needed
--
--   Rev 1.35   Nov 09 2009 17:25:04   ETiglao
--Changes for new check 34 and remove input pn_end_date on check 782 since this is no longer needed
--
--   Rev 1.34   Oct 13 2009 11:44:14   ETiglao
--Additional change for check 110
--
--   Rev 1.32   Oct 09 2009 12:05:28   dcarter
--Added new check 110
--
--   Rev 1.31   Sep 23 2009 10:18:54   smacdonald
--Added p_switch_inconsistency.
--
--   Rev 1.30   Aug 06 2009 13:53:40   APaton
--New parameter added to 118
--
--   Rev 1.29   Aug 04 2009 09:10:22   APaton
--Added 118 - p_fund_holdings_inconsistency
--
--   Rev 1.28   Aug 03 2009 14:52:04   dcarter
--p_invalid_fund_movement 117 check added
--
--   Rev 1.27   Jul 28 2009 10:01:50   KLWilson
--Add p_tax_records_check, check 108.
--
--   Rev 1.26   Jul 21 2009 15:21:02   smacdonald
--added p_negative_fund_holdings_check and p_draft_fund_mvmnt_check
--
--   Rev 1.25   Jul 10 2009 10:15:22   dcarter
--Added new SSPIQ suspense check
--
--   Rev 1.24   Apr 17 2009 12:38:02   KLWilson
--Change to fund management charge check as end date no longer required as an input parameter.
--
--   Rev 1.23   Apr 03 2009 12:43:22   KLWilson
--New ITR check added.
--
--   Rev 1.22   Mar 26 2009 15:53:06   KLWilson
--Add a date as an IN parameter to new UDCTL check procedures to use in cursors instead of system date.
--
--   Rev 1.21   Mar 24 2009 09:18:54   KLWilson
--New transaction check procedures moved from pck_transaction_control to deal with some UDCTL triggers.
--
--   Rev 1.20   Mar 19 2009 16:10:58   KLWilson
--Detail new parameter in a tag in NI check procedure.
--
--   Rev 1.19   Mar 11 2009 10:43:54   KLWilson
--New UDCTL health checks added.
--
--   Rev 1.18   Mar 10 2009 15:01:38   acletford
--Add new parameter to NI check
--
--   Rev 1.17   Dec 15 2008 16:57:24   dgforrest
--Added new procedure to check settlements mail for a failed income payment
--
--   Rev 1.16   Nov 12 2008 15:39:18   APaton
--New parameter added to zero value check
--
--   Rev 1.15   Jul 02 2008 15:18:36   AMeldrum
--Put batch_errors procedure back in now that synonym is present
--
--   Rev 1.10   Jun 02 2008 14:10:02   APaton
--Removal of parameter from p_switch_check
--
--   Rev 1.9   Apr 30 2008 15:41:14   APaton
--Renewal date no longer needed as an input
--
--   Rev 1.8   Apr 21 2008 10:23:36   APaton
--Make procedures public to allow them to be called from different processes
--
--   Rev 1.7   Mar 14 2008 10:12:24   APaton
--Added product flag as parameter to allow easy differentiation between different product types, eg Talisman and NIPP
--
--   Rev 1.6   Feb 05 2008 15:27:54   cverri
--Minor change to add an end date into individual perform
--
--   Rev 1.5   Jan 31 2008 11:41:14   cverri
--Added polcrcdte as input to policy exceptions
--
--   Rev 1.4   Dec 10 2007 08:48:02   APaton
--Added new parameter to individual exceptions
--
--   Rev 1.3   Dec 05 2007 08:32:18   APaton
--Changed to pass in stapol and pup indicator
--
--   Rev 1.2   Nov 23 2007 14:29:40   APaton
--Changed parameters for p_perform_individual
--
--   Rev 1.1   Oct 19 2007 15:10:56   adougan
--Changes to allow policy exceptions to be run for individual contracts
--
--   Rev 1.0   Jan 19 2007 16:05:20   SourceSafe
--Created by PICCS Create Software
********************************************************************************************/

    -----------------------------------------------------------------------------------------
    -- procedure to process policy exceptions for a scheme
    -- %param pv_scheme_category       IN sc010.schcat%TYPE
    -- %param pn_scheme_ref            IN sc010.schref%TYPE
    -- %param pv_employer_category     IN cl300.clicat2%TYPE
    -- %param pn_employer_ref          IN cl300.cliref2%TYPE
    -- %param pn_previous_renewal_date IN pa021.rnwdte%TYPE
    -- %param pn_renewal_date          IN pa021.rnwdte%TYPE
    -- %param pn_default_policy        IN sc010.dflpolref%TYPE
    -- %param pv_servicing_department  IN VARCHAR2
    -- %param pr_audit_details         IN pck_audits.rec_audits
    -----------------------------------------------------------------------------------------
    PROCEDURE p_perform(pv_scheme_category       IN sc010.schcat%TYPE
                       ,pn_scheme_ref            IN sc010.schref%TYPE
                       ,pv_employer_category     IN cl300.clicat2%TYPE
                       ,pn_employer_ref          IN cl300.cliref2%TYPE
                       ,pn_previous_renewal_date IN pa021.rnwdte%TYPE
                       ,pn_renewal_date          IN pa021.rnwdte%TYPE
                       ,pn_default_policy        IN sc010.dflpolref%TYPE
                       ,pv_servicing_department  IN VARCHAR2
                       ,pr_audit_details         IN pck_audits.rec_audits);

    -----------------------------------------------------------------------------------------
    -- procedure to check that a policy has a live ITR - also need to check for scheme default
    -- %param pn_policy_number   IN  co040.polref%TYPE
    -- %param pn_record_status   IN  co040.staxrf%TYPE
    -- %param pn_ITR_number      OUT co040.cliref%TYPE
    -- %param pb_ITR_found       OUT boolean
    -- %param pv_product_type    IN  pr010.prdref%TYPE
    -----------------------------------------------------------------------------------------
    PROCEDURE p_CSNXR_ITR_check(pn_policy_number   IN  co040.polref%TYPE
                               ,pn_record_status   IN  co040.staxrf%TYPE
                               ,pn_ITR_number      OUT co040.cliref%TYPE
                               ,pb_ITR_found       OUT BOOLEAN
                               ,pv_product_type    IN  pr010.prdref%TYPE);

    -----------------------------------------------------------------------------------------
    -- procedure to check that a policy, scheme or employer has an address
    -- %param pv_client_address_category co040.adrclicat%TYPE
    -- %param pn_client_address_ref      co040.adrcliref%TYPE
    -- %param pn_address_ref             co040.adrref%TYPE
    -----------------------------------------------------------------------------------------
    PROCEDURE p_address_check(pv_client_address_category IN co040.adrclicat%TYPE
                             ,pn_client_address_ref      IN co040.adrcliref%TYPE
                             ,pn_address_ref             IN co040.adrref%TYPE    DEFAULT 1);

    -----------------------------------------------------------------------------------------
    -- procedure to check that there is an address for the policyholder
    -- %param pv_client_address_category IN co040.adrclicat%TYPE
    -- %param pn_client_address_ref      IN co040.adrcliref%TYPE
    -- %param pv_product_type            IN pr010.prdref%TYPE
    -- %param pn_address_ref             IN co040.adrref%TYPE
    -- %param pn_policy_number           IN po010.polref%TYPE
    -----------------------------------------------------------------------------------------
    PROCEDURE p_address_check(pv_client_address_category IN co040.adrclicat%TYPE
                             ,pn_client_address_ref      IN co040.adrcliref%TYPE
                             ,pv_product_type            IN pr010.prdref%TYPE
                             ,pn_address_ref             IN co040.adrref%TYPE
                             ,pn_policy_number           IN po010.polref%TYPE);

    -----------------------------------------------------------------------------------------
    -- procedure to check whether there is any outstanding new business for the policy
    -- %param pn_policy_number         IN co040.polref%TYPE
    -- %param pn_policy_status         IN po010.stapol%TYPE
    -- %param pv_status_description    IN cs060.itevaldes%TYPE
    -- %param pn_renewal_date          IN pa021.rnwdte%TYPE
    -- %param pv_product_type          IN pr010.prdref%TYPE
    -----------------------------------------------------------------------------------------
    PROCEDURE p_outstanding_new_bus_check(pn_policy_number         IN co040.polref%TYPE
                                         ,pn_policy_status         IN po010.stapol%TYPE
                                         ,pv_status_description    IN cs060.itevaldes%TYPE
                                         ,pn_renewal_date          IN pa021.rnwdte%TYPE
                                         ,pv_product_type          IN pr010.prdref%TYPE);

    -----------------------------------------------------------------------------------------
    -- procedure to check if there are any HMA's for the policy
    -- %param pn_policy_number IN co040.polref%TYPE
    -- %param pv_product_type  IN VARCHAR2
    -----------------------------------------------------------------------------------------
    PROCEDURE p_HMA_check(pn_policy_number IN co040.polref%TYPE
                         ,pv_product_type  IN VARCHAR2);

    -----------------------------------------------------------------------------------------
    -- procedure to check if there are any HMA's for the policy
    -- %param pn_policy_number    IN po010.polref%TYPE
    -- %param pv_client_category  IN co040.clicat%TYPE
    -- %param pn_client_reference IN co040.cliref%TYPE
    -- %param pv_product_type     IN VARCHAR2
    -----------------------------------------------------------------------------------------
    PROCEDURE p_HMA_client_check(pn_policy_number    IN po010.polref%TYPE
                                ,pv_client_category  IN co040.clicat%TYPE
                                ,pn_client_reference IN co040.cliref%TYPE
                                ,pv_product_type     IN VARCHAR2);
    -----------------------------------------------------------------------------------------
    -- procedure to check if there are any HMA's for the policy
    -- %param pn_policy_number    IN po010.polref%TYPE
    -- %param pv_client_category  IN co040.clicat%TYPE
    -- %param pn_client_reference IN co040.cliref%TYPE
    -- %param pv_memo_type        IN cl660.memtyp%TYPE
    -- %param pv_product_type     IN VARCHAR2
    -----------------------------------------------------------------------------------------
    PROCEDURE p_HMA_check(pn_policy_number     IN po010.polref%TYPE
                          ,pv_client_category  IN co040.clicat%TYPE
                          ,pn_client_reference IN co040.cliref%TYPE
                          ,pv_memo_type        IN cl660.memtyp%TYPE
                          ,pv_product_type     IN VARCHAR2);
    -----------------------------------------------------------------------------------------
    -- procedure to check whether there are any outstanding alterations or endorsements on a policy
    -- %param pn_policy_number         IN co040.polref%TYPE
    -- %param pn_end_date              IN pa021.rnwdte%TYPE
    -- %param pv_product_type          IN pr010.prdref%TYPE
    -----------------------------------------------------------------------------------------
    PROCEDURE p_all_outstanding_AE_check(pn_policy_number         IN co040.polref%TYPE
                                        ,pn_end_date              IN pa021.rnwdte%TYPE
                                        ,pv_product_type          IN pr010.prdref%TYPE);

    -----------------------------------------------------------------------------------------
    -- procedure to check whether live and pup'd cases have passed retirement age
    -- %param pn_policy_number IN co040.polref%TYPE
    -- %param pv_product_type  IN pr010.prdref%TYPE
    -----------------------------------------------------------------------------------------
    PROCEDURE p_retirement_age_check(pn_policy_number     IN co040.polref%TYPE
                                    ,pv_product_type      IN pr010.prdref%TYPE
                                    ,pv_create_LV_trigger IN VARCHAR2 DEFAULT 'N');

    -----------------------------------------------------------------------------------------
    -- procedure to check whether policyholder has a temporary national insurance number
    -- %param pn_policy_number         IN po010.polref%TYPE
    -- %param pv_national_insurance_no IN cl010.natinr_no%TYPE
    -- %param pv_product_type          IN pr010.prdref%TYPE
    -- %param pn_birth_date            IN cl010.bthdte%TYPE
    -----------------------------------------------------------------------------------------
    PROCEDURE p_temp_NI_check(pn_policy_number         IN po010.polref%TYPE
                             ,pv_national_insurance_no IN cl010.natinr_no%TYPE
                             ,pv_product_type          IN pr010.prdref%TYPE
                             ,pn_birth_date            IN cl010.bthdte%TYPE);

    -----------------------------------------------------------------------------------------
    -- procedure to check that all live CCINQ records relate to a live ITR for individual
    -- %param pn_policy_number         IN co040.polref%TYPE
    -- %param pn_renewal_date          IN pa022.rnwdte%TYPE
    -- %param pv_product_type          IN pr010.prdref%TYPE
    -- %param pb_FBRC_check_only       IN BOOLEAN
    -----------------------------------------------------------------------------------------
    PROCEDURE p_ind_CCINQ_ITR_check(pn_policy_number         IN co040.polref%TYPE
                                   ,pn_renewal_date          IN pa022.rnwdte%TYPE
                                   ,pv_product_type          IN pr010.prdref%TYPE
                                   ,pb_FBRC_check_only       IN BOOLEAN);

    -----------------------------------------------------------------------------------------
    -- procedure to check whether DSS contributions have been received in first 18 mths of policy
    -- %param pn_policy_number         IN co040.polref%TYPE
    -- %param pn_renewal_date          IN pa022.rnwdte%TYPE
    -- %param pv_product_type          IN pr010.prdref%TYPE
    -----------------------------------------------------------------------------------------
    PROCEDURE p_DSS_not_received_check(pn_policy_number         IN co040.polref%TYPE
                                      ,pn_renewal_date          IN pa022.rnwdte%TYPE
                                      ,pv_product_type          IN pr010.prdref%TYPE);

    -----------------------------------------------------------------------------------------
    -- procedure to check PYMPL for unallocated monies
    -- %param pn_policy_number         IN co040.polref%TYPE
    -- %param pv_scheme_category       IN sc010.schcat%TYPE
    -- %param pn_scheme_ref            IN sc010.schref%TYPE
    -- %param pv_employer_category     IN cl300.clicat2%TYPE
    -- %param pn_employer_ref          IN cl300.cliref2%TYPE
    -- %param pn_previous_renewal_date IN pa021.rnwdte%TYPE
    -- %param pn_renewal_date          IN pa021.rnwdte%TYPE
    -- %param pv_product_type          IN pr010.prdref%TYPE
    -----------------------------------------------------------------------------------------
    PROCEDURE p_unallocated_monies_check(pn_policy_number         IN co040.polref%TYPE
                                        ,pv_scheme_category       IN sc010.schcat%TYPE
                                        ,pn_scheme_ref            IN sc010.schref%TYPE
                                        ,pv_employer_category     IN cl300.clicat2%TYPE
                                        ,pn_employer_ref          IN cl300.cliref2%TYPE
                                        ,pn_previous_renewal_date IN pa021.rnwdte%TYPE
                                        ,pn_renewal_date          IN pa021.rnwdte%TYPE
                                        ,pv_product_type          IN pr010.prdref%TYPE);

    -----------------------------------------------------------------------------------------
    -- procedure to check PYMIN for unallocated monies at client level (with no policy on it)
    -- %param pn_policy_number         IN po010.polref%TYPE
    -- %param pv_client_category       IN co040.clicat%TYPE
    -- %param pn_client_ref            IN co040.cliref%TYPE
    -- %param pn_previous_renewal_date IN pa021.rnwdte%TYPE
    -- %param pn_renewal_date          IN pa021.rnwdte%TYPE
    -- %param pv_product_type          IN pr010.prdref%TYPE
    -----------------------------------------------------------------------------------------
    PROCEDURE p_client_unallocated_monies(pn_policy_number         IN po010.polref%TYPE
                                         ,pv_client_category       IN co040.clicat%TYPE
                                         ,pn_client_ref            IN co040.cliref%TYPE
                                         ,pn_previous_renewal_date IN pa021.rnwdte%TYPE
                                         ,pn_renewal_date          IN pa021.rnwdte%TYPE
                                         ,pv_product_type          IN pr010.prdref%TYPE);

    -----------------------------------------------------------------------------------------
    -- procedure to check DSSRC for any unallocated DSS monies for the policyholder
    -- %param pn_policy_number         IN co040.polref%TYPE
    -- %param pv_national_insurance_no IN cl010.natinr_no%TYPE
    -- %param pv_product_type          IN pr010.prdref%TYPE
    -----------------------------------------------------------------------------------------
    PROCEDURE p_unallocated_DSS_monies_check(pn_policy_number         IN co040.polref%TYPE
                                            ,pv_national_insurance_no IN cl010.natinr_no%TYPE
                                            ,pv_product_type          IN pr010.prdref%TYPE);

    -----------------------------------------------------------------------------------------
    -- procedure to check unallocated DSS, Journal entry and Non-payment debits as shown on DBTIQ
    -- %param pn_policy_number         IN po010.polref%TYPE
    -- %param pv_national_insurance_no IN cl010.natinr_no%TYPE
    -- %param pv_client_category       IN co040.clicat%TYPE
    -- %param pn_client_ref            IN co040.cliref%TYPE
    -- %param pn_previous_renewal_date IN pa021.rnwdte%TYPE
    -- %param pn_renewal_date          IN pa021.rnwdte%TYPE
    -- %param pv_product_type          IN pr010.prdref%TYPE
    -----------------------------------------------------------------------------------------
    PROCEDURE p_unallocated_debits(pn_policy_number         IN po010.polref%TYPE
                                  ,pv_national_insurance_no IN cl010.natinr_no%TYPE
                                  ,pv_client_category       IN co040.clicat%TYPE
                                  ,pn_client_ref            IN co040.cliref%TYPE
                                  ,pn_previous_renewal_date IN pa021.rnwdte%TYPE
                                  ,pn_renewal_date          IN pa021.rnwdte%TYPE
                                  ,pv_product_type          IN pr010.prdref%TYPE);

    -----------------------------------------------------------------------------------------
    -- procedure to check whether there are any ACTPL error activities for a policy
    -- %param pn_policy_number IN co040.polref%TYPE
    -- %param pv_product_type  IN pr010.prdref%TYPE
    -- %param pv_activity      IN po100.actref%type DEFAULT NULL
    -----------------------------------------------------------------------------------------
    PROCEDURE p_ACTPL_error_check(pn_policy_number IN co040.polref%TYPE
                                 ,pv_product_type  IN pr010.prdref%TYPE
                                 ,pv_activity      IN po100.actref%TYPE DEFAULT NULL);

    -----------------------------------------------------------------------------------------
    -- procedure to check the statuses and fund movements of switches
    -- %param pn_policy_number         IN co040.polref%TYPE
    -- %param pn_start_date            IN pa021.rnwdte%TYPE
    -- %param pn_end_date              IN pa021.rnwdte%TYPE
    -- %param pv_product_type          IN pr010.prdref%TYPE
    -----------------------------------------------------------------------------------------
    PROCEDURE p_switch_check(pn_policy_number         IN co040.polref%TYPE
                            ,pn_start_date            IN pa021.rnwdte%TYPE
                            ,pn_end_date              IN pa021.rnwdte%TYPE
                            ,pv_product_type          IN pr010.prdref%TYPE);

    -----------------------------------------------------------------------------------------
    -- procedure to check the statuses of automatic switches
    -- %param pn_policy_number         IN po010.polref%TYPE
    -- %param pv_product_type          IN pr010.prdref%TYPE
    -----------------------------------------------------------------------------------------
    PROCEDURE p_automatic_switch_check(pn_policy_number         IN po010.polref%TYPE
                                      ,pv_product_type          IN pr010.prdref%TYPE
                                      ,pn_end_date              IN pa021.rnwdte%TYPE);

    -----------------------------------------------------------------------------------------
    -- procedure to check the status of switches and redirections
    -- %param pn_policy_number         IN co040.polref%TYPE
    -- %param pn_previous_renewal_date IN pa021.rnwdte%TYPE
    -- %param pn_renewal_date          IN pa021.rnwdte%TYPE
    -- %param pv_transaction_type      IN pa020.fndtrntyp%TYPE
    -- %param pv_product_type          IN pr010.prdref%TYPE
    -----------------------------------------------------------------------------------------
    PROCEDURE p_UDCTL_check(pn_policy_number         IN co040.polref%TYPE
                           ,pn_previous_renewal_date IN pa021.rnwdte%TYPE
                           ,pn_renewal_date          IN pa021.rnwdte%TYPE
                           ,pv_transaction_type      IN pa020.fndtrntyp%TYPE
                           ,pv_product_type          IN pr010.prdref%TYPE);

    -----------------------------------------------------------------------------------------
    -- procedure to check the statuses of redirections
    -- %param pn_policy_number         IN co040.polref%TYPE
    -- %param pn_previous_renewal_date IN pa021.rnwdte%TYPE
    -- %param pn_renewal_date          IN pa021.rnwdte%TYPE
    -- %param pv_product_type          IN pr010.prdref%TYPE
    -----------------------------------------------------------------------------------------
    PROCEDURE p_redirection_check(pn_policy_number         IN co040.polref%TYPE
                                 ,pn_previous_renewal_date IN pa021.rnwdte%TYPE
                                 ,pn_renewal_date          IN pa021.rnwdte%TYPE
                                 ,pv_product_type          IN pr010.prdref%TYPE);

    -----------------------------------------------------------------------------------------
    -- procedure to check status of premiums paid for live, pup'd and pending exit policies
    -- %param pn_policy_number         IN co040.polref%TYPE
    -- %param pn_previous_renewal_date IN pa021.rnwdte%TYPE
    -- %param pn_renewal_date          IN pa021.rnwdte%TYPE
    -- %param pv_product_type          IN pr010.prdref%TYPE
    -----------------------------------------------------------------------------------------
    PROCEDURE p_premium_status_check(pn_policy_number         IN co040.polref%TYPE
                                    ,pn_previous_renewal_date IN pa021.rnwdte%TYPE
                                    ,pn_renewal_date          IN pa021.rnwdte%TYPE
                                    ,pv_product_type          IN pr010.prdref%TYPE);

    -----------------------------------------------------------------------------------------
    -- procedure to check statuses of fund movements
    -- %param pn_policy_number         IN co040.polref%TYPE
    -- %param pn_previous_renewal_date IN pa021.rnwdte%TYPE
    -- %param pn_renewal_date          IN pa021.rnwdte%TYPE
    -- %param pn_policy_status         IN po010.stapol%TYPE
    -- %param pn_policy_exit_mode      IN po010.extmod%TYPE
    -- %param pv_product_type          IN pr010.prdref%TYPE
    -- %param pv_product_flag          IN VARCHAR2
    -----------------------------------------------------------------------------------------
    PROCEDURE p_fund_movement_status_check(pn_policy_number         IN co040.polref%TYPE
                                          ,pn_previous_renewal_date IN pa021.rnwdte%TYPE
                                          ,pn_renewal_date          IN pa021.rnwdte%TYPE
                                          ,pn_policy_status         IN po010.stapol%TYPE
                                          ,pn_policy_exit_mode      IN po010.extmod%TYPE
                                          ,pv_product_type          IN pr010.prdref%TYPE
                                          ,pv_product_flag          IN VARCHAR2);

    -----------------------------------------------------------------------------------------
    -- procedure to check that statement numbers are valid
    -- %param pn_policy_number IN po010.polref%TYPE
    -- %param pv_product_type  IN pr010.prdref%TYPE
    -----------------------------------------------------------------------------------------
    PROCEDURE p_statement_number_check(pn_policy_number IN po010.polref%TYPE
                                      ,pv_product_type  IN pr010.prdref%TYPE);

    -----------------------------------------------------------------------------------------
    -- procedure to check that every fund movement has a premium
    -- %param pn_policy_number         IN po010.polref%TYPE
    -- %param pn_previous_renewal_date IN po100.actdte%TYPE
    -- %param pn_renewal_date          IN po100.actdte%TYPE
    -- %param pv_product_type          IN pr010.prdref%TYPE
    -----------------------------------------------------------------------------------------
    PROCEDURE p_fund_and_premium_check(pn_policy_number         IN po010.polref%TYPE
                                      ,pn_previous_renewal_date IN po100.actdte%TYPE
                                      ,pn_renewal_date          IN po100.actdte%TYPE
                                      ,pv_product_type          IN pr010.prdref%TYPE);

    -----------------------------------------------------------------------------------------
    -- procedure to check that premium events have a corresponding fund movment
    -- %param pn_policy_number         IN po010.polref%TYPE
    -- %param pn_previous_renewal_date IN pa022.rnwdte%TYPE
    -- %param pn_renewal_date          IN pa022.rnwdte%TYPE
    -- %param pv_product_type          IN pr010.prdref%TYPE
    -----------------------------------------------------------------------------------------
    PROCEDURE p_premium_event_check(pn_policy_number         IN po010.polref%TYPE
                                   ,pn_previous_renewal_date IN pa022.rnwdte%TYPE
                                   ,pn_renewal_date          IN pa022.rnwdte%TYPE
                                   ,pv_product_type          IN pr010.prdref%TYPE);

    -----------------------------------------------------------------------------------------
    -- procedure to check that statement balance is equal to current holdings
    -- %param pn_policy_number     IN po010.polref%TYPE
    -- %param pn_renewal_date      IN po100.actdte%TYPE
    -- %param pv_product_type      IN pr010.prdref%TYPE
    -- %param pn_statement_no      IN co055.untstm_no%TYPE
    -- %param pn_latest_start_date IN co055.strdte%TYPE
    -----------------------------------------------------------------------------------------
    PROCEDURE p_balance_and_holdings_check(pn_policy_number     IN po010.polref%TYPE
                                          ,pn_renewal_date      IN po100.actdte%TYPE
                                          ,pv_product_type      IN pr010.prdref%TYPE
                                          ,pn_statement_no      IN co055.untstm_no%TYPE
                                          ,pn_latest_start_date IN co055.strdte%TYPE);

    -----------------------------------------------------------------------------------------
    -- procedure to check that policy has a value for non DSS only cases
    -- %param pn_policy_number IN  po010.polref%TYPE
    -- %param pv_product_type  IN  pr010.prdref%TYPE
    -- %param pn_currency_date IN po010.polcrcdte%TYPE
    -- %param pb_nonzero_value OUT BOOLEAN
    -----------------------------------------------------------------------------------------
    PROCEDURE p_zero_policy_value_check(pn_policy_number IN  po010.polref%TYPE
                                       ,pv_product_type  IN  pr010.prdref%TYPE
                                       ,pn_currency_date IN  po010.polcrcdte%TYPE
                                       ,pb_nonzero_value OUT BOOLEAN);

    -----------------------------------------------------------------------------------------
    -- procedure to check that policy has a value for DSS only cases
    -- %param pn_policy_number IN  po010.polref%TYPE
    -- %param pv_product_type  IN  pr010.prdref%TYPE
    -- %param pn_currency_date IN po010.polcrcdte%TYPE
    -- %param pb_nonzero_value OUT BOOLEAN
    -----------------------------------------------------------------------------------------
    PROCEDURE p_zero_policy_value_check_DSS(pn_policy_number IN  po010.polref%TYPE
                                           ,pv_product_type  IN  pr010.prdref%TYPE
                                           ,pn_currency_date IN  po010.polcrcdte%TYPE
                                           ,pb_nonzero_value OUT BOOLEAN);

    -----------------------------------------------------------------------------------------
    -- procedure to check for negative values on FNDQT
    -- %param pn_policy_number IN po010.polref%TYPE
    -- %param pv_product_type  IN pr010.prdref%TYPE
    -----------------------------------------------------------------------------------------
    PROCEDURE p_negative_FNDQT_check(pn_policy_number IN po010.polref%TYPE
                                    ,pv_product_type  IN pr010.prdref%TYPE);

    -----------------------------------------------------------------------------------------
    -- procedure to check for a carried forward mismatch on WP funds
    -- %param pn_policy_number         IN po010.polref%TYPE
    -- %param pn_renewal_date          IN po100.actdte%TYPE
    -- %param pv_product_type          IN pr010.prdref%TYPE
    -- %param pn_statement_no          IN co055.untstm_no%TYPE
    -----------------------------------------------------------------------------------------
    PROCEDURE p_carried_fwrd_mismatch_check(pn_policy_number         IN po010.polref%TYPE
                                           ,pn_renewal_date          IN po100.actdte%TYPE
                                           ,pv_product_type          IN pr010.prdref%TYPE
                                           ,pn_statement_no          IN co055.untstm_no%TYPE);

    -----------------------------------------------------------------------------------------
    -- procedure to check that all ORD/AVCO have increments have the relevant investments.
    -- %param pn_policy_number IN co040.polref%TYPE
    -- %param pv_product_type  IN pr010.prdref%TYPE
    -----------------------------------------------------------------------------------------
    PROCEDURE p_ORD_investment_check(pn_policy_number  IN co040.polref%TYPE
                                    ,pv_product_type   IN pr010.prdref%TYPE);

    -----------------------------------------------------------------------------------------
    -- procedure to check that last premium wasn't more than 4 months ago
    -- %param pn_policy_number  IN po010.polref%TYPE
    -- %param pn_start_date     IN po100.actdte%TYPE
    -- %param pn_end_date       IN po100.actdte%TYPE
    -- %param pv_product_type   IN pr010.prdref%TYPE
    -----------------------------------------------------------------------------------------
    PROCEDURE p_last_premium_paid_check(pn_policy_number  IN po010.polref%TYPE
                                       ,pn_start_date     IN po100.actdte%TYPE
                                       ,pn_end_date       IN po100.actdte%TYPE
                                       ,pv_product_type   IN pr010.prdref%TYPE);

    -----------------------------------------------------------------------------------------
    -- procedure to check if there's any negative AMC fund movements
    -- %param pn_policy_number IN po010.polref%TYPE
    -- %param pn_start_date    IN po100.actdte%TYPE
    -- %param pn_end_date      IN po100.actdte%TYPE
    -- %param pv_product_type  IN pr010.prdref%TYPE
    -----------------------------------------------------------------------------------------
    PROCEDURE p_negative_AMC_check(pn_policy_number IN po010.polref%TYPE
                                  ,pn_start_date    IN po100.actdte%TYPE
                                  ,pn_end_date      IN po100.actdte%TYPE
                                  ,pv_product_type  IN pr010.prdref%TYPE);

    -----------------------------------------------------------------------------------------
    -- procedure to check if there's any investment in a with profit fund
    -- %param pn_policy_number IN po010.polref%TYPE
    -- %param pn_end_date      IN po100.actdte%TYPE
    -- %param pv_product_type  IN pr010.prdref%TYPE
    -----------------------------------------------------------------------------------------
    PROCEDURE p_with_profit_check(pn_policy_number IN po010.polref%TYPE
                                 ,pn_end_date      IN po100.actdte%TYPE
                                 ,pv_product_type  IN pr010.prdref%TYPE);

    -----------------------------------------------------------------------------------------
    -- procedure to check if the AMC is greater than 1%
    -- %param pn_policy_number IN po010.polref%TYPE
    -- %param pn_start_date    IN po100.actdte%TYPE
    -- %param pv_product_type  IN pr010.prdref%TYPE
    -----------------------------------------------------------------------------------------
    PROCEDURE p_fund_management_charge_check(pn_policy_number IN po010.polref%TYPE
                                            ,pn_start_date    IN po100.actdte%TYPE
                                            ,pv_product_type  IN pr010.prdref%TYPE);

    -----------------------------------------------------------------------------------------
    -- procedure to raise an exception for a pending exit policy
    -- %param pn_policy_number   IN po010.polref%TYPE
    -- %param pv_product_type    IN pr010.prdref%TYPE
    -----------------------------------------------------------------------------------------
    PROCEDURE p_raise_pending_exit(pn_policy_number   IN po010.polref%TYPE
                                  ,pv_product_type    IN pr010.prdref%TYPE);

    -----------------------------------------------------------------------------------------
    -- procedure to check that the FNDQT records are correct
    -- %param pn_policy_number         IN po010.polref%TYPE
    -- %param pn_renewal_date          IN pa021.rnwdte%TYPE
    -- %param pv_product_type          IN po010.prdref%TYPE
    -----------------------------------------------------------------------------------------
    PROCEDURE p_FNDQT_check(pn_policy_number         IN po010.polref%TYPE
                           ,pn_renewal_date          IN pa021.rnwdte%TYPE
                           ,pv_product_type          IN po010.prdref%TYPE);

    ---------------------------------------------------------------------------------
    -- Procedure to check settlement mail for rejected income payments on IR cases --
    ---------------------------------------------------------------------------------
    PROCEDURE p_settlement_IR_failed_payment (pn_policy_number  IN po010.polref%TYPE
                                             ,pv_product_type   IN pr010.prdref%TYPE);

    /*===========================================================================================
    Procedure p_oustanding_premiums_hc
    Checks the outstanding premiums health check, and reports on any errors found
    %param pn_policy_reference IN po010.polref
    ===========================================================================================*/
    PROCEDURE p_oustanding_premiums_hc (pn_policy_reference IN po010.polref%TYPE);

    /*===========================================================================================
    Procedure p_batch_errors
    Checks if there are any unresolved batch errors on the data_errors table
    %param pn_policy_reference IN po010.polref
    ===========================================================================================*/
    PROCEDURE p_batch_errors (pn_policy IN po010.polref%TYPE);

    /*===========================================================================================
    Procedure p_csn_trigger_check
    Checks if there are any CSN UDCTL triggers that are not status ACT
    %param pn_policy_reference IN co040.polref%TYPE
    %param pn_end_date         IN pa021.rnwdte%TYPE
    %param pv_product_type     IN pr010.prdref%TYPE
    ===========================================================================================*/
    PROCEDURE p_csn_trigger_check(pn_policy_number         IN co040.polref%TYPE
                                 ,pn_end_date              IN pa021.rnwdte%TYPE
                                 ,pv_product_type          IN pr010.prdref%TYPE);

    /*===========================================================================================
    Procedure p_db_trigger_check
    Checks if there are any CSN UDCTL triggers that are not status LIV with efvdte DDMM not 3112
    and efvdte YY not most recent with-profits bonus rune year + 1
    %param pn_policy_reference IN co040.polref%TYPE
    %param pv_product_type     IN pr010.prdref%TYPE
    ===========================================================================================*/
   PROCEDURE p_db_trigger_check(pn_policy_number IN co040.polref%TYPE
                               ,pv_product_type  IN pr010.prdref%TYPE);

   /*******************************************************************************************
    --  Checks if there are any UDCTL triggers that are not status LIV with efvdte > sys date
    --  or if there are non-status live triggers without a valid LIV trigger
    -- %param pn_policy_number     IN pa020.polref%TYPE
    -- %param pv_transaction_type  IN pa020.fndtrntyp%TYPE
    -- %param pn_status            IN pa020.sta_pa%TYPE
    -- %param pv_product_type      IN pr010.prdref%TYPE
    -- %param pn_trig_check_date   IN cs340.sysdte%TYPE
    ********************************************************************************************/
    PROCEDURE p_transaction_and_lv_check(pn_policy_number     IN pa020.polref%TYPE
                                        ,pv_transaction_type  IN pa020.fndtrntyp%TYPE
                                        ,pn_status            IN pa020.sta_pa%TYPE
                                        ,pv_product_type      IN pr010.prdref%TYPE
                                        ,pn_trig_check_date   IN cs340.sysdte%TYPE);

    /*******************************************************************************************
    -- Procedure to return trans efvdte, trnctl_no, status descr and boolean if record found<BR>
    -- %param pn_policy_number     IN pa020.polref%TYPE
    -- %param pv_transaction_type  IN pa020.fndtrntyp%TYPE
    -- %param pn_status            IN pa020.sta_pa%TYPE
    -- %param pn_trig_check_date   IN cs340.sysdte%TYPE
    ********************************************************************************************/

    PROCEDURE p_transaction_check  (pn_policy_number     IN pa020.polref%TYPE
                                   ,pv_transaction_type  IN pa020.fndtrntyp%TYPE
                                   ,pn_status            IN pa020.sta_pa%TYPE
                                   ,pv_product_type      IN pr010.prdref%TYPE
                                   ,pn_trig_check_date   IN cs340.sysdte%TYPE);
     /*===========================================================================================
    Procedure p_int_trigger_check
    Checks if there are any INT UDCTL triggers that are not status LIV with efvdte > sys date
    %param pn_policy_reference IN co040.polref%TYPE
    %param pv_product_type     IN pr010.prdref%TYPE
    %param pn_trig_check_date IN cs340.sysdte%TYPE
   ===========================================================================================*/
    PROCEDURE p_int_trigger_check(pn_policy_number   IN co040.polref%TYPE
                                 ,pv_product_type    IN pr010.prdref%TYPE
                                 ,pn_trig_check_date IN cs340.sysdte%TYPE);

    /*===========================================================================================
   Procedure p_ITR_check
   Checks if there are any ITR records where the stop new business indicator = Y or the SL
   authorisation code is set to 97
   -- %param pn_policy_reference IN po010.polref%TYPE
   -- %param pv_product_type     IN pr010.prdref%TYPE
   ============================================================================================*/

   PROCEDURE p_ITR_check (pn_policy_number IN po010.polref%TYPE
                         ,pv_product_type  IN pr010.prdref%TYPE);

    /*===========================================================================================
   Procedure p_sspiq_suspense
   Checks if there are any Suspense records for an individual policy on SSPIQ
   -- %param pn_policy_reference IN co040.polref%TYPE
   ============================================================================================*/

   PROCEDURE p_sspiq_suspense(pn_policy_number  IN co040.polref%TYPE);

    /*===========================================================================================
    Procedure p_draft_fund_mvmnt_check
    Checks for draft fund movements with an effective date within the reporting period and
    an audit date 65 working days before the report date
    -- %param pn_policy_in      IN po010.polref%TYPE
    -- %param pn_report_date_in IN fi700.audupddte%TYPE
    ============================================================================================*/
    PROCEDURE p_draft_fund_mvmnt_check(pn_policy_in      IN po010.polref%TYPE
                                      ,pn_report_date_in IN fi700.audupddte%TYPE);

    /*===========================================================================================
    Procedure p_negative_fund_holdings_check
    Checks CO051(type 'T' only), CO055 (Statement 999 only) and CO058 records for -ve valuations
    -- %param pn_polref_in    IN po010.polref%TYPE
    -- %param pv_product_type IN po010.prdref%TYPE)
    ============================================================================================*/
    PROCEDURE p_negative_fund_holdings_check (pn_polref_in    IN po010.polref%TYPE);

   /*===========================================================================================
    Procedure p_tax_records_check
    Checks for invalid tax relief records for EE payments
    -- %param pn_polref         IN po010.polref%TYPE
    -- %param pv_product_type   IN po010.prdref%TYPE
   ============================================================================================*/

    PROCEDURE p_tax_records_check(pn_polref      IN po010.polref%TYPE
                                 ,pv_product_ref IN po010.prdref%TYPE);

    /*===========================================================================================
    Procedure p_invalid_fund_movements
    Checks for PGIUP records with invalid effective date
    -- %param pn_policy_reference IN po010.polref%TYPE
    ============================================================================================*/

    PROCEDURE p_invalid_fund_movements(pn_policy_reference IN po010.polref%TYPE);

    /*===========================================================================================
    Procedure p_invalid_fund_movt_right_type
    Checks for PGIUP records with invalid rights type
    -- %param pn_policy_reference IN po010.polref%TYPE
    ============================================================================================*/

    PROCEDURE p_invalid_fund_movt_right_type(pn_policy_reference IN po010.polref%TYPE);

    /*===========================================================================================
    Procedure p_invalid_fund_movt_investment
    Checks for PGIUP records with invalid investment fund
    -- %param pn_policy_reference IN po010.polref%TYPE
    ============================================================================================*/

    PROCEDURE p_invalid_fund_movt_investment(pn_policy_reference IN po010.polref%TYPE);

    /*===========================================================================================
    Procedure p_invalid_fund_movt_increment
    Checks for PGIUP records with missing increment
    -- %param pn_policy_reference IN po010.polref%TYPE
    ============================================================================================*/

    PROCEDURE p_invalid_fund_movt_increment(pn_policy_reference IN po010.polref%TYPE);

    /*===========================================================================================
    Procedure p_invalid_fund_movt_othr_bnft
    Checks for PGIUP records with other benefit is greater than the benefit quantity 1
    -- %param pn_policy_reference IN po010.polref%TYPE
    ============================================================================================*/

    PROCEDURE p_invalid_fund_movt_othr_bnft(pn_policy_reference IN po010.polref%TYPE);

    /*===========================================================================================
    Procedure p_bonus_holding_inconsistency
    Checks for bonus holding inconsistencies in valuation and unit processing errors
    -- %param pn_policy_reference IN po010.polref%TYPE
    -- %param pv_product_type     IN po010.prdref%TYPE
    ============================================================================================*/
    PROCEDURE p_bonus_holding_inconsistency(pn_policy_reference IN po010.polref%TYPE
                                           ,pv_product_type     IN po010.prdref%TYPE);

    /*===========================================================================================
    Procedure p_fund_holding_inconsistency
    Checks for fund holding inconsistencies in valuation and unit processing errors
    -- %param pn_policy_reference IN po010.polref%TYPE
    -- %param pv_product_type     IN po010.prdref%TYPE
    ============================================================================================*/
    PROCEDURE p_fund_holding_inconsistency(pn_policy_reference IN po010.polref%TYPE
                                          ,pv_product_type     IN po010.prdref%TYPE);

/*===========================================================================================
    Procedure p_incr_holding_inconsistency
    Checks for increment holding inconsistencies in valuation and unit processing errors
    -- %param pn_policy_reference IN po010.polref%TYPE
    -- %param pv_product_type     IN po010.prdref%TYPE
    ============================================================================================*/
    PROCEDURE p_incr_holding_inconsistency(pn_policy_reference IN po010.polref%TYPE
                                          ,pv_product_type     IN po010.prdref%TYPE);

    /*===========================================================================================
    Procedure p_switch_inconsistency
    Checks for fund holding inconsistencies in valuation and unit processing errors
    -- %param pn_policy_in IN po010.polref%TYPE
    ===========================================================================================*/
    PROCEDURE p_switch_inconsistency(pn_policy_in IN po010.polref%TYPE);

    /*===========================================================================================
    Procedure p_pgiup_inconsistency
    Checks for inconsistencies with PGIUP and Employee benefits
    -- %param pn_policy_in IN po010.polref%TYPE
    ===========================================================================================*/
    PROCEDURE p_pgiup_inconsistency(pn_policy_in IN po010.polref%TYPE);

    /*******************************************************************************
    -- %Description p_faf_discrepancy - call FAF calculation check to check for FAF discrepancies
    -- %param   pn_polref      IN  po100.polref%TYPE
    *******************************************************************************/
    PROCEDURE p_faf_discrepancy(pn_polref   IN po100.polref%TYPE);

    /*******************************************************************************
    -- %Description p_faf_itr_discrepancy - call FAF calculation check to check for ITR discrepancies
    -- %param   pn_polref      IN  po100.polref%TYPE
    -- %param   pn_process_id  IN  health_check_processes.process_id%TYPE
    *******************************************************************************/
    PROCEDURE p_faf_itr_discrepancy(pn_polref     IN po100.polref%TYPE
                                   ,pn_process_id IN health_check_processes.process_id%TYPE);

    /*===========================================================================================
    Procedure p_no_actioned_fund_movt_check
    Checks if there are any actioned one-time UDCTL triggers but no actioned fund movement
    -- %param pn_policy_reference IN pa020.polref%TYPE
    -- %param pv_product_type     IN po010.prdref%TYPE
    -- If updating this cursor then update bulk level code
    ==========================================================================================*/
    PROCEDURE p_no_actioned_fund_movt_check (pn_policy_reference IN pa020.polref%TYPE
                                            ,pv_product_type     IN po010.prdref%TYPE);

    /*===========================================================================================
    Procedure p_no_actioned_UDCTL_triggers
    Checks if there are actioned fund movement but no actioned UDCTL one-time trigger
    -- %param pn_policy_reference IN fi700.polref%TYPE
    -- %param pv_product_type     IN po010.prdref%TYPE
    If updating this cursor then update the bulk level code
    ============================================================================================*/
    PROCEDURE p_no_actioned_UDCTL_triggers(pn_policy_reference IN fi700.polref%TYPE
                                          ,pv_product_type     IN po010.prdref%TYPE);

    /*******************************************************************************
    -- %Description check if ITR is authorised
    -- %param   pn_polref       IN po100.polref%TYPE
    -- %param   pv_product_type IN po100.prdref%TYPE
    -- %raises  NONE
    *******************************************************************************/
    PROCEDURE p_itr_authorised_check(pn_polref          IN po010.polref%TYPE
                                    ,pv_product_type    IN po010.prdref%TYPE);

    /*******************************************************************************
    -- %Description check consultant details
    -- %param   pn_polref       IN po100.polref%TYPE
    -- %param   pv_product_type IN po100.prdref%TYPE
    -- %raises  NONE
    *******************************************************************************/
    PROCEDURE p_consultant_check(pn_polref       IN po010.polref%TYPE
                                ,pv_product_type IN po010.prdref%TYPE);

    /*****************************************************************************
    -- Procedure p_max_fund_limit_check
    -- Check whether policy is invested in more than 35 funds
    -- %param pn_policy_number    IN po010.polref%TYPE
    -- %param pv_product_type     IN po010.prdref%TYPE
    ******************************************************************************/
    PROCEDURE p_max_fund_limit_check (pn_policy_number   IN po010.polref%TYPE
                                     ,pv_product_type    IN po010.prdref%TYPE);

    /*===========================================================================================
    Procedure p_ac_cc_policy_discr_check
    %Description Checks if there is a discrepancy between the expected charge amount
    and the amount paid on FI700s
    -- %param pn_policy_number    IN co040.polref%TYPE
    -- %param pv_product_type     IN pr010.prdref%TYPE
    -- %param pn_end_date         IN pa021.rnwdte%TYPE
    ===========================================================================================*/

    PROCEDURE p_ac_cc_policy_discr_check (pn_policy_number IN co040.polref%TYPE
                                         ,pv_product_type  IN pr010.prdref%TYPE
                                         ,pn_end_date      IN pa021.rnwdte%TYPE);

    /*===========================================================================================
    Procedure p_sus_ac_trigger_check
    %Description Checks if there are any Suspended AC UDCTL triggers
    %param pn_policy_number    IN co040.polref%TYPE
    %param pv_product_type     IN pr010.prdref%TYPE
    ===========================================================================================*/

    PROCEDURE p_sus_ac_trigger_check(pn_policy_number IN co040.polref%TYPE
                                    ,pv_product_type  IN pr010.prdref%TYPE);

    /*===========================================================================================
    Procedure p_sus_cc_trigger_check
    %Description Checks if there are any Suspended CC UDCTL triggers
    %param pn_policy_number    IN co040.polref%TYPE
    %param pv_product_type     IN pr010.prdref%TYPE
    ===========================================================================================*/

    PROCEDURE p_sus_cc_trigger_check(pn_policy_number IN co040.polref%TYPE
                                    ,pv_product_type  IN pr010.prdref%TYPE);

    /*===========================================================================================
    Procedure p_ac_trigger_check
    %Description Checks if there are any AC UDCTL triggers that are not status ACT
    %param pn_policy_number    IN co040.polref%TYPE
    %param pn_end_date         IN pa021.rnwdte%TYPE
    %param pv_product_type     IN pr010.prdref%TYPE
    ===========================================================================================*/

    PROCEDURE p_ac_trigger_check(pn_policy_number IN co040.polref%TYPE
                                ,pn_end_date      IN pa021.rnwdte%TYPE
                                ,pv_product_type  IN pr010.prdref%TYPE);

    /*===========================================================================================
    Procedure p_cc_trigger_check
    %Description Checks if there are any CC UDCTL triggers that are not status ACT
    %param pn_policy_number    IN co040.polref%TYPE
    %param pn_end_date         IN pa021.rnwdte%TYPE
    %param pv_product_type     IN pr010.prdref%TYPE
    ===========================================================================================*/

    PROCEDURE p_cc_trigger_check(pn_policy_number IN co040.polref%TYPE
                                ,pn_end_date      IN pa021.rnwdte%TYPE
                                ,pv_product_type  IN pr010.prdref%TYPE);

    /*===========================================================================================
    Procedure p_drf_crg_paid_premium
    %Description Checks if there is a DRF charge trigger record but the premium linked to it is paid
    %param pn_policy_reference IN co040.polref%TYPE
    %param pv_product_type     IN pr010.prdref%TYPE
    ===========================================================================================*/
    PROCEDURE p_drf_crg_paid_premium(pn_policy_number IN co040.polref%TYPE
                                    ,pv_product_type  IN pr010.prdref%TYPE);

    /*=============================================================================================
    Procedure p_valid_charge_increments_recs
    %Description Checks if the charge_increment_dates records follow on logically and tie into the linked PA020
    %param pn_policy_number IN co040.polref%TYPE
    %param pv_product_type  IN pr010.prdref%TYPE
    ==============================================================================================*/
    PROCEDURE p_valid_charge_increments_recs(pn_policy_number IN co040.polref%TYPE
                                            ,pv_product_type  IN pr010.prdref%TYPE);

    /*=============================================================================================
    Procedure p_incrm_charges_check
    %Description Check to ensure that all live increments have a AC/CC record
    %param pn_policy_number    IN co040.polref%TYPE
    %param pv_product_type     IN pr010.prdref%TYPE
    ==============================================================================================*/

    PROCEDURE p_incrm_charges_check (pn_policy_number IN co040.polref%TYPE
                                    ,pv_product_type  IN pr010.prdref%TYPE);

    /*=============================================================================================
    Procedure p_cm240_status_check
    Check to ensure that the CM240 records for new AC/CC charges are at status 10 or 20
    %param pn_policy_number    IN co040.polref%TYPE
    %param pv_product_type     IN pr010.prdref%TYPE
    ==============================================================================================*/

    PROCEDURE p_cm240_status_check (pn_policy_number IN co040.polref%TYPE
                                   ,pv_product_type  IN pr010.prdref%TYPE);

    /*=============================================================================================
    Procedure p_ini_charge_period_check
    %Description Check that the initial charge period is not more than 60 months
    %param pn_policy_number    IN co040.polref%TYPE
    %param pv_product_type     IN pr010.prdref%TYPE
    ==============================================================================================*/

    PROCEDURE p_ini_charge_period_check (pn_policy_number IN co040.polref%TYPE
                                        ,pv_product_type  IN pr010.prdref%TYPE);

    /*=============================================================================================
    Procedure p_stakeholder_charge_check
    %Description Check that no AC/CC charges have been keyed against Stakeholder policies
    %param pn_policy_number    IN co040.polref%TYPE
    %param pv_product_type     IN pr010.prdref%TYPE
    ==============================================================================================*/

    PROCEDURE p_stakeholder_charge_check (pn_policy_number IN co040.polref%TYPE
                                         ,pv_product_type  IN pr010.prdref%TYPE);

    /*=============================================================================================
    Procedure p_gps_rs_link_validations
    %Description   Procedure to validate linked GPS and RS policies
    %param   pn_policy_number   IN  po010.polref%TYPE
    %param   pv_product_type    IN  VARCHAR2
    ==============================================================================================*/
    PROCEDURE p_gps_rs_link_validations (pn_policy_number IN co040.polref%TYPE
                                        ,pv_product_type  IN VARCHAR2);

    /********************************************************************************************
    -- %Description   Procedure to check invalid commission payment
    -- %param         pn_policy_ref   IN cm240.polref%TYPE
    -- %param         pn_scheme_ref   IN commission_switch_off.scheme_reference%TYPE
    -- %param         pv_scheme_cat   IN commission_switch_off.scheme_category%TYPE
    -- %param         pv_product_type IN po010.prdref%TYPE
    *********************************************************************************************/
    PROCEDURE p_invalid_commission_check (pn_policy_ref   IN cm240.polref%TYPE
                                         ,pn_scheme_ref   IN commission_switch_off.scheme_reference%TYPE
                                         ,pv_scheme_cat   IN commission_switch_off.scheme_category%TYPE
                                         ,pv_product_type IN po010.prdref%TYPE);

    /********************************************************************************************
    -- %Description   Procedure to check if Regular contribution end date is greater than policy holder 75th birthday
    -- %param         pn_policy_reference  IN po010.polref%TYPE
    -- %param         pv_product_type      IN pr010.prdref%TYPE
    *********************************************************************************************/
    PROCEDURE p_age75_less_than_rc_end_date(pn_policy_reference  IN po010.polref%TYPE
                                           ,pv_product_type      IN pr010.prdref%TYPE);

    /********************************************************************************************
    -- %Description   Procedure to check if age 75 trigger failed to process
    -- %param         pn_policy_reference  IN po010.polref%TYPE
    -- %param         pv_product_type      IN pr010.prdref%TYPE
    *********************************************************************************************/
    PROCEDURE p_age75_trigger_fail(pn_policy_reference IN po010.polref%TYPE
                                  ,pv_product_type     IN pr010.prdref%TYPE);

    /********************************************************************************************
    -- %Description   Procedure to Checks if there is an outstanding PSA trigger in UDCTL
    -- %param         pn_policy_reference  IN pa020.polref%TYPE
    -- %param         pv_product_type      IN po010.prdref%TYPE
    -- %param         pn_renewal_date      IN pa021.rnwdte%TYPE
    *********************************************************************************************/
    PROCEDURE p_psa_UDCTL_check (pn_policy_reference IN pa020.polref%TYPE
                                ,pv_product_type     IN po010.prdref%TYPE
                                ,pn_renewal_date     IN pa021.rnwdte%TYPE);

    /********************************************************************************************
    -- %Description Procedure to check if policy has uplifted but still shows entitlement as
    --               other than 'T' and vice versa
    -- %param       pn_policy_number  IN  pa020.polref%TYPE
    -- %param       pv_product_type   IN  po010.prdref%TYPE
    -- %raises      Exception 908
    *********************************************************************************************/
    PROCEDURE p_GAR_UPL_mismatch(pn_policy_number  IN  pa020.polref%TYPE
                                ,pv_product_type   IN  po010.prdref%TYPE);

END pck_policy_exceptions;
/
CREATE OR REPLACE PACKAGE BODY PROJECT_DEV_07.pck_policy_exceptions AS
/*******************************************************************************************
* File Name        : pck_policy_exceptions
* Description      : Package to produce policy level exceptions for GPS renewals
* Author           : Angela Dougan
* Date             : 9 November 2006
* Version          : 0.1
* Modification History :
* Date              Version    Modified by    Brief Description of Modificationfsty
* -----------------------------------------------------------------------------------------
* $Log:   //vm1/PICCSDB/archives/life/database/bodies/pck_policy_exceptions.bdy-arc  $
--
--   Rev 1.272   Sep 24 2020 13:33:26   SourceSafe
--Integrated version 1.271.2.0 from project OST
--
--   Rev 1.271.2.0   Sep 18 2020 16:09:36   Kvishal
--Change 175727 : Remove the Outstanding Mail 713/714 Exception on TAL GPS Renewals
--
--   Rev 1.271   Jan 30 2020 15:21:34   SourceSafe
--Integrated version 1.270.2.0 from project OST
--
--   Rev 1.270.2.0   13 Jan 2020 15:21:02   dmcneil
--OST Call 167146 - change to HC781 to omit CPS
--
--   Rev 1.270   Mar 18 2019 15:35:20   SourceSafe
--Integrated version 1.269.1.3 from project DWP_DISC
--
--   Rev 1.269.1.3   18 Mar 2019 13:49:24   RRajagopla1
--minor changes.
--
--   Rev 1.269.1.2   18 Mar 2019 11:05:40   RRajagopla1
--minor change
--
--   Rev 1.269.1.1   18 Mar 2019 10:53:26   RRajagopla1
--adding comments with minor change
--
--   Rev 1.269.1.0   14 Mar 2019 10:36:16   RRajagopla1
--747 error shouldn't be display when the renewal start date is 43432.
--
--   Rev 1.269   Sep 12 2018 15:12:04   SourceSafe
--Integrated version 1.268.1.2 from project TALISKER_EXISTING_BUSINESS
--
--   Rev 1.268.1.2   30 Aug 2018 16:14:18   HKODE
--fix for 279930
--
--   Rev 1.268.1.1   Jul 30 2018 11:41:46   pdhanpal1
--Minor Change
--
--   Rev 1.268.1.0   Jul 13 2018 15:21:12   pdhanpal1
--Talisker Existing Business - Healthcheck Changes
--
--   Rev 1.268   Apr 11 2018 10:29:44   SourceSafe
--Integrated version 1.267.1.5 from project GST_RENEWALS_CYCLE_THREE
--
--   Rev 1.267.1.5   Apr 09 2018 20:26:44   psundar
--Minor code review changes
--
--   Rev 1.267.1.4   Apr 09 2018 15:28:14   psundar
--Minor code review changes
--
--   Rev 1.267.1.3   Apr 02 2018 13:25:30   psundar
--Minor code review changes
--
--   Rev 1.267.1.2   Mar 27 2018 13:18:18   susingh
--Change the parameter name
--
--   Rev 1.267.1.1   Mar 26 2018 16:50:38   psundar
--Updated the procedure p_retirement_age_check as part of GST Renewals project
--
--   Rev 1.267.1.0   Mar 05 2018 17:31:40   psundar
--Added Changes to p_HMA_check, p_retirement_age_check and p_perform procedures
--
--   Rev 1.267   May 19 2017 14:37:00   SourceSafe
--Integrated version 1.266.1.1 from project PROFITSHARE_CRS
--
--   Rev 1.266.1.1   Apr 07 2017 14:59:18   KAnala
--Minor Change
--
--   Rev 1.266   Mar 24 2017 16:03:34   SourceSafe
--Integrated version 1.265.1.0 from project PROFITSHARE_CRS
--
--   Rev 1.265.1.0   Mar 24 2017 17:11:20   PGurikar
--Minor Changes to handle NULL
--
--   Rev 1.265   Jan 12 2017 14:56:38   SourceSafe
--Integrated version 1.264.1.5 from project PROFITSHARE_RECOGNITION
--
--   Rev 1.264.1.5   Nov 16 2016 17:08:20   Nyadav
--Fixed review comments
--
--   Rev 1.264.1.4   Nov 10 2016 11:07:12   susingh
--Chnage made for PSA
--
--   Rev 1.264.1.3   Oct 29 2016 23:09:18   susingh
--ProfitShare Change - HealthCheck
--
--   Rev 1.264.1.2   Oct 14 2016 17:49:20   Nyadav
--Minor changes
--
--   Rev 1.264.1.1   Oct 13 2016 18:01:36   Nyadav
--Made changes to p_ACTPL_error_check for PSA errors
--
--   Rev 1.264.1.0   Oct 13 2016 10:42:40   Nyadav
--Added changes for yearly review hold-ups for PSA due
--
--   Rev 1.264   Jun 03 2016 14:03:22   SourceSafe
--Integrated version 1.259.1.5 from project AT_RET_AGE_SEVENTY_FIVE
--
--   Rev 1.259.1.5   May 04 2016 12:15:24   SPatlolla
--Integrated with 1.263 version.
--
--   Rev 1.259.1.4   Apr 12 2016 16:22:42   SPatlolla
--Integrating 1.261 version.
--
--   Rev 1.259.1.3   Apr 01 2016 14:19:28   SPatlolla
--Minor changes in error message wording.. defect 1040 fix.
--
--   Rev 1.259.1.2   Mar 08 2016 09:33:40   SPatlolla
--Reinstate Age 75 health checks 1.259.1.0
--
--   Rev 1.259.1.0   Mar 07 2016 10:42:34   SPatlolla
--Age 75 Health checks.
--
--   Rev 1.259   Feb 01 2016 11:36:26   SourceSafe
--Integrated version 1.258.1.1 from project COMMISSION_SWITCH_OFF
--
--   Rev 1.258.1.1   Jan 31 2016 16:21:52   rhegganni
--Include Manual debits and credits correctly and retrieve correct SP/TV date paid date for comparison
--
--   Rev 1.258   Jan 18 2016 11:51:28   SourceSafe
--Integrated version 1.257.1.0 from project COMMISSION_SWITCH_OFF
--
--   Rev 1.257.1.0   Jan 15 2016 16:55:18   rhegganni
--Include Manual Debits as well
--
--   Rev 1.257   Jan 15 2016 11:07:12   SourceSafe
--Integrated version 1.256.2.0 from project COMMISSION_SWITCH_OFF
--
--   Rev 1.256.2.0   Jan 12 2016 18:57:00   rhegganni
--Added healthchecks for Invalid Commission movements
--
--   Rev 1.256   Oct 05 2015 16:39:38   SourceSafe
--Integrated version 1.255.1.0 from project AT_RETIREMENT_DRIP
--
--   Rev 1.255.1.0   Sep 07 2015 09:59:04   dblowman
--Added details for Dripfeed check 167.
--
--   Rev 1.255   Jul 13 2015 08:57:00   SourceSafe
--Integrated version 1.253.1.1 from project AT_RETIREMENT
--
--   Rev 1.253.1.1   Jul 08 2015 12:33:48   KLWilson
--Merge with version 1.254
--
--   Rev 1.254   Jul 07 2015 15:55:46   SourceSafe
--Integrated version 1.253.2.1 from project DATA_INTEGRITY
--
--   Rev 1.253.2.1   Jun 17 2015 09:42:12   BIHamilton
--Removed the repeated line regarding matdte (it shouldn't be there and the comment on the previous version saying it was pupdte is a red herring).
--
--   Rev 1.253.1.0   Jun 09 2015 11:11:34   KLWilson
--Added a check for UFPLS ERR into p_actpl_error_check, this will be check number 901.
--
--   Rev 1.253   Jun 02 2015 17:00:10   SourceSafe
--Integrated version 1.252.1.0 from project DATA_INTEGRITY_II
--
--   Rev 1.252.1.0   Jun 02 2015 10:33:20   SSinha
--Code changes as part of Data Integrity Call 35A.
--
--   Rev 1.252   May 26 2015 16:38:42   SourceSafe
--Integrated version 1.251.1.2 from project DATA_INTEGRITY_II
--
--   Rev 1.251.1.2   May 20 2015 12:02:46   SSinha
--Changes made to fix performance issue as part of 35A call.
--
--   Rev 1.251.1.1   May 11 2015 12:22:44   SSinha
--Fixed review comment.
--
--   Rev 1.251.1.0   May 11 2015 05:28:22   SSinha
--Code changes as part of Data Integrity Call 35A.
--
--   Rev 1.251   Apr 22 2015 16:00:08   SourceSafe
--Integrated version 1.250.1.3 from project SUPPORT_PROJECT
--
--   Rev 1.250.1.3   Apr 16 2015 15:45:56   Mrangaswamy
--Integrated with Data Integrity code to Ship to UAT
--
--   Rev 1.250.1.2   Apr 01 2015 10:22:44   Mrangaswamy
--Removed the Data Integrity releated code for FIT Testing
--
--   Rev 1.250.1.1   Mar 18 2015 11:58:58   Mrangaswamy
--Code Fix to HC 777 to Ignore RB trigger stuck in the past if premium is not paid
--
--   Rev 1.250.1.0   Mar 18 2015 09:59:46   Mrangaswamy
--Code Changes for the support call 69186
--
--   Rev 1.250   Mar 05 2015 16:22:02   SourceSafe
--Integrated version 1.249.1.0 from project DATA_INTEGRITY
--
--   Rev 1.249.1.0   Feb 23 2015 11:31:30   nswarupa
--Made changes as part of Data Integrity Call 114/122
--
--   Rev 1.249   Nov 13 2014 15:22:58   SourceSafe
--Integrated version 1.248.1.0 from project DATA_INTEGRITY
--
--   Rev 1.248.1.0   Nov 13 2014 14:56:22   BIHamilton
--Fixed so we use the system date and not the oracle date
--(Not a problem on live but means we can't do backdating shenanigans on any test system)
--
--   Rev 1.248   Sep 16 2014 15:43:24   SourceSafe
--Integrated version 1.247.1.5 from project GPS_RS_LINKS
--
--   Rev 1.247.1.5   Sep 12 2014 12:38:30   rhegganni
--Fixed review comments
--
--   Rev 1.247.1.4   Sep 10 2014 13:26:38   rhegganni
--Pass correct prdsubgroup for GPS/RS validations
--
--   Rev 1.247.1.3   Sep 10 2014 12:41:46   rhegganni
--Changes to use error number 866 for GPS/RS Link errors
--
--   Rev 1.247.1.2   Sep 09 2014 21:59:16   rhegganni
--Added new procedure to validate linked GPS/RS policies
--
--   Rev 1.247   Jun 19 2014 11:21:58   SourceSafe
--Integrated version 1.244.2.16 from project RFC
--
--   Rev 1.244.2.16   Jun 19 2014 10:15:32   shuxley
--Integrated 1.244.2.15 with 1.246.
--
--   Rev 1.244.2.15   Jun 03 2014 16:43:58   shuxley
--Included a check for current live fund holding in cu_periodic_rebalancing.
--
--   Rev 1.244.2.14   May 23 2014 12:04:56   shuxley
--Refactored cu_periodic_rebalancing to include product type in filter and deal with blank rights types on po030.
--
--   Rev 1.244.2.13   May 19 2014 10:36:58   shuxley
--Joining pa020 records to po030 records via rhttyp in cu_periodic_rebalancing .
--
--   Rev 1.244.2.12   May 16 2014 10:48:44   shuxley
--Revert to 1.244.2.10.
--
--   Rev 1.244.2.11   May 16 2014 10:30:34   shuxley
--Changes to cu_periodic_rebalancing for failing scenario.
--
--   Rev 1.244.2.10   May 15 2014 15:53:36   shuxley
--Changes to cu_periodic_rebalancing for failing scenario also simplified the query.
--
--   Rev 1.244.2.9   May 13 2014 14:43:58   shuxley
--Added maint != 'D' condition on pa020 subqueries in cu_periodic_rebalancing.
--
--   Rev 1.244.2.8   May 13 2014 14:19:56   shuxley
--Changed efvdte condition on 4 subqueries in cu_periodic_rebalancing.
--
--   Rev 1.244.2.7   May 12 2014 15:22:46   shuxley
--1 further change to cu_periodic_rebalancing
--
--   Rev 1.244.2.6   May 12 2014 14:35:16   shuxley
--2 more changes to cu_periodic_rebalancing
--
--   Rev 1.244.2.5   May 12 2014 11:37:30   shuxley
--Refactored cu_periodic_rebalancing to fix bug.
--
--   Rev 1.244.2.4   May 06 2014 15:25:26   shuxley
--Changed cu_periodic_rebalancing to replace a duplicated status.
--
--   Rev 1.244.2.3   May 06 2014 11:14:40   shuxley
--Changed cu_periodic_rebalancing to include rights type. Added some comments.
--
--   Rev 1.244.2.2   Apr 29 2014 14:48:12   shuxley
--Fixes and comments in cu_periodic_rebalancing.
--
--   Rev 1.244.2.1   Apr 24 2014 09:33:30   shuxley
--Update subquery on cu_periodic_rebalancing.
--
--   Rev 1.244.2.0   Apr 22 2014 15:37:18   shuxley
--RFC396. Refactored cu_periodic_rebalancing and fixed a bug.
--
--   Rev 1.246   Jun 17 2014 15:03:32   SourceSafe
--Integrated version 1.244.1.4 from project RDR_CHANGE_DETAILS_PHASE_III
--
--   Rev 1.244.1.4   Jun 11 2014 16:04:48   KLWilson
--Change to how charge_inc_proportions table is used in check 147.
--
--   Rev 1.244.1.3   Jun 11 2014 14:41:48   KLWilson
--Further changes to check 147.  Also merged with version 1.245
--
--   Rev 1.245   May 22 2014 09:48:24   SourceSafe
--Integrated version 1.244.3.3 from project DATA_INTEGRITY
--
--   Rev 1.244.3.3   May 20 2014 15:08:16   BIHamilton
--Need to check on an EXISTS on cancelled fund movements to satisfy all the business conditions.
--
--   Rev 1.244.3.2   May 20 2014 10:02:14   SSinha
--Used Left join instead of join.
--
--   Rev 1.244.3.1   May 20 2014 06:33:54   SSinha
--Fixed code to handle cancelled premium event.
--
--   Rev 1.244.3.0   May 12 2014 11:15:38   SSinha
--Made changes as part of Data_Integrity call 17 to check condition on event table.
--
--   Rev 1.244.1.2   Apr 24 2014 15:09:48   KLWilson
--Changes to check 147 after peer review.
--
--   Rev 1.244.1.1   Apr 17 2014 08:49:52   KLWilson
--Further changes to check 147 to deal with policies that have multiple charge_increment_dates records.  Remove checks 148, 153 and 155.  Small change to 157 to no longer check on status of charge records.
--
--   Rev 1.244.1.0   Apr 04 2014 14:52:38   KLWilson
--RDR change details - changes to check 147 to replace read of PO350 with new table charge_inc_proportions.  Also small change to checks 151 and 152.
--
--   Rev 1.244   Dec 12 2013 10:55:02   SourceSafe
--Integrated version 1.243.1.0 from project SUPPORT_PROJECT
--
--   Rev 1.243.1.0   Nov 14 2013 11:17:44   acuthell
--Re-instate version 1.241 changes which were backed out in v1.243 to allow RDR Change Details changes to go ahead of support changes.
--
--   Rev 1.243   Nov 14 2013 10:45:20   SourceSafe
--Integrated version 1.242.1.0 from project RDR_CHANGE_DETAILS_PHASE_I
--
--   Rev 1.242.1.0   Nov 14 2013 09:47:42   acuthell
--Backed out version 1.241 changes - base version 1.240 with changes from v1.242.
--
--   Rev 1.242   Nov 11 2013 13:41:54   SourceSafe
--Integrated version 1.241.1.0 from project RDR_CHANGE_DETAILS_PHASE_I
--
--   Rev 1.241.1.0   Oct 04 2013 12:31:32   ABanswada
--RDR Change Details-changes implemented to exclude healthchecks for DUM charges similar to NIL charges
--
--   Rev 1.241   Sep 23 2013 16:17:16   SourceSafe
--Integrated version 1.240.1.0 from project SUPPORT_PROJECT
--
--   Rev 1.240.1.0   Aug 29 2013 17:45:14   HMBerrington
--Altered lpcu_premium_events because it wasn't reporting XDD paid premiums.
--
--   Rev 1.240   Apr 24 2013 11:03:44   SourceSafe
--Integrated version 1.239.1.5 from project RDR_HEALTHCHECKS
--
--   Rev 1.239.1.5   Apr 23 2013 15:22:38   KLWilson
--Back out previous changes to check 148 as not needed.
--
--   Rev 1.239.1.4   Apr 22 2013 14:03:36   KLWilson
--Updates to checks 151 and 152 to check on FND type charges as well as FIX.
--
--   Rev 1.239.1.3   Apr 17 2013 09:57:04   KLWilson
--Add DISTINCT back into check 148.
--
--   Rev 1.239.1.2   Apr 15 2013 10:11:52   KLWilson
--Exclude NIL charges from check 153.
--
--   Rev 1.239.1.1   Apr 15 2013 08:43:48   KLWilson
--Small correction to check 147.
--
--   Rev 1.239.1.0   Apr 11 2013 10:55:02   KLWilson
--Post imp changes to several checks.  Changed 151 and 152 to exclude cases where 1st premium is not allocated.  Exclude NIL charges from check 155.  Change partitioning of CM240 records in 148.  Changes to 147 to exclude cases where 1st premium is not allocated and also to use reporting period end date in calc of expected charges instead of system date.
--
--   Rev 1.239   Apr 02 2013 14:52:04   SourceSafe
--Integrated version 1.238.1.0 from project GENDER_TM_I
--
--   Rev 1.238.1.0   Mar 26 2013 11:01:46   RSannanagari
--Backed Out BOPS Changes
--
--   Rev 1.238   Feb 19 2013 13:16:30   SourceSafe
--Integrated version 1.237.1.0 from project RDR_HEALTHCHECKS
--
--   Rev 1.237.1.0   Feb 15 2013 14:27:16   KLWilson
--Check 711 updated to only report an error if an AQ090 exists for the policy.
--
--   Rev 1.237   Feb 15 2013 10:24:46   SourceSafe
--Integrated version 1.236.1.0 from project RDR_HEALTHCHECKS
--
--   Rev 1.236.1.0   Feb 15 2013 10:06:52   KLWilson
--Dummy change
--
--   Rev 1.236   Feb 12 2013 14:55:12   SourceSafe
--Integrated version 1.235.1.3 from project RDR_HEALTHCHECKS
--
--   Rev 1.235.1.3   Feb 11 2013 10:02:58   KLWilson
--Further small change to 147 to check on PA020.STRDTE in calc of paid RP fund movements.
--
--   Rev 1.235.1.2   Feb 11 2013 08:41:24   KLWilson
--Changes following code review to put some commands into uppercase.  System dates passed into the cursor as parameters.
--
--   Rev 1.235.1.1   Feb 07 2013 14:57:24   KLWilson
--Further change to check 147 to use PA020.STRDTE in calculations of expected amounts.
--
--   Rev 1.235.1.0   Feb 07 2013 10:54:52   KLWilson
--Change to check 147 to remove the check on system date in the FI700 RP read for ORD contribution charges.
--
--   Rev 1.235   Feb 04 2013 11:22:34   SourceSafe
--Integrated version 1.234.1.15 from project RDR_HEALTHCHECKS
--
--   Rev 1.234.1.15   Feb 04 2013 09:44:44   KLWilson
--Change to add to_number around CS060 value following peer review.
--
--   Rev 1.234.1.14   Feb 01 2013 12:00:36   KLWilson
--Changed to soft code the 99p tolerance.  This has been added into a CS060 record.
--
--   Rev 1.234.1.13   Jan 25 2013 12:02:48   KLWilson
--Changed to always check for a paid event for each charge. Add 99p tolerance check. Add AVCS into part of check for SPs and TVs.  Change way RVP charges total up events.
--
--   Rev 1.234.1.12   Jan 22 2013 10:49:52   KLWilson
--Small changes to 147 to exclude more bonus transactions.  Changes to 148 to report a different error for ADH charges and fix read of remun_references table.
--
--   Rev 1.234.1.11   Jan 17 2013 14:29:52   KLWilson
--Further changes to 151 and 152 after change in requirements.  Also check 147 updated to deduct a frequency in date comparisons and tidy up of code.
--
--   Rev 1.234.1.10   Jan 15 2013 14:11:50   KLWilson
--Exclude NIL charge type records from check 161.  Remove check on CO040.STAXRF in check 158.
--
--   Rev 1.234.1.9   Jan 14 2013 15:59:46   KLWilson
--Small change to check 156 to check on status on charge_increment_dates table.  Change also to 154 to exclude correct charge types.
--
--   Rev 1.234.1.8   Jan 11 2013 15:06:00   KLWilson
--Changes to checks 151 and 152 to report all regular premium triggers.
--
--   Rev 1.234.1.7   Jan 11 2013 13:58:34   KLWilson
--Correction to check 154 to ensure more than 1 increment is reported correctly.  Change to 156 to show description of UDCTL status.
--
--   Rev 1.234.1.6   Jan 11 2013 10:02:30   KLWilson
--Further small changes to check 148
--
--   Rev 1.234.1.5   Jan 11 2013 08:40:38   KLWilson
--Small change to check 148.  Also take out the SUS/*NO checks out of 151/152 and add audit date as an output to check 156.
--
--   Rev 1.234.1.4   Jan 10 2013 08:18:10   KLWilson
--Small correction to text of check 156
--
--   Rev 1.234.1.3   Jan 09 2013 16:04:42   KLWilson
--New version of check 148 added.  Check 156 altered to omit NIL charge types.
--
--   Rev 1.234.1.2   Jan 08 2013 12:08:36   KLWilson
--Change to check on system date when reporting suspended triggers.
--
--   Rev 1.234.1.1   Jan 07 2013 16:06:56   KLWilson
--Changes to check 156 to report triggers correctly that are not LIVE or DRAFT.  Also slight change to text wording.
--
--   Rev 1.234.1.0   Jan 07 2013 14:07:00   KLWilson
--Changes to healthcheck 160 to remove reads of PA020 records and simplify check for 60 months to prevent failures on web.
--
--   Rev 1.234   Nov 02 2012 15:45:30   SourceSafe
--Integrated version 1.233.1.0 from project RDR_HEALTHCHECKS
--
--   Rev 1.233.1.0   Oct 31 2012 11:30:42   KLWilson
--Update checks 136 and 137 to remove checks on ACI and CCI records. Also small updates to check 147 to correct errors.  Remove change to check 755 which was incorrect.
--
--   Rev 1.233   Oct 24 2012 14:49:52   SourceSafe
--Integrated version 1.231.1.17 from project RDR_HEALTHCHECKS
--
--   Rev 1.231.1.17   Oct 24 2012 10:55:04   KLWilson
--Small change to check 148 after first test.
--
--   Rev 1.231.1.16   Oct 18 2012 10:27:26   KLWilson
--Added some comments to explain previous changes in vrs 15
--
--   Rev 1.231.1.15   Oct 16 2012 08:18:36   KLWilson
--Changes to checks 148, 151, 152 and 154 following initial tester analysis
--
--   Rev 1.231.1.14   Oct 09 2012 10:01:52   KLWilson
--Check 900 changed to be ACCC ERR and check 901 removed.
--
--   Rev 1.231.1.13   Sep 24 2012 09:25:34   KLWilson
--Change checks 835 and 836 to 900 and 901.
--
--   Rev 1.231.1.12   Sep 17 2012 15:40:30   KLWilson
--Add new discrepancy checks 147 and 148.
--
--   Rev 1.231.1.11   Sep 06 2012 09:14:12   KLWilson
--Code merge.This now includes version 1.232
--
--   Rev 1.231.2.0   Jul 26 2012 10:46:12   MDonnelly
--Added new pricing error health check process to HC144 list.
--
--   Rev 1.231.1.10   Sep 03 2012 14:53:54   KLWilson
--New suspended AC/CC UDCTL trigger checks added and new check on stakeholder policies added.  Checks 151 and 152 amended to check on system date when looking at suspended triggers.  Check 156 simplified.
--
--   Rev 1.231.1.9   Aug 14 2012 10:42:10   KLWilson
--Remove healthcheck 159.  Change numbers of the 2 new ACTPL errors to be 835 and 836 to allow them to work in group renewals.  Changed check 755 to exclude RDR policies and make the date check in 155 the same as 755.  Changes to check 782 to exclude charge triggers set to ACT within a premium frequency period.
--
--   Rev 1.231.1.8   Jun 01 2012 09:10:38   KLWilson
--Change the use of ITR to Adviser in 2 of the new healthchecks.
--
--   Rev 1.231.1.7   May 30 2012 11:13:22   KLWilson
--Alterations to check 158 to add new csnrsncde and change error text.
--
--   Rev 1.231.1.6   May 16 2012 11:45:22   KLWilson
--Correction to check 156 after initial testing by TA.
--
--   Rev 1.231.1.5   May 11 2012 11:29:58   KLWilson
--Changes to checks 136 and 137 after initial testing by TA.  Also small correction to check 157.
--
--   Rev 1.231.1.4   Apr 25 2012 11:02:50   KLWilson
--Small change to check 157 to cope with RVP 0 and initial versions of checks 158, 159 and 160 added.
--
--   Rev 1.231.1.3   Apr 18 2012 11:02:08   KLWilson
--Changes to the way check 156 works after peer review.  Small change to check 157 to deal with SPs/TVs correctly.
--
--   Rev 1.231.1.2   Apr 16 2012 14:53:32   KLWilson
--Changes following initial peer review and also change to check 154 to use events rather than FI700s.
--
--   Rev 1.231.1.1   Apr 13 2012 14:12:26   KLWilson
--Initial versions of new healthchecks 149 to 157.
--
--   Rev 1.231.1.0   Apr 03 2012 15:06:28   KLWilson
--RDR Changes.  Updates made to checks 136, 137 and 782 to deal with new charge records.
--
--   Rev 1.231   Feb 15 2012 15:23:28   SourceSafe
--Integrated version 1.230.1.0 from project ANNUITY_ADJUSTMENT
--
--   Rev 1.230.1.0   Feb 15 2012 14:10:08   dcarter
--Added status check 52 for pending verification
--
--   Rev 1.230   Feb 07 2012 15:00:06   SourceSafe
--Integrated version 1.229.1.12 from project ANNUITY_ADJUSTMENT
--
--   Rev 1.229.1.12   Feb 07 2012 11:10:04   dcarter
--Changed after code review
--
--   Rev 1.229.1.11   Feb 06 2012 12:37:18   dcarter
--Take out brackets in comment
--
--   Rev 1.229.1.10   Feb 06 2012 11:03:54   dcarter
--Changed error message wording
--
--   Rev 1.229.1.9   Feb 03 2012 15:05:28   dcarter
--Changed again
--
--   Rev 1.229.1.8   Feb 03 2012 14:02:46   dcarter
--Changed cursor again as the aq100s had historical data on it
--
--   Rev 1.229.1.5   Feb 01 2012 15:45:46   dcarter
--Changed GARs again
--
--   Rev 1.229.1.4   Feb 01 2012 09:11:50   dcarter
--Added new check for Fund Value
--
--   Rev 1.229.1.3   Jan 30 2012 11:13:52   dcarter
--Change exception codes and message
--
--   Rev 1.229.1.2   Jan 25 2012 09:21:26   dcarter
--Joined to the right table this time.
--
--   Rev 1.229   Jul 12 2011 08:50:50   SourceSafe
--Integrated version 1.228.1.0 from project SUPPORT_PROJECT
--
--   Rev 1.228.1.0   Jun 23 2011 15:47:38   dblowman
--Check in correct version.
--
--   Rev 1.227.1.0   Jun 09 2011 15:32:58   dblowman
--Added join using polref to FI700 in lpcu_premium_events, without this the query picked up records from other policies resulting in passing healthcheck 734 incorrectly.
--
--   Rev 1.227   Mar 04 2011 13:19:54   SourceSafe
--Integrated version 1.226.1.0 from project QOPR_FIVE
--
--   Rev 1.226.1.0   Mar 03 2011 20:53:00   dblowman
--Merged Support Changes into QoPR changes. ITR Discrepancy now uses pck_activity.f_activity_exists
--following code review.
--
--   Rev 1.226   Mar 03 2011 12:12:10   SourceSafe
--Integrated version 1.224.1.3 from project QOPR_FIVE
--   Rev 1.225   Feb 28 2011 12:41:56   SourceSafe
--Integrated version 1.224.2.0 from project SUPPORT_PROJECT
--
-- NOTE : Versions 1.223.1.3 to 1.225 out of sync due to
--        issue with PICCS/VM , reintegrated for 1.227
--
--   Rev 1.224.1.3   Mar 01 2011 09:52:48   dblowman
--Defect 257 - Change to wording on ITR Discrepancy Write Off.
--
--   Rev 1.224.1.2   Feb 21 2011 15:36:26   dblowman
--ITR BAU Development - Added FAF ITR Healthcheck 144
--
--   Rev 1.224.1.1   Feb 15 2011 10:23:32   dblowman
--Changes following peer review
--
--   Rev 1.224.1.0   Feb 14 2011 13:49:42   dblowman
--Added health check 144 ITR FAF Discrepancy
--
--   Rev 1.224.2.0   Feb 25 2011 16:59:38   MDonnelly
--Have 118 ignore late vest cases and CO051s with a 99999 end date before current bonus year
--
--   Rev 1.224   Feb 11 2011 16:35:28   SourceSafe
--Integrated version 1.223.1.3 from project SUPPORT_PROJECT
--
--   Rev 1.223.1.3   Feb 10 2011 09:19:36   MDonnelly
--Minor code change after code review - use new view instead.
--
--   Rev 1.223.1.1   Feb 09 2011 15:18:52   MDonnelly
--Modified code to allow for the fact that there may be multiple GE001 records on the same date with different audit ID's
--
--   Rev 1.223.1.0   Feb 08 2011 09:47:16   MDonnelly
--Call 11377: make sure that a policy has gone through a bonus run before making it party to H/C 118
--
--   Rev 1.223   Dec 07 2010 11:51:52   SourceSafe
--Integrated version 1.222.1.1 from project QOPR_FOUR
--
--   Rev 1.222.1.1   Dec 02 2010 10:13:26   MDonnelly
--Defect fix where older FAF ERRORs were being hidden
--
--   Rev 1.222.1.0   Nov 15 2010 15:15:04   MDonnelly
--Changes to FAF healthcheck to output separate discrepancy figures
--
--   Rev 1.222   Aug 26 2010 22:32:06   SourceSafe
--Integrated version 1.221.1.0 from project ORACLE_UPGRADE
--
--   Rev 1.221.1.0   Aug 22 2010 23:14:28   LMcLurg
--Oracle 11g: Put back code from 1.218.1.0 that seems to have been missed in the merge between 1.221 and 1.220
--
--   Rev 1.221   Jul 29 2010 12:04:16   SourceSafe
--Integrated version 1.220.1.0 from project TV_INS
--
--   Rev 1.220.1.0   Jul 29 2010 11:47:28   betregidgo
--change select to obtain consultant based on scheme default policy links - this is for group
--
--   Rev 1.220   Jul 23 2010 17:03:50   SourceSafe
--Integrated version 1.217.1.2 from project TV_INS
--
--   Rev 1.217.1.2   Jul 23 2010 16:57:28   betregidgo
--integrate version 1.219
--
--   Rev 1.217.1.1   Jul 06 2010 17:17:24   betregidgo
--add 1.218 post_imp and alteration to itr select statement
--
--   Rev 1.218   Jun 25 2010 16:24:38   SourceSafe
--Integrated version 1.217.2.0 from project THIRTY_FIVE_FUNDS_POST_IMP
--
--   Rev 1.217.2.0   Jun 23 2010 16:52:48   rhegganni
--Added procedure for healthcheck 141
--
--   Rev 1.217   Apr 29 2010 11:44:16   SourceSafe
--Integrated version 1.216.1.2 from project HEALTHCHECKS
--
--   Rev 1.216.1.2   Apr 28 2010 15:39:20   dcarter
--Added union to check if it's 118 or 138 or both that are active
--
--   Rev 1.216.1.1   Apr 28 2010 12:56:46   dcarter
--Changed 118 for tolerance, 138 new exception code and GPS check. 135 for AVCR check
--
--   Rev 1.216.1.0   Apr 20 2010 09:47:58   dcarter
--Changed check 118 to use tolerance of 1
--
--   Rev 1.216   Mar 16 2010 15:34:02   SourceSafe
--Integrated version 1.215.1.1 from project HEALTHCHECKS
--
--   Rev 1.215.1.1   Mar 16 2010 14:43:24   dcarter
--Take check on ge001 out
--
--   Rev 1.215   Mar 11 2010 10:11:32   SourceSafe
--Integrated version 1.214.1.0 from project HEALTHCHECKS
--
--   Rev 1.214.1.0   Mar 11 2010 09:57:08   dcarter
--Changed to add quantity othbenqty when checking for TL98 products.
--
--   Rev 1.214   Mar 03 2010 11:36:56   SourceSafe
--Integrated version 1.213.1.0 from project HEALTHCHECKS
--
--   Rev 1.213.1.0   Mar 03 2010 10:27:54   KLWilson
--Small change to check 787 to look for specific policy.
--
--   Rev 1.213   Feb 26 2010 14:11:10   SourceSafe
--Integrated version 1.212.1.0 from project HEALTHCHECKS
--
--   Rev 1.212.1.0   Feb 24 2010 13:12:18   dcarter
--Changed 787 and 788 healthchecks.
--
--   Rev 1.212   Feb 10 2010 09:03:50   SourceSafe
--Integrated version 1.211.1.0 from project HEALTHCHECKS_II
--
--   Rev 1.211.1.0   Feb 09 2010 11:15:18   APaton
--Should be renewal date minus 1 being passed in to talqte
--
--   Rev 1.211   Feb 04 2010 09:47:02   SourceSafe
--Integrated version 1.210.1.7 from project HEALTHCHECKS_II
--
--   Rev 1.210.1.7   Jan 27 2010 15:37:40   ETiglao
--Changes to fix defect on check 137
--
--   Rev 1.210.1.6   Jan 27 2010 14:28:42   ETiglao
--Additional changes for check 137 per code review
--
--   Rev 1.210.1.5   Jan 26 2010 14:19:18   ETiglao
--Additional changes for check 136
--
--   Rev 1.210.1.4   Jan 26 2010 12:22:06   ETiglao
--Changes for new check 136 and 137
--
--   Rev 1.210.1.3   Jan 22 2010 09:31:46   ETiglao
--Changes for check 132 remove use of historical increment record as this is not needed
--
--   Rev 1.210.1.2   Jan 19 2010 11:09:34   ETiglao
--Changes for check 752 to remove the condition that 1st line of address is equal to 2nd line of address since this is not considered as an unknown address
--
--   Rev 1.210.1.1   Jan 19 2010 08:39:46   KLWilson
--Change to premium events cursor to check for RVP and AVCR increments too.
--
--   Rev 1.210.1.0   Jan 18 2010 16:01:26   smacdonald
--p_fund_holding_inconsistency broken up into p_fund_holding_inconsistency, p_incr_holding_inconsistency and p_bonus_holding_inconsistency.
--
--   Rev 1.210   Jan 14 2010 10:33:40   SourceSafe
--Integrated version 1.209.1.1 from project HEALTHCHECKS
--
--   Rev 1.209.1.1   Jan 13 2010 15:02:12   dcarter
--Changed to accept parameter of end date rather than system date
--
--   Rev 1.209.1.0   Jan 13 2010 09:09:32   ETiglao
--Changes for rule 4 check 752 due to code out of step with bulk level and additional changes to check 108
--
--   Rev 1.209   Jan 12 2010 09:56:36   SourceSafe
--Integrated version 1.208.1.0 from project HEALTHCHECKS
--
--   Rev 1.208.1.0   Jan 11 2010 21:11:50   ETiglao
--Changes for check 106 and 132
--
--   Rev 1.208   Jan 06 2010 15:55:52   SourceSafe
--Integrated version 1.207.1.3 from project HEALTHCHECKS
--
--   Rev 1.207.1.3   Jan 06 2010 13:28:40   ETiglao
--Make the check on benefit quantity 1 also as absolute value for check 133 as per BA advice
--
--   Rev 1.207.1.2   Jan 04 2010 12:00:02   ETiglao
--Additional changes for check 132
--
--   Rev 1.207.1.1   Dec 22 2009 17:10:32   ETiglao
--Added the information on benefit quantity 1 and other benefit quantity to the info provided to the user per BA advice
--
--   Rev 1.207.1.0   Dec 22 2009 15:42:10   ETiglao
--Changes for new check 133, additional other benefit quantity info for check 119 and fix for HF issue 2 and 15
--
--   Rev 1.207   Dec 15 2009 17:50:08   ETiglao
--Additional changes for check 108
--
--   Rev 1.206   Dec 15 2009 17:08:40   ETiglao
--Changes for check 108 HF issue 71
--
--   Rev 1.205   Dec 14 2009 18:00:30   ETiglao
--Additional changes for check 131 and 132
--
--   Rev 1.204   Dec 14 2009 10:41:46   ETiglao
--Remove checking on right type of spaces for check 130
--
--   Rev 1.203   Dec 11 2009 14:07:56   ETiglao
--Additional change to format the end date
--
--   Rev 1.202   Dec 11 2009 14:04:16   ETiglao
--Changes to format the end date if it is 99999 for check 761
--
--   Rev 1.201   Dec 11 2009 11:41:28   ETiglao
--Text information changes for check 761, 117, 130 to 131
--
--   Rev 1.200   Dec 10 2009 13:06:54   ETiglao
--Additional fix for check 710
--
--   Rev 1.199   Dec 10 2009 12:21:36   ETiglao
--Changes for check 117, addtl fix for check 119 & check 710 added end date for user info for check 761
--
--   Rev 1.198   Dec 09 2009 14:03:34   ETiglao
--Change the product reference input name for p_negative_fund_holdings_check
--
--   Rev 1.197   Dec 09 2009 13:32:38   ETiglao
--Changes for check 119 and check 761 HF issue 75
--
--   Rev 1.196   Dec 07 2009 21:39:02   ETiglao
--Changes to fix the error in batch control parameter
--
--   Rev 1.195   Dec 07 2009 15:22:30   ETiglao
--Additional changes for check 710
--
--   Rev 1.194   Dec 07 2009 14:29:14   ETiglao
--Changes for 710 HF issue 68
--
--   Rev 1.193   Dec 04 2009 13:57:44   ETiglao
--Changes for exception 761
--
--   Rev 1.192   Nov 27 2009 15:38:24   ETiglao
--Remove changes on 710 per BA's advice
--
--   Rev 1.191   Nov 27 2009 12:55:14   ETiglao
--Changes for check 710 HF issue 68 per code review
--
--   Rev 1.190   Nov 26 2009 14:01:00   dblowman
--Changes to error message for 129 reapplied to v1.187 - to ensure v1.188 changes not included in version to be shipped.
--
--   Rev 1.187   Nov 19 2009 17:24:54   dblowman
--Changes following code review
--
--   Rev 1.186   Nov 19 2009 16:01:12   dblowman
--SYSTEST - add translation of status into error message for 129
--
--   Rev 1.185   Nov 19 2009 10:11:42   dblowman
--bug fix for check 129
--
--   Rev 1.184   Nov 18 2009 17:38:18   dblowman
--Apply format mask on amount to error message for 129
--
--   Rev 1.183   Nov 18 2009 17:08:06   dblowman
--Changed wording of error message for 129
--
--   Rev 1.182   Nov 18 2009 16:48:38   dblowman
--Enhanced error message for check 129 to show increment details
--
--   Rev 1.181   Nov 18 2009 13:51:58   dblowman
--Added p_faf_discrepancy check 129
--
--   Rev 1.180   Nov 17 2009 14:45:28   ETiglao
--Additional fix for check 737
--
--   Rev 1.179   Nov 17 2009 12:19:34   ETiglao
--Changes the exception 34 to 40 as rule 34 is being used used at scheme level
--
--   Rev 1.178   Nov 16 2009 14:03:10   ETiglao
--Additional changes for exception 782 and 34
--
--   Rev 1.177   Nov 12 2009 17:05:44   ETiglao
--Changes for check 737 for HF issue 45
--
--   Rev 1.176   Nov 10 2009 13:35:56   ETiglao
--Remove the additional info for check 761 as this no longer needed
--
--   Rev 1.175   Nov 10 2009 12:48:44   ETiglao
--Put additional information on check 761
--
--   Rev 1.174   Nov 09 2009 17:29:56   ETiglao
--Changes on check 782 and 761 to fix defects.
--
--   Rev 1.173   Nov 09 2009 13:08:56   ETiglao
--Changes for check 757 for HF issue 50 and additional chhanges for 761
--
--   Rev 1.172   Nov 06 2009 16:31:46   ETiglao
--Additional changes for check 761 for HF issue 44 and 51
--
--   Rev 1.171   Nov 04 2009 11:13:40   APaton
--Correct retirement date calculation in 772
--
--   Rev 1.170   Nov 03 2009 11:45:04   APaton
--Fix to 788 to only report those errors shown on business errors screen and remove check on schema name as most checks are logged against errors schema not the life one
--
--   Rev 1.169   Nov 02 2009 16:34:52   ETiglao
--Changes for healthcheck feedback issue 43 (fix on check 734)
--
--   Rev 1.168   Oct 22 2009 15:35:18   KLWilson
--Change made in check 760 to check on PO200 maint field
--
--   Rev 1.167   Oct 22 2009 15:03:30   ETiglao
--Changes for exception 761 per healthcheck feedback
--
--   Rev 1.166   Oct 21 2009 11:50:46   ETiglao
--Remove the changes for exception 782 due to change in requirement
--
--   Rev 1.165   Oct 21 2009 09:38:26   ETiglao
--Added back the changes made for exception 782 in ver 1.161 which was removed in ver 1.163 as this not ready to go to PRE
--
--   Rev 1.164   Oct 21 2009 08:31:34   APaton
--Changes to transaction and lv checks
--
--   Rev 1.163   Oct 20 2009 11:09:50   ETiglao
--Code review changes
--
--   Rev 1.162   Oct 16 2009 11:28:34   ETiglao
--Replace the format of ln_retn_limit_late_vesting and ln_retn_limit_yearly_switch to number
--
--   Rev 1.161   Oct 15 2009 17:04:08   ETiglao
--Changes to use batch control parameter to set the years to retirement limit for exception 777. Also added changes for exception 782
--
--   Rev 1.160   Oct 13 2009 11:23:14   ETiglao
--Minor changes on the check 110 information per code review
--
--   Rev 1.158   Oct 12 2009 11:14:48   ETiglao
--Remove extra checking on 'SWA' fund transaction type on standard strategy check
--
--   Rev 1.157   Oct 09 2009 12:05:10   dcarter
--Added new check 110
--
--   Rev 1.156   Oct 08 2009 15:31:36   ETiglao
--Use the earliest retirement date (from PR and NPR) when getting exception 777 (check 11)
--
--   Rev 1.155   Oct 08 2009 14:22:28   ETiglao
--Slight modification on the text output of check 721
--
--   Rev 1.154   Oct 08 2009 12:28:06   ETiglao
--Add checks on failed redirection (exception 721 rule 16). Also correct derivation of rebalancing frequency for standard and new strategy
--
--   Rev 1.153   Oct 06 2009 11:23:28   ETiglao
--Changes to fix defect on fund range
--
--   Rev 1.152   Oct 06 2009 10:51:18   ETiglao
--Additional fix for fund range check (exception 777)
--
--   Rev 1.151   Oct 05 2009 16:20:08   ETiglao
--Minor fix for fund range check (exception 777)
--
--   Rev 1.150   Oct 05 2009 11:13:56   ETiglao
--Minor fix on managed fund check (exception 777)
--
--   Rev 1.149   Oct 05 2009 09:57:24   ETiglao
--Add revised checks on Fund Range (exception 777)
--
--   Rev 1.148   Oct 02 2009 14:18:00   ETiglao
--Removed the checks on Fund Range as no records extracted in clone
--
--   Rev 1.147   Oct 01 2009 15:42:44   ETiglao
--Add checks on Fund Range (exception 777)
--
--   Rev 1.146   Sep 30 2009 15:29:36   ETiglao
--Changes for check 11 (exception 777)
--
--   Rev 1.145   Sep 25 2009 14:07:36   smacdonald
--Removed a check for 'SWC' pa020 records from p_switch_inconsistency
--
--   Rev 1.144   Sep 24 2009 11:53:14   smacdonald
--Added some new calculations and a read on pa020 to retrieve the crgamt in the p_switch_inconsitency procedure.
--
--   Rev 1.143   Sep 23 2009 15:17:24   smacdonald
--Turns out the batch_control_parameters table can only be accessed via a package...
--
--   Rev 1.142   Sep 23 2009 14:45:06   smacdonald
--Changed p_switch_inconsitency to remove the need for new health_check_ref_data table and used batch_control_parameters instead.
--
--   Rev 1.141   Sep 23 2009 09:58:38   smacdonald
--Updated lpcu_premium_events to reflect changed requirements and added p_switch_inconsistency.
--
--   Rev 1.140   Sep 22 2009 11:30:46   KLWilson
--Correct output for check 801
--
--   Rev 1.139   Sep 08 2009 12:03:40   KLWilson
--Correction to check 787 to stop errors in adhoc healthchecks and change to output for check 772.
--
--   Rev 1.138   Sep 08 2009 09:25:44   SMcCarlie
--Added Increment Type and Ref. to message for exception 716
--
--   Rev 1.137   Sep 04 2009 11:12:50   ETiglao
--This is a copy of version 1.135 but remove changes on check 788
--
--   Rev 1.136   Sep 04 2009 09:10:38   ETiglao
--This is a copy of version 1.133
--
--   Rev 1.135   Sep 03 2009 20:41:40   ETiglao
--Additional changes for check 788
--
--   Rev 1.134   Sep 03 2009 17:43:42   ETiglao
--Changes for checks 734, 759 and 788 (defect 52)
--
--   Rev 1.133   Sep 01 2009 15:25:12   KLWilson
--Small correction to healthcheck 829
--
--   Rev 1.132   Sep 01 2009 13:35:10   dcarter
--Added elegibility indicator to error message for NI check procedure
--
--   Rev 1.131   Sep 01 2009 09:43:06   KLWilson
--Code review changes
--
--   Rev 1.130   Aug 27 2009 15:20:34   ETiglao
--Further remove of changes for check 721
--
--   Rev 1.129   Aug 27 2009 15:03:34   ETiglao
--Back out the changes on check 721 as this will affect GPS processing
--
--   Rev 1.128   Aug 25 2009 16:02:00   KLWilson
--Changes to check 737 resulting from peer review changes passed on from BAs.
--
--   Rev 1.127   Aug 20 2009 10:22:10   ETiglao
--Additional changes on check 721 rule 16
--
--   Rev 1.126   Aug 19 2009 15:04:54   ETiglao
--Peer review changes for check 721 rule 16
--
--   Rev 1.125   Aug 19 2009 09:01:40   KLWilson
--Peer review changes made to DB trigger check and CSNXR ITR check.
--
--   Rev 1.124   Aug 18 2009 16:19:00   SMcCarlie
--Added DOB to error message in p_retirement_age_check
--
--   Rev 1.123   Aug 10 2009 10:39:12   APaton
--Yet another fix to 118
--
--   Rev 1.122   Aug 07 2009 14:53:30   APaton
--Remove duplicates and match on cal_yr on co058's for check 118
--
--   Rev 1.121   Aug 07 2009 13:46:00   APaton
--Remove full outer join from 118 - appears to be a bug in Oracle
--
--   Rev 1.120   Aug 06 2009 13:52:04   APaton
--Fix to 118
--
--   Rev 1.119   Aug 05 2009 15:45:24   APaton
--Fix to 118
--
--   Rev 1.118   Aug 05 2009 09:10:50   KLWilson
--Small changes to a couple of checks to add a maint D check.
--
--   Rev 1.117   Aug 04 2009 12:52:42   ETiglao
--Addtional changes to 119 check
--
--   Rev 1.116   Aug 04 2009 09:57:52   ETiglao
--Put additional condition on healthcheck 41
--
--   Rev 1.115   Aug 04 2009 09:09:20   APaton
--Added 118 - p_fund_holdings_inconsistency
--
--   Rev 1.114   Aug 03 2009 14:52:18   dcarter
--p_invalid_fund_movement 117 check added
--
--   Rev 1.113   Aug 03 2009 10:51:12   ETiglao
--Changes to 119 and 116 checks
--
--   Rev 1.112   Jul 28 2009 10:03:10   KLWilson
--Add p_tax_records_check, check no 108.
--
--   Rev 1.111   Jul 27 2009 13:27:30   nswarupa
--Made changes to p_outstanding_AE_check as part of fixing pilot call - 4
--
--   Rev 1.110   Jul 22 2009 10:03:56   APaton
--Change to 777 - Defect 31
--
--   Rev 1.109   Jul 21 2009 15:21:36   smacdonald
--added p_negative_fund_holdings_check and p_draft_fund_mvmnt_check
--
--   Rev 1.108   Jul 10 2009 10:15:40   dcarter
--Added new SSPIQ suspense check
--
--   Rev 1.107   May 01 2009 11:29:00   KLWilson
--Change made to TA/WVR check after clone run test.
--
--   Rev 1.106   Apr 20 2009 09:03:48   KLWilson
--Change made to CSN check to look for *NO transactions now.
--
--   Rev 1.105   Apr 17 2009 12:32:14   KLWilson
--Changes made to fund management charge check and DB check.
--
--   Rev 1.104   Apr 16 2009 14:59:00   KLWilson
--Remove code for OGF and FAF ACTPL errors, as no longer required.  Also change made to new business check to report web cases as well.
--
--   Rev 1.103   Apr 15 2009 10:56:56   KLWilson
--Further small change to p_ord_investment_check
--
--   Rev 1.102   Apr 15 2009 09:11:16   KLWilson
--Further changes to p_ord_investment_check and p_itr_check to fix defects.
--
--   Rev 1.101   Apr 08 2009 12:38:26   KLWilson
--Small changes made to ITR check, fund id added as output in 5 healthchecks and changes made to p_ord_investment_check after requirements changed again.
--
--   Rev 1.100   Apr 07 2009 14:08:46   KLWilson
--Further change to p_ord_investment_check after code review.
--
--   Rev 1.99   Apr 07 2009 11:39:30   KLWilson
--Further corrections for defects.
--
--   Rev 1.98   Apr 07 2009 09:33:48   KLWilson
--Change made in p_ord_investment_check and in ACTPL read to fix defects.
--
--   Rev 1.97   Apr 03 2009 12:47:04   KLWilson
--New ITR check added and changes made to new business healthcheck and negative FNDQT check after requirements changed.

--   Rev 1.96   Mar 31 2009 11:52:02   KLWilson
--Change made to p_fund_movement_status_check to no longer report status DRF fund movements and output more fields in error message.
--
--   Rev 1.95   Mar 30 2009 11:40:36   KLWilson
--Changes made to CSN and DB healthchecks after requirement changes.
--
--   Rev 1.94   Mar 26 2009 15:54:06   KLWilson
--Add a date as an IN parameter to new UDCTL check procedures to use in cursors instead of system date.
--
--   Rev 1.93   Mar 26 2009 09:53:30   KLWilson
--Amendments made to existing healthchecks - nos 760, 761, 757, 752 and 712.
--
--   Rev 1.92   Mar 24 2009 10:43:58   KLWilson
--Put AMC check back to how it was.
--
--   Rev 1.91   Mar 24 2009 09:20:10   KLWilson
--New transaction check procedures moved from pck_transaction_control to deal with some UDCTL triggers instead of having individual procedures.  The way AMC triggers dealt with also changed.
--
--   Rev 1.90   Mar 19 2009 16:14:54   KLWilson
--Changes following code review, problems caused by VM.
--
--   Rev 1.89   Mar 13 2009 12:34:26   acletford
--Changes to healthcheck for temp NI number
--
--   Rev 1.88   Mar 11 2009 09:17:40   KLWilson
--New UDCTL health checks added.
--
--   Rev 1.87   Mar 10 2009 16:02:28   acletford
--Add in new parameter to NI check
--
--   Rev 1.86   Mar 10 2009 14:16:48   acletford
--Improve health checks for Strategies & Rebalancing
--
--   Rev 1.85   Dec 15 2008 17:02:04   dgforrest
--Added new procedure to check settlements mail for a failed income payment
--
--   Rev 1.84   Nov 12 2008 15:36:48   APaton
--Changes to 737, 720, 778 and 782
--
--   Rev 1.83   Sep 11 2008 11:55:24   APaton
--Minor fix to p_statement_number_check
--
--   Rev 1.82   Aug 25 2008 10:55:24   APaton
--Fix to p_premium_check
--
--   Rev 1.81   Aug 21 2008 11:55:04   APaton
--Minor changes to fix GPS
--
--   Rev 1.80   Jul 28 2008 11:29:14   APaton
--Tidying up cursor usage to try and prevent 'invalid cursor' error
--
--   Rev 1.79   Jul 21 2008 11:24:34   APaton
--Balance holdings check should be done for policies on their 1st renewal
--
--   Rev 1.78   Jul 21 2008 09:53:42   AMeldrum
--Put p_fund_and_premium check back to how it was
--
--   Rev 1.74   Jul 14 2008 11:39:36   AMeldrum
--Changes after code review
--
--   Rev 1.73   Jul 07 2008 11:53:14   AMeldrum
--As p_statement_number_check uses it's own start date for the fund movements, add a check when bulk fetching the fund movements on start date, to ensure we get the right dates
--
--   Rev 1.72   Jul 04 2008 15:42:24   AMeldrum
--Remove calls to check digit logic
--
--   Rev 1.70   Jul 02 2008 15:19:08   AMeldrum
--Put batch errors back
--
--   Rev 1.60   May 19 2008 16:07:26   APaton
--Minor change to unallocated debits check
--
--   Rev 1.59   May 13 2008 10:35:24   APaton
--Need actual premiums to be passed into p_premium_check
--
--   Rev 1.58   Apr 30 2008 15:40:12   APaton
--AMC check should be for after system date not renewal date
--
--   Rev 1.57   Apr 21 2008 10:20:28   APaton
--Changes to allow policy exceptions to be run in NIPP review process
--
--   Rev 1.56   Mar 19 2008 09:02:42   APaton
--More changes for Talisman and change to use end date passed in rather than gn.gn_sysdte
--
--   Rev 1.55   Mar 14 2008 10:08:04   APaton
--Changes for Talisman products
--
--   Rev 1.54   Feb 27 2008 14:19:22   rmill
--Heat Call 610494.  Changed calc of total ctbs.
--
--   Rev 1.53   Feb 20 2008 09:31:16   cverri
--Change for individual inquiry only to 'carried forward mismatch' check to use true system date
--
--   Rev 1.52   Feb 08 2008 15:01:48   cverri
--Change to remove individual FAF check, and tweak to RP investment check for NIPP
--
--   Rev 1.51   Feb 08 2008 09:47:18   cverri
--Add check for NIPP for unallocated debits
--
--   Rev 1.50   Feb 05 2008 15:27:04   cverri
--Changes for enquiry exceptions tweaks during UAT
--
--   Rev 1.49   Jan 31 2008 11:39:40   cverri
--Minor changes to status check in -ive amc, remove strategies from autoswitch check and pass crcdte into zero policy value
--
--   Rev 1.48   Jan 21 2008 13:38:18   cverri
--Changes to balance_and_holdings check and carried_fwrd_mismatch to include reversed fund movements
--
--   Rev 1.47   Jan 11 2008 08:20:58   APaton
--More new exceptions added
--
--   Rev 1.46   Dec 27 2007 11:19:58   APaton
--Need to allow process to continue even if TALQTE fails
--
--   Rev 1.45   Dec 24 2007 10:42:44   APaton
--More new exceptions added
--
--   Rev 1.44   Dec 18 2007 13:33:48   APaton
--Temporarily comment out call to function which isn't in UAT yet
--
--   Rev 1.43   Dec 14 2007 15:22:22   APaton
--Minor fixes and new exceptions added for individual
--
--   Rev 1.42   Dec 10 2007 08:46:10   APaton
--Changes to switch check and new exception added
--
--   Rev 1.41   Dec 05 2007 08:28:28   APaton
--Added more exceptions for individual and fixed CCINQ ITR check for individual
--
--   Rev 1.40   Nov 28 2007 14:37:26   APaton
--Added p_automatic check and amended output for ACTPL check
--
--   Rev 1.39   Nov 23 2007 14:26:18   APaton
--Added new exceptions
--
--   Rev 1.38   Nov 09 2007 10:28:10   cverri
--Minor change to outstanding NB check, and to change unallocated to unmatched for unallocated money check
--
--   Rev 1.37   Nov 01 2007 14:44:52   cverri
--Minor change after code review comment
--
--   Rev 1.36   Oct 31 2007 15:37:10   cverri
--Changes for individual to unallocated money checks
--
--   Rev 1.35   Oct 19 2007 15:10:04   adougan
--Changes to allow policy exceptions to be run for individual contracts
--
--   Rev 1.34   Aug 24 2007 09:59:12   adougan
--Ignore any premium group exceptions for increments on renewal
--
--   Rev 1.33   Aug 15 2007 10:47:50   adougan
--Need to check whether there is an increment on renewal for premium group check
--
--   Rev 1.32   Jun 11 2007 15:18:16   adougan
--Ignore any increments on or after renewal date
--
--   Rev 1.31   May 24 2007 11:01:20   adougan
--Change to premium event check
--
--   Rev 1.30   May 21 2007 14:00:16   adougan
--Add new premium event check
--
--   Rev 1.29   May 09 2007 09:26:26   adougan
--Fix to negative FNDQT check
--
--   Rev 1.28   May 02 2007 16:05:14   adougan
--Minor change to negative FNDQT check
--
--   Rev 1.27   May 01 2007 11:55:34   adougan
--Added new negative FNDQT check
--
--   Rev 1.26   Apr 27 2007 11:24:46   adougan
--premium group check should ignore increment reference.  Also removed variables that are
--no longer needed
--
--   Rev 1.25   Apr 20 2007 14:30:38   adougan
--Refinements to some of the exceptions
--
--   Rev 1.24   Apr 10 2007 15:16:36   adougan
--Fixes to some minor defects
--
--   Rev 1.23   Mar 07 2007 09:08:08   adougan
--Change to premium group check
--
--   Rev 1.22   Mar 05 2007 15:06:32   adougan
--Remove fixed and salary related premium checks
--
--   Rev 1.21   Mar 02 2007 11:59:50   adougan
--Moved call to p_redirection_check for live cases only
--
--   Rev 1.20   Mar 01 2007 11:49:28   adougan
--Some minor changes to exceptions
--
--   Rev 1.19   Feb 23 2007 08:58:58   adougan
--Minor change to redirection check
--
--   Rev 1.18   Feb 22 2007 11:19:26   adougan
--Change to CCINQ consistency check
--
--   Rev 1.17   Feb 21 2007 09:04:48   adougan
--Fix to ALC ERR
--
--   Rev 1.16   Feb 19 2007 13:47:44   adougan
--Minor change to UDCTL check
--
--   Rev 1.15   Feb 15 2007 15:33:36   adougan
--Fixes to new business check and redirection check
--
--   Rev 1.14   Feb 15 2007 13:18:04   adougan
--Need to determine status description in p_switch_check
--
--   Rev 1.13   Feb 14 2007 15:34:52   adougan
--Call scheme unallocated monies check for client reference and ignore zero dates on nb005
--
--   Rev 1.12   Feb 13 2007 15:38:54   adougan
--Ignore waiver premiums from checks
--
--   Rev 1.11   Feb 08 2007 15:27:16   adougan
--Added hint to cursor cu_ITR_details
--
--   Rev 1.10   Feb 08 2007 14:57:50   adougan
--Code review changes and minor bug fix
--
--   Rev 1.9   Feb 08 2007 09:44:12   adougan
--Fixes to bugs
--
--   Rev 1.8   Feb 07 2007 11:06:06   adougan
--Changes to p_premium_group_check and p_SCYRQ_check
--
--   Rev 1.7   Feb 05 2007 16:19:36   adougan
--Change to p_statement_number_check
--
--   Rev 1.6   Feb 02 2007 09:37:46   adougan
--Added fix to p_premium_group_check
--
--   Rev 1.5   Jan 31 2007 13:16:54   adougan
--Add temporary exception to stop package falling over
--
--   Rev 1.4   Jan 30 2007 15:40:22   adougan
--Fixes to exceptions
--
--   Rev 1.3   Jan 26 2007 10:53:14   adougan
--Use gn_sysdte instead of SYSDATE to be consistent with clear up and post renewal reports
--
--   Rev 1.2   Jan 22 2007 13:23:36   adougan
--Remove dependency on businesserrors.errordata
--
--   Rev 1.1   Jan 22 2007 10:36:20   adougan
--Change to p_switch_check to also check switches waiting printing
--
--   Rev 1.0   Jan 22 2007 08:46:12   SourceSafe
--Created by PICCS Create Software
********************************************************************************************/

    LPCN_DSS_OPR_REF     CONSTANT NUMBER(5) := 80578;
    LPCN_NEW_START_DATE  CONSTANT NUMBER(5) := 43432;
    lpn_system_date      NUMBER(5)          := pck_system_context.f_get_system_date;
    lpd_system_date      DATE               := pck_dates.f_system_date;

    CURSOR lpcu_premium_events (pcn_policy event.polref%TYPE
                               ,pcn_start_date event.dte1%TYPE
                               ,pcn_end_date event.dte1%TYPE) IS
        SELECT
              -- Sum of valid premium amounts within period given
              SUM (trnamt1) over (PARTITION BY staevt
                                               ,inrtyp
                                               ,trntyp1
                                               ,trnprmgrp
                                               ,valid_status_in_dates) sum_trnamt1
              -- Highest collection date of valid premiums within period given
              ,MAX (dte2) over (PARTITION BY staevt
                                             ,inrtyp
                                             ,trntyp1
                                             ,trnprmgrp
                                             ,valid_status_in_dates) max_dte2
              -- Output the partition on the valid premiums for above case statements
              -- so the PL/SQL can pick out the rows it needs (it should be the non-Null)
              ,valid_status_in_dates
              -- Get the last premium paid date
              ,max(premium.dte2) over (PARTITION BY last_premium_paid_partition) last_premium_paid
              -- Output the partition for the last premium paid case above so the PL/SQL can easily identify it
              ,last_premium_paid_partition
              -- Ugly case statement to identify any premiums with missing fund movements
              -- First we identify those we need to check (paid, primary events within the period)...
              ,CASE WHEN (staevt = 42 AND premium.dte2 >= pcn_start_date
                      OR (staevt = 55 AND premium.payment_date BETWEEN pcn_start_date AND pcn_end_date -1))
                    AND trnind1    < 2
                    AND clicat     != 'ANN'
                    AND trnamt1    != 0
                    AND due_date   <  pcn_end_date - 1
                    AND inrtyp     != 'PPC'
                    AND trntyp1    NOT IN ('PH','TUP','A','AOP','ATY','CAP','ID','INT','P','PRA','TOP')
                    THEN
                         -- then for GPS and non-DSS check unq and tranno on the FI700
                         CASE WHEN (inrtyp     != 'DSS'
                             OR pol.prdref LIKE  '%GPS%')
                         AND NOT EXISTS (SELECT NULL
                                        FROM fi700
                                        WHERE evtunq    = premium.unq
                                        AND   evttrn_no = premium.tranno
                                        AND   polref    = premium.polref
                                        AND   staevt    = 50)
                         THEN 1 -- output indicator if not found
                         -- And for non-GPS or DSS, we only check the unq on the FI700
                         WHEN (inrtyp     =        'DSS'         -- DSS payments can be merged if re-processed
                         AND   pol.prdref NOT LIKE '%GPS%'       -- for individual so won't be one for each
                         AND NOT EXISTS (SELECT NULL             -- tranno just for each unique reference
                                        FROM fi700
                                        WHERE evtunq = premium.unq
                                        AND   polref = premium.polref
                                        AND   staevt = 50))
                         THEN 1 -- output indicator it found
                         ELSE NULL -- output NULL if everything okay
                         END -- inner case
                     ELSE NULL -- output NULL if not the type of premium we're interested in
                END AS check_fund_movement
              ,premium.trntyp1
              ,premium.trnprmgrp    trnprmgrp
              ,premium.inrtyp       event_increment
              ,premium.inrref       event_increment_ref
              ,premium.due_date     due_date
              ,premium.dte2         coll_date
              ,premium.payment_date
              ,premium.staevt       event_status
              ,premium.unq          event_unq
              ,premium.tranno       event_tranno
              ,NVL(status_description.itevalnam,'*NO') status
        FROM
        (SELECT fi560.*
            ,CASE   WHEN staevt IN (10,20,75,82)
                    AND  dte2 BETWEEN pcn_start_date AND pcn_end_date - 1
                    THEN 1
                    WHEN fi560.staevt = 55
                    AND fi560.payment_date BETWEEN pcn_start_date AND pcn_end_date - 1
                    THEN 1
                    ELSE NULL
             END AS valid_status_in_dates
            ,CASE   WHEN staevt IN (10,55)
                    AND  inrtyp IN ('ORD','AVCO','RVP','AVCR')
                    AND  trntyp1 IN ('RP','ABP','AOP','ARP','FP','IRP','MN1')
                    THEN 1
                    ELSE NULL
               END last_premium_paid_partition
         FROM
        (SELECT e.unq   ,e.tranno   ,e.polref   ,e.clicat   ,e.cliref
            ,e.inrtyp   ,e.inrref   ,e.trnind1  ,e.trnind2  ,e.trntyp1  ,e.trntyp2
            ,e.trnamt1  ,e.trnamt2  ,e.staevt   ,e.trnprmgrp
            ,e.dte1 due_date
            ,e.dte2 -- Note this holds the payment date for premiums collected by direct debit
            ,CASE   WHEN staevt = 55 AND bilmettyp = 'D' -- paid by DD payment method
                    THEN e.dte2 -- DD payment date
                    WHEN staevt = 55 AND bilmettyp != 'D'-- paid by some other payment method
                    THEN (SELECT MAX(pyt.dte1) -- actual date on linked payment
                        FROM fi595 x, event pyt
                        WHERE e.staevt = 55 AND e.unq = x.unqtwo AND e.tranno = x.trn_notwo AND x.staxrffnc = 30 AND ispnamone = 'FI500'
                        AND x.unqone = pyt.unq AND x.trn_noone = pyt.tranno AND pyt.staevt IN (30,50))
                    ELSE NULL -- not paid
                 END payment_date
        FROM event e
        JOIN ge060 g ON  g.bilmet = e.trntyp2 AND g.maint != 'D'
        WHERE e.polref = pcn_policy AND e.ispec = 'FI560') fi560
        ) premium
        -- Get the product
        JOIN po010 pol ON pol.polref = premium.polref
        -- Get status description from CS060
        LEFT OUTER JOIN (SELECT itevalnam
                               ,datiteval
                         FROM cs060
                         WHERE ispgrpnam =  'FI560'
                         AND   datitenam =  'STAEVT'
                         AND   maint     <> 'D') status_description
            ON premium.staevt = TO_NUMBER(LTRIM(status_description.datiteval,0));

    CURSOR lpcu_fund_movements (pcn_policy fi700.polref%TYPE
                               ,pcn_start_date fi700.efvdte%TYPE) IS
        SELECT fi700.fndref
              ,fi700.efvdte
              ,nvl(data_description.itevalnam, '*NO') transaction_type
              ,fi700.fndtrntyp
              ,fi700.staevt
              ,nvl(status_description.itevalnam, '*NO') status
              ,fi700.untstm_no
              ,pr310.fndweenam
              ,pr310.fnd_id
              ,fi700.evtunq
              ,fi700.evttrn_no
              ,fi700.amt
              ,fi700.benqty1
              ,fi700.inrtyp
              ,fi700.inrref
        FROM fi700
        JOIN pr310
        ON fi700.fndref = pr310.fndref
        LEFT OUTER JOIN (SELECT itevalnam
                               ,datiteval
                         FROM cs060
                         WHERE ispgrpnam =  'FI700'
                         AND   datitenam =  'FNDTRNTYP'
                         AND   maint     <> 'D') data_description
        ON fi700.fndtrntyp = data_description.datiteval
        LEFT OUTER JOIN (SELECT itevalnam
                               ,datiteval
                         FROM cs060
                         WHERE ispgrpnam =  'FI700'
                         AND   datitenam =  'STA'
                         AND   maint     <> 'D') status_description
        ON fi700.staevt = LTRIM(status_description.datiteval,0)
        WHERE fi700.polref = pcn_policy
        AND   fi700.efvdte >= pcn_start_date
        AND   pr310.maint != 'D'
        AND   fi700.staevt NOT IN (70,80)
        ORDER BY efvdte ASC;

    TYPE rec_premiums IS TABLE OF lpcu_premium_events%ROWTYPE INDEX BY PLS_INTEGER;
    lpr_premiums rec_premiums;
    lpb_premiums_exist BOOLEAN := FALSE;
    lpn_policy_with_premiums event.polref%TYPE := 0;

    TYPE rec_fund_movements IS TABLE OF lpcu_fund_movements%ROWTYPE INDEX BY PLS_INTEGER;
    lpr_fund_movements rec_fund_movements;
    lpb_fund_movements BOOLEAN := FALSE;
    lpn_fund_movement_date pa020.strdte%TYPE := 0;
    lpn_policy_with_fund_movements fi700.polref%TYPE := 0;

    CURSOR lpcu_incr_and_decr_details(pcn_policy_number IN co040.polref%TYPE
                                     ,pcn_end_date  IN pa022.rnwdte%TYPE) IS
        SELECT po020.inrtyp
              ,po020.inrref
              ,po030.crcdte
              ,po030.othctbprm + po030.othctbadm + po030.othctbocc er_cont
              ,po030.occxtr + po030.prmamt + po030.admcrg -
                         (po030.othctbprm + po030.othctbadm + po030.othctbocc) ee_cont
              ,po030.bentyp
        FROM po020
        JOIN po030
        ON  po020.polref = po030.polref
        AND po020.inrtyp = po030.inrtyp
        AND po020.inrref = po030.inrref
        WHERE po020.polref = pcn_policy_number
        AND   po020.stainr  = 30
        AND   po030.bentyp <> 'WVR'
        AND   po020.maint  <> 'D'
        AND   po030.maint  <> 'D'
        AND   po020.alttyp NOT IN ('E','S')
        AND   po030.staben NOT IN (9, 12)
        AND   po030.crcdte NOT IN (0, 99999, -99999)
        AND   po030.crcdte < pcn_end_date
        AND (po030.othctbprm + po030.othctbadm + po030.othctbocc <> 0
        OR  po030.occxtr + po030.prmamt + po030.admcrg -
                         (po030.othctbprm + po030.othctbadm + po030.othctbocc) <> 0)
        UNION
        SELECT po020.inrtyp
              ,po020.inrref
              ,hi030.crcdte
              ,hi030.othctbprm + hi030.othctbadm + hi030.othctbocc er_cont
              ,hi030.sgnoccxtr + hi030.sgnprmamt + hi030.admcrg -
                            (hi030.othctbprm + hi030.othctbadm + hi030.othctbocc) ee_cont
              ,hi030.bentyp
        FROM po020
        JOIN hi030
        ON  po020.polref = hi030.polref
        AND po020.inrtyp = hi030.inrtyp
        AND po020.inrref = hi030.inrref
        WHERE po020.polref  = pcn_policy_number
        AND   po020.stainr  = 30
        AND   hi030.bentyp <> 'WVR'
        AND   po020.maint  <> 'D'
        AND   hi030.maint  <> 'D'
        AND   po020.alttyp IN ('E','S')
        AND   hi030.staben NOT IN (9, 12)
        AND   hi030.crcdte NOT IN (0, 99999, -99999)
        AND   hi030.crcdte < pcn_end_date
        AND (hi030.othctbprm + hi030.othctbadm + hi030.othctbocc <> 0
        OR   hi030.sgnoccxtr + hi030.sgnprmamt + hi030.admcrg -
                            (hi030.othctbprm + hi030.othctbadm + hi030.othctbocc) <> 0)
        ORDER BY 1, 2;

    CURSOR lpcu_SCYRQ_details(pcn_policy_number  IN co040.polref%TYPE
                             ,pcv_increment_type IN po020.inrtyp%TYPE
                             ,pcn_increment_ref  IN po020.inrref%TYPE
                             ,pcn_renewal_date   IN pa022.rnwdte%TYPE) IS
        SELECT strdte
              ,enddte
              ,inialcrte
              ,stdalcrte
              ,emrpympct
              ,emppympct
              ,csncfn
        FROM po350
        WHERE polref = pcn_policy_number
        AND   inrtyp = pcv_increment_type
        AND   inrref = pcn_increment_ref
        AND   sta    = 30
        AND   strdte < pcn_renewal_date
        ORDER BY polrcd_no DESC;

    CURSOR lpcu_activity_details (pcn_policy_number IN po100.polref%type) IS
        SELECT actref
              ,actpar
              ,actdte
              ,audaplcde
              ,audstf_no
              ,audupddte
        FROM po100
        WHERE polref =  pcn_policy_number
        AND   sta    =  30
        AND   maint  <> 'D'
        AND   actref IN ('ALC ERR'
                        ,'DEALC ERR'
                        ,'CSN ERR'
                        ,'SW ERR'
                        ,'UNW ERR'
                        ,'RDT ERR'
                        ,'BON ERR'
                        ,'CRG ERR'
                        ,'FORAC ERR'
                        ,'FORWB ERR'
                        ,'EXTFNDERR'
                        ,'VSTFNDERR'
                        ,'ID ERR'
                        ,'TFC ERR'
                        ,'ACCC ERR'
                        ,'UFPLS ERR'
                        ,'DFD ERR'
                        ,'PSA ERR'
                        ,'UPL ERR'
                        ,'ALCERR_RP')--Added the PSA,UPL, UPL RP Allocation error
        ORDER BY inrtyp
                ,inrref
                ,bentyp
                ,benref
                ,actref
                ,unqref;

    TYPE rec_actpl IS TABLE OF lpcu_activity_details%ROWTYPE INDEX BY PLS_INTEGER;
    lpr_ACTPL_errors rec_ACTPL;
    lpb_ACTPL_exist BOOLEAN := FALSE;
    lpn_policy_ACTPL fi700.polref%TYPE := 0;

    -- procedure to set up AWD information for scheme level exceptions
    PROCEDURE p_setup_AWD_policy_info(pr_audits               IN pck_audits.rec_audits
                                     ,pv_scheme_category      IN sc010.schcat%TYPE
                                     ,pn_scheme_ref           IN sc010.schref%TYPE
                                     ,pv_employer_category    IN cl300.clicat2%TYPE
                                     ,pn_employer_ref         IN cl300.cliref2%TYPE
                                     ,pn_policy_number        IN po010.polref%TYPE
                                     ,pv_product_reference    IN po010.prdref%TYPE
                                     ,pv_servicing_department IN VARCHAR2) IS

        lr_errordata    pck_business_errors.rec_errordata;

    BEGIN
        lr_errordata.sourcecode       := pr_audits.audit_application_code
                                                 ||LPAD(pr_audits.audit_staff_number,4,0);
        lr_errordata.systemdate       := TO_CHAR(pck_utility.f_dtcnv(lpn_system_date),'ddmmyy');
        lr_errordata.primaryclient    := pv_scheme_category
                                                 ||LPAD(pn_scheme_ref,8,0);
        lr_errordata.secondaryclient  := pv_employer_category
                                                 ||LPAD(pn_employer_ref,8,0);
        lr_errordata.policy           := pn_policy_number;
        lr_errordata.productreference := pv_product_reference;
        lr_errordata.processingdept   := pv_servicing_department;

        pck_business_errors.p_save_data(lr_errordata);

    END p_setup_AWD_policy_info;


    -- procedure to raise an exception for non-GPS contracts
    PROCEDURE p_raise_exception(pn_policy_number    IN po010.polref%TYPE
                               ,pn_exception_number IN exception_codes.code%TYPE
                               ,pv_error_message    IN VARCHAR2
                               ,pv_product_type     IN VARCHAR2
                               ) IS
    BEGIN
        CASE pv_product_type
            WHEN 'GPS' THEN
                pck_GPS_exceptions.p_raise_exception(pn_exception_number => pn_exception_number
                                                    ,pv_free_text        => pv_error_message
                                                    ,pn_polref           => pn_policy_number);
            ELSE
                pck_health_check_wrapper.p_raise_exception(pn_policy_number    => pn_policy_number
                                                          ,pn_exception_number => pn_exception_number
                                                          ,pv_error_message    => pv_error_message
                                                           );
        END CASE;
    END p_raise_exception;

    /*==================================================================================
    p_fetch_premiums
    Procedure to populate package collection of premium EVENT records
    ==================================================================================*/
    PROCEDURE p_fetch_premiums (pn_policy po010.polref%TYPE
                               ,pn_previous_renewal_date event.dte1%TYPE
                               ,pn_renewal_date event.dte1%TYPE
                               ) IS
        i PLS_INTEGER := 0;
    BEGIN

        lpb_premiums_exist := FALSE;
        -- Clear out old tables
        lpr_premiums.DELETE;
        -- Re-populate
        FOR a IN lpcu_premium_events (pn_policy
                                     ,pn_previous_renewal_date
                                     ,pn_renewal_date) LOOP
            -- Set record found flag
            IF NOT lpb_premiums_exist THEN
                lpb_premiums_exist := TRUE;
            END IF;
            i := i + 1;
            lpr_premiums(i) := a;

        END LOOP;

        lpn_policy_with_premiums := pn_policy;

    END p_fetch_premiums;
    /*==================================================================================
    p_fetch_fund_movement
    Procedure to populate package collection of fund movements
    ==================================================================================*/
    PROCEDURE p_fetch_fund_movements (pn_policy fi700.polref%TYPE
                                     ,pn_start_date fi700.efvdte%TYPE
                                     ) IS
        i PLS_INTEGER := 0;
    BEGIN
        lpb_fund_movements := FALSE;
        -- Clear out old tables
        lpr_fund_movements.DELETE;
        -- Re-populate
        FOR a IN lpcu_fund_movements(pn_policy
                                    ,pn_start_date) LOOP

            -- Set the record found flag
            IF NOT lpb_fund_movements THEN
                lpb_fund_movements := TRUE;
            END IF;
            i := i + 1;
            lpr_fund_movements(i) := a;

        END LOOP;

        lpn_policy_with_fund_movements := pn_policy;
        lpn_fund_movement_date := pn_start_date;

    END p_fetch_fund_movements;
    /*==================================================================================
    p_fetch_premiums
    Procedure to populate package collection of activity PO100 records
    ==================================================================================*/
    PROCEDURE p_fetch_ACTPL (pn_policy po010.polref%TYPE) IS
        i PLS_INTEGER := 0;
    BEGIN
        lpb_ACTPL_exist := FALSE;
        -- Clear out old collection
        lpr_ACTPL_errors.DELETE;
        -- Re-populate
        FOR a IN  lpcu_activity_details (pn_policy) LOOP
            -- Set record found flag
            IF NOT lpb_ACTPL_exist THEN
                lpb_ACTPL_exist := TRUE;
            END IF;
            i := i + 1;
            lpr_ACTPL_errors(i) := a;
        END LOOP;

        lpn_policy_ACTPL := pn_policy;

    END p_fetch_ACTPL;

    /* procedure to check to see whether there are any manual commission movements for a
       policy and itr */
    PROCEDURE p_manual_commission_check(pn_policy_number         IN co040.polref%TYPE
                                       ,pn_previous_renewal_date IN pa021.rnwdte%TYPE
                                       ,pn_renewal_date          IN pa021.rnwdte%TYPE) IS

        CURSOR cu_manual_movements IS
            SELECT inrtyp
                  ,inrref
                  ,csntyp
                  ,csnsta
                  ,csnamt
                  ,pck_utility.f_dtcnv(oridte) origin_date
                  ,stf_no
            FROM cm240
            WHERE itr_no IN (SELECT cliref
                             FROM co040
                             WHERE polref = cm240.polref
                             AND   staxrf = 30
                             AND   rolref = 'ITR'
                             AND   maint <> 'D')
            AND   csnsta    IN (10,20,40,60,80)
            AND   polref    =  pn_policy_number
            AND   csnrsncde IN (78,79)      -- manual movements
            AND   duedte BETWEEN pn_previous_renewal_date AND pn_renewal_date-1;

        lv_error_message    VARCHAR2(1803);

    BEGIN

        FOR lr_manual_movements IN cu_manual_movements LOOP

            lv_error_message := 'Increment type: '||lr_manual_movements.inrtyp||'~'||
                                'Increment ref: '||lr_manual_movements.inrref||'~'||
                                'Commission movement type: '||lr_manual_movements.csntyp||'~'||
                                'Movement status: '||lr_manual_movements.csnsta||'~'||
                                'Amount: '||lr_manual_movements.csnamt||'~'||
                                'Origin date: '||lr_manual_movements.origin_date||'~'||
                                'Staff number: '||lr_manual_movements.stf_no;

            pck_GPS_exceptions.p_raise_exception(763                -- exception number
                                                ,lv_error_message);

        END LOOP;

    END p_manual_commission_check;

    -- procedure to check that SCYRQ and CCINQ have consistent commission types
    PROCEDURE p_CCINQ_consistency_check(pn_policy_number         IN co040.polref%TYPE
                                       ,pv_increment_type        IN po020.inrtyp%TYPE
                                       ,pn_increment_ref         IN po020.inrref%TYPE
                                       ,pv_commission_type       IN po350.csncfn%TYPE) IS

        CURSOR cu_CCINQ_details IS
            SELECT csntyp
                  ,idmind
                  ,itr_no
            FROM co060
            WHERE polref    =  pn_policy_number
            AND   inrtyp    =  pv_increment_type
            AND   inrref    =  pn_increment_ref
            AND   csnrcdtyp =  10
            AND   sta       =  30
            AND   maint     <> 'D';

        lr_CCINQ_details            cu_CCINQ_details%ROWTYPE;
        lv_error_message            VARCHAR2(1803);
        lv_commission_type          VARCHAR2(2);

    BEGIN
        OPEN cu_CCINQ_details;
        FETCH cu_CCINQ_details INTO lr_CCINQ_details;

        IF cu_CCINQ_details%NOTFOUND THEN
            lv_error_message := 'Increment type: '||pv_increment_type||'~'||
                                'Increment ref: '||pn_increment_ref||'~'||
                                'SCYRQ commission classification: '||pv_commission_type||'~'||
                                'CCINQ commission classification: No record';

            pck_GPS_exceptions.p_raise_exception(762                -- exception number
                                                ,lv_error_message);

        ELSE
            WHILE cu_CCINQ_details%FOUND LOOP

                CASE lr_CCINQ_details.csntyp||lr_CCINQ_details.idmind
                    WHEN 'IY' THEN lv_commission_type := 'IN';
                    WHEN 'IN' THEN lv_commission_type := 'NI';
                    WHEN 'RY' THEN lv_commission_type := 'IR';
                    WHEN 'RN' THEN lv_commission_type := 'RE';
                    WHEN 'LY' THEN lv_commission_type := 'IL';
                    WHEN 'LN' THEN lv_commission_type := 'LE';
                    WHEN 'FY' THEN lv_commission_type := 'FE';
                    WHEN 'FN' THEN lv_commission_type := 'FE';
                    WHEN 'OY' THEN lv_commission_type := 'OF';
                    WHEN 'ON' THEN lv_commission_type := 'OF';
                    WHEN 'NY' THEN lv_commission_type := 'NC';
                    WHEN 'NN' THEN lv_commission_type := 'NC';
                    WHEN 'DY' THEN lv_commission_type := 'DC';
                    WHEN 'DN' THEN lv_commission_type := 'DC';
                    ELSE
                        lv_commission_type := lr_CCINQ_details.csntyp||lr_CCINQ_details.idmind;
                END CASE;

                IF pv_commission_type||lv_commission_type NOT IN ('IDMIN'
                                                                 ,'IDMRE'
                                                                 ,'IDMIR'
                                                                 ,'NINI'
                                                                 ,'NIRE'
                                                                 ,'LEVLE'
                                                                 ,'ILCIL'
                                                                 ,'ILCLE'
                                                                 ,'NILNC'
                                                                 ,'NILDC'
                                                                 ,'NILIN'
                                                                 ,'NILRE'
                                                                 ,' DC') THEN
                    lv_error_message := 'Increment type: '||pv_increment_type||'~'||
                                        'Increment ref: '||pn_increment_ref||'~'||
                                        'SCYRQ commission classification: '||pv_commission_type||'~'||
                                        'CCINQ commission classification: '||lv_commission_type;

                    pck_GPS_exceptions.p_raise_exception(762                -- exception number
                                                        ,lv_error_message);

                END IF;

                FETCH cu_CCINQ_details INTO lr_CCINQ_details;

            END LOOP;

        END IF;

        CLOSE cu_CCINQ_details;

    END p_CCINQ_consistency_check;

    -- procedure to check the SCYRQ exceptions
    PROCEDURE p_SCYRQ_check(pn_policy_number           IN  co040.polref%TYPE
                           ,pr_increments              IN  lpcu_incr_and_decr_details%ROWTYPE
                           ,pn_start_date              IN  pa021.rnwdte%TYPE
                           ,pn_renewal_date            IN  pa021.rnwdte%TYPE
                           ,pb_live_SCYRQ_record_found OUT BOOLEAN
                           ,pr_SCYRQ_details           OUT lpcu_SCYRQ_details%ROWTYPE) IS

        lr_SCYRQ_details            lpcu_SCYRQ_details%ROWTYPE;
        lb_true_increment           BOOLEAN;
        lv_error_message            VARCHAR2(1803);

    BEGIN

        IF pr_increments.er_cont > 0
        OR pr_increments.ee_cont > 0 THEN
            lb_true_increment := TRUE;
        ELSE
            lb_true_increment := FALSE;
        END IF;

        OPEN lpcu_SCYRQ_details(pn_policy_number
                               ,pr_increments.inrtyp
                               ,pr_increments.inrref
                               ,pn_renewal_date);
        FETCH lpcu_SCYRQ_details INTO lr_SCYRQ_details;

        IF lpcu_SCYRQ_details%NOTFOUND THEN
            lv_error_message := 'Policy: '||pn_policy_number||'~'||
                                'Increment reference: '||pr_increments.inrref;

            pck_GPS_exceptions.p_raise_exception(747                -- exception number
                                                ,lv_error_message);

        ELSE

            pb_live_SCYRQ_record_found := TRUE;
            pr_SCYRQ_details           := lr_SCYRQ_details;

            -- need to check corresponding CCINQ record for this SCYRQ record
            p_CCINQ_consistency_check(pn_policy_number
                                     ,pr_increments.inrtyp
                                     ,pr_increments.inrref
                                     ,lr_SCYRQ_details.csncfn);


            IF  lr_SCYRQ_details.enddte   <> pn_renewal_date - 1
            OR (lr_SCYRQ_details.strdte   <> pn_start_date AND
                -- New start date has been updated to cap allocation rate, 747 exception should be bypassed.
                lr_SCYRQ_details.strdte   <> LPCN_NEW_START_DATE)   THEN
                lv_error_message := 'Policy: '||pn_policy_number||'~'||
                                    'Increment reference: '||pr_increments.inrref;

                pck_GPS_exceptions.p_raise_exception(747                -- exception number
                                                    ,lv_error_message);
            END IF;

            -- allocation rate check should look at all live records for increments only that
            -- are not NIL or blank commission
            IF  lb_true_increment
            AND lr_SCYRQ_details.csncfn NOT IN ('NIL',' ')
            AND (lr_SCYRQ_details.inialcrte = 0
            OR   lr_SCYRQ_details.stdalcrte = 0) THEN
                lv_error_message := 'Policy: '||pn_policy_number||'~'||
                                    'Increment reference: '||pr_increments.inrref;

                pck_GPS_exceptions.p_raise_exception(771                -- exception number
                                                    ,lv_error_message);
            END IF;

            FETCH lpcu_SCYRQ_details INTO lr_SCYRQ_details;

            IF lpcu_SCYRQ_details%FOUND THEN            -- should only be 1 live record
                lv_error_message := 'Policy: '||pn_policy_number||'~'||
                                    'Increment reference: '||pr_increments.inrref;

                pck_GPS_exceptions.p_raise_exception(748                -- exception number
                                                    ,lv_error_message);
            END IF;

        END IF;

        CLOSE lpcu_SCYRQ_details;

    END p_SCYRQ_check;

    -- procedure to check that each live CCINQ record is unique and that the dates flow
    PROCEDURE p_CCINQ_check(pn_policy_number   IN co040.polref%TYPE
                           ,pv_increment_type  IN po020.inrtyp%TYPE
                           ,pn_increment_ref   IN po020.inrref%TYPE) IS

        CURSOR cu_CCINQ_details IS
            SELECT COUNT(1) no_of_rows
                  ,csntyp
                  ,strdte
                  ,enddte
            FROM co060
            WHERE polref    =  pn_policy_number
            AND   inrtyp    =  pv_increment_type
            AND   inrref    =  pn_increment_ref
            AND   csnrcdtyp =  10
            AND   sta       =  30
            AND   maint     <> 'D'
            GROUP BY csntyp
                    ,strdte
                    ,enddte
            ORDER BY csntyp
                    ,strdte
                    ,enddte;

        lv_error_message    VARCHAR2(1803);
        lr_previous_row     cu_CCINQ_details%ROWTYPE;
        lb_error_found      BOOLEAN DEFAULT FALSE;
        lb_live_CCINQ_found BOOLEAN DEFAULT FALSE;

    BEGIN
        FOR lr_CCINQ_details IN cu_CCINQ_details LOOP

            lb_live_CCINQ_found := TRUE;

            IF  (NVL(lr_previous_row.csntyp,' ')  =  lr_CCINQ_details.csntyp
            AND  NVL(lr_previous_row.enddte,0)    <> lr_CCINQ_details.strdte - 1)
            OR  (lr_CCINQ_details.no_of_rows > 1) THEN
                lb_error_found := TRUE;
            END IF;

            lr_previous_row := lr_CCINQ_details;

        END LOOP;

        IF NOT lb_live_CCINQ_found
        OR     lb_error_found      THEN

            lv_error_message := 'Increment type: '||pv_increment_type||'~'||
                                'Increment ref: '||pn_increment_ref;

            pck_GPS_exceptions.p_raise_exception(764                -- exception number
                                                ,lv_error_message);

        END IF;

    END p_CCINQ_check;

    -- procedure to check that there is a live overcoded commission record
    PROCEDURE p_overcoded_commission_check(pn_policy_number   IN co040.polref%TYPE
                                          ,pv_increment_type  IN po020.inrtyp%TYPE
                                          ,pn_increment_ref   IN po020.inrref%TYPE
                                          ,pn_default_policy  IN sc010.dflpolref%TYPE) IS

        CURSOR cu_overcoded_commission IS
            SELECT 1
            FROM cm420
            WHERE ((polref =  pn_policy_number
            AND     inrref =  pn_increment_ref)
            OR     (polref =  pn_default_policy
            AND     inrref =  1))
            AND   inrtyp =  pv_increment_type
            AND   maint  <> 'D';

        lr_overcoded_commission cu_overcoded_commission%ROWTYPE;
        lv_error_message        VARCHAR2(1803);

    BEGIN
        OPEN cu_overcoded_commission;
        FETCH cu_overcoded_commission INTO lr_overcoded_commission;

        IF cu_overcoded_commission%NOTFOUND THEN

            lv_error_message := 'Increment type: '||pv_increment_type||'~'||
                                'Increment ref: '||pn_increment_ref;

            pck_GPS_exceptions.p_raise_exception(765                -- exception number
                                                ,lv_error_message);

        END IF;

        CLOSE cu_overcoded_commission;

    END p_overcoded_commission_check;

    -- procedure to check that all RVP have increments have the relevant investments.
    PROCEDURE p_RVP_investment_check(pn_policy_number IN co040.polref%TYPE
                                    ,pv_pup_indicator IN VARCHAR2) IS

        CURSOR cu_RVP_details(cn_increment_reference IN pa020.inrref%TYPE) IS
            SELECT sta_pa
                  ,status_description.itevalnam status
                  ,fndtrntyp
                  ,pck_utility.f_dtcnv(strdte) strdte
                  ,CASE enddte
                       WHEN 99999 THEN NULL
                       ELSE pck_utility.f_dtcnv(enddte)
                   END enddte
            FROM   PA020
            LEFT OUTER JOIN (SELECT itevalnam
                                   ,datiteval
                             FROM cs060
                             WHERE ispgrpnam =  'PA020'
                             AND   datitenam =  'STA'
                             AND   maint     <> 'D') status_description
            ON TO_CHAR(sta_pa) = LTRIM(status_description.datiteval,0)
            WHERE  polref = pn_policy_number
            AND    inrtyp = 'RVP'
            AND    inrref = cn_increment_reference
            AND    sta_pa IN (30,50)
            AND    fndtrntyp = 'RP'
            AND    maint !='D'
            ORDER BY enddte DESC;

        lr_RVP_details            cu_RVP_details%ROWTYPE;
        ln_live_count             PLS_INTEGER;
        lb_error_found            BOOLEAN DEFAULT FALSE;
        lv_error_message          VARCHAR2(1803);

    BEGIN
        ln_live_count := 0;
        OPEN  cu_RVP_details(0);        -- check inrref 0 only
        FETCH cu_RVP_details INTO lr_RVP_details;

        IF cu_RVP_details%NOTFOUND THEN
            CLOSE cu_RVP_details;
            OPEN cu_RVP_details(1);      -- check inrref 1 if inrref 0 doesn't exist
            FETCH cu_RVP_details INTO lr_RVP_details;

            IF cu_RVP_details%NOTFOUND THEN
                lb_error_found  := TRUE;
            END IF;
        END IF;

        WHILE cu_RVP_details%FOUND
        AND NOT lb_error_found LOOP

    -- Checking for PUP policies with live records or Live policies with more than one live record or
    -- where the first Live record is not all 9's.

            IF pv_pup_indicator = 'Y'
            AND lr_RVP_details.sta_pa = 30 THEN
               lb_error_found := TRUE;
            ELSIF pv_pup_indicator = 'N'
            AND   lr_RVP_details.sta_pa = 30
            AND   lr_RVP_details.enddte IS NULL THEN
                  ln_live_count  := ln_live_count + 1;
            ELSIF pv_pup_indicator = 'N'
            AND   lr_RVP_details.enddte IS NOT NULL
            AND   ln_live_count         = 0         THEN
                  lb_error_found := TRUE;
            END IF;

            IF ln_live_count > 1 THEN
               lb_error_found := TRUE;
            END IF;

            IF lb_error_found THEN
               lv_error_message:='RP Start Date: '  ||lr_RVP_details.strdte||'~'||
                                 'RP End Date: '    ||lr_RVP_details.enddte||'~'||
                                 'RP UDCTL Status: '||lr_RVP_details.status||'~';
            END IF;

            FETCH cu_RVP_details INTO lr_RVP_details;

        END LOOP;

        CLOSE cu_RVP_details;


        IF lb_error_found THEN
            IF pv_pup_indicator   = 'N' THEN
               lv_error_message := lv_error_message||'Policy Status: LIVE';
            ELSE
               lv_error_message := lv_error_message||'Policy Status: PUP';
            END IF;

            pck_GPS_exceptions.p_raise_exception(761,lv_error_message);

        END IF;

    END p_RVP_investment_check;

    -- procedure to check that all ORD/AVCOs have increments have the relevant investments.
    PROCEDURE p_ORD_investment_check(pn_policy_number  IN co040.polref%TYPE
                                    ,pv_product_type   IN pr010.prdref%TYPE) IS

         CURSOR cu_ORD_non_rs_details (pcn_policy_number  pa020.polref%TYPE) IS
            SELECT (CASE
                       WHEN udctl_info IS NOT NULL THEN
                            udctl_info
                       ELSE 'No RP investment record exists for '
                    END) ||'~'||
                    'Increment Type: '|| inrtyp ||'~'||
                    'Increment reference: '||inrref error_message
            FROM (
                     SELECT po.inrtyp
                           ,po.inrref
                           ,(SELECT 'Effective Date: '||TO_CHAR(TO_DATE(TO_CHAR(pa2.efvdte + 2415021),'J'),'DD/MM/YYYY')  ||'~'||
                                    'End Date: '      ||(CASE
                                                            WHEN pa2.enddte = 99999 THEN
                                                                  '99/99/9999'
                                                            WHEN pa2.enddte = -99999 THEN
                                                                  'N/A'
                                                            ELSE TO_CHAR(TO_DATE(TO_CHAR(pa2.enddte + 2415021),'J'),'DD/MM/YYYY')
                                                         END) ||'~'||
                                    'UDCTL Status: '  ||NVL((SELECT cs.itevalnam
                                                             FROM   cs060 cs
                                                             WHERE  cs.ispgrpnam  = 'PA020'
                                                             AND    cs.datitenam  =  'STA'
                                                             AND    cs.maint     != 'D'
                                                             AND    cs.datiteval  = pa2.sta_pa),'*NO')
                             FROM  pa020 pa2
                             WHERE pa2.polref    = pol.polref
                             AND   pa2.fndtrntyp = 'RP'
                             AND   pa2.inrtyp    = po.inrtyp
                             AND   pa2.maint    != 'D'
                             AND  (pa2.enddte   != 99999
                             OR    pa2.sta_pa   != 30)
                             AND   pa2.efvdte    = (SELECT MAX(efvdte)
                                                    FROM pa020 pa3
                                                    WHERE pa3.polref    = pa2.polref
                                                    AND   pa3.fndtrntyp = 'RP'
                                                    AND   pa3.inrtyp    = pa2.inrtyp
                                                    AND   pa3.maint    != 'D'
                                                    AND  (pa3.enddte   != 99999
                                                    OR    pa3.sta_pa   != 30))
                             AND   pa2.trnctl_no = (SELECT MAX(pa4.trnctl_no)
                                                    FROM  pa020 pa4
                                                    WHERE pa4.polref    = pa2.polref
                                                    AND   pa4.fndtrntyp = 'RP'
                                                    AND   pa4.inrtyp    = pa2.inrtyp
                                                    AND   pa4.maint    != 'D'
                                                    AND  (pa4.enddte   != 99999
                                                    OR    pa4.sta_pa   != 30)
                                                    AND   pa4.efvdte    = pa2.efvdte)) AS udctl_info
                     FROM   po010 pol
                           ,po020 po
                     WHERE  pol.polref = pcn_policy_number
                     AND    pol.stapol  IN   (30,52)
                     AND    pol.polref   =   po.polref
                     AND    po.maint    !=   'D'
                     AND    po.stainr    IN  (30,52)
                     AND    po.inrtyp   IN   ('ORD','AVCO')
                     AND    po.inrref    =   (SELECT MIN(po2.inrref)
                                              FROM  po020 po2
                                              WHERE po2.polref  = po.polref
                                              AND   po2.maint  != 'D'
                                              AND   po2.stainr  IN (30,52)
                                              AND   po2.inrtyp IN ('ORD','AVCO'))
                     AND   EXISTS (SELECT 1                     -- check if the 1st increment of ORD OR AVCO is not exited
                                   FROM  po020 a                -- if the 1st increment is exited, the rest will be displayed as exited
                                   WHERE a.polref  = po.polref  -- although the other increments are live
                                   AND a.maint    != 'D'
                                   AND a.inrtyp    = po.inrtyp
                                   AND (a.stainr  IN (30,52)
                                   OR  (a.stainr   = 61
                                   AND a.extmod   IN (41,42,43,52,51)))
                                   AND a.inrref    = 1)
                     AND  NOT EXISTS (SELECT 1                  -- check that no udctl RP record exist for the policy
                                      FROM  pa020 pa
                                      WHERE pa.polref    = po.polref
                                      AND   pa.fndtrntyp = 'RP'
                                      AND   pa.inrtyp    = po.inrtyp
                                      AND   pa.sta_pa    = 30
                                      AND   pa.maint    != 'D'
                                      AND   pa.enddte    = 99999)
                     AND  EXISTS(SELECT 1                      -- check that policy has investment
                                 FROM  po030 po3
                                 WHERE po3.maint !=  'D'
                                 AND   po3.polref =  po.polref
                                 AND   po3.staben IN (30,52)
                                 AND   po3.bentyp LIKE 'INV%')
                 );

         CURSOR cu_ORD_rs_details (pcn_policy_number  pa020.polref%TYPE) IS
            SELECT (CASE
                       WHEN udctl_info IS NOT NULL THEN
                          udctl_info
                       ELSE 'No RP investment record exists for '
                    END) ||'~'||
                    'Increment Type: '||inrtyp ||'~'||
                    'Increment reference: '||inrref error_message
            FROM (
                     SELECT  po.inrtyp
                            ,po.inrref
                            ,(SELECT 'Effective Date: '||TO_CHAR(TO_DATE(TO_CHAR(pa2.efvdte + 2415021),'J'),'DD/MM/YYYY')  ||'~'||
                                     'End Date: '      ||(CASE
                                                            WHEN pa2.enddte = 99999 THEN
                                                                  '99/99/9999'
                                                            WHEN pa2.enddte = -99999 THEN
                                                                  'N/A'
                                                            ELSE TO_CHAR(TO_DATE(TO_CHAR(pa2.enddte + 2415021),'J'),'DD/MM/YYYY')
                                                          END) ||'~'||
                                     'UDCTL Status: '  ||NVL((SELECT cs.itevalnam
                                                              FROM   cs060 cs
                                                              WHERE  cs.ispgrpnam = 'PA020'
                                                              AND   cs.datitenam =  'STA'
                                                              AND   cs.maint    != 'D'
                                                              AND   cs.datiteval = pa2.sta_pa),'*NO')
                              FROM pa020 pa2
                              WHERE pa2.polref    = pol.polref
                              AND   pa2.fndtrntyp = 'RP'
                              AND   pa2.inrtyp    = po.inrtyp
                              AND   pa2.inrref    = po.inrref
                              AND   pa2.maint    != 'D'
                              AND  (pa2.enddte   != 99999
                              OR    pa2.sta_pa   != 30)
                              AND   pa2.efvdte    = (SELECT MAX(efvdte)
                                                     FROM   pa020 pa3
                                                     WHERE pa3.polref    = pa2.polref
                                                     AND   pa3.fndtrntyp = 'RP'
                                                     AND   pa3.inrtyp    = pa2.inrtyp
                                                     AND   pa3.inrref    = pa2.inrref
                                                     AND   pa3.maint    != 'D'
                                                     AND  (pa3.enddte   != 99999
                                                     OR    pa3.sta_pa   != 30))
                              AND   pa2.trnctl_no = (SELECT MAX(pa4.trnctl_no)
                                                     FROM  pa020 pa4
                                                     WHERE pa4.polref    = pa2.polref
                                                     AND   pa4.fndtrntyp = 'RP'
                                                     AND   pa4.inrtyp    = pa2.inrtyp
                                                     AND   pa4.inrref    = pa2.inrref
                                                     AND   pa4.maint    != 'D'
                                                     AND  (pa4.enddte   != 99999
                                                     OR    pa4.sta_pa   != 30)
                                                     AND   pa4.efvdte    = pa2.efvdte)) AS udctl_info
                     FROM  po010 pol
                          ,po020 po
                     WHERE pol.polref = pcn_policy_number
                     AND   pol.stapol  IN  (30,52)
                     AND   pol.polref   =  po.polref
                     AND   po.inrtyp   IN  ('ORD','AVCO')
                     AND   po.stainr   IN  (30,52)
                     AND   po.maint    !=  'D'
                     AND   EXISTS (SELECT 1                     -- check if the 1st increment of ORD OR AVCO is not exited
                                   FROM  po020 a                -- if the 1st increment is exited, the rest will be displayed as exited
                                   WHERE a.polref = pol.polref  -- although the other increments are live
                                   AND a.maint   != 'D'
                                   AND a.inrtyp   = po.inrtyp
                                   AND (a.stainr IN (30,52)
                                   OR  (a.stainr  = 61
                                   AND a.extmod  IN (41,42,43,52,51)))
                                   AND a.inrref   = 1)
                     AND  NOT EXISTS (SELECT 1
                                      FROM  pa020 pa
                                      WHERE pol.polref   = pa.polref
                                      AND   pa.fndtrntyp = 'RP'
                                      AND   pa.inrtyp    = po.inrtyp
                                      AND   pa.inrref    = po.inrref
                                      AND   pa.sta_pa    = 30
                                      AND   pa.maint    != 'D'
                                      AND   pa.enddte    = 99999)
                     AND  EXISTS(SELECT 1                      -- check that policy has investment
                                 FROM  po030 po3
                                 WHERE po3.maint !=  'D'
                                 AND   po3.polref =  po.polref
                                 AND   po3.staben IN (30,52)
                                 AND   po3.bentyp LIKE 'INV%')
                 );

        lr_ORD_non_rs_details     cu_ORD_non_rs_details%ROWTYPE;
        lr_ORD_rs_details         cu_ORD_rs_details%ROWTYPE;

    BEGIN

        IF pv_product_type NOT LIKE 'RS-%' THEN

             OPEN cu_ORD_non_rs_details (pn_policy_number);
             LOOP
                FETCH cu_ORD_non_rs_details  INTO lr_ORD_non_rs_details;
                EXIT WHEN cu_ORD_non_rs_details%NOTFOUND;

                p_raise_exception(pn_policy_number
                                 ,761
                                 ,lr_ORD_non_rs_details.error_message
                                 ,pv_product_type
                                 );
            END LOOP;
            CLOSE cu_ORD_non_rs_details;
        ELSE

            OPEN cu_ORD_rs_details (pn_policy_number);
             LOOP
                FETCH cu_ORD_rs_details  INTO lr_ORD_rs_details;
                EXIT WHEN cu_ORD_rs_details%NOTFOUND;

                p_raise_exception(pn_policy_number
                                 ,761
                                 ,lr_ORD_rs_details.error_message
                                 ,pv_product_type
                                 );
            END LOOP;
            CLOSE cu_ORD_rs_details;
        END IF;

    END p_ORD_investment_check;

    -- procedure to check the status of switches and amc
    PROCEDURE p_UDCTL_check(pn_policy_number         IN co040.polref%TYPE
                           ,pn_previous_renewal_date IN pa021.rnwdte%TYPE
                           ,pn_renewal_date          IN pa021.rnwdte%TYPE
                           ,pv_transaction_type      IN pa020.fndtrntyp%TYPE
                           ,pv_product_type          IN pr010.prdref%TYPE) IS

        CURSOR cu_incomplete_transactions (pcn_policy_number         co040.polref%TYPE
                                          ,pcv_transaction_type      pa020.fndtrntyp%TYPE
                                          ,pcn_previous_renewal_date pa021.rnwdte%TYPE
                                          ,pcn_renewal_date          pa021.rnwdte%TYPE)
        IS
            SELECT pa020.sta_pa
                  ,pa020.trnctl_no
                  ,pa020.efvdte
                  ,NVL(data_description.itevalnam,'*NO') itevalnam
                  ,pa2.trnctl_no trans_no
                  ,pa2.fndtrntyp
            FROM pa020
            LEFT OUTER JOIN (SELECT itevalnam
                                   ,datiteval
                             FROM cs060
                             WHERE ispgrpnam =  'UT085'
                             AND   datitenam =  'STA'
                             AND   maint     <> 'D') data_description
            ON pa020.sta_pa  = data_description.datiteval
            LEFT OUTER JOIN pa020 pa2
            ON pa020.polref = pa2.polref
            AND pa020.pnttrn_no = pa2.trnctl_no
            WHERE pa020.polref     = pcn_policy_number
            AND   pa020.fndtrntyp  = pcv_transaction_type
            AND   pa020.maint     != 'D'
            AND ((pa020.fndtrntyp != 'AMC'
            AND   pa020.efvdte BETWEEN pcn_previous_renewal_date AND pcn_renewal_date-1
            AND   NOT EXISTS (SELECT 1
                              FROM pa020 pa3
                              WHERE pa3.polref = pa020.polref
                              AND   pa3.fndtrntyp = 'TAP'
                              AND   pa3.trnctl_no = pa020.pnttrn_no))
            OR    pa020.fndtrntyp  = 'AMC'
            AND ((SELECT SUM (benqty1)
                  FROM  co055
                  WHERE co055.polref    = pcn_policy_number
                  AND   co055.untstm_no = 999
                  GROUP BY co055.polref)
                   > 0));

        lv_error_message              VARCHAR2(1803);
        ln_exception_number           ge110.rsncde%TYPE;

    BEGIN
        CASE pv_transaction_type
            WHEN 'SW'  THEN ln_exception_number := 737;
            WHEN 'AMC' THEN ln_exception_number := 778;
            ELSE
                ln_exception_number := 999;
        END CASE;

        FOR lr_incomplete_transactions IN cu_incomplete_transactions(pn_policy_number
                                                                    ,pv_transaction_type
                                                                    ,pn_previous_renewal_date
                                                                    ,pn_renewal_date) LOOP

            IF (pv_transaction_type = 'SW'  AND lr_incomplete_transactions.sta_pa NOT IN (40,50,80))
            OR (pv_transaction_type = 'AMC' AND (lr_incomplete_transactions.sta_pa != 30
                                            OR   lr_incomplete_transactions.efvdte <= pn_renewal_date)) THEN

                lv_error_message := pv_transaction_type||' effective date: '||
                                                pck_utility.f_dtcnv(lr_incomplete_transactions.efvdte)||'~'||
                                    pv_transaction_type||' UDCTL status: '||lr_incomplete_transactions.itevalnam||'~'||
                                    pv_transaction_type||' transaction control number: '||
                                                 lr_incomplete_transactions.trnctl_no;

                IF pv_transaction_type = 'SW' THEN
                   lv_error_message := lv_error_message ||'~'||  'Linked Transaction Control Type: ' || NVL(lr_incomplete_transactions.fndtrntyp, ' ')
                                       ||'~'|| 'Linked Transaction Control Number: ' ||NVL(lr_incomplete_transactions.trans_no, 0);
                END IF;

                p_raise_exception(pn_policy_number
                                 ,ln_exception_number
                                 ,lv_error_message
                                 ,pv_product_type
                                 );
            END IF;

        END LOOP;

    END p_UDCTL_check;

    -- procedure to check failed redirections
    PROCEDURE p_redirection_check(pn_policy_number         IN co040.polref%TYPE
                                 ,pn_previous_renewal_date IN pa021.rnwdte%TYPE
                                 ,pn_renewal_date          IN pa021.rnwdte%TYPE
                                 ,pv_product_type          IN pr010.prdref%TYPE) IS

        CURSOR cu_redirection_details IS
            SELECT  TO_DATE(TO_CHAR(pa.strdte + 2415021),'J') AS start_date
                   ,TO_DATE(TO_CHAR(pa.efvdte + 2415021),'J') AS effective_date
                   ,(CASE
                        WHEN pa.sta_pa IN (5,10,30,40,47,50,80) THEN
                            (SELECT itevalnam
                             FROM  cs060 cs
                             WHERE ispgrpnam    = 'UT085'
                             AND   datitenam    = 'STA'
                             AND   maint       != 'D'
                             AND   cs.datiteval = pa.sta_pa)
                        WHEN pa.sta_pa NOT IN (5,10,30,40,47,50,80) AND pa.sta_pa IS NOT NULL THEN
                             '*NO'
                        ELSE NULL
                     END) AS status
                    ,pa.trnctl_no
            FROM  pa020 pa
            WHERE pa.polref          =  pn_policy_number
            AND   pa.fndtrntyp       =  'RE'
            AND   pa.sta_pa     NOT IN  (50,80,5)    --actioned, cancelled and draft
            AND   pa.maint          !=  'D'
            AND   pa.efvdte    BETWEEN  pn_previous_renewal_date AND pn_renewal_date-1;

        lv_error_message    VARCHAR2(1803);

    BEGIN

        FOR lr_redirection_details IN cu_redirection_details LOOP

                lv_error_message := 'Start Date: ' || lr_redirection_details.start_date || '~' ||
                                    'Effective Date: ' ||lr_redirection_details.effective_date || '~' ||
                                    'Status: ' || lr_redirection_details.status || '~' ||
                                    'Transaction Control Number: '||lr_redirection_details.trnctl_no;

                p_raise_exception(pn_policy_number
                                 ,721
                                 ,lv_error_message
                                 ,pv_product_type
                                 );

        END LOOP;

    END p_redirection_check;

    -- function to establish whether there is an increment on renewal
    FUNCTION f_increment_on_renewal(pn_policy_number IN po010.polref%TYPE
                                   ,pn_renewal_date  IN pa022.rnwdte%TYPE
                                   ,pv_contributor   IN VARCHAR2) RETURN BOOLEAN IS

        ln_employer_contribution    NUMBER(12,2);
        ln_employee_contribution    NUMBER(12,2);
        lb_increment_on_renewal     BOOLEAN         DEFAULT FALSE;

    BEGIN
        SELECT NVL(SUM(er_cont),0) total_er_cont
              ,NVL(SUM(ee_cont),0) total_ee_cont
        INTO ln_employer_contribution
            ,ln_employee_contribution
        FROM (SELECT po030.othctbprm + po030.othctbadm + po030.othctbocc er_cont
                    ,po030.occxtr + po030.prmamt + po030.admcrg -
                        (po030.othctbprm + po030.othctbadm + po030.othctbocc) ee_cont
              FROM po020
              JOIN po030
              ON  po020.polref = po030.polref
              AND po020.inrtyp = po030.inrtyp
              AND po020.inrref = po030.inrref
              WHERE po020.polref = pn_policy_number
              AND   po020.inrtyp = 'RVP'
              AND   po020.stainr = 30
              AND   po030.bentyp = 'INV'
              AND   po020.maint != 'D'
              AND   po030.maint != 'D'
              AND   po030.staben NOT IN (9, 12)
              AND   po030.crcdte NOT IN (0, 99999, -99999)
              AND   po030.crcdte >= pn_renewal_date
              AND (po030.othctbprm + po030.othctbadm + po030.othctbocc <> 0
              OR  po030.occxtr + po030.prmamt + po030.admcrg -
                     (po030.othctbprm + po030.othctbadm + po030.othctbocc) <> 0)
              UNION
              SELECT hi030.othctbprm + hi030.othctbadm + hi030.othctbocc er_cont
                    ,hi030.sgnoccxtr + hi030.sgnprmamt + hi030.admcrg -
                        (hi030.othctbprm + hi030.othctbadm + hi030.othctbocc) ee_cont
              FROM po020
              JOIN hi030
              ON  po020.polref = hi030.polref
              AND po020.inrtyp = hi030.inrtyp
              AND po020.inrref = hi030.inrref
              WHERE po020.polref  = pn_policy_number
              AND   po020.inrtyp  = 'RVP'
              AND   po020.stainr  = 30
              AND   hi030.bentyp  = 'INV'
              AND   po020.maint  != 'D'
              AND   hi030.maint  != 'D'
              AND   hi030.staben NOT IN (9, 12)
              AND   hi030.crcdte NOT IN (0, 99999, -99999)
              AND   hi030.crcdte >= pn_renewal_date
              AND (hi030.othctbprm + hi030.othctbadm + hi030.othctbocc <> 0
              OR   hi030.sgnoccxtr + hi030.sgnprmamt + hi030.admcrg -
                        (hi030.othctbprm + hi030.othctbadm + hi030.othctbocc) <> 0));

        CASE pv_contributor
            WHEN 'EE' THEN
                IF ln_employee_contribution > 0 THEN
                    lb_increment_on_renewal := TRUE;
                END IF;

            WHEN 'ER' THEN
                IF ln_employer_contribution > 0 THEN
                    lb_increment_on_renewal := TRUE;
                END IF;
        END CASE;

        RETURN(lb_increment_on_renewal);

    END f_increment_on_renewal;

    -- procedure to check the premium group for a policy
    PROCEDURE p_premium_group_check(pn_policy_number         IN co040.polref%TYPE
                                   ,pv_pup_indicator         IN VARCHAR2
                                   ,pv_contributor           IN VARCHAR2
                                   ,pb_contributions_exist   IN BOOLEAN
                                   ,pn_previous_renewal_date IN pa021.rnwdte%TYPE
                                   ,pn_renewal_date          IN pa021.rnwdte%TYPE
                                   ,pb_exception_raised     OUT BOOLEAN
                                   ,pv_premium_frequency    OUT co072.frq%TYPE) IS

        CURSOR cu_premium_group IS
            SELECT stabil
                  ,enddte
                  ,frq
            FROM  co072
            WHERE polref = pn_policy_number
            AND   inrtyp = 'RVP'
            AND   stabil IN (30, 60)
            AND   prmgrp = pv_contributor
            AND   maint !='D'
            ORDER BY efvdte DESC;

        lr_premium_group                     cu_premium_group%ROWTYPE;
        lb_contribution_found                BOOLEAN DEFAULT FALSE;
        lb_live_record_exists                BOOLEAN DEFAULT FALSE;
        lb_pup_record_exists                 BOOLEAN DEFAULT FALSE;

        BEGIN
            pb_exception_raised   := FALSE;

            OPEN  cu_premium_group;
            FETCH cu_premium_group INTO lr_premium_group;

            IF cu_premium_group%FOUND THEN
                pv_premium_frequency := lr_premium_group.frq;
            ELSIF  cu_premium_group%NOTFOUND
            AND pb_contributions_exist THEN
               pb_exception_raised := TRUE;
            END IF;

            WHILE cu_premium_group%FOUND
            AND (NOT lb_pup_record_exists
            OR   NOT lb_live_record_exists) LOOP

                IF  lr_premium_group.stabil = 30 THEN
                    lb_live_record_exists      := TRUE;

                    IF lr_premium_group.enddte > pn_previous_renewal_date THEN
                        lb_contribution_found := TRUE;
                    END IF;

                ELSIF lr_premium_group.stabil = 60 THEN
                    lb_pup_record_exists := TRUE;
                END IF;

                FETCH cu_premium_group INTO lr_premium_group;

            END LOOP;

            CLOSE cu_premium_group;

            IF pb_contributions_exist
            AND ((pv_pup_indicator = 'N' AND NOT lb_live_record_exists)
            OR   (pv_pup_indicator = 'Y' AND (NOT lb_pup_record_exists OR lb_live_record_exists))) THEN
                pb_exception_raised := TRUE;
            ELSIF pv_pup_indicator = 'N'
            AND ((pb_contributions_exist AND NOT lb_contribution_found)
            OR   (NOT pb_contributions_exist AND lb_contribution_found)) THEN
                pb_exception_raised := TRUE;
            END IF;

            IF  pb_exception_raised
            AND NOT f_increment_on_renewal(pn_policy_number         -- don't raise exception
                                          ,pn_renewal_date          -- if there's been an
                                          ,pv_contributor) THEN     -- increment on renewal date
                pck_GPS_exceptions.p_raise_exception(766);
            END IF;

    END p_premium_group_check;

    -- procedure to check average premium against expected premium
    PROCEDURE p_premium_check(pn_policy_number         IN co040.polref%TYPE
                             ,pn_previous_renewal_date IN pa021.rnwdte%TYPE
                             ,pn_renewal_date          IN pa021.rnwdte%TYPE
                             ,pn_total_employee_cont   IN po030.totprm%TYPE
                             ,pn_total_employer_cont   IN po030.totprm%TYPE
                             ,pv_employee_frequency    IN co072.frq%TYPE
                             ,pv_employer_frequency    IN co072.frq%TYPE) IS

        ln_max_date    pa021.rnwdte%TYPE DEFAULT 0;
        lb_error_found BOOLEAN           DEFAULT FALSE;

        ln_employee_total event.trnamt2%TYPE := 0;
        ln_employer_total event.trnamt2%TYPE := 0;
        ln_max_ee_date    event.dte2%TYPE    := -99999;
        ln_max_er_date    event.dte2%TYPE    := -99999;

        ln_index    PLS_INTEGER;
        lb_ee_found BOOLEAN;
        lb_er_found BOOLEAN;

    BEGIN

        -- If we haven't got the premium events for this policy number, get them now
        IF lpn_policy_with_premiums != pn_policy_number THEN
            p_fetch_premiums(pn_policy_number
                            ,pn_previous_renewal_date
                            ,pn_renewal_date
                            );
        END IF;

        ln_index := 1;
        lb_ee_found := FALSE;
        lb_er_found := FALSE;
        -- Loop round and get the latest collection date and sum the amounts
        WHILE (NOT lb_ee_found        OR
               NOT lb_er_found)       AND
                   lpb_premiums_exist AND
                   ln_index <= lpr_premiums.COUNT LOOP

            -- Paid RVP/RP events only
            IF  lpr_premiums(ln_index).valid_status_in_dates = 1     AND -- dates fall within start and end dates
                lpr_premiums(ln_index).event_status          = 55    AND
                lpr_premiums(ln_index).event_increment       = 'RVP' AND
                lpr_premiums(ln_index).trntyp1               = 'RP'  THEN
                -- Employee money, if we haven't got it already
                IF lpr_premiums(ln_index).trnprmgrp = 'EE' AND
                   NOT lb_ee_found                         THEN
                    ln_employee_total := lpr_premiums(ln_index).sum_trnamt1;
                    IF lpr_premiums(ln_index).max_dte2 > ln_max_ee_date THEN
                        ln_max_ee_date := lpr_premiums(ln_index).max_dte2;
                    END IF;
                    -- Ensure that we only get it once
                    lb_ee_found := TRUE;
                -- Employer money, if we haven't got it already
                ELSIF lpr_premiums(ln_index).trnprmgrp = 'ER' AND
                      NOT lb_er_found THEN
                    ln_employer_total := lpr_premiums(ln_index).sum_trnamt1;
                    IF lpr_premiums(ln_index).max_dte2 > ln_max_er_date THEN
                       ln_max_er_date := lpr_premiums(ln_index).max_dte2;
                    END IF;
                    -- Ensure that we only get it once
                    lb_er_found := TRUE;
                END IF;
            END IF;
            ln_index := ln_index + 1;
        END LOOP;

        IF lb_er_found THEN
            ln_max_date := GREATEST(ln_max_er_date, ln_max_date);
        END IF;
        IF lb_ee_found THEN
            ln_max_date := GREATEST(ln_max_ee_date, ln_max_date);
        END IF;

        -- raise an error if there are more than 6 months since the renewal date
        -- as long as some premiums have been paid
        IF (pv_employee_frequency = 'M'
        OR  pv_employer_frequency = 'M')
        AND ADD_MONTHS(pck_utility.f_dtcnv(ln_max_date),6) <
                       pck_utility.f_dtcnv(pn_renewal_date)     THEN
            pck_GPS_exceptions.p_raise_exception(769);
        END IF;

        -- raise an error if it differs by 25% from that passed in
        IF  lb_ee_found
        AND ABS((pn_total_employee_cont - ln_employee_total)/pn_total_employee_cont) > 0.25 THEN
            lb_error_found := TRUE;
        END IF;
        IF  lb_er_found
        AND ABS((pn_total_employer_cont - ln_employer_total)/pn_total_employer_cont) > 0.25 THEN
            lb_error_found := TRUE;
        END IF;

        IF lb_error_found THEN
           pck_GPS_exceptions.p_raise_exception(770);
        END IF;

    EXCEPTION
        WHEN zero_divide THEN
            -- total contributions shouldn't be zero if there are ER/EE events, so this is an exception
            pck_GPS_exceptions.p_raise_exception(770);

    END p_premium_check;

    -- procedure to check all the increment level exceptions
    PROCEDURE p_increment_level_checks(pn_policy_number         IN co040.polref%TYPE
                                      ,pv_pup_indicator         IN VARCHAR2
                                      ,pn_previous_renewal_date IN pa021.rnwdte%TYPE
                                      ,pn_renewal_date          IN pa021.rnwdte%TYPE
                                      ,pn_default_policy        IN sc010.dflpolref%TYPE) IS

        lb_live_SCYRQ_record_found  BOOLEAN             DEFAULT FALSE;
        lb_RVP_exists               BOOLEAN             DEFAULT FALSE;
        lb_employee_conts_exist     BOOLEAN             DEFAULT FALSE;
        lb_employer_conts_exist     BOOLEAN             DEFAULT FALSE;
        lb_exception_raised         BOOLEAN;
        ln_total_employee_pct       NUMBER(7,3)         DEFAULT 0;
        ln_total_employer_pct       NUMBER(7,3)         DEFAULT 0;
        ln_total_employee_cont      po030.totprm%TYPE   DEFAULT 0;
        ln_total_employer_cont      po030.totprm%TYPE   DEFAULT 0;
        ln_actual_employee_cont     po030.totprm%TYPE   DEFAULT 0;
        ln_actual_employer_cont     po030.totprm%TYPE   DEFAULT 0;
        ln_latest_start_date        po030.crcdte%TYPE;
        ln_start_date               pa021.rnwdte%TYPE;
        lr_SCYRQ_details            lpcu_SCYRQ_details%ROWTYPE;
        lv_EE_premium_frequency     co072.frq%TYPE;
        lv_ER_premium_frequency     co072.frq%TYPE;
        lv_error_message            VARCHAR2(1803);

    BEGIN
        -- need to find details from last increment because lpcu_incr_and_decr_details cursor
        -- ignores increments with zero premiums.
        SELECT MAX(po030.crcdte)
        INTO ln_latest_start_date
        FROM po020
        JOIN (SELECT polref, inrtyp, inrref, crcdte, maint
              FROM po030
              UNION
              SELECT polref, inrtyp, inrref, crcdte, maint
              FROM hi030) po030
        ON  po020.polref = po030.polref
        AND po020.inrtyp = po030.inrtyp
        AND po020.inrref = po030.inrref
        WHERE po020.polref = pn_policy_number
        AND   po020.stainr = 30
        AND   po020.inrtyp = 'RVP'
        AND   po020.maint != 'D'
        AND   po030.maint != 'D'
        AND   po030.crcdte NOT IN (0, 99999, -99999)
        AND   po030.crcdte < pn_renewal_date;

        ln_start_date := GREATEST(pn_previous_renewal_date
                                 ,ln_latest_start_date);

        FOR lr_increments IN lpcu_incr_and_decr_details(pn_policy_number
                                                       ,pn_renewal_date) LOOP

            IF lr_increments.inrtyp = 'RVP' THEN

                lb_RVP_exists            := TRUE;

                ln_total_employee_cont   := ln_total_employee_cont + lr_increments.ee_cont;
                ln_total_employer_cont   := ln_total_employer_cont + lr_increments.er_cont;

                IF lr_increments.crcdte <= pn_previous_renewal_date THEN
                    ln_actual_employee_cont   := ln_actual_employee_cont + lr_increments.ee_cont;
                    ln_actual_employer_cont   := ln_actual_employer_cont + lr_increments.er_cont;
                ELSE
                    ln_actual_employee_cont   := ln_actual_employee_cont
                                                 + ((pn_renewal_date - lr_increments.crcdte)
                                                   / (pn_renewal_date - pn_previous_renewal_date)
                                                   * lr_increments.ee_cont);
                    ln_actual_employer_cont   := ln_actual_employer_cont
                                                 + ((pn_renewal_date - lr_increments.crcdte)
                                                   / (pn_renewal_date - pn_previous_renewal_date)
                                                   * lr_increments.er_cont);
                END IF;

                IF  pv_pup_indicator     = 'N'
                AND lr_increments.bentyp = 'INV' THEN

                    p_SCYRQ_check(pn_policy_number
                                 ,lr_increments
                                 ,ln_start_date
                                 ,pn_renewal_date
                                 ,lb_live_SCYRQ_record_found        -- out parameter
                                 ,lr_SCYRQ_details);                -- out parameter

                    IF lb_live_SCYRQ_record_found THEN

                        ln_total_employee_pct := ln_total_employee_pct + lr_SCYRQ_details.emppympct;
                        ln_total_employer_pct := ln_total_employer_pct + lr_SCYRQ_details.emrpympct;

                    END IF;

                    p_CCINQ_check(pn_policy_number
                                 ,lr_increments.inrtyp
                                 ,lr_increments.inrref);

                END IF;

            END IF;

            IF lr_increments.bentyp IN ('INV','INVPR') THEN

                p_overcoded_commission_check(pn_policy_number
                                            ,lr_increments.inrtyp
                                            ,lr_increments.inrref
                                            ,pn_default_policy);

            END IF;

        END LOOP;

        IF ln_total_employee_cont > 0 THEN
            lb_employee_conts_exist := TRUE;
        END IF;

        IF ln_total_employer_cont > 0 THEN
            lb_employer_conts_exist := TRUE;
        END IF;

        /* allocation percentages check needs to look over all increments/decrements but only if a
           live SCYRQ record exists */
        IF  lb_live_SCYRQ_record_found
        AND (ln_total_employee_pct <> 100
        OR   ln_total_employer_pct <> 100) THEN
            lv_error_message := 'Policy: '||pn_policy_number||'~'||
                                 'EE% Total: '||ln_total_employee_pct||'~'||
                                 'ER% Total: '||ln_total_employer_pct;

            pck_GPS_exceptions.p_raise_exception(749                -- exception number
                                                ,lv_error_message);
        END IF;

        IF lb_RVP_exists THEN

            p_RVP_investment_check(pn_policy_number
                                  ,pv_pup_indicator);

            p_premium_group_check(pn_policy_number
                                 ,pv_pup_indicator
                                 ,'EE'                      -- employee's contributions
                                 ,lb_employee_conts_exist
                                 ,pn_previous_renewal_date
                                 ,pn_renewal_date
                                 ,lb_exception_raised       -- out parameter
                                 ,lv_EE_premium_frequency); -- out parameter

            IF NOT lb_exception_raised THEN
                p_premium_group_check(pn_policy_number
                                     ,pv_pup_indicator
                                     ,'ER'                      -- employer's contributions
                                     ,lb_employer_conts_exist
                                     ,pn_previous_renewal_date
                                     ,pn_renewal_date
                                     ,lb_exception_raised       -- out parameter
                                     ,lv_ER_premium_frequency); -- out parameter
            END IF;

            IF  pv_pup_indicator = 'N' THEN

                p_redirection_check(pn_policy_number
                                   ,pn_previous_renewal_date
                                   ,pn_renewal_date
                                   ,'GPS');


                p_premium_check(pn_policy_number
                               ,pn_previous_renewal_date
                               ,pn_renewal_date
                               ,ln_actual_employee_cont
                               ,ln_actual_employer_cont
                               ,lv_EE_premium_frequency
                               ,lv_ER_premium_frequency);
            END IF;

        END IF;

    END p_increment_level_checks;

    -- procedure to check if there are any HMA's for the policy
    PROCEDURE p_HMA_check(pn_policy_number IN co040.polref%TYPE
                         ,pv_product_type  IN VARCHAR2) IS

        CURSOR cu_HMA_notes(pcv_memo_type IN cl660.memtyp%TYPE) IS
            SELECT cl660.msgunq
				  ,cl660.memttl
			FROM   cl670
			JOIN   cl660
			ON     cl670.msgunq = cl660.msgunq
			JOIN   po010
			ON     po010.polref = cl670.polref
			WHERE  cl670.polref = pn_policy_number
			AND    cl660.memsta = 30
			AND    cl660.memtyp = pcv_memo_type
			AND    po010.stapol IN (30,52);

        lv_error_message    VARCHAR2(1803);

    BEGIN
        FOR lr_HMA_details IN cu_HMA_notes('NOTE') LOOP

            lv_error_message := 'HMA Number: '||lr_HMA_details.msgunq||'~'||
                                'HMA Details: '||lr_HMA_details.memttl;

            p_raise_exception(pn_policy_number
                             ,709
                             ,lv_error_message
                             ,pv_product_type
                             );
        END LOOP;

        IF pv_product_type <> 'GPS' THEN
            FOR lr_HMA_details IN cu_HMA_notes('INFO') LOOP

                lv_error_message := 'HMA Number: '||lr_HMA_details.msgunq||'~'||
                                    'HMA Details: '||lr_HMA_details.memttl;

                p_raise_exception(pn_policy_number
                                 ,786
                                 ,lv_error_message
                                 ,pv_product_type
                                 );
            END LOOP;
        END IF;
    END p_HMA_check;

    -- procedure to check if there are any HMA's for the policy
    PROCEDURE p_HMA_client_check(pn_policy_number    IN po010.polref%TYPE
                                ,pv_client_category  IN co040.clicat%TYPE
                                ,pn_client_reference IN co040.cliref%TYPE
                                ,pv_product_type     IN VARCHAR2) IS

        CURSOR cu_HMA_notes(pcv_memo_type IN cl660.memtyp%TYPE) IS
            SELECT cl660.msgunq
                  ,cl660.memttl
            FROM cl670
            JOIN cl660
            ON cl670.msgunq = cl660.msgunq
            WHERE cl670.clicat = pv_client_category
            AND   cl670.cliref = pn_client_reference
            AND   cl660.memsta = 30
            AND   cl660.memtyp = pcv_memo_type;

        lv_error_message    VARCHAR2(1803);

    BEGIN
        FOR lr_HMA_details IN cu_HMA_notes('NOTE') LOOP

            lv_error_message := 'HMA Number: '||lr_HMA_details.msgunq||'~'||
                                'HMA Details: '||lr_HMA_details.memttl;

            p_raise_exception(pn_policy_number
                             ,709
                             ,lv_error_message
                             ,pv_product_type
                             );
        END LOOP;

        FOR lr_HMA_details IN cu_HMA_notes('INFO') LOOP

            lv_error_message := 'HMA Number: '||lr_HMA_details.msgunq||'~'||
                                'HMA Details: '||lr_HMA_details.memttl;

            p_raise_exception(pn_policy_number
                             ,786
                             ,lv_error_message
                             ,pv_product_type
                             );
        END LOOP;
    END p_HMA_client_check;

    -- procedure to check if there are any HMA's for the policy
    PROCEDURE p_HMA_check(pn_policy_number     IN po010.polref%TYPE
                          ,pv_client_category  IN co040.clicat%TYPE
                          ,pn_client_reference IN co040.cliref%TYPE
                          ,pv_memo_type        IN cl660.memtyp%TYPE
                          ,pv_product_type     IN VARCHAR2) IS

        CURSOR cu_HMA_details IS
            SELECT cl660.msgunq
                  ,cl660.memttl
            FROM cl670
            JOIN cl660
            ON cl670.msgunq = cl660.msgunq
            WHERE ((cl670.clicat = pv_client_category
            AND   cl670.cliref = pn_client_reference)
            OR    cl670.polref = pn_policy_number)
            AND   cl660.memsta = 30
            AND   cl660.memtyp = pv_memo_type;

        lv_error_message    VARCHAR2(1803);

    BEGIN
        FOR lr_HMA_details IN cu_HMA_details LOOP
            lv_error_message := 'HMA Number: '||lr_HMA_details.msgunq||'~'||
                                'HMA Details: '||lr_HMA_details.memttl;

            IF pv_memo_type = 'NOTE' THEN
                p_raise_exception(pn_policy_number
                                 ,709
                                 ,lv_error_message
                                 ,pv_product_type
                                 );
            ELSE
                p_raise_exception(pn_policy_number
                                 ,786
                                 ,lv_error_message
                                 ,pv_product_type
                                 );
            END IF;
        END LOOP;

    END p_HMA_check;

    -- procedure to check PYMPL for unallocated monies
    PROCEDURE p_unallocated_monies_check(pn_policy_number         IN co040.polref%TYPE
                                        ,pv_scheme_category       IN sc010.schcat%TYPE
                                        ,pn_scheme_ref            IN sc010.schref%TYPE
                                        ,pv_employer_category     IN cl300.clicat2%TYPE
                                        ,pn_employer_ref          IN cl300.cliref2%TYPE
                                        ,pn_previous_renewal_date IN pa021.rnwdte%TYPE
                                        ,pn_renewal_date          IN pa021.rnwdte%TYPE
                                        ,pv_product_type          IN pr010.prdref%TYPE) IS

        CURSOR cu_event_details IS
            SELECT event.clicat
                  ,event.cliref
                  ,event.trnbilgrp
                  ,event.trnamt1
                  ,pck_utility.f_dtcnv(event.dte1) received_date
                  ,CASE event.dte2
                       WHEN -99999 THEN NULL
                       ELSE pck_utility.f_dtcnv(event.dte2)
                   END due_date
                  ,event.trntyp1
                  ,fi600.cshextdat1
            FROM            event
            LEFT OUTER JOIN fi600
            ON  event.unq    = fi600.extunq
            AND event.tranno = fi600.exttrn_no
            WHERE polref  =  pn_policy_number
            AND   clicat  <> pv_scheme_category
            AND   cliref  <> pn_scheme_ref
            AND   clicat  <> pv_employer_category
            AND   cliref  <> pn_employer_ref
            AND   trntyp2 <> 'NP'               -- is not a non-payment
            AND   staevt  IN (28,32)            -- prematched or unmatched
            AND   dte1 BETWEEN pn_previous_renewal_date AND pn_renewal_date-1;

        lv_error_message    VARCHAR2(1803);

    BEGIN
        FOR lr_event_details IN cu_event_details LOOP

            lv_error_message := 'Client: '||lr_event_details.clicat||'/'||
                                            lr_event_details.cliref||'/'||
                                            lr_event_details.trnbilgrp||'~'||
                                'Policy: '||pn_policy_number||'~'||
                                'Gross amount: £'||LTRIM(TO_CHAR(lr_event_details.trnamt1,'9999999990D99'))||'~'||
                                'Date received: '||lr_event_details.received_date||'~'||
                                'Due date: '||lr_event_details.due_date||'~'||
                                'Payment type: '||lr_event_details.trntyp1||'~'||
                                'Reason: '||lr_event_details.cshextdat1;

            p_raise_exception(pn_policy_number    => pn_policy_number
                             ,pn_exception_number => 705
                             ,pv_error_message    => lv_error_message
                             ,pv_product_type     => pv_product_type
                             );

        END LOOP;

    END p_unallocated_monies_check;

    -- procedure to check PYMIN for unallocated monies at client level (with no policy on it)
    PROCEDURE p_client_unallocated_monies(pn_policy_number         IN po010.polref%TYPE
                                         ,pv_client_category       IN co040.clicat%TYPE
                                         ,pn_client_ref            IN co040.cliref%TYPE
                                         ,pn_previous_renewal_date IN pa021.rnwdte%TYPE
                                         ,pn_renewal_date          IN pa021.rnwdte%TYPE
                                         ,pv_product_type          IN pr010.prdref%TYPE) IS

        CURSOR cu_event_details IS
            SELECT event.clicat
                  ,event.cliref
                  ,event.trnbilgrp
                  ,event.trnamt1
                  ,pck_utility.f_dtcnv(event.dte1) received_date
                  ,CASE event.dte2
                       WHEN -99999 THEN NULL
                       ELSE pck_utility.f_dtcnv(event.dte2)
                   END due_date
                  ,event.trntyp1
                  ,fi600.cshextdat1
            FROM            event
            LEFT OUTER JOIN fi600
            ON  event.unq    = fi600.extunq
            AND event.tranno = fi600.exttrn_no
            WHERE polref = 0
            AND   clicat  = pv_client_category
            AND   cliref  = pn_client_ref
            AND   trntyp2 <> 'NP'               -- is not a non-payment
            AND   staevt  IN (28,32)            -- prematched or unmatched
            AND   dte1 BETWEEN pn_previous_renewal_date AND pn_renewal_date-1;

        lv_error_message    VARCHAR2(1803);

    BEGIN
        FOR lr_event_details IN cu_event_details LOOP

            lv_error_message := 'Client: '||lr_event_details.clicat||'/'||
                                            lr_event_details.cliref||'/'||
                                            lr_event_details.trnbilgrp||'~'||
                                'Policy: '||'0'||'~'||
                                'Gross amount: £'||LTRIM(TO_CHAR(lr_event_details.trnamt1,'9999999990D99'))||'~'||
                                'Date received: '||lr_event_details.received_date||'~'||
                                'Due date: '||lr_event_details.due_date||'~'||
                                'Payment type: '||lr_event_details.trntyp1||'~'||
                                'Reason: '||lr_event_details.cshextdat1;

            p_raise_exception(pn_policy_number    => pn_policy_number
                             ,pn_exception_number => 705
                             ,pv_error_message    => lv_error_message
                             ,pv_product_type     => pv_product_type
                             );
        END LOOP;

    END p_client_unallocated_monies;

    -- procedure to check DSSRC for any unallocated DSS monies for the policyholder
    PROCEDURE p_unallocated_DSS_monies_check(pn_policy_number         IN co040.polref%TYPE
                                            ,pv_national_insurance_no IN cl010.natinr_no%TYPE
                                            ,pv_product_type          IN pr010.prdref%TYPE) IS

        CURSOR cu_event_details IS
            SELECT fi600.clishtnam
                  ,pck_utility.f_dtcnv(event.dte1) received_date
                  ,pck_utility.f_dtcnv(event.dte2) tax_year
                  ,trnamt1
                  ,trntyp1
                  ,staevt
            FROM event
            JOIN fi600
            ON  event.unq    = fi600.extunq
            AND event.tranno = fi600.exttrn_no
            WHERE event.cliref      = LPCN_DSS_OPR_REF
            AND   event.clicat      = 'OPR'
            AND   fi600.maint      <> 'D'
            AND   event.staevt     IN (28, 45)               -- prematched or recovery
            AND   (fi600.qtepolref  = pn_policy_number
            OR     (fi600.qtenatinr = pv_national_insurance_no
            AND     pv_national_insurance_no <> ' '));

        lv_error_message    VARCHAR2(1803);
        ln_exception_number ge110.rsncde%TYPE;

    BEGIN
        FOR lr_event_details IN cu_event_details LOOP

            lv_error_message := 'Name: '||lr_event_details.clishtnam||','||
                                          pn_policy_number||','||
                                          pv_national_insurance_no||'~'||
                                'Date received: '||lr_event_details.received_date||'~'||
                                'Tax year: '||lr_event_details.tax_year||'~'||
                                'Payment amount: £'||LTRIM(TO_CHAR(lr_event_details.trnamt1,'9999999990D99'))||'~'||
                                'Payment type: '||lr_event_details.trntyp1;

            IF pv_product_type != 'GPS' THEN
                lv_error_message := lv_error_message||'~'||
                                    'Client : OPR '||LPCN_DSS_OPR_REF;
            END IF;

            IF lr_event_details.staevt = 28 THEN
                ln_exception_number := 708;
            ELSE
                ln_exception_number := 774;
            END IF;

            p_raise_exception(pn_policy_number
                             ,ln_exception_number
                             ,lv_error_message
                             ,pv_product_type
                             );

        END LOOP;

    END p_unallocated_DSS_monies_check;

    -- procedure to check unallocated DSS, Journal entry and Non-payment debits as shown on DBTIQ
    PROCEDURE p_unallocated_debits(pn_policy_number         IN po010.polref%TYPE
                                  ,pv_national_insurance_no IN cl010.natinr_no%TYPE
                                  ,pv_client_category       IN co040.clicat%TYPE
                                  ,pn_client_ref            IN co040.cliref%TYPE
                                  ,pn_previous_renewal_date IN pa021.rnwdte%TYPE
                                  ,pn_renewal_date          IN pa021.rnwdte%TYPE
                                  ,pv_product_type          IN pr010.prdref%TYPE) IS

        CURSOR cu_DBTIQ_details IS
            SELECT event.clicat
                  ,event.cliref
                  ,event.trnbilgrp
                  ,event.trnamt1
                  ,pck_utility.f_dtcnv(event.dte1) received_date
                  ,CASE event.dte2
                       WHEN -99999 THEN NULL
                       ELSE pck_utility.f_dtcnv(event.dte2)
                   END due_date
                  ,CASE event.dte2
                       WHEN -99999 THEN NULL
                       ELSE to_char(pck_utility.f_dtcnv(event.dte2),'DD/MM')
                   END due_month
                  ,event.trntyp1
                  ,event.trntyp2
                 ,fi600.clishtnam
                 ,event.polref
            FROM            event
            LEFT OUTER JOIN fi600
            ON  event.unq    = fi600.extunq
            AND event.tranno = fi600.exttrn_no
            WHERE (polref = pn_policy_number
                  OR (clicat  = pv_client_category AND cliref  = pn_client_ref))
            AND ((trntyp2 IN ('DSS','JE') AND staevt = 45)  -- is either an unmatched journal entry or DSS
                  OR (trntyp2 = 'NP' AND staevt = 28))      -- or an unmatched non payment
            AND   trnind4 = 1
            AND   dte1 BETWEEN pn_previous_renewal_date AND pn_renewal_date-1;

        lv_error_message    VARCHAR2(1803);
        ln_exception_number ge110.rsncde%TYPE;

    BEGIN
        FOR lr_DBTIQ_details IN cu_DBTIQ_details LOOP

             IF lr_DBTIQ_details.trntyp2 = 'NP' THEN
                ln_exception_number := 785;

                lv_error_message := 'Client: '||lr_DBTIQ_details.clicat||'/'||
                                            lr_DBTIQ_details.cliref||'~'||
                                    'Payment amount: £'||LTRIM(TO_CHAR(lr_DBTIQ_details.trnamt1,'9999999990D99'))||'~'||
                                    'Due Month :'||lr_DBTIQ_details.due_month||'~'||
                                    'Bill Group: '||lr_DBTIQ_details.trnbilgrp||'~'||
                                    'Date: '||lr_DBTIQ_details.due_date;

            ELSIF lr_DBTIQ_details.trntyp2 = 'JE' THEN
                ln_exception_number := 784;

                lv_error_message := 'Client: '||lr_DBTIQ_details.clicat||'/'||
                                                lr_DBTIQ_details.cliref||'~'||
                                    'Policy: '||lr_DBTIQ_details.polref||'~'||
                                    'Amount: £'||LTRIM(TO_CHAR(lr_DBTIQ_details.trnamt1,'9999999990D99'))||'~'||
                                    'Date: '||lr_DBTIQ_details.due_date;
            ELSE
                ln_exception_number := 774;

                lv_error_message := 'Name: '||lr_DBTIQ_details.clishtnam||'~'||
                                    'Policy: '||pn_policy_number||'~'||
                                    'Client: '||lr_DBTIQ_details.clicat||'/'||
                                                lr_DBTIQ_details.cliref||'~'||
                                     'NI No :'||pv_national_insurance_no||'~'||
                                    'Date received: '||lr_DBTIQ_details.received_date||'~'||
                                    'Tax year: '||lr_DBTIQ_details.due_date||'~'||
                                    'Payment amount: £'||LTRIM(TO_CHAR(lr_DBTIQ_details.trnamt1,'9999999990D99'))||'~'||
                                    'Payment type: '||lr_DBTIQ_details.trntyp1;
            END IF;

            p_raise_exception(pn_policy_number    => pn_policy_number
                             ,pn_exception_number => ln_exception_number
                             ,pv_error_message    => lv_error_message
                             ,pv_product_type     => pv_product_type
                             );
        END LOOP;
    END p_unallocated_debits;

    -- procedure to check whether policyholder has a temporary national insurance number
    PROCEDURE p_temp_NI_check(pn_policy_number         IN po010.polref%TYPE
                             ,pv_national_insurance_no IN cl010.natinr_no%TYPE
                             ,pv_product_type          IN pr010.prdref%TYPE
                             ,pn_birth_date            IN cl010.bthdte%TYPE) IS

        lv_error_message              VARCHAR2(1803);
        ln_16_year_date               cl010.bthdte%TYPE;
        lv_elegibilty_ind             po010.qlyprm%TYPE;

    BEGIN

        SELECT qlyprm
        INTO lv_elegibilty_ind
        FROM po010
        WHERE polref = pn_policy_number;

        ln_16_year_date := pck_utility.f_dtcnv(ADD_MONTHS(pck_utility.f_dtcnv(lpn_system_date), -192));

        IF (NOT pck_nino_validation.f_valid(pv_ni_number => pv_national_insurance_no) OR
            pv_national_insurance_no      =  'AB123456C'     OR
            pv_national_insurance_no    LIKE ('%000000%')    OR
            pv_national_insurance_no    LIKE ('%111111%')    OR
            pv_national_insurance_no    LIKE ('%222222%')    OR
            pv_national_insurance_no    LIKE ('%333333%')    OR
            pv_national_insurance_no    LIKE ('%444444%')    OR
            pv_national_insurance_no    LIKE ('%555555%')    OR
            pv_national_insurance_no    LIKE ('%666666%')    OR
            pv_national_insurance_no    LIKE ('%777777%')    OR
            pv_national_insurance_no    LIKE ('%888888%')    OR
            pv_national_insurance_no    LIKE ('%999999%')    OR
            (pv_national_insurance_no     =  'YY999999Y'     AND
            pn_birth_date                 <  ln_16_year_date))
        THEN
            IF pv_product_type <> 'GPS' THEN
                lv_error_message := 'NI Number: '||pv_national_insurance_no ||
                                    '~Elegibility Indicator : '||lv_elegibilty_ind;
            END IF;

            p_raise_exception(pn_policy_number
                             ,710
                             ,lv_error_message
                             ,pv_product_type
                             );
        END IF;

    END p_temp_NI_check;

    -- procedure to check whether live and pup'd cases have passed retirement age
    PROCEDURE p_retirement_age_check(pn_policy_number     IN co040.polref%TYPE
                                    ,pv_product_type      IN pr010.prdref%TYPE
                                    ,pv_create_LV_trigger IN VARCHAR2 DEFAULT 'N') IS

        CURSOR cu_retirement_date (pcn_policy_number IN co040.polref%TYPE) IS
            SELECT matdte
                  ,benage
                  ,CASE
                       WHEN first_right_type != second_right_TYPE THEN
                           'B'
                       ELSE
                           second_right_TYPE
                   END AS right_type
            FROM (SELECT matdte
                        ,benage
                        ,first_value(DECODE(rhttyp, ' ', 'A', rhttyp)) OVER(ORDER BY inrtyp DESC) AS first_right_TYPE
                        ,last_value(DECODE(rhttyp, ' ', 'A', rhttyp)) OVER(ORDER BY inrtyp) AS second_right_TYPE
                        ,row_number() over (PARTITION BY DECODE(rhttyp,' ','A',rhttyp) ORDER BY inrtyp, inrref, bentyp, benref) rnum
                  FROM po030
                  WHERE polref  = pcn_policy_number
                  AND   maint  != 'D'
                  AND   staben <= 30
                  AND   staben != 29
                  AND   benage < 75
                  AND   bentyp NOT IN ('WVR','GLA','GIP','LTD','STD','STDU')
                  AND   extmod NOT IN (1,51,52,41,42)
                  AND   matdte NOT IN (-99999,99999,0))
            WHERE rnum = 1
            ORDER BY matdte;

        CURSOR cu_birth_date (pcn_policy_number IN co040.polref%TYPE) IS
            SELECT cli.bthdte
                  ,cli.cliref
            FROM cl010 cli
            JOIN co040 xref ON  xref.cliref = cli.cliref
                            AND xref.clicat = cli.clicat
                            AND xref.rolref = 'PL'
                            AND xref.staxrf = 30
                            AND xref.maint  <> 'D'
            WHERE    xref.polref = pcn_policy_number
            AND        cli.stacli = 30
            AND        cli.maint <> 'D';

        ln_retirement_date   po030.matdte%TYPE;
        ln_sra               po030.benage%TYPE;
        ln_birth_date        cl010.bthdte%TYPE;
        lv_error_message     VARCHAR2(1803);
        lv_right_type        po030.rhttyp%TYPE;
        ln_client_reference  co040.cliref%TYPE;

    BEGIN
        OPEN cu_retirement_date(pn_policy_number);
        FETCH cu_retirement_date INTO ln_retirement_date, ln_sra, lv_right_type;
        CLOSE cu_retirement_date;

        IF ln_retirement_date < lpn_system_date THEN
            OPEN    cu_birth_date(pn_policy_number);
            FETCH    cu_birth_date INTO ln_birth_date, ln_client_reference;
            CLOSE    cu_birth_date;
            IF pv_product_type = 'GPS' THEN
                lv_error_message := 'LV trigger has been added so check if SRD has updated and reprocess exceptions';
            ELSE
                lv_error_message := 'DOB: '||TO_DATE(TO_CHAR(ln_birth_date + 2415021),'J')||'~'||
                                    'SRA: '||ln_sra||'~'||
                                    'Retirement Date: '||TO_DATE(TO_CHAR(ln_retirement_date + 2415021),'J');
            END IF;
            p_raise_exception(pn_policy_number
                             ,772
                             ,lv_error_message
                             ,pv_product_type
                             );

            -- Creates Late Vesting(LV) trigger in PA020
            IF pv_create_LV_trigger = 'Y' THEN
                pck_renewals_processing.p_create_LV_trigger(pn_retirement_date  => ln_retirement_date
                                                           ,pn_policy_reference => pn_policy_number
                                                           ,pv_right_type       => lv_right_type
                                                           ,pn_client_reference => ln_client_reference);
            END IF;
        END IF;

    END p_retirement_age_check;

    -- procedure to check that all live CCINQ records relate to a live ITR for GPS
    PROCEDURE p_CCINQ_ITR_check(pn_policy_number IN co040.polref%TYPE
                               ,pn_renewal_date  IN pa022.rnwdte%TYPE) IS

        CURSOR cu_ITR_details IS
            SELECT DISTINCT co060.inrtyp
                           ,co060.inrref
                           ,pck_utility.f_dtcnv(co060.strdte) start_date
                           ,co060.itr_no
                           ,cl090.itrsta
                           ,cl090.enddte
                           ,NVL(data_description.itevalnam,'Unknown') status
            FROM co060
            JOIN cl090
            ON co060.itr_no = cl090.itr_no
            LEFT OUTER JOIN (SELECT itevalnam
                                   ,datiteval
                             FROM cs060
                             WHERE ispgrpnam =  'ITR'
                             AND   datitenam =  'STA'
                             AND   maint     <> 'D') data_description
            ON cl090.itrsta = data_description.datiteval
            WHERE co060.polref    = pn_policy_number
            AND   co060.sta       = 30
            AND   co060.csnrcdtyp = 10
            AND   co060.csntyp   != 'N'
            AND  (co060.csntyp   != 'R'
            OR    co060.enddte   >= pn_renewal_date)
            AND   co060.maint    != 'D'
            AND   cl090.mnt      != 'D'
            AND   cl090.enddte    = (SELECT MAX(enddte)
                                     FROM cl090
                                     WHERE itr_no = co060.itr_no
                                     AND   mnt   != 'D');

        lb_exception_found          BOOLEAN;
        lv_error_message            VARCHAR2(1803);
        lv_ITR_status               cs060.itevalnam%TYPE;

    BEGIN
        FOR lr_ITR_details IN cu_ITR_details LOOP

            lb_exception_found := FALSE;        -- reset at start of each loop

            IF lr_ITR_details.itrsta <> 30 THEN

                lb_exception_found := TRUE;
                lv_ITR_status      := lr_ITR_details.status;

            ELSIF lr_ITR_details.enddte <  lpn_system_date THEN

                lb_exception_found := TRUE;
                lv_ITR_status      := 'SUPERSEDED';

            END IF;

            IF lb_exception_found THEN
                lv_error_message := 'Increment type: '||lr_ITR_details.inrtyp||'~'||
                                    'Increment ref: '||lr_ITR_details.inrref||'~'||
                                    'Start date: '||lr_ITR_details.start_date||'~'||
                                    'ITR number: '||lr_ITR_details.itr_no||'~'||
                                    'ITR status: '||lv_ITR_status;

                pck_GPS_exceptions.p_raise_exception(756                -- exception number
                                                    ,lv_error_message);
            END IF;

        END LOOP;

    END p_CCINQ_ITR_check;

    -- procedure to check that all live CCINQ records relate to a live ITR for individual
    PROCEDURE p_ind_CCINQ_ITR_check(pn_policy_number         IN co040.polref%TYPE
                                   ,pn_renewal_date          IN pa022.rnwdte%TYPE
                                   ,pv_product_type          IN pr010.prdref%TYPE
                                   ,pb_FBRC_check_only       IN BOOLEAN) IS

        CURSOR cu_ITR_details IS
            SELECT DISTINCT co060.inrtyp
                           ,co060.inrref
                           ,co060.strdte
                           ,co060.enddte CCINQ_enddte
                           ,co060.itr_no
                           ,cl090.itrsta
                           ,cl090.enddte
                           ,NVL(data_description.itevalnam,'Unknown') status
                           ,co060.csnrcdtyp
                           ,NVL(data_description2.itevalnam,'Unknown') commission_type
            FROM co060
            JOIN cl090
            ON co060.itr_no = cl090.itr_no
            LEFT OUTER JOIN (SELECT itevalnam
                                   ,datiteval
                             FROM cs060
                             WHERE ispgrpnam =  'ITR'
                             AND   datitenam =  'STA'
                             AND   maint     <> 'D') data_description
            ON cl090.itrsta = data_description.datiteval
            LEFT OUTER JOIN (SELECT itevalnam
                                   ,datiteval
                             FROM cs060
                             WHERE ispgrpnam =  'CSN'
                             AND   datitenam =  'CSNRCDTYP'
                             AND   maint     <> 'D') data_description2
            ON co060.csnrcdtyp = data_description2.datiteval
            WHERE co060.polref    = pn_policy_number
            AND   co060.sta       = 30
            AND   co060.csnrcdtyp IN (10,60)
            AND   co060.csntyp   != 'N'
            AND   co060.enddte   >= pn_renewal_date
            AND   co060.maint    != 'D'
            AND   cl090.mnt      != 'D'
            AND   co060.inrtyp   != 'PPC'
            AND   cl090.enddte    = (SELECT MAX(enddte)
                                     FROM cl090
                                     WHERE itr_no = co060.itr_no
                                     AND   mnt   != 'D');

        lb_exception_found          BOOLEAN;
        lv_error_message            VARCHAR2(1803);
        lv_ITR_status               cs060.itevalnam%TYPE;
        ld_end_date                 DATE;

    BEGIN
        FOR lr_ITR_details IN cu_ITR_details LOOP

            CASE
                WHEN pb_FBRC_check_only
                AND  lr_ITR_details.csnrcdtyp <> 60 THEN

                    lb_exception_found := FALSE;

                WHEN lr_ITR_details.itrsta <> 30 THEN

                    lb_exception_found := TRUE;
                    lv_ITR_status      := lr_ITR_details.status;

                WHEN lr_ITR_details.enddte <  lpn_system_date THEN

                    lb_exception_found := TRUE;
                    lv_ITR_status      := 'SUPERSEDED';

                ELSE
                    lb_exception_found := FALSE;

            END CASE;

            IF lb_exception_found THEN
                CASE lr_ITR_details.CCINQ_enddte
                    WHEN 99999 THEN
                        ld_end_date := NULL;
                    ELSE
                        ld_end_date := pck_utility.f_dtcnv(lr_ITR_details.CCINQ_enddte);
                END CASE;

                lv_error_message := 'Increment type: '||lr_ITR_details.inrtyp||'~'||
                                    'Increment ref: '||lr_ITR_details.inrref||'~'||
                                    'Start date: '||pck_utility.f_dtcnv(lr_ITR_details.strdte)||'~'||
                                    'End date:  '||ld_end_date||'~'||
                                    'Commission Type: '||lr_ITR_details.commission_type||'~'||
                                    'ITR number: '||lr_ITR_details.itr_no||'~'||
                                    'ITR status: '||lv_ITR_status;

                p_raise_exception(pn_policy_number
                                 ,756
                                 ,lv_error_message
                                 ,pv_product_type
                                 );
            END IF;

        END LOOP;

    END p_ind_CCINQ_ITR_check;

    -- procedure to check whether there are any ACTPL error activities for a policy
    PROCEDURE p_ACTPL_error_check(pn_policy_number IN co040.polref%TYPE
                                 ,pv_product_type  IN pr010.prdref%TYPE
                                 ,pv_activity      IN po100.actref%TYPE DEFAULT NULL) IS

        lv_error_message    VARCHAR2(1803);
        ln_exception_number ge110.rsncde%TYPE;

    BEGIN

        IF lpn_policy_ACTPL != pn_policy_number THEN
            p_fetch_ACTPL(pn_policy_number);
        END IF;

        IF lpb_ACTPL_exist THEN
            -- Loop through activities
            FOR a IN lpr_ACTPL_errors.FIRST..lpr_ACTPL_errors.LAST LOOP

                IF pv_activity IS NULL                      OR
                   pv_activity = lpr_ACTPL_errors(a).actref THEN

                    IF pv_product_type = 'GPS' THEN
                        lv_error_message := SUBSTR(lpr_ACTPL_errors(a).actpar,1,75);
                    ELSE
                        lv_error_message := 'Activity Date: '||pck_utility.f_dtcnv(lpr_ACTPL_errors(a).actdte)||'~'||
                                            'Activities Parameter: '||lpr_ACTPL_errors(a).actpar||'~'||
                                            'Audit: '||lpr_ACTPL_errors(a).audaplcde||lpr_ACTPL_errors(a).audstf_no||' '||
                                                          pck_utility.f_dtcnv(lpr_ACTPL_errors(a).audupddte);
                    END IF;
                    -- Set up exception based on Activity ref
                    CASE
                        WHEN lpr_ACTPL_errors(a).actref = 'ALC ERR' THEN
                            ln_exception_number := 723;
                        WHEN lpr_ACTPL_errors(a).actref = 'DEALC ERR' THEN
                            ln_exception_number := 724;
                        WHEN lpr_ACTPL_errors(a).actref = 'CSN ERR' THEN
                            ln_exception_number := 725;
                        WHEN lpr_ACTPL_errors(a).actref = 'SW ERR' THEN
                            ln_exception_number := 726;
                        WHEN lpr_ACTPL_errors(a).actref = 'UNW ERR' THEN
                            ln_exception_number := 727;
                        WHEN lpr_ACTPL_errors(a).actref = 'RDT ERR' THEN
                            ln_exception_number := 730;
                        WHEN lpr_ACTPL_errors(a).actref = 'BON ERR' THEN
                            ln_exception_number := 758;
                        WHEN lpr_ACTPL_errors(a).actref = 'CRG ERR' THEN
                            ln_exception_number := 736;
                        WHEN lpr_ACTPL_errors(a).actref = 'FORAC ERR'
                        AND  pv_product_type           != 'GPS'     THEN
                            ln_exception_number := 775;
                        WHEN lpr_ACTPL_errors(a).actref = 'FORWB ERR'
                        AND  pv_product_type           != 'GPS'     THEN
                            ln_exception_number := 776;
                        WHEN lpr_ACTPL_errors(a).actref = 'EXTFNDERR'
                        AND  pv_product_type           != 'GPS'     THEN
                            ln_exception_number := 731;
                        WHEN lpr_ACTPL_errors(a).actref = 'VSTFNDERR'
                        AND  pv_product_type           != 'GPS'     THEN
                            ln_exception_number := 732;
                        WHEN lpr_ACTPL_errors(a).actref = 'TFC ERR'
                        AND  pv_product_type           != 'GPS'     THEN
                            ln_exception_number := 789;
                        WHEN lpr_ACTPL_errors(a).actref = 'ID ERR'
                        AND  pv_product_type           != 'GPS'     THEN
                            ln_exception_number := 790;
                        WHEN lpr_ACTPL_errors(a).actref = 'DFD ERR'
                        AND  pv_product_type           != 'GPS'     THEN
                            ln_exception_number := 167;
                        WHEN lpr_ACTPL_errors(a).actref = 'ACCC ERR' THEN
                            ln_exception_number := 900;
                        WHEN lpr_ACTPL_errors(a).actref = 'UFPLS ERR' THEN
                            ln_exception_number := 901;
                        --If there is a PSA error in PO100
                        WHEN lpr_ACTPL_errors(a).actref = 'PSA ERR' THEN
                            ln_exception_number := 903;
                            lv_error_message    := 'PSA Error - '|| lv_error_message;
                        --If there is an UPL error in PO100
                        WHEN lpr_ACTPL_errors(a).actref = 'UPL ERR' THEN
                            ln_exception_number := 906;
                            lv_error_message    := 'UPL Error';
                        --If there is an UPL RP Allocation error in PO100
                        WHEN lpr_ACTPL_errors(a).actref = 'ALCERR_RP' THEN
                            ln_exception_number := 907;
                            lv_error_message    := 'RP Allocation Error';
                        ELSE
                            ln_exception_number := 0;       -- ignore exception
                    END CASE;

                    IF ln_exception_number != 0 THEN
                        p_raise_exception(pn_policy_number
                                         ,ln_exception_number
                                         ,lv_error_message
                                         ,pv_product_type
                                         );
                    END IF;
                END IF;
            END LOOP;
        END IF;
    END p_ACTPL_error_check;

    -- procedure to check status of premiums paid for live, pup'd and pending exit policies
    PROCEDURE p_premium_status_check(pn_policy_number         IN co040.polref%TYPE
                                    ,pn_previous_renewal_date IN pa021.rnwdte%TYPE
                                    ,pn_renewal_date          IN pa021.rnwdte%TYPE
                                    ,pv_product_type          IN pr010.prdref%TYPE) IS

        lv_error_message    VARCHAR2(1803);

    BEGIN
        -- Get the premiums into the local collection if we haven't already
        IF lpn_policy_with_premiums != pn_policy_number THEN
            p_fetch_premiums(pn_policy_number
                            ,pn_previous_renewal_date
                            ,pn_renewal_date
                            );
        END IF;

        IF lpb_premiums_exist THEN
            FOR i IN lpr_premiums.FIRST..lpr_premiums.LAST LOOP
                -- If we find one with a dodgy status, raise the error
                IF lpr_premiums(i).event_status  NOT IN (20, 55, 82) AND
                   (lpr_premiums(i).due_date     < pn_renewal_date   OR
                   lpr_premiums(i).coll_date     < pn_renewal_date)   THEN

                    lv_error_message := 'Premium group: ' || lpr_premiums(i).trnprmgrp||'~'||
                                        'Due date: ' || pck_utility.f_dtcnv (lpr_premiums(i).due_date)||'~'||
                                        'Effective date: ' || pck_utility.f_dtcnv (lpr_premiums(i).coll_date)||'~'||
                                        'Unique ref: ' || lpr_premiums(i).event_unq||'~'||
                                        'Transaction number: ' || lpr_premiums(i).event_tranno||'~'||
                                        'Premium status: ' || lpr_premiums(i).status;

                    p_raise_exception(pn_policy_number
                                     ,717                -- exception number
                                     ,lv_error_message
                                     ,pv_product_type
                                     );
                END IF;
            END LOOP;
        END IF;
    END p_premium_status_check;

    -- procedure to check whether DSS contributions have been received in first 18 mths of policy
    PROCEDURE p_DSS_not_received_check(pn_policy_number         IN co040.polref%TYPE
                                      ,pn_renewal_date          IN pa022.rnwdte%TYPE
                                      ,pv_product_type          IN pr010.prdref%TYPE) IS

        CURSOR cu_DSS_details IS
            SELECT  pck_utility.f_dtcnv(po200.pp_strdte) start_date
                   ,pck_utility.f_dtcnv(po020.inrcrcdte) incrm_start_date
                   ,NVL(data_description.itevaldes,'*NO') itevaldes
            FROM po020
            JOIN po200
            ON po020.polref = po200.dsspolref
            LEFT OUTER JOIN (SELECT itevaldes
                                   ,datiteval
                             FROM cs060
                             WHERE ispgrpnam =  'PO200'
                             AND   datitenam =  'PCSSTG'
                             AND   maint     <> 'D') data_description
            ON po200.pcsstg  = data_description.datiteval
            WHERE po020.polref    = pn_policy_number
            AND   po020.inrtyp    = 'DSS'
            AND   po020.stainr    = 30
            AND   po200.sta       = 30
            AND   po200.pp_enddte = 99999
            AND   po200.maint    != 'D'
            AND   pck_utility.f_dtcnv(po200.pp_strdte) <
                                       ADD_MONTHS(pck_utility.f_dtcnv(pn_renewal_date),-18)
            AND   pck_utility.f_dtcnv(po020.inrcrcdte) <
                                       ADD_MONTHS(pck_utility.f_dtcnv(pn_renewal_date),-18)
            AND NOT EXISTS (SELECT 1
                            FROM event
                            WHERE ispec  = 'FI560'
                            AND   polref = po020.polref
                            AND   inrref = po020.inrref
                            AND   inrtyp = po020.inrtyp
                            AND   staevt = 55               -- paid
                            AND   pck_utility.f_dtcnv(dte2) >
                                       ADD_MONTHS(pck_utility.f_dtcnv(pn_renewal_date),-18));

        lb_details_found    BOOLEAN;
        lr_DSS_details      cu_DSS_details%ROWTYPE;
        lv_error_message    VARCHAR2(1803)        := ' ';

    BEGIN
        OPEN cu_DSS_details;
        FETCH cu_DSS_details INTO lr_DSS_details;
        lb_details_found := cu_DSS_details%FOUND;
        CLOSE cu_DSS_details;

        IF lb_details_found THEN

            lv_error_message := 'PO200 PP Option Start Date: '||lr_dss_details.start_date||'~'||
                                'Increment Start Date: '||lr_dss_details.incrm_start_date||'~'||
                                'PO200 Process Stage: '||lr_dss_details.itevaldes;

            p_raise_exception(pn_policy_number
                             ,pn_exception_number => 760
                             ,pv_error_message    => lv_error_message
                             ,pv_product_type     => pv_product_type
                             );
        END IF;

    END p_DSS_not_received_check;

    -- procedure to check whether there are any outstanding alterations or endorsements on a policy
    PROCEDURE p_outstanding_AE_check(pn_policy_number         IN co040.polref%TYPE
                                    ,pn_previous_renewal_date IN pa021.rnwdte%TYPE
                                    ,pn_renewal_date          IN pa021.rnwdte%TYPE) IS

        CURSOR cu_endorsement_details IS
            SELECT 1
            FROM en001
            WHERE polref    =  pn_policy_number
            AND   qtesrccde <> ' '
            AND   altefvdte BETWEEN pn_previous_renewal_date AND pn_renewal_date-1
            AND   pcsstg    <> 20
            AND  (pcsstg    <  40       -- altered
            OR    pcsstg    IN (70, 99)); -- commission error or EN error

        ln_variable                 NUMBER(1);

    BEGIN
        OPEN cu_endorsement_details;
        FETCH cu_endorsement_details INTO ln_variable;

        IF cu_endorsement_details%FOUND THEN

            pck_GPS_exceptions.p_raise_exception(720);                -- exception number

        END IF;

        CLOSE cu_endorsement_details;

    END p_outstanding_AE_check;

    -- procedure to check whether there are any outstanding alterations or endorsements on a policy
    PROCEDURE p_all_outstanding_AE_check(pn_policy_number         IN co040.polref%TYPE
                                        ,pn_end_date              IN pa021.rnwdte%TYPE
                                        ,pv_product_type          IN pr010.prdref%TYPE) IS

        CURSOR cu_endorsement_details IS
            SELECT en001.altefvdte
                  ,en001.altrmk
                  ,en001.pcsstg
                  ,status_description.itevalnam
            FROM en001
            LEFT OUTER JOIN (SELECT itevalnam
                                   ,datiteval
                             FROM cs060
                             WHERE ispgrpnam =  'EN'
                             AND   datitenam =  'PCSSTG'
                             AND   maint     <> 'D') status_description
            ON en001.pcsstg = LTRIM(status_description.datiteval,0)
            WHERE polref    =  pn_policy_number
            AND   qtesrccde <> ' '
            AND   altefvdte <= pn_end_date
            AND   pcsstg NOT IN (20,40,50,60,98);

    BEGIN
        FOR lr_endorsement_details IN cu_endorsement_details LOOP
            IF lr_endorsement_details.altefvdte != pn_end_date
            OR lr_endorsement_details.pcsstg    != 35
            OR lr_endorsement_details.altrmk    != 'NIPP renewals automatic increment' THEN
                p_raise_exception(pn_policy_number    => pn_policy_number
                                 ,pn_exception_number => 720
                                 ,pv_error_message    => 'Alteration Date: '||pck_utility.f_dtcnv(lr_endorsement_details.altefvdte)||'~'||
                                                         'Alteration Remark: '||lr_endorsement_details.altrmk||'~'||
                                                         'Process Stage: '||lr_endorsement_details.itevalnam
                                 ,pv_product_type     => pv_product_type);
            END IF;
        END LOOP;

    END p_all_outstanding_AE_check;

    -- procedure to check the statuses and fund movements of switches
    PROCEDURE p_switch_check(pn_policy_number         IN co040.polref%TYPE
                            ,pn_start_date            IN pa021.rnwdte%TYPE
                            ,pn_end_date              IN pa021.rnwdte%TYPE
                            ,pv_product_type          IN pr010.prdref%TYPE) IS

        CURSOR cu_incomplete_fund_moves(pcn_end_date      pa020.efvdte%TYPE
                                       ,pcn_policy_number co040.polref%TYPE
                                       ,pcn_start_date    pa021.rnwdte%TYPE)
        IS
            SELECT pck_utility.f_dtcnv(pa.efvdte) effective_date
                  ,pa.trnctl_no
                  ,NVL((SELECT cs.itevalnam
                        FROM  cs060 cs
                        WHERE cs.ispgrpnam = 'PA020'
                        AND   cs.datitenam =  'STA'
                        AND   cs.maint    != 'D'
                        AND   cs.datiteval = pa.sta_pa),'*NO') status
                  ,pa.pnttrn_no
                  ,pa2.fndtrntyp
            FROM pa020 pa, pa020 pa2
            WHERE pa.polref     = pcn_policy_number
            AND   pa.fndtrntyp  = 'SW'
            AND   pa.maint     <> 'D'
            AND   pa.sta_pa    IN (40, 50)         -- waiting printing or active
            AND   pa.efvdte BETWEEN pcn_start_date AND pcn_end_date-1
            AND   pa2.polref(+) = pa.polref
            AND   pa2.trnctl_no(+) = pa.pnttrn_no
            AND   NOT EXISTS (SELECT 1
                              FROM pa020 pa3
                              WHERE pa.polref = pa3.polref
                              AND   pa3.fndtrntyp = 'TAP'
                              AND   pa3.trnctl_no = pa.pnttrn_no)
            AND NOT EXISTS (SELECT 1
                            FROM fi700
                            WHERE polref    = pa.polref
                            AND   efvdte    = pa.efvdte
                            AND   fndtrntyp = pa.fndtrntyp
                            AND   trnctl_no = pa.trnctl_no
                            AND   staevt    = 50);

        CURSOR cu_actioned_fund_movt_details(pcn_policy_number co040.polref%TYPE
                                            ,pcn_start_date    pa021.rnwdte%TYPE
                                            ,pcn_end_date      pa020.efvdte%TYPE)
        IS
            SELECT DISTINCT TO_DATE(TO_CHAR(fi2.efvdte + 2415021),'J') effective_date
                   ,fi2.trnctl_no
                   ,NVL((SELECT 'Linked Transaction Control Type: SW~' ||
                                'Linked Transaction Control Number: ' || pa5.trnctl_no
                     FROM  pa020 pa5
                     WHERE pa5.maint     != 'D'
                     AND   pa5.polref     = pcn_policy_number
                     AND   pa5.fndtrntyp  = 'SW'
                     AND   pa5.sta_pa    IN (40,50)
                     AND ((pa5.trnctl_no  = fi2.trnctl_no
                     AND   pa5.efvdte     = (SELECT MAX(pa6.efvdte)
                                             FROM  pa020 pa6
                                             WHERE pa6.maint     != 'D'
                                             AND   pa6.polref     = fi2.polref
                                             AND   pa6.fndtrntyp  = 'SW'
                                             AND   pa6.sta_pa    IN (40,50)))
                     OR   (pa5.efvdte     = fi2.efvdte
                     AND   pa5.trnctl_no  = (SELECT MAX(trnctl_no)
                                             FROM  pa020 pa7
                                             WHERE pa7.maint     != 'D'
                                             AND   pa7.polref     = fi2.polref
                                             AND   pa7.fndtrntyp  = 'SW'
                                             AND   pa7.sta_pa    IN (40,50))))),'No linked UDCTL record') linked_info
            FROM  fi700 fi2
            WHERE fi2.polref    =   pcn_policy_number
            AND   fi2.fndtrntyp =   'SW'
            AND   fi2.staevt    =    50
            AND   fi2.efvdte BETWEEN pcn_start_date AND pcn_end_date-1
            AND NOT EXISTS (SELECT 1
                            FROM pa020 pa4
                            WHERE pa4.polref     = fi2.polref
                            AND   pa4.fndtrntyp  = 'SW'
                            AND   pa4.maint     != 'D'
                            AND   pa4.sta_pa    IN (40,50)
                            AND   pa4.trnctl_no  = fi2.trnctl_no
                            AND   pa4.efvdte     = fi2.efvdte);

        lv_error_message            VARCHAR2(1803);

    BEGIN
         p_UDCTL_check(pn_policy_number
                     ,pn_start_date
                     ,pn_end_date - 1
                     ,'SW'                    -- transaction type
                     ,pv_product_type);

        FOR lr_incomplete_fund_moves IN cu_incomplete_fund_moves(pn_end_date - 1
                                                                ,pn_policy_number
                                                                ,pn_start_date) LOOP

                lv_error_message := 'SW effective date: '||lr_incomplete_fund_moves.effective_date||'~'||
                                    'SW UDCTL status: '||lr_incomplete_fund_moves.status||'~'||
                                    'SW transaction control number: '||lr_incomplete_fund_moves.trnctl_no ||'~'||
                                    'Linked Transaction Control Type: ' || NVL(lr_incomplete_fund_moves.fndtrntyp, ' ') ||'~'||
                                    'Linked Transaction Control Number: ' ||NVL(lr_incomplete_fund_moves.pnttrn_no, 0);

                p_raise_exception(pn_policy_number
                                 ,737
                                 ,lv_error_message
                                 ,pv_product_type
                                 );

        END LOOP;

        FOR lr_actioned_fund_movt_details IN cu_actioned_fund_movt_details(pn_policy_number
                                                                          ,pn_start_date
                                                                          ,pn_end_date) LOOP

                lv_error_message := 'Effective date: '||lr_actioned_fund_movt_details.effective_date||'~'||
                                    'FNDMV Status: ACT' ||'~'||
                                    'Transaction Control Number: '||lr_actioned_fund_movt_details.trnctl_no ||'~'||
                                    lr_actioned_fund_movt_details.linked_info;

                p_raise_exception(pn_policy_number
                                 ,737
                                 ,lv_error_message
                                 ,pv_product_type
                                 );

        END LOOP;

    END p_switch_check;

    -- procedure to check statuses of fund movements
    PROCEDURE p_fund_movement_status_check(pn_policy_number         IN co040.polref%TYPE
                                          ,pn_previous_renewal_date IN pa021.rnwdte%TYPE
                                          ,pn_renewal_date          IN pa021.rnwdte%TYPE
                                          ,pn_policy_status         IN po010.stapol%TYPE
                                          ,pn_policy_exit_mode      IN po010.extmod%TYPE
                                          ,pv_product_type          IN pr010.prdref%TYPE
                                          ,pv_product_flag          IN VARCHAR2) IS
        lv_error_message          VARCHAR2(1803);
        lb_error_found            BOOLEAN;

    BEGIN
        -- Get the fund movements into the local collection if we haven't already
        IF lpn_policy_with_fund_movements      != pn_policy_number         OR
           NVL(lpn_fund_movement_date, -99999) != pn_previous_renewal_date THEN
            p_fetch_fund_movements (pn_policy_number
                                   ,pn_previous_renewal_date);
        END IF;
        -- Loop round them
        IF lpb_fund_movements THEN
            FOR i IN lpr_fund_movements.FIRST..lpr_fund_movements.LAST LOOP

                lb_error_found := FALSE;
                -- If there is a problem with the status, raise an error
                IF    pn_policy_status IN (30,52,60,61)                                         -- Live/PUP, Pending or Fully exited
                AND   pn_policy_exit_mode NOT IN (01,51,52)                                     -- then all other movements should be
                AND   lpr_fund_movements(i).efvdte < pn_renewal_date
                AND ((pv_product_flag != 'TAL' AND lpr_fund_movements(i).staevt NOT IN (5,50))   -- Actioned or DRF except Talisman which can
                OR   (pv_product_flag  = 'TAL' AND lpr_fund_movements(i).staevt NOT IN (5,50,81))) THEN -- have 98C (81)
                    lb_error_found := TRUE;

                ELSIF  pn_policy_status IN (52,60,61)                -- Cancelled, Nil lapse or Cooled off
                AND    pn_policy_exit_mode IN (01,51,52) THEN        -- then there should be no other movements
                    lb_error_found := TRUE;

                END IF;

                IF lb_error_found THEN

                    lv_error_message := 'Investment Fund: ' ||lpr_fund_movements(i).fndweenam||'~'||
                                        'Fund Code: ' ||lpr_fund_movements(i).fnd_id||'~'||
                                        'Effective Date: '  ||pck_utility.f_dtcnv (lpr_fund_movements(i).efvdte)||'~'||
                                        'Transaction Type: '||lpr_fund_movements(i).transaction_type||'~'||
                                        'Status: '          ||lpr_fund_movements(i).status||'~'||
                                        'Statement Number: '||lpr_fund_movements(i).untstm_no||'~'||
                                        'Increment Type: '  ||lpr_fund_movements(i).inrtyp||'~'||
                                        'Increment Reference: '||lpr_fund_movements(i).inrref||'~'||
                                        'Unique Reference: '||lpr_fund_movements(i).evtunq||'~'||
                                        'Transaction Number: '||lpr_fund_movements(i).evttrn_no;

                    p_raise_exception(pn_policy_number
                                     ,759
                                     ,lv_error_message
                                     ,pv_product_type
                                     );

                END IF;

            END LOOP;
        END IF;
    END p_fund_movement_status_check;

    -- procedure to check that the FNDQT records are correct
    PROCEDURE p_FNDQT_check(pn_policy_number         IN po010.polref%TYPE
                           ,pn_renewal_date          IN pa021.rnwdte%TYPE
                           ,pv_product_type          IN po010.prdref%TYPE) IS

        CURSOR cu_policy_holdings IS
            SELECT pr310.fndweenam
                  ,pr310.fnd_id
                  ,pck_utility.f_dtcnv(co055.untstmdte) effective_date
                  ,co055.untstm_no
            FROM co055
            JOIN pr310
            ON co055.fndref = pr310.fndref
            WHERE co055.polref     = pn_policy_number
            AND   co055.untstm_no != 999
            AND   co055.untstmdte >= pn_renewal_date
            AND   co055.maint     != 'D';

        lv_error_message   VARCHAR2(1803);

    BEGIN
        FOR lr_policy_holdings IN cu_policy_holdings LOOP
            lv_error_message := 'Investment fund: '||lr_policy_holdings.fndweenam||'~'||
                                'Fund Code: '||lr_policy_holdings.fnd_id||'~';

            IF pv_product_type = 'GPS' THEN
                lv_error_message := lv_error_message||'Effective date: ';
            ELSE
                lv_error_message := lv_error_message||'Statement Date: ';
            END IF;

            lv_error_message := lv_error_message||lr_policy_holdings.effective_date||'~'||
                                'Statement number: '||lr_policy_holdings.untstm_no;

            p_raise_exception(pn_policy_number
                             ,773
                             ,lv_error_message
                             ,pv_product_type
                             );
        END LOOP;
    END p_FNDQT_check;

    -- procedure to check that statement numbers are valid
    PROCEDURE p_statement_number_check(pn_policy_number IN po010.polref%TYPE
                                      ,pv_product_type  IN pr010.prdref%TYPE) IS

        CURSOR cu_prev_renewal_fndqt_details IS
        SELECT max(untstmdte) + 1    -- not interested in fund movements equal to the statement date
        FROM   co055 a
        WHERE  polref    =  pn_policy_number
        AND    maint     <> 'D'
        AND    untstmdte <> 99999
        AND    untstm_no <> 999;

        lv_error_message    VARCHAR2(1803);
        ln_start_date       co055.untstmdte%TYPE;

    BEGIN

        IF pck_policy_details.f_policy_with_investment(pn_policy_number) THEN

           -- need to get previous renewals last payment date
           OPEN cu_prev_renewal_fndqt_details;
           FETCH cu_prev_renewal_fndqt_details INTO ln_start_date;
           IF cu_prev_renewal_fndqt_details%NOTFOUND OR ln_start_date IS NULL THEN
               ln_start_date := -99999;
           END IF;
           CLOSE cu_prev_renewal_fndqt_details;

           IF lpn_policy_with_fund_movements != pn_policy_number OR
              lpn_fund_movement_date         != ln_start_date    THEN
               p_fetch_fund_movements (pn_policy_number
                                      ,ln_start_date);
           END IF;

           IF lpb_fund_movements THEN
               FOR i IN lpr_fund_movements.FIRST..lpr_fund_movements.LAST LOOP

                   IF lpr_fund_movements(i).staevt = 50 AND
                      lpr_fund_movements(i).untstm_no != 999 THEN

                       lv_error_message := 'Investment fund: '||lpr_fund_movements(i).fndweenam||'~'||
                                           'Fund Code: '||lpr_fund_movements(i).fnd_id||'~'||
                                           'Effective date: '||pck_utility.f_dtcnv (lpr_fund_movements(i).efvdte)||'~'||
                                           'Transaction type: '||lpr_fund_movements(i).transaction_type||'~'||
                                           'Statement number: '||lpr_fund_movements(i).untstm_no;
                       p_raise_exception(pn_policy_number
                                        ,757
                                        ,lv_error_message
                                        ,pv_product_type
                                        );
                   END IF;
               END LOOP;
           END IF;
       END IF;
    END p_statement_number_check;

    --procedure to check for an automatic switch/rebalancing/managed strategy trigger failure
    PROCEDURE p_automatic_switch_check(pn_policy_number         IN po010.polref%TYPE
                                      ,pv_product_type          IN pr010.prdref%TYPE
                                      ,pn_end_date              IN pa021.rnwdte%TYPE) IS

        --Get all policies invested in standard strategy (pr310 fund type is 'I') and no
        --live UDCTL SWA UDCTL record with effective date greater than the reporting end date
        CURSOR cu_automatic_switches (pn_retn_limit_late_vesting  IN NUMBER
                                     ,pn_retn_limit_yearly_switch IN NUMBER
                                     ,pn_retirement_date          IN po010.polmatdte%TYPE
                                     ,pv_policy_on_late_vesting   IN VARCHAR2
                                     ,pcn_end_date                IN pa021.rnwdte%TYPE) IS
            SELECT *
            FROM (
                    SELECT "Policy"
                           ,NVL(y.fndtrntyp,'SWA') AS fndtrntyp
                           ,y.strdte
                           ,y.efvdte
                           ,y.enddte
                           ,(CASE
                                WHEN y.sta_pa IN (5,10,30,40,47,50,80) THEN
                                     (SELECT itevalnam
                                      FROM  cs060 cs
                                      WHERE cs.ispgrpnam  = 'UT085'
                                      AND   cs.datitenam  = 'STA'
                                      AND   cs.maint     != 'D'
                                      AND   cs.datiteval  = y.sta_pa)
                                WHEN y.sta_pa NOT IN (5,10,30,40,47,50,80) AND y.sta_pa IS NOT NULL THEN
                                      '*NO'
                                ELSE NULL
                             END) AS status
                           ,y.trnctl_no
                     FROM (
                             SELECT a.polref AS "Policy"
                             FROM  po030 a
                                  ,po010 h
                                  ,pr310 pr
                             WHERE a.ivmstg != 0
                             AND   a.polref    = pn_policy_number
                             AND   a.maint    != 'D'
                             AND   a.strdte   <= pcn_end_date
                             AND   a.enddte   >= pcn_end_date
                             AND   a.staben   =  30
                             AND   h.stapol   IN (30,52)
                             AND   a.ivmstg   =  pr.fndref
                             AND   pr.fndtyp  =  'I'
                             AND   a.polref   =  h.polref
                             AND   h.maint   != 'D'
                             AND   (pv_policy_on_late_vesting !='Y' --exclude policies on late_vesting
                             OR    (pv_policy_on_late_vesting  ='Y' --or include policy on late vesting but the years to retirement is greater than 2
                             AND   ((pn_retirement_date - pcn_end_date)/365) > pn_retn_limit_late_vesting))
                             AND NOT EXISTS (SELECT  pa2.*        --check that rebalancing frequency is yearly and
                                             FROM    pa020 pa2    --that years to retirement is less than 1. The script
                                                    ,co050 co2    --is similar to derivation in INVST screen
                                                    ,pr310 pr2
                                             WHERE   pa2.polref   =  a.polref
                                             AND     pa2.sta_pa      =  30
                                             AND     pa2.maint      !=  'D'
                                             AND     co2.polref      =  pa2.polref
                                             AND     co2.fndtrntyp   =  pa2.fndtrntyp
                                             AND     co2.trnctl_no   =  pa2.trnctl_no
                                             AND     co2.stastd      =  30
                                             AND     co2.maint      !=  'D'
                                             AND     pr2.fndref      =   co2.fndref
                                             AND     pr2.maint      !=  'D'
                                             AND    (pa2.fndtrntyp   =  'SWA' AND EXISTS (SELECT 'Y'
                                                                                          FROM    pr320 pr32
                                                                                          WHERE   pr32.ivmstgref = co2.fndref
                                                                                          AND     pr32.maint != 'D')
                                                                                          AND EXISTS (SELECT 'Y'   -- only look for benefit record if at policy level
                                                                                                      FROM    po030 po2
                                                                                                      WHERE   po2.polref       =  pa2.polref
                                                                                                      AND     po2.strdte      <=  pcn_end_date
                                                                                                      AND     po2.enddte      >=  pcn_end_date
                                                                                                      AND     po2.ivmin_fnd    =  'Y'
                                                                                                      AND     po2.staben       =  30
                                                                                                      AND     po2.ivmstg      !=  0
                                                                                                      AND     po2.maint       !=  'D'))

                                            AND    pr2.swhfrq = 'Y'
                                            AND   ((pn_retirement_date - pcn_end_date)/365) < pn_retn_limit_yearly_switch
                                            AND    pa2.trnctl_no = (SELECT MAX(pa21.trnctl_no)
                                                                   FROM    pa020 pa21
                                                                          ,co050 co21
                                                                          ,pr310 pr21
                                                                   WHERE   pa21.polref   =  a.polref
                                                                   AND     pa21.fndtrntyp   =  'SWA'
                                                                   AND     pa21.sta_pa      =  30
                                                                   AND     pa21.maint      !=  'D'
                                                                   AND     co21.polref      =  pa21.polref
                                                                   AND     co21.fndtrntyp   =  pa21.fndtrntyp
                                                                   AND     co21.trnctl_no   =  pa21.trnctl_no
                                                                   AND     co21.stastd      =  30
                                                                   AND     co21.maint      !=  'D'
                                                                   AND     pr21.fndref      =   co21.fndref
                                                                   AND     pr21.maint      !=  'D'
                                                                   AND    (pa21.fndtrntyp   =  'SWA' AND EXISTS (SELECT 'Y'
                                                                                                                 FROM    pr320 pr3
                                                                                                                 WHERE   pr3.ivmstgref = co21.fndref
                                                                                                                 AND     pr3.maint != 'D')
                                                                                                                 AND EXISTS (SELECT 'Y'   -- only look for benefit record if at policy level
                                                                                                                             FROM    po030 po21
                                                                                                                             WHERE   po21.polref       =  pa2.polref
                                                                                                                             AND     po21.strdte      <=  pcn_end_date
                                                                                                                             AND     po21.enddte      >=  pcn_end_date
                                                                                                                             AND     po21.ivmin_fnd    =  'Y'
                                                                                                                             AND     po21.staben       =  30
                                                                                                                             AND     po21.ivmstg      !=  0
                                                                                                                             AND     po21.maint       !=  'D')))
                                          )
                             AND  NOT EXISTS (SELECT g.*          --check SWA record
                                              FROM  pa020 g
                                              WHERE a.polref    = g.polref
                                              AND   g.fndtrntyp = 'SWA'
                                              AND   g.sta_pa    = 30
                                              AND   g.efvdte    > pcn_end_date)
                             AND  EXISTS (SELECT pa020.*
                                          FROM    pa020 pa020
                                                 ,co050 co050
                                                 ,pr310 pr310
                                          WHERE   pa020.polref =a.polref
                                          AND     pa020.fndtrntyp   =   'SWA'
                                          AND     pa020.sta_pa      =   30
                                          AND     pa020.maint      !=   'D'
                                          AND     co050.polref      =   pa020.polref
                                          AND     co050.fndtrntyp   =   pa020.fndtrntyp
                                          AND     co050.trnctl_no   =   pa020.trnctl_no
                                          AND     co050.stastd      =   30
                                          AND     co050.maint      !=  'D'
                                          AND     pr310.fndref      =   co050.fndref
                                          AND     pr310.maint      !=  'D'
                                          AND     pa020.fndtrntyp   = 'SWA' AND EXISTS (SELECT 'Y'
                                                                                        FROM    pr320 pr320
                                                                                        WHERE   pr320.ivmstgref = co050.fndref
                                                                                        AND     pr320.maint != 'D')
                                                                                        AND EXISTS (SELECT 'Y'   -- only look for benefit record if at policy level
                                                                                                    FROM    po030 po030
                                                                                                    WHERE   po030.polref       =  pa020.polref
                                                                                                    AND     po030.strdte      <=  pcn_end_date
                                                                                                    AND     po030.enddte      >=  pcn_end_date
                                                                                                    AND     po030.ivmin_fnd    =  'Y'
                                                                                                    AND     po030.staben       =  30
                                                                                                    AND     po030.ivmstg      !=  0
                                                                                                    AND     po030.maint       !=  'D')
                                                                                         )

                        GROUP BY a.polref
                      ) Policy_list
                     LEFT OUTER JOIN pa020 y ON  "Policy"    = y.polref
                                           AND y.fndtrntyp = 'SWA'
                                           AND y.maint    != 'D'
                    ) Policy_list2

            WHERE NVL(trnctl_no,0) = (SELECT NVL(MAX(w.trnctl_no),0)  -- to get the UDCTL record with the latest effective date and the highest transaction control number
                                      FROM  pa020 w
                                      WHERE w.polref     = "Policy"
                                      AND   w.fndtrntyp  = 'SWA'
                                      AND   w.maint     != 'D'
                                      AND   w.efvdte     = (SELECT NVL(MAX(u.efvdte),0)
                                                            FROM  pa020 u
                                                            WHERE u.polref     = "Policy"
                                                            AND   u.fndtrntyp  = 'SWA'
                                                            AND   u.maint     != 'D' ));

        --Get all policies invested in new strategy (fund reference 5000 and 6000) and no
        --live UDCTL PRB UDCTL record with effective date greater than the reporting end date
        --when rebalancing exist
        CURSOR cu_periodic_rebalancing (pn_retn_limit_late_vesting  IN NUMBER
                                       ,pn_retn_limit_yearly_switch IN NUMBER
                                       ,pn_retirement_date          IN po010.polmatdte%TYPE
                                       ,pv_policy_on_late_vesting   IN VARCHAR2
                                       ,pcn_end_date                IN pa021.rnwdte%TYPE) IS
            SELECT DISTINCT *
            FROM
            (
                SELECT
                    Driver.polref
                   ,NVL(Driver.fndtrntyp,'PRB') AS fndtrntyp
                   ,Driver.strdte
                   ,Driver.efvdte
                   ,Driver.enddte
                   ,(CASE
                         WHEN Driver.sta_pa IN (5,10,30,40,47,50,80) THEN
                             (SELECT itevalnam
                              FROM  cs060 cs
                              WHERE ispgrpnam  = 'UT085'
                              AND   datitenam  = 'STA'
                              AND   maint     != 'D'
                              AND cs.datiteval = Driver.sta_pa)
                          WHEN Driver.sta_pa NOT IN (5,10,30,40,47,50,80) AND Driver.sta_pa IS NOT NULL THEN
                              '*NO'
                          ELSE NULL
                     END) AS Status
                   ,Driver.trnctl_no
                FROM
                    (   SELECT DISTINCT
                            a.polref polref, a.prdref, a.rhttyp benefit_rhttyp, pa.fndtrntyp
                            ,pa.strdte, pa.efvdte, pa.enddte, pa.trnctl_no, pa.sta_pa
                            ,pa.rhttyp trigger_rhttyp, sh.rebalance_frequency

                        FROM po030 a

                        INNER JOIN po010 h  ON  h.polref  = a.polref
                                            AND h.maint  != 'D'
                                            AND h.stapol IN (30,52)

                        --  Join to test the fund reference is valid.
                        INNER JOIN pr310 pr ON  pr.fndref = a.ivmstg
                                            AND pr.maint != 'D'

                        --  Policy must be in a new strategy
                        INNER JOIN strategy_links sl    ON  sl.reference_no     = a.polref
                                                        AND sl.reference_type   = 'P'
                                                        AND sl.status           = 30

                        --  Need the strategy rebalancing frequency.
                        INNER JOIN strategy_headers sh  ON  sh.strategy_id      = sl.strategy_id
                                                        AND sh.status           = 30

                        --  Need to return a row even if the policy has no triggers.
                        --  Include completed or cancelled triggers as well as live
                        LEFT OUTER JOIN pa020 pa    ON pa.polref        = a.polref
                                                    AND pa.rhttyp       = a.rhttyp
                                                    AND pa.fndtrntyp    = 'PRB'
                                                    AND pa.maint        != 'D'

                        WHERE a.polref  =   pn_policy_number
                        AND   a.ivmstg  IN (5000,6000)
                        AND   a.maint   !=  'D'
                        AND   a.strdte  <=  pcn_end_date
                        AND   a.enddte  >=  pcn_end_date
                        AND   a.staben  =   30
                        AND   a.bentyp  LIKE 'INV%'

                        --  Policy is not late vesting
                        --  Or Policy is late vesting AND retirement date is more than 2 years after report period end date.
                        AND (   pv_policy_on_late_vesting != 'Y'
                                OR  (
                                        pv_policy_on_late_vesting  = 'Y'
                                        AND   ( (pn_retirement_date - pcn_end_date ) / 365 ) > pn_retn_limit_late_vesting
                                    )
                            )

                        -- Include policy if it has a rebal frequency not yearly and not "None".
                        -- OR Include policices with yearly rebal frequency if the policy is more than a year to retirement
                        AND (   (sh.rebalance_frequency != 'Y' AND sh.rebalance_frequency != 'N')
                                OR  (
                                        sh.rebalance_frequency = 'Y' AND
                                        ( (pn_retirement_date - pcn_end_date ) / 365 ) > pn_retn_limit_yearly_switch
                                    )
                            )
                    )   Driver

            WHERE
            (
                --  Only 'RS-EPP','RS-S32'policies should have blank rights types on their po030 (benefit) records.
                (   driver.prdref IN ('RS-EPP','RS-S32')    )

                OR

                --  Include policies of other products with 'A' or 'P' rhttyp only.
                (   driver.prdref NOT IN ('RS-EPP','RS-S32') AND driver.benefit_rhttyp IN ('A', 'P') )
            )

            AND (

                -- No PRB records found
                Driver.trnctl_no IS NULL

                -- Rhttyp 'P' in the past and no live Rhttyp 'P' in the future.
                OR Driver.trnctl_no = ( SELECT MAX(pa3.trnctl_no)
                                        FROM pa020 pa3
                                        WHERE pa3.polref    = driver.polref
                                        AND pa3.rhttyp      = driver.trigger_rhttyp
                                        AND pa3.fndtrntyp   = 'PRB'
                                        AND pa3.efvdte      <= pcn_end_date
                                        AND pa3.rhttyp      = 'P'
                                        AND pa3.maint       != 'D'
                                        AND NOT EXISTS
                                            (SELECT pa3f.trnctl_no
                                            FROM pa020 pa3f
                                            WHERE pa3f.polref    = pa3.polref
                                            AND pa3f.fndtrntyp   = pa3.fndtrntyp
                                            AND pa3f.efvdte      > pcn_end_date
                                            AND pa3f.rhttyp      = pa3.rhttyp
                                            AND pa3f.sta_pa      = 30
                                            AND pa3f.maint       != 'D'  ))

                -- Rhttyp 'A' in the past and no live Rhttyp 'A' in the future.
                OR Driver.trnctl_no = ( SELECT MAX(pa4.trnctl_no)
                                        FROM pa020 pa4
                                        WHERE pa4.polref    = driver.polref
                                        AND pa4.rhttyp      = driver.trigger_rhttyp
                                        AND pa4.fndtrntyp   = 'PRB'
                                        AND pa4.efvdte      <= pcn_end_date
                                        AND pa4.rhttyp      = 'A'
                                        AND pa4.maint       != 'D'
                                        AND NOT EXISTS
                                            (SELECT pa4f.trnctl_no
                                            FROM pa020 pa4f
                                            WHERE pa4f.polref    = pa4.polref
                                            AND pa4f.fndtrntyp   = pa4.fndtrntyp
                                            AND pa4f.efvdte      > pcn_end_date
                                            AND pa4f.rhttyp      = pa4.rhttyp
                                            AND pa4f.sta_pa      = 30
                                            AND pa4f.maint       != 'D'  ))

                -- Rhttyp ' ' in the past and no live Rhttyp ' ' in the future.
                OR Driver.trnctl_no = ( SELECT MAX(pa5.trnctl_no)
                                        FROM pa020 pa5
                                        WHERE   pa5.polref    = driver.polref
                                        AND     pa5.rhttyp      = driver.benefit_rhttyp
                                        AND     pa5.fndtrntyp   = 'PRB'
                                        AND     pa5.efvdte      <= pcn_end_date
                                        AND     pa5.rhttyp      = ' '
                                        AND     pa5.maint       != 'D'
                                        AND NOT EXISTS
                                            (SELECT pa5f.trnctl_no
                                            FROM    pa020 pa5f
                                            WHERE   pa5f.polref     = pa5.polref
                                            AND     pa5f.fndtrntyp  = pa5.fndtrntyp
                                            AND     pa5f.efvdte     > pcn_end_date
                                            AND     pa5f.rhttyp     = pa5.rhttyp
                                            AND     pa5f.sta_pa     = 30
                                            AND     pa5f.maint      != 'D'  ))

                )

            AND -- There are current live fund holdings for this policy and rights type.
            (
                (SELECT  SUM(c.benqty1)
                FROM    co055  c
                WHERE   c.polref    = driver.polref
                AND     c.rhttyp    = driver.benefit_rhttyp
                AND     c.untstm_no = 999
                AND     c.stastd    = 30
                AND     c.maint     != 'D') > 0
            )

            -- Return the most recent "problem" trigger.
            ORDER BY Driver.trnctl_no DESC

            ) one_row_per_policy

            WHERE ROWNUM = 1;

        --Get all policies invested in Managed Strategy (Governed Portfolio) and no
        --live UDCTL RB UDCTL record with effective date greater than the reporting end date
        CURSOR cu_rebalancing_managed(pn_retn_limit_late_vesting  IN NUMBER
                                     ,pn_retn_limit_yearly_switch IN NUMBER
                                     ,pn_retirement_date IN po010.polmatdte%TYPE
                                     ,pv_policy_on_late_vesting IN VARCHAR2
                                     ,pcn_end_date              IN pa021.rnwdte%TYPE) IS
        SELECT *
        FROM (
              SELECT  "Policy"
                     ,NVL(y.fndtrntyp,'RB') AS fndtrntyp
                     ,y.strdte
                     ,y.efvdte
                     ,y.enddte
                     ,(CASE
                          WHEN y.sta_pa IN (5,10,30,40,47,50,80) THEN
                              (SELECT itevalnam
                               FROM  cs060 cs
                               WHERE ispgrpnam  = 'UT085'
                               AND datitenam    = 'STA'
                               AND maint       != 'D'
                               AND cs.datiteval = y.sta_pa)
                          WHEN y.sta_pa NOT IN (5,10,30,40,47,50,80) AND y.sta_pa IS NOT NULL THEN
                               '*NO'
                          ELSE NULL
                        END) AS status
                    ,y.trnctl_no

              FROM (
                      SELECT polref AS "Policy"
                      FROM (
                               SELECT  pa.polref polref
                                      ,co.fndref fndref
                                FROM   pa020 pa
                                      ,co050 co
                                      ,pr310 pr
                                      ,po010 po
                                WHERE   pa.polref    =   pn_policy_number
                                AND     pa.sta_pa    =   30
                                AND     pa.maint     !=  'D'
                                AND     co.polref    =   pa.polref
                                AND     co.fndtrntyp =   pa.fndtrntyp
                                AND     co.trnctl_no =   pa.trnctl_no
                                AND     co.stastd   =    30
                                AND     co.maint     !=  'D'
                                AND     pr.fndref    =   co.fndref
                                AND     pr.maint     !=  'D'
                                AND     pa.polref    =   po.polref
                                AND     po.stapol    IN  (30,52)
                                AND     pa.fndtrntyp = 'STY' AND EXISTS (SELECT 'Y'
                                                                         FROM    strategies s
                                                                         WHERE   s.strategy_reference = co.fndref)
                                AND   (pv_policy_on_late_vesting !='Y' --exclude policies on late_vesting
                                OR    (pv_policy_on_late_vesting  ='Y' --or include policy on late vesting but the years to retirement is greater than 2
                                AND   ((pn_retirement_date - pcn_end_date)/365) > pn_retn_limit_late_vesting))
                                AND NOT EXISTS (SELECT i.*           --exclude if arrangement is yearly switch frequency that has less than 1 yr to retirement
                                            FROM  pa020 i
                                            WHERE i.fndtrntyp    = 'RB'
                                            AND   i.maint       != 'D'
                                            AND   i.polref       = pa.polref
                                            AND   i.sta_pa       = 30
                                            AND   i.frq          = 'Y'
                                            AND   ((pn_retirement_date - pcn_end_date)/365) < pn_retn_limit_yearly_switch)
                                AND NOT EXISTS (SELECT g.*           --check on RB record
                                                FROM pa020 g
                                                WHERE pa.polref = g.polref
                                                AND g.fndtrntyp = 'RB'
                                                AND g.maint    != 'D'
                                                AND g.sta_pa    = 30
                                                AND g.efvdte    > pcn_end_date)

                                ORDER BY pa.trnctl_no DESC
                            ) policy_list
                         GROUP BY polref
                      ) policy_list2
                 LEFT OUTER JOIN pa020 y ON  "Policy"    = y.polref
                                         AND y.fndtrntyp = 'RB'
                                         AND y.maint    != 'D'
             ) policy_list3
        WHERE ((NVL(trnctl_no,0) = (SELECT NVL(MAX(w.trnctl_no),0)
                                    FROM  pa020 w
                                    WHERE w.polref    = "Policy"
                                    AND   w.fndtrntyp = 'RB'
                                    AND   w.maint    !='D'
                                    AND   w.efvdte    = (SELECT NVL(MAX(u.efvdte),0)
                                                         FROM  pa020 u
                                                         WHERE u.polref  = w.polref
                                                         AND u.fndtrntyp = 'RB'
                                                         AND u.maint    != 'D' )))
        OR (NOT EXISTS (SELECT *
                        FROM  pa020 x
                        WHERE x.polref="Policy"
                        AND   x.fndtrntyp='RB'
                        AND   x.maint !='D')));

        --Get all policies invested in Fund Range (displayed as 'N/A in Investment Strategy via INVST) and no
        --live UDCTL RB UDCTL record with effective date greater than the reporting end date
        CURSOR cu_rebalancing_fund_range(pn_retn_limit_late_vesting  IN NUMBER
                                        ,pn_retn_limit_yearly_switch IN NUMBER
                                        ,pn_retirement_date          IN po010.polmatdte%TYPE
                                        ,pv_policy_on_late_vesting   IN VARCHAR2
                                        ,pcn_end_date                IN pa021.rnwdte%TYPE)IS
            SELECT *
            FROM (
                    SELECT "Policy"
                          ,NVL(y.fndtrntyp,'RB') AS fndtrntyp
                          ,y.strdte
                          ,y.efvdte
                          ,y.enddte
                          ,(CASE
                               WHEN y.sta_pa IN (5,10,30,40,47,50,80) THEN
                                   (SELECT itevalnam
                                    FROM  cs060 cs
                                    WHERE ispgrpnam    = 'UT085'
                                    AND   datitenam    = 'STA'
                                    AND   maint       != 'D'
                                    AND   cs.datiteval = y.sta_pa)
                               WHEN y.sta_pa NOT IN (5,10,30,40,47,50,80) AND y.sta_pa IS NOT NULL THEN
                                    '*NO'
                               ELSE NULL
                            END) AS status
                          ,y.trnctl_no
                    FROM (
                            SELECT a.polref AS "Policy"
                            FROM po030 a
                                ,po010 h
                                ,pr310 pr
                                ,pa020 pa
                            WHERE a.polref      = pn_policy_number
                            AND   a.maint      != 'D'
                            AND   a.strdte     <= pcn_end_date
                            AND   a.enddte     >= pcn_end_date
                            AND   a.staben      = 30
                            AND   h.stapol     IN (30,52)
                            AND   h.maint      != 'D'
                            AND   a.ivmstg      = pr.fndref
                            AND   a.polref      = h.polref
                            AND   a.polref      = pa.polref
                            AND   pa.fndtrntyp IN ('RP','SP')
                            AND   pa.maint     != 'D'
                            AND   pa.sta_pa    <  82
                            AND   pa.inrtyp    != ' '
                            AND   pr.fndtyp    != 'I'
                            AND   a.ivmstg     NOT IN (5000,6000)
                            AND   EXISTS (SELECT r.*
                                          FROM pa020 r
                                          WHERE r.fndtrntyp  = 'RB'
                                          AND   r.maint     != 'D'
                                          AND   r.polref     = a.polref
                                          AND   r.sta_pa     = 30
                                          AND   r.frq       != ' ')
                            AND   (pv_policy_on_late_vesting !='Y' --exclude policies on late_vesting
                            OR    (pv_policy_on_late_vesting  ='Y' --or include policy on late vesting but the years to retirement is greater than 2
                            AND   ((pn_retirement_date - pcn_end_date)/365) > pn_retn_limit_late_vesting))
                            AND NOT EXISTS (SELECT i.*           --exclude if arrangement is yearly switch frequency that has less than 1 yr to retirement
                                            FROM  pa020 i
                                            WHERE i.fndtrntyp    = 'RB'
                                            AND   i.maint       != 'D'
                                            AND   i.polref       = a.polref
                                            AND   i.sta_pa       = 30
                                            AND   i.frq          = 'Y'
                                            AND   ((pn_retirement_date - pcn_end_date)/365) < pn_retn_limit_yearly_switch)
                            AND NOT EXISTS (SELECT g.*                                  --check RB record
                                            FROM  pa020 g
                                            WHERE a.polref    = g.polref
                                            AND   g.fndtrntyp = 'RB'
                                            AND   g.sta_pa    = 30
                                            AND   g.efvdte    > pcn_end_date)
                            AND NOT EXISTS (SELECT  pa020.*                             --standard strategy
                                            FROM    pa020 pa020
                                                   ,co050 co050
                                                   ,pr310 pr310
                                            WHERE   pa020.polref     = a.polref
                                            AND     pa020.sta_pa     = 30
                                            AND     pa020.maint     != 'D'
                                            AND     co050.polref     = pa020.polref
                                            AND     co050.fndtrntyp  = pa020.fndtrntyp
                                            AND     co050.trnctl_no  = pa020.trnctl_no
                                            AND     co050.stastd     = 30
                                            AND     co050.maint     != 'D'
                                            AND     pr310.fndref     =  co050.fndref
                                            AND     pr310.maint     != 'D'
                                            AND     pa020.fndtrntyp  = 'SWA'
                                            AND     EXISTS (SELECT 'Y'
                                                            FROM    pr320 pr320
                                                            WHERE   pr320.ivmstgref = co050.fndref
                                                            AND     pr320.maint    != 'D')
                                            AND     EXISTS (SELECT 'Y'   -- only look for benefit record if at policy level
                                                            FROM    po030 po030
                                                            WHERE   po030.polref      =   pa020.polref
                                                            AND     po030.strdte      <=  pcn_end_date
                                                            AND     po030.enddte      >=  pcn_end_date
                                                            AND     po030.ivmin_fnd   =   'Y'
                                                            AND     po030.staben      =   30
                                                            AND     po030.ivmstg      !=  0
                                                            AND     po030.maint       !=  'D'))
                            AND NOT EXISTS (SELECT sl.*                                 --new strategy
                                            FROM  strategy_links sl
                                            WHERE sl.reference_no   = a.polref
                                            AND   sl.reference_type = 'P'
                                            AND   sl.status         = 30)
                            AND NOT EXISTS (SELECT  pa.*                                --managed strategy
                                            FROM    pa020 pa
                                                   ,co050 co
                                                   ,pr310 pr
                                            WHERE   pa.polref     = a.polref
                                            AND     pa.sta_pa     = 30
                                            AND     pa.maint     != 'D'
                                            AND     co.polref     = pa.polref
                                            AND     co.fndtrntyp  = pa.fndtrntyp
                                            AND     co.trnctl_no  = pa.trnctl_no
                                            AND     co.stastd     = 30
                                            AND     co.maint     != 'D'
                                            AND     pr.fndref     =  co.fndref
                                            AND     pr.maint     != 'D'
                                            AND     pa.fndtrntyp = 'STY'
                                            AND     EXISTS (SELECT 'Y'
                                                            FROM    strategies s
                                                            WHERE   s.strategy_reference = co.fndref))


                            GROUP BY a.polref
                         ) Policy_list
                       LEFT OUTER JOIN pa020 y ON  "Policy"    = y.polref
                                               AND y.fndtrntyp = 'RB'
                                               AND y.maint    != 'D'
                  ) Policy_list2
            WHERE ((NVL(trnctl_no,0) = (SELECT NVL(MAX(w.trnctl_no),0)                -- to get the UDCTL record with the latest effective date and the highest transaction control number
                                        FROM  pa020 w
                                        WHERE w.polref    = "Policy"
                                        AND   w.fndtrntyp = 'RB'
                                        AND   w.maint    != 'D'
                                        AND   w.efvdte=(SELECT NVL(MAX(u.efvdte),0)
                                                        FROM  pa020 u
                                                        WHERE u.polref     = "Policy"
                                                        AND   u.fndtrntyp  = 'RB'
                                                        AND   u.maint     != 'D' )))
        OR (NOT EXISTS (SELECT *                             -- to get those cases with no RB UDCTL record
                        FROM  pa020 x
                        WHERE x.polref    = "Policy"
                        AND   x.fndtrntyp = 'RB'
                        AND   x.maint    != 'D')));


        lr_automatic_switches        cu_automatic_switches%ROWTYPE;
        lr_periodic_rebalancing      cu_periodic_rebalancing%ROWTYPE;
        lr_rebalancing_managed       cu_rebalancing_managed%ROWTYPE;
        lr_rebalancing_fund_range    cu_rebalancing_fund_range%ROWTYPE;
        lb_error_found               BOOLEAN := FALSE;
        lv_error_message             VARCHAR2(1803);
        ln_retirement_date           po010.polmatdte%TYPE;
        lv_policy_on_late_vesting    VARCHAR2(1) := 'N';
        lt_param_values              pck_batch_control_params.t_batch_control_parameters;
        ln_retn_limit_late_vesting   NUMBER(7) := 0;
        ln_retn_limit_yearly_switch  NUMBER(7) := 0;
        ln_rp_last_premium_paid_date event.dte1%TYPE;
        ln_sp_last_premium_paid_date event.dte1%TYPE;
        ln_tv_last_paid_date         event.dte1%TYPE;
        ln_last_dss_date             event.dte1%TYPE;

    BEGIN

       pck_process_info.p_set_action ('p_automatic_switch_check');

       --Get years to retirement limit for late vesting check and yearly switch frequency
       lt_param_values := pck_batch_control_params.f_get_batch_cntrl_params (pv_pck_name     => 'PCK_POLICY_EXCEPTIONS'
                                                                            ,pv_routine_name => 'P_AUTOMATIC_SWITCH_CHECK'
                                                                            );
       FOR i IN 1 .. lt_param_values.COUNT LOOP
           IF lt_param_values(i).param_name LIKE 'LN_RETN_LIMIT%' THEN

               IF ln_retn_limit_late_vesting = 0 THEN
                  ln_retn_limit_late_vesting  := TO_NUMBER(lt_param_values(i).param_value);
               ELSE
                  ln_retn_limit_yearly_switch := TO_NUMBER(lt_param_values(i).param_value);
               END IF;
           END IF;
       END LOOP;

       --Get earliest retirement date
       ln_retirement_date := pck_policy_details.f_get_earliest_retirement_date(pn_policy_number);

       --Check if the policy is on late vesting
       lv_policy_on_late_vesting := pck_policy_details.f_policy_on_late_vesting(pn_policy_number);

       --check if the premium is paid
       -- To retrieve last premium paid date for RP
       pck_contributions.p_get_rp_last_paid_premium(pn_policy_number
                                                   ,lpn_system_date
                                                   ,'Y'
                                                   ,ln_rp_last_premium_paid_date);

       -- To retrieve last premium paid date for TV, SP, DSS
       pck_contributions.p_get_sp_tv_dss_last_premium(pn_policy_number
                                                     ,lpn_system_date
                                                     ,ln_sp_last_premium_paid_date
                                                     ,ln_tv_last_paid_date
                                                     ,ln_last_dss_date);

       IF ln_retn_limit_late_vesting         != 0         AND
          ln_retn_limit_yearly_switch        != 0         AND
          ln_retirement_date                 != 0         AND
          ((ln_rp_last_premium_paid_date     != 0)        OR
           (ln_sp_last_premium_paid_date NOT IN (99999
                                                ,-99999)) OR
           (ln_tv_last_paid_date         NOT IN (99999
                                                ,-99999)) OR
           (ln_last_dss_date             NOT IN (99999
                                                ,-99999)))
       THEN

          OPEN cu_automatic_switches(ln_retn_limit_late_vesting
                                    ,ln_retn_limit_yearly_switch
                                    ,ln_retirement_date
                                    ,lv_policy_on_late_vesting
                                    ,pn_end_date);
          FETCH cu_automatic_switches INTO lr_automatic_switches;
                lb_error_found := cu_automatic_switches%FOUND;
          CLOSE cu_automatic_switches;

          IF lb_error_found THEN

             lv_error_message := 'Control Record Type: '||lr_automatic_switches.fndtrntyp||'~'||
                                 'Start Date: '||TO_CHAR(TO_DATE(TO_CHAR(lr_automatic_switches.strdte + 2415021),'J'),'DD-MON-YYYY')||'~'||
                                 'Effective Date: '||TO_CHAR(TO_DATE(TO_CHAR(lr_automatic_switches.efvdte + 2415021),'J'),'DD-MON-YYYY')||'~'||
                                 'End Date: '||TO_CHAR(TO_DATE(TO_CHAR(lr_automatic_switches.enddte + 2415021),'J'),'DD-MON-YYYY')||'~'||
                                 'Status: '||lr_automatic_switches.status||'~'||
                                 'Transaction Control Number: '||lr_automatic_switches.trnctl_no;

              p_raise_exception(pn_policy_number
                               ,777
                               ,lv_error_message
                               ,pv_product_type
                               );
          END IF;

          -- Check if the policy is invested on New Strategy
          IF NOT lb_error_found THEN

             OPEN cu_periodic_rebalancing(ln_retn_limit_late_vesting
                                         ,ln_retn_limit_yearly_switch
                                         ,ln_retirement_date
                                         ,lv_policy_on_late_vesting
                                         ,pn_end_date);
             FETCH cu_periodic_rebalancing INTO lr_periodic_rebalancing;
                   lb_error_found := cu_periodic_rebalancing%FOUND;
             CLOSE cu_periodic_rebalancing;

             IF lb_error_found THEN

                lv_error_message := 'Control Record Type: '||lr_periodic_rebalancing.fndtrntyp||'~'||
                                    'Start Date: '||TO_CHAR(TO_DATE(TO_CHAR(lr_periodic_rebalancing.strdte + 2415021),'J'),'DD-MON-YYYY')||'~'||
                                    'Effective Date: '||TO_CHAR(TO_DATE(TO_CHAR(lr_periodic_rebalancing.efvdte + 2415021),'J'),'DD-MON-YYYY')||'~'||
                                    'End Date: '||TO_CHAR(TO_DATE(TO_CHAR(lr_periodic_rebalancing.enddte + 2415021),'J'),'DD-MON-YYYY')||'~'||
                                    'Status: '||lr_periodic_rebalancing.status||'~'||
                                    'Transaction Control Number: '||lr_periodic_rebalancing.trnctl_no;

                 p_raise_exception(pn_policy_number
                                  ,777
                                  ,lv_error_message
                                  ,pv_product_type
                                  );
              END IF;
          END IF;

          -- Check if the policy is invested on Managed Strategy
          IF NOT lb_error_found THEN

             OPEN cu_rebalancing_managed(ln_retn_limit_late_vesting
                                        ,ln_retn_limit_yearly_switch
                                        ,ln_retirement_date
                                        ,lv_policy_on_late_vesting
                                        ,pn_end_date);
             FETCH cu_rebalancing_managed INTO lr_rebalancing_managed;
                   lb_error_found := cu_rebalancing_managed%FOUND;
             CLOSE cu_rebalancing_managed;

             IF lb_error_found THEN

                lv_error_message := 'Control Record Type: '||lr_rebalancing_managed.fndtrntyp||'~'||
                                    'Start Date: '||TO_CHAR(TO_DATE(TO_CHAR(lr_rebalancing_managed.strdte + 2415021),'J'),'DD-MON-YYYY')||'~'||
                                    'Effective Date: '||TO_CHAR(TO_DATE(TO_CHAR(lr_rebalancing_managed.efvdte + 2415021),'J'),'DD-MON-YYYY')||'~'||
                                    'End Date: '||TO_CHAR(TO_DATE(TO_CHAR(lr_rebalancing_managed.enddte + 2415021),'J'),'DD-MON-YYYY')||'~'||
                                    'Status: '||lr_rebalancing_managed.status||'~'||
                                    'Transaction Control Number: '||lr_rebalancing_managed.trnctl_no;

                p_raise_exception(pn_policy_number
                                 ,777
                                 ,lv_error_message
                                 ,pv_product_type
                                 );
              END IF;
           END IF;

           -- Check if the policy is invested on Fund Range
           IF NOT lb_error_found THEN

              OPEN cu_rebalancing_fund_range(ln_retn_limit_late_vesting
                                            ,ln_retn_limit_yearly_switch
                                            ,ln_retirement_date
                                            ,lv_policy_on_late_vesting
                                            ,pn_end_date);
              FETCH cu_rebalancing_fund_range INTO lr_rebalancing_fund_range;
                    lb_error_found := cu_rebalancing_fund_range%FOUND;
              CLOSE cu_rebalancing_fund_range;

              IF lb_error_found THEN

                 lv_error_message := 'Control Record Type: '||lr_rebalancing_fund_range.fndtrntyp||'~'||
                                     'Start Date: '||TO_CHAR(TO_DATE(TO_CHAR(lr_rebalancing_fund_range.strdte + 2415021),'J'),'DD-MON-YYYY')||'~'||
                                     'Effective Date: '||TO_CHAR(TO_DATE(TO_CHAR(lr_rebalancing_fund_range.efvdte + 2415021),'J'),'DD-MON-YYYY')||'~'||
                                     'End Date: '||TO_CHAR(TO_DATE(TO_CHAR(lr_rebalancing_fund_range.enddte + 2415021),'J'),'DD-MON-YYYY')||'~'||
                                     'Status: '||lr_rebalancing_fund_range.status||'~'||
                                     'Transaction Control Number: '||lr_rebalancing_fund_range.trnctl_no;

                  p_raise_exception(pn_policy_number
                                   ,777
                                   ,lv_error_message
                                   ,pv_product_type
                                   );
              END IF;
           END IF;
         END IF;
    END p_automatic_switch_check;

    -- procedure to check that there is an address for the policyholder
    PROCEDURE p_address_check(pv_client_address_category IN co040.adrclicat%TYPE
                             ,pn_client_address_ref      IN co040.adrcliref%TYPE
                             ,pv_product_type            IN pr010.prdref%TYPE
                             ,pn_address_ref             IN co040.adrref%TYPE
                             ,pn_policy_number           IN po010.polref%TYPE) IS

        CURSOR cu_address_details IS
            SELECT adrlneone
                  ,adrlnetwo
            FROM cl060
            WHERE clicat =  pv_client_address_category
            AND   cliref =  pn_client_address_ref
            AND   adrref =  pn_address_ref
            AND   maint  <> 'D'
            AND   strdte <> -99999
            AND   lpn_system_date BETWEEN cl060.strdte AND cl060.enddte;

        lr_address_details  cu_address_details%ROWTYPE;
        ln_exception_number NUMBER(3);
        lb_no_address       BOOLEAN := FALSE;

    BEGIN

        CASE NVL(pv_client_address_category,' ')
            WHEN ' ' THEN
                ln_exception_number := 752;
            WHEN 'GPS' THEN
                ln_exception_number := 754;
            WHEN 'ITR' THEN
                ln_exception_number := 753;
            ELSE
                ln_exception_number := 999;
        END CASE;

        OPEN cu_address_details;
        FETCH cu_address_details INTO lr_address_details;

        IF  (cu_address_details%NOTFOUND
        OR  (NVL(lr_address_details.adrlneone,' ')  =   ' '
         AND NVL(lr_address_details.adrlnetwo,' ')  =   ' ')
        OR       lr_address_details.adrlneone      LIKE '%UNKNOWN%'
        OR       lr_address_details.adrlnetwo      LIKE '%UNKNOWN%'
        OR       lr_address_details.adrlneone      LIKE '%GONE AWAY%'
        OR      (lr_address_details.adrlneone      LIKE '%GONE%'
         AND     lr_address_details.adrlnetwo      LIKE '%AWAY%')) THEN
            lb_no_address := TRUE;
        END IF;
        CLOSE cu_address_details;

        IF lb_no_address THEN
            p_raise_exception(pn_policy_number
                             ,ln_exception_number
                             ,NULL      -- error message
                             ,pv_product_type);
        END IF;
    END p_address_check;

    PROCEDURE p_fund_and_premium_check(pn_policy_number         IN po010.polref%TYPE
                                      ,pn_previous_renewal_date IN po100.actdte%TYPE
                                      ,pn_renewal_date          IN po100.actdte%TYPE
                                      ,pv_product_type          IN pr010.prdref%TYPE) IS

        CURSOR cu_fund_movements IS
            SELECT pr310.fndweenam
                  ,fi700.efvdte
                  ,data_description.itevalnam transaction_type
                  ,status_description.itevalnam status
                  ,fi700.evtunq
                  ,fi700.evttrn_no
                  ,fi700.inrtyp
                  ,fi700.inrref
            FROM fi700
            JOIN pr310
            ON fi700.fndref = pr310.fndref
            LEFT OUTER JOIN (SELECT itevalnam
                                   ,datiteval
                             FROM cs060
                             WHERE ispgrpnam =  'FI700'
                             AND   datitenam =  'FNDTRNTYP'
                             AND   maint     <> 'D') data_description
            ON fi700.fndtrntyp = data_description.datiteval
            LEFT OUTER JOIN (SELECT itevalnam
                                   ,datiteval
                             FROM cs060
                             WHERE ispgrpnam =  'FI700'
                             AND   datitenam =  'STA'
                             AND   maint     <> 'D') status_description
            ON fi700.staevt = LTRIM(status_description.datiteval,0)
            WHERE fi700.polref = pn_policy_number
            AND   fi700.staevt = 50
            AND   pr310.maint != 'D'
            AND   fi700.fndtrntyp IN ('RP','SP')
            AND   fi700.efvdte BETWEEN pn_previous_renewal_date AND pn_renewal_date-1
            AND NOT EXISTS (SELECT NULL
                            FROM event
                            WHERE unq = fi700.evtunq
                            AND   tranno = fi700.evttrn_no
                            AND   staevt = 55);

        lv_error_message    VARCHAR2(1803);

    BEGIN
        FOR lr_fund_movements IN cu_fund_movements LOOP

            lv_error_message := 'Investment Fund: '||lr_fund_movements.fndweenam||'~'||
                                'Effective Date: '||pck_utility.f_dtcnv(lr_fund_movements.efvdte)||'~'||
                                'Transaction Type: '||lr_fund_movements.transaction_type||'~'||
                                'Status: '||lr_fund_movements.status||'~'||
                                'Increment Type: '||lr_fund_movements.inrtyp||'~'||
                                'Increment Reference: '||lr_fund_movements.inrref||'~'||
                                'Unique reference: '||lr_fund_movements.evtunq||'~'||
                                'Transaction number: '||lr_fund_movements.evttrn_no;
            p_raise_exception(pn_policy_number
                             ,716
                             ,lv_error_message
                             ,pv_product_type);
        END LOOP;
    END p_fund_and_premium_check;

    PROCEDURE p_balance_and_holdings_check(pn_policy_number     IN po010.polref%TYPE
                                          ,pn_renewal_date      IN po100.actdte%TYPE
                                          ,pv_product_type      IN pr010.prdref%TYPE
                                          ,pn_statement_no      IN co055.untstm_no%TYPE
                                          ,pn_latest_start_date IN co055.strdte%TYPE) IS

        CURSOR cu_unit_details(pcn_statement_no      IN co055.untstm_no%TYPE
                              ,pcn_latest_start_date IN co055.strdte%TYPE) IS
            SELECT co055.fndweenam
                  ,co055.fnd_id
                  ,co055.total_units - NVL(fi700.units_after_renewal,0) fndqt_current
                  ,NVL(co055_2.total_units,0) + NVL(fi700.units_before_renewal,0) - NVL(reversed_before_renewal,0) fndqt_previous
            FROM (SELECT co055.fndref
                        ,pr310.fndweenam
                        ,pr310.fnd_id
                        ,SUM(co055.benqty1) total_units
                  FROM co055
                  JOIN pr310
                  ON co055.fndref = pr310.fndref
                  WHERE co055.untstm_no = 999
                  AND   co055.polref    = pn_policy_number
                  AND   co055.stastd    = 30
                  AND   co055.maint    != 'D'
                  AND   pr310.maint    != 'D'
                  GROUP BY co055.fndref
                          ,pr310.fndweenam
                          ,pr310.fnd_id) co055
            LEFT OUTER JOIN (SELECT co055.fndref
                                   ,SUM(co055.benqty1) total_units
                             FROM co055
                             WHERE co055.untstm_no = pcn_statement_no
                             AND   co055.polref    = pn_policy_number
                             AND   co055.strdte    = pcn_latest_start_date
                             AND   co055.stastd    = 30
                             AND   co055.maint    != 'D'
                             GROUP BY co055.fndref) co055_2
            ON co055.fndref = co055_2.fndref
            LEFT OUTER JOIN (SELECT fndref
                                   ,SUM(CASE
                                            WHEN efvdte < pn_renewal_date AND untstm_no = 999 AND staevt IN (50,65) THEN
                                                benqty1
                                            ELSE
                                                0
                                        END) units_before_renewal
                                   ,SUM(CASE
                                            WHEN efvdte >= pn_renewal_date AND staevt IN (50,65) THEN
                                                benqty1
                                            ELSE
                                                0
                                        END) units_after_renewal
                                    ,SUM(CASE
                                            WHEN staevt = 70 AND untstm_no < 999
                                            THEN
                                                benqty1
                                            ELSE
                                                0
                                        END) reversed_before_renewal
                             FROM fi700
                             WHERE polref = pn_policy_number
                             GROUP BY fndref) fi700
            ON  co055.fndref    = fi700.fndref
            WHERE co055.total_units - NVL(fi700.units_after_renewal,0)
                              != NVL(co055_2.total_units,0) + NVL(fi700.units_before_renewal,0) - NVL(reversed_before_renewal,0);

        lv_error_message            VARCHAR2(1803);

    BEGIN
        FOR lr_unit_details IN cu_unit_details(NVL(pn_statement_no,0)
                                              ,NVL(pn_latest_start_date,0)) LOOP
            lv_error_message := 'Investment Fund: '||lr_unit_details.fndweenam||'~'||
                                'Fund Code: '||lr_unit_details.fnd_id||'~'||
                                'FNDQT(pre) + FI700(effective date < renewal date): '||
                                                     lr_unit_details.fndqt_previous||'~'||
                                'FNDQT(cur) - FI700(effective date >= renewal date): '||
                                                     lr_unit_details.fndqt_current;

            p_raise_exception(pn_policy_number
                             ,779
                             ,lv_error_message
                             ,pv_product_type);

        END LOOP;

    END p_balance_and_holdings_check;

    PROCEDURE p_zero_policy_value_check(pn_policy_number IN  po010.polref%TYPE
                                       ,pv_product_type  IN  pr010.prdref%TYPE
                                       ,pn_currency_date IN po010.polcrcdte%TYPE
                                       ,pb_nonzero_value OUT BOOLEAN) IS

        CURSOR cu_increment_detail (pcn_policy_number  po010.polref%TYPE)
        IS
                SELECT 1                          --check if there an non DSS increment with investment
                FROM  po020 po                      --for the policy
                WHERE po.polref      =   pcn_policy_number
                AND   po.maint      !=   'D'
                AND   po.inrtyp     !=   'DSS'
                AND   po.stainr     IN   (30,52)
                AND   po.maibentyp  LIKE 'INV%'
                AND   EXISTS (SELECT 1            --need to check whether the 1st increment is live
                              FROM  po020 po2
                              WHERE po2.maint !=  'D'
                              AND   po2.polref =  po.polref
                              AND   po2.inrtyp =  po.inrtyp
                              AND   po2.inrref =  1
                              AND   po2.stainr IN (30,52))
                AND   NOT EXISTS (SELECT 1        -- need to check there is no LIV ASAP or Initial charge triggers
                                  FROM pa020 pa   -- as this can result in a valid zero policy value
                                  WHERE pa.polref    = po.polref
                                  AND   pa.fndtrntyp IN ('CCI', 'ACI')
                                  AND   pa.sta_pa    = 30)
                AND   NOT EXISTS (SELECT 1
                                  FROM pa020 pa    -- need to check there is no ACT ASAP or Initial charge triggers
                                      ,po030 po3   -- which has been ACT within a frequency period
                                  WHERE pa.polref    = po.polref
                                  AND   pa.fndtrntyp IN ('CCI', 'ACI')
                                  AND   pa.inrtyp NOT IN ('SP', 'TV')
                                  AND   pa.sta_pa    = 50
                                  AND   pa.polref    = po3.polref
                                  AND   pa.inrtyp    = po3.inrtyp
                                  AND   pa.inrref    = po3.inrref
                                  AND   pck_utility.f_dtcnv(pa.efvdte) >= pck_dates.f_subtract_frequency
                                                                (pd_old_date  => lpd_system_date
                                                                ,pv_frequency => po3.prmfrq));

        ln_current_policy_value co055.benqty1%TYPE;
        lr_increment_detail     cu_increment_detail%ROWTYPE;
        lv_error_message        VARCHAR2(1803);

    BEGIN
        SELECT NVL(SUM(benqty1),0)
        INTO ln_current_policy_value
        FROM co055
        WHERE polref    = pn_policy_number
        AND   untstm_no = 999
        AND   stastd    = 30
        AND   maint    != 'D';

        IF ln_current_policy_value = 0 THEN
            pb_nonzero_value := FALSE;

            OPEN cu_increment_detail(pn_policy_number);
            FETCH cu_increment_detail INTO lr_increment_detail;

               IF cu_increment_detail%FOUND              AND
                  pn_currency_date NOT IN (99999,-99999) THEN

                   lv_error_message := 'Commencement Date: '|| pck_utility.f_dtcnv(pn_currency_date) || '~' ||
                                       'DSS only?: No';

                   p_raise_exception(pn_policy_number
                                    ,782
                                    ,lv_error_message
                                    ,pv_product_type);
               END IF;
            CLOSE cu_increment_detail;
        ELSE
            pb_nonzero_value := TRUE;
        END IF;
    END p_zero_policy_value_check;

    PROCEDURE p_zero_policy_value_check_DSS(pn_policy_number IN  po010.polref%TYPE
                                           ,pv_product_type  IN  pr010.prdref%TYPE
                                           ,pn_currency_date IN po010.polcrcdte%TYPE
                                           ,pb_nonzero_value OUT BOOLEAN) IS

        CURSOR cu_increment_detail(pcn_policy_number IN  po010.polref%TYPE)
        IS
            SELECT 1                                         --check for DSS increment with investment
            FROM  po020 po
            WHERE po.polref     =   pcn_policy_number
            AND   po.maint     !=   'D'
            AND   po.inrtyp     =   'DSS'
            AND   po.stainr    IN   (30,52)
            AND   po.maibentyp LIKE 'INV%'
            AND NOT EXISTS (SELECT 1
                            FROM po020 po2
                            WHERE po2.polref      =   po.polref
                            AND   po2.maint      !=   'D'
                            AND   po2.inrtyp     !=   'DSS'
                            AND   po2.stainr     IN   (30,52)
                            AND   po2.maibentyp  LIKE 'INV%'
                            AND   EXISTS (SELECT 1            --need to check whether the 1st increment is live
                                          FROM  po020 po3
                                          WHERE po3.maint  !=  'D'
                                          AND   po3.polref  =  po2.polref
                                          AND   po3.inrtyp  =  po2.inrtyp
                                          AND   po3.inrref  =  1
                                          AND   po3.stainr IN (30,52)));

        ln_current_policy_value co055.benqty1%TYPE;
        lr_increment_detail     cu_increment_detail%ROWTYPE;
        lv_error_message        VARCHAR2(1803);

    BEGIN
        SELECT NVL(SUM(benqty1),0)
        INTO ln_current_policy_value
        FROM co055
        WHERE polref    = pn_policy_number
        AND   untstm_no = 999
        AND   stastd    = 30
        AND   maint    != 'D';

        IF ln_current_policy_value = 0 THEN
            pb_nonzero_value := FALSE;

            OPEN cu_increment_detail(pn_policy_number);
            FETCH cu_increment_detail INTO lr_increment_detail;

                IF cu_increment_detail%FOUND              AND
                   pn_currency_date NOT IN (99999,-99999) THEN

                    lv_error_message := 'Commencement Date: '|| pck_utility.f_dtcnv(pn_currency_date) || '~' ||
                                        'DSS only?: Yes';

                    p_raise_exception(pn_policy_number
                                     ,40
                                     ,lv_error_message
                                     ,pv_product_type);
            END IF;
        ELSE
            pb_nonzero_value := TRUE;
        END IF;
    END p_zero_policy_value_check_DSS;

    PROCEDURE p_negative_AMC_check(pn_policy_number IN po010.polref%TYPE
                                  ,pn_start_date    IN po100.actdte%TYPE
                                  ,pn_end_date      IN po100.actdte%TYPE
                                  ,pv_product_type  IN pr010.prdref%TYPE) IS

        lv_error_message        VARCHAR2(1803);

    BEGIN

        IF lpn_policy_with_fund_movements != pn_policy_number OR
           lpn_fund_movement_date         != pn_start_date    THEN
            p_fetch_fund_movements (pn_policy_number
                                   ,pn_start_date);
        END IF;

        IF lpb_fund_movements THEN
            FOR i IN lpr_fund_movements.FIRST..lpr_fund_movements.LAST LOOP

                IF lpr_fund_movements(i).staevt     IN (5,30,50)    AND
                   lpr_fund_movements(i).efvdte     <= pn_end_date  AND
                   lpr_fund_movements(i).amt        < 0             AND
                   lpr_fund_movements(i).fndtrntyp  = 'AMC'         THEN

                    lv_error_message := 'Investment Fund: '||lpr_fund_movements(i).fndweenam||'~'||
                                        'Effective Date: '||pck_utility.f_dtcnv(lpr_fund_movements(i).efvdte)||'~'||
                                        'Transaction Type: '||lpr_fund_movements(i).fndtrntyp||'~'||
                                        'Status: '||lpr_fund_movements(i).status||'~'||
                                        'Statement Number: '||lpr_fund_movements(i).untstm_no||'~'||
                                        'Unique Reference: '||lpr_fund_movements(i).evtunq||'~'||
                                        'Transaction Number: '||lpr_fund_movements(i).evttrn_no;
                    p_raise_exception(pn_policy_number
                                     ,701
                                     ,lv_error_message
                                     ,pv_product_type
                                     );
                END IF;
            END LOOP;
        END IF;
    END p_negative_AMC_check;

    PROCEDURE p_carried_fwrd_mismatch_check(pn_policy_number         IN po010.polref%TYPE
                                           ,pn_renewal_date          IN po100.actdte%TYPE
                                           ,pv_product_type          IN pr010.prdref%TYPE
                                           ,pn_statement_no          IN co055.untstm_no%TYPE) IS

        CURSOR cu_wp_unit_details IS
            SELECT co055.fndweenam
                  ,co055.untstm_no
                  ,DECODE(co055.untstm_no,999,0,NVL(co055.total_units,0))
                                    + NVL(fi700.units_before_renewal,0) - NVL(reversed_before_renewal,0) fndqt_previous
            FROM (SELECT co055.fndref
                        ,SUM(co055.benqty1) total_units
                        ,pr310.fndweenam
                        ,co055.untstm_no
                  FROM co055
                  JOIN pr310
                  ON co055.fndref = pr310.fndref
                  WHERE co055.untstm_no IN (pn_statement_no,999)
                  AND   co055.polref    = pn_policy_number
                  AND   co055.stastd    = 30
                  AND   co055.maint    != 'D'
                  AND   pr310.maint    != 'D'
                  AND   pr310.fnd_id IN ('WPU','WU2','WU3')
                  AND   co055.strdte = (SELECT MAX(a.strdte)
                                        FROM co055 a JOIN pr310 b
                                        ON a.fndref = b.fndref
                                        WHERE a.untstm_no = co055.untstm_no
                                        AND   a.polref    = pn_policy_number
                                        AND   a.stastd    = 30
                                        AND   a.maint    != 'D'
                                        AND   b.maint    != 'D'
                                        AND   b.fnd_id    = pr310.fnd_id)
                  GROUP BY co055.fndref
                          ,pr310.fndweenam
                          ,co055.untstm_no) co055
            LEFT OUTER JOIN (SELECT fndref
                                ,SUM(CASE
                                        WHEN efvdte < pn_renewal_date AND untstm_no = 999 AND staevt IN (50,65) THEN
                                            benqty1
                                        ELSE
                                            0
                                    END) units_before_renewal
                                ,SUM(CASE
                                        WHEN staevt = 70 AND untstm_no < 999 THEN
                                            benqty1
                                        ELSE
                                            0
                                    END) reversed_before_renewal
                             FROM fi700
                             WHERE polref = pn_policy_number
                             GROUP BY fndref) fi700
            ON  co055.fndref    = fi700.fndref
            ORDER BY co055.untstm_no
                    ,co055.fndweenam;

        lr_wp_unit_details      cu_wp_unit_details%ROWTYPE;
        lr_talqte_inputs        pck_aql_wrapper.r_talqte_inputs;
        ln_total_basic_ar       NUMBER(10,2);
        ln_total_declared_ar    NUMBER(10,2);
        ln_total_interim_ar     NUMBER(10,2);
        ln_total_basic_pr       NUMBER(10,2);
        ln_total_declared_pr    NUMBER(10,2);
        ln_total_interim_pr     NUMBER(10,2);
        ln_total_terminal_bonus NUMBER(10,2);
        ln_total_WP_holdings    NUMBER(14,2);
        lv_error_message        VARCHAR2(1803);

    BEGIN
        OPEN cu_wp_unit_details;
        FETCH cu_wp_unit_details INTO lr_wp_unit_details;
        CLOSE cu_wp_unit_details;

        -- only need to do the rest if there is WP units
        IF NVL(lr_wp_unit_details.fndqt_previous,0) > 0 THEN

            lr_talqte_inputs.policy_reference   := pn_policy_number;
            lr_talqte_inputs.quote_date         := pn_renewal_date - 1;
            lr_talqte_inputs.exaprcind          := 'N';
            lr_talqte_inputs.quote_type         := 'F';
            lr_talqte_inputs.calculate_PUP_fund := 'N';
            lr_talqte_inputs.penalty_free_ind   := ' ';

            pck_aql_wrapper.p_talqte_withprofit_values(lr_talqte_inputs
                                                      ,ln_total_basic_ar
                                                      ,ln_total_declared_ar
                                                      ,ln_total_interim_ar
                                                      ,ln_total_basic_pr
                                                      ,ln_total_declared_pr
                                                      ,ln_total_interim_pr
                                                      ,ln_total_terminal_bonus);

            -- to get WP fund holdings need to divide by 0.95
            ln_total_WP_holdings := (ln_total_basic_ar
                                   + ln_total_basic_pr
                                   + ln_total_declared_ar
                                   + ln_total_declared_pr) /0.95;

            IF lr_wp_unit_details.fndqt_previous NOT BETWEEN ln_total_WP_holdings - 1
                                                         AND ln_total_WP_holdings + 1 THEN
                lv_error_message := 'Investment Fund: '||lr_wp_unit_details.fndweenam||'~'||
                                    'FNDQT(pre) + FI700s(effective date < review date): '||lr_wp_unit_details.fndqt_previous||'~'||
                                    'Basic + Declared Benefit (provided by TALQTE): '||ln_total_WP_holdings;
                p_raise_exception(pn_policy_number
                                 ,783
                                 ,lv_error_message
                                 ,pv_product_type
                                 );
            END IF;

        END IF;

    EXCEPTION
        -- don't want package to fall over just because TALQTE has failed
        WHEN OTHERS THEN
            lv_error_message := 'Values from TALQTE cannot be calculated for this policy~'||
                                gla.gl_errare||gla.gl_err_no||' - '||pck_prod_support.f_error_msg(gla.gl_errare
                                                                                                 ,gla.gl_err_no);
            p_raise_exception(pn_policy_number
                             ,783
                             ,lv_error_message
                             ,pv_product_type
                             );

    END p_carried_fwrd_mismatch_check;

    PROCEDURE p_with_profit_check(pn_policy_number IN po010.polref%TYPE
                                 ,pn_end_date      IN po100.actdte%TYPE
                                 ,pv_product_type  IN pr010.prdref%TYPE) IS

        lv_error_message    VARCHAR2(1803);

    BEGIN

        IF lpn_policy_with_fund_movements != pn_policy_number OR
           lpn_fund_movement_date         != pn_end_date      THEN
            p_fetch_fund_movements (pn_policy_number
                                   ,PN_END_DATE);
        END IF;

        IF lpb_fund_movements THEN
            FOR i IN lpr_fund_movements.FIRST..lpr_fund_movements.LAST LOOP

                IF lpr_fund_movements(i).fnd_id  IN ('WPU','WU2','WU3') AND
                   lpr_fund_movements(i).staevt  = 50                   AND
                   lpr_fund_movements(i).benqty1 > 0                    AND
                   lpr_fund_movements(i).efvdte  <= pn_end_date         THEN

                    lv_error_message := 'Investment Fund: '||lpr_fund_movements(i).fndweenam||'~'||
                                        'Effective Date: '||pck_utility.f_dtcnv (lpr_fund_movements(i).efvdte)||'~'||
                                        'Transaction Type: '||lpr_fund_movements(i).fndtrntyp||'~'||
                                        'Status: '||lpr_fund_movements(i).status||'~'||
                                        'Statement Number: '||lpr_fund_movements(i).untstm_no||'~'||
                                        'Unique Reference: '||lpr_fund_movements(i).evtunq||'~'||
                                        'Transaction Number: '||lpr_fund_movements(i).evttrn_no;
                    p_raise_exception(pn_policy_number
                                     ,702
                                     ,lv_error_message
                                     ,pv_product_type
                                     );
                END IF;
            END LOOP;
        END IF;
    END p_with_profit_check;

    PROCEDURE p_fund_management_charge_check(pn_policy_number IN po010.polref%TYPE
                                            ,pn_start_date    IN po100.actdte%TYPE
                                            ,pv_product_type  IN pr010.prdref%TYPE) IS

        CURSOR cu_fund_details IS
            SELECT DISTINCT co058.fndref
                           ,co058.fndsubtyp
                           ,pr310.fndweenam
                           ,pr315.mgmfeepct
            FROM co058
            JOIN pr310
            ON co058.fndref = pr310.fndref
            JOIN pr315
            ON  co058.fndref    = pr315.fndref
            AND co058.fndsubtyp = pr315.fndsubtyp
            WHERE co058.polref    = pn_policy_number
            AND   co058.sta       = 30
            AND   co058.enddte    > pn_start_date
            AND   co058.benqty   != 0
            AND   pr315.maint    != 'D'
            AND   pr310.maint    != 'D'
            AND   pr315.mgmfeepct > 1;

        lv_error_message            VARCHAR2(1803);

    BEGIN
        FOR lr_fund_details IN cu_fund_details LOOP

            -- If the charge is > 1, raise an error
               lv_error_message := 'Investment Fund: '||lr_fund_details.fndweenam||'~'||
                                   'Investment FMC: '||lr_fund_details.mgmfeepct;

                p_raise_exception(pn_policy_number
                                 ,703
                                 ,lv_error_message
                                 ,pv_product_type
                                 );
        END LOOP;

    END p_fund_management_charge_check;

    PROCEDURE p_last_premium_paid_check(pn_policy_number  IN po010.polref%TYPE
                                       ,pn_start_date     IN po100.actdte%TYPE
                                       ,pn_end_date       IN po100.actdte%TYPE
                                       ,pv_product_type   IN pr010.prdref%TYPE) IS

        CURSOR cu_summary_event_details IS
            SELECT NULL
            FROM event
            WHERE polref = pn_policy_number
            AND   ispec  = 'FI561'
            AND   staevt = 40
            AND   inrtyp IN ('ORD','AVCO')
            AND   trntyp1 IN ('RP','ABP','AOP','ARP','FP','IRP','MN1');

        lr_summary_event_details    cu_summary_event_details%ROWTYPE;
        lb_raise_exception          BOOLEAN := FALSE;
        ln_index PLS_INTEGER := 0;
        lb_last_prem_found BOOLEAN;
    BEGIN
        IF pv_product_type IN ('TAL-SSA86','TAL-EPP','TAL-FSAVC','TAL-S226','TAL-S226A') THEN
            OPEN cu_summary_event_details;
            FETCH cu_summary_event_details INTO lr_summary_event_details;
            lb_raise_exception := cu_summary_event_details%NOTFOUND;
            CLOSE cu_summary_event_details;
        ELSE
            -- Get the premiums into the local collection if we haven't already
            IF lpn_policy_with_premiums != pn_policy_number THEN
                p_fetch_premiums(pn_policy_number
                                ,pn_start_date
                                ,pn_end_date
                                );
            END IF;

            ln_index := lpr_premiums.FIRST;
            lb_last_prem_found := FALSE;
            WHILE NOT lb_last_prem_found   AND
                      lpb_premiums_exist   AND
                  NOT lb_raise_exception   AND
                      ln_index IS NOT NULL AND
                      lpr_premiums(ln_index).last_premium_paid_partition = 1 LOOP

                IF lpr_premiums(ln_index).last_premium_paid IS NOT NULL THEN
                    IF ADD_MONTHS(pck_utility.f_dtcnv(lpr_premiums(ln_index).last_premium_paid),4)
                                                                <= pck_utility.f_dtcnv(pn_end_date) THEN
                        lb_raise_exception := TRUE;
                    END IF;
                    lb_last_prem_found := TRUE;
                END IF;
                ln_index := lpr_premiums.NEXT(ln_index);
            END LOOP;
            IF NOT lb_last_prem_found THEN
                lb_raise_exception := TRUE;
            END IF;
        END IF;

        IF lb_raise_exception THEN
            p_raise_exception(pn_policy_number
                             ,769
                             ,NULL      -- no error message
                             ,pv_product_type
                             );
        END IF;
    END p_last_premium_paid_check;

    ------------------------- PUBLIC PROCEDURES ---------------------------------------------

    -- procedure to check whether there is any outstanding new business for the policy
    PROCEDURE p_outstanding_new_bus_check(pn_policy_number         IN co040.polref%TYPE
                                         ,pn_policy_status         IN po010.stapol%TYPE
                                         ,pv_status_description    IN cs060.itevaldes%TYPE
                                         ,pn_renewal_date          IN pa021.rnwdte%TYPE
                                         ,pv_product_type          IN pr010.prdref%TYPE) IS

        CURSOR cu_new_business_details IS
            SELECT (CASE WHEN nb005.pcsstg = -1
             THEN 'Keyed to Web'
             WHEN nb005.pcsstg = 0
             THEN 'Uploaded'
             ELSE
             NVL(data_description.itevaldes,'Unknown process stage')
             END) AS status_description
             ,nb005.pcsstg
             ,nb005.crcdte crcdte
             ,nb005.pplacpdte
             ,(CASE WHEN nb005.pcsstg IN (52, 90)
                    THEN  nb005.pplenddte
                    ELSE  nb010.cmpdte
               END) AS    cmp_date
            ,cl045.pcsstg cl045_pcsstg
            ,po020.inrtyp increment_type
            ,po020.inrref increment_ref
            FROM (SELECT DECODE(pcsstg,02,01
                               ,11,10
                               ,pcsstg) pcsstg
                        ,crcdte
                        ,pplacpdte
                        ,pplenddte
                        ,pplref
                        ,maint
                        ,pplunq
                  FROM nb005) nb005
            LEFT OUTER JOIN cl045
            ON  nb005.pplref = cl045.polref
            AND nb005.pplunq = cl045.xrfunq
            AND cl045.maint != 'D'
            LEFT OUTER JOIN nb010
            ON  nb005.pplref = nb010.pplref
            AND nb005.pplunq = nb010.pplunq
            AND nb010.maint != 'D'
            LEFT OUTER JOIN po020
            ON  nb005.pplref = po020.polref
            AND nb005.pplunq = po020.pplunq
            LEFT OUTER JOIN (SELECT itevaldes
                                   ,datiteval
                              FROM cs060
                              WHERE ispgrpnam =  'NB005'
                              AND   datitenam =  'PCSSTG'
                              AND   maint     <> 'D') data_description
            ON nb005.pcsstg = data_description.datiteval
            WHERE nb005.pplref  = pn_policy_number
            AND   nb005.crcdte  < pn_renewal_date
            AND   nb005.maint  <> 'D'
            AND   nb005.pplunq <> 0
            UNION
            SELECT (CASE WHEN b.status = 'E'
                    THEN 'Expected'
                    WHEN b.status = 'U'
                    THEN 'Uploading'
                    END) AS status_description
                   ,0
                   ,pck_utility.f_dtcnv(mis.created_date) crcdte
                   ,0
                   ,NULL
                   ,0
                   ,b.increment_type increment_type
                   ,b.increment_reference increment_ref
           FROM multiple_increment_summary mis
           INNER JOIN multiple_increments b ON mis.ID = b.mi_summary_id
           WHERE mis.policy_reference = pn_policy_number
           AND   pck_utility.f_dtcnv(mis.created_date) < pn_renewal_date
           AND   b.status IN ('E', 'U')
           AND NOT EXISTS (SELECT 1 FROM nb005 nb
                           WHERE  nb.pplref = mis.policy_reference
                           AND    nb.pcsstg = 1
                           AND    nb.ppldte = pck_utility.f_dtcnv(mis.created_date));

        lr_new_business_details     cu_new_business_details%ROWTYPE;
        lv_error_message            VARCHAR2(1803);
        lb_exception_found          BOOLEAN;

    BEGIN
        FOR lr_new_business_details IN cu_new_business_details LOOP

            lb_exception_found := FALSE;    -- need to reset at start of each loop

            IF lr_new_business_details.pcsstg NOT IN (50,52,53,54,90) OR
               lr_new_business_details.status_description IN ('Expected', 'Uploading') THEN

                lb_exception_found := TRUE;

                IF  lr_new_business_details.pcsstg = 30
                AND (lr_new_business_details.pplacpdte    = -99999
                OR   lr_new_business_details.cl045_pcsstg < 60) THEN

                    lr_new_business_details.status_description := 'Awaiting U/W';

                END IF;

                lv_error_message := lr_new_business_details.status_description;

            ELSIF pn_policy_status < 30 THEN

                lb_exception_found := TRUE;
                lv_error_message   := pv_status_description;

            END IF;

            IF lb_exception_found THEN
                IF pv_product_type != 'GPS' THEN
                    lv_error_message := 'Increment Type: '||lr_new_business_details.increment_type||'~'||
                                        'Currency Date: '||pck_utility.f_dtcnv(lr_new_business_details.crcdte)||'~'||
                                        'Status: '||lv_error_message||'~'||
                                        'Completion Date: ' ||pck_utility.f_dtcnv(lr_new_business_details.cmp_date);
                    IF pn_policy_status NOT IN (30,52) THEN
                        lv_error_message := lv_error_message||'~'||pn_policy_number;
                    END IF;
                END IF;

                p_raise_exception(pn_policy_number    => pn_policy_number
                                 ,pn_exception_number => 712
                                 ,pv_error_message    => lv_error_message
                                 ,pv_product_type     => pv_product_type
                                 );

            END IF;
        END LOOP;
    END p_outstanding_new_bus_check;

    -- procedure to check that all policies or the scheme has a live ITR
    PROCEDURE p_CSNXR_ITR_check(pn_policy_number   IN  co040.polref%TYPE
                               ,pn_record_status   IN  co040.staxrf%TYPE
                               ,pn_ITR_number      OUT co040.cliref%TYPE
                               ,pb_ITR_found       OUT BOOLEAN
                               ,pv_product_type    IN  pr010.prdref%TYPE) IS

        CURSOR cu_ITR_details IS
        SELECT /*+ all_rows */ cliref
        FROM co040
        WHERE polref =  pn_policy_number
        AND   rolref =  'ITR'
        AND   staxrf =  pn_record_status
        AND   clicat =  'ITR'
        AND   jtlind =  1
        AND   maint  <> 'D'
        AND   lpn_system_date BETWEEN strdte AND enddte
        AND   enddte = 99999
        ORDER BY cliref, xrfunq;

        ln_exception_number NUMBER(3);
        lv_error_message    VARCHAR2(1803);

    BEGIN
        OPEN cu_ITR_details;

        FETCH cu_ITR_details INTO pn_ITR_number;

        IF cu_ITR_details%NOTFOUND THEN

            pb_ITR_found := FALSE;

            IF pn_record_status = 10 THEN

                lv_error_message := 'CSNXR ITR record at status '||pn_record_status||
                                    ' with joint life indicator equal to 1 required';

                ln_exception_number := 715;

            ELSIF pn_record_status = 30 THEN

                ln_exception_number := 755;

            END IF;

        ELSE
            pb_ITR_found := TRUE;
        END IF;

        CLOSE cu_ITR_details;

        IF NOT pb_ITR_found THEN
            p_raise_exception(pn_policy_number
                             ,ln_exception_number
                             ,lv_error_message
                             ,pv_product_type);
        END IF;
    END p_CSNXR_ITR_check;

    -- procedure to check that there is an address for the policyholder
    PROCEDURE p_address_check(pv_client_address_category IN co040.adrclicat%TYPE
                             ,pn_client_address_ref      IN co040.adrcliref%TYPE
                             ,pn_address_ref             IN co040.adrref%TYPE DEFAULT 1) IS
    BEGIN
        p_address_check(pv_client_address_category => pv_client_address_category
                       ,pn_client_address_ref => pn_client_address_ref
                       ,pv_product_type => 'GPS'   -- product type
                       ,pn_address_ref => pn_address_ref
                       ,pn_policy_number => NULL    -- policy number
                       );  -- start date
    END p_address_check;

    /***********************************************************************************************************
    -- %Description  Procedure to check for negative values on FNDQT
    -- %param        pn_polref         IN    po010.polref%TYPE
    -- %param        pv_product_type   IN    pr010.prdref%TYPE
    -- %raises       OTHERS
    ***********************************************************************************************************/
    PROCEDURE p_negative_FNDQT_check(pn_policy_number IN po010.polref%TYPE
                                    ,pv_product_type  IN pr010.prdref%TYPE) IS

        CURSOR cu_FNDQT_details IS
            SELECT pr310.fndweenam
                  ,pr310.fnd_id
                  ,DECODE(co055.untstmdte,-99999,lpn_system_date,co055.untstmdte) statement_date
                  ,co055.benqty1
            FROM co055
            JOIN pr310
            ON co055.fndref = pr310.fndref
            WHERE co055.polref  = pn_policy_number
            AND   co055.stastd  = 30
            AND   co055.maint  != 'D'
            AND   pr310.maint  != 'D'
            AND   co055.benqty1 < 0
            AND  (co055.untstm_no, co055.strdte) = (SELECT MAX(untstm_no), MAX(strdte)
                                                    FROM co055 a
                                                    WHERE polref     = co055.polref
                                                    AND   stastd     = 30
                                                    AND   untstm_no != 999
                                                    AND   maint     != 'D')
            AND NOT EXISTS ( SELECT 1
			                 FROM po100
			                 WHERE po100.polref = co055.polref
			                 AND po100.MAINT != 'D'
			                 AND po100.sta = 50
			                 AND po100.actref = 'RS-CNTOPT');

        lr_FNDQT_details    cu_FNDQT_details%ROWTYPE;
        lv_error_message    VARCHAR2(1803);
        lb_exception_found  BOOLEAN := FALSE;

    BEGIN
        OPEN cu_FNDQT_details;
        FETCH cu_FNDQT_details INTO lr_FNDQT_details;
        IF cu_FNDQT_details%FOUND THEN
            lb_exception_found := TRUE;
            IF pv_product_type != 'GPS' THEN
                lv_error_message := 'Investment Fund: '||lr_FNDQT_details.fndweenam||'~'||
                                    'Fund Code: ' || lr_FNDQT_details.fnd_id||'~'||
                                    'Statement Date: '||pck_utility.f_dtcnv(lr_FNDQT_details.statement_date)||'~'||
                                    'Benefit Quantity: '||lr_FNDQT_details.benqty1;
            END IF;
        END IF;
        CLOSE cu_FNDQT_details;

        IF lb_exception_found THEN
            p_raise_exception(pn_policy_number
                             ,781
                             ,lv_error_message
                             ,pv_product_type);
        END IF;
    END p_negative_FNDQT_check;

    -- procedure to check that premium events have a corresponding fund movement
    PROCEDURE p_premium_event_check(pn_policy_number         IN po010.polref%TYPE
                                   ,pn_previous_renewal_date IN pa022.rnwdte%TYPE
                                   ,pn_renewal_date          IN pa022.rnwdte%TYPE
                                   ,pv_product_type          IN pr010.prdref%TYPE) IS

        lv_error_message    VARCHAR2(1803);

    BEGIN
        -- Get the premiums into the local collection if we haven't already
        IF lpn_policy_with_premiums != pn_policy_number THEN
            p_fetch_premiums(pn_policy_number
                            ,pn_previous_renewal_date
                            ,pn_renewal_date
                            );
        END IF;

        IF lpb_premiums_exist THEN
            FOR i IN lpr_premiums.FIRST..lpr_premiums.LAST LOOP

                IF lpr_premiums(i).check_fund_movement IS NOT NULL THEN
                    lv_error_message := 'Premium Group: '||lpr_premiums(i).trnprmgrp||'~'||
                                        'Due Date: '||pck_utility.f_dtcnv (lpr_premiums(i).due_date)||'~'||
                                        'Effective Date: '||pck_utility.f_dtcnv(lpr_premiums(i).coll_date)||'~'||
                                        'Premium Status: '||lpr_premiums(i).event_status||'~'||
                                        'Increment Type: '||lpr_premiums(i).event_increment||'~'||
                                        'Increment Reference: '||lpr_premiums(i).event_increment_ref||'~'||
                                        'Unique Reference: '||lpr_premiums(i).event_unq||'~'||
                                        'Unique Transaction Number: '||lpr_premiums(i).event_tranno;

                    p_raise_exception(pn_policy_number
                                     ,734                -- exception number
                                     ,lv_error_message
                                     ,pv_product_type
                                     );
                END IF;
            END LOOP;
        END IF;
    END p_premium_event_check;

    -- procedure to raise an exception for a pending exit policy
    PROCEDURE p_raise_pending_exit(pn_policy_number   IN po010.polref%TYPE
                                  ,pv_product_type    IN pr010.prdref%TYPE) IS

        CURSOR cu_exit_details IS
            SELECT audupddte
            FROM aq090
            WHERE polref = pn_policy_number
            AND   maint != 'D';

        lr_exit_details     cu_exit_details%ROWTYPE;
        lv_error_message    VARCHAR2(1803);
        lb_exit_rec_found   BOOLEAN := FALSE;

    BEGIN
        OPEN cu_exit_details;
        FETCH cu_exit_details INTO lr_exit_details;
        lb_exit_rec_found := cu_exit_details%FOUND;
        CLOSE cu_exit_details;

        IF lb_exit_rec_found THEN
            lv_error_message := 'Update Date: '||pck_utility.f_dtcnv(lr_exit_details.audupddte);

            p_raise_exception(pn_policy_number
                             ,711                -- exception number
                             ,lv_error_message
                             ,pv_product_type
                             );
        END IF;

    END p_raise_pending_exit;

    ---------------------------------------------------------------------------------
    -- Procedure to check settlement mail for rejected income payments on IR cases --
    ---------------------------------------------------------------------------------
    PROCEDURE p_settlement_IR_failed_payment (pn_policy_number  IN po010.polref%TYPE
                                             ,pv_product_type   IN pr010.prdref%TYPE) IS

        -- Find any problem payments for the policy.
        CURSOR cu_problem_payments(pcn_policy_reference  payment_history.policy_reference%TYPE)
        IS
        SELECT status, net_amount, tax_amount, gross_amount, payment_due_date, actual_payment_date
        FROM   payment_history
        WHERE  policy_reference = pcn_policy_reference
        AND    status IN ('F','A');

        lv_error_message    VARCHAR2(1803);
    BEGIN
        FOR prob_payment IN cu_problem_payments (pn_policy_number) LOOP

            IF prob_payment.status IN ('F','A') THEN
                lv_error_message := 'Returned payment details: '||
                                    'Due Date: ' || SUBSTR(prob_payment.payment_due_date,1,10) ||'~'||
                                    'Date Paid: ' || SUBSTR(prob_payment.actual_payment_date,1,10) ||'~'||
                                    'Gross(£): ' || prob_payment.gross_amount ||'~'||
                                    'Tax(£): ' || prob_payment.tax_amount ||'~'||
                                    'Net(£): ' || prob_payment.net_amount ;

                p_raise_exception (pn_policy_number
                                  ,801
                                  ,lv_error_message
                                  ,pv_product_type);
            END IF;
        END LOOP;
    END p_settlement_IR_failed_payment;

    /*===========================================================================================
    Procedure p_oustanding_premiums_hc
    Checks the outstanding premiums health check, and reports on any errors found
    %param pn_policy_reference IN po010.polref
    ===========================================================================================*/
    PROCEDURE p_oustanding_premiums_hc (pn_policy_reference IN po010.polref%TYPE)
    IS

        CURSOR cu_outstanding_premiums(pcn_policy IN po010.polref%TYPE)
        IS
        SELECT  pol.prdref product_reference
               ,'Policy Name :' ||veh.policy_name ||
                '~Created Date : ' ||veh.created_date ||
                '~Update Date : ' || veh.update_date ||
                '~Updated By : ' || (CASE
                                     WHEN cl.clisur||cl.clifor IS NULL THEN
                                         'N/A'
                                     ELSE
                                         cl.clifor||' '||cl.clisur
                                     END) ||
                '~Description : ' || veh.sysdescription error_message
        FROM v_errorcode_healthcheck veh
        JOIN po010 pol ON pol.polref = veh.policy_ref
                      AND pol.maint != 'D'
        LEFT OUTER JOIN cl011 cl ON cl.stf_no = veh.updated_by
        WHERE veh.policy_ref = pcn_policy;

        lb_premium_error_found  BOOLEAN;
        lv_product_ref          po010.prdref%TYPE;
        lv_error_message        VARCHAR2(1803);

  BEGIN
        OPEN cu_outstanding_premiums(pn_policy_reference);
        FETCH cu_outstanding_premiums INTO lv_product_ref
                                          ,lv_error_message;
        lb_premium_error_found := cu_outstanding_premiums%FOUND;
        CLOSE cu_outstanding_premiums;
        IF lb_premium_error_found THEN
            p_raise_exception(pn_policy_reference
                             ,787
                             ,lv_error_message
                             ,lv_product_ref
                             );
        END IF;
    END;

    /*===========================================================================================
    Procedure p_batch_errors
    Checks if there are any unresolved batch errors on the data_errors table
    %param pn_policy_reference IN po010.polref
    ===========================================================================================*/
    PROCEDURE p_batch_errors (pn_policy IN po010.polref%TYPE) IS

        CURSOR cu_batch_errors(pcn_policy IN po010.polref%TYPE)
        IS
        SELECT NVL(CASE
                   WHEN d.product_reference IS NULL THEN
                       (SELECT pol.prdref
                          FROM po010 pol
                         WHERE d.policy_reference = pol.polref)
                   ELSE
                       d.product_reference
                   END,'N/A') product_reference
              ,'Source Code :'       ||d.source_code||
               '~Error Code :'       ||d.error_code||
               '~Error Status :'     ||cs.itevaldes||
               '~Staff Name :' ||(CASE
                                  WHEN cl.clisur||cl.clifor IS NULL THEN
                                      'N/A'
                                  ELSE
                                      cl.clifor||' '||cl.clisur
                                  END) ||
               '~Error Description :'||ded.error_desc error_message
        FROM data_errors d
        JOIN data_errors_description ded ON d.source_code = ded.source_code
                                        AND d.error_code  = ded.error_code
        JOIN cs060 cs ON cs.datiteval = d.status
                     AND cs.ispgrpnam = 'ERROR'
                     AND cs.maint != 'D'
                     AND cs.datitenam = 'STATUS'
        LEFT OUTER JOIN cl011 cl ON cl.stf_no = d.assigned_to
        WHERE d.source_code   != 'PCK_HEALTH_CHECK_WRAPPER'
          AND d.status         < 80
          AND ded.access_level = 0
          AND d.policy_reference = pcn_policy;

        lb_batch_error_found    BOOLEAN;
        lv_product_ref          po010.prdref%TYPE;
        lv_error_message        VARCHAR2(1803);

    BEGIN

        OPEN cu_batch_errors(pn_policy);
        FETCH cu_batch_errors INTO lv_product_ref
                                  ,lv_error_message;
        lb_batch_error_found := cu_batch_errors%FOUND;
        CLOSE cu_batch_errors;
        IF lb_batch_error_found THEN
            p_raise_exception(pn_policy
                             ,788
                             ,lv_error_message
                             ,lv_product_ref
                             );
        END IF;

    END p_batch_errors;

    /*===========================================================================================
    Procedure p_csn_trigger_check
    Checks if there are any CSN UDCTL triggers that are not status ACT
    %param pn_policy_reference IN co040.polref%TYPE
    %param pn_end_date         IN pa021.rnwdte%TYPE
    %param pv_product_type     IN pr010.prdref%TYPE
    ===========================================================================================*/

    PROCEDURE p_csn_trigger_check(pn_policy_number         IN co040.polref%TYPE
                                 ,pn_end_date              IN pa021.rnwdte%TYPE
                                 ,pv_product_type          IN pr010.prdref%TYPE)
    IS

        CURSOR cu_csn_triggers(pcn_policy_number co040.polref%TYPE
                              ,pcn_end_date      pa021.rnwdte%TYPE)
        IS
        SELECT pck_utility.f_dtcnv(pa.efvdte) effective_date
              ,trnctl_no
              ,NVL(cs.itevalnam,'*NO') itevalnam
              ,inrtyp
              ,pck_utility.f_dtcnv(pa.strdte) start_date
              ,pck_utility.f_dtcnv(pa.enddte) end_date
        FROM  pa020 pa, cs060 cs
        WHERE pa.polref = pcn_policy_number
        AND   pa.fndtrntyp = 'CSN'
        AND   ((pa.inrtyp IN ('SP', 'TV')
        AND   pa.strdte  = pa.enddte
        AND   pa.sta_pa != 50
        AND   pa.efvdte < pcn_end_date)
        OR    (pa.frq = 'M'
        AND   pa.strdte != pa.enddte
        AND   pa.sta_pa = 30
        AND   (pa.efvdte < pcn_end_date
        OR    (pa.efvdte > pa.enddte)))
        OR    (pa.frq = 'M'
        AND   pa.strdte != pa.enddte
        AND   pa.sta_pa = 50
        AND   pa.efvdte < pa.enddte)
        OR    pa.sta_pa IN (47, 98, 99))
        AND   pa.maint  != 'D'
        AND   cs.ispgrpnam(+) = 'PA020'
        AND   cs.datitenam(+) =  'STA'
        AND   cs.maint(+)     != 'D'
        AND   cs.datiteval(+) = pa.sta_pa
        AND   EXISTS (SELECT 1
                      FROM  po020 po2
                      WHERE po2.polref = pa.polref
                      AND   pa.inrtyp  = po2.inrtyp
                      AND   pa.inrref  = po2.inrref
                      AND   po2.stainr = 30
                      AND   po2.maint != 'D');

        lv_error_message    VARCHAR2(1803)        := ' ';

    BEGIN

        FOR lr_csn_triggers IN cu_csn_triggers(pn_policy_number
                                              ,pn_end_date) LOOP

           --Raise exception 820
           lv_error_message := 'CSN effective date: '||lr_csn_triggers.effective_date||'~'||
                               'CSN UDCTL status: '||lr_csn_triggers.itevalnam||'~'||
                               'CSN Increment Type: '||lr_csn_triggers.Inrtyp||'~'||
                               'CSN Start Date: '||lr_csn_triggers.start_date||'~'||
                               'CSN End Date: '||lr_csn_triggers.end_date||'~'||
                               'CSN transaction control number: '||lr_csn_triggers.trnctl_no;
           p_raise_exception(pn_policy_number
                            ,820
                            ,lv_error_message
                            ,pv_product_type
                            );
        END LOOP;

    END p_csn_trigger_check;

   /*===========================================================================================
    Procedure p_db_trigger_check
    Checks if there are any CSN UDCTL triggers that are not status LIV with efvdte DDMM not 3112
    and efvdte YY not most recent with-profits bonus rune year + 1
    %param pn_policy_reference IN co040.polref%TYPE
    %param pv_product_type     IN pr010.prdref%TYPE
    ===========================================================================================*/
    PROCEDURE p_db_trigger_check(pn_policy_number IN co040.polref%TYPE
                                ,pv_product_type  IN pr010.prdref%TYPE)
    IS
        CURSOR cu_db_triggers(pcn_policy_number co040.polref%TYPE)
        IS
        SELECT pck_utility.f_dtcnv(pa.efvdte) effective_date
              ,trnctl_no
              ,NVL(cs.itevalnam,'*NO') itevalnam
        FROM  pa020 pa
             ,cs060 cs
             ,po010 pl
             ,(SELECT audupddte,talbondte
                 FROM (SELECT audupddte,talbondte
                         FROM ge001 ge1
                        ORDER BY unique_id DESC)
                WHERE ROWNUM = 1) ge
        WHERE pa.polref    = pcn_policy_number
        AND   pa.fndtrntyp = 'DB'
        AND   pa.maint    != 'D'
        AND   pa.polref    = pl.polref
        AND   (pa.sta_pa  != 30
        OR   TO_CHAR(TO_DATE(TO_CHAR(pa.efvdte + 2415021),'J'), 'DDMM') != '3112'
        OR   (TO_CHAR(TO_DATE(TO_CHAR(pa.efvdte + 2415021),'J'), 'YYYY') != (TO_CHAR(TO_DATE(TO_CHAR(ge.talbondte + 2415021),'J'), 'YYYY'))
        AND  TO_CHAR(TO_DATE(TO_CHAR(pl.polcrcdte + 2415021),'J'), 'YYYY') != TO_CHAR((SELECT system_dt FROM cs340), 'YYYY')))
        AND  NOT EXISTS (SELECT 1 FROM pa020 pa2
                         WHERE pa2.polref = pa.polref
                         AND   pa2.fndtrntyp = 'DB'
                         AND   pa2.trnctl_no != pa.trnctl_no
                         AND   pa2.sta_pa = 30
                         AND   pa2.maint != 'D')
        AND   cs.ispgrpnam(+) = 'PA020'
        AND   cs.datitenam(+) =  'STA'
        AND   cs.maint(+)     != 'D'
        AND   cs.datiteval(+) = pa.sta_pa;

        lv_status           cs060.itevalnam%TYPE  := ' ';
        ld_effective_date   DATE;
        ln_trnctl_no        pa020.trnctl_no%TYPE  := 0;
        lv_error_message    VARCHAR2(1803)        := ' ';
        lb_transaction_found BOOLEAN              := FALSE;
        lv_ir_policy         VARCHAR2(1)          := 'N';

    BEGIN

        pck_income_release_queries.p_check_ir_policy(pn_policy_number
                                                    ,lv_ir_policy);

        -- Do not want to do this check if this is an IR policy as the DB trigger is set to CNL

        IF lv_ir_policy = 'N' THEN

            OPEN cu_db_triggers(pn_policy_number);

            FETCH cu_db_triggers INTO ld_effective_date
                                     ,ln_trnctl_no
                                     ,lv_status;

            lb_transaction_found := (cu_db_triggers%FOUND);

            CLOSE cu_db_triggers;

            IF lb_transaction_found THEN
               --Raise exception 821
               lv_error_message := 'DB effective date: '||ld_effective_date||'~'||
                                   'DB UDCTL status: '||lv_status||'~'||
                                   'DB transaction control number: '||ln_trnctl_no;
               p_raise_exception(pn_policy_number
                                ,821
                                ,lv_error_message
                                ,pv_product_type
                                );
            END IF;

        END IF;

    END p_db_trigger_check;

    /*******************************************************************************************
    --  Checks if there are any UDCTL triggers that are not status LIV with efvdte > sys date
    --  or if there are non-status live triggers without a valid LIV trigger
    -- %param pn_policy_number     IN pa020.polref%TYPE
    -- %param pv_transaction_type  IN pa020.fndtrntyp%TYPE
    -- %param pn_status            IN pa020.sta_pa%TYPE
    -- %param pv_product_type      IN pr010.prdref%TYPE
    -- %param pn_trig_check_date   IN cs340.sysdte%TYPE
    ********************************************************************************************/

    PROCEDURE p_transaction_and_lv_check(pn_policy_number     IN pa020.polref%TYPE
                                        ,pv_transaction_type  IN pa020.fndtrntyp%TYPE
                                        ,pn_status            IN pa020.sta_pa%TYPE
                                        ,pv_product_type      IN pr010.prdref%TYPE
                                        ,pn_trig_check_date   IN cs340.sysdte%TYPE)
    IS
        CURSOR cu_transaction_and_lv_dets (pcn_policy_number    pa020.polref%TYPE
                                          ,pcv_transaction_type pa020.fndtrntyp%TYPE
                                          ,pcn_status           pa020.sta_pa%TYPE
                                          ,pcn_trig_check_date  cs340.sysdte%TYPE)
        IS
        SELECT TO_DATE(TO_CHAR(pa.efvdte + 2415021),'J') effective_date
              ,trnctl_no
              ,NVL(cs.itevalnam,'*NO') itevalnam
        FROM  pa020 pa, cs060 cs
        WHERE pa.polref = pcn_policy_number
        AND   pa.fndtrntyp = pcv_transaction_type
        AND   ((pa.sta_pa  = pcn_status AND pa.efvdte <= pcn_trig_check_date)
        OR    (pa.sta_pa != pcn_status AND
        NOT EXISTS (SELECT 1 FROM pa020 pa2
                    WHERE pa2.polref    = pa.polref
                    AND   pa2.fndtrntyp = pcv_transaction_type
                    AND   pa2.sta_pa    = 30
                    AND   pa2.efvdte   >= pcn_trig_check_date
                    AND   pa2.maint    != 'D')))
        AND   pa.maint    != 'D'
        AND   NOT EXISTS (SELECT 1 FROM pa020 pa3
                          WHERE pa3.polref = pa.polref
                          AND   pa3.fndtrntyp = 'LV'
                          AND   pa3.sta_pa    = 50
                          AND   pa3.maint    != 'D')
        AND   cs.ispgrpnam(+) = 'PA020'
        AND   cs.datitenam(+) =  'STA'
        AND   cs.maint(+)     != 'D'
        AND   cs.datiteval(+) = pa.sta_pa
        MINUS
        SELECT TO_DATE(TO_CHAR(pa.efvdte + 2415021),'J') effective_date
              ,pa.trnctl_no
              ,NVL((SELECT cs.itevalnam
                    FROM  cs060 cs
                    WHERE cs.ispgrpnam = 'PA020'
                    AND   cs.datitenam =  'STA'
                    AND   cs.maint    != 'D'
                    AND   cs.datiteval = pa.sta_pa),'*NO') itevalnam
        FROM pa020 pa
        LEFT OUTER JOIN (SELECT *
                         FROM (SELECT polref
                                     ,matdte
                                     ,row_number() over (PARTITION BY polref ORDER BY inrtyp, inrref, bentyp, benref) rnum
                               FROM po030
                               WHERE polref  = pcn_policy_number
                               AND   maint  != 'D'
                               AND   staben <= 30
                               AND   staben != 29
                               AND   bentyp NOT IN ('WVR','GLA','GIP','LTD','STD','STDU')
                               AND   extmod NOT IN (1,51,52,41,42)
                               AND   matdte NOT IN (-99999,99999,0))
                               WHERE rnum = 1) retiral_date
        ON pa.polref = retiral_date.polref
        WHERE pa.polref    = pcn_policy_number
        AND   pa.fndtrntyp = pcv_transaction_type
        AND   pa.sta_pa = 50
        AND   pa.maint != 'D'
        AND   pa.enddte > pcn_trig_check_date
        AND   MONTHS_BETWEEN(TO_DATE(TO_CHAR(NVL(retiral_date.matdte,99999)  + 2415021),'J')
                            ,TO_DATE(TO_CHAR(pa.efvdte  + 2415021),'J')) < CASE pa.frq
                                                                                WHEN 'Y' THEN 12
                                                                                WHEN 'H' THEN 6
                                                                                WHEN 'Q' THEN 4
                                                                                ELSE 1
                                                                           END;

        lv_error_message    VARCHAR2(1803)        := ' ';
        ln_exception_number ge110.rsncde%TYPE;

    BEGIN

        CASE pv_transaction_type
           WHEN 'UCC'  THEN ln_exception_number := 822;
           WHEN 'LOY'  THEN ln_exception_number := 823;
           WHEN 'ADM'  THEN ln_exception_number := 824;
        ELSE
            ln_exception_number := 999;
        END CASE;

        FOR lr_transaction_and_lv_dets IN cu_transaction_and_lv_dets(pn_policy_number
                                                                    ,pv_transaction_type
                                                                    ,pn_status
                                                                    ,pn_trig_check_date) LOOP

           lv_error_message := pv_transaction_type||' effective date: '|| lr_transaction_and_lv_dets.effective_date||'~'||
                               pv_transaction_type||' UDCTL status: '|| lr_transaction_and_lv_dets.itevalnam||'~'||
                               pv_transaction_type||' transaction control number: '|| lr_transaction_and_lv_dets.trnctl_no;

           p_raise_exception(pn_policy_number
                            ,ln_exception_number
                            ,lv_error_message
                            ,pv_product_type
                            );

        END LOOP;

    END p_transaction_and_lv_check;

    /*******************************************************************************************
    -- Procedure to return trans efvdte, trnctl_no, status descr and boolean if record found<BR>
    -- %param pn_policy_number     IN pa020.polref%TYPE
    -- %param pv_transaction_type  IN pa020.fndtrntyp%TYPE
    -- %param pn_status            IN pa020.sta_pa%TYPE
    -- %param pn_trig_check_date   IN cs340.sysdte%TYPE
    ********************************************************************************************/

    PROCEDURE p_transaction_check  (pn_policy_number     IN pa020.polref%TYPE
                                   ,pv_transaction_type  IN pa020.fndtrntyp%TYPE
                                   ,pn_status            IN pa020.sta_pa%TYPE
                                   ,pv_product_type      IN pr010.prdref%TYPE
                                   ,pn_trig_check_date   IN cs340.sysdte%TYPE)
    IS
        CURSOR cu_transaction_details (pcn_policy_number    pa020.polref%TYPE
                                      ,pcv_transaction_type pa020.fndtrntyp%TYPE
                                      ,pcn_status           pa020.sta_pa%TYPE)
        IS
        SELECT pck_utility.f_dtcnv(pa.efvdte) effective_date
              ,trnctl_no
              ,NVL(cs.itevalnam,'*NO') itevalnam
        FROM  pa020 pa, cs060 cs
        WHERE pa.polref    = pcn_policy_number
        AND   pa.fndtrntyp = pcv_transaction_type
        AND   (pa.sta_pa    = pcn_status
        AND   pa.efvdte    <= pn_trig_check_date)
        AND   pa.maint     <> 'D'
        AND   cs.ispgrpnam(+) = 'PA020'
        AND   cs.datitenam(+) =  'STA'
        AND   cs.maint(+)     <> 'D'
        AND   cs.datiteval(+) = pa.sta_pa;

        lv_error_message    VARCHAR2(1803)        := ' ';
        ln_exception_number ge110.rsncde%TYPE;

    BEGIN

         CASE pv_transaction_type
           WHEN 'TA'  THEN ln_exception_number := 826;
           WHEN 'WVR' THEN ln_exception_number := 827;
        ELSE
            ln_exception_number := 999;
        END CASE;

        FOR lr_transaction_details IN cu_transaction_details(pn_policy_number
                                                            ,pv_transaction_type
                                                            ,pn_status) LOOP

           lv_error_message := pv_transaction_type||' effective date: '|| lr_transaction_details.effective_date||'~'||
                               pv_transaction_type||' UDCTL status: '|| lr_transaction_details.itevalnam||'~'||
                               pv_transaction_type||' transaction control number: '|| lr_transaction_details.trnctl_no;

           p_raise_exception(pn_policy_number
                            ,ln_exception_number
                            ,lv_error_message
                            ,pv_product_type
                            );

        END LOOP;

    END p_transaction_check;

   /*===========================================================================================
   Procedure p_int_trigger_check
   Checks if there are any INT UDCTL triggers that are not status LIV with efvdte > sys date
   or if there are non-status live triggers without a valid LIV trigger
   -- %param pn_policy_reference IN co040.polref%TYPE
   -- %param pv_product_type     IN pr010.prdref%TYPE
   -- %param pn_trig_check_date   IN cs340.sysdte%TYPE
   ==========================================================================================*/
   PROCEDURE p_int_trigger_check (pn_policy_number   IN co040.polref%TYPE
                                 ,pv_product_type    IN pr010.prdref%TYPE
                                 ,pn_trig_check_date IN cs340.sysdte%TYPE)
   IS

        CURSOR cu_int_triggers(pcn_policy_number co040.polref%TYPE)
        IS
        SELECT pck_utility.f_dtcnv(pa.efvdte) effective_date
              ,trnctl_no
              ,NVL(cs.itevalnam,'*NO') itevalnam
        FROM  pa020 pa, cs060 cs
        WHERE pa.polref = pcn_policy_number
        AND   pa.fndtrntyp = 'INT'
        AND   pa.maint != 'D'
        AND   ((pa.sta_pa  = 30 AND pa.efvdte <= pn_trig_check_date)
        OR    (pa.sta_pa != 30 AND
        NOT EXISTS (SELECT 1 FROM pa020 pa2
                    WHERE pa2.polref    = pa.polref
                    AND   pa2.fndtrntyp = 'INT'
                    AND   pa2.sta_pa    = 30
                    AND   pa2.efvdte   >= pn_trig_check_date
                    AND   pa2.maint    != 'D')))
        AND   pa.maint  != 'D'
        AND   cs.ispgrpnam(+) = 'PA020'
        AND   cs.datitenam(+) =  'STA'
        AND   cs.maint(+)     != 'D'
        AND   cs.datiteval(+) = pa.sta_pa;

        lv_error_message    VARCHAR2(1803)        := ' ';

   BEGIN

       FOR lr_int_triggers IN cu_int_triggers(pn_policy_number) LOOP

            lv_error_message := 'INT effective date: '||lr_int_triggers.effective_date||'~'||
                                'INT UDCTL status: '||lr_int_triggers.itevalnam||'~'||
                                'INT transaction control number: '||lr_int_triggers.trnctl_no;
            p_raise_exception(pn_policy_number
                             ,825
                             ,lv_error_message
                             ,pv_product_type
                             );
       END LOOP;
   END p_int_trigger_check;

   /*===========================================================================================
   Procedure p_ITR_check
   Checks if there are any ITR records where the stop new business indicator = Y or the SL
   authorisation code is set to 97
   -- %param pn_policy_reference IN po010.polref%TYPE
   -- %param pv_product_type     IN pr010.prdref%TYPE
   ============================================================================================*/

   PROCEDURE p_ITR_check (pn_policy_number IN po010.polref%TYPE
                         ,pv_product_type  IN pr010.prdref%TYPE)
   IS

        CURSOR cu_itr_record_checks (pcn_policy_number IN po010.polref%TYPE)
        IS
        SELECT itr_no, sto_nb, slcathcde
        FROM   co040 co, cl090 cl
        WHERE co.polref =  pcn_policy_number
        AND   co.rolref =  'ITR'
        AND   co.staxrf =  30
        AND   co.clicat =  'ITR'
        AND   co.jtlind =  1
        AND   co.maint != 'D'
        AND   co.strdte <= lpn_system_date
        AND   co.enddte >= lpn_system_date
        AND   cl.itr_no = cliref
        AND   cl.mnt   != 'D'
        AND   cl.enddte    = (SELECT MAX(cl2.enddte)
                              FROM cl090 cl2
                              WHERE cl2.itr_no = cl.itr_no
                              AND   cl2.mnt   != 'D')
        AND   cl.efvdte    = (SELECT MAX(cl3.efvdte)
                              FROM cl090 cl3
                              WHERE cl3.itr_no = cl.itr_no
                              AND   cl3.mnt   != 'D')
        AND  (sto_nb IN ('A','Y') OR slcathcde IN (3,32, 56, 97));

        lv_error_message    VARCHAR2(1803)        := ' ';

   BEGIN

        FOR lr_itr_record_checks IN cu_itr_record_checks(pn_policy_number) LOOP

            IF lr_itr_record_checks.sto_nb IN ('A', 'Y') THEN
               -- Raise exception
               lv_error_message := 'ITR No: '||lr_itr_record_checks.itr_no;

               p_raise_exception(pn_policy_number
                                ,828
                                ,lv_error_message
                                ,pv_product_type
                                );
            END IF;

            IF lr_itr_record_checks.slcathcde IN (3,32, 56, 97) THEN
               -- Raise exception
               lv_error_message := 'ITR No: '||lr_itr_record_checks.itr_no;

               p_raise_exception(pn_policy_number
                                ,829
                                ,lv_error_message
                                ,pv_product_type
                                );
            END IF;

        END LOOP;

   END p_ITR_check;

     /*===========================================================================================
    Procedure p_sspiq_suspense
    Checks if there are any Suspense records for an individual policy on SSPIQ
    -- %param pn_policy_reference IN co040.polref%TYPE
    ============================================================================================*/
    PROCEDURE p_sspiq_suspense(pn_policy_number  IN co040.polref%TYPE)
    IS
        CURSOR cu_suspense_item(pcn_policy_number co040.polref%TYPE)
        IS
        SELECT client_details.prdref
              ,'Unmatched money on SSPIQ :' ||
               '~Date Received : ' || to_date(to_char(eve.dte1 + 2415021),'J') ||
               '~Amount : ' || eve.trnamt1 ||
               '~Name : ' || fi.clishtnam ||
               '~Payment Method : ' || eve.trntyp2 ||
               '~FI355 Additional Information : '|| fi.cshextdat1 ||' '||fi.cshextdat2 error_message
        FROM   fi600 fi
        JOIN   event eve ON fi.extunq = eve.unq
                        AND fi.exttrn_no = eve.tranno
                        AND eve.clicat = '999'
                        AND eve.cliref = 99999999
                        AND eve.ispec = 'FI500'
                        AND eve.staevt = 28
              ,(SELECT co.polref
                      ,pol.prdref
                      ,cl.clicat
                      ,cl.cliref
                      ,cl.natinr_no
                FROM   co040 co
                JOIN   cl010 cl  ON co.cliref = cl.cliref
                                AND co.clicat = cl.clicat
                                AND cl.natinr_no NOT IN ( 'AB123456C', ' ')
                JOIN   po010 pol ON pol.polref = co.polref
                                AND pol.polref = pcn_policy_number
                                AND pol.polref != 0
                                AND pol.stapol IN (30, 52)
                WHERE  co.rolref IN ('P', 'PL')) client_details
       WHERE   fi.qtepolref = client_details.polref
          OR   fi.qtenatinr = client_details.natinr_no
          OR   fi.cshextdat1 LIKE '%' || client_details.polref || '%'
          OR   fi.cshextdat1 LIKE '%' || client_details.natinr_no || '%'
          OR   fi.cshextdat2 LIKE '%' || client_details.natinr_no  || '%'
          OR   fi.cshextdat1 LIKE '%' || client_details.cliref  || '%'
          OR   fi.cshextdat2 LIKE '%' || client_details.cliref  || '%';


    BEGIN

        FOR lr_suspense_item IN cu_suspense_item(pn_policy_number)
        LOOP

           --Raise exception 36
           p_raise_exception(pn_policy_number
                            ,36
                            ,lr_suspense_item.error_message
                            ,lr_suspense_item.prdref
                            );
        END LOOP;

    END p_sspiq_suspense;

    PROCEDURE p_draft_fund_mvmnt_check(pn_policy_in      IN po010.polref%TYPE
                                      ,pn_report_date_in IN fi700.audupddte%TYPE) IS
        CURSOR cu_draft_check (pcn_policy_in   IN po010.polref%TYPE
                              ,pcn_report_date IN fi700.efvdte%TYPE
                              ,pcn_audit_date  IN fi700.audupddte%TYPE) IS
        SELECT fi.polref
              ,po.prdref
              ,116 exception_code
              ,'Draft Fund Movement'   ||
               '~Investment Fund: '    || pr.fndweenam ||
               '~Fund Code: '          || TO_CHAR(fi.fndref)||
               '~Effective Date: '     || TO_CHAR(TO_DATE(TO_CHAR(efvdte + 2415021), 'J'), 'DD-MM-YYYY')||
               '~Transaction Type: '   || fi.fndtrntyp ||
               '~Status: DRAFT'        ||
               '~Statement Number: '   || TO_CHAR(fi.untstm_no) ||
               '~Unique Reference: '   || TO_CHAR(fi.unq) ||
               '~Transaction Number: ' || TO_CHAR(fi.trn_no) AS error_message
        FROM po010 po
        JOIN fi700 fi ON  fi.polref = po.polref
                      AND fi.staevt = 5
                      AND fi.efvdte < pcn_report_date
                      AND fi.audupddte < pcn_audit_date
        JOIN pr310 pr ON  pr.fndref = fi.fndref
                      AND pr.maint != 'D'
        WHERE po.polref = pcn_policy_in
        AND   po.stapol IN (30,52)
        AND   po.maint != 'D'
        AND (   po.prdref LIKE 'TAL%'
             OR po.prdref LIKE 'RS%'
             OR po.prdref  LIKE 'TL98%')
       AND NOT EXISTS (SELECT 1 FROM event ev WHERE ev.polref  = fi.polref
                                                AND ev.dte1    = fi.duedte
                                                AND ev.dte2    = fi.efvdte
                                                AND ev.unq     = fi.evtunq
                                                AND ev.tranno  = fi.evttrn_no
                                                AND ev.ispec   = 'FI560'
                                                AND ev.staevt  = 82);

        ln_audit_date fi700.audupddte%TYPE;
    BEGIN
        ln_audit_date := pck_dates.f_subtract_work_days(pn_report_date_in, 65);
        FOR i IN cu_draft_check(pn_policy_in
                               ,pn_report_date_in
                               ,ln_audit_date) LOOP
             --Raise exception 116
             p_raise_exception(i.polref
                              ,116
                              ,i.error_message
                              ,i.prdref
                              );
        END LOOP;
    END p_draft_fund_mvmnt_check;

    /*===========================================================================================
    Procedure p_negative_fund_holdings_check
    Checks CO051(type 'T' only), CO055 (Statement 999 only) and CO058 records for -ve valuations
    -- %param pn_polref_in    IN po010.polref%TYPE
    -- %param pv_product_type IN po010.prdref%TYPE)
    ============================================================================================*/
    PROCEDURE p_negative_fund_holdings_check (pn_polref_in    IN po010.polref%TYPE) IS

        lv_product_with_rights_type  VARCHAR2(1) := 'N';

        CURSOR cu_fund_holdings_check (pcn_polref_in po010.polref%TYPE) IS
        WITH policies AS (SELECT polref
                         ,prdref
                          FROM po010
                          WHERE stapol IN (30,52)
                          AND   polref = pcn_polref_in
                          AND   maint != 'D'
                          AND (   prdref LIKE 'TAL-%'
                               OR prdref LIKE 'TL98-%'
                               OR prdref like 'RS-%'))
        SELECT co51.polref
               ,pol.prdref
               ,'CO Type: CO051' ||
                '~Investment Fund: ' || pr.fndweenam ||
                '~Fund Code: ' || pr.fnd_id ||
                '~Increment Type: ' || co51.inrtyp ||
                '~Increment Reference: ' || TO_CHAR(co51.inrref) ||
                '~Rights Type: ' || (CASE
                                       WHEN lv_product_with_rights_type = 'Y' THEN
                                           co51.rhttyp
                                       ELSE 'N/A'
                                     END) ||
                '~Pre/Post: ' || (CASE
                                     WHEN co51.spldte = -99999 THEN
                                        'PRE'
                                     WHEN co51.spldte = 35524 THEN
                                        'POST'
                                     ELSE
                                        'Invalid Split Date'
                                  END) ||
                '~Start Date: ' || TO_CHAR(TO_DATE(TO_CHAR(co51.strdte + 2415021),'J'), 'DD/MM/YYYY') ||
                '~Participation Date: ' || TO_CHAR(TO_DATE(TO_CHAR(co51.prtdte + 2415021),'J'), 'DD/MM/YYYY') ||
                '~Basic Benefit Quantity: ' || (CASE
                                         WHEN co51.basben = 0 THEN
                                             '0'
                                         ELSE
                                             TO_CHAR(co51.basben,'fm99999990.000')
                                      END) ||
                '~Bonus Benefit Quantity: ' || (CASE
                                                   WHEN co51.totdba = 0 THEN
                                                       '0'
                                                   ELSE
                                                       TO_CHAR(co51.totdba,'fm99999990.000')
                                                   END) ||
                '~ProfitShare Basic Benefits: ' || TO_CHAR(co51.profitshare_basic_benefits,'fm99999990.000') ||
                '~ProfitShare Bonus Benefits: ' || TO_CHAR(co51.profitshare_bonus_benefits,'fm99999990.000')  ||
                '~ProfitShare Bonus Change: ' || TO_CHAR(co51.profitshare_bonus_change,'fm99999990.000') AS error_message
        FROM co051 co51
        JOIN policies pol ON pol.polref = co51.polref
        JOIN pr310 pr ON  pr.fndref = co51.fndref
                      AND pr.maint != 'D'
        WHERE co51.bonrcdtyp = 'T'
        AND co51.maint != 'D'
        AND co51.stabon = 30
        AND (   co51.basben < 0
             OR co51.totdba < 0)
        UNION
        SELECT co58.polref
              ,pol.prdref
               ,'CO Type: CO058' ||
               '~Investment Fund: ' || pr.fndweenam ||
               '~Fund Code:' || pr.fnd_id ||
               '~Increment Type: ' || co58.inrtyp ||
               '~Increment Reference: ' || TO_CHAR(co58.inrref) ||
               '~Rights Type: ' || (CASE
                                        WHEN lv_product_with_rights_type = 'Y' THEN
                                           co58.rhttyp
                                       ELSE 'N/A'
                                    END) ||
               '~Pre/Post: ' || (CASE
                                    WHEN co58.spldte = -99999 THEN
                                        'PRE'
                                    WHEN co58.spldte = 35524 THEN
                                        'POST'
                                    ELSE
                                        'Invalid Split Date'
                                 END) ||
                '~Calendar Year: ' || (CASE
                                           WHEN co58.cal_yr = 0 THEN
                                              'N/A'
                                            ELSE TO_CHAR(co58.cal_yr)
                                       END) ||
               '~Benefit Quantity: ' || (CASE
                                            WHEN pol.prdref NOT LIKE 'TL98%'  THEN --no othbenqty info
                                              (CASE
                                                  WHEN co58.benqty    =     0 THEN
                                                     '0'
                                                  ELSE
                                                     TO_CHAR(co58.benqty,'fm99999990.000')
                                               END)
                                            ELSE
                                              (CASE
                                                  WHEN  co58.benqty     = 0
                                                  AND   co58.othbenqty  = 0 THEN
                                                     '0 ~Other Benefit Quantity: 0'
                                                  WHEN  co58.benqty     = 0
                                                  AND   co58.othbenqty != 0 THEN
                                                     '0 ~Other Benefit Quantity:' || TO_CHAR(co58.othbenqty,'fm99999990.000')
                                                  WHEN  co58.benqty    != 0
                                                  AND   co58.othbenqty  = 0 THEN
                                                     TO_CHAR(co58.benqty,'fm99999990.000') || '~Other Benefit Quantity: 0'
                                                  ELSE
                                                     TO_CHAR(co58.benqty,'fm99999990.000') || '~Other Benefit Quantity:'  ||
                                                     TO_CHAR(co58.othbenqty,'fm99999990.000')
                                               END)
                                         END) ||
               '~ProfitShare Benefits: ' || TO_CHAR(NVL(co58.profitshare_benefits, 0),'fm99999990.000') AS error_message
        FROM co058 co58
        JOIN policies pol ON pol.polref = co58.polref
        JOIN pr310 pr ON  pr.fndref = co58.fndref
                      AND pr.maint != 'D'
        WHERE  co58.sta        =   30
        AND   (co58.benqty     <   0
          OR  (co58.othbenqty  <   0
          AND   pol.prdref    LIKE 'TL98%'))

        UNION
        SELECT co55.polref
              ,pol.prdref
              ,'CO Type: CO055' ||
               '~Investment Fund: ' ||  pr.fndweenam ||
               '~Fund Code: ' || pr.fnd_id ||
               '~Rights Type: ' || (CASE
                                       WHEN lv_product_with_rights_type = 'Y' THEN
                                          co55.rhttyp
                                        ELSE 'N/A'
                                    END) ||
               '~Benefit Quantity 1: ' || (CASE
                                             WHEN co55.benqty1 = 0 THEN
                                                 '0'
                                             ELSE
                                                  TO_CHAR(co55.benqty1,'fm99999990.000')
                                           END) ||
               '~Benefit Quantity 2: ' || (CASE
                                              WHEN pol.prdref NOT LIKE 'TL98%'  THEN --no othbenqty info
                                                 (CASE
                                                     WHEN co55.benqty2    =     0 THEN
                                                        '0'
                                                     ELSE
                                                        TO_CHAR(co55.benqty2,'fm99999990.000')
                                                  END)
                                           ELSE
                                              (CASE
                                                  WHEN  co55.benqty2    = 0
                                                  AND   co55.othbenqty  = 0 THEN
                                                     '0 ~Other Benefit Quantity: 0'
                                                  WHEN  co55.benqty2    = 0
                                                  AND   co55.othbenqty != 0 THEN
                                                     '0 ~Other Benefit Quantity:' || TO_CHAR(co55.othbenqty,'fm99999990.000')
                                                  WHEN  co55.benqty2   != 0
                                                  AND   co55.othbenqty  = 0 THEN
                                                     TO_CHAR(co55.benqty2,'fm99999990.000') || '~Other Benefit Quantity: 0'
                                                  ELSE
                                                     TO_CHAR(co55.benqty2,'fm99999990.000') || '~Other Benefit Quantity:'  ||
                                                     TO_CHAR(co55.othbenqty,'fm99999990.000')
                                               END)
                                            END) ||
               '~ProfitShare Benefits: ' || NVL(co55.profitshare_benefits, 0) AS error_message
        FROM co055 co55
        JOIN policies pol ON pol.polref = co55.polref
        JOIN pr310 pr ON  pr.fndref = co55.fndref
                      AND pr.maint != 'D'
        WHERE  co55.stastd      =   30
        AND   (co55.benqty1     <   0
           OR  co55.benqty2     <   0
           OR (co55.othbenqty   <   0
           AND  pol.prdref    LIKE 'TL98%'))
        AND    co55.untstm_no   =  999;

    BEGIN

        lv_product_with_rights_type := pck_policy_details.f_rights_type_applicable(pn_polref_in);

        FOR i IN cu_fund_holdings_check(pn_polref_in) LOOP
             --Raise exception 119
             p_raise_exception(i.polref
                              ,119
                              ,i.error_message
                              ,i.prdref
                              );
        END LOOP;
    END p_negative_fund_holdings_check;

   /*===========================================================================================
    Procedure p_tax_records_check
    Checks for invalid tax relief records for EE payments
   ============================================================================================*/

    PROCEDURE p_tax_records_check(pn_polref      IN po010.polref%TYPE
                                 ,pv_product_ref IN po010.prdref%TYPE)
    IS

        CURSOR cu_tax_records(pcn_policy_ref po010.polref%TYPE) IS

        SELECT  'Due Date: '               || TO_DATE(TO_CHAR(ev.dte1 + 2415021),'J') ||
                '~Paid Date: '             || TO_DATE(TO_CHAR(ev.dte2 + 2415021),'J') ||
                '~Amount 1: '              || '£' || LTRIM(TO_CHAR(ev.trnamt1,'9999999990D99')) ||
                '~Amount 2: '              || '£' || LTRIM(TO_CHAR(ev.trnamt2,'9999999990D99')) ||
                '~Eligibility Indicator: ' || po.qlyprm     ||
                '~Increment Type: '        || ev.inrtyp  ||
                '~Premium Type: '          || ev.trntyp1 ||
                '~Bill Method: '           || ev.trntyp2 error_message
                ,108 exception_number
        FROM  event ev
             ,po010 po
             ,pr010 pr
        WHERE   ev.polref           =  pcn_policy_ref
        AND     ev.staevt           =  55
        AND     po.polref           =  ev.polref
        AND     po.prdref           =  pr.prdref
        AND     po.prdvrs_no        =  pr.prdvrs_no
        AND     ev.trnprmgrp        =  'EE'
        AND     ev.trnamt1          =  ev.trnamt2
        AND     ev.trntyp2         <>  'JE'
        AND     ev.trntyp1         <>  'ARC'
        AND  (((po.prdref        LIKE  'TL98%'
          OR    pr.prdsubgrp        =  'CRG7')     --NIPP case
          AND   ev.inrtyp          !=  'PPC')
        OR    ((pr.prdsubgrp        =  'CRG6'      --RS case
          OR    po.prdref        LIKE  'TAL-GPS%')
          AND   ev.inrtyp          !=  'AVCR')
        OR     (po.prdref    NOT LIKE  'TL98%'
          AND   po.prdref    NOT LIKE  'TAL-GPS%'
          AND   pr.prdsubgrp NOT   IN  ('CRG7'
                                       ,'CRG6')))
        AND     po.stapol          IN  (30
                                       ,41
                                       ,52)        --ignored exited policies(status=61)
        AND     ev.trnamt1          >  0.02        --ignored zero,£0.01 and £0.02 values
        AND     ev.inrtyp          !=  'TV'        --ignored TV's
        AND     ev.dte2            >=  39907
        AND ((NOT EXISTS (SELECT 1
                          FROM  fi720 fi
                          WHERE ev.polref  = fi.polref
                          AND   ev.unq     = fi.evtunq
                          AND   ev.tranno  = fi.evttrn_no
                          AND   fi.sta    IN (30, 50))
        AND po.qlyprm = 'Y')
        OR (EXISTS (SELECT 1
                    FROM  fi720 fi2
                    WHERE ev.polref  = fi2.polref
                    AND   ev.unq     = fi2.evtunq
                    AND   ev.tranno  = fi2.evttrn_no
                    AND   fi2.sta   IN (30, 50))
        AND po.qlyprm = 'N'));

    BEGIN

        pck_process_info.p_set_action('p_tax_records_check');

        FOR i IN cu_tax_records(pn_polref)
        LOOP

            p_raise_exception(pn_polref
                             ,i.exception_number
                             ,i.error_message
                             ,pv_product_ref);
        END LOOP;

    END p_tax_records_check;

    /*===========================================================================================
    Procedure p_invalid_fund_movements
    Checks for PGIUP records with invalid effective date
    -- %param pn_policy_reference IN po010.polref%TYPE
    If updating this cursor then update pck_exceptions.bulk_invalid_fund_movements
    ============================================================================================*/
    PROCEDURE p_invalid_fund_movements(pn_policy_reference IN po010.polref%TYPE)
    IS
        lv_product_with_rights_type  VARCHAR2(1) := 'N';

        CURSOR cu_fund_movement_detail(pcn_policy_reference IN po010.polref%TYPE)
        IS
        SELECT f.polref
              ,pol.prdref
              ,'Investment Fund: '     || pr.fndweenam ||
               '~Effective Date: '     || TO_CHAR(TO_DATE(TO_CHAR(f.efvdte + 2415021), 'J'), 'DD-MM-YYYY')||
               '~Fund Code: '          || TO_CHAR(pr.fnd_id)||
               '~Increment Type: '     || f.inrtyp ||
               '~Increment Ref: '      || f.inrref ||
               '~Rights Type: '        || (CASE
                                             WHEN lv_product_with_rights_type = 'Y' THEN
                                               f.rhttyp
                                             ELSE 'N/A'
                                           END) ||
               '~Transaction Type: '   || f.fndtrntyp ||
               '~Status: '             || (SELECT itevalnam
                                           FROM  cs060 cs
                                           WHERE ispgrpnam    = 'UT170'
                                           AND   datitenam    = 'STA'
                                           AND   maint       != 'D'
                                           AND   cs.datiteval = f.staevt) ||
               '~Statement Number: '   || TO_CHAR(f.untstm_no) ||
               '~Unique Reference: '   || TO_CHAR(f.unq) ||
               '~Transaction Number: ' || TO_CHAR(f.trn_no) error_message
        FROM fi700 f
        JOIN pr310 pr ON pr.fndref  = f.fndref
                      AND pr.maint != 'D'
        JOIN po010 pol ON f.polref     = pol.polref
                       AND pol.stapol IN (30, 52)
                       AND pol.maint  != 'D'
                       AND (pol.prdref LIKE 'TAL%'
                         OR pol.prdref LIKE 'RS%'
                         OR pol.prdref LIKE 'TL98%')
        WHERE f.polref  = pcn_policy_reference
        AND   f.staevt IN (50,65,70)
        AND   f.efvdte IN (0,99999,-99999);

    BEGIN

        lv_product_with_rights_type := pck_policy_details.f_rights_type_applicable(pn_policy_reference);

        FOR i IN cu_fund_movement_detail(pn_policy_reference) LOOP
                 --Raise exception 117
                 p_raise_exception(i.polref
                                  ,117
                                  ,i.error_message
                                  ,i.prdref
                                  );
        END LOOP;
    END p_invalid_fund_movements;

    /*===========================================================================================
    Procedure p_invalid_fund_movt_right_type
    Checks for PGIUP records with invalid rights type
    -- %param pn_policy_reference IN po010.polref%TYPE
    If updating this cursor then update pck_exceptions.bulk_invalid_fnd_mvt_rhttyp
    ============================================================================================*/
    PROCEDURE p_invalid_fund_movt_right_type(pn_policy_reference IN po010.polref%TYPE)
    IS

        lv_product_with_rights_type  VARCHAR2(1) := 'N';

        CURSOR cu_fund_movement_detail(pcn_policy_reference IN po010.polref%TYPE)
        IS
        SELECT f.polref
              ,pol.prdref
              ,'Investment Fund: '     || pr.fndweenam ||
               '~Effective Date: '     || TO_CHAR(TO_DATE(TO_CHAR(f.efvdte + 2415021), 'J'), 'DD-MM-YYYY')||
               '~Fund Code: '          || TO_CHAR(pr.fnd_id)||
               '~Increment Type: '     || f.inrtyp ||
               '~Increment Ref: '      || f.inrref ||
               '~Rights Type: '        || f.rhttyp ||
               '~Transaction Type: '   || f.fndtrntyp ||
               '~Status: '             || (SELECT itevalnam
                                           FROM  cs060 cs
                                           WHERE ispgrpnam    = 'UT170'
                                           AND   datitenam    = 'STA'
                                           AND   maint       != 'D'
                                           AND   cs.datiteval = f.staevt) ||
               '~Statement Number: '   || TO_CHAR(f.untstm_no) ||
               '~Unique Reference: '   || TO_CHAR(f.unq) ||
               '~Transaction Number: ' || TO_CHAR(f.trn_no) error_message
        FROM fi700 f
        JOIN pr310 pr ON  pr.fndref  = f.fndref
                      AND pr.maint  != 'D'
        JOIN po010 pol ON  f.polref    = pol.polref
                       AND pol.stapol IN (30, 52)
                       AND pol.maint  != 'D'
        WHERE  f.polref                       =   pcn_policy_reference
        AND    f.staevt                      IN   (50,65,70)
        AND  ((lv_product_with_rights_type    =   'N'
          AND  f.rhttyp                      IN   ('A','P'))
        OR    (lv_product_with_rights_type    =   'Y'
          AND  f.rhttyp                    NOT IN ('A','P')));

    BEGIN

        lv_product_with_rights_type := pck_policy_details.f_rights_type_applicable(pn_policy_reference);

        FOR i IN cu_fund_movement_detail(pn_policy_reference) LOOP
                 --Raise exception 130
                 p_raise_exception(i.polref
                                  ,130
                                  ,i.error_message
                                  ,i.prdref
                                  );
        END LOOP;

    END p_invalid_fund_movt_right_type;

    /*===========================================================================================
    Procedure p_invalid_fund_movt_investment
    Checks for PGIUP records with invalid investment fund
    -- %param pn_policy_reference IN po010.polref%TYPE
    If updating this cursor then update pck_exceptions.bulk_invalid_fnd_mvt_invstmt
    ============================================================================================*/
    PROCEDURE p_invalid_fund_movt_investment(pn_policy_reference IN po010.polref%TYPE)
    IS

        lv_product_with_rights_type  VARCHAR2(1) := 'N';

        CURSOR cu_fund_movement_detail(pcn_policy_reference IN po010.polref%TYPE)
        IS
        SELECT f.polref
              ,pol.prdref
              ,'Investment Fund: '     || 'N/A' ||
               '~Effective Date: '     || TO_CHAR(TO_DATE(TO_CHAR(f.efvdte + 2415021), 'J'), 'DD-MM-YYYY')||
               '~Fund Code: '          || NVL((SELECT fnd_id
                                          FROM  pr310 pr2
                                          WHERE pr2.maint !='D'
                                          AND   pr2.fndref = f.fndref),'No fund definition') ||
               '~Increment Type: '     || f.inrtyp ||
               '~Increment Ref: '      || f.inrref ||
               '~Rights Type: '        || (CASE
                                             WHEN lv_product_with_rights_type = 'Y' THEN
                                               f.rhttyp
                                             ELSE 'N/A'
                                           END) ||
               '~Transaction Type: '   || f.fndtrntyp ||
               '~Status: '             || (SELECT itevalnam
                                           FROM  cs060 cs
                                           WHERE ispgrpnam    = 'UT170'
                                           AND   datitenam    = 'STA'
                                           AND   maint       != 'D'
                                           AND   cs.datiteval = f.staevt) ||
               '~Statement Number: '   || TO_CHAR(f.untstm_no) ||
               '~Unique Reference: '   || TO_CHAR(f.unq) ||
               '~Transaction Number: ' || TO_CHAR(f.trn_no) error_message
        FROM po010 pol
        JOIN fi700 f ON  f.polref  = pol.polref
                     AND f.staevt IN (50,65,70)
        WHERE f.polref = pcn_policy_reference
        AND NOT EXISTS (SELECT 1
                        FROM  pr310 pr
                        WHERE pr.fndref  = f.fndref
                        AND   pr.maint  != 'D'
                        AND   pr.fndref  > 0)

        AND   pol.stapol IN (30,52)
        AND   pol.maint  != 'D'
        AND (   pol.prdref LIKE 'TAL%'
             OR pol.prdref LIKE 'RS%'
             OR pol.prdref LIKE 'TL98%');

    BEGIN

        FOR i IN cu_fund_movement_detail(pn_policy_reference) LOOP
                 --Raise exception 131
                 p_raise_exception(i.polref
                                  ,131
                                  ,i.error_message
                                  ,i.prdref
                                  );
        END LOOP;

    END p_invalid_fund_movt_investment;

    /*===========================================================================================
    Procedure p_invalid_fund_movt_increment
    Checks for PGIUP records with missing increment
    -- %param pn_policy_reference IN po010.polref%TYPE
    If updating this cursor then update pck_exceptions.bulk_invalid_fnd_mvt_incrmnt
    ============================================================================================*/
    PROCEDURE p_invalid_fund_movt_increment(pn_policy_reference IN po010.polref%TYPE)
    IS

        lv_product_with_rights_type  VARCHAR2(1) := 'N';

        CURSOR cu_fund_movement_detail(pcn_policy_reference IN po010.polref%TYPE)
        IS
        SELECT *
        FROM (
                 SELECT  f.polref
                        ,pol.prdref
                        ,'Investment Fund: '     || pr.fndweenam ||
                         '~Effective Date: '     || TO_CHAR(TO_DATE(TO_CHAR(f.efvdte + 2415021), 'J'), 'DD-MM-YYYY')||
                         '~Fund Code: '          || TO_CHAR(pr.fnd_id)||
                         '~Increment Type: '     || f.inrtyp ||
                         '~Increment Ref: '      || f.inrref ||
                         '~Rights Type: '        || (CASE
                                                        WHEN lv_product_with_rights_type = 'Y' THEN
                                                           f.rhttyp
                                                        ELSE 'N/A'
                                                     END) ||
                         '~Transaction Type: '   || f.fndtrntyp ||
                         '~Status: '             || (SELECT itevalnam
                                                     FROM  cs060 cs
                                                     WHERE ispgrpnam    = 'UT170'
                                                     AND   datitenam    = 'STA'
                                                     AND   maint       != 'D'
                                                     AND   cs.datiteval = f.staevt) ||
                         '~Statement Number: '   || TO_CHAR(f.untstm_no) ||
                         '~Unique Reference: '   || TO_CHAR(f.unq) ||
                         '~Transaction Number: ' || TO_CHAR(f.trn_no) error_message
                        ,(CASE
                             WHEN  EXISTS (SELECT 1
                                           FROM po020 inc
                                           WHERE inc.maint      !=    'D'
                                           AND   inc.polref      =    f.polref
                                           AND   inc.inrtyp      =    f.inrtyp
                                           AND   inc.inrref      =    f.inrref
                                           AND   inc.maibentyp  LIKE  'INV%'
                                           AND ((inc.stainr    NOT IN (30,52)
                                            AND  inc.extmod      =    0)
                                           OR   (inc.stainr      =    61
                                            AND  inc.extmod    NOT IN (12,32,35)))) THEN
                                  'Yes'
                             ELSE 'No'
                          END)  increment_invalid
                      ,(CASE
                           WHEN EXISTS (SELECT 1
                                        FROM  po020 inc2
                                        WHERE inc2.maint     !=   'D'
                                        AND   inc2.polref     =   f.polref
                                        AND   inc2.inrtyp     =   f.inrtyp
                                        AND   inc2.inrref     =   f.inrref
                                        AND   inc2.maibentyp LIKE 'INV%') THEN
                                'Yes'
                           ELSE 'No'
                        END) increment_exist
                 FROM   fi700 f
                 JOIN   pr310 pr ON pr.fndref = f.fndref
                                 AND pr.maint != 'D'
                 JOIN   po010 pol ON  f.polref   = pol.polref
                                  AND pol.stapol IN (30, 52)
                                  AND pol.maint  != 'D'
                                  AND (pol.prdref LIKE 'TAL%'
                                  OR pol.prdref LIKE 'RS%'
                                  OR pol.prdref LIKE 'TL98%')
                 WHERE f.polref = pcn_policy_reference
                 AND   f.staevt = 50
                 AND   f.inrtyp NOT IN ('RVP','AVCR')
              )
        WHERE increment_invalid = 'Yes'
        OR    increment_exist   = 'No';

    BEGIN

        lv_product_with_rights_type := pck_policy_details.f_rights_type_applicable(pn_policy_reference);

        FOR i IN cu_fund_movement_detail(pn_policy_reference) LOOP
                 --Raise exception 132
                 p_raise_exception(i.polref
                                  ,132
                                  ,i.error_message
                                  ,i.prdref
                                  );
        END LOOP;
    END p_invalid_fund_movt_increment;

    /*===========================================================================================
    Procedure p_invalid_fund_movt_othr_benft
    Checks for PGIUP records with other benefit quantity greater than benefit quantity 1
    -- %param pn_policy_reference IN po010.polref%TYPE
    If updating this cursor then update pck_exceptions.p_bulk_invalid_fnd_mvt_othben
    ============================================================================================*/
    PROCEDURE p_invalid_fund_movt_othr_bnft(pn_policy_reference IN po010.polref%TYPE)
    IS

        lv_product_with_rights_type  VARCHAR2(1) := 'N';

        CURSOR cu_fund_movement_detail(pcn_policy_reference IN po010.polref%TYPE)
        IS
        SELECT f.polref
              ,pol.prdref
              ,'Investment Fund: '     || pr.fndweenam ||
               '~Effective Date: '     || TO_CHAR(TO_DATE(TO_CHAR(f.efvdte + 2415021), 'J'), 'DD-MM-YYYY')||
               '~Fund Code: '          || TO_CHAR(pr.fnd_id)||
               '~Increment Type: '     || f.inrtyp ||
               '~Increment Ref: '      || f.inrref ||
               '~Rights Type: '        || (CASE
                                             WHEN lv_product_with_rights_type = 'Y' THEN
                                               f.rhttyp
                                             ELSE 'N/A'
                                           END) ||
               '~Transaction Type: '   || f.fndtrntyp ||
               '~Status: '             || (SELECT itevalnam
                                           FROM  cs060 cs
                                           WHERE ispgrpnam    = 'UT170'
                                           AND   datitenam    = 'STA'
                                           AND   maint       != 'D'
                                           AND   cs.datiteval = f.staevt) ||
               '~Statement Number: '   || TO_CHAR(f.untstm_no) ||
               '~Unique Reference: '   || TO_CHAR(f.unq) ||
               '~Transaction Number: ' || TO_CHAR(f.trn_no) ||
               '~Benefit Quantity 1: ' || (CASE
                                              WHEN f.benqty1 = 0 THEN
                                                 '0'
                                              ELSE TO_CHAR(f.benqty1,'fm99999990.000')
                                           END) ||
               '~Other Benefit Quantity: ' || (CASE
                                                  WHEN f.benqty1 = 0 THEN
                                                     '0'
                                                  ELSE TO_CHAR(f.othbenqty,'fm99999990.000')
                                               END)  error_message
        FROM fi700 f
        JOIN pr310 pr ON pr.fndref  = f.fndref
                      AND pr.maint != 'D'
        JOIN po010 pol ON f.polref     = pol.polref
                       AND pol.stapol IN (30, 52)
                       AND pol.maint  != 'D'
                       AND (pol.prdref LIKE 'TAL%'
                         OR pol.prdref LIKE 'TL98%')
        WHERE f.polref         = pcn_policy_reference
        AND   f.staevt        IN (50,65,70)
        AND   ABS(f.othbenqty) > ABS(f.benqty1);

    BEGIN

        lv_product_with_rights_type := pck_policy_details.f_rights_type_applicable(pn_policy_reference);

        FOR i IN cu_fund_movement_detail(pn_policy_reference) LOOP
                 --Raise exception 133
                 p_raise_exception(i.polref
                                  ,133
                                  ,i.error_message
                                  ,i.prdref
                                  );
        END LOOP;
    END p_invalid_fund_movt_othr_bnft;

    --  Checks for fund holding inconsistencies in valuation and unit processing errors
    PROCEDURE p_bonus_holding_inconsistency(pn_policy_reference IN po010.polref%TYPE
                                           ,pv_product_type     IN po010.prdref%TYPE) IS
        CURSOR cu_fund_holdings(pcn_policy_number IN po010.polref%TYPE) IS
        WITH policy_list AS (SELECT po.polref
                                   ,po.prdref
                                   ,NVL(tal_fixup.is_fixup,'N') is_fixup
                             FROM po010 po
                             JOIN health_check_product_rules hcpr ON  hcpr.product_ref = po.prdref
                                                                  AND hcpr.rule_id = 118
                                                                  AND hcpr.status = 'ACTIVE'
                             LEFT OUTER JOIN(SELECT act.polref
                                                   ,'Y' is_fixup
                                             FROM po100 act
                                             WHERE act.actref = '98 FIXUP'
                                             AND   act.sta IN (5,30,50)) tal_fixup ON tal_fixup.polref = po.polref
                              WHERE po.stapol IN (30,52)
                              AND   po.polref = pcn_policy_number
                              AND   TRUNC(TO_DATE(TO_CHAR(po.polcrcdte + 2415021),'J')
                                         ,'YYYY') < (SELECT TRUNC(TO_DATE(TO_CHAR(talbondte + 2415021),'J')
                                                                 ,'YYYY')
                                                     FROM   v_latest_ge001)
                              AND   NOT EXISTS (SELECT  1
                                                FROM    po030
                                                WHERE   po030.polref    = po.polref
                                                AND     po030.lv_ind   IN ('L','S')
                                                AND     po030.ivmin_fnd = 'Y'
                                                AND     po030.staben    = 30
                                                AND     po030.maint    != 'D')
                              AND   po.maint != 'D'
                              UNION
                              SELECT po.polref
                                    ,po.prdref
                                    ,NVL(tal_fixup.is_fixup,'N') is_fixup
                              FROM po010 po
                              JOIN health_check_product_rules hcpr ON  hcpr.product_ref = po.prdref
                                                                   AND hcpr.rule_id = 138
                                                                   AND hcpr.status = 'ACTIVE'
                              LEFT OUTER JOIN(SELECT act.polref
                                                    ,'Y' is_fixup
                                              FROM po100 act
                                              WHERE act.actref = '98 FIXUP'
                                              AND   act.sta IN (5,30,50)) tal_fixup ON tal_fixup.polref = po.polref
                               WHERE po.stapol IN (30,52)
                               AND   po.polref = pcn_policy_number
                               AND   po.maint != 'D')
            ,co51 AS (SELECT  DISTINCT polref
                             ,fndref
                             ,rhttyp
                             ,basben
                             ,totdba
                             ,othbasben
                             ,spldte
                             ,split_date
                             ,profitshare_basic_benefits
                             ,profitshare_bonus_benefits
                      FROM  (SELECT  polref
                                    ,strdte
                                    ,MAX(strdte) OVER (PARTITION BY polref) AS last_bonus_date
                                    ,fndref
                                    ,rhttyp
                                    ,SUM(basben) OVER (PARTITION BY polref
                                                                   ,strdte
                                                                   ,fndref
                                                                   ,rhttyp
                                                                   ,CASE
                                                                        WHEN spldte = -99999 THEN
                                                                            'PRE'
                                                                        ELSE
                                                                            'POST'
                                                                    END) basben
                                    ,SUM(totdba) OVER (PARTITION BY polref
                                                                   ,strdte
                                                                   ,fndref
                                                                   ,rhttyp
                                                                   ,CASE
                                                                        WHEN spldte = -99999 THEN
                                                                            'PRE'
                                                                        ELSE
                                                                            'POST'
                                                                    END) totdba
                                    ,SUM(othbasben) OVER (PARTITION BY polref
                                                                      ,strdte
                                                                      ,fndref
                                                                      ,rhttyp
                                                                      ,CASE
                                                                           WHEN spldte = -99999 THEN
                                                                               'PRE'
                                                                           ELSE
                                                                              'POST'
                                                                       END) othbasben
                                    ,spldte
                                    ,CASE
                                         WHEN spldte = -99999 THEN
                                             'PRE'
                                         ELSE
                                             'POST'
                                    END split_date
                                   ,SUM(profitshare_basic_benefits) OVER (PARTITION BY polref
                                                                                      ,strdte
                                                                                      ,fndref
                                                                                      ,rhttyp
                                                                                      ,CASE
                                                                                           WHEN spldte = -99999 THEN
                                                                                               'PRE'
                                                                                           ELSE
                                                                                              'POST'
                                                                                       END) profitshare_basic_benefits
                                   ,SUM(profitshare_bonus_benefits) OVER (PARTITION BY polref
                                                                                      ,strdte
                                                                                      ,fndref
                                                                                      ,rhttyp
                                                                                      ,CASE
                                                                                           WHEN spldte = -99999 THEN
                                                                                               'PRE'
                                                                                           ELSE
                                                                                              'POST'
                                                                                       END) profitshare_bonus_benefits
                              FROM co051
                              WHERE fndref IN (300,305,310,320,340,360,400,410)
                              AND   polref = pcn_policy_number
                              AND   stabon = 30
                              AND   maint != 'D'
                              AND   enddte = 99999) co051_sub
                      WHERE  co051_sub.strdte = co051_sub.last_bonus_date)
            ,fi AS (SELECT DISTINCT f.polref
                          ,f.fndref
                          ,f.rhttyp
                          ,SUM(f.benqty1) OVER (PARTITION BY f.polref
                                                            ,f.fndref
                                                            ,f.rhttyp
                                                            ,CASE
                                                                 WHEN (f.duedte NOT IN (0,99999,-99999))THEN
                                                                     (CASE
                                                                          WHEN f.duedte < 35524 THEN
                                                                              'PRE'
                                                                          ELSE
                                                                              'POST'
                                                                      END)
                                                                 ELSE
                                                                     (CASE
                                                                          WHEN (f.efvdte >= 35524 AND f.duedte != -99999) THEN
                                                                              'POST'
                                                                          ELSE
                                                                              'PRE'
                                                                      END)
                                                             END) fi700_total
                          ,f.duedte
                          ,CASE
                               WHEN (f.duedte NOT IN (0,99999,-99999))THEN
                                   (CASE
                                        WHEN f.duedte < 35524 THEN
                                            'PRE'
                                        ELSE
                                            'POST'
                                    END)
                               ELSE
                                   (CASE
                                        WHEN (f.efvdte >= 35524 AND f.duedte != -99999) THEN
                                            'POST'
                                        ELSE
                                            'PRE'
                                    END)
                           END split_date
                          ,SUM(NVL(f.profitshare_benefits,0)) OVER (PARTITION BY f.polref
                                                                         ,f.fndref
                                                                         ,f.rhttyp
                                                                         ,CASE
                                                                              WHEN (f.duedte NOT IN (0,99999,-99999))THEN
                                                                                  (CASE
                                                                                       WHEN f.duedte < 35524 THEN
                                                                                           'PRE'
                                                                                       ELSE
                                                                                           'POST'
                                                                                   END)
                                                                              ELSE
                                                                                  (CASE
                                                                                       WHEN (f.efvdte >= 35524 AND f.duedte != -99999) THEN
                                                                                           'POST'
                                                                                       ELSE
                                                                                           'PRE'
                                                                                   END)
                                                                          END) profitshare_benefits
                    FROM fi700 f
                    LEFT OUTER JOIN (SELECT co.polref
                                           ,MAX(co.strdte) strdte
                                    FROM co051 co
                                    WHERE co.stabon = 30
                                    AND   co.bonrcdtyp IN ('T','A')
                                    AND   co.maint != 'D'
                                    AND   co.enddte = 99999
                                    AND   co.fndref IN (300,305,310,320,340,360,400,410)
                                    GROUP BY co.polref) c ON c.polref = f.polref
                    WHERE f.fndref IN (300,305,310,320,340,360,400,410)
                    AND   f.polref = pcn_policy_number
                    AND   f.staevt IN (50,65)
                    AND   f.efvdte < NVL(c.strdte, 99999))
        SELECT
               CASE
               WHEN dataset.prdref LIKE 'TAL-GPS%'
                    OR dataset.prdref LIKE 'TAL-CPS%' THEN
                   138
               ELSE
                   118
               END exception_code
              ,'CO Type: CO051' ||
               '~Investment Fund: '|| NVL((SELECT fnd.fndweenam
                                           FROM pr310 fnd
                                           WHERE dataset.fndref = fnd.fndref)
                                          ,'N/A') ||
               '~Fund Code: '   || TO_CHAR(dataset.fndref) ||
               '~Rights Type: ' || dataset.rhttyp ||
               '~CO051 Total: ' || TO_CHAR(dataset.co51_total)||
               '~FI700 Total: ' || TO_CHAR(dataset.fi700_total) ||
               '~Difference: '  || TO_CHAR(dataset.difference) ||
               '~CO051 ProfitShare Benefits Total: ' || TO_CHAR(dataset.co51_profitshare_benefits) ||
               '~FI700 ProfitShare Benefits Total: ' || TO_CHAR(dataset.fi700_profitshare_benefits) ||
               '~Difference:  ProfitShare Benefits: '  || TO_CHAR(dataset.profitshare_difference) error_text
        FROM (SELECT DISTINCT pl.polref
                    ,pl.prdref
                    ,totals.fndref
                    ,totals.rhttyp
                    ,totals.split_date
                    ,totals.fi700_total
                    ,CASE pl.is_fixup
                         WHEN 'Y' THEN
                             totals.basben + totals.totdba + totals.othbasben
                         ELSE
                             totals.basben + totals.totdba
                     END co51_total
                    ,CASE pl.is_fixup
                         WHEN 'Y' THEN
                             (totals.basben + totals.totdba + totals.othbasben) - totals.fi700_total
                         ELSE
                             (totals.basben + totals.totdba) - totals.fi700_total
                     END difference
                    ,(totals.profitshare_basic_benefits + totals.profitshare_bonus_benefits) co51_profitshare_benefits
                    ,totals.profitshare_benefits fi700_profitshare_benefits
                    ,((totals.profitshare_basic_benefits + totals.profitshare_bonus_benefits) - totals.profitshare_benefits) profitshare_difference
              FROM policy_list pl
              JOIN (SELECT NVL(co51.polref, fi.polref) polref
                          ,NVL(co51.fndref,fi.fndref) fndref
                          ,NVL(co51.rhttyp,fi.rhttyp) rhttyp
                          ,NVL(co51.spldte,fi.duedte) spldte
                          ,NVL(co51.split_date,fi.split_date) split_date
                          ,NVL(co51.basben,0) basben
                          ,NVL(co51.totdba,0) totdba
                          ,NVL(co51.othbasben, 0) othbasben
                          ,NVL(fi.fi700_total,0) fi700_total
                          ,NVL(co51.profitshare_basic_benefits,0) profitshare_basic_benefits
                          ,NVL(co51.profitshare_bonus_benefits,0) profitshare_bonus_benefits
                          ,NVL(fi.profitshare_benefits,0) profitshare_benefits
                    FROM co51
                    FULL OUTER JOIN  fi ON  fi.polref = co51.polref
                                        AND fi.rhttyp = co51.rhttyp
                                        AND fi.fndref = co51.fndref
                                        AND fi.split_date = co51.split_date) totals ON totals.polref = pl.polref) dataset
        WHERE ABS(dataset.difference) > 1;


    BEGIN
        pck_process_info.p_set_action('p_bonus_holding_inconsistency');

        FOR lr_fund_holdings IN cu_fund_holdings(pn_policy_reference) LOOP
            p_raise_exception(pn_policy_reference
                             ,lr_fund_holdings.exception_code
                             ,lr_fund_holdings.error_text
                             ,pv_product_type);
        END LOOP;

    END p_bonus_holding_inconsistency;

    PROCEDURE p_fund_holding_inconsistency(pn_policy_reference IN po010.polref%TYPE
                                          ,pv_product_type     IN po010.prdref%TYPE) IS

        CURSOR cu_fund_holdings(pcn_policy_number IN po010.polref%TYPE) IS
        WITH policy_list AS (SELECT DISTINCT po.polref
                                   ,po.prdref
                                   ,co.fndref
                                   ,co.rhttyp
                                   ,co.benqty1
                                   ,co.benqty2
                                   ,co.othbenqty
                                   ,CASE
                                        WHEN co.spldte = 35524 THEN
                                            'POST'
                                        ELSE
                                            'PRE'
                                    END split_date
                                   ,NVL(co.profitshare_benefits,0) profitshare_benefits
                             FROM po010 po
                             JOIN co055 co ON  co.polref = po.polref
                                           AND co.stastd = 30
                                           AND co.maint != 'D'
                                           AND co.untstm_no = 999
                             JOIN health_check_product_rules hcpr ON  hcpr.product_ref = po.prdref
                                                                  AND hcpr.rule_id = 134
                                                                  AND hcpr.status = 'ACTIVE'
                             WHERE po.stapol IN (30,52)
                             AND   po.polref = pcn_policy_number
                             AND   po.maint != 'D')
        SELECT pl.polref
              ,pl.prdref
              ,134 exception_code
              ,'CO Type: CO055' ||
               '~Investment Fund: '|| NVL((SELECT fnd.fndweenam
                                           FROM pr310 fnd
                                           WHERE pl.fndref = fnd.fndref)
                                          ,'N/A') ||
               '~Fund Code: '   ||TO_CHAR(pl.fndref) ||
               '~Rights Type: ' || pl.rhttyp ||
               '~PRE/POST: '    || pl.split_date ||
               '~CO055 Total: Benqty: ' || TO_CHAR(pl.benqty1) ||
               ', Benqty2: '   || TO_CHAR(pl.benqty2) ||
               ', Othbenqty: ' || TO_CHAR(pl.othbenqty) ||
               '~FI700 Total: Benqty: ' || NVL(TO_CHAR(fund_totals.bentot),0) ||
               ', Benqty2: '   || NVL(TO_CHAR(fund_totals.bentot2),0) ||
               ', Othbenqty: ' || NVL(TO_CHAR(fund_totals.othbentot),0) ||
               '~Difference:  Benqty: ' || TO_CHAR(ABS(pl.benqty1 - NVL(fund_totals.bentot,0))) ||
               ', Benqty2: '   || TO_CHAR(ABS(pl.benqty2 - NVL(fund_totals.bentot2,0))) ||
               ', Othbenqty: ' || TO_CHAR(ABS(pl.othbenqty - NVL(fund_totals.othbentot,0)) ||
               '~CO055 Total: ProfitShare Benefits: ' || TO_CHAR(pl.profitshare_benefits) ||
               '~FI700 Total: ProfitShare Benefits: ' || NVL(TO_CHAR(fund_totals.profitshare_benefits),0) ||
               '~Difference:  ProfitShare Benefits: ' || TO_CHAR(ABS(pl.profitshare_benefits - NVL(fund_totals.profitshare_benefits,0)))) error_text
        FROM policy_list pl
        LEFT OUTER JOIN(SELECT DISTINCT fi.polref
                              ,fi.fndref
                              ,fi.rhttyp
                              ,SUM(fi.benqty1) OVER (PARTITION BY fi.polref
                                                                 ,fi.fndref
                                                                 ,fi.rhttyp
                                                                 ,CASE
                                                                      WHEN (fi.duedte NOT IN (0,99999,-99999))THEN
                                                                          (CASE
                                                                               WHEN fi.duedte < 35524 THEN
                                                                                   'PRE'
                                                                               ELSE
                                                                                   'POST'
                                                                           END)
                                                                      ELSE
                                                                          (CASE
                                                                               WHEN (fi.efvdte >= 35524 AND fi.duedte != -99999) THEN
                                                                                   'POST'
                                                                               ELSE
                                                                                   'PRE'
                                                                           END)
                                                                  END) AS bentot
                              ,SUM(fi.benqty2) over (PARTITION BY fi.polref
                                                                 ,fi.fndref
                                                                 ,fi.rhttyp
                                                                 ,CASE
                                                                      WHEN (fi.duedte NOT IN (0,99999,-99999))THEN
                                                                          (CASE
                                                                               WHEN fi.duedte < 35524 THEN
                                                                                   'PRE'
                                                                               ELSE
                                                                                   'POST'
                                                                           END)
                                                                      ELSE
                                                                          (CASE
                                                                               WHEN (fi.efvdte >= 35524 AND fi.duedte != -99999) THEN
                                                                                   'POST'
                                                                               ELSE
                                                                                   'PRE'
                                                                           END)
                                                                  END) AS bentot2
                               ,SUM(fi.othbenqty) OVER (PARTITION BY fi.polref
                                                                    ,fi.fndref
                                                                    ,fi.rhttyp
                                                                    ,CASE
                                                                         WHEN (fi.duedte NOT IN (0,99999,-99999))THEN
                                                                             (CASE
                                                                                  WHEN fi.duedte < 35524 THEN
                                                                                      'PRE'
                                                                                  ELSE
                                                                                      'POST'
                                                                              END)
                                                                         ELSE
                                                                             (CASE
                                                                                  WHEN (fi.efvdte >= 35524 AND fi.duedte != -99999) THEN
                                                                                      'POST'
                                                                                  ELSE
                                                                                      'PRE'
                                                                              END)
                                                                     END) AS othbentot
                               ,CASE
                                    WHEN (fi.duedte NOT IN (0,99999,-99999))THEN
                                        (CASE
                                             WHEN fi.duedte < 35524 THEN
                                                 'PRE'
                                             ELSE
                                                 'POST'
                                         END)
                                    ELSE
                                        (CASE
                                             WHEN (fi.efvdte >= 35524 AND fi.duedte != -99999) THEN
                                                 'POST'
                                             ELSE
                                                 'PRE'
                                         END)
                                END split_date
                               ,SUM (NVL(fi.profitshare_benefits,0)) OVER (PARTITION BY fi.polref
                                                                                ,fi.fndref
                                                                                ,fi.rhttyp
                                                                                ,CASE
                                                                                     WHEN (fi.duedte NOT IN (0,99999,-99999))THEN
                                                                                         (CASE
                                                                                              WHEN fi.duedte < 35524 THEN
                                                                                                  'PRE'
                                                                                              ELSE
                                                                                                  'POST'
                                                                                          END)
                                                                                     ELSE
                                                                                         (CASE
                                                                                              WHEN (fi.efvdte >= 35524 AND fi.duedte != -99999) THEN
                                                                                                  'POST'
                                                                                              ELSE
                                                                                                  'PRE'
                                                                                          END)
                                                                                 END) AS profitshare_benefits
                        FROM fi700 fi
                        WHERE fi.staevt IN (50,65)
                        AND   fi.polref = pcn_policy_number) fund_totals ON  fund_totals.polref = pl.polref
                                                                         AND fund_totals.fndref = pl.fndref
                                                                         AND fund_totals.rhttyp = pl.rhttyp
                                                                         AND fund_totals.split_date = pl.split_date
        WHERE NVL(bentot, 0)    != NVL(benqty1, 0)
        OR    NVL(bentot2, 0)   != NVL(benqty2, 0)
        OR    NVL(othbentot, 0) != NVL(othbenqty, 0);

    BEGIN
        pck_process_info.p_set_action('p_fund_holding_inconsistency');

        FOR lr_fund_holdings IN cu_fund_holdings(pn_policy_reference) LOOP
            p_raise_exception(pn_policy_reference
                             ,lr_fund_holdings.exception_code
                             ,lr_fund_holdings.error_text
                             ,pv_product_type);
        END LOOP;

    END p_fund_holding_inconsistency;

    PROCEDURE p_incr_holding_inconsistency(pn_policy_reference IN po010.polref%TYPE
                                          ,pv_product_type     IN po010.prdref%TYPE) IS

        CURSOR cu_fund_holdings(pcn_policy_number IN po010.polref%TYPE) IS
        WITH policy_list AS (SELECT po.polref
                                   ,po.prdref
                                   ,co.fndref
                                   ,co.inrtyp
                                   ,co.inrref
                                   ,co.rhttyp
                                   ,CASE
                                        WHEN spldte = 35524 THEN
                                            'POST'
                                        ELSE
                                            'PRE'
                                    END split_date
                                  ,co.cal_yr
                                  ,CASE
                                   WHEN po.prdref  LIKE 'TL98%' THEN
                                       co.benqty + co.othbenqty
                                   ELSE
                                       co.benqty
                                   END benqty
                                  ,NVL(co.profitshare_benefits,0) profitshare_benefits
                             FROM po010 po
                             JOIN co058 co ON  co.polref = po.polref
                             JOIN health_check_product_rules hcpr ON  hcpr.product_ref = po.prdref
                                                                  AND hcpr.rule_id = 135
                                                                  AND hcpr.status = 'ACTIVE'
                             WHERE po.stapol IN (30,52)
                             AND po.polref = pcn_policy_number
                             AND   po.maint != 'D')
        SELECT pl.polref
              ,pl.prdref
              ,135 exception_code
              ,'CO Type: CO058' ||
               '~Investment Fund: ' ||(SELECT fndweenam
                                       FROM   pr310 fnd
                                       WHERE fnd.fndref = pl.fndref) ||
               '~Fund Code: '     || TO_CHAR(pl.fndref) ||
               '~Increment Type: '|| pl.inrtyp ||
               '~Increment Ref: ' || TO_CHAR(pl.inrref) ||
               '~Rights Type: '   || pl.rhttyp ||
               '~PRE/POST: '      || pl.split_date ||
               '~Calendar Year: ' || TO_CHAR(pl.cal_yr) ||
               '~CO058 Total: '   || TO_CHAR(pl.benqty) ||
               '~FI700 Total: '   || TO_CHAR(NVL(fund_totals.fi700tot,0) ||
               '~CO058 ProfitShare Benefits Total: '   || TO_CHAR(pl.profitshare_benefits) ||
               '~FI700 ProfitShare Benefits Total: '   || TO_CHAR(NVL(fund_totals.profitshare_benefits,0))) error_text
        FROM policy_list pl
        LEFT OUTER JOIN (SELECT DISTINCT fi.polref
                                        ,fi.fndref
                                        ,fi.inrtyp
                                        ,CASE
                                             WHEN fi.inrtyp IN ('RVP','AVCO','AVCR') THEN
                                                 0
                                             ELSE
                                                 fi.inrref
                                         END inrref
                                        ,fi.rhttyp
                                        ,fi.cal_yr
                                        ,CASE
                                             WHEN fi.inrtyp IN ('RVP','AVCO','AVCR') THEN
                                                 SUM(fi.benqty1) OVER (PARTITION BY fi.polref
                                                                                   ,fi.fndref
                                                                                   ,fi.inrtyp
                                                                                   ,fi.rhttyp
                                                                                   ,fi.cal_yr
                                                                                   ,CASE
                                                                                        WHEN (fi.duedte NOT IN (0,99999,-99999))THEN
                                                                                            (CASE
                                                                                                 WHEN fi.duedte < 35524 THEN
                                                                                                     'PRE'
                                                                                                 ELSE
                                                                                                     'POST'
                                                                                             END)
                                                                                    ELSE
                                                                                        (CASE
                                                                                             WHEN (fi.efvdte >= 35524 AND fi.duedte != -99999) THEN
                                                                                                 'POST'
                                                                                             ELSE
                                                                                                 'PRE'
                                                                                             END)
                                                                                    END)
                                             ELSE
                                                 SUM(fi.benqty1) over (PARTITION BY fi.polref
                                                                                   ,fi.fndref
                                                                                   ,fi.inrtyp
                                                                                   ,fi.inrref
                                                                                   ,fi.rhttyp
                                                                                   ,fi.cal_yr
                                                                                   ,CASE
                                                                                        WHEN (fi.duedte NOT IN (0,99999,-99999))THEN
                                                                                            (CASE
                                                                                                 WHEN fi.duedte < 35524 THEN
                                                                                                     'PRE'
                                                                                                 ELSE
                                                                                                     'POST'
                                                                                             END)
                                                                                    ELSE
                                                                                        (CASE
                                                                                             WHEN (fi.efvdte >= 35524 AND fi.duedte != -99999) THEN
                                                                                                 'POST'
                                                                                             ELSE
                                                                                                 'PRE'
                                                                                             END)
                                                                                    END)
                                        END AS fi700tot
                                       ,CASE
                                            WHEN (fi.duedte NOT IN (0,99999,-99999))THEN
                                                (CASE
                                                     WHEN fi.duedte < 35524 THEN
                                                         'PRE'
                                                     ELSE
                                                         'POST'
                                                 END)
                                            ELSE
                                                (CASE
                                                     WHEN (fi.efvdte >= 35524 AND fi.duedte != -99999) THEN
                                                         'POST'
                                                     ELSE
                                                         'PRE'
                                                 END)
                                        END pre_or_post
                                       ,SUM(NVL(fi.profitshare_benefits,0)) OVER (PARTITION BY fi.polref
                                                                                       ,fi.fndref
                                                                                       ,fi.inrtyp
                                                                                       ,fi.inrref
                                                                                       ,fi.rhttyp
                                                                                       ,fi.cal_yr
                                                                                       ,CASE
                                                                                            WHEN (fi.duedte NOT IN (0,99999,-99999))THEN
                                                                                                (CASE
                                                                                                     WHEN fi.duedte < 35524 THEN
                                                                                                         'PRE'
                                                                                                     ELSE
                                                                                                         'POST'
                                                                                                 END)
                                                                                        ELSE
                                                                                            (CASE
                                                                                                 WHEN (fi.efvdte >= 35524 AND fi.duedte != -99999) THEN
                                                                                                     'POST'
                                                                                                 ELSE
                                                                                                     'PRE'
                                                                                                 END)
                                                                                        END) AS profitshare_benefits
                         FROM fi700 fi
                         WHERE fi.staevt IN (50,65)
                         AND   fi.polref = pcn_policy_number) fund_totals ON  fund_totals.polref = pl.polref
                                                                          AND fund_totals.fndref = pl.fndref
                                                                          AND fund_totals.inrtyp = pl.inrtyp
                                                                          AND fund_totals.inrref = pl.inrref
                                                                          AND fund_totals.cal_yr = pl.cal_yr
                                                                          AND fund_totals.rhttyp = pl.rhttyp
                                                                          AND fund_totals.pre_or_post = pl.split_date
        WHERE NVL(fund_totals.fi700tot,0) != benqty;

    BEGIN
        pck_process_info.p_set_action('p_incr_holding_inconsistency');

        FOR lr_fund_holdings IN cu_fund_holdings(pn_policy_reference) LOOP
            p_raise_exception(pn_policy_reference
                             ,lr_fund_holdings.exception_code
                             ,lr_fund_holdings.error_text
                             ,pv_product_type);
        END LOOP;

    END p_incr_holding_inconsistency;

    --  Checks for fund holding inconsistencies in valuation and unit processing errors
    PROCEDURE p_switch_inconsistency(pn_policy_in IN po010.polref%TYPE) IS

        CURSOR cu_switch_check(pcn_policy_in          IN po010.polref%TYPE
                              ,pcn_tolerance_limit_in IN NUMBER) IS
        SELECT polref
              ,prdref
              ,'Switch In Amount does not equal Switch Out Amount' ||
               '~Effective Date: ' || TO_CHAR(TO_DATE(TO_CHAR(efvdte + 2415021),'J')) ||
               '~Transaction Control Number: ' || TO_CHAR(trnctl_no) ||
               '~SW In Amount (includes any charges): £'  || TO_CHAR(switch_in) ||
               '~SW Out Amount: £' || TO_CHAR(switch_out) ||
               '~Charge amount: £' || TO_CHAR(crgamt) ||
               '~calculated SW In amount (Units*Price): £' || TO_CHAR(amt_in) ||
               '~calculated SW Out amount (Units*Price): £' || TO_CHAR(amt_out) error_text
        FROM (SELECT f.polref
                    ,p.prdref
                    ,f.trnctl_no
                    ,f.efvdte
                    ,SUM(DECODE(SIGN(f.amt),1,f.amt,0)) + crgamt AS switch_in
                    ,SUM(DECODE(SIGN(f.amt),-1,f.amt,0)) switch_out
                    ,SUM(DECODE(SIGN((f.fndprc*f.benqty1)), 1, ROUND((f.fndprc*f.benqty1)/100,2), 0)) AS amt_in
                    ,SUM(DECODE(SIGN((f.fndprc*f.benqty1)), -1, ROUND((f.fndprc*f.benqty1)/100,2), 0)) amt_out
                    ,pa.crgamt
              FROM fi700 f
              JOIN po010 p ON  p.polref = f.polref
                           AND p.maint != 'D'
                           AND p.stapol IN (30,52)
              JOIN health_check_product_rules hcpr ON  hcpr.product_ref = p.prdref
                                                   AND hcpr.status = 'ACTIVE'
                                                   AND hcpr.rule_id = 13
              JOIN pa020 pa ON  pa.polref    = f.polref
                            AND pa.trnctl_no = f.trnctl_no
                            AND pa.efvdte    = f.efvdte
                            AND pa.sta_pa    = 50
                            AND pa.maint    <> 'D'
              WHERE f.fndtrntyp = 'SW'
              AND   f.staevt = 50
              AND   f.polref = pcn_policy_in
              GROUP BY f.polref
                      ,p.prdref
                      ,f.trnctl_no
                      ,f.efvdte
                      ,pa.crgamt)
        WHERE ABS(switch_in+ switch_out) > pcn_tolerance_limit_in;

        lt_param_values pck_batch_control_params.t_batch_control_parameters;

        ln_tolerance_limit NUMBER(7) := 0;

    BEGIN
        pck_process_info.p_set_action('p_switch_inconsistency');
        lt_param_values := pck_batch_control_params.f_get_batch_cntrl_params (pv_pck_name => 'PCK_POLICY_EXCEPTIONS'
                                                                             ,pv_routine_name => 'P_SWITCH_INCONSISTENCY'
                                                                             );
        FOR i IN 1 .. lt_param_values.COUNT LOOP
            IF lt_param_values(i).param_name = 'LN_TOLERANCE_LIMIT' THEN
                ln_tolerance_limit := lt_param_values(i).param_value;
            ELSE
                ln_tolerance_limit := 0;
            END IF;
        END LOOP;
        FOR lr_switch_check IN cu_switch_check(pn_policy_in
                                              ,ln_tolerance_limit) LOOP
            p_raise_exception(pn_policy_in
                             ,13
                             ,lr_switch_check.error_text
                             ,lr_switch_check.prdref);
        END LOOP;

    END p_switch_inconsistency;


    /*******************************************************************************
     -- %Description Calls FAF calulcation routine and checks for FAF discrepancies
     --              raises healthceck exception when discrepancy found for policy.
     -- %param   pn_polref  IN po100.polref%TYPE
     -- %raises  NONE
     *******************************************************************************/
    PROCEDURE p_faf_discrepancy(pn_polref  IN  po100.polref%TYPE) IS

    CURSOR cu_discrepancy(pcn_polref      IN po100.polref%TYPE) IS
        SELECT DISTINCT p.polref
                   ,129 exception_number
                   ,fsa.product_ref
                   ,'Increment: '||p.inrtyp||' '||p.inrref||', Fund Discrepancy:  ' || CHR(163) ||
                     LPAD(TO_CHAR(p.amt,'FM9999999990.90'),12)||
                    ', Status: '||CASE
                                    WHEN p.sta = 30 THEN 'Live'
                                    WHEN p.sta = 60 THEN 'Calculated'
                                    ELSE 'Unknown'
                                 END ||
                    '~' || actpar error_message
    FROM   po100 p
          ,faf_stats_analysis fsa
    WHERE  p.polref = pcn_polref
    AND    p.actref = 'FAF ERROR'
    AND    p.sta    = 30  -- LIVE
    AND    fsa.policy_reference = p.polref
    AND    fsa.rec_type = 'ADHOC FAF HEALTHCHECK';

    BEGIN
        pck_process_info.p_set_action(pv_action_name=>'P_FAF_DISCREPANCY');
        -- call the validation and calculation routines for FAF discrepanci
        pck_adhoc_faf_stats_wrapper.p_adh_faf_analysis(pn_polref => pn_polref);
        -- check if any discrepancies for any of the policy increments
        FOR x IN cu_discrepancy(pcn_polref      =>  pn_polref)
        LOOP
            -- log the exception for the policy
            p_raise_exception(pn_polref
                             ,x.exception_number
                             ,x.error_message
                             ,x.product_ref);
        END LOOP;
    END p_faf_discrepancy;


    /*******************************************************************************
     -- %Description Checks for ITR discrepancies
     --   NB: Must run after healthcheck 129 (FAF DISCREPANCY) above, as reliant on data generated by that check
     --   Checks for ITR discrepancies on all FAF increments for a policy
     --   If policy already has FAF discrpancies generated by 129 above then exceptions will be raised.
     --   If policy only has ITR discrepancies then NO exceptions are raised UNLESS its for ADHOC health checks
     --   at policy level (process 1005) and scheme level (process 1006).
     --   This is to ensure that ITR only discrepancies do not stop processing of settlements,exits etc
     --   within AWD framework as no impact on policy values.
     -- %param   pn_polref  IN po100.polref%TYPE
     -- %raises  NONE
     *******************************************************************************/
    PROCEDURE p_faf_itr_discrepancy(pn_polref     IN  po100.polref%TYPE
                                   ,pn_process_id IN  health_check_processes.process_id%TYPE) IS

    -- fetch and translate the abbreviated ACTPL string (max 100 chars) into something more readable
    CURSOR cu_itr_discrepancy(pcn_polref      IN po100.polref%TYPE) IS
    SELECT DISTINCT p.polref
                   ,144 exception_number
                   ,fsa.product_ref
                   ,'Increment: '||p.inrtyp||' '||p.inrref||', FAF ITR Discrepancy:  ' || CHR(163) ||
                     LPAD(TO_CHAR(p.amt,'FM9999999990.90'),12)||
                    ', Status: '||CASE
                                    WHEN p.sta = 30 THEN 'Live'
                                    WHEN p.sta = 60 THEN 'Calculated'
                                    ELSE 'Unknown'
                                 END ||
                    '~' || REPLACE(REPLACE(actpar,'(Unable to calculate) ','(Unable to calculate due amt)')
                                                 ,'ITR W\Off','FAF ITR Audit Table W/Off')  error_message
    FROM   po100 p
          ,faf_stats_analysis fsa
    WHERE  p.polref = pcn_polref
    AND    p.actref = 'FAFITRERR'
    AND    p.sta    = 30  -- LIVE
    AND    fsa.policy_reference = p.polref
    AND    fsa.rec_type = 'ADHOC FAF HEALTHCHECK';

    lb_faf_error  BOOLEAN := FALSE;

    BEGIN
        pck_process_info.p_set_action(pv_action_name=>'P_FAF_ITR_DISCREPANCY');

        -- check if any FAF exceptions have been raised for the policy
        lb_faf_error := pck_activity.f_activity_exists(pn_policy_reference => pn_polref
                                                      ,pv_actref           => 'FAF ERROR');

        -- only continue to check for ITR discpreancies to raise exceptions if ADHOC healthcheck or FAF discrepancy
        IF lb_faf_error
        OR pn_process_id IN (1005, 1006, 1029) THEN
            -- now check for ITR discrepancies for any of the policy increments
            FOR x IN cu_itr_discrepancy(pcn_polref      =>  pn_polref)
            LOOP
                -- log the exception for the policy, because a FAF exception has been raised
                p_raise_exception(pn_polref
                                 ,x.exception_number
                                 ,x.error_message
                                 ,x.product_ref);
            END LOOP;
        END IF;

    END p_faf_itr_discrepancy;


    PROCEDURE p_pgiup_inconsistency(pn_policy_in IN po010.polref%TYPE)
    IS
        CURSOR cu_pgiup_inconsistency(pcn_policy_reference po010.polref%TYPE)
        IS
        --110 Policy Level
        WITH policy AS (SELECT pol.polref policy_reference   -- Only get the policies we are interested in
                              ,pol.prdref
                        FROM  po010 pol
                        WHERE pol.stapol IN (30,52)
                          AND pol.prdref IN ('RS-STK','RS-PP','RS-S32','RS-EPP') --Stakeholder only
                          AND pol.pupdte = -99999
                          AND pol.polref = pcn_policy_reference
                       )
                SELECT DISTINCT policy_reference
                               ,product_ref
                               ,'PGIUP not consistent with INCRM : ' ||
                                '~Total EE Amount :'|| EE_employee_benefit_total ||
                                '~Total ER Amount :'|| ER_employer_benefit_total ||
                                '~PGIUP EE Amount :'|| pgiup_employee_grsprmamt ||
                                '~PGIUP EE Total : '|| pgiup_employee_grsprmamt * pgiup_employee_occpyr ||
                                '~PGIUP ER Amount : '|| pgiup_employer_grsprmamt ||
                                '~PGIUP ER Total : '|| pgiup_employer_grsprmamt * pgiup_employee_occpyr ||
                                '~PGIUP EE Frequency : ' || pgiup_employee_occpyr  error_message
                               ,110 exception_code
                FROM ( SELECT DISTINCT employee_grsprmamt_pgiup.policy_reference      policy_reference
                                      ,employee_grsprmamt_pgiup.gross_premium_amount  pgiup_employee_grsprmamt
                                      ,employee_grsprmamt_pgiup.occ_frequency         pgiup_employee_occpyr
                                      ,SUM(employee_contribution) over (PARTITION BY employee_grsprmamt_pgiup.policy_reference
                                                                                    ,employee_grsprmamt_pgiup.increment_type
                                                                                    ,employee_grsprmamt_pgiup.premium_group
                                                                       ) EE_employee_benefit_total
                                      ,employer_grsprmamt_pgiup.gross_premium_amount pgiup_employer_grsprmamt
                                      ,SUM(employer_contribution) over (PARTITION BY employer_grsprmamt_pgiup.policy_reference
                                                                                    ,employer_grsprmamt_pgiup.increment_type
                                                                                    ,employer_grsprmamt_pgiup.premium_group
                                                                        ) ER_employer_benefit_total
                                      ,benefits.increment_type  benefits_increment_type --BENEFITS_INCREMENT_TYPE
                                      ,employer_grsprmamt_pgiup.product_ref product_ref
                FROM (SELECT po030.polref     policy_reference --Get the total benefits, have to union hi030 with po030
                            ,po030.inrtyp     increment_type
                            ,othctbprm + othctbadm + othctbocc  employer_contribution
                            ,occxtr + po030.prmamt + admcrg - (othctbprm + othctbadm + othctbocc) employee_contribution
                      FROM  po030 po030
                           ,po020
                           ,policy
                     WHERE  po030.polref = po020.polref
                       AND  po030.polref = policy.policy_reference
                       AND  po020.polref = pcn_policy_reference
                       AND po020.prdref = policy.prdref
                       AND  po030.inrtyp = po020.inrtyp
                       AND  po030.inrref = po020.inrref
                       AND  po020.alttyp NOT IN ('E', 'S')
                       AND  po020.maint != 'D'
                       AND  po030.maint != 'D'
                       AND  bentyp NOT IN ('TA', 'PLANA', 'GLA', 'LTD', 'STD')
                       AND  ((po030.staben = 29 AND po020.inrref = po030.inrref)
                          OR (po030.staben = 30 AND po030.inrref = 0 AND po020.inrref = 1 ))
                       AND  altcde NOT IN (50, 51, 52)
                       AND  crcdte NOT IN (0, 99999, -99999)
                       AND ((othctbprm + othctbadm + othctbocc != 0 )
                         OR (occxtr + po030.prmamt + admcrg - (othctbprm + othctbadm + othctbocc) != 0))
                     UNION ALL
                     SELECT hi030.polref     policy_reference  --Get the total benefits, have to union hi030 with po030
                           ,hi030.inrtyp     increment_type
                           ,othctbprm + othctbadm + othctbocc employer_contribution
                           ,sgnoccxtr + sgnprmamt + admcrg - (othctbprm + othctbadm + othctbocc) employee_contribution
                     FROM  hi030
                          ,po020
                          ,policy
                     WHERE hi030.polref = po020.polref
                       AND hi030.polref = policy.policy_reference
                       AND po020.polref = pcn_policy_reference
                       AND hi030.inrtyp = po020.inrtyp
                       AND hi030.inrref = po020.inrref
                       AND po020.alttyp IN ('E', 'S')
                       AND po020.maint != 'D'
                       AND po020.strdte = hi030.benaltdte
                       AND hi030.maint != 'D'
                       AND bentyp NOT IN ('TA', 'PLANA', 'GLA', 'LTD', 'STD')
                       AND staben = 29
                       AND altcde NOT IN (50, 51, 52)
                       AND crcdte NOT IN (0, 99999, -99999)
                       AND ((othctbprm + othctbadm + othctbocc != 0)
                         OR (sgnoccxtr + sgnprmamt + admcrg - (othctbprm + othctbadm + othctbocc) != 0))
                      ) benefits
                    ,(SELECT policy_reference  --get the employer gross premium amount
                            ,product_ref
                            ,gross_premium_amount
                            ,status
                            ,premium_group
                            ,increment_type       -- 'RVP' etc
                            ,occ_frequency        --12 occurences = Monthly etc
                            ,payment_frequency
                      FROM (SELECT po020.polref         policy_reference
                                  ,po020.prdref         product_ref
                                  ,SUM(co072.grsprmamt) gross_premium_amount
                                  ,co072.stabil         status
                                  ,co072.prmgrp         premium_group
                                  ,co072.inrtyp         increment_type       -- 'RVP' etc
                                  ,ge070.occpyr         occ_frequency        --12 occurences etc
                                  ,ge070.frq            payment_frequency    --Monthly,Yearly etc
                            FROM  co072 co072
                            JOIN policy ON policy.policy_reference = co072.polref
                            JOIN po020 po020 ON co072.polref = po020.polref
                                            AND co072.prdref = po020.prdref
                                            AND co072.inrtyp = po020.inrtyp
                                            AND co072.inrref = po020.inrref
                                            AND co072.stabil = 30
                                            AND co072.stapol IN (30, 52)
                                            AND co072.prmgrp IN ('ER')
                                            AND co072.maint != 'D'
                            JOIN ge070 ge070 ON ge070.frq = co072.frq
                            GROUP  BY po020.polref
                                     ,po020.prdref
                                     ,co072.stabil
                                     ,co072.prmgrp
                                     ,co072.inrtyp
                                     ,ge070.occpyr
                                     ,ge070.frq)
                     ) employer_grsprmamt_pgiup
                    ,(SELECT policy_reference  -- get the employee gross premium amount from PGIUP screen
                            ,product_ref
                            ,gross_premium_amount
                            ,status
                            ,premium_group
                            ,increment_type       -- 'RVP' etc
                            ,occ_frequency        --12 occurences etc
                            ,payment_frequency
                      FROM (SELECT po020.polref         policy_reference
                                  ,po020.prdref         product_ref
                                  ,SUM(co072.grsprmamt) gross_premium_amount
                                  ,co072.stabil         status
                                  ,co072.prmgrp         premium_group
                                  ,co072.inrtyp         increment_type       -- 'RVP' etc
                                  ,ge070.occpyr         occ_frequency        --12 occurences etc
                                  ,ge070.frq            payment_frequency    --Monthly,Yearly etc
                            FROM  co072 co072
                            JOIN  policy ON policy.policy_reference = co072.polref
                            JOIN  po020 po020 ON co072.polref = po020.polref
                                             AND co072.prdref = po020.prdref
                                             AND co072.inrtyp = po020.inrtyp
                                             AND co072.inrref = po020.inrref
                                             AND co072.stabil = 30
                                             AND co072.stapol IN (30, 52)
                                             AND co072.prmgrp IN ('EE', ' ')
                                             AND co072.maint != 'D'
                            JOIN ge070 ge070 ON ge070.frq = co072.frq
                            GROUP  BY po020.polref
                                     ,po020.prdref
                                     ,co072.stabil
                                     ,co072.prmgrp
                                     ,co072.inrtyp
                                     ,ge070.occpyr
                                     ,ge070.frq)
                        ) employee_grsprmamt_pgiup
               WHERE employee_grsprmamt_pgiup.policy_reference = employer_grsprmamt_pgiup.policy_reference
                 AND employee_grsprmamt_pgiup.increment_type   = employer_grsprmamt_pgiup.increment_type
                 AND benefits.policy_reference = employer_grsprmamt_pgiup.policy_reference
                ) total_benefits
            --Only interested if the totals don't match
          WHERE ((ER_employer_benefit_total > 0 AND ER_employer_benefit_total != pgiup_employer_grsprmamt * pgiup_employee_occpyr)
              OR (EE_employee_benefit_total > 0 AND EE_employee_benefit_total != pgiup_employee_grsprmamt * pgiup_employee_occpyr));

    BEGIN

        pck_process_info.p_set_action('p_pgiup_inconsistency');

        FOR i IN cu_pgiup_inconsistency(pn_policy_in) LOOP
                 --Raise exception 110
                 p_raise_exception(i.policy_reference
                                  ,i.exception_code
                                  ,i.error_message
                                  ,i.product_ref
                                  );
        END LOOP;

    END p_pgiup_inconsistency;

    /*===========================================================================================
    Procedure p_no_actioned_fund_movt_check
    Checks if there are any actioned one-time UDCTL triggers but no actioned fund movement
    -- %param pn_policy_reference IN pa020.polref%TYPE
    -- %param pv_product_type     IN po010.prdref%TYPE
    -- If updating this cursor then update bulk level code
    ==========================================================================================*/
    PROCEDURE p_no_actioned_fund_movt_check (pn_policy_reference IN pa020.polref%TYPE
                                            ,pv_product_type     IN po010.prdref%TYPE)
    IS

        CURSOR cu_one_time_UDTCL_triggers(pcn_policy_reference  pa020.polref%TYPE)
        IS
        SELECT *
        FROM (
                SELECT  'Trigger Type: '       || pa.fndtrntyp ||
                        '~Effective Date: '    || to_date(to_char(pa.efvdte + 2415021),'J') ||
                        '~Trigger Status: ACT' ||
                        '~Audit Details: '     || pa.audaplcde || pa.audstf_no || ' ' ||
                                                  to_date(to_char(pa.audupddte + 2415021),'J') error_message
                       ,decode(fi.polref, NULL, 'N', 'Y') fi700_exist
                FROM   pa020 pa
                       LEFT OUTER JOIN fi700 fi ON  fi.polref    = pa.polref
                                                AND fi.fndtrntyp = pa.fndtrntyp
                                                AND fi.staevt    = 50
                                                AND fi.efvdte    = pa.efvdte
                                                and rownum       = 1
                WHERE pa.polref      =   pcn_policy_reference
                AND   pa.maint      !=   'D'
                AND   pa.sta_pa      =   50
                AND   pa.efvdte      <   lpn_system_date
                AND   pa.fndtrntyp  IN  ('PV', 'PTV', 'VST', 'TVO', 'DTH','RFD')
                UNION
                SELECT  'Trigger Type: '       || pa.fndtrntyp ||
                        '~Effective Date: '    || to_date(to_char(pa.efvdte + 2415021),'J') ||
                        '~Trigger Status: ACT' ||
                        '~Audit Details: '     || pa.audaplcde || pa.audstf_no || ' ' ||
                                                  to_date(to_char(pa.audupddte + 2415021),'J') error_message
                       ,decode(fi.polref, NULL, 'N', 'Y') fi700_exist
                FROM   pa020 pa
                       LEFT OUTER JOIN fi700 fi ON  fi.polref    = pa.polref
                                                AND fi.fndtrntyp = pa.fndtrntyp
                                                AND fi.staevt    = 50
                                                AND fi.efvdte    = pa.efvdte
                                                AND fi.trnctl_no = pa.trnctl_no
                WHERE pa.polref      =   pcn_policy_reference
                AND   pa.maint      !=   'D'
                AND   pa.sta_pa      =   50
                AND   pa.efvdte      <   lpn_system_date
                AND   pa.fndtrntyp  IN  ('ACA','CCA')
             )
         WHERE fi700_exist = 'N';

    BEGIN

        pck_process_info.p_set_action('p_no_actioned_fund_movt_check');

        FOR i IN cu_one_time_UDTCL_triggers(pn_policy_reference) LOOP
                 --Raise exception 136
                 p_raise_exception(pn_policy_reference
                                  ,136
                                  ,i.error_message
                                  ,pv_product_type
                                  );
        END LOOP;

    END p_no_actioned_fund_movt_check;

    /*===========================================================================================
    Procedure p_no_actioned_UDCTL_triggers
    Checks if there are actioned fund movement but no actioned UDCTL one-time trigger
    -- %param pn_policy_reference IN fi700.polref%TYPE
    -- %param pv_product_type     IN po010.prdref%TYPE
    If updating this cursor then update the bulk level code
    ============================================================================================*/
    PROCEDURE p_no_actioned_UDCTL_triggers(pn_policy_reference IN fi700.polref%TYPE
                                          ,pv_product_type     IN po010.prdref%TYPE)
    IS

        CURSOR cu_fund_movement_details(pcn_policy_reference         IN po010.polref%TYPE
                                       ,pcv_product_with_rights_type IN VARCHAR2)
        IS
        SELECT *
        FROM (
                SELECT  'Transaction Type: '    || fi.fndtrntyp  ||
                        '~Investment Fund: '    || pr.fndweenam ||
                        '~Fund Code: '          || TO_CHAR(pr.fnd_id)||
                        '~Effective Date: '     || TO_CHAR(TO_DATE(TO_CHAR(fi.efvdte + 2415021), 'J'), 'DD-MM-YYYY')||
                        '~Statement Number: '   || TO_CHAR(fi.untstm_no) ||
                        '~Increment Type: '     || fi.inrtyp ||
                        '~Increment Ref: '      || fi.inrref ||
                        '~Rights Type: '        || (CASE
                                                       WHEN pcv_product_with_rights_type = 'Y' THEN
                                                          fi.rhttyp
                                                       ELSE 'N/A'
                                                    END) ||
                        '~Unique Reference: '   || TO_CHAR(fi.unq) ||
                        '~Transaction Number: ' || TO_CHAR(fi.trn_no)  error_message
                       ,decode(pa.polref, NULL, 'N', 'Y') pa020_exist
                FROM fi700 fi
                JOIN pr310 pr  ON  pr.fndref  = fi.fndref
                               AND pr.maint  != 'D'
                LEFT OUTER JOIN pa020 pa ON  pa.maint    != 'D'
                                         AND pa.polref    = fi.polref
                                         AND pa.fndtrntyp = fi.fndtrntyp
                                         AND pa.sta_pa    = 50
                                         AND pa.efvdte    = fi.efvdte
                                         AND rownum       = 1
                WHERE fi.polref   = pcn_policy_reference
                AND   fi.staevt   = 50
                AND   fi.efvdte   < lpn_system_date
                AND   fi.fndtrntyp IN ('PV', 'PTV', 'VST', 'TVO', 'DTH','RFD')
                UNION
                SELECT  'Transaction Type: '    || fi.fndtrntyp  ||
                        '~Investment Fund: '    || pr.fndweenam ||
                        '~Fund Code: '          || TO_CHAR(pr.fnd_id)||
                        '~Effective Date: '     || TO_CHAR(TO_DATE(TO_CHAR(fi.efvdte + 2415021), 'J'), 'DD-MM-YYYY')||
                        '~Statement Number: '   || TO_CHAR(fi.untstm_no) ||
                        '~Increment Type: '     || fi.inrtyp ||
                        '~Increment Ref: '      || fi.inrref ||
                        '~Rights Type: '        || (CASE
                                                       WHEN pcv_product_with_rights_type = 'Y' THEN
                                                          fi.rhttyp
                                                       ELSE 'N/A'
                                                    END) ||
                        '~Unique Reference: '   || TO_CHAR(fi.unq) ||
                        '~Transaction Number: ' || TO_CHAR(fi.trn_no) ||
                        '~ProfitShare Benefits: ' || TO_CHAR(NVL(fi.profitshare_benefits,0)) error_message
                       ,decode(pa.polref, NULL, 'N', 'Y') pa020_exist
                FROM fi700 fi
                JOIN pr310 pr  ON  pr.fndref  = fi.fndref
                               AND pr.maint  != 'D'
                LEFT OUTER JOIN pa020 pa ON  pa.maint    != 'D'
                                         AND pa.polref    = fi.polref
                                         AND pa.fndtrntyp = fi.fndtrntyp
                                         AND pa.sta_pa    = 50
                                         AND pa.efvdte    = fi.efvdte
                                         AND pa.trnctl_no = fi.trnctl_no
                WHERE fi.polref   = pcn_policy_reference
                AND   fi.staevt   = 50
                AND   fi.efvdte   < lpn_system_date
                AND   fi.fndtrntyp  IN  ('ACA','CCA','PSA','UPL')
            )
        WHERE pa020_exist = 'N';

    BEGIN

        pck_process_info.p_set_action('p_no_actioned_UDCTL_triggers');

        FOR i IN cu_fund_movement_details(pn_policy_reference
                                         ,pck_policy_details.f_rights_type_applicable(pn_policy_reference)) LOOP
                 --Raise exception 137
                 p_raise_exception(pn_policy_reference
                                  ,137
                                  ,i.error_message
                                  ,pv_product_type
                                  );
        END LOOP;

    END p_no_actioned_UDCTL_triggers;

    /*******************************************************************************
    -- %Description check if ITR is authorised
    -- %param   pn_polref       IN po100.polref%TYPE
    -- %param   pv_product_type IN po100.prdref%TYPE
    -- %raises  NONE
    *******************************************************************************/
    PROCEDURE p_itr_authorised_check(pn_polref          IN po010.polref%TYPE
                                    ,pv_product_type    IN po010.prdref%TYPE)
    IS
        CURSOR cu_itr(pcn_policy_number IN po010.polref%TYPE)
        IS
        SELECT itr_no
        FROM   co040 co, cl090 cl
        WHERE co.polref =  pcn_policy_number
        AND   co.rolref =  'ITR'
        AND   co.staxrf =  30
        AND   co.clicat =  'ITR'
        AND   co.jtlind =  1
        AND   co.maint != 'D'
        AND   co.strdte <= lpn_system_date
        AND   co.enddte >= lpn_system_date
        AND   cl.itr_no = cliref
        AND   cl.mnt   != 'D'
        AND   cl.enddte    >= lpn_system_date
        AND   cl.efvdte    <= lpn_system_date;

        lv_check_required   VARCHAR2(1);
        lv_check_result     VARCHAR2(1);
        lb_itr_found        BOOLEAN := FALSE;
    BEGIN
        FOR lr_itr IN cu_itr(pn_polref) LOOP

            lb_itr_found := TRUE;

            -- Check for authorisation of ITR
            pck_exits_validation.p_itr_commission_check(pn_itr_no           => lr_itr.itr_no
                                                       ,pv_check_required   => lv_check_required
                                                       ,pv_check_result     => lv_check_result);

            IF lv_check_result = 'R' THEN

                p_raise_exception(pn_polref
                                 ,829
                                 ,'For policy '||pn_polref||' ITR is not authorised: '||lr_itr.itr_no
                                 ,pv_product_type);
            END IF;

        END LOOP;

        IF NOT lb_itr_found THEN

            p_raise_exception(pn_polref
                             ,755
                             ,'For policy '||pn_polref||' ITR not found.'
                             ,pv_product_type);
        END IF;
    END p_itr_authorised_check;

    /*******************************************************************************
    -- %Description check consultant details
    -- %param   pn_polref       IN po100.polref%TYPE
    -- %param   pv_product_type IN po100.prdref%TYPE
    -- %raises  NONE
    *******************************************************************************/
    PROCEDURE p_consultant_check(pn_polref       IN po010.polref%TYPE
                                ,pv_product_type IN po010.prdref%TYPE)
    IS
        CURSOR cu_consultant(pcn_policy_number IN po010.polref%TYPE) IS
            SELECT dftpol_ins.cliref
            FROM   co040 xrf
                  ,co040 schdft
                  ,co040 dftpol_ins
                  ,co040 dftpol_brn
                  ,cl570 loc
                  ,cl011 staff
            WHERE  xrf.polref = pcn_policy_number
            AND    xrf.rolref = 'SCH'
            AND    xrf.maint != 'D'
            AND    xrf.staxrf = 30
            AND    xrf.enddte = 99999
            AND    schdft.clicat = xrf.clicat
            AND    schdft.cliref = xrf.cliref
            AND    schdft.schsubcat = xrf.schsubcat
            AND    schdft.maint != 'D'
            AND    schdft.staxrf = 10
            AND    schdft.enddte = 99999
            AND    dftpol_ins.polref = schdft.polref
            AND    dftpol_ins.rolref = 'INS'
            AND    dftpol_ins.staxrf = 10
            AND    dftpol_ins.clicat = 'STA'
            AND    dftpol_ins.jtlind = 1
            AND    dftpol_ins.maint != 'D'
            AND    dftpol_ins.strdte <= lpn_system_date
            AND    dftpol_ins.enddte >= lpn_system_date
            AND    dftpol_ins.pplunq = (SELECT MAX(pplunq)
                                FROM   co040 dftpol_ins2
                                WHERE  dftpol_ins2.polref = dftpol_ins.polref
                                AND    dftpol_ins2.rolref = 'INS'
                                AND    dftpol_ins2.staxrf = 10
                                AND    dftpol_ins2.clicat = 'STA'
                                AND    dftpol_ins2.jtlind = 1
                                AND    dftpol_ins2.maint != 'D'
                                AND    dftpol_ins2.strdte <= lpn_system_date
                                AND    dftpol_ins2.enddte >= lpn_system_date)
            AND    dftpol_brn.polref = schdft.polref
            AND    dftpol_brn.rolref = 'BRN'
            AND    dftpol_brn.staxrf = 10
            AND    dftpol_brn.clicat = 'LOC'
            AND    dftpol_brn.jtlind = 1
            AND    dftpol_brn.maint != 'D'
            AND    dftpol_brn.strdte <= lpn_system_date
            AND    dftpol_brn.enddte >= lpn_system_date
            AND    dftpol_brn.pplunq = (SELECT MAX(pplunq)
                                FROM   co040 dftpol_brn2
                                WHERE  dftpol_brn2.polref = dftpol_brn.polref
                                AND    dftpol_brn2.rolref = 'BRN'
                                AND    dftpol_brn2.staxrf = 10
                                AND    dftpol_brn2.clicat = 'LOC'
                                AND    dftpol_brn2.jtlind = 1
                                AND    dftpol_brn2.maint != 'D'
                                AND    dftpol_brn2.strdte <= lpn_system_date
                                AND    dftpol_brn2.enddte >= lpn_system_date)
            AND    loc.loc_no = dftpol_brn.cliref
            AND    staff.stf_no = dftpol_ins.cliref
            AND    staff.loccde = loc.loccde
            AND    staff.maint != 'D'
            AND    staff.spsdte = -99999;

        ln_consultant co040.cliref%TYPE;
    BEGIN
            OPEN  cu_consultant(pn_polref);
            FETCH cu_consultant INTO ln_consultant;
            CLOSE cu_consultant;

            IF ln_consultant IS NULL THEN

                p_raise_exception(pn_polref
                                 ,831
                                 ,'For policy ' || pn_polref || ' Consultant not found'
                                 ,pv_product_type);
            END IF;
    END p_consultant_check;

    /*********************************************************************
    -- Procedure p_max_fund_limit_check
    -- Check whether policy is invested in more than 35 funds
    -- %param pn_policy_number   IN po010.polref%TYPE
    -- %param pv_product_type    IN po010.prdref%TYPE
    **********************************************************************/
    PROCEDURE p_max_fund_limit_check (pn_policy_number   IN po010.polref%TYPE
                                     ,pv_product_type    IN po010.prdref%TYPE)
    IS
        ln_fund_holding  PLS_INTEGER;
        lv_error_message VARCHAR2(1000);
    BEGIN
         pck_process_info.p_set_action('p_max_fund_limit_check');

         SELECT COUNT(DISTINCT fndref)
         INTO   ln_fund_holding
         FROM   co058
         WHERE  polref = pn_policy_number
         AND    sta    = 30
         AND    enddte = 99999
         AND    benqty > 0;

         IF ln_fund_holding > 35 THEN
             lv_error_message := 'Policy '||pn_policy_number||' is invested in '||ln_fund_holding||' funds';
             p_raise_exception(pn_policy_number
                              ,141 -- Exception, Policy invested in more than 35 funds
                              ,lv_error_message
                              ,pv_product_type);
         END IF;
    END p_max_fund_limit_check;

    /*===========================================================================================
    Procedure p_ac_cc_policy_discr_check
    Checks if there is a discrepancy between the expected charge amount and the amount paid on
    FI700s
    %param pn_policy_number    IN co040.polref%TYPE
    %param pv_product_type     IN pr010.prdref%TYPE
    %param pn_end_date         IN pa021.rnwdte%TYPE
    ===========================================================================================*/

    PROCEDURE p_ac_cc_policy_discr_check (pn_policy_number IN co040.polref%TYPE
                                         ,pv_product_type  IN pr010.prdref%TYPE
                                         ,pn_end_date      IN pa021.rnwdte%TYPE)
    IS

        CURSOR cu_ac_cc_policy_check (pcn_policy_number co040.polref%TYPE
                                     ,pcn_system_date   cs340.sysdte%TYPE
                                     ,pcd_system_date   cs340.system_dt%TYPE
                                     ,pcd_end_date      cs340.system_dt%TYPE)
        IS
        SELECT * FROM (SELECT DISTINCT y.charge_policy
                                 ,y.charge_method
                                 ,SUM(ROUND(y.sum_charge, 2)) sum_charge
                                 ,NVL(y.paid_amount, 0) paid_amount
                                 ,NVL(y.outstanding_amount, 0) outstanding_amount
                                 ,CASE
                                  WHEN y.charge_subtype != 'ADH' THEN
                                  'Charge ID: '               ||y.charge_id||'~'||
                                  'Charge Type: '             ||y.charge_type||'~'||
                                  'Charge Sub Type: '         ||y.charge_subtype||'~'||
                                  'Charge Method: '           ||y.charge_method||'~'||
                                  'Increment Type: '          ||y.increment_type||'~'||
                                  'Increment Ref: '           ||y.increment_reference||'~'||
                                  'Expected Total Charge Amount: '|| SUM(ROUND(y.sum_charge, 2))||'~'||
                                  'Fund Movements Paid Amount: '  || NVL(y.paid_amount, 0)||'~'||
                                  'Charges Outstanding Amount: '  || NVL(y.outstanding_amount, 0)
                                  ELSE
                                  'Charge ID: '               ||y.charge_id||'~'||
                                  'Charge Type: '             ||y.charge_type||'~'||
                                  'Charge Sub Type: '         ||y.charge_subtype||'~'||
                                  'Charge Method: '           ||y.charge_method||'~'||
                                  'Expected Total Charge Amount: '|| SUM(ROUND(y.sum_charge, 2))||'~'||
                                  'Fund Movements Paid Amount: '  || NVL(y.paid_amount, 0)||'~'||
                                  'Charges Outstanding Amount: '  || NVL(y.outstanding_amount, 0)
                                  END error_message
                                  FROM
            (SELECT charge_policy
                   ,charge_id
                   ,increment_type
                   ,increment_reference
                   ,charge_type
                   ,charge_subtype
                   ,charge_method
                   ,paid_amount
                   ,outstanding_amount
                   ,total_premium
                   ,premium
                   ,SUM(charge_total) sum_charge
            FROM
            (
            SELECT     cd.polref                charge_policy
                      ,cd.charge_id             charge_id
                      ,cd.charge_type           charge_type
                      ,cd.charge_subtype        charge_subtype
                      ,cd.charge_method         charge_method
                      ,cd.trnctl_no             trnctl_no
                      ,cid.start_date           start_date
                      ,cid.end_date             end_date
                      ,cd.duration              duration
                      ,cd.frequency             frequency
                      ,cid.charge_increment_dates_id charge_increment_dates_id
                      ,cid.increment_type       increment_type
                      ,cid.increment_reference  increment_reference
                      ,cid.charge_amount        charge_amount
                      ,cid.charge_percentage    charge_percentage
                      ,cd.status                charge_status
                      ,cid.status               charge_increment_status
                      ,frq.occpyr               occpyr
                      ,0                        total_premium
                      ,0                        premium
                      ,0                        date1
                      ,CASE
                       WHEN cd.charge_method   = 'FIX' AND
                            cd.charge_subtype != 'ADH' THEN
                           CASE
                           WHEN NVL(cid.end_date,TO_DATE('31-Dec-2999', 'DD-Mon-YYYY')) >= pcd_end_date THEN

                             SUM(cid.charge_amount *
                              TRUNC((TRUNC(MONTHS_BETWEEN(pcd_end_date,pck_dates.f_subtract_frequency
                                                                         (cid.start_date
                                                                         ,CASE
                                                                          cd.frequency
                                                                          WHEN 'S' THEN 'M'
                                                                          ELSE
                                                                          cd.frequency
                                                                          END))) / (12 / CASE frq.occpyr
                                                                                         WHEN 0 THEN 12
                                                                                         ELSE frq.occpyr
                                                                                         END))))
                             OVER (PARTITION BY cd.polref, cd.charge_id, cid.start_date)
                           WHEN cid.end_date < pcd_end_date  THEN
                             SUM(cid.charge_amount *
                              TRUNC((TRUNC(MONTHS_BETWEEN(cid.end_date,pck_dates.f_subtract_frequency
                                                                     (cid.start_date
                                                                     ,CASE
                                                                      cd.frequency
                                                                      WHEN 'S' THEN 'M'
                                                                      ELSE
                                                                      cd.frequency
                                                                      END))) / (12 / CASE frq.occpyr
                                                                                     WHEN 0 THEN 12
                                                                                     ELSE frq.occpyr
                                                                                     END))))
                             OVER (PARTITION BY cd.polref, cd.charge_id, cid.start_date)
                           END
                       WHEN cd.charge_method = 'ASA' THEN
                       cid.charge_amount
                       WHEN cd.charge_method   = 'FIX' AND
                            cd.charge_subtype  = 'ADH' THEN
                            SUM(cid.increment_amount) OVER (PARTITION BY cd.polref, cd.charge_id, cid.start_date)
                       ELSE 0
                       END charge_total
                      ,(SELECT SUM(NVL(co.outstanding_amount, 0))
                        FROM  charges_outstanding co
                        WHERE co.charge_id = cd.charge_id
                        AND   co.status = 30) outstanding_amount
                      ,(SELECT SUM(fi2.amt)
                        FROM  fi700 fi2
                        WHERE fi2.polref  = cd.polref
                        AND fi2.trnctl_no = cd.trnctl_no
                        AND fi2.fndtrntyp NOT IN ('LB', 'IB', 'TB')
                        AND fi2.staevt    IN (50, 65)
                        AND fi2.efvdte   <= pcn_system_date) paid_amount
                FROM charge_details cd
                JOIN charge_increment_dates cid ON  cd.charge_id = cid.charge_id
                                                AND cid.status  IN (30, 50)
                                                AND cid.start_date <= pcd_system_date
                                                AND NVL(cid.end_date, pcd_system_date) >= cid.start_date
                JOIN pa020 pa ON pa.polref = cd.polref
                             AND pa.trnctl_no = cd.trnctl_no
                             AND pa.sta_pa IN (30, 50)
                             AND pa.strdte < pcn_system_date
                JOIN ge070 frq ON frq.frq    = cd.frequency
                              AND frq.maint != 'D'
                WHERE cd.polref = pcn_policy_number
                AND   cd.status IN (30, 50)
                AND   cd.charge_method IN ('ASA', 'FIX')
                AND  (cd.charge_subtype != 'ONG' OR
                      cd.charge_Subtype = 'ONG' AND cid.increment_type NOT IN ('SP', 'TV'))
                AND   NOT EXISTS (SELECT 1
                                  FROM pa020 pa
                                  WHERE pa.polref = cd.polref
                                  AND   pa.trnctl_no = cd.trnctl_no
                                  AND   pa.sta_pa = 5)
                AND   EXISTS (SELECT 1
                              FROM event ev
                              WHERE ev.polref  = cd.polref
                              AND   ev.inrtyp  = cid.increment_type
                              AND   ev.inrref >= cid.increment_reference
                              AND   ev.staevt  = 55)
                AND NOT EXISTS (SELECT 1
                                FROM fi700 fi
                                WHERE cid.increment_type IN ('ORD', 'AVCO', 'RVP', 'AVCR')
                                AND   cd.charge_method = 'FIX'
                                AND   fi.polref = cd.polref
                                AND   fi.fndtrntyp = 'RP'
                                AND   fi.inrtyp = cid.increment_type
                                AND   fi.inrref = cid.increment_reference
                                AND   fi.staevt = 30
                                AND   fi.efvdte >= pcn_system_date
                                AND   NOT EXISTS (SELECT 1
                                                  FROM fi700 fi2
                                                  WHERE fi2.polref = cd.polref
                                                  AND   fi2.staevt = 50
                                                  AND   fi2.trnctl_no = cd.trnctl_no))
                UNION ALL
                SELECT DISTINCT cd.polref               charge_policy
                              ,cd.charge_id             charge_id
                              ,cd.charge_type           charge_type
                              ,cd.charge_subtype        charge_subtype
                              ,cd.charge_method         charge_method
                              ,cd.trnctl_no             trnctl_no
                              ,cid.start_date           start_date
                              ,cid.end_date             end_date
                              ,cd.duration              duration
                              ,cd.frequency             frequency
                              ,cid.charge_increment_dates_id charge_increment_dates_id
                              ,cid.increment_type       increment_type
                              ,cid.increment_reference  increment_reference
                              ,cid.charge_amount        charge_amount
                              ,cid.charge_percentage    charge_percentage
                              ,cd.status                charge_status
                              ,cid.status               charge_increment_status
                              ,frq.occpyr               occpyr
                              ,0                        total_premium
                              ,0                        premium
                              ,w.dte1                   date1
                              ,ROUND(cid.charge_percentage * SUM(CASE
                                                                 WHEN NVL(cip.increment_proportion, 0) > 0
                                                                 THEN ((w.trnamt2 * cip.increment_proportion) / 100)
                                                                 WHEN cip.increment_proportion = 0
                                                                 THEN 0
                                                                 ELSE w.trnamt2 * 1
                                                                 END)
                                  OVER (PARTITION BY cd.polref, cd.charge_id, w.event_dte1) / 100, 2) charge_total
                              ,(SELECT SUM(NVL(co.outstanding_amount, 0))
                               FROM  charges_outstanding co
                               WHERE co.charge_id = cd.charge_id
                               AND   co.status = 30) outstanding_amount
                              ,(SELECT SUM(fi2.amt)
                                FROM  fi700 fi2
                                WHERE fi2.polref  = cd.polref
                                AND fi2.trnctl_no = cd.trnctl_no
                                AND fi2.staevt    IN (50, 65)
                                AND fi2.fndtrntyp NOT IN ('LB', 'IB', 'TB')
                                AND fi2.efvdte   <= pcn_system_date) paid_amount
                FROM charge_details cd
                JOIN charge_increment_dates cid ON  cd.charge_id = cid.charge_id
                                                AND cid.status  IN (30, 50)
                                                AND cid.start_date <= pcd_system_date
                                                AND NVL(cid.end_date, pcd_system_date) >= cid.start_date
                JOIN pa020 pa ON pa.polref = cd.polref
                             AND pa.trnctl_no = cd.trnctl_no
                             AND pa.sta_pa IN (30, 50)
                             AND pa.strdte < pcn_system_date
                JOIN ge070 frq ON  frq.frq    = cd.frequency
                               AND frq.maint != 'D'
                JOIN (SELECT   ev.polref  event_polref
                              ,ev.inrtyp  event_inrtyp
                              ,ev.inrref  event_inrref
                              ,ev.trnamt1
                              ,ev.trnamt2
                              ,ev.dte1
                              ,pck_utility.f_dtcnv(ev.dte1) event_dte1
                              ,pck_utility.f_dtcnv(ev.dte2) event_dte2
                              ,ev.trnprmgrp
                        FROM event ev
                        WHERE ev.polref = pcn_policy_number
                        AND   ev.staevt = 55
                        AND   ev.inrtyp IN ('RVP', 'AVCR')) w
                ON  w.event_polref = cd.polref
                AND w.event_inrtyp = cid.increment_type
                AND w.event_dte1 BETWEEN cid.start_date
                                 AND NVL(cid.end_date, pcd_system_date)
                LEFT OUTER JOIN charge_inc_proportions cip
                             ON cip.polref              = w.event_polref
                            AND cip.increment_type      = w.event_inrtyp
                            AND cip.increment_reference = cid.increment_reference
                            AND cip.status              = 30
                            AND cip.start_date         <= w.event_dte1
                            AND cip.end_date           >= w.event_dte1
                WHERE cd.polref = pcn_policy_number
                AND   cd.status IN (30, 50)
                AND   cd.charge_method = 'CON'
                AND   cid.increment_type IN ('RVP', 'AVCR')
                AND   NOT EXISTS (SELECT 1
                                  FROM pa020 pa
                                  WHERE pa.polref = cd.polref
                                  AND   pa.trnctl_no = cd.trnctl_no
                                  AND   pa.sta_pa = 5)
                AND   EXISTS (SELECT 1
                              FROM event ev
                              WHERE ev.polref  = cd.polref
                              AND   ev.inrtyp  = cid.increment_type
                              AND   ev.inrref >= cid.increment_reference
                              AND   ev.staevt  = 55)
                UNION ALL
                SELECT cd.polref                charge_policy
                      ,cd.charge_id             charge_id
                      ,cd.charge_type           charge_type
                      ,cd.charge_subtype        charge_subtype
                      ,cd.charge_method         charge_method
                      ,cd.trnctl_no             trnctl_no
                      ,cid.start_date           start_date
                      ,cid.end_date             end_date
                      ,cd.duration              duration
                      ,cd.frequency             frequency
                      ,cid.charge_increment_dates_id charge_increment_dates_id
                      ,cid.increment_type       increment_type
                      ,cid.increment_reference  increment_reference
                      ,cid.charge_amount        charge_amount
                      ,cid.charge_percentage    charge_percentage
                      ,cd.status                charge_status
                      ,cid.status               charge_increment_status
                      ,frq.occpyr               occpyr
                      ,0                        total_premium
                      ,0                        premium
                      ,0                        date1
                      ,(SELECT SUM(fi.amt)
                        FROM  fi700 fi
                        WHERE fi.polref = cd.polref
                        AND   fi.fndtrntyp = 'RP'
                        AND   fi.inrtyp = cid.increment_type
                        AND   fi.inrref = cid.increment_reference
                        AND   fi.staevt = 50
                        AND   TO_DATE(TO_CHAR(fi.duedte + 2415021),'J') >= cid.start_date
                        AND   TO_DATE(TO_CHAR(fi.duedte + 2415021),'J') <=
                                       NVL(cid.end_date,TO_DATE('31-Dec-2999', 'DD-Mon-YYYY')))
                        * cid.charge_percentage / 100  charge_total
                      ,(SELECT SUM(NVL(co.outstanding_amount, 0))
                        FROM  charges_outstanding co
                        WHERE co.charge_id = cd.charge_id
                        AND   co.status = 30) outstanding_amount
                      ,(SELECT SUM(fi2.amt)
                        FROM  fi700 fi2
                        WHERE fi2.polref  = cd.polref
                        AND fi2.trnctl_no = cd.trnctl_no
                        AND fi2.staevt    IN (50, 65)
                        AND fi2.fndtrntyp NOT IN ('LB', 'IB', 'TB')
                        AND fi2.efvdte   <= pcn_system_date) paid_amount
                FROM charge_details cd
                JOIN charge_increment_dates cid ON  cd.charge_id = cid.charge_id
                                                AND cid.status  IN (30, 50)
                                                AND cid.start_date <= pcd_system_date
                                                AND NVL(cid.end_date, pcd_system_date) >= cid.start_date
                JOIN pa020 pa ON pa.polref = cd.polref
                             AND pa.trnctl_no = cd.trnctl_no
                             AND pa.sta_pa IN (30, 50)
                             AND pa.strdte < pcn_system_date
                JOIN ge070 frq ON  frq.frq    = cd.frequency
                               AND frq.maint != 'D'
                WHERE cd.polref = pcn_policy_number
                AND   cd.status IN (30, 50)
                AND   cd.charge_method IN ('CON')
                AND   cid.increment_type IN ('ORD', 'AVCO')
                AND   NOT EXISTS (SELECT 1
                                  FROM pa020 pa
                                  WHERE pa.polref = cd.polref
                                  AND   pa.trnctl_no = cd.trnctl_no
                                  AND   pa.sta_pa = 5)
                AND   EXISTS (SELECT 1
                              FROM event ev
                              WHERE ev.polref  = cd.polref
                              AND   ev.inrtyp  = cid.increment_type
                              AND   ev.inrref >= cid.increment_reference
                              AND   ev.staevt  = 55)
                UNION ALL
                SELECT cd.polref                charge_policy
                      ,cd.charge_id             charge_id
                      ,cd.charge_type           charge_type
                      ,cd.charge_subtype        charge_subtype
                      ,cd.charge_method         charge_method
                      ,cd.trnctl_no             trnctl_no
                      ,cid.start_date           start_date
                      ,cid.end_date             end_date
                      ,cd.duration              duration
                      ,cd.frequency             frequency
                      ,cid.charge_increment_dates_id charge_increment_dates_id
                      ,cid.increment_type       increment_type
                      ,cid.increment_reference  increment_reference
                      ,cid.charge_amount        charge_amount
                      ,cid.charge_percentage    charge_percentage
                      ,cd.status                charge_status
                      ,cid.status               charge_increment_status
                      ,frq.occpyr               occpyr
                      ,z.total_premium          total_premium
                      ,z.premium                premium
                      ,0                        date1
                      ,CASE
                         WHEN NVL(cid.end_date,TO_DATE('31-Dec-2999', 'DD-Mon-YYYY')) >= pcd_end_date THEN
                         SUM((ROUND(cid.charge_percentage * z.premium) / 100) *
                           TRUNC((TRUNC(MONTHS_BETWEEN(pcd_end_date,pck_dates.f_subtract_frequency
                                                                     (cid.start_date
                                                                     ,CASE
                                                                      cd.frequency
                                                                      WHEN 'S' THEN 'M'
                                                                      ELSE
                                                                      cd.frequency
                                                                      END)) / (12 / CASE frq.occpyr
                                                                                    WHEN 0 THEN 12
                                                                                    ELSE frq.occpyr
                                                                                    END)))))
                             OVER (PARTITION BY cd.polref, cd.charge_id, cid.start_date)
                         WHEN cid.end_date < pcd_end_date THEN
                         SUM((ROUND(cid.charge_percentage * z.premium) / 100) *
                           TRUNC((TRUNC(MONTHS_BETWEEN(cid.end_date,pck_dates.f_subtract_frequency
                                                                  (cid.start_date
                                                                  ,CASE
                                                                   cd.frequency
                                                                   WHEN 'S' THEN 'M'
                                                                   ELSE
                                                                   cd.frequency
                                                                   END)) / (12 / CASE frq.occpyr
                                                                                 WHEN 0 THEN 12
                                                                                 ELSE frq.occpyr
                                                                                 END)))))
                             OVER (PARTITION BY cd.polref, cd.charge_id, cid.start_date)
                       END charge_total
                      ,(SELECT SUM(NVL(co.outstanding_amount, 0))
                        FROM  charges_outstanding co
                        WHERE co.charge_id = cd.charge_id
                        AND   co.status = 30) outstanding_amount
                      ,(SELECT SUM(fi2.amt)
                        FROM  fi700 fi2
                        WHERE fi2.polref  = cd.polref
                        AND fi2.trnctl_no = cd.trnctl_no
                        AND fi2.fndtrntyp NOT IN ('LB', 'IB', 'TB')
                        AND fi2.staevt    IN (50, 65))
                FROM charge_details cd
                JOIN charge_increment_dates cid ON cd.charge_id = cid.charge_id
                                               AND cid.status  IN (30, 50)
                                               AND cid.start_date <= pcd_system_date
                                               AND NVL(cid.end_date, pcd_system_date) >= cid.start_date
                JOIN pa020 pa ON pa.polref = cd.polref
                             AND pa.trnctl_no = cd.trnctl_no
                             AND pa.sta_pa IN (30, 50)
                             AND pa.strdte < pcn_system_date
                JOIN ge070 frq ON  frq.frq    = cd.frequency
                               AND frq.maint != 'D'
                JOIN (SELECT DISTINCT y.polref        premium_policy
                                     ,y.inrtyp        inrtyp
                                     ,y.inrref        inrref
                                     ,y.crcdte        crcdte
                                     ,y.total_premium total_premium
                                     ,y.prm_frq       prm_frq
                                     ,y.frqocc        frqocc
                                     ,y.premium       premium
                                     ,CASE
                                      WHEN y.r = 1 AND y.inrtyp NOT IN ('SP','TV','DSS')
                                      THEN y.premium
                                      WHEN y.r != 1 AND y.inrtyp NOT IN ('SP','TV','DSS')
                                      THEN SUM(y.premium) over (ORDER BY y.polref, y.inrtyp ROWS y.r-1 PRECEDING)
                                      END CURRENT_PREMIUM
                FROM
                       (SELECT DISTINCT inc.polref
                          ,inc.inrtyp
                          ,inc.inrref
                          ,rhttyp
                          ,crcdte
                          ,staben
                          ,tot_prm AS total_premium
                          ,prm_frq
                          ,frqocc
                          ,CASE
                           WHEN inc.inrtyp IN ('SP', 'TV', 'DSS')
                           THEN tot_prm
                           ELSE tot_prm / frqocc
                           END AS premium
                          ,CASE
                           WHEN inc.inrtyp IN ('SP', 'TV', 'DSS')
                           THEN ee_cont
                           ELSE ee_cont / frqocc
                           END AS ee_cont
                          ,CASE
                           WHEN inc.inrtyp IN ('SP', 'TV', 'DSS')
                           THEN er_cont
                           ELSE er_cont / frqocc
                           END AS er_cont
                          ,ROW_number() OVER (PARTITION BY inc.polref, inc.inrtyp ORDER BY inc.polref) r
                    FROM po020 inc
                    JOIN po020 inc_b ON inc_b.polref = inc.polref AND inc_b.inrtyp = inc.inrtyp AND inc_b.inrref = 1
                    JOIN (SELECT DISTINCT polref
                                ,inrtyp
                                ,inrref
                                ,rhttyp
                                ,crcdte
                                ,staben
                                ,ee_cont
                                ,er_cont
                                ,tot_prm
                                ,prm_frq
                                ,frqocc
                          FROM (SELECT polref
                                      ,inrtyp
                                      ,inrref
                                      ,rhttyp
                                      ,pck_utility.f_dtcnv(crcdte) crcdte
                                      ,staben
                                      ,othctbprm + othctbadm + othctbocc er_cont
                                      ,occxtr + prmamt + admcrg - (othctbprm + othctbadm + othctbocc) ee_cont
                                      ,totprm AS tot_prm
                                      ,prmfrq AS prm_frq
                                      ,occpyr AS frqocc
                                FROM po030
                                JOIN ge070  ON frq = prmfrq  AND ge070.maint != 'D'
                                WHERE po030.maint  != 'D'
                                AND   bentyp NOT IN ('WVR','TA','PLANA','GLA','LTD','STD','GIP','STU','STDU')
                                AND   altcde NOT IN (50,51,52)
                                AND   crcdte NOT IN (0,99999,-99999)
                                UNION
                                SELECT polref
                                      ,inrtyp
                                      ,inrref
                                      ,rhttyp
                                      ,pck_utility.f_dtcnv(crcdte) crcdte
                                      ,staben
                                      ,othctbprm + othctbadm + othctbocc er_cont
                                      ,sgnoccxtr + sgnprmamt + admcrg - (othctbprm + othctbadm + othctbocc) ee_cont
                                      ,totprm tot_prm
                                      ,prmfrq prm_frq
                                      ,occpyr AS frqocc
                                FROM hi030
                                JOIN ge070
                                ON frq = prmfrq
                                AND ge070.maint != 'D'
                                WHERE hi030.maint  != 'D'
                                AND   bentyp NOT IN ('WVR','TA','PLANA','GLA','LTD','STD','GIP','STU','STDU')
                                AND   altcde NOT IN (50,51,52)
                                AND   crcdte NOT IN (0,99999,-99999))) benefit
                    ON  inc.polref = benefit.polref
                    AND inc.inrtyp = benefit.inrtyp
                    AND inc.inrref = benefit.inrref
                    WHERE inc.polref = pcn_policy_number
                    AND   inc.stainr   = 30
                    AND ((benefit.staben = 30 AND benefit.inrref = 0)
                        OR (benefit.staben = 30 AND benefit.inrtyp IN ('SP', 'TV', 'DSS') AND benefit.tot_prm > 0)
                        OR (benefit.staben = 29 AND benefit.Inrref = inc.Inrref))
                    AND   inc.maint   != 'D'
                    AND   inc_b.stainr = 30
                    AND   benefit.crcdte <= pcd_system_date
                    ORDER BY INC.POLREF, INC.INRTYP, inc.inrref ) y
                ORDER BY y.polref, y.inrtyp, y.inrref) z
                ON  z.premium_policy = cd.polref
                AND z.inrtyp         = cid.increment_type
                AND z.inrref         = cid.increment_reference
                WHERE cd.polref = pcn_policy_number
                AND   cd.status IN (30, 50)
                AND   cd.charge_method = 'CON'
                AND   cid.increment_type IN ('SP','TV','AVCS')
                AND   NOT EXISTS (SELECT 1
                                  FROM pa020 pa
                                  WHERE pa.polref = cd.polref
                                  AND   pa.trnctl_no = cd.trnctl_no
                                  AND   pa.sta_pa = 5)
                AND   EXISTS (SELECT 1
                              FROM event ev
                              WHERE ev.polref = cd.polref
                              AND   ev.inrtyp = cid.increment_type
                              AND   ev.inrref = cid.increment_reference
                              AND   ev.staevt = 55)) x
                GROUP BY x.charge_policy
                        ,x.charge_id
                        ,x.increment_type
                        ,x.increment_reference
                        ,x.charge_type
                        ,x.charge_subtype
                        ,x.charge_method
                        ,x.paid_amount
                        ,x.outstanding_amount
                        ,x.total_premium
                        ,x.premium
            ) y
            GROUP BY y.charge_policy
                    ,y.charge_id
                    ,y.increment_type
                    ,y.increment_reference
                    ,y.charge_type
                    ,y.charge_subtype
                    ,y.charge_method
                    ,y.paid_amount
                    ,y.outstanding_amount) z
           WHERE z.charge_method IN ('ASA', 'FIX','CON') AND
                 --99p tolerance check as per business requirements - added as a CS060 record
                 (ABS(z.sum_charge - ((NVL(z.paid_amount, 0) * -1) + NVL(z.outstanding_amount,0)))
                                                               > (SELECT TO_NUMBER(datiteval) / 100
                                                                  FROM cs060 CS
                                                                  WHERE cs.Ispgrpnam = 'HCHCK'
                                                                  AND   cs.datitenam = 'TOLERANCE'
                                                                  AND   cs.itevalnam = 'ACCC TOL'));

         ld_end_date DATE;

    BEGIN
         pck_process_info.p_set_action('p_ac_cc_policy_discr_check');

         -- Convert period end date to be used in cursor
         ld_end_date := TO_DATE('01/01/1900', 'DD/MM/YYYY') + pn_end_date;

         FOR lr_ac_cc_policy_check IN cu_ac_cc_policy_check(pn_policy_number
                                                           ,lpn_system_date
                                                           ,lpd_system_date
                                                           ,ld_end_date) LOOP
           -- Raise exception 147
           p_raise_exception(pn_policy_number
                            ,147
                            ,lr_ac_cc_policy_check.error_message
                            ,pv_product_type
                            );

         END LOOP;

    END p_ac_cc_policy_discr_check;

    /*===========================================================================================
    Procedure p_sus_ac_trigger_check
    Checks if there are any Suspended AC UDCTL triggers
    %param pn_policy_number    IN co040.polref%TYPE
    %param pv_product_type     IN pr010.prdref%TYPE
    ===========================================================================================*/

    PROCEDURE p_sus_ac_trigger_check(pn_policy_number IN co040.polref%TYPE
                                    ,pv_product_type  IN pr010.prdref%TYPE)

    IS

        CURSOR cu_sus_ac_triggers(pcn_policy_number co040.polref%TYPE)
        IS
        SELECT 'AC Effective Date: '            ||TO_DATE(TO_CHAR(pa.efvdte + 2415021),'J')||'~'||
               'AC Transaction Type: '          ||pa.fndtrntyp||'~'||
               'AC UDCTL status: '              ||'Suspended' ||'~'||
               'AC Increment Type: '            ||pa.inrtyp||'~'||
               'AC Increment Ref: '             ||pa.inrref||'~'||
               'AC Start Date: '                ||TO_DATE(TO_CHAR(pa.strdte + 2415021),'J')||'~'||
               'AC End Date: '                  ||TO_DATE(TO_CHAR(pa.enddte + 2415021),'J')||'~'||
               'AC transaction control number: '||pa.trnctl_no error_message
        FROM    pa020 pa
        WHERE   pa.polref = pcn_policy_number
        AND     pa.fndtrntyp IN ('ACI','ACO','ACV','ACA')
        AND     pa.maint != 'D'
        AND     pa.sta_pa = 47;

    BEGIN

        pck_process_info.p_set_action('p_sus_ac_trigger_check');

        FOR lr_sus_ac_triggers IN cu_sus_ac_triggers(pn_policy_number) LOOP

           -- Raise exception 149
           p_raise_exception(pn_policy_number
                            ,149
                            ,lr_sus_ac_triggers.error_message
                            ,pv_product_type
                            );

        END LOOP;

    END p_sus_ac_trigger_check;

    /*===========================================================================================
    Procedure p_sus_cc_trigger_check
    Checks if there are any Suspended CC UDCTL triggers
    %param pn_policy_number    IN co040.polref%TYPE
    %param pv_product_type     IN pr010.prdref%TYPE
    ===========================================================================================*/

    PROCEDURE p_sus_cc_trigger_check(pn_policy_number IN co040.polref%TYPE
                                    ,pv_product_type  IN pr010.prdref%TYPE)

    IS

        CURSOR cu_sus_cc_triggers(pcn_policy_number co040.polref%TYPE)
        IS
        SELECT 'CC Effective Date: '            ||TO_DATE(TO_CHAR(pa.efvdte + 2415021),'J')||'~'||
               'CC Transaction Type: '          ||pa.fndtrntyp||'~'||
               'CC UDCTL status: '              ||'Suspended' ||'~'||
               'CC Increment Type: '            ||pa.inrtyp||'~'||
               'CC Increment Ref: '             ||pa.inrref||'~'||
               'CC Start Date: '                ||TO_DATE(TO_CHAR(pa.strdte + 2415021),'J')||'~'||
               'CC End Date: '                  ||TO_DATE(TO_CHAR(pa.enddte + 2415021),'J')||'~'||
               'CC transaction control number: '||pa.trnctl_no error_message
        FROM    pa020 pa
        WHERE   pa.polref = pcn_policy_number
        AND     pa.fndtrntyp IN ('CCI','CCO','CCV','CCA')
        AND     pa.maint != 'D'
        AND     pa.sta_pa = 47;

    BEGIN

        pck_process_info.p_set_action('p_sus_cc_trigger_check');

        FOR lr_sus_cc_triggers IN cu_sus_cc_triggers(pn_policy_number) LOOP

           -- Raise exception 150
           p_raise_exception(pn_policy_number
                            ,150
                            ,lr_sus_cc_triggers.error_message
                            ,pv_product_type
                            );

        END LOOP;

    END p_sus_cc_trigger_check;

    /*===========================================================================================
    Procedure p_ac_trigger_check
    Checks if there are any AC UDCTL triggers that are not status ACT
    %param pn_policy_number    IN co040.polref%TYPE
    %param pn_end_date         IN pa021.rnwdte%TYPE
    %param pv_product_type     IN pr010.prdref%TYPE
    ===========================================================================================*/

    PROCEDURE p_ac_trigger_check(pn_policy_number IN co040.polref%TYPE
                                ,pn_end_date      IN pa021.rnwdte%TYPE
                                ,pv_product_type  IN pr010.prdref%TYPE)
    IS

        CURSOR cu_ac_triggers(pcn_policy_number co040.polref%TYPE
                             ,pcn_end_date      pa021.rnwdte%TYPE
                             ,pcn_system_date   cs340.sysdte%TYPE)
        IS
        SELECT 'AC Effective Date: '            ||TO_DATE(TO_CHAR(pa.efvdte + 2415021),'J')||'~'||
               'AC Transaction Type: '          ||pa.fndtrntyp||'~'||
               'AC UDCTL status: '              ||NVL(cs.itevalnam,'*NO')||'~'||
               'AC Increment Type: '            ||pa.inrtyp||'~'||
               'AC Increment Ref: '             ||pa.inrref||'~'||
               'AC Start Date: '                ||TO_DATE(TO_CHAR(pa.strdte + 2415021),'J')||'~'||
               'AC End Date: '                  ||TO_DATE(TO_CHAR(pa.enddte + 2415021),'J')||'~'||
               'AC transaction control number: '||pa.trnctl_no error_message
        FROM   pa020 pa
        JOIN   charge_details cd ON cd.polref = pa.polref
                                AND cd.trnctl_no = pa.trnctl_no
        JOIN   charge_increment_dates cid ON cd.charge_id = cid.charge_id
        LEFT OUTER JOIN po020 po ON po.polref = pa.polref
                                AND po.inrtyp = pa.inrtyp
                                AND po.inrref = pa.inrref
                                AND po.stainr = 30
                                AND po.maint != 'D'
        LEFT OUTER JOIN cs060 CS ON cs.ispgrpnam = 'PA020'
                                AND cs.datitenam = 'STA'
                                AND cs.maint    != 'D'
                                AND cs.datiteval = pa.sta_pa
        WHERE   pa.polref = pcn_policy_number
        AND     pa.fndtrntyp IN ('ACI','ACO','ACV','ACA')
        AND     pa.maint != 'D'
        AND   ((pa.frq     = 'S' AND
                pa.strdte  = pa.enddte    AND
                pa.sta_pa  = 30           AND
                pa.efvdte  < pcn_end_date)
           OR  (pa.frq    !='S'           AND
                pa.strdte != pa.enddte    AND
                pa.sta_pa  = 30           AND
                pa.efvdte  < pcn_end_date))
        AND NOT EXISTS (SELECT 1
                        FROM  fi700 fi
                        WHERE cid.increment_type IN ('ORD', 'AVCO', 'RVP', 'AVCR')
                        AND   cd.charge_method IN ('FIX', 'FND', 'CON')
                        AND   fi.polref = cd.polref
                        AND   fi.fndtrntyp = 'RP'
                        AND   fi.inrtyp = cid.increment_type
                        AND   fi.inrref = cid.increment_reference
                        AND   fi.staevt = 30
                        AND   fi.efvdte >= pcn_system_date
                        AND   NOT EXISTS (SELECT 1
                                          FROM fi700 fi2
                                          WHERE fi2.polref = pa.polref
                                          AND   fi2.staevt = 50
                                          AND   fi2.trnctl_no = pa.trnctl_no));

    BEGIN

        pck_process_info.p_set_action('p_ac_trigger_check');

        FOR lr_ac_triggers IN cu_ac_triggers(pn_policy_number
                                            ,pn_end_date
                                            ,lpn_system_date) LOOP

           -- Raise exception 151
           p_raise_exception(pn_policy_number
                            ,151
                            ,lr_ac_triggers.error_message
                            ,pv_product_type
                            );

        END LOOP;

    END p_ac_trigger_check;

    /*===========================================================================================
    Procedure p_cc_trigger_check
    Checks if there are any CC UDCTL triggers that are not status ACT
    %param pn_policy_number    IN co040.polref%TYPE
    %param pn_end_date         IN pa021.rnwdte%TYPE
    %param pv_product_type     IN pr010.prdref%TYPE
    ===========================================================================================*/

    PROCEDURE p_cc_trigger_check(pn_policy_number IN co040.polref%TYPE
                                ,pn_end_date      IN pa021.rnwdte%TYPE
                                ,pv_product_type  IN pr010.prdref%TYPE)
    IS

        CURSOR cu_cc_triggers(pcn_policy_number co040.polref%TYPE
                             ,pcn_end_date      pa021.rnwdte%TYPE
                             ,pcn_system_date   cs340.sysdte%TYPE)
        IS
        SELECT 'CC Effective Date: '            ||TO_DATE(TO_CHAR(pa.efvdte + 2415021),'J')||'~'||
               'CC Transaction Type: '          ||pa.fndtrntyp||'~'||
               'CC UDCTL status: '              ||NVL(cs.itevalnam,'*NO')||'~'||
               'CC Increment Type: '            ||pa.inrtyp||'~'||
               'CC Increment Ref: '             ||pa.inrref||'~'||
               'CC Start Date: '                ||TO_DATE(TO_CHAR(pa.strdte + 2415021),'J')||'~'||
               'CC End Date: '                  ||TO_DATE(TO_CHAR(pa.enddte + 2415021),'J')||'~'||
               'CC transaction control number: '||pa.trnctl_no error_message
        FROM   pa020 pa
        JOIN   charge_details cd ON cd.polref = pa.polref
                                AND cd.trnctl_no = pa.trnctl_no
        JOIN   charge_increment_dates cid ON cd.charge_id = cid.charge_id
        LEFT OUTER JOIN po020 po ON po.polref = pa.polref
                                AND po.inrtyp = pa.inrtyp
                                AND po.inrref = pa.inrref
                                AND po.stainr = 30
                                AND po.maint != 'D'
        LEFT OUTER JOIN cs060 CS ON cs.ispgrpnam = 'PA020'
                                AND cs.datitenam = 'STA'
                                AND cs.maint    != 'D'
                                AND cs.datiteval = pa.sta_pa
        WHERE   pa.polref = pcn_policy_number
        AND     pa.fndtrntyp IN ('CCI','CCO','CCV','CCA')
        AND     pa.maint != 'D'
        AND   ((pa.frq     = 'S' AND
                pa.strdte  = pa.enddte    AND
                pa.sta_pa  = 30           AND
                pa.efvdte  < pcn_end_date)
           OR  (pa.frq    !='S'           AND
                pa.strdte != pa.enddte    AND
                pa.sta_pa  = 30           AND
                pa.efvdte  < pcn_end_date))
        AND NOT EXISTS (SELECT 1
                        FROM  fi700 fi
                        WHERE cid.increment_type IN ('ORD', 'AVCO', 'RVP', 'AVCR')
                        AND   cd.charge_method IN ('FIX', 'FND', 'CON')
                        AND   fi.polref = cd.polref
                        AND   fi.fndtrntyp = 'RP'
                        AND   fi.inrtyp = cid.increment_type
                        AND   fi.inrref = cid.increment_reference
                        AND   fi.staevt = 30
                        AND   fi.efvdte >= pcn_system_date
                        AND   NOT EXISTS (SELECT 1
                                          FROM fi700 fi2
                                          WHERE fi2.polref = pa.polref
                                          AND   fi2.staevt = 50
                                          AND   fi2.trnctl_no = pa.trnctl_no));

    BEGIN

        pck_process_info.p_set_action('p_cc_trigger_check');

        FOR lr_cc_triggers IN cu_cc_triggers(pn_policy_number
                                            ,pn_end_date
                                            ,lpn_system_date) LOOP

           --Raise exception 152
           p_raise_exception(pn_policy_number
                            ,152
                            ,lr_cc_triggers.error_message
                            ,pv_product_type
                            );
        END LOOP;

    END p_cc_trigger_check;

    /*===========================================================================================
    Procedure p_drf_crg_paid_premium
    Checks if there is a DRF charge trigger record but the premium linked to it is paid
    %param pn_policy_number    IN co040.polref%TYPE
    %param pv_product_type     IN pr010.prdref%TYPE
    ===========================================================================================*/
    PROCEDURE p_drf_crg_paid_premium(pn_policy_number IN co040.polref%TYPE
                                    ,pv_product_type  IN pr010.prdref%TYPE)
    IS
        CURSOR cu_charge_triggers (pcn_policy_reference co040.polref%TYPE)
        IS
            SELECT DISTINCT 'Transaction Type: '  || pa.fndtrntyp  ||
                            '~Increment Type: '   || pa.inrtyp ||
                            '~Increment Ref: '    || pa.inrref ||
                            '~Effective Date: '   || TO_DATE(TO_CHAR(pa.efvdte + 2415021),'J') ||
                            '~Start Date: '       || TO_DATE(TO_CHAR(pa.strdte + 2415021),'J') error_message
                FROM pa020 pa
                JOIN event ev ON  ev.polref  = pa.polref
                              AND ev.staevt  = 55
                              AND ev.inrtyp  = pa.inrtyp
                              AND ev.inrref >= pa.inrref
                WHERE pa.polref = pcn_policy_reference
                AND   ((pa.fndtrntyp IN ('ACO','ACV','ACA','CCO','CCV','CCA')
                AND   pa.trnsubtyp != 1) -- exclude % contribution charges from this check as can sit as DRF for months
                OR    (pa.fndtrntyp IN ('ACI','CCI')))
                AND   pa.sta_pa  = 5;

    BEGIN

        pck_process_info.p_set_action('p_drf_crg_paid_premium');

        FOR lr_charge_triggers IN cu_charge_triggers(pn_policy_number) LOOP

           --Raise exception 154
           p_raise_exception(pn_policy_number
                            ,154
                            ,lr_charge_triggers.error_message
                            ,pv_product_type
                            );
        END LOOP;

    END p_drf_crg_paid_premium;

    /*=============================================================================================
    Procedure p_valid_charge_increments_recs
    Checks if the charge_increment_dates records follow on logically and tie into the linked PA020
    %param pn_policy_number    IN co040.polref%TYPE
    %param pv_product_type     IN pr010.prdref%TYPE
    ==============================================================================================*/
    PROCEDURE p_valid_charge_increments_recs(pn_policy_number IN co040.polref%TYPE
                                            ,pv_product_type  IN pr010.prdref%TYPE)
    IS

        CURSOR cu_charge_increment_recs (pcn_policy_ref co040.polref%TYPE)
        IS
        SELECT  cid.start_date           start_date
               ,cid.end_date             end_date
               ,cd.charge_type           charge_type
               ,cd.charge_subtype        charge_subtype
               ,cd.status                charge_status
               ,cd.trnctl_no             charge_trnctl_no
               ,cid.charge_id            charge_id
               ,cid.increment_type       increment_type
               ,cid.increment_reference  increment_reference
               ,pa.sta_pa                trn_status
               ,NVL(cs.itevalnam,' ')    trn_status_descr
               ,TO_DATE(TO_CHAR(pa.enddte + 2415021),'J') trn_end_date_cnv
               ,pa.enddte                                 trn_end_date
               ,pa.trnctl_no                              trnctl_no
               ,pa.audupddte                              audupddte
               ,TO_DATE(TO_CHAR(pa.audupddte + 2415021),'J') trn_audit_date_cnv
            FROM charge_details cd
            JOIN charge_increment_dates cid ON cd.charge_id = cid.charge_id
                                           AND cid.status   = 30
            LEFT OUTER JOIN pa020 pa        ON pa.polref    = cd.polref
                                           AND pa.trnctl_no = cd.trnctl_no
            LEFT OUTER JOIN cs060 CS ON cs.ispgrpnam = 'PA020'
                                    AND cs.datitenam = 'STA'
                                    AND cs.maint    != 'D'
                                    AND cs.datiteval = pa.sta_pa
            WHERE cd.polref    = pcn_policy_ref
            AND   cd.status    = 30
            AND   cd.charge_type NOT IN ('NIL', 'DUM');  -- Omit checking on NIL and DUM charge types

        lb_trigger_rec_exception_found BOOLEAN := FALSE;
        lb_no_pa020_found              BOOLEAN := FALSE;
        lv_error_message               VARCHAR2(1803);

    BEGIN

        pck_process_info.p_set_action('p_valid_charge_increments_recs');

        FOR lr_charge_increment_recs IN cu_charge_increment_recs (pn_policy_number) LOOP

            lb_trigger_rec_exception_found := FALSE; -- reset at start of loop
            lb_no_pa020_found              := FALSE;

            IF lr_charge_increment_recs.trn_end_date IS NULL     OR
               lr_charge_increment_recs.trn_status NOT IN (5,30) THEN
                  lb_no_pa020_found := TRUE;
                  -- If status of record is suspended then only report if it has been at this status for more than
                  -- 31 days
                  IF NVL(lr_charge_increment_recs.trn_status, 0) = 47 AND
                     lpn_system_date < (lr_charge_increment_recs.audupddte + 31) THEN
                       lb_no_pa020_found := FALSE;
                  END IF;
            ELSIF lr_charge_increment_recs.trn_status = 30 AND
                  ((lr_charge_increment_recs.end_date != lr_charge_increment_recs.trn_end_date_cnv) OR
                   (lr_charge_increment_recs.end_date IS NULL AND lr_charge_increment_recs.trn_end_date != 99999)) THEN
                  lb_trigger_rec_exception_found := TRUE;
            END IF;

            -- Slightly different error messages if error with PA020 trigger found or no PA020 found at all

            IF lb_trigger_rec_exception_found OR
               lb_no_pa020_found              THEN
                    lv_error_message := 'Charge Start date: '||lr_charge_increment_recs.start_date||'~'||
                                        'Charge End date:  '||lr_charge_increment_recs.end_date||'~'||
                                        'Charge Type: '||lr_charge_increment_recs.charge_type||'~'||
                                        'Charge Subtype: ' || lr_charge_increment_recs.charge_subtype ||'~'||
                                        'Charge Status: ' || lr_charge_increment_recs.charge_status ||'~'||
                                        'Charge ID: ' || lr_charge_increment_recs.charge_id ||'~'||
                                        'Increment type: '||lr_charge_increment_recs.increment_type||'~'||
                                        'Increment ref: '||lr_charge_increment_recs.increment_reference;

                IF lb_trigger_rec_exception_found THEN
                   lv_error_message := lv_error_message ||
                                 '~UDCTL Trigger End date: ' || lr_charge_increment_recs.trn_end_date_cnv ||
                                 ' does not match charge end date';
                END IF;

                IF lb_no_pa020_found THEN
                   lv_error_message := lv_error_message ||
                            '~No Live/Draft UDCTL trigger for transaction control number: '||
                            lr_charge_increment_recs.charge_trnctl_no           ||'~'||
                            'UDCTL Trigger Status: ' || NVL(lr_charge_increment_recs.trn_status_descr, ' ') ||'~'||
                            'UDCTL Trigger Audit Date: ' || lr_charge_increment_recs.trn_audit_date_cnv;
                END IF;

                    -- Raise exception 156
                    p_raise_exception(pn_policy_number
                                     ,156
                                     ,lv_error_message
                                     ,pv_product_type
                                     );

            END IF;

        END LOOP;

    END p_valid_charge_increments_recs;

    /*=============================================================================================
    Procedure p_incrm_charges_check
    Check to ensure that all live increments have a AC/CC record
    %param pn_policy_number    IN co040.polref%TYPE
    %param pv_product_type     IN pr010.prdref%TYPE
    ==============================================================================================*/

    PROCEDURE p_incrm_charges_check (pn_policy_number IN co040.polref%TYPE
                                    ,pv_product_type  IN pr010.prdref%TYPE)
    IS
        CURSOR cu_incrm_charges (pcn_policy_reference co040.polref%TYPE)
        IS
            SELECT crg.policy_reference
                  ,'Increment Type: '||crg.increment_type||'~'||
                   'Increment Reference: '||crg.increment_ref||'~'||
                   'Employee cont: '||LTRIM(TO_CHAR(crg.employee_contribution,'99999990D99'))||'~'||
                   'Employer cont: '||LTRIM(TO_CHAR(crg.employer_contribution,'99999990D99')) error_message
            FROM
            (SELECT po3.polref    policy_reference
                   ,po3.inrtyp    increment_type
                   ,po3.inrref    increment_ref
                   ,po3.othctbprm + po3.othctbadm + po3.othctbocc                  employer_contribution
                   ,po3.occxtr + po3.prmamt + po3.admcrg - (po3.othctbprm + po3.othctbadm + po3.othctbocc)
                                                                                   employee_contribution
             FROM   po030 po3
             JOIN   po020 inc   ON po3.polref               = inc.polref
                               AND po3.inrtyp               = inc.inrtyp
                               AND po3.inrref               = inc.inrref
                               AND inc.stainr               = 30
                               AND inc.maint               != 'D'
             JOIN   po020 inc_b ON po3.polref               = inc_b.polref
                               AND po3.inrtyp               = inc_b.inrtyp
                               AND inc_b.inrref             = 1
                               AND inc_b.stainr             = 30
                               AND inc_b.maint             != 'D'
             JOIN   pr010 pr    ON po3.prdref               = pr.prdref
                               AND po3.prdvrs_no            = pr.prdvrs_no
                               AND pr.commission_allowed_yn = 'N'
             WHERE  po3.polref = pcn_policy_reference
             AND  po3.maint != 'D'
             AND  po3.bentyp NOT IN ('WVR','TA','PLANA','GLA','LTD','STD','GIP','STU','STDU')
             AND  po3.staben IN (29,30)
             AND  po3.altcde NOT IN (50, 51, 52)
             AND  po3.crcdte NOT IN (0, 99999, -99999)
             AND ((po3.othctbprm + po3.othctbadm + po3.othctbocc != 0 )
               OR (po3.occxtr + po3.prmamt + po3.admcrg - (po3.othctbprm + po3.othctbadm + po3.othctbocc) != 0))
             UNION
             SELECT hi3.polref    policy_reference
                   ,hi3.inrtyp    increment_type
                   ,hi3.inrref    increment_ref
                   ,hi3.othctbprm + hi3.othctbadm + hi3.othctbocc             employer_contribution
                   ,hi3.sgnoccxtr + hi3.sgnprmamt + hi3.admcrg - (hi3.othctbprm + hi3.othctbadm + hi3.othctbocc)
                                                                                employee_contribution
             FROM   hi030 hi3
             JOIN   po020 inc   ON hi3.polref               = inc.polref
                               AND hi3.inrtyp               = inc.inrtyp
                               AND hi3.inrref               = inc.inrref
                               AND inc.stainr               = 30
                               AND inc.maint               != 'D'
             JOIN   po020 inc_b ON hi3.polref               = inc_b.polref
                               AND hi3.inrtyp               = inc_b.inrtyp
                               AND inc_b.inrref             = 1
                               AND inc_b.stainr             = 30
                               AND inc_b.maint             != 'D'
             JOIN   pr010 pr    ON hi3.prdref               = pr.prdref
                               AND hi3.prdvrs_no            = pr.prdvrs_no
                               AND pr.commission_allowed_yn = 'N'
             WHERE  hi3.polref = pcn_policy_reference
             AND  hi3.maint != 'D'
             AND  hi3.bentyp NOT IN ('WVR','TA','PLANA','GLA','LTD','STD','GIP','STU','STDU')
             AND  hi3.staben IN (29, 30)
             AND  hi3.altcde NOT IN (50, 51, 52)
             AND  hi3.crcdte NOT IN (0, 99999, -99999)
             AND ((hi3.othctbprm + hi3.othctbadm + hi3.othctbocc <> 0)
               OR (hi3.sgnoccxtr + hi3.sgnprmamt + hi3.admcrg - (hi3.othctbprm + hi3.othctbadm + hi3.othctbocc)
                                                                                                          <> 0))) crg
            WHERE NOT EXISTS (SELECT NULL
                              FROM charge_details cd
                              JOIN charge_increment_dates cid ON cd.charge_id = cid.charge_id
                              WHERE cd.polref                 = crg.policy_reference
                              AND   ((cid.increment_type      = crg.increment_type  AND
                                      cid.increment_reference = crg.increment_ref)
                              OR    (crg.increment_type = 'RVP'              AND
                                     cid.increment_type = crg.increment_type AND
                                     cd.charge_method   = 'FND'              AND
                                     cid.increment_reference  = 0)));

    BEGIN

        pck_process_info.p_set_action('p_incrm_charges_check');

        FOR lr_incrm_charges IN cu_incrm_charges(pn_policy_number) LOOP

           --Raise exception 157
           p_raise_exception(pn_policy_number
                            ,157
                            ,lr_incrm_charges.error_message
                            ,pv_product_type
                            );
        END LOOP;

    END p_incrm_charges_check;

    /*=============================================================================================
    Procedure p_cm240_status_check
    Check to see if the CM240 records for new AC/CC charges are at status 10 or 20
    %param pn_policy_number    IN co040.polref%TYPE
    %param pv_product_type     IN pr010.prdref%TYPE
    ==============================================================================================*/

    PROCEDURE p_cm240_status_check (pn_policy_number IN co040.polref%TYPE
                                   ,pv_product_type  IN pr010.prdref%TYPE)

    IS
        CURSOR cu_cm240_charge_recs (pcn_policy_reference IN co040.polref%TYPE)
        IS
        SELECT 'Charge Type: ' || (CASE cm.csntyp
                           WHEN 'A' THEN
                              'Ad hoc Adviser Charge'
                           WHEN 'B' THEN
                              'Initial Adviser Charge'
                           WHEN 'C' THEN
                              'Ongoing Adviser Charge'
                           WHEN 'E' THEN
                              'Ad hoc Consultancy Charge'
                           WHEN 'G' THEN
                              'Initial Consultancy Charge'
                           WHEN 'H' THEN
                              'Ongoing Consultancy Charge'
                           END) ||'~'||
               'Reason Code: ' || (CASE cm.csnrsncde
                                      WHEN 177 THEN
                                         'Monetary Amount'
                                      WHEN 178 THEN
                                         '% of Contribution'
                                      WHEN 179 THEN
                                         '% of Fund'
                                      WHEN 180 THEN
                                         'ASAP'
                                      END) ||'~'||
               'Increment Type: ' || cm.inrtyp ||'~'||
               'Increment Ref: '  || cm.inrref ||'~'||
               'Charge Status: '  || cm.csnsta ||'~'||
               'Charge Amount: '  || cm.csnamt ||'~'||
               'Origin Date: '    || TO_DATE(TO_CHAR(cm.oridte + 2415021),'J') error_message
        FROM cm240 cm
        WHERE cm.itr_no IN (SELECT co.cliref
                            FROM   co040 co
                            WHERE  co.polref = cm.polref
                            AND    co.rolref = 'ITR'
                            AND    co.maint <> 'D')
        AND   cm.csnsta    IN (10, 20)
        AND   cm.polref    =  pcn_policy_reference
        AND   cm.csnrsncde IN (177,178,179,180)   -- AC/CC Charges
        AND   cm.csntyp    IN ('A','B','C','E','G','H');

    BEGIN

        pck_process_info.p_set_action('p_cm240_status_check');

        FOR lr_cm240_charge_recs IN cu_cm240_charge_recs (pn_policy_number) LOOP

           -- Raise exception 158
           p_raise_exception(pn_policy_number
                            ,158
                            ,lr_cm240_charge_recs.error_message
                            ,pv_product_type
                            );

        END LOOP;

    END p_cm240_status_check;

    /*=============================================================================================
    Procedure p_ini_charge_period_check
    Check that the initial charge period is not more than 60 months
    %param pn_policy_number    IN co040.polref%TYPE
    %param pv_product_type     IN pr010.prdref%TYPE
    ==============================================================================================*/

    PROCEDURE p_ini_charge_period_check (pn_policy_number IN co040.polref%TYPE
                                        ,pv_product_type  IN pr010.prdref%TYPE)

    IS

        CURSOR cu_ini_charge_recs (pcn_policy_reference IN co040.polref%TYPE)
        IS
        SELECT DISTINCT data.polref
              ,'Charge ID: '||data.charge_id||'~'||
               'Charge Type: '             ||data.charge_type||'~'||
               'Charge Sub Type: '         ||data.charge_subtype||'~'||
               'Charge Method: '           ||data.charge_method||'~'||
               'Charge Status: '           ||data.status||'~'||
               'Charge Start Date: '       ||data.start_date||'~'||
               'Charge End Date: '         ||data.end_date||'~'||
               'Increment Type: '          ||data.increment_type||'~'||
               'Increment Ref: '           ||data.increment_reference error_message
        FROM
        (SELECT cd.polref
               ,cd.charge_id
               ,cd.charge_type
               ,cd.charge_subtype
               ,cd.charge_method
               ,MIN(cid.start_date) OVER (PARTITION BY cid.charge_id) start_date
               ,MAX(cid.end_date) OVER (PARTITION BY cid.charge_id) end_date
               ,cd.status
               ,cid.increment_type
               ,cid.increment_reference
        FROM  charge_details cd
        JOIN  charge_increment_dates cid ON  cd.charge_id = cid.charge_id
        WHERE cd.polref         = pcn_policy_reference
        AND   cd.status         = 30
        AND   cd.charge_subtype = 'INI'
        AND   cd.charge_method  IN ('FIX', 'FND', 'CON')) DATA
        WHERE ROUND(MONTHS_BETWEEN (data.end_date, data.start_date))
                 > 60;

    BEGIN

        pck_process_info.p_set_action('p_ini_charge_period_check');

        FOR lr_ini_charge_recs IN cu_ini_charge_recs(pn_policy_number) LOOP

           -- Raise exception 160
           p_raise_exception(pn_policy_number
                            ,160
                            ,lr_ini_charge_recs.error_message
                            ,pv_product_type
                            );

        END LOOP;

    END p_ini_charge_period_check;

   /*=============================================================================================
    Procedure p_stakeholder_charge_check
    Check that the initial charge period is not more than 60 months
    %param pn_policy_number    IN co040.polref%TYPE
    %param pv_product_type     IN pr010.prdref%TYPE
    ==============================================================================================*/

    PROCEDURE p_stakeholder_charge_check (pn_policy_number IN co040.polref%TYPE
                                         ,pv_product_type  IN pr010.prdref%TYPE)

    IS

       CURSOR cu_stakeholder_charge_recs (pcn_policy_reference IN co040.polref%TYPE)
       IS
       SELECT 'Charge Type: '    ||cd.charge_type||'~'||
              'Charge Subtype: ' ||cd.charge_subtype ||'~'||
              'Charge Method: '  ||cd.charge_method ||'~'||
              'Increment type: ' ||cid.increment_type||'~'||
              'Increment ref: '  ||cid.increment_reference||'~'||
              'Start date: '     ||cid.start_date || '~'||
              'End date:  '      ||cid.end_date error_message
       FROM charge_details cd
       JOIN charge_increment_dates cid ON cd.charge_id = cid.charge_id
       WHERE cd.polref = pcn_policy_reference
       AND   cd.charge_type NOT IN ('NIL', 'DUM');

    BEGIN

        pck_process_info.p_set_action('p_stakeholder_charge_check');

        FOR lr_stakeholder_charge_recs IN cu_stakeholder_charge_recs(pn_policy_number) LOOP

           -- Raise exception 161
           p_raise_exception(pn_policy_number
                            ,161
                            ,lr_stakeholder_charge_recs.error_message
                            ,pv_product_type
                            );

        END LOOP;

    END p_stakeholder_charge_check;

    /********************************************************************************************
    -- %Description   Procedure to setup validation errors
    -- %param         pn_policy_number           IN  po010.polref%TYPE
    -- %param         pv_product_type            IN  pr010.prdref%TYPE
    -- %param         pb_valid_gps_prdvrs_no     IN  BOOLEAN
    -- %param         pb_dob_matching            IN  BOOLEAN
    -- %param         pb_ni_no_matching          IN  BOOLEAN
    -- %param         pb_sra_matching            IN  BOOLEAN
    -- %param         pb_live_rps_exist          IN  BOOLEAN
    -- %param         pb_valid_gps_pup_date      IN  BOOLEAN
    -- %param         pb_valid_cps_str_date      IN  BOOLEAN
    -- %param         pn_linked_rs_policy_count  IN  PLS_INTEGER
    *********************************************************************************************/
    PROCEDURE p_setup_validation_errors (pn_policy_number            IN     po010.polref%TYPE
                                        ,pv_product_type             IN     pr010.prdref%TYPE
                                        ,pb_valid_gps_prdvrs_no      IN     BOOLEAN
                                        ,pb_dob_matching             IN     BOOLEAN
                                        ,pb_ni_no_matching           IN     BOOLEAN
                                        ,pb_sra_matching             IN     BOOLEAN
                                        ,pb_live_rps_exist           IN     BOOLEAN
                                        ,pb_valid_gps_pup_date       IN     BOOLEAN
                                        ,pb_valid_cps_str_date       IN     BOOLEAN
                                        ,pn_linked_rs_policy_count   IN     PLS_INTEGER)
    IS
        lv_error_message          VARCHAR2(2000);
        LCN_GPS_RS_LINK_ERR_CODE  CONSTANT NUMBER := 866;
    BEGIN
        pck_process_info.p_set_action (pv_action_name => 'p_setup_validation_errors');

        IF pb_valid_gps_prdvrs_no != TRUE  THEN

            lv_error_message :=  'A link to an RS plan has been set up for a version 5 or 6 GPS plan.';

            p_raise_exception (pn_policy_number
                              ,LCN_GPS_RS_LINK_ERR_CODE
                              ,lv_error_message
                              ,pv_product_type
                              );

        END IF;

        IF  pb_dob_matching   != TRUE  OR
            pb_ni_no_matching != TRUE  THEN

           lv_error_message :=  'A link has been set up where the GPS and RS plans have different client details.';

           p_raise_exception (pn_policy_number
                             ,LCN_GPS_RS_LINK_ERR_CODE
                             ,lv_error_message
                             ,pv_product_type
                             );

        END IF;


        IF pb_sra_matching != TRUE THEN

            lv_error_message :=  'A link has been set up where the GPS and RS plans have different retirement dates.';

            p_raise_exception (pn_policy_number
                              ,LCN_GPS_RS_LINK_ERR_CODE
                              ,lv_error_message
                              ,pv_product_type
                              );

        END IF;

        IF pb_live_rps_exist != TRUE THEN

            lv_error_message :=  'A link to an RS plan has been set up for a GPS plan which has no live RP increment at the effective date of the link.';

            p_raise_exception (pn_policy_number
                              ,LCN_GPS_RS_LINK_ERR_CODE
                              ,lv_error_message
                              ,pv_product_type
                              );

        END IF;

        IF pb_valid_gps_pup_date != TRUE THEN

            lv_error_message :=  'A link to an RS plan has been set up for a GPS plan which was made Paid-Up prior to 01/08/2013.';

            p_raise_exception (pn_policy_number
                              ,LCN_GPS_RS_LINK_ERR_CODE
                              ,lv_error_message
                              ,pv_product_type
                              );

        END IF;

        IF pb_valid_cps_str_date != TRUE THEN

            lv_error_message :=  'A link has been set up for a plan that was a CPS at the effective date of the link.';

            p_raise_exception (pn_policy_number
                              ,LCN_GPS_RS_LINK_ERR_CODE
                              ,lv_error_message
                              ,pv_product_type
                              );

        END IF;

        IF pn_linked_rs_policy_count > 1 THEN

            lv_error_message :=  'A GPS plan has been linked with more than one RS plan.';

            p_raise_exception (pn_policy_number
                              ,LCN_GPS_RS_LINK_ERR_CODE
                              ,lv_error_message
                              ,pv_product_type
                              );

        END IF;
    END p_setup_validation_errors;

    /********************************************************************************************
    -- %Description   Procedure to validate linked GPS and RS policies
    -- %param         pn_policy_number           IN  po010.polref%TYPE
    -- %param         pv_product_type            IN  pr010.prdref%TYPE
    -- %param         pv_product_sub_group       IN  pr010.prdsubgrp%TYPE
    -- %param         pn_linked_policy           IN  po010.polref%TYPE
    *********************************************************************************************/
    PROCEDURE p_validate_gps_rs_policies (pn_policy_number     IN po010.polref%TYPE
                                         ,pv_product_type      IN pr010.prdref%TYPE
                                         ,pv_product_sub_group IN pr010.prdsubgrp%TYPE
                                         ,pn_linked_policy     IN po010.polref%TYPE)
    IS

        lb_valid_gps_prdvrs_no    BOOLEAN;
        lb_dob_matching           BOOLEAN;
        lb_ni_no_matching         BOOLEAN;
        lb_sra_matching           BOOLEAN;
        lb_live_rps_exist         BOOLEAN;
        lb_valid_gps_pup_date     BOOLEAN;
        lb_valid_cps_str_date     BOOLEAN;
        ln_linked_rs_policy_cnt   PLS_INTEGER;
        ln_gps_policy             po010.polref%TYPE;
        ln_rs_policy              po010.polref%TYPE;
    BEGIN
        pck_process_info.p_set_action ('p_validate_gps_rs_policies');

        IF pv_product_sub_group = 'CRG4' THEN
            ln_gps_policy := pn_policy_number;
            ln_rs_policy  := pn_linked_policy;
        ELSE
            ln_gps_policy := pn_linked_policy;
            ln_rs_policy  := pn_policy_number;
        END IF;

        pck_gps_rs_link.p_validate_gps_rs_policies
                                   (pn_gps_polref              => ln_gps_policy
                                   ,pn_rs_polref               => ln_rs_policy
                                   ,pb_valid_gps_prdvrs_no     => lb_valid_gps_prdvrs_no
                                   ,pb_ni_no_matching          => lb_ni_no_matching
                                   ,pb_dob_matching            => lb_dob_matching
                                   ,pb_sra_matching            => lb_sra_matching
                                   ,pb_live_rps_exist          => lb_live_rps_exist
                                   ,pb_valid_gps_pup_date      => lb_valid_gps_pup_date
                                   ,pb_valid_cps_str_date      => lb_valid_cps_str_date
                                   ,pn_linked_rs_policy_count  => ln_linked_rs_policy_cnt);


         p_setup_validation_errors (pn_policy_number            => pn_policy_number
                                   ,pv_product_type             => pv_product_type
                                   ,pb_valid_gps_prdvrs_no      => lb_valid_gps_prdvrs_no
                                   ,pb_dob_matching             => lb_dob_matching
                                   ,pb_ni_no_matching           => lb_ni_no_matching
                                   ,pb_sra_matching             => lb_sra_matching
                                   ,pb_live_rps_exist           => lb_live_rps_exist
                                   ,pb_valid_gps_pup_date       => lb_valid_gps_pup_date
                                   ,pb_valid_cps_str_date       => lb_valid_cps_str_date
                                   ,pn_linked_rs_policy_count   => ln_linked_rs_policy_cnt);
    END p_validate_gps_rs_policies;

    /********************************************************************************************
    -- %Description   Procedure to validate linked GPS and RS policies
    -- %param         pn_policy_number   IN  po010.polref%TYPE
    -- %param         pv_product_type    IN  VARCHAR2
    *********************************************************************************************/
    PROCEDURE p_gps_rs_link_validations (pn_policy_number IN co040.polref%TYPE
                                        ,pv_product_type  IN VARCHAR2)
    IS
        lv_product_sub_group     pr010.prdsubgrp%TYPE;
        ln_linked_rs_policy      po010.polref%TYPE;
        lt_linked_gps_policies   t_number_table;
        ln_linked_policy_count   PLS_INTEGER;
        ln_linked_gps_policy     PLS_INTEGER;
    BEGIN
        pck_process_info.p_register_module (pv_module_name => 'PCK_POLICY_EXCEPTIONS'
                                           ,pv_action_name => 'P_GPS_RS_LINK_VALIDATIONS'
                                           );

        IF pck_gps_rs_link.f_linked_policy_exists (pn_policy_ref => pn_policy_number) THEN

            lv_product_sub_group := pck_policy_details.f_get_product_subgroup
                                                           (pn_polref =>  pn_policy_number);

            CASE lv_product_sub_group

                WHEN 'CRG4' THEN
                    ln_linked_rs_policy := pck_gps_rs_link.f_get_linked_rs_policy
                                                                 (pn_gps_policy_reference => pn_policy_number);

                    p_validate_gps_rs_policies (pn_policy_number     => pn_policy_number
                                               ,pv_product_type      => pv_product_type
                                               ,pv_product_sub_group => lv_product_sub_group
                                               ,pn_linked_policy     => ln_linked_rs_policy);

                WHEN 'CRG6' THEN
                    pck_gps_rs_link.p_get_linked_policies (pn_policy_reference    => pn_policy_number
                                                          ,pn_linked_policy_count => ln_linked_policy_count
                                                          ,pt_linked_policies     => lt_linked_gps_policies);

                    ln_linked_gps_policy :=  lt_linked_gps_policies(lt_linked_gps_policies.FIRST);

                    WHILE (ln_linked_gps_policy IS NOT NULL) LOOP
                        p_validate_gps_rs_policies
                                                (pn_policy_number     => pn_policy_number
                                                ,pv_product_type      => pv_product_type
                                                ,pv_product_sub_group => lv_product_sub_group
                                                ,pn_linked_policy     => ln_linked_gps_policy);

                        ln_linked_gps_policy := lt_linked_gps_policies.NEXT(ln_linked_gps_policy);
                   END LOOP;
            ELSE NULL;
            END CASE;
        END IF;
    END p_gps_rs_link_validations;


    -- main procedure
    PROCEDURE p_perform(pv_scheme_category       IN sc010.schcat%TYPE
                       ,pn_scheme_ref            IN sc010.schref%TYPE
                       ,pv_employer_category     IN cl300.clicat2%TYPE
                       ,pn_employer_ref          IN cl300.cliref2%TYPE
                       ,pn_previous_renewal_date IN pa021.rnwdte%TYPE
                       ,pn_renewal_date          IN pa021.rnwdte%TYPE

                       ,pn_default_policy        IN sc010.dflpolref%TYPE
                       ,pv_servicing_department  IN VARCHAR2
                       ,pr_audit_details         IN pck_audits.rec_audits) IS

        CURSOR cu_policy_details IS
            SELECT /*+ index (co040 co040_itr)*/ co040.polref
                  ,po010.stapol
                  ,DECODE(po010.pupdte, -99999, 'N', 'Y') pup_indicator
                  ,po010.extmod
                  ,po010.prdref
                  ,NVL(data_description.itevaldes,'Unknown policy status') status
                  ,po030.crcdte
                  ,po030.altcde
            FROM co040
            JOIN po010
            ON co040.polref = po010.polref
            LEFT OUTER JOIN po030
            ON  co040.polref = po030.polref
            AND po030.inrtyp = 'RVP'
            AND po030.inrref = 0
            AND po030.bentyp = 'INV'
            AND po030.benref = 1
            AND po030.maint != 'D'
            LEFT OUTER JOIN (SELECT itevaldes
                                   ,datiteval
                             FROM cs060
                             WHERE ispgrpnam =  'POL'
                             AND   datitenam =  'STAPOL'
                             AND   maint     <> 'D') data_description
            ON po010.stapol = data_description.datiteval
            WHERE co040.clicat = pv_scheme_category
            AND   co040.cliref = pn_scheme_ref
            AND   co040.rolref = 'SCH'
            AND   co040.maint != 'D'
            AND   po010.maint != 'D'
            AND   co040.enddte =  99999
            AND   co040.staxrf IN (5, 30)         -- draft or live cases
            ORDER BY co040.polref;

        CURSOR cu_client_details(pcn_policy_number IN co040.polref%TYPE) IS
            SELECT co040.clicat
              ,co040.cliref
              ,co040.adrclicat
              ,co040.adrcliref
              ,co040.adrref
              ,cl010.natinr_no
              ,cl010.bthdte
            FROM co040
            JOIN cl010
            ON  co040.clicat = cl010.clicat
            AND co040.cliref = cl010.cliref
            WHERE co040.polref = pcn_policy_number
            AND   co040.rolref IN ('P','L','PL')
            AND   co040.staxrf =  30
            AND   co040.maint  <> 'D'
            AND   cl010.maint  <> 'D'
            AND   lpn_system_date BETWEEN co040.strdte AND co040.enddte
            ORDER BY co040.xrfunq DESC;

        TYPE t_policy_details IS TABLE OF cu_policy_details%ROWTYPE INDEX BY PLS_INTEGER;

        lt_policy_details           t_policy_details;
        lr_client_details           cu_client_details%ROWTYPE;
        ln_ITR_number               co040.cliref%TYPE;
        lb_ITR_found                BOOLEAN;

    BEGIN

        OPEN cu_policy_details;
        FETCH cu_policy_details BULK COLLECT INTO lt_policy_details;
        CLOSE cu_policy_details;

        IF lt_policy_details.COUNT > 0 THEN
            FOR i IN lt_policy_details.FIRST..lt_policy_details.LAST LOOP

                -- exceptions not required for entrants after renewal date
                IF NVL(lt_policy_details(i).crcdte,-99999) < pn_renewal_date THEN
                    p_setup_AWD_policy_info(pr_audit_details
                                           ,pv_scheme_category
                                           ,pn_scheme_ref
                                           ,pv_employer_category
                                           ,pn_employer_ref
                                           ,lt_policy_details(i).polref
                                           ,lt_policy_details(i).prdref
                                           ,pv_servicing_department);

                    OPEN cu_client_details(lt_policy_details(i).polref);
                    FETCH cu_client_details INTO lr_client_details;
                    CLOSE cu_client_details;

                    -- pending exits should be raised as an exception
                    IF lt_policy_details(i).stapol = 52 THEN

                        pck_GPS_exceptions.p_raise_exception(711);            -- exception number

                    ELSIF  lt_policy_details(i).stapol = 30 THEN            -- live & pup'd cases

                        -- need additional pup check for policies pup'd the old way
                        IF  lt_policy_details(i).pup_indicator = 'N'
                        AND lt_policy_details(i).altcde IN (50,51,52) THEN
                            lt_policy_details(i).pup_indicator := 'Y';
                        END IF;

                        p_increment_level_checks(lt_policy_details(i).polref
                                                ,lt_policy_details(i).pup_indicator
                                                ,pn_previous_renewal_date
                                                ,pn_renewal_date
                                                ,pn_default_policy);

                        p_unallocated_DSS_monies_check(lt_policy_details(i).polref
                                                      ,lr_client_details.natinr_no
                                                      ,'GPS'
                                                      );

                        p_temp_NI_check(lt_policy_details(i).polref
                                       ,lr_client_details.natinr_no
                                       ,'GPS'
                                       ,lr_client_details.bthdte);

                        p_retirement_age_check(pn_policy_number     => lt_policy_details(i).polref
                                              ,pv_product_type      => 'GPS'
                                              ,pv_create_LV_trigger => 'Y');

                        p_address_check(lr_client_details.adrclicat
                                       ,lr_client_details.adrcliref
                                       ,lr_client_details.adrref);

                        p_CSNXR_ITR_check(lt_policy_details(i).polref
                                         ,30                -- policy should have record of status 30
                                         ,ln_ITR_number     -- out parameter
                                         ,lb_ITR_found      -- out parameter
                                         ,'GPS');

                        p_DSS_not_received_check(lt_policy_details(i).polref
                                                ,pn_renewal_date
                                                ,'GPS');

                        p_CCINQ_ITR_check(lt_policy_details(i).polref
                                         ,pn_renewal_date);

                        p_statement_number_check(lt_policy_details(i).polref
                                                ,'GPS');

                    END IF;

                    IF lt_policy_details(i).stapol IN (30, 52) THEN

                        p_fund_movement_status_check(lt_policy_details(i).polref
                                                    ,pn_previous_renewal_date
                                                    ,pn_renewal_date
                                                    ,lt_policy_details(i).stapol
                                                    ,lt_policy_details(i).extmod
                                                    ,'GPS'
                                                    ,'GPS');

                        p_premium_status_check(lt_policy_details(i).polref
                                              ,pn_previous_renewal_date
                                              ,pn_renewal_date
                                              ,'GPS');

                        p_negative_FNDQT_check(lt_policy_details(i).polref
                                              ,'GPS');

                        p_premium_event_check(lt_policy_details(i).polref
                                             ,pn_previous_renewal_date
                                             ,pn_renewal_date
                                             ,'GPS');
                    END IF;

                    p_HMA_check(pn_policy_number => lt_policy_details(i).polref
                               ,pv_product_type  => 'GPS');

                    p_unallocated_monies_check(lt_policy_details(i).polref
                                              ,pv_scheme_category
                                              ,pn_scheme_ref
                                              ,pv_employer_category
                                              ,pn_employer_ref
                                              ,pn_previous_renewal_date
                                              ,pn_renewal_date
                                              ,'GPS');

                    pck_scheme_exceptions.p_unallocated_monies_check(lr_client_details.clicat
                                                                    ,lr_client_details.cliref
                                                                    ,pn_previous_renewal_date
                                                                    ,pn_renewal_date
                                                                    ,'GPS');

                    p_ACTPL_error_check(lt_policy_details(i).polref
                                       ,'GPS');

                    p_outstanding_AE_check(lt_policy_details(i).polref
                                          ,pn_previous_renewal_date
                                          ,pn_renewal_date);

                    p_switch_check(lt_policy_details(i).polref
                                  ,pn_previous_renewal_date
                                  ,pn_renewal_date
                                  ,'GPS');

                    p_outstanding_new_bus_check(lt_policy_details(i).polref
                                               ,lt_policy_details(i).stapol
                                               ,lt_policy_details(i).status
                                               ,pn_renewal_date
                                               ,'GPS');

                    p_manual_commission_check(lt_policy_details(i).polref
                                             ,pn_previous_renewal_date
                                             ,pn_renewal_date);

                    p_FNDQT_check(lt_policy_details(i).polref
                                 ,pn_renewal_date
                                 ,'GPS');

                    p_gps_rs_link_validations (pn_policy_number  => lt_policy_details(i).polref
                                              ,pv_product_type   => 'GPS');

                END IF;

            END LOOP;

        END IF;

    END p_perform;

    /********************************************************************************************
    -- %Description   Procedure to check invalid commission payment
    -- %param         pn_policy_ref   IN cm240.polref%TYPE
    -- %param         pn_scheme_ref   IN commission_switch_off.scheme_reference%TYPE
    -- %param         pv_scheme_cat   IN commission_switch_off.scheme_category%TYPE
    -- %param         pv_product_type IN po010.prdref%TYPE
    *********************************************************************************************/
    PROCEDURE p_invalid_commission_check (pn_policy_ref   IN cm240.polref%TYPE
                                         ,pn_scheme_ref   IN commission_switch_off.scheme_reference%TYPE
                                         ,pv_scheme_cat   IN commission_switch_off.scheme_category%TYPE
                                         ,pv_product_type IN po010.prdref%TYPE)
    IS
        LCN_SYSTEM_DTE CONSTANT cs340.sysdte%TYPE  := pck_system_context.f_get_system_date;
        LCN_COMM_SWITCH_OFF_LIVE_DATE CONSTANT cs340.sysdte%TYPE  := 42396;

        CURSOR cu_invalid_comm_movements (pcn_policy_ref               IN cm240.polref%TYPE
                                         ,pcn_scheme_ref               IN commission_switch_off.scheme_reference%TYPE
                                         ,pcv_scheme_cat               IN commission_switch_off.scheme_category%TYPE
                                         ,pcn_sysdte                   IN cs340.sysdte%TYPE
                                         ,pcn_comm_switch_off_live_dte IN cs340.sysdte%TYPE)
        IS
            WITH policy_comm_details AS
                (SELECT co1.polref  polref
                       ,co2.cliref  itr_no
                       ,co1.cliref  scheme_ref
                       ,co1.clicat  scheme_cat
                       ,TRUNC(cso.switch_off_date) - TO_DATE('01-JAN-1900', 'DD-MON-YYYY') switch_off_dte
                 FROM   co040 co1
                 JOIN   commission_switch_off cso
                 ON    (co1.cliref  =  cso.scheme_reference
                 AND    co1.clicat  =  cso.scheme_category)
                 JOIN   co040 co2
                 ON    (co2.polref = co1.polref)
                 WHERE  co1.rolref  =  'SCH'
                 AND    co1.staxrf  =  30
                 AND    co1.maint  !=  'D'
                 AND    co1.cliref  =  pcn_scheme_ref
                 AND    co1.clicat  =  pcv_scheme_cat
                 AND    co1.polref  =  pcn_policy_ref
                 AND    co1.strdte  <= pcn_sysdte
                 AND    co1.enddte  >  pcn_sysdte
                 AND    co2.clicat  =  'ITR'
                 AND    co2.rolref  =  'ITR'
                 AND    co2.maint  !=  'D'
                 AND    cso.status  =  50)

            SELECT  ' ITR:'                           || TO_CHAR(itr_no)                                               ||
                    ' ~ Scheme_cat:'                  || scheme_cat                                                    ||
                    ' ~ scheme_ref:'                  || TO_CHAR(scheme_ref)                                           ||
                    ' ~ Commission_switch_off_date:'  || TO_CHAR(TO_DATE(switch_off_dte + 2415021, 'J'), 'DD/MM/YYYY') ||
                    ' ~ Inrtyp:'                      || inrtyp                                                        ||
                    ' ~ Inrref:'                      || inrref                                                        ||
                    ' ~ Csntyp:'                      || csntyp                                                        ||
                    ' ~ Duedate:'                     || TO_CHAR(TO_DATE(duedte + 2415021, 'J'), 'DD/MM/YYYY')         ||
                    ' ~ Remuneration_type:'           || csntyp                                                        ||
                    ' ~ Remuneration_amount:'         || TO_CHAR(csnamt)    error_message
            FROM   (SELECT  cm.duedte
                           ,cm.itr_no
                           ,cm.csntyp
                           ,cm.polref
                           ,pcd.scheme_cat
                           ,pcd.scheme_ref
                           ,pcd.switch_off_dte
                           ,cm.inrtyp
                           ,cm.inrref
                           ,SUM(CASE WHEN cm.movtyp = 'D' THEN -1 * cm.csnamt
                                 ELSE cm.csnamt END) csnamt
                    FROM    cm240 cm
                    JOIN    policy_comm_details pcd

                    ON    (cm.csnsta        !=  90
                    AND    cm.polref         =  pcd.polref
                    AND    cm.itr_no         =  pcd.itr_no
                    AND    cm.oridte         >  pcn_comm_switch_off_live_dte)

                    LEFT OUTER JOIN  event ev1
                    ON    (cm.inrtyp         =   ev1.inrtyp
                    AND    cm.polref         =   ev1.polref
                    AND    cm.trn_no         =   ev1.tranno
                    AND    cm.unq            =   ev1.unq
                    AND    ev1.ispec         =   'FI560'
                    AND    ev1.staevt        =   55)

                    LEFT OUTER JOIN fi595 fi
                    ON   (fi.unqtwo    =   ev1.unq
                    AND   fi.trn_notwo =   ev1.tranno
                    AND   fi.ispnamone =   'FI500')

                    LEFT OUTER JOIN event ev2
                    ON   (fi.unqone     =   ev2.unq
                    AND   fi.trn_noone  =   ev2.tranno
                    AND   ev2.polref    =   ev2.polref)

                    LEFT OUTER JOIN en240 en
                    ON  (cm.polref    =  en.polref
                    AND  cm.itr_no    =  en.itr_no
                    AND  cm.csnrsncde =  en.csnrsncde
                    AND  cm.duedte    =  en.duedte
                    AND  cm.inrtyp    =  en.inrtyp
                    AND  cm.inrref    =  en.inrref
                    AND  cm.movtyp    =  en.movtyp
                    AND  cm.prmamt    =  en.prmamt
                    AND  cm.csnamt    =  en.csnamt
                    AND  cm.csntyp    =  en.csntyp
                    AND  en.csnrsncde =  78)   -- Manual Credits

                    WHERE ((cm.csntyp         IN ('L', 'R', 'S', 'I', 'F','O')
                    AND     cm.csnrsncde  NOT IN (78, 79)

                    -- Commission movement Due Date >= Commission Switch off Date
                    AND   ((cm.duedte   >=  pcd.switch_off_dte)

                    -- Commission generated for RP Paid date >= Commission Switch off Date
                    OR     (cm.inrtyp    IN   ('RVP', 'AVCR')
                    AND     ev1.dte2      >=  pcd.switch_off_dte)

                    -- Commission generated for SP Paid date >= Commission Switch off Date
                    OR     (cm.inrtyp     IN  ('SP', 'TV')
                    AND     ev2.dte1    >=   pcd.switch_off_dte)))

                    -- EVENT DTE2 of the premium before renewals, PUP date >= Commission Switch off Date
                    OR    (cm.csnrsncde IN (130, 172, 174)
                    AND    pcd.switch_off_dte <= (SELECT MAX(ev3.dte2)
                                                  FROM   event ev3
                                                  WHERE  ev3.polref = cm.polref
                                                  AND    ev3.inrtyp = cm.inrtyp
                                                  AND    ev3.ispec  = 'FI560'
                                                  AND    ev3.staevt = 55
                                                  AND    ev3.dte1  <  cm.duedte
                                                  AND    ev3.dte1   =  (SELECT MAX(ev4.dte1)
                                                                        FROM   event ev4
                                                                        WHERE  ev4.polref  = cm.polref
                                                                        AND    ev4.ispec   = 'FI560'
                                                                        AND    ev4.staevt  = 55
                                                                        AND    ev4.inrtyp  = ev3.inrtyp
                                                                        AND    ev4.dte1   <= ev3.dte1)))

                     OR  (cm.csnrsncde      =  79    -- Manual Debits
                     OR  (cm.csnrsncde      =  78    -- Manual Credits
                     AND  GREATEST(en.efvdte, en.duedte) > pcd.switch_off_dte)))

                    GROUP BY cm.polref
                            ,cm.inrtyp
                            ,cm.inrref
                            ,cm.csntyp
                            ,cm.duedte
                            ,cm.itr_no
                            ,pcd.scheme_cat
                            ,pcd.scheme_ref
                            ,pcd.switch_off_dte)
            WHERE  csnamt > 0;
    BEGIN
        pck_process_info.p_register_module (pv_module_name => 'PCK_POLICY_EXCEPTIONS'
                                           ,pv_action_name => 'P_INVALID_COMMISSION_CHECK');

        FOR rec IN cu_invalid_comm_movements (pn_policy_ref
                                             ,pn_scheme_ref
                                             ,pv_scheme_cat
                                             ,LCN_SYSTEM_DTE
                                             ,LCN_COMM_SWITCH_OFF_LIVE_DATE) LOOP
            -- Raise exception 902
            p_raise_exception (pn_policy_ref
                              ,902
                              ,rec.error_message
                              ,pv_product_type);
        END LOOP;
    END p_invalid_commission_check;
    -- %Description   Procedure to check if Regular contribution end date is greater than policy holder 75th birthday
    PROCEDURE p_age75_less_than_rc_end_date(pn_policy_reference  IN po010.polref%TYPE
                                       ,pv_product_type      IN pr010.prdref%TYPE)
    IS

    CURSOR cu_75thdob_less_than_RC(pcn_policy_reference IN po010.polref%TYPE)
    IS

        SELECT p10.polref            policy_reference
               ,'Policy holder 75th birthday is less than Regular contribution end date' || '~' ||
               'policy reference  : ' || p10.polref  ||'~'||
               'product reference : ' || p10.prdref ||'~'||
               'policy holder 75th birthday : ' || TO_CHAR(add_months(TO_DATE('01/01/1900', 'DD/MM/YYYY') + c.bthdte,900),'DD-MM-YYYY') ||'~' ||
               'policy holder regular contribution end date : ' || TO_CHAR(pck_utility.f_dtcnv(p30.pymenddte),'DD-MM-YYYY') error_message
        FROM    cl010 c
               ,po010 p10
               ,po030 p30
               ,co040 co
        WHERE   p10.polref       =   p30.polref
        AND     co.rolref        =   'PL'
        AND     co.cliref        =   c.cliref
        AND     co.clicat        =   c.clicat
        AND     p10.polref       =   co.polref
        AND     p30.inrtyp      IN   ('RVP','ORD','AVCR')
        AND     p30.inrref      =    0 -- This is the master increment record.
        AND     p30.staben      =    30
        AND     p30.maint       !=   'D'
        AND     p30.bentyp      LIKE 'INV%'
        AND     p10.prdref      =    'RS-PP'
        AND     p10.stapol      =    30
        AND     p10.polref      =    pcn_policy_reference
        AND    add_months(TO_DATE('01/01/1900', 'DD/MM/YYYY') + c.bthdte,900) <= TO_DATE('01/01/1900', 'DD/MM/YYYY') + p30.pymenddte;

        lr_75thdob_less_than_RC   cu_75thdob_less_than_RC%ROWTYPE;

    BEGIN

        pck_process_info.p_register_module(pv_module_name  => 'PCK_POLICY_EXCEPTIONS'
                                          ,pv_action_name  => 'P_AGE75_LESS_THAN_RC_END_DATE');

        OPEN  cu_75thdob_less_than_RC(pcn_policy_reference => pn_policy_reference);
        FETCH cu_75thdob_less_than_RC INTO lr_75thdob_less_than_RC;
        IF cu_75thdob_less_than_RC%FOUND THEN
            p_raise_exception(lr_75thdob_less_than_RC.policy_reference
                             ,172
                             ,lr_75thdob_less_than_RC.error_message
                             ,pv_product_type
                             );
        END IF;
        CLOSE cu_75thdob_less_than_RC;

    END p_age75_less_than_rc_end_date;


    -- %Description  Procedure to check if age 75 trigger fails to process
    PROCEDURE p_age75_trigger_fail(pn_policy_reference IN po010.polref%TYPE
                                  ,pv_product_type     IN pr010.prdref%TYPE)
    IS
        CURSOR cu_age_75_trigger(pcn_policy_reference IN po010.polref%TYPE)
        IS
            SELECT p10.polref             policy_reference,
                   'Age 75 Trigger failed for : ' ||'~'||
                   ' Policy reference : ' || p10.polref || '~' ||
                   ' Product reference : ' || p10.prdref ||'~' ||
                   ' Actref : ' || p100.actref ||'~' ||
                   ' Status : ' || p100.sta  error_message
            FROM  po010 p10
                 ,po100 p100
            WHERE p10.polref = p100.polref
            AND  p10.maint != 'D'
            AND  p10.prdref = 'RS-PP'
            AND  p100.actref = 'AGE_75'
            AND  p100.sta    = 75
            AND  p10.polref  = pcn_policy_reference
            AND  p10.stapol IN (30,52);

        lr_age_75_trigger         cu_age_75_trigger%ROWTYPE;

    BEGIN
        pck_process_info.p_register_module(pv_module_name  => 'PCK_POLICY_EXCEPTIONS'
                                          ,pv_action_name  => 'P_AGE75_TRIGGER_FAIL');

        OPEN  cu_age_75_trigger(pcn_policy_reference => pn_policy_reference);
        FETCH cu_age_75_trigger INTO lr_age_75_trigger;
        IF cu_age_75_trigger%FOUND THEN
            p_raise_exception(lr_age_75_trigger.policy_reference
                             ,173
                             ,lr_age_75_trigger.error_message
                             ,pv_product_type
                             );
        END IF;
        CLOSE  cu_age_75_trigger;

    END p_age75_trigger_fail;

    /*===========================================================================================
    Procedure p_psa_UDCTL_check
    -- Checks if there is an outstanding PSA trigger in UDCTL
    -- %param pn_policy_reference IN pa020.polref%TYPE
    -- %param pv_product_type     IN po010.prdref%TYPE
    -- %param pn_renewal_date     IN pa021.rnwdte%TYPE
    -- If updating this cursor then update bulk level code
    ==========================================================================================*/
    PROCEDURE p_psa_UDCTL_check (pn_policy_reference IN pa020.polref%TYPE
                                ,pv_product_type     IN po010.prdref%TYPE
                                ,pn_renewal_date     IN pa021.rnwdte%TYPE)
    IS

        CURSOR cu_psa_UDCTL_check(pcn_policy_reference  pa020.polref%TYPE
                                 ,pcn_renewal_date      pa021.rnwdte%TYPE)
        IS
        SELECT '~Policy: ' || pa.polref ||
               '~ Effective date: ' || to_date(to_char(pa.efvdte + 2415021),'J') ||
               '~ Trigger Status: ' || pa.sta_pa ||
               '~ Transaction Control No: ' || pa.trnctl_no error_message
        FROM   pa020 pa
        WHERE  pa.polref    = pcn_policy_reference
        AND    pa.fndtrntyp = 'PSA'
        AND    pa.maint    <> 'D'
        AND    pa.sta_pa   IN (30, 5)
        AND    pa.efvdte    < pcn_renewal_date;

    BEGIN

        pck_process_info.p_set_action('p_psa_UDCTL_check');

        FOR idx IN cu_psa_UDCTL_check(pcn_policy_reference => pn_policy_reference
                                     ,pcn_renewal_date     => pn_renewal_date)
        LOOP
                 --Raise exception 904
                 p_raise_exception(pn_policy_number    => pn_policy_reference
                                  ,pn_exception_number => 904
                                  ,pv_error_message    => idx.error_message
                                  ,pv_product_type     => pv_product_type);
        END LOOP;

    END p_psa_UDCTL_check;

    /********************************************************************************************
    -- %Description Procedure to check if policy has uplifted but still shows entitlement as
    --               other than 'T' and vice versa
    -- %param       pn_policy_number  IN pa020.polref%TYPE
    -- %param       pv_product_type   IN po010.prdref%TYPE
    -- %raises      Exception 908
    *********************************************************************************************/
    PROCEDURE p_GAR_UPL_mismatch (pn_policy_number  IN pa020.polref%TYPE
                                 ,pv_product_type   IN po010.prdref%TYPE)
    IS
        CURSOR cu_UPL_GAR_check(pcn_policy_number IN pa020.polref%TYPE)
        IS
            SELECT '~Policy: '                  || pa.polref ||
                   '~ Effective date: '         || to_date(to_char(pa.efvdte + 2415021),'J') ||
                   '~ Trigger Status: '         || pa.sta_pa ||
                   '~ Transaction Control No: ' || pa.trnctl_no ||
                   '~ Entitlement: '            || gar.entitlement error_message
            FROM   pa020   pa
                  ,guaranteed_ann_pol_dets  gar
            WHERE  pa.polref             = pcn_policy_number
            AND    gar.policy_reference  = pa.polref
            AND    pa.fndtrntyp          = 'UPL'
            AND    pa.maint             <> 'D'
            AND    pa.efvdte            <= lpn_system_date
            AND  ((pa.sta_pa = 50 AND gar.entitlement != 'T') OR
                  (pa.sta_pa != 50 AND gar.entitlement = 'T'))

            UNION ALL

            SELECT '~Policy: '                  || gar.policy_reference ||
                   '~ Entitlement: '            || gar.entitlement error_message
            FROM   guaranteed_ann_pol_dets gar
            WHERE  gar.policy_reference = pcn_policy_number
            AND    gar.entitlement      = 'T'
            AND    gar.policy_reference NOT IN (SELECT pa.polref
                                                FROM   pa020 pa
                                                WHERE  pa.polref    =  gar.policy_reference
                                                AND    pa.fndtrntyp =  'UPL');
    BEGIN
        pck_process_info.p_set_action('p_GAR_UPL_mismatch');

        FOR idx IN cu_UPL_GAR_check(pcn_policy_number => pn_policy_number)
        LOOP
			 --Raise exception 908
			 p_raise_exception(pn_policy_number    => pn_policy_number
							  ,pn_exception_number => 908
							  ,pv_error_message    => idx.error_message
							  ,pv_product_type     => pv_product_type);
        END LOOP;
    END p_GAR_UPL_mismatch;

END pck_policy_exceptions;
/
