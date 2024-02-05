CREATE OR REPLACE PACKAGE PROJECT_DEV_07.pck_commission AS
/*******************************************************************************************
 * File Name        :
 * Description      :
 * Author           :
 * Date             :
 * Version          : 0.1
 * Modification History :
 * Version        Date           Modified by    Brief Description of Modification
 * -----------------------------------------------------------------------------------------
 * $Log:   //vm1/PICCSDB/archives/life/database/headers/pck_commission.spc-arc  $
--
--   Rev 1.32   Jan 25 2017 14:46:08   SourceSafe
--Integrated version 1.31.1.0 from project LEGACY_AUDIT_IV
--
--   Rev 1.31.1.0   Jan 12 2017 10:57:28   SMMackinnon
--Make the weighted ord 1 start date public
--
--   Rev 1.31   Nov 24 2016 07:26:54   SourceSafe
--Integrated version 1.28.2.2 from project LEGACY_AUDIT_III
--
--   Rev 1.28.2.2   Sep 08 2016 17:43:54   SMMackinnon
--Added maturity date to f_remaining_term_pay_ic
--
--   Rev 1.28.2.1   Sep 07 2016 16:59:20   SMMackinnon
--Merge with v1.30
--
--   Rev 1.30   Sep 02 2016 13:25:58   SourceSafe
--Integrated version 1.29.1.0 from project LEGACY_AUDIT_II
--
--   Rev 1.29.1.0   Aug 12 2016 17:26:24   SMMackinnon
--New Branch for Legacy Audit 2 taken from V1.28.1.3
--
--   Rev 1.28.1.3   Aug 11 2016 12:18:48   ETiglao
--Changes to add a new parameter pn_valuation_date in p_increment_ic_proportion
--
--   Rev 1.28.1.2   Aug 08 2016 20:19:32   ETiglao
--Remove f_remaining_term_pay_ic as this will be implemented on phase 3
--
--   Rev 1.28.1.1   Aug 02 2016 10:58:16   ETiglao
--Rename p_increment_ic_remaining with p_increment_ic_proportion and add new changes
--
--   Rev 1.28.1.0   Jul 26 2016 12:39:44   ETiglao
--Changes to fix defect
--
--   Rev 1.28   Jun 29 2016 11:40:14   SourceSafe
--Integrated version 1.27.1.8 from project LEGACY_AUDIT_II
--
--   Rev 1.27.1.8   May 31 2016 10:44:48   ETiglao
--Minor changes on description on p _increment_ic_remaining (peer revier changes)
--
--   Rev 1.27.1.7   May 10 2016 10:10:08   ETiglao
--Remove f_initial_commission_recouped as this is no longer needed
--
--   Rev 1.27.1.6   May 06 2016 14:34:42   ETiglao
--Minor changes on the description
--
--   Rev 1.27.1.5   May 06 2016 13:42:16   ETiglao
--Changes to add extra 2 input parameters on p_initial_commission_recouped
--
--   Rev 1.27.1.4   Apr 26 2016 16:38:54   ETiglao
--Additional changes on p_initial_commission_recouped and f_initial_commission_recouped
--
--   Rev 1.27.1.3   Mar 07 2016 11:52:28   ETiglao
--Add back p_initial_commission_recouped and f_initial_commission_recouped.  Remove f_value_for_money_efv_date as this is no longer needed.
--
--   Rev 1.27.1.2   Jan 12 2016 12:12:08   ETiglao
--Remove p_initial_commission_recouped, f_initial_commisison_recouped and p_pup_and_paid_premium_terms as these will not be included on April 2016 shipment
--
--   Rev 1.27.1.1   Dec 30 2015 17:24:32   ETiglao
--Add f_value_for_money_efv_date and remove input pv_exit_ind in p_initial_commission_recouped as this is no longer needed
--
--   Rev 1.27.1.0   Dec 14 2015 17:24:22   ETiglao
--Add f_initial_commission_recouped and p_initial_commission_recouped
--
--   Rev 1.27   Dec 07 2015 15:16:38   SourceSafe
--Integrated version 1.26.1.11 from project COMMISSION_SWITCH_OFF
--
--   Rev 1.26.1.11   Nov 30 2015 17:25:16   rhegganni
--Minor tidy up
--
--   Rev 1.26.1.10   Nov 03 2015 12:46:58   SASOPA
--Added a procedure p_update_comm_switch_off
--
--   Rev 1.26.1.9   Oct 22 2015 11:18:54   HKODE
--dummy
--
--   Rev 1.26.1.7   Sep 03 2015 12:30:10   HKODE
--Added out parameter to p_commission_switch_off_date
--
--   Rev 1.26.1.6   Aug 05 2015 07:41:02   PJayaraj
--Alignment changes
--
--   Rev 1.26.1.5   Jul 29 2015 14:08:36   HKODE
--alignment
--
--   Rev 1.26.1.4   Jul 23 2015 10:29:36   PJayaraj
--Added a function f_commission_switch_off
--
--   Rev 1.26.1.3   Jul 21 2015 13:10:34   HKODE
--Overloading procedure for p_update_switch_off_date
--
--   Rev 1.26.1.2   Jul 17 2015 08:22:18   HKODE
--Update of nil commission
--
--   Rev 1.26.1.1   Jul 06 2015 08:30:48   HKODE
--changed input parameter datatype
--
--   Rev 1.26.1.0   Jul 02 2015 06:58:56   PJayaraj
--Added p_commission_switch_off_date and p_update_switch_off_date
--
--   Rev 1.26   May 19 2014 13:42:52   SourceSafe
--Integrated version 1.25.1.1 from project RDR_SALES_MAINTENANCE_II
--
--   Rev 1.25.1.1   May 06 2014 18:41:56   RRajagopla1
--Comments fixed.
--
--   Rev 1.25.1.0   May 06 2014 14:06:50   RRajagopla1
--Added p_update_cm240_status and p_update_cm640_status.
--
--   Rev 1.25   Nov 07 2012 13:04:04   SourceSafe
--Integrated version 1.24.1.1 from project RDR_UNIT_PROCESSING
--
--   Rev 1.24.1.1   Nov 07 2012 08:10:42   KLWilson
--Change new procedure names after peer review.
--
--   Rev 1.24.1.0   Nov 06 2012 15:22:54   KLWilson
--Add 2 new procedures p_update_cm240 and p_update_cm200
--
--   Rev 1.24   Aug 23 2012 13:06:24   SourceSafe
--Integrated version 1.23.3.0 from project RDR_ILLUSTRATIONS
--
--   Rev 1.23.3.0   Aug 15 2012 11:30:28   ETiglao
--Add a new input parameter pv_ac_cc_case on p_commission_rate_type
--
--   Rev 1.23   May 06 2011 14:00:26   SourceSafe
--Integrated version 1.22.1.0 from project THUNDERHEAD
--
--   Rev 1.22.1.0   Dec 09 2010 12:01:10   dcarter
--Added parameter to get the IFA split payment details to switch from rounding down or up.
--
--   Rev 1.22   Jul 23 2010 17:04:46   SourceSafe
--Integrated version 1.21.1.0 from project TV_INS
--
--   Rev 1.21.1.0   May 28 2010 12:15:16   KLWilson
--Overloaded version of p_get_tv_amc added.
--
--   Rev 1.21   Sep 09 2009 10:21:58   ACOOK
--Updated commission_rate_type to a procedure to return to commission rate types, one for KAE cals and one for AMC calcs.
--
--   Rev 1.20   Aug 07 2009 11:26:42   averri
--New function to return maximum FAF amount for NIPP increments.
--
--   Rev 1.19   Jun 30 2009 15:17:46   averri
--Reinstated new procedure p_get_tv_amc again - this time on a separate distribution so it can be taken to UAT with other RS New Entrants changes.
--
--   Rev 1.17   Jun 29 2009 15:01:50   averri
--Reinstated p_get_tv_amc.
--
--   Rev 1.16   Jun 29 2009 10:30:44   averri
--Back out new procedure p_get_tv_amc.
--
--   Rev 1.15   Jun 26 2009 15:18:50   beastell
--Added procedure p_get_tv_amc.
--
--   Rev 1.14   Jun 03 2009 11:54:58   cmleckie
--Add new public function- f_check_commission_feature
--
--   Rev 1.13   May 28 2009 10:49:14   averri
--Default new input fields to 0 in p_validate_amc.
--
--   Rev 1.12   May 22 2009 14:57:34   averri
--Deduct any AMC adjustment and key account enhancements from total AMC cost in p_validate_AMC.
--
--   Rev 1.11   Mar 20 2009 17:13:44   rmackenzie
--moved p_validate_amc from web_commission to pck_commission. Created wrapper in web_commission in order to call the procedure in pck_commission
--
--   Rev 1.10   Mar 17 2009 08:44:16   averri
--Added new function and procedures for PP Reprice - one to split commission into first and subsequent monthly payments, and another to determine the commission rate type.
--
--   Rev 1.9   Feb 26 2009 11:10:34   KLWilson
--2 new functions added to determine whether a transaction being processed is event faf.
--
--   Rev 1.8   Feb 16 2009 12:05:20   smathew
--Add new procedure p_update_csn_movements
--
--   Rev 1.7   Jan 21 2009 04:54:40   nkamath
--Added procedure f_ceh_record_exists to check for record in commission_event_headers.
--
--   Rev 1.6   Dec 12 2008 12:46:52   smmackinnon
--Income release event faf - update plsql doc comments with effective date
--
--   Rev 1.4   Dec 01 2008 06:47:54   nkamath
--Added procedure p_get_faf_details to read the commission details from cm420.
--
--   Rev 1.3   Nov 26 2008 09:21:50   nkamath
--Added procedure to read commission amount/percentage from commission_event_headers.
--
--   Rev 1.2   Oct 27 2008 11:44:58   smmackinnon
--Added procedures for inserting and updating commission_event_headers record
--
--   Rev 1.1   Feb 19 2008 11:46:10   sgodfrey
--Changed r_commission to gr_commission
--
--   Rev 1.0   Feb 11 2008 14:46:50   sgodfrey
--Initial revision.
 ********************************************************************************************/

    SUBTYPE gr_commission IS cm240%ROWTYPE;


    TYPE r_remaining_years_pay_ic IS RECORD
        (increment_reference      po020.inrref%TYPE
        ,initial_csn_exist        VARCHAR2(1)
        ,remaining_yrs_pay_ic     NUMBER(10,4)
        );

    TYPE t_remaining_years_pay_ic IS TABLE OF r_remaining_years_pay_ic INDEX BY PLS_INTEGER;

    /**************************************************************************************
    -- <BR>
    -- %param pr_commission IN r_commission
    -- %param pb_throw_exception IN BOOLEAN := TRUE
     **************************************************************************************/
    PROCEDURE p_insert_commission(pr_commission      IN gr_commission
                                 ,pb_throw_exception IN BOOLEAN := TRUE);

    /**************************************************************************************
    -- <BR> procedure to insert commission_event_headers record
    -- %param pr_commission_event_headers IN commission_event_headers%ROWTYPE
    -- %raises Exception for DUP_VAL_ON_INDEX and OTHERS
     **************************************************************************************/
    PROCEDURE p_insert_csn_event_headers(pr_commission_event_headers IN commission_event_headers%ROWTYPE);

    /**************************************************************************************
    -- <BR> procedure to update transaction_control on commission_event_headers
    -- %param pn_policy_reference IN commission_event_headers.policy_reference%TYPE
    -- %param pn_event_type       IN commission_event_headers.event_type%TYPE
    -- %param pd_effective_date   IN commission_event_headers.effective_date%TYPE
    -- %param pn_trnctl_no        IN commission_event_headers.transaction_control%TYPE
    -- %param pb_success_flag     OUT BOOLEAN
    -- %raises Exception for WHEN OTHERS
     **************************************************************************************/
    PROCEDURE p_update_ceh_trnctl(pn_policy_reference IN commission_event_headers.policy_reference%TYPE
                                 ,pn_event_type       IN commission_event_headers.event_type%TYPE
                                 ,pd_effective_date   IN commission_event_headers.effective_date%TYPE
                                 ,pn_trnctl_no        IN commission_event_headers.transaction_control%TYPE
                                 ,pb_success_flag     OUT BOOLEAN);

    /**************************************************************************************
    -- <BR> procedure to update the status on commission_event_headers
    -- %param pn_policy_reference IN commission_event_headers.policy_reference%TYPE
    -- %param pn_trnctl_no        IN commission_event_headers.transaction_control%TYPE
    -- %param pn_status           IN commission_event_headers.status%TYPE
    -- %param pb_success_flag     OUT BOOLEAN
    -- %raises Exception for WHEN OTHERS
     **************************************************************************************/
    PROCEDURE p_update_ceh_status(pn_policy_reference IN commission_event_headers.policy_reference%TYPE
                                 ,pn_trnctl_no        IN commission_event_headers.transaction_control%TYPE
                                 ,pv_status           IN commission_event_headers.status%TYPE
                                 ,pb_success_flag     OUT BOOLEAN);

    /*******************************************************************************
    -- %Description Fetches the commission event amount and percentage from commission_event_headers
    -- %param pn_policy_reference      IN  commission_event_headers.policy_reference%TYPE
    -- %param pn_event_type            IN  commission_event_headers.event_type%TYPE
    -- %param pd_effective_date        IN  commission_event_headers.effective_date%TYPE
    -- %param pn_commission_amount     OUT commission_event_headers.amount%TYPE
    -- %param pn_commission_percentage OUT commission_event_headers.percentage%TYPE
    *******************************************************************************/
    PROCEDURE p_get_commission_event_values (pn_policy_reference      IN  commission_event_headers.policy_reference%TYPE
                                            ,pn_event_type            IN  commission_event_headers.event_type%TYPE
                                            ,pd_effective_date        IN  commission_event_headers.effective_date%TYPE
                                            ,pn_commission_amount     OUT commission_event_headers.amount%TYPE
                                            ,pn_commission_percentage OUT commission_event_headers.percentage%TYPE);

    /*******************************************************************************
    -- %Description Procedure to get the FAF commission amount and percentage.
    -- %param pn_policy_reference    IN  cm420.polref%TYPE
    -- %param pv_increment_type      IN  cm420.inrtyp%TYPE
    -- %param pn_increment_reference IN  cm420.inrref%TYPE
    -- %param pn_commission_amt      OUT cm420.csnamt%TYPE
    -- %param pn_commission_pct      OUT cm420.commission_pct%TYPE
    *******************************************************************************/
    PROCEDURE p_get_faf_details (pn_policy_reference    IN  cm420.polref%TYPE
                                ,pv_increment_type      IN  cm420.inrtyp%TYPE
                                ,pn_increment_reference IN  cm420.inrref%TYPE
                                ,pn_commission_amt      OUT cm420.csnamt%TYPE
                                ,pn_commission_pct      OUT cm420.commission_pct%TYPE);

    /**************************************************************************************
    -- Checks whether a commission event header record exists.
    -- %param  pn_policy_reference IN po010.polref%TYPE
    -- %param  pd_effective_date   IN commission_event_headers.effective_date%TYPE
    -- %param  pv_status           IN commission_event_headers.status%TYPE
    -- %return BOOLEAN
    **************************************************************************************/
    FUNCTION f_ceh_record_exists(pn_policy_reference IN po010.polref %TYPE
                                ,pd_effective_date   IN commission_event_headers.effective_date%TYPE
                                ,pv_status           IN commission_event_headers.status%TYPE)
    RETURN BOOLEAN;

    /**************************************************************************************
    -- Update the unq and trn_no of the commission movements
    -- %param  pn_policy_reference  IN  cm240.polref%TYPE
    -- %param  pn_old_event_unique  IN  cm240.unq%TYPE
    -- %param  pn_old_event_trn_no  IN  cm240.trn_no%TYPE
    -- %param  pn_new_event_unique  IN  cm240.unq%TYPE
    -- %param  pn_new_event_trn_no  IN  cm240.trn_no%TYPE
    -- %param  pr_audits            IN  pck_audits.rec_audits
    -- %param  pb_success_flag      OUT BOOLEAN
    **************************************************************************************/
    PROCEDURE p_update_csn_movements(pn_policy_reference  IN  cm240.polref%TYPE
                                    ,pn_old_event_unique  IN  cm240.unq%TYPE
                                    ,pn_old_event_trn_no  IN  cm240.trn_no%TYPE
                                    ,pn_new_event_unique  IN  cm240.unq%TYPE
                                    ,pn_new_event_trn_no  IN  cm240.trn_no%TYPE
                                    ,pr_audits            IN  pck_audits.rec_audits
                                    ,pb_success_flag      OUT BOOLEAN
                                    );

     /**************************************************************************************
    -- Checks whether a commission event header record exists for input policy and trans no.
    -- %param  pn_policy_reference IN commission_event_headers.policy_reference%TYPE
    -- %param  pn_transaction_control IN commission_event_headers.transaction_control%TYPE
    -- %return BOOLEAN
    **************************************************************************************/

    FUNCTION f_check_for_event_faf(pn_policy_reference    IN commission_event_headers.policy_reference%TYPE
                                  ,pn_transaction_control IN commission_event_headers.transaction_control%TYPE)
    RETURN BOOLEAN;

    /*******************************************************************************
    -- %Description Function that is called to determine whether this is an Event
    --              FAF transaction that is being processed
    -- %param  pn_policy_reference IN FI700.polref%TYPE
    -- %param  pn_eff_date         IN fi700.efvdte%TYPE
    -- %param  pv_fund_trans_type  IN fi700.fndtrntyp%TYPE
    -- %param  pn_unique           IN fi700.evtunq%TYPE
    -- %param  pn_tranno           IN fi700.evttrn_no%TYPE
    -- %return BOOLEAN
    *******************************************************************************/

    FUNCTION f_check_for_event_faf  (pn_policy_reference IN FI700.polref%TYPE
                                    ,pn_eff_date         IN fi700.efvdte%TYPE
                                    ,pv_fund_trans_type  IN fi700.fndtrntyp%TYPE
                                    ,pn_unique           IN fi700.evtunq%TYPE
                                    ,pn_tranno           IN fi700.evttrn_no%TYPE)
    RETURN BOOLEAN;

    /*******************************************************************************
    -- %Description Procedure p_split_IFA_payments
    -- Given a payment amount, and number of payments the procedure will calculate how
    -- much should be paid in the first payment to ensure that equal payments are
    -- received for the remaining payments. The parameter pb_round_pymt_down is
    -- used to detemine if the amount is rounded down or up. It's defaulted to round up.
    -- %param   pn_payment_amount       IN  NUMBER
    -- %param   pn_payment_term         IN  NUMBER
    -- %param   pb_round_pymt_down      IN  BOOLEAN DEFAULT FALSE
    -- %param   pn_first_amount         OUT NUMBER
    -- %param   pn_other_amounts        OUT NUMBER
    -- %param   pv_all_payments_equal   OUT VARCHAR2
    -- %param   pn_count_other_payments OUT NUMBER
    *******************************************************************************/
    PROCEDURE p_split_IFA_payments  (pn_payment_amount       IN  NUMBER
                                    ,pn_payment_term         IN  NUMBER
                                    ,pb_round_pymt_down      IN  BOOLEAN DEFAULT FALSE
                                    ,pn_first_amount         OUT NUMBER
                                    ,pn_other_amounts        OUT NUMBER
                                    ,pv_all_payments_equal   OUT VARCHAR2
                                    ,pn_count_other_payments OUT NUMBER);

    /********************************************************************************************
    -- %Description function f_check_commission_feature
    -- Based on the input policy and feature, determine whether commission feature is switched on
    -- C = extra clawback, F- FAF
    -- %param   pn_policy_reference      IN po020.inrtyp%TYPE
    -- %param   pv_commission_feature      IN VARCHAR2
    -- %return  lb_feature_on             BOOLEAN
    *********************************************************************************************/

        FUNCTION f_check_commission_feature (pn_policy_reference     IN po010.polref%TYPE
                                        ,pv_commission_feature     IN VARCHAR2)
                                          RETURN BOOLEAN;

    /*******************************************************************************
    -- %Description   Based on the types of commission selected, determine the
    --                commission rate type
    -- %param         pv_increment_type            IN   po020.inrtyp%TYPE
    -- %param         pn_ic_csn                    IN   NUMBER
    -- %param         pn_rc_csn                    IN   NUMBER
    -- %param         pn_lc_csn                    IN   NUMBER
    -- %param         pn_fbrc_csn                  IN   NUMBER
    -- %param         pn_faf                       IN   NUMBER
    -- %param         pv_ac_cc_case                IN   VARCHAR2 DEFAULT 'N'
    -- %param         pn_commission_rate_type_kae  OUT  NUMBER
    -- %param         pn_commission_rate_type_amc  OUT  NUMBER)
    *******************************************************************************/
    PROCEDURE p_commission_rate_type (pv_increment_type            IN   po020.inrtyp%TYPE
                                     ,pn_ic_csn                    IN   NUMBER
                                     ,pn_rc_csn                    IN   NUMBER
                                     ,pn_lc_csn                    IN   NUMBER
                                     ,pn_fbrc_csn                  IN   NUMBER
                                     ,pn_faf                       IN   NUMBER
                                     ,pv_ac_cc_case                IN   VARCHAR2 DEFAULT 'N'
                                     ,pn_commission_rate_type_kae  OUT  NUMBER
                                     ,pn_commission_rate_type_amc  OUT  NUMBER);

    /*******************************************************************************
    -- %Description Validate whether the selected commission rates are valid.
    --              Checks to ensure the amc does not go above the maximum allowed.
    --              No validation is performed on whether the values for commission
    --              passed in are with amounts allowed. This is currently done on the web by
    --              EService/NIPP/Scripts/InputScreens/Commission.js
    --              This code simply checks the amc that will be used based on the commission
    --              levels passed in
    -- %param pn_itr_number               cl010.cliref%TYPE
    -- %param pv_product_reference        pr010.prdref%TYPE
    -- %param pn_product_version          pr010.prdvrs_no%TYPE
    -- %param pv_payment_type             VARCHAR2 - RP (regular premium), TV(transfer value), SP(single premium)
    --                                    ,RPAVC (regular avcs), DSS. No distinction is made for AVC single payments
    -- %param pd_currency_date            DATE
    -- %param pn_commission_type          NUMBER
    --                                          ICRC    = 1
    --                                          LC      = 2
    --                                          SP      = 3
    --                                          SPFBRC  = 4
    --                                          NC      = 6
    --                                          ICFBRC  = 7
    --                                          LCFBRC  = 8
    --                                          ???     = 9
    --                                          FE      = 10
    --                                          FEFBRC  = 11
    -- %param pn_level_single_commission  NUMBER
    -- %param pn_renewal_commission       NUMBER
    -- %param pn_initial_commission_rate  NUMBER
    -- %param pn_fbr_commission           NUMBER                fund based renewal commission
    -- %param pv_fbrc_applies             VARCHAR2              Y or N
    -- %param pv_pr_vesting_year          gla.gl_cnrout_yr%TYPE In format YY
    -- %param pn_term_to_65               gll.gl_trmdec_65%TYPE
    -- %param pd_increment_maturity       DATE
    -- %param pv_valid_amc                VARCHAR2              Will return Y/N or NULL if an error occurs
    -- %raise LOGIC_ERROR if an error occurs in the migrated logic that is called
    *******************************************************************************/
    PROCEDURE p_validate_amc(pn_itr_number              IN  cl010.cliref%TYPE
                            ,pv_product_reference       IN  pr010.prdref%TYPE
                            ,pn_product_version         IN  pr010.prdvrs_no%TYPE
                            ,pv_payment_type            IN  VARCHAR2
                            ,pd_currency_date           IN  DATE
                            ,pn_commission_type         IN  NUMBER
                            ,pn_level_single_commission IN  NUMBER
                            ,pn_renewal_commission      IN  NUMBER
                            ,pn_initial_commission_rate IN  NUMBER
                            ,pn_fbr_commission          IN  NUMBER
                            ,pv_fbrc_applies            IN  VARCHAR2
                            ,pv_pr_vesting_year         IN  gla.gl_cnrout_yr%TYPE
                            ,pn_term_to_65              IN  gll.gl_trmdec_65%TYPE
                            ,pd_increment_maturity      IN  DATE
                            ,pn_amc_adjustment            IN  NUMBER    DEFAULT 0
                            ,pn_key_account_enhancement    IN  NUMBER    DEFAULT 0
                            ,pv_valid_amc               OUT VARCHAR2);

    /*******************************************************************************
    -- %Description        Procedure p_get_tv_amc
    --                     Calculates TV AMC called from the web to remove technical
    --                     debt/remove hard-coding.
    --                     Also allows for new parameter GL_PRDRGBAS.
    -- %param pn_scheme_reference         sc010.schref%TYPE      Scheme Reference
    -- %param pv_scheme_category          sc010.schcat%TYPE      Scheme Category
    -- %param pn_policy_reference         po010.polref%TYPE      Policy Reference
    -- %param pv_product_reference        pr010.prdref%TYPE      Product Reference
    -- %param pn_product_version          pr010.prdvrs_no%TYPE   Product Version
    -- %param pd_currency_date            DATE                   Currency Date
    -- %param pd_increment_maturity       DATE                   Increment Maturity Date
    -- %param pn_sp_rate                  NUMBER                 Initial Commission Rate
    -- %param pn_fbr_commission           NUMBER                 FBRC Commission Rate
    -- %param pn_term_to_65               gll.gl_trmdec_65%TYPE  Term to 65
    -- %param pn_tv_amc                   NUMBER                 TV AMC Amount
    *******************************************************************************/
    PROCEDURE p_get_tv_amc(pn_scheme_reference      IN  sc010.schref%TYPE
                          ,pv_scheme_category       IN  sc010.schcat%TYPE
                          ,pn_policy_reference      IN  po010.polref%TYPE
                          ,pv_product_reference     IN  pr010.prdref%TYPE
                          ,pn_product_version       IN  pr010.prdvrs_no%TYPE
                          ,pd_currency_date         IN  DATE
                          ,pd_increment_maturity    IN  DATE
                          ,pn_sp_rate               IN  NUMBER
                          ,pn_fbr_commission        IN  NUMBER
                          ,pn_term_to_65            IN  gll.gl_trmdec_65%TYPE
                          ,pn_tv_amc                OUT NUMBER);

    /**************************************************************************************
    -- Procedure name    : p_get_tv_amc
    -- Description       : Procedure to calculate TV AMC.  Called from pck_group_tvs_in
    -- Parameters        :
    -- pn_scheme_reference         IN   sc010.schref%TYPE      Scheme Reference
    -- pv_scheme_category          IN   sc010.schcat%TYPE      Scheme Category
    -- pn_policy_reference         IN   po010.polref%TYPE      Policy Reference
    -- pv_product_reference        IN   pr010.prdref%TYPE      Product Reference
    -- pn_product_version          IN   pr010.prdvrs_no%TYPE   Product Version
    -- pd_currency_date            IN   DATE                   Currency Date
    -- pd_increment_maturity       IN   DATE                   Increment Maturity Date
    -- pn_sp_rate                  IN   NUMBER                 Initial Commission Rate
    -- pn_fbr_commission           IN   NUMBER                 FBRC Commission Rate
    -- pn_term_to_65               IN   gll.gl_trmdec_65%TYPE  Term to 65
    -- pn_tv_amc                   OUT  NUMBER                 TV AMC Amount
    -- pn_charge_adjustment_rate_4 OUT  gla.gl_crgadjrte4%TYPE Crgadjrte4 amount
    ****************************************************************************************/
    PROCEDURE p_get_tv_amc(pn_scheme_reference      IN  sc010.schref%TYPE
                          ,pv_scheme_category       IN  sc010.schcat%TYPE
                          ,pn_policy_reference      IN  po010.polref%TYPE
                          ,pv_product_reference     IN  pr010.prdref%TYPE
                          ,pn_product_version       IN  pr010.prdvrs_no%TYPE
                          ,pd_currency_date         IN  DATE
                          ,pd_increment_maturity    IN  DATE
                          ,pn_sp_rate               IN  NUMBER
                          ,pn_fbr_commission        IN  NUMBER
                          ,pn_term_to_65            IN  gll.gl_trmdec_65%TYPE
                          ,pn_tv_amc                OUT NUMBER
                          ,pn_charge_adjustment_rate_4  OUT gla.gl_crgadjrte4%TYPE);

    /*******************************************************************************
    -- %Description Function to return maximum amount of FAF allowed on NIPP incs
    -- %param         pv_product_reference     IN pr010.prdref%TYPE
                    pn_product_version         IN pr010.prdvrs_no%TYPE
                    pv_increment_type         IN pr020.inrtyp%TYPE
    -- %return         ln_maximum_FAF
    -- %raises        n/a
    *******************************************************************************/
    FUNCTION f_maximum_FAF_amount    (pv_product_reference     IN pr010.prdref%TYPE
                                    ,pn_product_version     IN pr010.prdvrs_no%TYPE
                                    ,pv_increment_type         IN pr020.inrtyp%TYPE)
                                    RETURN NUMBER;

    /*******************************************************************************
    -- %Description Update CM240 to have a new status depending on input params
    -- %param       pn_old_rec_status IN cm240.csnsta%TYPE
    -- %param       pn_new_rec_status IN cm240.csnsta%TYPE
    -- %param       pv_audaplcde      IN cm240.audaplcde%TYPE
    -- %param       pn_audstf_no      IN cm240.audstf_no%TYPE
    -- %raises        n/a
    *******************************************************************************/

    PROCEDURE p_update_cm240_status (pn_old_rec_status IN cm240.csnsta%TYPE
                                    ,pn_new_rec_status IN cm240.csnsta%TYPE
                                    ,pv_audaplcde      IN cm240.audaplcde%TYPE
                                    ,pn_audstf_no      IN cm240.audstf_no%TYPE);

    /*******************************************************************************
    -- %Description Update CM200 to have a new CSNSTSTYP depending on input params
    -- %param       pn_old_rec_type IN cm240.csnststyp%TYPE
    -- %param       pn_new_rec_type IN cm240.csnststyp%TYPE
    -- %param       pv_audaplcde    IN cm240.audaplcde%TYPE
    -- %param       pn_audstf_no    IN cm240.audstf_no%TYPE
    -- %raises        n/a
    *******************************************************************************/

    PROCEDURE p_update_cm200_csnststyp (pn_old_rec_type IN cm200.csnststyp%TYPE
                                       ,pn_new_rec_type IN cm200.csnststyp%TYPE
                                       ,pv_audaplcde    IN cm200.audaplcde%TYPE
                                       ,pn_audstf_no    IN cm200.audstf_no%TYPE);

    /*******************************************************************************
    -- %Description     Procedure to update the CM240 status for an ITR
    -- %param           pn_itr_no         IN cm240.itr_no%TYPE
    -- %param           pn_from_status    IN cm240.csnsta%TYPE
    -- %param           pn_to_status      IN cm240.csnsta%TYPE
    -- %param           pn_efvdte         IN cm240.efvdte%TYPE
    -- %param           pn_audit_staff_no IN cm240.audstf_no%TYPE
    -- %param           pv_audit_apl_code IN cm240.audaplcde%TYPE
    -- %raises          None
    *******************************************************************************/
    PROCEDURE p_update_cm240_status(pn_itr_no         IN cm240.itr_no%TYPE
                                   ,pn_from_status    IN cm240.csnsta%TYPE
                                   ,pn_to_status      IN cm240.csnsta%TYPE
                                   ,pn_efvdte         IN cm240.efvdte%TYPE
                                   ,pn_audit_staff_no IN cm240.audstf_no%TYPE
                                   ,pv_audit_apl_code IN cm240.audaplcde%TYPE);

    /*******************************************************************************
    -- %Description     Procedure to update the CM640 status for an ITR
    -- %param           pn_itr_no         IN cm640.itr_no%TYPE
    -- %param           pn_from_status    IN cm640.csnsta%TYPE
    -- %param           pn_to_status      IN cm640.csnsta%TYPE
    -- %param           pn_audit_staff_no IN cm240.audstf_no%TYPE
    -- %param           pv_audit_apl_code IN cm240.audaplcde%TYPE
    -- %raises          None
    *******************************************************************************/
    PROCEDURE p_update_cm640_status(pn_itr_no         IN cm640.itr_no%TYPE
                                   ,pn_from_status    IN cm640.csnsta%TYPE
                                   ,pn_to_status      IN cm640.csnsta%TYPE
                                   ,pn_audit_staff_no IN cm240.audstf_no%TYPE
                                   ,pv_audit_apl_code IN cm240.audaplcde%TYPE);

    /********************************************************************************************
    -- %Description     Procedure to retrieve commission switch off date
    -- %param           pn_scheme_reference      IN  commission_switch_off.scheme_reference%TYPE
    -- %param           pv_scheme_category       IN  commission_switch_off.scheme_category%TYPE
    -- %param           pd_comm_switch_off_date  OUT commission_switch_off.switch_off_date%TYPE
    -- %param           pn_status                OUT commission_switch_off.status%TYPE
    -- %raises          NONE
    *********************************************************************************************/
    PROCEDURE p_commission_switch_off_date (pn_scheme_reference            IN  commission_switch_off.scheme_reference%TYPE
                                           ,pv_scheme_category             IN  commission_switch_off.scheme_category%TYPE
                                           ,pd_commission_switch_off_date  OUT commission_switch_off.switch_off_date%TYPE
                                           ,pn_status                      OUT commission_switch_off.status%TYPE);

    /********************************************************************************************
    -- %Description     Overloaded procedure to retrieve commission switch off date for a policy
    -- %param           pn_policy_reference      IN  po010.polref%TYPE
    -- %param           pd_comm_switch_off_date  OUT commission_switch_off.switch_off_date%TYPE
    -- %raises          NONE
    *********************************************************************************************/
    PROCEDURE p_commission_switch_off_date (pn_policy_reference            IN  po010.polref%TYPE
                                           ,pd_commission_switch_off_date  OUT commission_switch_off.switch_off_date%TYPE);

    /********************************************************************************************
    -- %Description     Procedure to update commission switch off date for CPS
    -- %param           pn_scheme_reference     IN  commission_switch_off.scheme_reference%TYPE
    -- %param           pv_scheme_category      IN  commission_switch_off.scheme_category%TYPE
    -- %param           pn_switch_off_date      IN  NUMBER
    -- %raises          WHEN OTHERS
    *********************************************************************************************/
    PROCEDURE p_update_cps_switch_off_date (pn_scheme_reference  IN  commission_switch_off.scheme_reference%TYPE
                                           ,pv_scheme_category   IN  commission_switch_off.scheme_category%TYPE
                                           ,pn_switch_off_date   IN  NUMBER);

    /********************************************************************************************
    -- %Description     Procedure to insert or update into commission switch off table
    -- %param           pv_scheme_category      IN  commission_switch_off.scheme_category%TYPE
    -- %param           pn_scheme_reference     IN  commission_switch_off.scheme_reference%TYPE
    -- %param           pn_status               IN  commission_switch_off.status%TYPE DEFAULT 30
    -- %param           pd_switch_off_date      IN  commission_switch_off.switch_off_date%TYPE
    -- %raises          WHEN OTHERS
    *********************************************************************************************/
    PROCEDURE p_update_comm_switch_off (pv_scheme_category      IN  commission_switch_off.scheme_category%TYPE
                                       ,pn_scheme_reference     IN  commission_switch_off.scheme_reference%TYPE
                                       ,pn_status               IN  commission_switch_off.status%TYPE  DEFAULT 30
                                       ,pd_switch_off_date      IN  commission_switch_off.switch_off_date%TYPE);

    /*************************************************************************************************
    -- %Description     Procedure to update commission switch off date, called from Change details
    -- %param           pn_scheme_reference     IN  commission_switch_off.scheme_reference%TYPE
    -- %param           pv_scheme_category      IN  commission_switch_off.scheme_category%TYPE
    -- %param           pv_switch_off_date      IN  VARCHAR2
    -- %param           pv_switch_off_date_chg  IN  VARCHAR2
    -- %raises          WHEN OTHERS
    **************************************************************************************************/
    PROCEDURE p_update_switch_off_date (pn_scheme_reference     IN  commission_switch_off.scheme_reference%TYPE
                                       ,pv_scheme_category      IN  commission_switch_off.scheme_category%TYPE
                                       ,pv_switch_off_date      IN  VARCHAR2
                                       ,pv_switch_off_date_chg  IN  VARCHAR2);

    /********************************************************************************************
    -- %Description     Procedure to update scheme to Nil Commission
    -- %raises          none
    *********************************************************************************************/
    PROCEDURE p_upd_scheme_to_nil_commission;

    /********************************************************************************************
    -- %Description     Retrieve commission switch off date
    -- %param           pn_schref      IN  commission_switch_off.scheme_reference%TYPE DEFAULT NULL
    -- %param           pv_schcat      IN  commission_switch_off.scheme_category%TYPE DEFAULT NULL
    -- %param           pn_polref      IN  po010.polref%TYPE DEFAULT NULL
    -- %return          NUMBER
    *********************************************************************************************/
    FUNCTION f_commission_switch_off_date (pn_schref  IN  commission_switch_off.scheme_reference%TYPE DEFAULT NULL
                                          ,pv_schcat  IN  commission_switch_off.scheme_category%TYPE DEFAULT NULL
                                          ,pn_polref  IN  po010.polref%TYPE DEFAULT NULL)
    RETURN NUMBER;

    /********************************************************************************************
    -- %Description     Calculate the weighted date for CPS ORD1
    -- %param           pn_policy_reference IN po010.polref%TYPE
    -- %param           pn_valuation_date   IN hi020.strdte%TYPE
    -- %return          DATE
    *********************************************************************************************/
    FUNCTION f_weighted_ord1_date(pn_policy_reference IN po010.polref%TYPE
                                 ,pn_valuation_date   IN hi020.strdte%TYPE)
    RETURN DATE;

    /*******************************************************************************
    -- %Description   get the remaining term to pay the initial commission in years.
    --                this will be called both on sqc via wrapper and pl/sql versions
    --                of pck_gpsucc
    -- %param         pn_policy_reference       IN   po010.polref%TYPE
    -- %param         pv_product_reference      IN   po010.prdref%TYPE
    -- %param         pn_valuation_date         IN   co060.strdte%TYPE
    -- %param         pn_maturity_date          IN   po030.matdte%TYPE
    -- %param         pv_increment_type         IN   po020.inrtyp%TYPE
    -- %param         pn_increment_reference    IN   po020.inrref%TYPE
    -- %return        NUMBER
    -- %raises        none
    *******************************************************************************/
    FUNCTION f_remaining_term_pay_ic(pn_policy_reference     IN  po010.polref%TYPE
                                    ,pv_product_reference    IN  po010.prdref%TYPE
                                    ,pn_valuation_date       IN  co060.strdte%TYPE
                                    ,pn_maturity_date        IN   po030.matdte%TYPE
                                    ,pv_increment_type       IN  po020.inrtyp%TYPE
                                    ,pn_increment_reference  IN  po020.inrref%TYPE)
    RETURN NUMBER;

    /*******************************************************************************
    -- %Description   check if the initial commission has been recouped and if it is
    --                then derive the proportion of the initial commission that needs
    --                to be paid. this will be called both on sqc via wrapper and pl/sql
    --                versions of pck_gps_sv
    -- %param         pn_policy_reference       IN   po010.polref%TYPE
    -- %param         pv_product_reference      IN   po010.prdref%TYPE
    -- %param         pn_valuation_date         IN   po020.inrcrcdte%TYPE
    -- %param         pv_increment_type         IN   po020.inrtyp%TYPE
    -- %param         pn_increment_reference    IN   po020.inrref%TYPE
    -- %param         pb_initial_csn_recouped   OUT  BOOLEAN
    -- %param         pn_initial_csn_proportn   OUT  NUMBER
    -- %raises        none
    *******************************************************************************/
    PROCEDURE p_increment_ic_proportion(pn_policy_reference       IN   po010.polref%TYPE
                                       ,pv_product_reference      IN   po010.prdref%TYPE
                                       ,pn_valuation_date         IN   po020.inrcrcdte%TYPE
                                       ,pv_increment_type         IN   po020.inrtyp%TYPE
                                       ,pn_increment_reference    IN   po020.inrref%TYPE
                                       ,pb_initial_csn_recouped   OUT  BOOLEAN
                                       ,pn_initial_csn_proportn   OUT  NUMBER);
END pck_commission;
/
CREATE OR REPLACE PACKAGE BODY PROJECT_DEV_07.pck_commission AS
/*******************************************************************************************
 * File Name        :
 * Description      :
 * Author           :
 * Date             :
 * Version          : 0.1
 * Modification History :
 * Version         Date          Modified by    Brief Description of Modification
 * -----------------------------------------------------------------------------------------
 * $Log:   //vm1/PICCSDB/archives/life/database/bodies/pck_commission.bdy-arc  $
--
--   Rev 1.53   Feb 01 2017 17:13:20   SourceSafe
--Integrated version 1.52.1.0 from project LEGACY_AUDIT_IV
--
--   Rev 1.52.1.0   Jan 31 2017 17:39:26   KLMCKENDRICK
--Fix for fund reduction on PUP'd policies with less than a year's premiums. Introduced in LE Phase 3, so exists in UCC code. Adding retrospectively to fund reduction.
--
--   Rev 1.52   Jan 25 2017 14:45:50   SourceSafe
--Integrated version 1.51.1.2 from project LEGACY_AUDIT_IV
--
--   Rev 1.51.1.2   Dec 22 2016 17:53:10   SMMackinnon
--Added in Admin fee to the premiums in the weighted date calculation
--
--   Rev 1.51.1.1   Dec 14 2016 14:28:46   SMMackinnon
--Find the last premium due date for CPS cases with no ORD premiums
--
--   Rev 1.51.1.0   Dec 12 2016 09:53:32   SMMackinnon
--Add extra cursor for IC exists check to cover ORD1 CPS increments
--
--   Rev 1.51   Nov 24 2016 07:26:20   SourceSafe
--Integrated version 1.48.2.9 from project LEGACY_AUDIT_III
--
--   Rev 1.48.2.9   Nov 08 2016 10:21:00   SMMackinnon
--Alter performance array indexes to be PLS_INTEGER
--
--   Rev 1.48.2.8   Oct 26 2016 17:08:46   SMMackinnon
--Move performance fix to pck_commission from aql_gpsucc and pck_cpsucc so that it is accessible from the SQC versions
--
--   Rev 1.48.2.7   Oct 05 2016 16:31:18   SMMackinnon
--Reinstate missing comments
--
--   Rev 1.48.2.6   Oct 05 2016 16:28:24   SMMackinnon
--Changes for code analysis tool
--
--   Rev 1.48.2.5   Oct 04 2016 13:29:36   SMMackinnon
--Changes for RVPs on CPS cases including weighted ORD1 start date
--
--   Rev 1.48.2.4   Sep 22 2016 17:10:56   SMMackinnon
--Simplify increment start date and move cursor to be local
--
--   Rev 1.48.2.3   Sep 14 2016 16:27:26   SMMackinnon
--Fix product refs in increment cursor and fix valuation date input in commission exist cursor
--
--   Rev 1.48.2.2   Sep 08 2016 17:43:18   SMMackinnon
--Added maturity date and removed rounding from f_remaining_term_pay_ic
--
--   Rev 1.48.2.1   Sep 07 2016 16:58:16   SMMackinnon
--merge with v1.50

--   Rev 1.50   Sep 02 2016 13:25:46   SourceSafe
--Integrated version 1.49.1.7 from project LEGACY_AUDIT_II
--
--   Rev 1.49.1.7   Aug 25 2016 10:11:24   SMMackinnon
--Change the rounding on ppt and put to use complete months
--
--   Rev 1.49.1.6   Aug 24 2016 11:11:18   SMMackinnon
--Remove some of the error handling added in v1.49.1.4
--
--   Rev 1.49.1.5   Aug 23 2016 14:59:00   SMMackinnon
--Remove rounding from Fund Reduction components and add MIN check on next premium due date when calculating pup term
--
--   Rev 1.49.1.4   Aug 22 2016 13:26:16   ETiglao
--Code review comment.
--
--   Rev 1.49.1.3   Aug 19 2016 13:18:12   ETiglao
--Changes to add a status of 52 on po020 cursor
--
--   Rev 1.49.1.2   Aug 18 2016 15:02:04   ETiglao
--Changes on the description of f_cancelled_increment
--
--   Rev 1.49.1.1   Aug 18 2016 14:28:30   ETiglao
--Issue exception when no premium payment or increment details exist for the rp increment
--
--   Rev 1.49.1.0   Aug 12 2016 17:14:46   SMMackinnon
--New Branch for Legacy Audit 2 taken from V1.48.1.9
--
--   Rev 1.48.1.9   Aug 12 2016 12:08:12   ETiglao
--Set the new parameter pn_valuation_date when calling pck_contributions.f_last_rp_premium_due_date
--
--   Rev 1.48.1.8   Aug 11 2016 12:18:00   ETiglao
--Changes to add a new parameter pn_valuation_date in p_increment_ic_proportion
--
--   Rev 1.48.1.7   Aug 08 2016 20:20:52   ETiglao
--Remove f_remaining_term_pay_ic as this will be implemented on phase 3
--
--   Rev 1.48.1.6   Aug 05 2016 13:01:10   ETiglao
--Changes to remove the derivation of gross premium as this will no longer be used as a condition not to derive the initial commission recouped indicator, remaining terms to pay ic and initial commission proportion
--
--   Rev 1.48.1.5   Aug 04 2016 11:00:34   ETiglao
--Additional changes
--
--   Rev 1.48.1.4   Aug 03 2016 22:38:54   ETiglao
--Changes on f_remaining_term_pay_ic to use ln_paid_up_term_yrs instead of  lr_increment_details.paid_up_term_yrs as this was moved to another local procedure
--
--   Rev 1.48.1.3   Aug 03 2016 14:28:02   ETiglao
--Additional changes to check that paid up date is not null in f_premium_payment_term_years
--
--   Rev 1.48.1.2   Aug 02 2016 10:54:16   ETiglao
--Rename p_increment_ic_remaining with p_increment_ic_proportion
--
--   Rev 1.48.1.1   Aug 02 2016 10:44:22   ETiglao
--Add f_remaining_term_pay_ic and additional changes to p_increment_ic_remaining
--
--   Rev 1.48.1.0   Jul 26 2016 12:43:50   ETiglao
--Changes to fix defect
--
--   Rev 1.48   Jun 29 2016 11:40:02   SourceSafe
--Integrated version 1.47.1.11 from project LEGACY_AUDIT_II
--
--   Rev 1.47.1.11   May 31 2016 10:39:08   ETiglao
--Minor changes on description (peer review changes)
--
--   Rev 1.47.1.10   May 11 2016 13:36:36   ETiglao
--Changes to call pck_policy_increment_details.f_first_rp_currency_date in p_pup_and_due_premium_terms
--
--   Rev 1.47.1.9   May 10 2016 17:37:22   ETiglao
--Additional changes
--
--   Rev 1.47.1.8   May 10 2016 10:07:40   ETiglao
--Remove f_initial_commission_recouped as this is no longer needed
--
--   Rev 1.47.1.7   May 06 2016 14:37:44   ETiglao
--Minor changes on description
--
--   Rev 1.47.1.6   May 06 2016 14:29:04   ETiglao
--Add p_increment_ic_remaining
--
--   Rev 1.47.1.5   Apr 26 2016 16:40:44   ETiglao
--Add p_initial_commission_remaining
--
--   Rev 1.47.1.4   Mar 07 2016 12:01:04   ETiglao
--Reverse changes made on 1.47.1.3 and remove f_value_for_money_effective_date  as this is no longer needed
--
--   Rev 1.47.1.3   Jan 12 2016 12:15:30   ETiglao
--Remove p_initial_commission_recouped, f_initial_commission_recouped and p_pup_and_paid_premium_terms as these will not be included on April 2016 shipment
--
--   Rev 1.47.1.2   Dec 30 2015 17:28:40   ETiglao
--Add f_value_for_money_effective_date and remove input pv_exit_ind in p_initial_commission_recouped
--
--   Rev 1.47.1.1   Dec 17 2015 15:46:36   ETiglao
--Changes to use the new procedure pck_policy_details.p_first_last_premium_paid_date
--
--   Rev 1.47.1.0   Dec 14 2015 17:22:36   ETiglao
--Add p_pup_and_paid_premium_terms, f_initial_commission_recouped and p_initial_commission_recouped
--
--   Rev 1.47   Dec 10 2015 16:51:20   SourceSafe
--Integrated version 1.46.1.0 from project COMMISSION_SWITCH_OFF
--
--   Rev 1.46.1.0   Dec 10 2015 16:31:42   rhegganni
--Changes while updating audit update id
--
--   Rev 1.46   Dec 07 2015 15:16:22   SourceSafe
--Integrated version 1.45.1.35 from project COMMISSION_SWITCH_OFF
--
--   Rev 1.45.1.35   Dec 04 2015 13:49:50   rhegganni
--Insert Nil Commission record for DSS
--
--   Rev 1.45.1.33   Dec 01 2015 09:15:10   rhegganni
--p_insert_cm240_for_DSS removed
--
--   Rev 1.45.1.32   Nov 30 2015 17:25:16   rhegganni
--Minor tidy up
--
--   Rev 1.45.1.31   Nov 19 2015 13:00:38   ARamakrishna
--minor changes to p_commission_switch_off_date.
--
--   Rev 1.45.1.30   Nov 03 2015 12:47:16   SASOPA
--Added a procedure p_update_comm_switch_off
--
--   Rev 1.45.1.29   Oct 22 2015 11:18:12   HKODE
--added new parameter to f_commission_switch_off_date
--
--   Rev 1.45.1.28   Oct 16 2015 17:01:34   HKODE
--Code changes for defect 363 & 364
--
--   Rev 1.45.1.27   Oct 01 2015 18:56:14   SUppuluri
--changes made in p_update_pa020 to make the end date of the OGF trigger updated to the commission switch off date every time it is changed, not only when the end date is greater than the commission switch off date.
--
--   Rev 1.45.1.26   Sep 30 2015 09:59:38   rmill
--removed call to set end date on FAF PA020 record
--
--   Rev 1.45.1.25   Sep 28 2015 19:28:02   SUppuluri
--Minor changes for defect 352
--
--   Rev 1.45.1.24   Sep 24 2015 17:55:00   SUppuluri
--code fix for defect 352
--
--   Rev 1.45.1.23   Sep 23 2015 16:05:44   SUppuluri
--minor changes like space and alignment
--
--   Rev 1.45.1.22   Sep 22 2015 17:40:30   ARamakrishna
--Minor changes to procedure p_insert_cm420
--
--   Rev 1.45.1.21   Sep 22 2015 12:10:58   SUppuluri
--Code fix for  Defect 348
--
--   Rev 1.45.1.20   Sep 21 2015 16:55:06   ARamakrishna
--Defect 340 fix
--
--   Rev 1.45.1.19   Sep 18 2015 13:56:22   ARamakrishna
--Added p_insert_cm420 procedure as part of defect 340 fix
--
--   Rev 1.45.1.18   Sep 14 2015 06:47:06   HKODE
--Defect fix 340
--
--   Rev 1.45.1.17   Sep 09 2015 16:17:46   ARamakrishna
--minor changes to procedure p_update_commission_switch_off
--
--   Rev 1.45.1.15   Sep 08 2015 14:08:22   SASOPA
--Changes made in procedure p_commission_switch_off_date to process the default policy as well
--
--   Rev 1.45.1.14   Sep 03 2015 12:32:22   HKODE
--Added output parameter for p_commission_switch_off_date
--
--   Rev 1.45.1.13   Sep 02 2015 12:01:12   PJayaraj
--Code change for defect 326 and 327
--
--   Rev 1.45.1.12   Aug 19 2015 14:30:48   HKODE
--Code optimization of p_update_nil_commission
--
--   Rev 1.45.1.11   Aug 04 2015 12:08:36   PJayaraj
--Alignment changes
--
--   Rev 1.45.1.10   Jul 31 2015 06:26:42   HKODE
--minor changes in code regarding the new column in commission switch off table
--
--   Rev 1.45.1.9   Jul 29 2015 14:03:36   HKODE
--update of audit details in p_update_nil_commission
--
--   Rev 1.45.1.8   Jul 27 2015 12:26:06   HKODE
--Minor changes
--
--   Rev 1.45.1.7   Jul 23 2015 07:13:06   PJayaraj
--Added a function f_commission_switch_off
--
--   Rev 1.45.1.6   Jul 21 2015 13:08:34   HKODE
--Overloading procedure for p_update_switch_off_date
--
--   Rev 1.45.1.5   Jul 17 2015 11:58:20   HKODE
--minor change on cm420 update in p_update_nil_commission
--
--   Rev 1.45.1.4   Jul 17 2015 08:27:48   HKODE
--Updating nil commission
--
--   Rev 1.45.1.3   Jul 06 2015 11:08:16   HKODE
--no code change
--
--   Rev 1.45.1.2   Jul 06 2015 08:34:14   HKODE
--changed the input parameter datatype
--
--   Rev 1.45.1.1   Jul 03 2015 10:25:44   PJayaraj
--No code changes
--
--   Rev 1.45   Apr 22 2015 10:12:20   SourceSafe
--Integrated version 1.44.1.0 from project DWP_CHARGES_CAP
--
--   Rev 1.44.1.0   Apr 09 2015 14:35:36   smacdonald
--Modified one of the p_get_tv_amc procedures to mine the tv amc from wrp_product_table if the policy has been DWP charge capped (DWP charge cap defects 110, 111 & 112)
--
--   Rev 1.44   May 19 2014 13:41:14   SourceSafe
--Integrated version 1.43.1.2 from project RDR_SALES_MAINTENANCE_II
--
--   Rev 1.43.1.2   May 07 2014 11:49:56   RRajagopla1
--Comments fixed.
--
--   Rev 1.43.1.1   May 06 2014 18:46:54   RRajagopla1
--Comments fixed.
--
--   Rev 1.43.1.0   May 06 2014 14:11:04   RRajagopla1
--Added p_update_cm240_status and p_update_cm640_status.
--
--   Rev 1.43   Nov 09 2012 15:01:52   SourceSafe
--Integrated version 1.42.1.0 from project RDR_UNIT_PROCESSING
--
--   Rev 1.42.1.0   Nov 08 2012 10:29:40   KLWilson
--Changes to the 2 new procedures to update audupddte and audupd_id.
--
--   Rev 1.42   Nov 07 2012 13:03:58   SourceSafe
--Integrated version 1.41.1.2 from project RDR_UNIT_PROCESSING
--
--   Rev 1.41.1.2   Nov 07 2012 08:52:38   KLWilson
--Further changes in setting process names after peer review.
--
--   Rev 1.41.1.1   Nov 07 2012 08:11:10   KLWilson
--Change new procedure names after peer review.
--
--   Rev 1.41.1.0   Nov 06 2012 15:23:56   KLWilson
--Add 2 new procedures p_update_cm240 to update CSNSTA and p_update_cm200 to update CSNSTSTYP.
--
--   Rev 1.41   Aug 23 2012 13:05:38   SourceSafe
--Integrated version 1.40.3.0 from project RDR_ILLUSTRATIONS
--
--   Rev 1.40.3.0   Aug 15 2012 11:28:38   ETiglao
--Add a new parameter pv_ac_cc_case on p_commission_rate_type
--
--   Rev 1.40   May 06 2011 13:54:34   SourceSafe
--Integrated version 1.39.1.0 from project THUNDERHEAD
--
--   Rev 1.39.1.0   Dec 09 2010 12:00:58   dcarter
--Added parameter to get the IFA split payment details to switch from rounding down or up.
--
--   Rev 1.39   Jul 23 2010 17:03:34   SourceSafe
--Integrated version 1.38.1.0 from project TV_INS
--
--   Rev 1.38.1.0   May 28 2010 12:15:38   KLWilson
--Overloaded version of p_get_tv_amc added.
--
--   Rev 1.38   Sep 10 2009 09:25:42   ACOOK
--Changed again, this time to handle nil commission.
--
--   Rev 1.37   Sep 09 2009 15:06:40   averri
--Next problem .... LC commission rate type (KAE) for RP's should be 3, not 1. Moved FBRC condition down the order.
--
--   Rev 1.36   Sep 09 2009 14:14:40   averri
--LC commission rate type (AMC) for single increments (SP,TV,DSS) should be 4.
--
--   Rev 1.35   Sep 09 2009 11:24:20   ACOOK
--Add in DSS check for commission rate type for AMC.
--
--   Rev 1.33   Sep 08 2009 16:34:08   ACOOK
--Change f_commission_rate_type for LC cases.
--
--   Rev 1.32   Sep 07 2009 15:55:56   averri
--PP version 5 should only validate the cost of commission and should exclude special deals from AMC calc.
--
--   Rev 1.31   Sep 03 2009 11:30:00   ACOOK
--Another update to f_commission_rate_type.
--
--   Rev 1.30   Sep 03 2009 10:34:14   ACOOK
--Updated f_commission_rate_type to ORD FBRC cases.
--
--   Rev 1.29   Aug 07 2009 11:26:18   averri
--New function to return maximum FAF amount for NIPP increments.
--
--   Rev 1.28   Aug 07 2009 11:13:12   ACOOK
--PP reprice phase 2 - Key Account Enhancement changes.
--
--   Rev 1.27   Jul 09 2009 11:33:02   averri
--Include changes from version 1.15.1.0 made direct to PRE, and 1.24.1.0 made direct to UAT.
--
--   Rev 1.26   Jul 01 2009 10:19:40   cmleckie
--Default product_charge_basis to 0
--
--   Rev 1.25   Jun 30 2009 15:18:22   averri
--Reinstated new procedure p_get_tv_amc again - this time on a separate distribution so it can be taken to UAT with other RS New Entrants changes.
--
--   Rev 1.23   Jun 30 2009 14:16:54   beastell
--Initialising global variables at start of p_get_tv_amc.
--
--   Rev 1.22   Jun 29 2009 15:01:24   averri
--Reinstated p_get_tv_amc.
--
--   Rev 1.21   Jun 29 2009 10:36:08   averri
--Back out new procedure p_get_tv_amc (version 1.19).
--
--   Rev 1.20   Jun 26 2009 16:11:42   averri
--Change to p_validate_amc so that KAE and special deals are not used for RS-PP v4.
--
--   Rev 1.19   Jun 26 2009 15:17:34   beastell
--Adding procedure p_get_tv_amc.
--
--   Rev 1.18   Jun 03 2009 11:54:18   cmleckie
--Add new function- f_check_commission_feature
--
--   Rev 1.17   May 28 2009 10:49:04   averri
--Default new input fields to 0 in p_validate_amc.
--
--   Rev 1.16   May 22 2009 14:54:30   averri
--Deduct any AMC adjustment and key account enhancements from total AMC cost in p_validate_AMC.
--
--   Rev 1.15   Mar 25 2009 10:07:54   averri
--Ensure inputs to validate AMC are less than 100%.
--
--   Rev 1.14   Mar 20 2009 17:13:44   rmackenzie
--moved p_validate_amc from web_commission to pck_commission. Created wrapper in web_commission in order to call the procedure in pck_commission
--
--   Rev 1.13   Mar 20 2009 10:45:36   ACOOK
--Upadte to f_commission_rate_type to handle FBRC only cases.
--
--   Rev 1.12   Mar 17 2009 08:44:30   averri
--Added new function and procedures for PP Reprice - one to split commission into first and subsequent monthly payments, and another to determine the commission rate type.
--
--   Rev 1.11   Feb 26 2009 11:11:04   KLWilson
--2 new functions added to determine whether a transaction being processed is event faf.
--
--   Rev 1.10   Feb 16 2009 12:04:46   smathew
--Added new procedure p_update_csn_movements
--
--   Rev 1.9   Jan 21 2009 11:59:50   nkamath
--Removed the ORDER BY clause in the query used in  f_ceh_record_exists
--
--   Rev 1.8   Jan 21 2009 04:52:48   nkamath
--Added procedure f_ceh_record_exists to check if a record exists in commission_event_headers.
--
--   Rev 1.7   Dec 12 2008 12:47:48   smmackinnon
--Income Release event faf - change to add effective date when updating commission event headers to allow for duplicate draft entries
--
--   Rev 1.6   Dec 01 2008 06:47:04   nkamath
--Added procedure p_get_faf_details to read the commission details from cm420.
--
--   Rev 1.5   Nov 26 2008 09:22:06   nkamath
--Added procedure to read commission amount/percentage from commission_event_headers.
--
--   Rev 1.4   Nov 21 2008 10:41:50   smmackinnon
--Change set process calls to improve audit details on CEH table
--
--   Rev 1.3   Nov 13 2008 17:01:30   smmackinnon
--Added 3 extra fields to commission_event_headers insert procedure
--
--   Rev 1.2   Oct 27 2008 11:47:38   smmackinnon
--Added procedures for inserting and updating commission_event_headers record
--
--   Rev 1.1   Feb 19 2008 11:46:48   sgodfrey
--Changed r_commission to gr_commission
--
--   Rev 1.0   Feb 11 2008 14:47:28   sgodfrey
--Initial revision.
 ********************************************************************************************/

    lpn_system_date            cs340.sysdte%TYPE             := pck_system_context.f_get_system_date;
    lpd_system_date            DATE                          := pck_dates.f_system_date;
    LPCN_SYS_TIME              CONSTANT cm240.audupdtme%TYPE := TO_NUMBER(TO_CHAR(SYSTIMESTAMP,'HH24MISSFF2'));
    lpr_audit_info             pck_audits.rec_audits;

    -- legacy audit value for money changes
    LPCN_FUND_REDUCTION        CONSTANT  PLS_INTEGER  := 75;
    -- 4d array to hold the remaining IC years
    TYPE t_remaining_ic_years_1d IS TABLE OF NUMBER INDEX BY PLS_INTEGER; --increment ref
    TYPE t_remaining_ic_years_2d IS TABLE OF t_remaining_ic_years_1d INDEX BY po020.inrtyp%TYPE; -- increment type
    TYPE t_remaining_ic_years_3d IS TABLE OF t_remaining_ic_years_2d INDEX BY PLS_INTEGER; -- valuation date
    TYPE t_remaining_ic_years_4d IS TABLE OF t_remaining_ic_years_3d INDEX BY PLS_INTEGER; -- policy ref
    lpt_remaining_ic_years t_remaining_ic_years_4d;

    PROCEDURE p_get_dup_val_err(pv_table_name           IN VARCHAR2
                               ,pv_sqlerrm              IN VARCHAR2
                               ,pr_commission           IN gr_commission
                               ,pt_params               OUT pck_err.t_err_param
                               ,pv_additional_text      OUT error_log.err_text%TYPE) IS

        ln_i          PLS_INTEGER;
        lv_constraint VARCHAR2(30);
        LCN_MAX_LINE_LEN CONSTANT PLS_INTEGER := 2000;

    BEGIN
        ln_i          := INSTR(pv_sqlerrm
                              ,'.') + 1;
        lv_constraint := SUBSTR(pv_sqlerrm
                               ,ln_i
                               ,INSTR(pv_sqlerrm
                                     ,')'
                                     ,-1) - ln_i);
        pt_params     := pck_err.t_err_param(lv_constraint
                                            ,pv_table_name);
        CASE lv_constraint
            WHEN 'CM240_MTC' THEN
                pv_additional_text := SUBSTR('unq=' || TO_CHAR(pr_commission.unq)||
                                             'trn_no=' || TO_CHAR(pr_commission.trn_no)||
                                             'polref=' || TO_CHAR(pr_commission.polref)||
                                             'duedte=' || TO_CHAR(pr_commission.duedte)||
                                             'co_unq=' || TO_CHAR(pr_commission.co_unq)
                                            ,1
                                            ,LCN_MAX_LINE_LEN);
            WHEN 'CM240_MTC' THEN
                pv_additional_text := SUBSTR('itr_no=' || TO_CHAR(pr_commission.itr_no)||
                                             'stf_no=' || TO_CHAR(pr_commission.stf_no)||
                                             'csnsta=' || TO_CHAR(pr_commission.csnsta)||
                                             'polref=' || TO_CHAR(pr_commission.polref)||
                                             'duedte=' || TO_CHAR(pr_commission.duedte)||
                                             'unq=' || TO_CHAR(pr_commission.unq)||
                                             'trn_no=' || TO_CHAR(pr_commission.trn_no)||
                                             'co_unq=' || TO_CHAR(pr_commission.co_unq)
                                            ,1
                                            ,LCN_MAX_LINE_LEN);
            WHEN 'CM240_STM' THEN
                pv_additional_text := SUBSTR('itr_no=' || TO_CHAR(pr_commission.itr_no)||
                                             'stm_no=' || TO_CHAR(pr_commission.stm_no)||
                                             'csnstmseq=' || TO_CHAR(pr_commission.csnstmseq)||
                                             'stmdte=' || TO_CHAR(pr_commission.stmdte)||
                                             'condition_stm=' || TO_CHAR(pr_commission.condition_stm)
                                             ,1
                                            ,LCN_MAX_LINE_LEN);
            WHEN 'CM240_UNP' THEN
                pv_additional_text := SUBSTR('itr_no=' || TO_CHAR(pr_commission.itr_no)||
                                             'csnsta=' || TO_CHAR(pr_commission.csnsta)||
                                             'polref=' || TO_CHAR(pr_commission.polref)||
                                             'duedte=' || TO_CHAR(pr_commission.duedte)||
                                             'csnamt=' || TO_CHAR(pr_commission.csnamt)||
                                             'movtyp=' || '''' ||pr_commission.movtyp|| '''' ||
                                             'unq='    || TO_CHAR(pr_commission.unq)||
                                             'trn_no=' || TO_CHAR(pr_commission.trn_no)||
                                             'stf_no=' || TO_CHAR(pr_commission.stf_no)||
                                             'co_unq=' || TO_CHAR(pr_commission.co_unq)||
                                             'condition_unp=' || TO_CHAR(pr_commission.condition_unp)
                                            ,1
                                            ,LCN_MAX_LINE_LEN);
            ELSE
                pv_additional_text := SUBSTR('unique_id=' || TO_CHAR(pr_commission.unique_id)
                                            ,1
                                            ,LCN_MAX_LINE_LEN);
        END CASE;

    END p_get_dup_val_err;

    FUNCTION f_get_null_val_err_details(pv_sqlerrm    IN VARCHAR2
                                       ,pv_table_name IN VARCHAR2) RETURN pck_err.t_err_param IS
        ln_i      PLS_INTEGER;
        lv_column VARCHAR2(30);
    BEGIN
        ln_i      := INSTR(pv_sqlerrm
                          ,'"'
                          ,1
                          ,5) + 1;
        lv_column := SUBSTR(pv_sqlerrm
                           ,ln_i
                           ,INSTR(pv_sqlerrm
                                 ,'"'
                                 ,-1) - ln_i);
        RETURN(pck_err.t_err_param(pv_table_name
                                  ,lv_column));
    END f_get_null_val_err_details;

    PROCEDURE p_insert_commission(pr_commission      IN gr_commission
                                 ,pb_throw_exception IN BOOLEAN := TRUE) IS

    null_column_value EXCEPTION;
    PRAGMA EXCEPTION_INIT(null_column_value
                         ,-1400);

    lt_err_params    pck_err.t_err_param;
    lv_add_err_text  error_log.err_text%TYPE;

    BEGIN


    INSERT INTO cm240
    (audaplcde
    ,audstf_no
    ,audupd_id
    ,audupddte
    ,wofprc
    ,unq
    ,trn_no
    ,stmdte
    ,stm_no
    ,stf_no
    ,sspprc
    ,sspdte
    ,spsdte
    ,pymdte
    ,audupdtme
    ,prmamt
    ,co_unq
    ,polref
    ,outprc
    ,oridte
    ,movtyp
    ,itrref_no
    ,itr_no
    ,inrtyp
    ,inrrngind
    ,inrref
    ,idmind
    ,efvdte
    ,duedte
    ,csntyp
    ,csnstmseq
    ,csnsta
    ,csnrsncde
    ,csnamt
    ,cpg_no
    ,condition_stm
    ,condition_unp)
    VALUES
    (NVL(pr_commission.audaplcde,' ')
    ,NVL(pr_commission.audstf_no,0)
    ,1
    ,NVL(pr_commission.audupddte,0)
    ,NVL(pr_commission.wofprc,' ')
    ,NVL(pr_commission.unq,0)
    ,NVL(pr_commission.trn_no,0)
    ,NVL(pr_commission.stmdte,0)
    ,NVL(pr_commission.stm_no,0)
    ,NVL(pr_commission.stf_no,0)
    ,NVL(pr_commission.sspprc,' ')
    ,NVL(pr_commission.sspdte,0)
    ,NVL(pr_commission.spsdte,0)
    ,NVL(pr_commission.pymdte,0)
    ,NVL(pr_commission.audupdtme,0)
    ,NVL(pr_commission.prmamt,0)
    ,NVL(pr_commission.co_unq,0)
    ,NVL(pr_commission.polref,0)
    ,NVL(pr_commission.outprc,' ')
    ,NVL(pr_commission.oridte,0)
    ,NVL(pr_commission.movtyp,' ')
    ,NVL(pr_commission.itrref_no,0)
    ,NVL(pr_commission.itr_no,0)
    ,NVL(pr_commission.inrtyp,' ')
    ,NVL(pr_commission.inrrngind,' ')
    ,NVL(pr_commission.inrref,0)
    ,NVL(pr_commission.idmind,' ')
    ,NVL(pr_commission.efvdte,0)
    ,NVL(pr_commission.duedte,0)
    ,NVL(pr_commission.csntyp,' ')
    ,NVL(pr_commission.csnstmseq,0)
    ,NVL(pr_commission.csnsta,0)
    ,NVL(pr_commission.csnrsncde,0)
    ,NVL(pr_commission.csnamt,0)
    ,NVL(pr_commission.cpg_no,0)
    ,NVL(pr_commission.condition_stm,0)
    ,NVL(pr_commission.condition_unp,0));

    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN

            p_get_dup_val_err('CM240'
                             ,SQLERRM
                             ,pr_commission
                             ,lt_err_params
                             ,lv_add_err_text);

            pck_err.p_handle('DUP_VAL_ON_INDEX'
                            ,lt_err_params
                            ,''
                            ,0
                            ,lv_add_err_text
                            ,TRUE
                            ,pb_throw_exception);

        WHEN null_column_value THEN

            pck_err.p_handle('NULL_COLUMN_VALUE'
                            ,f_get_null_val_err_details(SQLERRM
                                                       ,'CM240')
                            ,''
                            ,0
                            ,NULL
                            ,TRUE
                            ,pb_throw_exception);


    END;

    PROCEDURE p_insert_csn_event_headers(pr_commission_event_headers IN commission_event_headers%ROWTYPE)
    IS
        lv_error_text error_log.err_text%TYPE := '- Policy '        ||pr_commission_event_headers.policy_reference
                                              || ', Event type '    ||pr_commission_event_headers.event_type;
    BEGIN
        pck_process_info.p_register_module(pv_module_name => 'pck_commission'
                                          ,pv_action_name => 'p_insert_csn_event_headers');

        INSERT INTO commission_event_headers
            (policy_reference
            ,event_type
            ,effective_date
            ,ifa_reference
            ,amount
            ,quote_reference
            ,transaction_control
            ,percentage
            ,policy_record_no)
        VALUES
            (pr_commission_event_headers.policy_reference
            ,pr_commission_event_headers.event_type
            ,pr_commission_event_headers.effective_date
            ,pr_commission_event_headers.ifa_reference
            ,pr_commission_event_headers.amount
            ,pr_commission_event_headers.quote_reference
            ,pr_commission_event_headers.transaction_control
            ,pr_commission_event_headers.percentage
            ,pr_commission_event_headers.policy_record_no);

        pck_process_info.p_deregister_module;

    EXCEPTION

        WHEN DUP_VAL_ON_INDEX THEN
            pck_err.p_handle(pv_err_code      => 'DUP_VAL_ON_INDEX'
                            ,pt_err_param     => pck_err.t_err_param('commission_event_headers')
                            ,pv_subprcss_name => 'p_insert_csn_event_headers'
                            ,pn_err_occurance => 0
                            ,pv_add_text      => lv_error_text
                            ,pb_log_err       => TRUE
                            ,pb_re_raise      => TRUE);

        WHEN OTHERS THEN
            pck_err.p_handle(pv_err_code      => 'CANNOT_INSERT_RECORD'
                            ,pt_err_param     => pck_err.t_err_param('commission_event_headers'
                                                                    ,SUBSTR(SQLERRM,1,100))
                            ,pv_subprcss_name => 'p_insert_csn_event_headers'
                            ,pn_err_occurance => 0
                            ,pv_add_text      => lv_error_text
                            ,pb_log_err       => TRUE
                            ,pb_re_raise      => TRUE);
    END p_insert_csn_event_headers;

    PROCEDURE p_update_ceh_trnctl(pn_policy_reference IN commission_event_headers.policy_reference%TYPE
                                 ,pn_event_type       IN commission_event_headers.event_type%TYPE
                                 ,pd_effective_date   IN commission_event_headers.effective_date%TYPE
                                 ,pn_trnctl_no        IN commission_event_headers.transaction_control%TYPE
                                 ,pb_success_flag     OUT BOOLEAN)
    IS
        lv_error_text error_log.err_text%TYPE := '- Policy '             ||pn_policy_reference
                                              || ', Event type '         ||pn_event_type
                                              || ', Transaction control '||pn_trnctl_no;
    BEGIN
        pck_process_info.p_register_module(pv_module_name => 'pck_commission'
                                          ,pv_action_name => 'p_update_ceh_trnctl');

        UPDATE commission_event_headers
        SET   transaction_control = pn_trnctl_no
             ,audit_id            = audit_id + 1
        WHERE policy_reference    = pn_policy_reference
        AND   event_type          = pn_event_type
        AND   effective_date      = pd_effective_date
        AND   status              = 'D'; -- at status draft

        pb_success_flag := SQL%ROWCOUNT > 0;
        pck_process_info.p_deregister_module;

    EXCEPTION
        WHEN OTHERS THEN
            -- Error logged and reraised
            pck_err.p_handle(pv_err_code      => 'CANNOT_UPDATE_RECORD'
                            ,pt_err_param     => pck_err.t_err_param('commission_event_headers'
                                                                    ,SUBSTR(SQLERRM,1,100))
                            ,pv_subprcss_name => 'p_update_ceh_trnctl'
                            ,pn_err_occurance => 0
                            ,pv_add_text      => lv_error_text
                            ,pb_log_err       => TRUE
                            ,pb_re_raise      => TRUE);
    END p_update_ceh_trnctl;

    PROCEDURE p_update_ceh_status(pn_policy_reference IN commission_event_headers.policy_reference%TYPE
                                 ,pn_trnctl_no        IN commission_event_headers.transaction_control%TYPE
                                 ,pv_status           IN commission_event_headers.status%TYPE
                                 ,pb_success_flag     OUT BOOLEAN)
    IS
        lv_error_text error_log.err_text%TYPE := '- Policy '             ||pn_policy_reference
                                              || ', Transaction control '||pn_trnctl_no
                                              || ', Status              '||pv_status;
    BEGIN
        pck_process_info.p_register_module(pv_module_name => 'pck_commission'
                                          ,pv_action_name => 'p_update_ceh_status');

        UPDATE commission_event_headers
        SET   status = pv_status
             ,audit_id            = audit_id + 1
        WHERE policy_reference    = pn_policy_reference
        AND   transaction_control = pn_trnctl_no;

        pb_success_flag := SQL%ROWCOUNT > 0;
        pck_process_info.p_deregister_module;

    EXCEPTION
        WHEN OTHERS THEN
            -- Error logged and reraised
            pck_err.p_handle(pv_err_code      => 'CANNOT_UPDATE_RECORD'
                            ,pt_err_param     => pck_err.t_err_param('commission_event_headers'
                                                                    ,SUBSTR(SQLERRM,1,100))
                            ,pv_subprcss_name => 'p_update_ceh_status'
                            ,pn_err_occurance => 0
                            ,pv_add_text      => lv_error_text
                            ,pb_log_err       => TRUE
                            ,pb_re_raise      => TRUE);
    END p_update_ceh_status;

    /*******************************************************************************
    -- %Description Fetches the commission event amount and percentage from commission_event_headers
    -- %param pn_policy_reference      IN  commission_event_headers.policy_reference%TYPE
    -- %param pn_event_type            IN  commission_event_headers.event_type%TYPE
    -- %param pd_effective_date        IN  commission_event_headers.effective_date%TYPE
    -- %param pn_commission_amount     OUT commission_event_headers.amount%TYPE
    -- %param pn_commission_percentage OUT commission_event_headers.percentage%TYPE
    *******************************************************************************/
    PROCEDURE p_get_commission_event_values (pn_policy_reference      IN  commission_event_headers.policy_reference%TYPE
                                            ,pn_event_type            IN  commission_event_headers.event_type%TYPE
                                            ,pd_effective_date        IN  commission_event_headers.effective_date%TYPE
                                            ,pn_commission_amount     OUT commission_event_headers.amount%TYPE
                                            ,pn_commission_percentage OUT commission_event_headers.percentage%TYPE)
    IS
    BEGIN
        -- Register the module and action name.
        pck_process_info.p_register_module(pv_module_name => 'PCK_COMMISSION'
                                          ,pv_action_name => 'P_GET_COMMISSION_EVENT_VALUES');

        -- Get the commission amount and percentage.
        SELECT  amount
               ,NVL(percentage, 0)
        INTO    pn_commission_amount
               ,pn_commission_percentage
        FROM    commission_event_headers
        WHERE   policy_reference = pn_policy_reference
        AND     event_type       = pn_event_type
        AND     effective_date   = pd_effective_date;

        -- Deregister the module.
        pck_process_info.p_deregister_module;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            -- Set the output values to zero.
            pn_commission_amount     := 0;
            pn_commission_percentage := 0;

            pck_err.p_handle(pv_err_code      => 'NO_DATA_FOUND'
                            ,pt_err_param     => pck_err.t_err_param('COMMISSION_EVENT_HEADERS'
                                                                    ,'Error getting commission event amount/percentage')
                            ,pv_subprcss_name => pck_process_info.f_action
                            ,pn_err_occurance => 0
                            ,pv_add_text      => '  Policy ref = '     || TO_CHAR(pn_policy_reference) ||
                                                 ', Event type = '     || TO_CHAR(pn_event_type) ||
                                                 ', Effective_date = ' || TO_CHAR(pd_effective_date)
                            ,pb_log_err       => TRUE
                            ,pb_re_raise      => FALSE);

            -- Deregister the module.
            pck_process_info.p_deregister_module;
    END p_get_commission_event_values;

    /*******************************************************************************
    -- %Description Procedure to get the FAF commission amount and percentage.
    -- %param pn_policy_reference    IN  cm420.polref%TYPE
    -- %param pv_increment_type      IN  cm420.inrtyp%TYPE
    -- %param pn_increment_reference IN  cm420.inrref%TYPE
    -- %param pn_commission_amt      OUT cm420.csnamt%TYPE
    -- %param pn_commission_pct      OUT cm420.commission_pct%TYPE
    *******************************************************************************/
    PROCEDURE p_get_faf_details (pn_policy_reference    IN  cm420.polref%TYPE
                                ,pv_increment_type      IN  cm420.inrtyp%TYPE
                                ,pn_increment_reference IN  cm420.inrref%TYPE
                                ,pn_commission_amt      OUT cm420.csnamt%TYPE
                                ,pn_commission_pct      OUT cm420.commission_pct%TYPE)
    AS
    BEGIN
        -- Register the module and action name.
        pck_process_info.p_register_module (pv_module_name => 'PCK_COMMISSION'
                                           ,pv_action_name => 'P_GET_FAF_DETAILS');

        SELECT csnamt
              ,commission_pct
        INTO   pn_commission_amt
              ,pn_commission_pct
        FROM   cm420
        WHERE  polref =  pn_policy_reference
        AND    inrtyp =  TRIM(pv_increment_type)
        AND    inrref =  pn_increment_reference
        AND    maint  <> 'D'
        AND    bentyp =  ' ';

        -- Deregister the module and action name.
        pck_process_info.p_deregister_module;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
           pn_commission_amt := 0;
           pn_commission_pct := 0;

           -- Deregister the module and action name.
           pck_process_info.p_deregister_module;
    END p_get_faf_details;

    /**************************************************************************************
    -- Checks whether a commission event header record exists.
    -- %param  pn_policy_reference IN po010.polref%TYPE
    -- %param  pd_effective_date   IN commission_event_headers.effective_date%TYPE
    -- %param  pv_status           IN commission_event_headers.status%TYPE
    -- %return BOOLEAN
    **************************************************************************************/
    FUNCTION f_ceh_record_exists(pn_policy_reference IN po010.polref%TYPE
                                ,pd_effective_date   IN commission_event_headers.effective_date%TYPE
                                ,pv_status           IN commission_event_headers.status%TYPE)
    RETURN BOOLEAN
    IS
        -- Cursor to check if a draft commission event header record exists.
        CURSOR cu_ceh_record (pcn_policy_reference po010.polref%TYPE
                             ,pcd_effective_date   commission_event_headers.effective_date%TYPE
                             ,pcv_status           commission_event_headers.status%TYPE)
        IS
            SELECT   effective_date
            FROM     commission_event_headers
            WHERE    policy_reference = pcn_policy_reference
            AND      effective_date   = pcd_effective_date
            AND      status           = pcv_status;

        ld_effective_date   commission_event_headers.effective_date%TYPE;
        lb_ceh_exists       BOOLEAN;
    BEGIN
        -- Set the action name.
        pck_process_info.p_set_action(pv_action_name => 'F_CEH_RECORD_EXISTS');

        -- Read the commission event headers table.
        OPEN cu_ceh_record(pcn_policy_reference => pn_policy_reference
                          ,pcd_effective_date   => pd_effective_date
                          ,pcv_status           => pv_status);
        FETCH cu_ceh_record
        INTO  ld_effective_date;
        -- Check if record found.
        lb_ceh_exists := (cu_ceh_record%FOUND);
        CLOSE cu_ceh_record;

        pck_process_info.p_unset_action;
        RETURN lb_ceh_exists;
    END f_ceh_record_exists;

   /**************************************************************************************
    -- Update the unq and trn_no of the commission movements
    -- %param  pn_policy_reference  IN  cm240.polref%TYPE
    -- %param  pn_old_event_unique  IN  cm240.unq%TYPE
    -- %param  pn_old_event_trn_no  IN  cm240.trn_no%TYPE
    -- %param  pn_new_event_unique  IN  cm240.unq%TYPE
    -- %param  pn_new_event_trn_no  IN  cm240.trn_no%TYPE
    -- %param  pr_audits            IN  pck_audits.rec_audits
    -- %param  pb_success_flag      OUT BOOLEAN
    **************************************************************************************/
    PROCEDURE p_update_csn_movements(pn_policy_reference  IN  cm240.polref%TYPE
                                    ,pn_old_event_unique  IN  cm240.unq%TYPE
                                    ,pn_old_event_trn_no  IN  cm240.trn_no%TYPE
                                    ,pn_new_event_unique  IN  cm240.unq%TYPE
                                    ,pn_new_event_trn_no  IN  cm240.trn_no%TYPE
                                    ,pr_audits            IN  pck_audits.rec_audits
                                    ,pb_success_flag      OUT BOOLEAN
                                    )
    IS
        ln_system_date  cs340.sysdte%TYPE;
        lv_error_text error_log.err_text%TYPE := '- Policy '             || TO_CHAR(pn_policy_reference)
                                              || ', Event Unq '          || TO_CHAR(pn_old_event_unique)
                                              || ', Event Trnno '|| TO_CHAR(pn_old_event_trn_no);

    BEGIN
        pck_process_info.p_register_module(pv_module_name => 'pck_commission'
                                          ,pv_action_name => 'p_update_csn_movements');

        ln_system_date := pck_system_context.f_get_system_date;

        UPDATE  cm240
        SET     unq       = pn_new_event_unique
               ,trn_no    = pn_new_event_trn_no
               ,audstf_no = pr_audits.audit_staff_number
               ,audaplcde = pr_audits.audit_application_code
               ,audupd_id = MOD(audupd_id + 1,100)
               ,audupddte = ln_system_date
               ,audupdtme = TO_NUMBER(TO_CHAR(SYSTIMESTAMP,'HH24MISSFF2'))
        WHERE   polref = pn_policy_reference
        AND     unq    = pn_old_event_unique
        AND     trn_no = pn_old_event_trn_no;

        pb_success_flag := SQL%ROWCOUNT > 0;
        pck_process_info.p_deregister_module;

    EXCEPTION
        WHEN OTHERS THEN
            -- Error logged and reraised
            pck_err.p_handle(pv_err_code      => 'CANNOT_UPDATE_RECORD'
                            ,pt_err_param     => pck_err.t_err_param('CM240'
                                                                    ,SUBSTR(SQLERRM,1,100))
                            ,pv_subprcss_name => pck_process_info.f_action
                            ,pn_err_occurance => 0
                            ,pv_add_text      => lv_error_text
                            ,pb_log_err       => TRUE
                            ,pb_re_raise      => TRUE);

    END p_update_csn_movements;

    /**************************************************************************************
    -- Checks whether a commission event header record exists for input policy and trans no.
    -- %param  pn_policy_reference IN commission_event_headers.policy_reference%TYPE
    -- %param  pn_transaction_control IN commission_event_headers.transaction_control%TYPE
    -- %return BOOLEAN
    **************************************************************************************/

    FUNCTION f_check_for_event_faf(pn_policy_reference    IN commission_event_headers.policy_reference%TYPE
                                  ,pn_transaction_control IN commission_event_headers.transaction_control%TYPE)
    RETURN BOOLEAN IS

        CURSOR cu_event_faf_case (pcn_policy_reference    commission_event_headers.policy_reference%TYPE
                                 ,pcn_transaction_control commission_event_headers.transaction_control%TYPE)
        IS
        SELECT    effective_date
        FROM      commission_event_headers
        WHERE     policy_reference    = pcn_policy_reference
        AND       transaction_control = pcn_transaction_control;

        ld_effective_date   commission_event_headers.effective_date%TYPE;
        lb_event_faf_case BOOLEAN;
    BEGIN
        -- Set the Action Name
        pck_process_info.p_register_module(pv_module_name => 'PCK_COMMISSION'
                                          ,pv_action_name => 'f_check_for_event_faf');

        OPEN    cu_event_faf_case (pn_policy_reference
                                  ,pn_transaction_control);
        FETCH  cu_event_faf_case
        INTO   ld_effective_date;

        -- Check if record found.
        lb_event_faf_case := (cu_event_faf_case%FOUND);
        CLOSE   cu_event_faf_case;

        pck_process_info.p_deregister_module;
        RETURN lb_event_faf_case;
    END f_check_for_event_faf;

    /*******************************************************************************
    -- %Description Function that is called to determine whether this is an Event
    --              FAF transaction that is being processed
    -- %param  pn_policy_reference IN FI700.polref%TYPE
    -- %param  pn_eff_date         IN fi700.efvdte%TYPE
    -- %param  pv_fund_trans_type  IN fi700.fndtrntyp%TYPE
    -- %param  pn_unique           IN fi700.evtunq%TYPE
    -- %param  pn_tranno           IN fi700.evttrn_no%TYPE
    -- %return BOOLEAN
    *******************************************************************************/

    FUNCTION f_check_for_event_faf  (pn_policy_reference IN FI700.polref%TYPE
                                    ,pn_eff_date         IN fi700.efvdte%TYPE
                                    ,pv_fund_trans_type  IN fi700.fndtrntyp%TYPE
                                    ,pn_unique           IN fi700.evtunq%TYPE
                                    ,pn_tranno           IN fi700.evttrn_no%TYPE)
    RETURN BOOLEAN
    IS

        CURSOR cu_event_faf_case (pcn_policy_reference   fi700.polref%TYPE
                                 ,pcn_effective_date     fi700.efvdte%TYPE
                                 ,pcv_fund_trans_type    fi700.fndtrntyp%TYPE
                                 ,pcn_unique             fi700.evtunq%TYPE
                                 ,pcn_tranno             fi700.evttrn_no%TYPE)
        IS
        SELECT ceh.effective_date
        FROM   commission_event_headers ceh, fi700 fi
        WHERE  fi.polref = pcn_policy_reference
        AND    fi.efvdte = pcn_effective_date
        AND    fi.fndtrntyp = pcv_fund_trans_type
        AND    fi.evtunq    = pcn_unique
        AND    fi.evttrn_no = pcn_tranno
        AND    ceh.policy_reference = fi.polref
        AND    ceh.transaction_control = fi.trnctl_no;

        ld_effective_date   commission_event_headers.effective_date%TYPE;
        lb_event_faf_case BOOLEAN;
    BEGIN
        -- Set the Action Name
        pck_process_info.p_register_module(pv_module_name => 'PCK_COMMISSION'
                                          ,pv_action_name => 'f_check_for_event_faf');

       OPEN cu_event_faf_case(pn_policy_reference
                             ,pn_eff_date
                             ,pv_fund_trans_type
                             ,pn_unique
                             ,pn_tranno);
       FETCH cu_event_faf_case
       INTO ld_effective_date;

       -- Check if record found.
       lb_event_faf_case := (cu_event_faf_case%FOUND);
       CLOSE cu_event_faf_case;

       pck_process_info.p_deregister_module;
       RETURN lb_event_faf_case;
    END f_check_for_event_faf;

    /*******************************************************************************
    -- %Description Procedure p_split_IFA_payments
    -- Given a payment amount, and number of payments the procedure will calculate how
    -- much should be paid in the first payment to ensure that equal payments are
    -- received for the remaining payments. The parameter pb_round_pymt_down is
    -- used to detemine if the amount is rounded down or up. It's defaulted to round up.
    -- %param   pn_payment_amount       IN  NUMBER
    -- %param   pn_payment_term         IN  NUMBER
    -- %param   pb_round_pymt_down      IN  BOOLEAN DEFAULT FALSE
    -- %param   pn_first_amount         OUT NUMBER
    -- %param   pn_other_amounts        OUT NUMBER
    -- %param   pv_all_payments_equal   OUT VARCHAR2
    -- %param   pn_count_other_payments OUT NUMBER
    *******************************************************************************/
    PROCEDURE p_split_IFA_payments  (pn_payment_amount       IN  NUMBER
                                    ,pn_payment_term         IN  NUMBER
                                    ,pb_round_pymt_down      IN  BOOLEAN DEFAULT FALSE
                                    ,pn_first_amount         OUT NUMBER
                                    ,pn_other_amounts        OUT NUMBER
                                    ,pv_all_payments_equal   OUT VARCHAR2
                                    ,pn_count_other_payments OUT NUMBER)
    IS
        lcn_constant_rounding_payments    CONSTANT NUMBER(1) := 2;
    BEGIN
        -- Set the Action Name
        pck_process_info.p_register_module(pv_module_name => 'PCK_COMMISSION'
                                          ,pv_action_name => 'p_split_IFA_payments');

        IF (pn_payment_term > 1) THEN -- If more than one payment required.
            IF pb_round_pymt_down THEN --if flag is set to true we want round down not up
                pn_other_amounts := TRUNC(pn_payment_amount/pn_payment_term,lcn_constant_rounding_payments);
            ELSE
                pn_other_amounts := ROUND(pn_payment_amount/pn_payment_term,lcn_constant_rounding_payments);
            END IF;
        ELSE
            -- When we have 1 (or less) payments, then ensure that subsequent payments amounts are set to 0.
            pn_other_amounts        := 0;
        END IF;
        pn_count_other_payments := pn_payment_term - 1;
        pn_first_amount         := pn_payment_amount - (pn_other_amounts*pn_count_other_payments);

        IF (pn_first_amount = pn_other_amounts) THEN
            pv_all_payments_equal   := 'Y';
        ELSE
            pv_all_payments_equal   := 'N';
        END IF;

        pck_process_info.p_deregister_module;

    END p_split_IFA_payments;

    /**********************************************************************************************
    -- %Description function f_check_commission_feature
    -- Based on the input policy and feature, determine whether commission feature is switched on
    -- C = extra clawback, F- FAF
    -- %param   pn_policy_reference      IN po020.inrtyp%TYPE
    -- %param   pv_commission_feature      IN VARCHAR2
    -- %return  lb_feature_on             BOOLEAN
    ***********************************************************************************************/

    FUNCTION f_check_commission_feature (pn_policy_reference IN po010.polref%TYPE
                                        ,pv_commission_feature IN VARCHAR2)
                                          RETURN BOOLEAN IS

        lb_feature_on         BOOLEAN;
        ln_clawback_value    pr190.tblval1%TYPE := 0;
        ln_value_2            pr190.tblval1%TYPE := 0;
        ln_value_3            pr190.tblval1%TYPE := 0;
        ln_error_code        cs001.err_no%TYPE := 0;
    BEGIN
        lb_feature_on := FALSE;

        prl_fldeqt.p_set_commission_feature(pv_commission_feature => pv_commission_feature);

        wrp_product_table.p_product_table(pv_prdref       => pck_policy_details.f_get_product_reference (pn_policy_reference => pn_policy_reference)
                                         ,pn_prdvrs_no    => pck_policy_details.f_get_product_version (pn_policy_reference => pn_policy_reference)
                                         ,pv_inrtyp       => ' '
                                         ,pn_elmref       => 0
                                         ,pv_tbltyp       => 'VRSCSN'
                                         ,pn_sysdte       => pck_policy_details.f_commencement_date (pn_policy_reference => pn_policy_reference)
                                         ,pn_efvdte       => pck_policy_details.f_commencement_date (pn_policy_reference => pn_policy_reference)
                                         ,pn_table_val_1  => ln_clawback_value
                                         ,pn_table_val_2  => ln_value_2
                                         ,pn_table_val_3  => ln_value_3
                                         ,pn_error_status => ln_error_code);

        IF ln_clawback_value > 0 THEN

            lb_feature_on := TRUE;
        END IF;

        RETURN lb_feature_on;
    END f_check_commission_feature;

    /*******************************************************************************
    -- %Description   Based on the types of commission selected, determine the
    --                commission rate type
    -- %param         pv_increment_type            IN   po020.inrtyp%TYPE
    -- %param         pn_ic_csn                    IN   NUMBER
    -- %param         pn_rc_csn                    IN   NUMBER
    -- %param         pn_lc_csn                    IN   NUMBER
    -- %param         pn_fbrc_csn                  IN   NUMBER
    -- %param         pn_faf                       IN   NUMBER
    -- %param         pv_ac_cc_case                IN   VARCHAR2 DEFAULT 'N'
    -- %param         pn_commission_rate_type_kae  OUT  NUMBER
    -- %param         pn_commission_rate_type_amc  OUT  NUMBER)
    *******************************************************************************/
    PROCEDURE p_commission_rate_type (pv_increment_type            IN   po020.inrtyp%TYPE
                                     ,pn_ic_csn                    IN   NUMBER
                                     ,pn_rc_csn                    IN   NUMBER
                                     ,pn_lc_csn                    IN   NUMBER
                                     ,pn_fbrc_csn                  IN   NUMBER
                                     ,pn_faf                       IN   NUMBER
                                     ,pv_ac_cc_case                IN   VARCHAR2 DEFAULT 'N'
                                     ,pn_commission_rate_type_kae  OUT  NUMBER
                                     ,pn_commission_rate_type_amc  OUT  NUMBER)
    IS

    BEGIN
        -- Set the Action Name
        pck_process_info.p_register_module(pv_module_name => 'PCK_COMMISSION'
                                          ,pv_action_name => 'f_commission_rate_type');

        IF pv_ac_cc_case != 'Y' THEN
            -- Set the commission basis for the KAE calc.
            IF pv_increment_type IN ('ORD','AVCO') THEN
                CASE
                    WHEN pn_fbrc_csn > 0 AND pn_faf > 0 THEN
                         pn_commission_rate_type_kae := 11;
                    WHEN pn_faf > 0                     THEN
                         pn_commission_rate_type_kae := 10;
                    WHEN pn_lc_csn > 0                  THEN
                         pn_commission_rate_type_kae := 3;
                    WHEN pn_ic_csn > 0 OR pn_rc_csn > 0 OR pn_fbrc_csn > 0 THEN
                         pn_commission_rate_type_kae := 1;
                    ELSE
                         pn_commission_rate_type_kae := 6;
                END CASE;
            END IF;

            IF pv_increment_type IN ('SP','TV', 'DSS') THEN
                CASE
                    WHEN pn_fbrc_csn > 0 AND pn_faf > 0 THEN
                         pn_commission_rate_type_kae := 13;
                    WHEN pn_faf > 0                     THEN
                         pn_commission_rate_type_kae := 12;
                    WHEN pn_fbrc_csn > 0                THEN
                         pn_commission_rate_type_kae := 5;
                    WHEN pn_lc_csn > 0                  THEN
                         pn_commission_rate_type_kae := 5;
                    ELSE
                        pn_commission_rate_type_kae := 6;
                END CASE;
            END IF;

            -- Now set the commission basis for the AMC calc.
            IF pv_increment_type IN ('ORD','AVCO') THEN
                CASE
                    WHEN pn_rc_csn > 0 OR (pn_ic_csn > 0 AND pn_fbrc_csn = 0) THEN
                        pn_commission_rate_type_amc := 1;
                    WHEN pn_lc_csn > 0 THEN
                        pn_commission_rate_type_amc := 2;
                    WHEN pn_ic_csn > 0 AND pn_fbrc_csn > 0 THEN
                        pn_commission_rate_type_amc := 7;
                    WHEN pn_fbrc_csn > 0 AND pn_lc_csn > 0 THEN
                        pn_commission_rate_type_amc := 8;
                    WHEN pn_fbrc_csn > 0 AND pn_faf > 0 THEN
                        pn_commission_rate_type_amc := 11;
                    WHEN pn_fbrc_csn > 0 THEN
                        pn_commission_rate_type_amc := 7;
                    ELSE
                        pn_commission_rate_type_amc := 0;
                END CASE;
            END IF;

            IF pv_increment_type IN ('SP','TV','DSS') THEN
                CASE
                    WHEN pn_lc_csn > 0 THEN
                        pn_commission_rate_type_amc := 4;
                    WHEN pn_fbrc_csn > 0 AND pn_faf > 0 THEN
                        pn_commission_rate_type_amc := 11;
                    WHEN pn_fbrc_csn > 0 THEN
                        pn_commission_rate_type_amc := 4;
                    ELSE
                        pn_commission_rate_type_amc := 0;
                END CASE;
            END IF;
        ELSE  -- ac/cc case, set the commission rate type kae and amc to a default value
            pn_commission_rate_type_kae := 20;
            pn_commission_rate_type_amc := 20;
        END IF;

        pck_process_info.p_deregister_module;

    END p_commission_rate_type;

    --------------------------------------------------------------------------------------
    -- Test to check if the input commission allow for a valid AMC rate.
    -- Procedure was developed in web_commission by Natasha Park and moved to this package by Ron Mackenzie in March 2009.
    PROCEDURE p_validate_amc(pn_itr_number              IN  cl010.cliref%TYPE
                            ,pv_product_reference       IN  pr010.prdref%TYPE
                            ,pn_product_version         IN  pr010.prdvrs_no%TYPE
                            ,pv_payment_type            IN  VARCHAR2
                            ,pd_currency_date           IN  DATE
                            ,pn_commission_type         IN  NUMBER
                            ,pn_level_single_commission IN  NUMBER
                            ,pn_renewal_commission      IN  NUMBER
                            ,pn_initial_commission_rate IN  NUMBER
                            ,pn_fbr_commission          IN  NUMBER
                            ,pv_fbrc_applies            IN  VARCHAR2
                            ,pv_pr_vesting_year         IN  gla.gl_cnrout_yr%TYPE
                            ,pn_term_to_65              IN  gll.gl_trmdec_65%TYPE
                            ,pd_increment_maturity      IN  DATE
                            ,pn_amc_adjustment            IN  NUMBER    DEFAULT 0
                            ,pn_key_account_enhancement    IN  NUMBER    DEFAULT 0
                            ,pv_valid_amc               OUT VARCHAR2)
    IS
        -- Convert the payment type to an increment type based on the product type
        CURSOR cu_increment_type(pcv_product_reference pr020.prdref%TYPE
                                ,pcn_product_version   pr020.prdvrs_no%TYPE
                                ,pcv_payment_type      VARCHAR2)
        IS
            SELECT increments.inrtyp
            FROM   pr020 increments
            WHERE  increments.prdref    =  pcv_product_reference
            AND    increments.prdvrs_no =  pcn_product_version
            AND    increments.maint     <> 'D'
            AND    increments.staprd    = 30
            AND    pcv_payment_type     = CASE
                                              WHEN increments.inrtyp IN ('ORD','RVP')   THEN 'RP'
                                              WHEN increments.inrtyp IN ('AVCR','AVCO') THEN 'RPAVC'
                                              WHEN increments.inrtyp = 'SP'             THEN 'SP'
                                              WHEN increments.inrtyp = 'TV'             THEN 'TV'
                                              WHEN increments.inrtyp = 'DSS'            THEN 'DSS'
                                          END;

        ln_charging_basis           gla.gl_crgbas%TYPE;
        lv_product_sub_group        pr010.prdsubgrp%TYPE;
        ln_amc                      pr190.tblval1%TYPE;
        ln_max_amc                  pr190.tblval1%TYPE;
        ln_standard_contract_charge pr190.tblval1%TYPE;
        lv_charge_adjustment_type_3 gla.gl_crgadjtyp3%TYPE;
        ln_charge_adjustment_rate_3 gla.gl_crgadjrte3%TYPE;
        lv_charge_adjustment_type_4 gla.gl_crgadjtyp4%TYPE;
        ln_charge_adjustment_rate_4 gla.gl_crgadjrte4%TYPE;
        ln_error_number             gla.gl_glgerr%TYPE;
        lv_error_area               gla.gl_glgerrare%TYPE;
        lv_error_code               VARCHAR2(1000);
        lv_increment_type           pr020.inrtyp%TYPE;
        lv_dummy                    pr020.inrtyp%TYPE;

        e_migrated_logic_error      EXCEPTION;
        e_no_increment_found        EXCEPTION;
        e_multiple_increments       EXCEPTION;
    BEGIN

        -- do nothing if any of the inputs are over 100%
        IF (pn_level_single_commission     >= 100 OR
            pn_renewal_commission        >= 100 OR
            pn_initial_commission_rate    >= 100 OR
            pn_fbr_commission            >= 100) THEN

            pv_valid_amc := 'N';
        ELSE
            -- Look up the charging basis for the ITR/Product
            ln_charging_basis    := wrp_charging_basis.f_charging_basis(
                                        pv_product_reference  => pv_product_reference
                                       ,pn_product_vrs_no     => pn_product_version
                                       ,pn_itr_number         => pn_itr_number
                                       ,pd_quote_date         => pck_dates.f_system_date);

            -- Look up the product sub group
            lv_product_sub_group := pck_productdata.f_get_product_sub_group(
                                        pv_product_reference => pv_product_reference
                                       ,pn_product_version   => pn_product_version);

            -- Look up the increment type for this product/payment_type
            OPEN cu_increment_type(pcv_product_reference => pv_product_reference
                                  ,pcn_product_version   => pn_product_version
                                  ,pcv_payment_type      => pv_payment_type);

            FETCH cu_increment_type INTO lv_increment_type;
            IF cu_increment_type%NOTFOUND THEN
                CLOSE cu_increment_type;
                RAISE e_no_increment_found;
            END IF;

            FETCH cu_increment_type INTO lv_dummy;
            IF cu_increment_type%FOUND THEN
                CLOSE cu_increment_type;
                RAISE e_multiple_increments;
            END IF;

            CLOSE cu_increment_type;

            -- Get the amc
            cml_gpsamc.p_get_amc(
                pv_product_reference        => pv_product_reference
               ,pn_product_version          => pn_product_version
               ,pv_product_sub_group        => lv_product_sub_group
               ,pv_increment_type           => lv_increment_type
               ,pd_currency_date            => pd_currency_date
               ,pn_commission_type          => pn_commission_type
               ,pn_level_single_commission  => pn_level_single_commission
               ,pn_renewal_commission       => pn_renewal_commission
               ,pn_initial_commission_rate  => pn_initial_commission_rate
               ,pn_fbr_commission           => pn_fbr_commission
               ,pn_commission_basis         => CASE UPPER(pv_fbrc_applies)
                                                   WHEN 'Y' THEN 5
                                                   ELSE 0
                                               END
               ,pv_pr_vesting_year          => pv_pr_vesting_year
               ,pn_term_to_65               => pn_term_to_65
               ,pn_charge_basis             => ln_charging_basis
               ,pd_increment_maturity       => pd_increment_maturity
               ,pn_amc                      => ln_amc
               ,pn_standard_contract_charge => ln_standard_contract_charge
               ,pv_charge_adjustment_type_3 => lv_charge_adjustment_type_3
               ,pn_charge_adjustment_rate_3 => ln_charge_adjustment_rate_3
               ,pv_charge_adjustment_type_4 => lv_charge_adjustment_type_4
               ,pn_charge_adjustment_rate_4 => ln_charge_adjustment_rate_4
               ,pn_error_number             => ln_error_number
               ,pv_error_area               => lv_error_area);

            -- Check if errors were returned, if so then return them to the calling program
            IF ln_error_number != 0 THEN
                RAISE e_migrated_logic_error;
            END IF;

            -- For RS-PP version 4 and later the maximum amc is only compare to the commission charge and excludes
            -- the standard contact charge, so deduct it from the amc returned above as this includes it
            IF pv_product_reference = 'RS-PP' AND pn_product_version > 3 THEN
                ln_amc := ln_amc - ln_standard_contract_charge;
            END IF;

            -- deduct any special deal AMC adjustment or key account enhancements from the calculated AMC
            -- (this does not apply to RS-PP v4 policies and later since we only want to check the cost of
            -- commission for those cases and KAE/SPC don't apply to cost of commission)
            IF NOT (pv_product_reference = 'RS-PP' AND pn_product_version > 3) THEN
                ln_amc := ln_amc - nvl(pn_amc_adjustment,0) - nvl(pn_key_account_enhancement,0);
            END IF;

            -- Look up the max amc charge. These will probably get added to the variable key table (currently 1% for stakeholder and 1.65% for non stakeholder)
            ln_max_amc := pck_varkey_data.f_get_maximum_amc(
                              pv_product_reference  => pv_product_reference
                             ,pn_product_version    => pn_product_version
                             ,pv_increment_type     => lv_increment_type
                             ,pn_start_date         => pck_utility.f_dtcnv(pd_currency_date));

            -- Check whether the amc calculated would be higher than the maximum amc, if so then the amc is not valid
            IF ln_amc > ln_max_amc THEN
                pv_valid_amc := 'N';
            ELSE
                pv_valid_amc := 'Y';
            END IF;
        END IF;
    EXCEPTION
        WHEN e_migrated_logic_error THEN
            lv_error_code :=  SUBSTR('Error: ' ||
                                     lv_error_area ||
                                     LPAD(ln_error_number,4,0) ||
                                     ' - ' ||
                                     pck_prod_support.f_error_msg(lv_error_area
                                                                 ,ln_error_number)
                                    ,1,1000);

            pck_err.p_handle(
                 pv_err_code      => 'LOGIC_ERROR'
                ,pt_err_param     => pck_err.t_err_param('cml_gpsamc' ,'web_commission')
                ,pn_err_occurance => 1
                ,pv_add_text      => lv_error_code
                ,pb_log_err       => TRUE
                ,pb_re_raise      => TRUE);
        WHEN e_no_increment_found  THEN
            pck_err.p_handle(
                 pv_err_code      => 'NO_DATA_FOUND'
                ,pt_err_param     => pck_err.t_err_param('pr020')
                ,pn_err_occurance => 1
                ,pv_add_text      => 'For increment_type ' || lv_increment_type ||
                                     ' based on a payment type passed from the web of ' || pv_payment_type
                ,pb_log_err       => TRUE
                ,pb_re_raise      => TRUE);
        WHEN e_multiple_increments THEN
            pck_err.p_handle(
                 pv_err_code      => 'TOO_MANY_ROWS'
                ,pt_err_param     => pck_err.t_err_param('pr020')
                ,pn_err_occurance => 1
                ,pv_add_text      => 'For increment_type ' || lv_increment_type ||
                                     ' based on a payment type passed from the web of ' || pv_payment_type
                ,pb_log_err       => TRUE
                ,pb_re_raise      => TRUE);
    END p_validate_amc;

    /*******************************************************************************
    -- Procedure name    : p_get_tv_amc
    -- Description       : Procedure to calculate TV AMC
    --                     called from the web to remove technicaldebt/remove
    --                     hard-coding also allow for new parameter GL_PRDRGBAS
    -- Parameters        :
    -- pn_scheme_reference         sc010.schref%TYPE      Scheme Reference
    -- pv_scheme_category          sc010.schcat%TYPE      Scheme Category
    -- pn_policy_reference         po010.polref%TYPE      Policy Reference
    -- pv_product_reference        pr010.prdref%TYPE      Product Reference
    -- pn_product_version          pr010.prdvrs_no%TYPE   Product Version
    -- pd_currency_date            DATE                   Currency Date
    -- pd_increment_maturity       DATE                   Increment Maturity Date
    -- pn_sp_rate                  NUMBER                 Initial Commission Rate
    -- pn_fbr_commission           NUMBER                 FBRC Commission Rate
    -- pn_term_to_65               gll.gl_trmdec_65%TYPE  Term to 65
    -- pn_tv_amc                   NUMBER                 TV AMC Amount
    *******************************************************************************/
    PROCEDURE p_get_tv_amc(pn_scheme_reference      IN  sc010.schref%TYPE
                          ,pv_scheme_category       IN  sc010.schcat%TYPE
                          ,pn_policy_reference      IN  po010.polref%TYPE
                          ,pv_product_reference     IN  pr010.prdref%TYPE
                          ,pn_product_version       IN  pr010.prdvrs_no%TYPE
                          ,pd_currency_date         IN  DATE
                          ,pd_increment_maturity    IN  DATE
                          ,pn_sp_rate               IN  NUMBER
                          ,pn_fbr_commission        IN  NUMBER
                          ,pn_term_to_65            IN  gll.gl_trmdec_65%TYPE
                          ,pn_tv_amc                OUT NUMBER)
    IS
        lv_product_sub_group         pr010.prdsubgrp%TYPE;
        ln_charging_basis            gla.gl_crgbas%TYPE;
        ln_product_charge_basis      po010.product_charge_basis%TYPE := 0;
        lv_charge_adjustment_type_3  gla.gl_crgadjtyp3%TYPE;
        ln_charge_adjustment_rate_3  gla.gl_crgadjrte3%TYPE;
        lv_charge_adjustment_type_4  gla.gl_crgadjtyp4%TYPE;
        ln_charge_adjustment_rate_4  gla.gl_crgadjrte4%TYPE;
        ln_standard_contract_charge  pr190.tblval1%TYPE;
        ln_error_number              gla.gl_glgerr%TYPE;
        lv_error_area                gla.gl_glgerrare%TYPE;
        lv_error_code                VARCHAR2(1000);
        ln_dummy                     NUMBER;

        e_migrated_logic_error       EXCEPTION;

    BEGIN

        -- Initialising global variables
        wrp_initialise.p_start_up;

        -- Look up the product sub group
        lv_product_sub_group := pck_productdata.f_get_product_sub_group(
        pv_product_reference => pv_product_reference
        ,pn_product_version   => pn_product_version);

        -- Check if policy reference has been passed through
        IF pn_policy_reference != 0 THEN

            -- For policy, check f_charge_basis directly
            ln_product_charge_basis := pck_policy_details.f_charge_basis(pn_policy_reference => pn_policy_reference);

        -- No policy reference - check for scheme details
        ELSE
            IF pn_scheme_reference != 0 THEN

                IF pck_utility.f_dtcnv (pd_currency_date) != 0 THEN

                    -- Get charge basis from sceme details
                    ln_product_charge_basis := pck_scheme_charge_basis_api.f_charge_basis(
                                                         pv_scheme_category    =>  pv_scheme_category
                                                        ,pn_scheme_reference   =>  pn_scheme_reference
                                                        ,pd_effective_date     =>  pd_currency_date
                                                        ,pn_no_data_found_val  =>  0);
                END IF;
            END IF;
        END IF;

        /******************************************************************************************************
        ** Policies that have been DWP charge capped should be treated as having a product charge basis of 1 **
        ** when mining the TV amc amount.  Non charge capped policies continue to function the same way.     **
        ******************************************************************************************************/
        IF pck_capped_charges.f_scheme_has_charge_cap(pn_polref => pn_policy_reference) THEN
            wrp_product_table.p_get_stndrd_cntrct_chrg
                (pv_increment_type       => 'TV'
                ,pv_product_reference    => pv_product_reference
                ,pn_product_version      => pn_product_version
                ,pn_product_charge_basis => 1
                ,pn_effective_date       => pd_currency_date - TO_DATE('01-01-1900','dd-mm-yyyy')
                ,pn_fund_charge          => ln_dummy
                ,pn_stndrd_cntrct_chrg   => pn_tv_amc
                ,pn_error_status         => ln_error_number);
            pn_tv_amc := 1 - pn_tv_amc;
        ELSE
            -- Get the AMC
            cml_gpsamc.p_get_amc(
                         pv_product_reference         =>  pv_product_reference
                        ,pn_product_version           =>  pn_product_version
                        ,pv_product_sub_group         =>  lv_product_sub_group
                        ,pv_increment_type            =>  'TV'
                        ,pd_currency_date             =>  pd_currency_date
                        ,pn_commission_type           =>  CASE pn_fbr_commission
                                                              WHEN 0 THEN 3
                                                              ELSE 4
                                                          END
                        ,pn_level_single_commission   =>  pn_sp_rate
                        ,pn_renewal_commission        =>  0
                        ,pn_initial_commission_rate   =>  0
                        ,pn_fbr_commission            =>  pn_fbr_commission
                        ,pn_commission_basis          =>  CASE pn_fbr_commission
                                                              WHEN 0 THEN 0
                                                              ELSE 5
                                                          END
                        ,pv_pr_vesting_year           =>  00
                        ,pn_term_to_65                =>  pn_term_to_65
                        ,pn_charge_basis              =>  ln_charging_basis
                        ,pd_increment_maturity        =>  pd_increment_maturity
                        ,pn_amc                       =>  pn_tv_amc
                        ,pn_standard_contract_charge  =>  ln_standard_contract_charge
                        ,pv_charge_adjustment_type_3  =>  lv_charge_adjustment_type_3
                        ,pn_charge_adjustment_rate_3  =>  ln_charge_adjustment_rate_3
                        ,pv_charge_adjustment_type_4  =>  lv_charge_adjustment_type_4
                        ,pn_charge_adjustment_rate_4  =>  ln_charge_adjustment_rate_4
                        ,pn_error_number              =>  ln_error_number
                        ,pv_error_area                =>  lv_error_area
                        ,pn_product_charge_basis      =>  ln_product_charge_basis);
        END IF;

        -- Check if errors were returned, if so then return them to the calling program
        IF ln_error_number != 0 THEN
            RAISE e_migrated_logic_error;
        END IF;

        EXCEPTION
        WHEN e_migrated_logic_error THEN
            lv_error_code := SUBSTR('Error: '
                                     || lv_error_area
                                     || LPAD(ln_error_number,4,0)
                                     || ' - '
                                     || pck_prod_support.f_error_msg(lv_error_area,ln_error_number)
                                    ,1
                                    ,1000);

            pck_err.p_handle(pv_err_code      => 'LOGIC_ERROR'
                            ,pt_err_param     => pck_err.t_err_param('cml_gpsamc','web_commission')
                            ,pn_err_occurance => 1
                            ,pv_add_text      => lv_error_code
                            ,pb_log_err       => TRUE
                            ,pb_re_raise      => TRUE);

    END p_get_tv_amc;

    /**************************************************************************************
    -- Procedure name    : p_get_tv_amc
    -- Description       : Procedure to calculate TV AMC.  Called from pck_group_tvs_in
    -- Parameters        :
    -- pn_scheme_reference         IN   sc010.schref%TYPE      Scheme Reference
    -- pv_scheme_category          IN   sc010.schcat%TYPE      Scheme Category
    -- pn_policy_reference         IN   po010.polref%TYPE      Policy Reference
    -- pv_product_reference        IN   pr010.prdref%TYPE      Product Reference
    -- pn_product_version          IN   pr010.prdvrs_no%TYPE   Product Version
    -- pd_currency_date            IN   DATE                   Currency Date
    -- pd_increment_maturity       IN   DATE                   Increment Maturity Date
    -- pn_sp_rate                  IN   NUMBER                 Initial Commission Rate
    -- pn_fbr_commission           IN   NUMBER                 FBRC Commission Rate
    -- pn_term_to_65               IN   gll.gl_trmdec_65%TYPE  Term to 65
    -- pn_tv_amc                   OUT  NUMBER                 TV AMC Amount
    -- pn_charge_adjustment_rate_4 OUT  gla.gl_crgadjrte4%TYPE Crgadjrte4 amount
    ****************************************************************************************/
    PROCEDURE p_get_tv_amc(pn_scheme_reference      IN  sc010.schref%TYPE
                          ,pv_scheme_category       IN  sc010.schcat%TYPE
                          ,pn_policy_reference      IN  po010.polref%TYPE
                          ,pv_product_reference     IN  pr010.prdref%TYPE
                          ,pn_product_version       IN  pr010.prdvrs_no%TYPE
                          ,pd_currency_date         IN  DATE
                          ,pd_increment_maturity    IN  DATE
                          ,pn_sp_rate               IN  NUMBER
                          ,pn_fbr_commission        IN  NUMBER
                          ,pn_term_to_65            IN  gll.gl_trmdec_65%TYPE
                          ,pn_tv_amc                OUT NUMBER
                          ,pn_charge_adjustment_rate_4  OUT gla.gl_crgadjrte4%TYPE)
    IS
        lv_product_sub_group         pr010.prdsubgrp%TYPE;
        ln_charging_basis            gla.gl_crgbas%TYPE;
        ln_product_charge_basis      po010.product_charge_basis%TYPE := 0;
        lv_charge_adjustment_type_3  gla.gl_crgadjtyp3%TYPE;
        ln_charge_adjustment_rate_3  gla.gl_crgadjrte3%TYPE;
        lv_charge_adjustment_type_4  gla.gl_crgadjtyp4%TYPE;
        ln_standard_contract_charge  pr190.tblval1%TYPE;
        ln_error_number              gla.gl_glgerr%TYPE;
        lv_error_area                gla.gl_glgerrare%TYPE;
        lv_error_code                VARCHAR2(1000);

        e_migrated_logic_error       EXCEPTION;

    BEGIN

        -- Initialising global variables
        wrp_initialise.p_start_up;

        -- Look up the product sub group
        lv_product_sub_group := pck_productdata.f_get_product_sub_group(
        pv_product_reference => pv_product_reference
        ,pn_product_version   => pn_product_version);

        -- Check if policy reference has been passed through
        IF pn_policy_reference != 0 THEN

            -- For policy, check f_charge_basis directly
            ln_product_charge_basis := pck_policy_details.f_charge_basis(pn_policy_reference => pn_policy_reference);

        -- No policy reference - check for scheme details
        ELSE
            IF pn_scheme_reference != 0 THEN

                IF pck_utility.f_dtcnv (pd_currency_date) != 0 THEN

                    -- Get charge basis from sceme details
                    ln_product_charge_basis := pck_scheme_charge_basis_api.f_charge_basis(
                                                         pv_scheme_category    =>  pv_scheme_category
                                                        ,pn_scheme_reference   =>  pn_scheme_reference
                                                        ,pd_effective_date     =>  pd_currency_date
                                                        ,pn_no_data_found_val  =>  0);
                END IF;
            END IF;
        END IF;

        -- Get the AMC
        cml_gpsamc.p_get_amc(
                     pv_product_reference         =>  pv_product_reference
                    ,pn_product_version           =>  pn_product_version
                    ,pv_product_sub_group         =>  lv_product_sub_group
                    ,pv_increment_type            =>  'TV'
                    ,pd_currency_date             =>  pd_currency_date
                    ,pn_commission_type           =>  CASE pn_fbr_commission
                                                          WHEN 0 THEN 3
                                                          ELSE 4
                                                      END
                    ,pn_level_single_commission   =>  pn_sp_rate
                    ,pn_renewal_commission        =>  0
                    ,pn_initial_commission_rate   =>  0
                    ,pn_fbr_commission            =>  pn_fbr_commission
                    ,pn_commission_basis          =>  CASE pn_fbr_commission
                                                          WHEN 0 THEN 0
                                                          ELSE 5
                                                      END
                    ,pv_pr_vesting_year           =>  00
                    ,pn_term_to_65                =>  pn_term_to_65
                    ,pn_charge_basis              =>  ln_charging_basis
                    ,pd_increment_maturity        =>  pd_increment_maturity
                    ,pn_amc                       =>  pn_tv_amc
                    ,pn_standard_contract_charge  =>  ln_standard_contract_charge
                    ,pv_charge_adjustment_type_3  =>  lv_charge_adjustment_type_3
                    ,pn_charge_adjustment_rate_3  =>  ln_charge_adjustment_rate_3
                    ,pv_charge_adjustment_type_4  =>  lv_charge_adjustment_type_4
                    ,pn_charge_adjustment_rate_4  =>  pn_charge_adjustment_rate_4
                    ,pn_error_number              =>  ln_error_number
                    ,pv_error_area                =>  lv_error_area
                    ,pn_product_charge_basis      =>  ln_product_charge_basis);

        -- Check if errors were returned, if so then return them to the calling program
        IF ln_error_number != 0 THEN
            RAISE e_migrated_logic_error;
        END IF;

        EXCEPTION
        WHEN e_migrated_logic_error THEN
            lv_error_code := SUBSTR('Error: '
                                     || lv_error_area
                                     || LPAD(ln_error_number,4,0)
                                     || ' - '
                                     || pck_prod_support.f_error_msg(lv_error_area,ln_error_number)
                                    ,1
                                    ,1000);

            pck_err.p_handle(pv_err_code      => 'LOGIC_ERROR'
                            ,pt_err_param     => pck_err.t_err_param('cml_gpsamc','web_commission')
                            ,pn_err_occurance => 1
                            ,pv_add_text      => lv_error_code
                            ,pb_log_err       => TRUE
                            ,pb_re_raise      => TRUE);

    END p_get_tv_amc;

    /*******************************************************************************
    -- %Description Function to return maximum amount of FAF allowed on NIPP incs
    -- %param         pv_product_reference     IN pr010.prdref%TYPE
                    pn_product_version         IN pr010.prdvrs_no%TYPE
                    pv_increment_type         IN pr020.inrtyp%TYPE
    -- %return         ln_maximum_FAF
    -- %raises        n/a
    *******************************************************************************/
    FUNCTION f_maximum_FAF_amount    (pv_product_reference     IN pr010.prdref%TYPE
                                    ,pn_product_version     IN pr010.prdvrs_no%TYPE
                                    ,pv_increment_type         IN pr020.inrtyp%TYPE) RETURN NUMBER IS
        ln_maximum_FAF     NUMBER(10,2);
        ln_error_flag    PLS_INTEGER;
    BEGIN
        -- call wrapper to access DFLCSN variable key table
        wrp_product_table.p_get_maximum_FAF_amt    (pv_product_reference     => pv_product_reference
                                                ,pn_product_version     => pn_product_version
                                                ,pv_increment_type         => pv_increment_type
                                                ,pn_rp_max_faf_amount     => ln_maximum_FAF
                                                ,pn_error_status         => ln_error_flag);

        -- if error found, return zero values
        IF ln_error_flag != 0 THEN
            ln_maximum_FAF        := 99999999.99;
        END IF;

        RETURN ln_maximum_FAF;
    END f_maximum_FAF_amount;

    /*******************************************************************************
    -- %Description Update CM240 to have a new status depending on input params
    -- %param       pn_old_rec_status IN cm240.csnsta%TYPE
    -- %param       pn_new_rec_status IN cm240.csnsta%TYPE
    -- %param       pv_audaplcde      IN cm240.audaplcde%TYPE
    -- %param       pn_audstf_no      IN cm240.audstf_no%TYPE
    -- %raises        n/a
    *******************************************************************************/

    PROCEDURE p_update_cm240_status (pn_old_rec_status IN cm240.csnsta%TYPE
                                    ,pn_new_rec_status IN cm240.csnsta%TYPE
                                    ,pv_audaplcde      IN cm240.audaplcde%TYPE
                                    ,pn_audstf_no      IN cm240.audstf_no%TYPE)
    IS

    BEGIN
        -- Register the module and action name.
        pck_process_info.p_register_module (pv_module_name => 'PCK_COMMISSION'
                                           ,pv_action_name => 'P_UPDATE_CM240_STATUS');

        UPDATE cm240
        SET csnsta     = pn_new_rec_status
           ,audaplcde  = pv_audaplcde
           ,audstf_no  = pn_audstf_no
           ,audupd_id  = MOD(audupd_id + 1,100)
           ,audupddte  = lpn_system_date
        WHERE csnsta = pn_old_rec_status;

    EXCEPTION
        WHEN OTHERS THEN
            -- Error logged and reraised
            pck_err.p_handle(pv_err_code      => 'CANNOT_UPDATE_RECORD'
                            ,pt_err_param     => pck_err.t_err_param('CM240'
                                                                    ,SUBSTR(SQLERRM,1,100))
                            ,pv_subprcss_name => 'p_update_CM240_status'
                            ,pn_err_occurance => 0
                            ,pv_add_text      => ' '
                            ,pb_log_err       => TRUE
                            ,pb_re_raise      => TRUE);
    END p_update_cm240_status;


    /*******************************************************************************
    -- %Description Update CM200 to have a new CSNSTSTYP depending on input params
    -- %param       pn_old_rec_type IN cm240.csnststyp%TYPE
    -- %param       pn_new_rec_type IN cm240.csnststyp%TYPE
    -- %param       pv_audaplcde    IN cm240.audaplcde%TYPE
    -- %param       pn_audstf_no    IN cm240.audstf_no%TYPE
    -- %raises        n/a
    *******************************************************************************/

    PROCEDURE p_update_cm200_csnststyp (pn_old_rec_type IN cm200.csnststyp%TYPE
                                       ,pn_new_rec_type IN cm200.csnststyp%TYPE
                                       ,pv_audaplcde    IN cm200.audaplcde%TYPE
                                       ,pn_audstf_no    IN cm200.audstf_no%TYPE)
    IS

    BEGIN
        -- Register the module and action name.
        pck_process_info.p_register_module (pv_module_name => 'PCK_COMMISSION'
                                           ,pv_action_name => 'P_UPDATE_CM200_CSNSTSTYP');

        UPDATE cm200
        SET csnststyp  = pn_new_rec_type
           ,audaplcde  = pv_audaplcde
           ,audstf_no  = pn_audstf_no
           ,audupd_id  = MOD(audupd_id + 1,100)
           ,audupddte  = lpn_system_date
        WHERE csnststyp = pn_old_rec_type;

    EXCEPTION
        WHEN OTHERS THEN
            -- Error logged and reraised
            pck_err.p_handle(pv_err_code      => 'CANNOT_UPDATE_RECORD'
                            ,pt_err_param     => pck_err.t_err_param('CM200'
                                                                    ,SUBSTR(SQLERRM,1,100))
                            ,pv_subprcss_name => 'p_update_CM200_csnststyp'
                            ,pn_err_occurance => 0
                            ,pv_add_text      => ' '
                            ,pb_log_err       => TRUE
                            ,pb_re_raise      => TRUE);

    END p_update_cm200_csnststyp;


    /*******************************************************************************
    -- %Description     Procedure to update the CM240 status for an ITR
    -- %param           pn_itr_no         IN cm240.itr_no%TYPE
    -- %param           pn_from_status    IN cm240.csnsta%TYPE
    -- %param           pn_to_status      IN cm240.csnsta%TYPE
    -- %param           pn_efvdte         IN cm240.efvdte%TYPE
    -- %param           pn_audit_staff_no IN cm240.audstf_no%TYPE
    -- %param           pv_audit_apl_code IN cm240.audaplcde%TYPE
    -- %raises          None
    *******************************************************************************/
    PROCEDURE p_update_cm240_status(pn_itr_no         IN cm240.itr_no%TYPE
                                   ,pn_from_status    IN cm240.csnsta%TYPE
                                   ,pn_to_status      IN cm240.csnsta%TYPE
                                   ,pn_efvdte         IN cm240.efvdte%TYPE
                                   ,pn_audit_staff_no IN cm240.audstf_no%TYPE
                                   ,pv_audit_apl_code IN cm240.audaplcde%TYPE)
    IS
    BEGIN
        pck_process_info.p_register_module(pv_module_name => 'PCK_COMMISSION'
                                          ,pv_action_name => 'p_update_cm240_status');

        UPDATE cm240 c
        SET    c.csnsta    = pn_to_status
              ,c.audaplcde = pv_audit_apl_code
              ,c.audstf_no = pn_audit_staff_no
              ,c.audupddte = lpn_system_date
              ,c.audupdtme = LPCN_SYS_TIME
              ,c.audupd_id = MOD(c.audupd_id + 1, 100)
        WHERE  c.itr_no    = pn_itr_no
        AND    c.csnsta    = pn_from_status
        AND    c.efvdte    >= NVL(pn_efvdte, c.efvdte)
        AND    c.csntyp    NOT IN ('A','B','E','G');   -- Ignore Initial charge types


    END p_update_cm240_status;

    /*******************************************************************************
    -- %Description     Procedure to update the CM640 status for an ITR
    -- %param           pn_itr_no         IN cm640.itr_no%TYPE
    -- %param           pn_from_status    IN cm640.csnsta%TYPE
    -- %param           pn_to_status      IN cm640.csnsta%TYPE
    -- %param           pn_audit_staff_no IN cm240.audstf_no%TYPE
    -- %param           pv_audit_apl_code IN cm240.audaplcde%TYPE
    -- %raises          None
    *******************************************************************************/
    PROCEDURE p_update_cm640_status(pn_itr_no         IN cm640.itr_no%TYPE
                                   ,pn_from_status    IN cm640.csnsta%TYPE
                                   ,pn_to_status      IN cm640.csnsta%TYPE
                                   ,pn_audit_staff_no IN cm240.audstf_no%TYPE
                                   ,pv_audit_apl_code IN cm240.audaplcde%TYPE)
    IS
    BEGIN
        pck_process_info.p_register_module(pv_module_name => 'PCK_COMMISSION'
                                          ,pv_action_name => 'p_update_cm640_status');

        UPDATE cm640 c
        SET    c.csnsta    = pn_to_status
              ,c.audaplcde = pv_audit_apl_code
              ,c.audstf_no = pn_audit_staff_no
              ,c.audupddte = lpn_system_date
              ,c.audupdtme = LPCN_SYS_TIME
              ,c.audupd_id = MOD(c.audupd_id + 1, 100)
        WHERE  c.itr_no    = pn_itr_no
        AND    c.csnsta    = pn_from_status;

    END p_update_cm640_status;

    /********************************************************************************************
    -- %Description     Procedure to retrieve commission switch off date
    -- %param           pn_scheme_reference      IN  commission_switch_off.scheme_reference%TYPE
    -- %param           pv_scheme_category       IN  commission_switch_off.scheme_category%TYPE
    -- %param           pd_comm_switch_off_date  OUT commission_switch_off.switch_off_date%TYPE
    -- %param           pn_status                OUT commission_switch_off.status%TYPE
    -- %raises          NONE
    *********************************************************************************************/
    PROCEDURE p_commission_switch_off_date (pn_scheme_reference            IN  commission_switch_off.scheme_reference%TYPE
                                           ,pv_scheme_category             IN  commission_switch_off.scheme_category%TYPE
                                           ,pd_commission_switch_off_date  OUT commission_switch_off.switch_off_date%TYPE
                                           ,pn_status                      OUT commission_switch_off.status%TYPE)
    IS
        CURSOR cu_commission_switch_off (pcn_scheme_ref  IN  commission_switch_off.scheme_reference%TYPE
                                        ,pcv_scheme_cat  IN  commission_switch_off.scheme_category%TYPE)
        IS
            SELECT  csf.switch_off_date
                   ,csf.status
            FROM    commission_switch_off csf
            WHERE   csf.scheme_reference = pcn_scheme_ref
            AND     csf.scheme_category  = pcv_scheme_cat
            AND     csf.status           IN (30,50);
    BEGIN
        pck_process_info.p_register_module(pv_module_name => 'PCK_COMMISSION'
                                          ,pv_action_name => 'p_commission_switch_off_date');

        OPEN cu_commission_switch_off (pn_scheme_reference
                                      ,pv_scheme_category);

        FETCH cu_commission_switch_off INTO pd_commission_switch_off_date
                                           ,pn_status;
        CLOSE cu_commission_switch_off;
    END p_commission_switch_off_date;

    /********************************************************************************************
    -- %Description     Overloaded procedure to retrieve commission switch off date
    -- %param           pn_policy_reference            IN  po010.polref%TYPE
    -- %param           pd_commission_switch_off_date  OUT commission_switch_off.switch_off_date%TYPE
    -- %raises          None
    *********************************************************************************************/
    PROCEDURE p_commission_switch_off_date(pn_policy_reference            IN  po010.polref%TYPE
                                          ,pd_commission_switch_off_date  OUT commission_switch_off.switch_off_date%TYPE)
    IS
        lv_scheme_category         commission_switch_off.scheme_category%TYPE;
        ln_scheme_reference        commission_switch_off.scheme_reference%TYPE;
        ln_status                  commission_switch_off.status%TYPE;
        ln_stapol                  sc010.stapol%TYPE;
    BEGIN
        pck_process_info.p_register_module(pv_module_name => 'PCK_COMMISSION'
                                          ,pv_action_name => 'p_commission_switch_off');

        pck_scheme_details.p_get_scheme_no_status (pn_polref    => pn_policy_reference
                                                  ,pv_schcat    => lv_scheme_category
                                                  ,pn_schref    => ln_scheme_reference
                                                  ,pn_stapol    => ln_stapol);

        p_commission_switch_off_date (pn_scheme_reference           => ln_scheme_reference
                                     ,pv_scheme_category            => lv_scheme_category
                                     ,pd_commission_switch_off_date => pd_commission_switch_off_date
                                     ,pn_status                     => ln_status);
    END p_commission_switch_off_date;

    /*************************************************************************************************
    -- %Description     Procedure to set OGF end date of member policies to Commission switch off date
    -- %param           pn_schref          IN commission_switch_off.scheme_reference%TYPE
    -- %param           pv_schcat          IN commission_switch_off.scheme_reference%TYPE
    -- %param           pv_fndtrntyp       IN pa020.fndtrntyp%TYPE
    -- %param           pn_switch_off_date IN NUMBER
    -- %raises          NONE
    *************************************************************************************************/
    PROCEDURE p_update_ogf_end_date (pn_schref          IN commission_switch_off.scheme_reference%TYPE
                                    ,pv_schcat          IN commission_switch_off.scheme_category%TYPE
                                    ,pv_fndtrntyp       IN pa020.fndtrntyp%TYPE
                                    ,pn_switch_off_date IN NUMBER)
    IS
        CURSOR cu_policy_in_scheme(pcn_scheme_reference IN co040.cliref%TYPE
                                  ,pcv_scheme_category  IN co040.clicat%TYPE)
        IS
            SELECT co.polref
            FROM   co040 co
            WHERE  co.cliref  =  pcn_scheme_reference
            AND    co.clicat  =  pcv_scheme_category
            AND    co.rolref  =  'SCH'
            AND    co.staxrf  =  30
            AND    co.maint  !=  'D';
    BEGIN
        pck_process_info.p_register_module(pv_module_name => 'PCK_COMMISSION'
                                          ,pv_action_name => 'p_update_ogf_end_date');

        FOR lr_policy IN cu_policy_in_scheme(pcn_scheme_reference => pn_schref
                                            ,pcv_scheme_category  => pv_schcat) LOOP

            UPDATE  pa020 pa
            SET     pa.enddte     =  pn_switch_off_date
                   ,pa.audaplcde  =  lpr_audit_info.audit_application_code
                   ,pa.audstf_no  =  lpr_audit_info.audit_staff_number
                   ,pa.audupd_id  =  MOD(pa.audupd_id + 1, 100)
                   ,pa.audupddte  =  lpn_system_date
                   ,pa.audupdtme  =  LPCN_SYS_TIME
            WHERE   pa.sta_pa     =  30
            AND     pa.polref     =  lr_policy.polref
            AND     pa.fndtrntyp  =  pv_fndtrntyp;
        END LOOP;
    END p_update_ogf_end_date;

    /********************************************************************************************
    -- %Description     Procedure to insert or update into commission switch off table
    -- %param           pv_scheme_category      IN  commission_switch_off.scheme_category%TYPE
    -- %param           pn_scheme_reference     IN  commission_switch_off.scheme_reference%TYPE
    -- %param           pn_status               IN  commission_switch_off.status%TYPE DEFAULT 30
    -- %param           pd_switch_off_date      IN  commission_switch_off.switch_off_date%TYPE
    -- %raises          WHEN OTHERS
    *********************************************************************************************/
    PROCEDURE p_update_comm_switch_off (pv_scheme_category      IN  commission_switch_off.scheme_category%TYPE
                                       ,pn_scheme_reference     IN  commission_switch_off.scheme_reference%TYPE
                                       ,pn_status               IN  commission_switch_off.status%TYPE  DEFAULT 30
                                       ,pd_switch_off_date      IN  commission_switch_off.switch_off_date%TYPE)
    IS
        CURSOR cu_commission_switch_off (pcn_scheme_reference     IN  commission_switch_off.scheme_reference%TYPE
                                        ,pcv_scheme_category      IN  commission_switch_off.scheme_category%TYPE)
        IS
            SELECT *
            FROM   commission_switch_off csf
            WHERE  csf.scheme_reference = pcn_scheme_reference
            AND    csf.scheme_category  = pcv_scheme_category
            AND    csf.status           = 30;

        lr_commission_switch_off  commission_switch_off%ROWTYPE;
    BEGIN
        pck_process_info.p_register_module(pv_module_name => 'PCK_COMMISSION'
                                          ,pv_action_name => 'p_update_comm_switch_off');

        pck_audits.p_process_audits (pv_process_name => 'PCK_COMMISSION'
                                    ,pr_audits       => lpr_audit_info);

        IF pd_switch_off_date IS NULL THEN
            DELETE commission_switch_off csf
            WHERE  csf.scheme_reference = pn_scheme_reference
            AND    csf.scheme_category  = pv_scheme_category;
        ELSE
            OPEN cu_commission_switch_off (pn_scheme_reference
                                          ,pv_scheme_category);

            FETCH cu_commission_switch_off INTO lr_commission_switch_off;
            CLOSE cu_commission_switch_off;

            IF lr_commission_switch_off.scheme_reference IS NOT NULL THEN
                UPDATE commission_switch_off csf
                SET    csf.switch_off_date  =  pd_switch_off_date
                      ,csf.status           =  pn_status
                      ,csf.audit_id         =  lr_commission_switch_off.audit_id + 1
                      ,csf.audit_date       =  lpd_system_date
                      ,csf.audit_apl_cde    =  lpr_audit_info.audit_application_code
                      ,csf.audit_stf_no     =  lpr_audit_info.audit_staff_number
                WHERE  csf.scheme_reference =  pn_scheme_reference
                AND    csf.scheme_category  =  pv_scheme_category;
            ELSE
                INSERT INTO commission_switch_off
                     (scheme_category
                     ,scheme_reference
                     ,switch_off_date
                     ,status
                     ,audit_id
                     ,audit_date
                     ,audit_apl_cde
                     ,audit_stf_no)
                VALUES
                     (pv_scheme_category
                     ,pn_scheme_reference
                     ,pd_switch_off_date
                     ,pn_status
                     ,1
                     ,lpd_system_date
                     ,lpr_audit_info.audit_application_code
                     ,lpr_audit_info.audit_staff_number);
            END IF;
        END IF;
    EXCEPTION
        WHEN OTHERS THEN
            pck_err.p_handle (pv_err_code  => 'FATAL_EXCEPTION'
                             ,pv_add_text  => 'Unable to update or create commission switch off record for scheme :' ||
                                               pv_scheme_category || ' '|| TO_CHAR(pn_scheme_reference)
                             ,pb_log_err   => TRUE
                             ,pb_re_raise  => TRUE);
    END p_update_comm_switch_off;

    /********************************************************************************************
    -- %Description     Procedure to insert or update into commission switch off table
    -- %param           pn_scheme_reference     IN  commission_switch_off.scheme_reference%TYPE
    -- %param           pv_scheme_category      IN  commission_switch_off.scheme_category%TYPE
    -- %param           pd_switch_off_date      IN  commission_switch_off.switch_off_date%TYPE
    -- %param           pn_status               IN  commission_switch_off.status%TYPE DEFAULT 30
    -- %raises          NONE
    *********************************************************************************************/
    PROCEDURE p_upd_com_switch_off_n_ogf_trg (pn_scheme_reference     IN  commission_switch_off.scheme_reference%TYPE
                                             ,pv_scheme_category      IN  commission_switch_off.scheme_category%TYPE
                                             ,pd_switch_off_date      IN  commission_switch_off.switch_off_date%TYPE
                                             ,pn_status               IN  commission_switch_off.status%TYPE DEFAULT 30)
    IS
        ln_switch_off_date    NUMBER(5) := pck_utility.f_dtcnv (pd_switch_off_date);
    BEGIN
        pck_process_info.p_register_module (pv_module_name => 'PCK_COMMISSION'
                                           ,pv_action_name => 'p_upd_com_switch_off_n_ogf_trg');

        p_update_comm_switch_off (pv_scheme_category
                                 ,pn_scheme_reference
                                 ,pn_status
                                 ,pd_switch_off_date);

        p_update_ogf_end_date (pn_schref          => pn_scheme_reference
                              ,pv_schcat          => pv_scheme_category
                              ,pv_fndtrntyp       => 'OGF'
                              ,pn_switch_off_date => ln_switch_off_date);
    END p_upd_com_switch_off_n_ogf_trg;

    /********************************************************************************************
    -- %Description     Procedure to update commission switch off record to actioned
    -- %param           pn_scheme_reference     IN  commission_switch_off.scheme_reference%TYPE
    -- %param           pv_scheme_category      IN  commission_switch_off.scheme_category%TYPE
    -- %raises          NONE
    *********************************************************************************************/
    PROCEDURE p_upd_comm_switch_off_actioned (pn_scheme_reference     IN  commission_switch_off.scheme_reference%TYPE
                                             ,pv_scheme_category      IN  commission_switch_off.scheme_category%TYPE)
    IS
    BEGIN
        pck_process_info.p_register_module(pv_module_name => 'PCK_COMMISSION'
                                          ,pv_action_name => 'p_upd_comm_switch_off_actioned');


        UPDATE commission_switch_off csf
        SET    csf.status           =  50
              ,csf.audit_id         =  csf.audit_id + 1
              ,csf.audit_date       =  lpd_system_date
              ,csf.audit_apl_cde    =  lpr_audit_info.audit_application_code
              ,csf.audit_stf_no     =  lpr_audit_info.audit_staff_number
        WHERE  csf.scheme_reference =  pn_scheme_reference
        AND    csf.scheme_category  =  pv_scheme_category;
    END p_upd_comm_switch_off_actioned;

    /********************************************************************************************
    -- %Description     Overloaded procedure to update commission switch off date for a CPS scheme
    -- %param           pn_scheme_reference     IN  commission_switch_off.scheme_reference%TYPE
    -- %param           pv_scheme_category      IN  commission_switch_off.scheme_category%TYPE
    -- %param           pn_switch_off_date      IN  NUMBER
    -- %raises          others
    *********************************************************************************************/
    PROCEDURE p_update_cps_switch_off_date (pn_scheme_reference     IN  commission_switch_off.scheme_reference%TYPE
                                           ,pv_scheme_category      IN  commission_switch_off.scheme_category%TYPE
                                           ,pn_switch_off_date      IN  NUMBER)
    IS
        ld_switch_off_date    DATE;
    BEGIN
        pck_process_info.p_register_module(pv_module_name => 'PCK_COMMISSION'
                                          ,pv_action_name => 'p_update_cps_switch_off_date');

        IF pn_switch_off_date IS NOT NULL THEN
            ld_switch_off_date := pck_utility.f_dtcnv(pn_switch_off_date);
        END IF;

        p_upd_com_switch_off_n_ogf_trg(pn_scheme_reference => pn_scheme_reference
                                      ,pv_scheme_category  => pv_scheme_category
                                      ,pd_switch_off_date  => ld_switch_off_date
                                      ,pn_status           => 50);
    EXCEPTION
        WHEN OTHERS THEN
            pck_err.p_handle (pv_err_code        => 'ERRMSG'
                             ,pn_err_occurance   => 0
                             ,pv_add_text        => 'Error in p_update_switch_off_date'
                                                 || ' Scheme reference     : '  || TO_CHAR(pn_scheme_reference)
                                                 || ' Scheme category      : '  || pv_scheme_category
                                                 || ' switch off Date      : '  || TO_CHAR(pn_switch_off_date)
                             ,pb_log_err         => TRUE
                             ,pb_re_raise        => TRUE
                             ,pb_use_oracle_errm => TRUE);

    END p_update_cps_switch_off_date;

    /********************************************************************************************
    -- %Description     Procedure to update commission switch off date, Called from Change Details
    -- %param           pn_scheme_reference     IN  commission_switch_off.scheme_reference%TYPE
    -- %param           pv_scheme_category      IN  commission_switch_off.scheme_category%TYPE
    -- %param           pv_switch_off_date      IN  VARCHAR2
    -- %param           pv_switch_off_date_chg  IN  VARCHAR2
    -- %raises          others
    *********************************************************************************************/
    PROCEDURE p_update_switch_off_date (pn_scheme_reference     IN  commission_switch_off.scheme_reference%TYPE
                                       ,pv_scheme_category      IN  commission_switch_off.scheme_category%TYPE
                                       ,pv_switch_off_date      IN  VARCHAR2
                                       ,pv_switch_off_date_chg  IN  VARCHAR2)
    IS

        ld_switch_off_date    DATE;
    BEGIN
        pck_process_info.p_register_module(pv_module_name => 'PCK_COMMISSION'
                                          ,pv_action_name => 'p_update_switch_off_date');

        IF  pv_switch_off_date_chg = 'Y'    AND
            pv_switch_off_date IS NOT NULL  THEN
            ld_switch_off_date := TO_DATE(pv_switch_off_date , 'DD/MM/YYYY');
        END IF;

        p_upd_com_switch_off_n_ogf_trg (pn_scheme_reference => pn_scheme_reference
                                       ,pv_scheme_category  => pv_scheme_category
                                       ,pd_switch_off_date  => ld_switch_off_date);
    EXCEPTION
        WHEN OTHERS THEN
            pck_err.p_handle (pv_err_code        => 'ERRMSG'
                             ,pn_err_occurance   => 0
                             ,pv_add_text        => 'Error in p_update_switch_off_date'
                                                 || ' Scheme reference     : '  || TO_CHAR(pn_scheme_reference)
                                                 || ' Scheme category      : '  || pv_scheme_category
                                                 || ' switch off date chg  : '  || pv_switch_off_date_chg
                                                 || ' switch off Date      : '  || TO_CHAR(pv_switch_off_date)
                             ,pb_log_err         => TRUE
                             ,pb_re_raise        => TRUE
                             ,pb_use_oracle_errm => TRUE);
    END p_update_switch_off_date;

    /********************************************************************************************
    -- %Description     Procedure to update the cm420 table
    -- %param           pn_polref  IN   po010.polref%TYPE
    -- %raises          NONE
    *********************************************************************************************/
    PROCEDURE p_update_cm420_to_nil_comm (pn_polref IN po010.polref%TYPE)
    IS
    BEGIN
        pck_process_info.p_set_action(pv_action_name => 'p_update_cm420_to_nil_comm');

        UPDATE cm420 cm
        SET   cm.nilcsnind  = 'Y'
             ,cm.csnrtetyp  = 6
             ,cm.ocd_lc_sp  = 0
             ,cm.fb_rc_rte  = 0
             ,cm.fb_pymfrq  = ' '
             ,cm.nonidmrqd  = 'Y'
             ,cm.idmper     = 0
             ,cm.csnbas     = 7
             ,cm.ocdic_mlt  = 0.000
             ,cm.ocdrc_mlt  = 0.000
             ,cm.audaplcde  = lpr_audit_info.audit_application_code
             ,cm.audstf_no  = lpr_audit_info.audit_staff_number
             ,cm.audupd_id  = MOD(cm.audupd_id + 1, 100)
             ,cm.audupddte  = lpn_system_date
             ,cm.audupdtme  = LPCN_SYS_TIME
        WHERE cm.polref     = pn_polref
        AND   (cm.nilcsnind = 'N'
        OR     cm.fb_rc_rte > 0);

    END p_update_cm420_to_nil_comm;

    /********************************************************************************************
    -- %Description     Procedure to update FAF Overcoding to Dead.
    -- %param           pn_polref  IN   po100.polref%TYPE
    -- %raises          NONE
    *********************************************************************************************/
    PROCEDURE p_update_fafocdcsn_status (pn_polref  IN  po100.polref%TYPE)
    IS
        CURSOR cu_fafocdcsn (pcn_policy_reference  IN  po100.polref%TYPE)
        IS
            SELECT *
            FROM   po100
            WHERE  polref =  pcn_policy_reference
            AND    actref =  'FAFOCDCSN'
            AND    sta    =  30
            AND    maint !=  'D';
    BEGIN
        pck_process_info.p_set_action(pv_action_name => 'p_update_fafocdcsn_status');

        FOR lr_po100 IN cu_fafocdcsn (pcn_policy_reference => pn_polref)
        LOOP
            lr_po100.sta       := 60;

            lr_po100.audstf_no := lpr_audit_info.audit_staff_number;
            lr_po100.audaplcde := lpr_audit_info.audit_application_code;
            lr_po100.audupd_id := MOD(lr_po100.audupd_id + 1, 100);
            lr_po100.audupddte := lpn_system_date;
            lr_po100.audupdtme := LPCN_SYS_TIME;

            pck_activity.p_update_po100_row(pr_row => lr_po100);
        END LOOP;
    END p_update_fafocdcsn_status;

    /********************************************************************************************
    -- Procedure to insert Nil Commission record for DSS
    -- %param           pn_polref  IN   po100.polref%TYPE
    -- %raises          NONE
    *********************************************************************************************/
    PROCEDURE p_insert_nil_comm_DSS_record (pn_polref IN  po100.polref%TYPE)
    IS
        CURSOR cu_nil_comm_record (pcn_polref IN  po100.polref%TYPE) IS
        SELECT *
        FROM   cm420 c1
        WHERE  polref = pcn_polref
        AND    NOT EXISTS (SELECT 1
                           FROM   cm420 c2
                           WHERE  c1.polref = c2.polref
                           AND    c2.inrtyp = 'DSS')
        ORDER BY ovcdte DESC;

        lr_nil_comm_cm420 cm420%ROWTYPE;
    BEGIN
        pck_process_info.p_set_action(pv_action_name => 'p_insert_nil_comm_DSS_record');

        OPEN  cu_nil_comm_record (pcn_polref =>  pn_polref);
        FETCH cu_nil_comm_record INTO  lr_nil_comm_cm420;

        IF cu_nil_comm_record%FOUND THEN
            lr_nil_comm_cm420.inrtyp    := 'DSS';
            lr_nil_comm_cm420.inrref    := 1;

            lr_nil_comm_cm420.audupd_id := 1;
            lr_nil_comm_cm420.audstf_no := lpr_audit_info.audit_staff_number;
            lr_nil_comm_cm420.audaplcde := lpr_audit_info.audit_application_code;
            lr_nil_comm_cm420.audupddte := lpn_system_date;
            lr_nil_comm_cm420.audupdtme := LPCN_SYS_TIME;

            pck_proposal_ocd_commission.p_create_cm420 (pr_cm420 => lr_nil_comm_cm420);
        END IF;

        CLOSE cu_nil_comm_record;
    END p_insert_nil_comm_DSS_record;

    /********************************************************************
    -- %Description  Procedure to update scheme to Nil Commission
    -- %param    NONE
    -- %raises   NONE
    *********************************************************************/
    PROCEDURE p_upd_scheme_to_nil_commission
    IS
        CURSOR cu_commission_switch_off
        IS
            SELECT  *
            FROM    commission_switch_off
            WHERE   status = 30;

        CURSOR cu_scheme_sub_cat (pcv_schcat     sc010.schcat%TYPE
                                 ,pcn_schref     sc010.schref%TYPE)
        IS
            SELECT DISTINCT schsubcat
            FROM   sc010
            WHERE  schcat    =    pcv_schcat
            AND    schref    =    pcn_schref
            AND    stapol    =    30
            AND    enddte    =    99999
            AND    maint    !=    'D' ;

        ln_switch_off_date     NUMBER(5);
        ln_default_polref      sc010.dflpolref%TYPE;
        ln_next_day            NUMBER(5);
    BEGIN
        pck_process_info.p_register_module(pv_module_name => 'PCK_COMMISSION'
                                          ,pv_action_name => 'p_upd_scheme_to_nil_commission');

        FOR lr_comm_switch_off IN cu_commission_switch_off
        LOOP
            ln_switch_off_date := pck_utility.f_dtcnv(lr_comm_switch_off.switch_off_date);
            ln_next_day        := pck_dates.f_add_work_days (pn_date     => lpn_system_date
                                                            ,pn_add_days => 1);
            IF (ln_switch_off_date <= ln_next_day) THEN

                FOR rec_scheme_sub_cat IN cu_scheme_sub_cat (lr_comm_switch_off.scheme_category
                                                            ,lr_comm_switch_off.scheme_reference)
                LOOP
                    pck_scheme_details.p_get_default_policy (pv_scheme_category     => lr_comm_switch_off.scheme_category
                                                            ,pn_scheme_reference    => lr_comm_switch_off.scheme_reference
                                                            ,pv_scheme_subcategory  => rec_scheme_sub_cat.schsubcat
                                                            ,pn_default_policy      => ln_default_polref);

                    p_update_cm420_to_nil_comm (pn_polref => ln_default_polref);

                    p_insert_nil_comm_DSS_record (pn_polref => ln_default_polref);

                    p_update_fafocdcsn_status (pn_polref => ln_default_polref);
                END LOOP;

                p_upd_comm_switch_off_actioned (pn_scheme_reference => lr_comm_switch_off.scheme_reference
                                               ,pv_scheme_category  => lr_comm_switch_off.scheme_category);

            END IF;
        END LOOP;
    END p_upd_scheme_to_nil_commission;

    /********************************************************************************************
    -- %Description     Retrieve commission switch off date
    -- %param           pn_schref      IN  commission_switch_off.scheme_reference%TYPE DEFAULT NULL
    -- %param           pv_schcat      IN  commission_switch_off.scheme_category%TYPE DEFAULT NULL
    -- %param           pn_polref      IN  po010.polref%TYPE DEFAULT NULL
    -- %return          NUMBER
    *********************************************************************************************/
    FUNCTION f_commission_switch_off_date (pn_schref  IN  commission_switch_off.scheme_reference%TYPE DEFAULT NULL
                                          ,pv_schcat  IN  commission_switch_off.scheme_category%TYPE DEFAULT NULL
                                          ,pn_polref  IN  po010.polref%TYPE DEFAULT NULL)
    RETURN NUMBER
    IS
        ld_commission_switch_date  DATE;
        lv_scheme_category         commission_switch_off.scheme_category%TYPE;
        ln_scheme_reference        commission_switch_off.scheme_reference%TYPE;
        ln_status                  commission_switch_off.status%TYPE;
        ln_stapol                  sc010.stapol%TYPE;
    BEGIN
        pck_process_info.p_register_module(pv_module_name => 'PCK_COMMISSION'
                                          ,pv_action_name => 'f_commission_switch_off_date');

        IF NVL(pn_polref, 0) != 0 THEN

            pck_scheme_details.p_get_scheme_no_status (pn_polref    => pn_polref
                                                      ,pv_schcat    => lv_scheme_category
                                                      ,pn_schref    => ln_scheme_reference
                                                      ,pn_stapol    => ln_stapol);

            p_commission_switch_off_date (pn_scheme_reference           => ln_scheme_reference
                                         ,pv_scheme_category            => lv_scheme_category
                                         ,pd_commission_switch_off_date => ld_commission_switch_date
                                         ,pn_status                     => ln_status);
        ELSE
            p_commission_switch_off_date (pn_scheme_reference           => pn_schref
                                         ,pv_scheme_category            => pv_schcat
                                         ,pd_commission_switch_off_date => ld_commission_switch_date
                                         ,pn_status                     => ln_status);
        END IF;

        RETURN pck_common.f_dtcnv(ld_commission_switch_date);
    END f_commission_switch_off_date;

    /**********************************************************************************************
    -- %Description   check if an rp increment of a policy has a cancelled or NTUd increment status
    -- %param         pn_policy_reference     IN  co060.polref%TYPE
    -- %param         pv_increment_type       IN  co060.inrtyp%TYPE
    -- %param         pn_increment_reference  IN  co060.inrref%TYPE
    -- %return        BOOLEAN
    ***********************************************************************************************/
    FUNCTION f_cancelled_increment(pn_policy_reference     IN  co060.polref%TYPE
                                  ,pv_increment_type       IN  co060.inrtyp%TYPE
                                  ,pn_increment_reference  IN  co060.inrref%TYPE)
        RETURN BOOLEAN
    IS
        lb_cancelled_increment   BOOLEAN := FALSE;
        lr_increment_details     po020%ROWTYPE;
    BEGIN
        pck_process_info.p_set_action(pv_action_name => 'f_cancelled_increment');

        lr_increment_details := pck_policy_increment_details.f_get_row(pn_policy_reference => pn_policy_reference
                                                                      ,pv_increment_type   => pv_increment_type
                                                                      ,pn_increment_ref    => pn_increment_reference);
        -- check if increment is cancelled or NTUd
        IF lr_increment_details.stainr  = 61 AND
           lr_increment_details.extmod != 0  THEN
            lb_cancelled_increment := TRUE;
        END IF;

        RETURN lb_cancelled_increment;

    END f_cancelled_increment;

    /**********************************************************************************************
    -- %Description   check if an rp increment of a policy has initial commission
    -- %param         pn_policy_reference     IN  co060.polref%TYPE
    -- %param         pn_valuation_date       IN  co060.strdte%
    -- %param         pv_increment_type       IN  co060.inrtyp%TYPE
    -- %param         pn_increment_reference  IN  co060.inrref%TYPE
    -- %return        BOOLEAN
    ***********************************************************************************************/
    FUNCTION f_initial_commission_exist(pn_policy_reference     IN  co060.polref%TYPE
                                       ,pn_valuation_date       IN  co060.strdte%TYPE
                                       ,pv_increment_type       IN  co060.inrtyp%TYPE
                                       ,pn_increment_reference  IN  co060.inrref%TYPE)
        RETURN BOOLEAN
    IS
        CURSOR cu_initial_csn_CPS_ORD1(pcn_policy_reference IN co060.polref%TYPE
                                      ,pcn_valuation_date   IN co060.strdte%TYPE) IS
            SELECT 'Y'
            FROM   co060 co
            WHERE  co.polref = pcn_policy_reference
            AND    co.inrtyp = 'RVP'
            AND    co.maint != 'D'
            AND    co.csntyp = 'I'
            AND    co.sta IN (30,68)
            AND    co.strdte <= pcn_valuation_date
            AND    ROWNUM    = 1;

        CURSOR cu_initial_commission(pcn_policy_reference    IN co060.polref%TYPE
                                    ,pcv_increment_type      IN co060.inrtyp%TYPE
                                    ,pcn_increment_reference IN co060.inrref%TYPE
                                    ,pcn_valuation_date      IN co060.strdte%TYPE)
        IS
            SELECT 'Y'
            FROM   co060 co
            WHERE  co.polref  = pcn_policy_reference
            AND    co.inrtyp  = TRIM(pcv_increment_type)
            AND    co.inrref  = pcn_increment_reference
            AND    co.maint  != 'D'
            AND    co.csntyp  = 'I'
            AND    co.sta     IN (30,68)
            AND    co.strdte <= pcn_valuation_date
            AND    ROWNUM     = 1;

        lv_initial_commission_exist   VARCHAR2(1);
    BEGIN
        pck_process_info.p_set_action(pv_action_name => 'f_initial_commission_exist');

        -- for CPS ORD1 increments we need to check if there was commission on any of the RVPs
        IF pv_increment_type       = 'ORD' AND
           pn_increment_reference  = 1     THEN

            OPEN cu_initial_csn_CPS_ORD1(pn_policy_reference
                                        ,pn_valuation_date);
            FETCH cu_initial_csn_CPS_ORD1 INTO lv_initial_commission_exist;
            CLOSE cu_initial_csn_CPS_ORD1;

        ELSE
            OPEN cu_initial_commission(pn_policy_reference
                                      ,pv_increment_type
                                      ,pn_increment_reference
                                      ,pn_valuation_date);
            FETCH cu_initial_commission INTO lv_initial_commission_exist;
            CLOSE cu_initial_commission;
        END IF;

        RETURN NVL(lv_initial_commission_exist,'N') = 'Y';

    END f_initial_commission_exist;

    /*******************************************************************************
    -- %Description   get the premium payment term in years, difference between
    --                last premium due date for the rp increment and the first
    --                premium due date for the increment
    -- %param         pn_policy_reference     IN  po010.polref%TYPE
    -- %param         pv_increment_type       IN  po020.inrtyp%TYPE
    -- %param         pn_increment_reference  IN  po020.inrref%TYPE
    -- %param         pv_alteration_type      IN  po020.alttyp%TYPE
    -- %param         pn_start_date           IN  po020.strdte%TYPE
    -- %param         pn_incr_currency_date   IN  po020.inrcrcdte%TYPE
    -- %param         pv_main_benefit_type    IN  po020.maibentyp%TYPE
    -- %param         pd_paid_up_date         IN  DATE
    -- %param         pd_next_prem_due_date   IN  DATE
    -- return         NUMBER
    -- %raises        none
    *******************************************************************************/
    FUNCTION f_premium_payment_term_years(pd_incr_currency_date   IN  DATE
                                         ,pd_paid_up_date         IN  DATE
                                         ,pd_next_prem_due_date   IN  DATE)
       RETURN NUMBER
   IS
        ln_prem_payment_term_yrs   NUMBER(10,6) := 0;
    BEGIN
        pck_process_info.p_set_action(pv_action_name => 'f_premium_payment_term_years');

        -- derive the premium payment term in years
        IF pd_next_prem_due_date != pd_paid_up_date AND
           pd_paid_up_date       IS NOT NULL        THEN
            ln_prem_payment_term_yrs := FLOOR(MONTHS_BETWEEN(LEAST(pd_next_prem_due_date,pd_paid_up_date)
                                                                  ,pd_incr_currency_date))/12;
        ELSE
            ln_prem_payment_term_yrs := FLOOR(MONTHS_BETWEEN(pd_next_prem_due_date
                                                            ,pd_incr_currency_date))/12;
        END IF;

        RETURN NVL(ln_prem_payment_term_yrs,0);
    END f_premium_payment_term_years;

    -- Calculate the weighted ORD1 start date for CPS cases
    -- this should be a weighted average of the RVP start dates
    FUNCTION f_weighted_ord1_date(pn_policy_reference IN po010.polref%TYPE
                                 ,pn_valuation_date   IN hi020.strdte%TYPE)
    RETURN DATE IS

        CURSOR cu_weighted_date(pcn_policy_reference po010.polref%TYPE
                               ,pcn_valuation_date   hi020.strdte%TYPE
                               ,pcn_last_prem_date   fi720.duedte%TYPE)
        IS WITH history AS (SELECT hi.polref
                                  ,hi.inrref
                                  ,hi.strdte
                            FROM hi020 hi
                            WHERE  hi.polref = pcn_policy_reference
                            AND    hi.prdref IN ('TAL-GPS2','TAL-GPS3','TAL-GPS4')
                            AND    hi.inrtyp = 'RVP'
                            AND    hi.maint != 'D'
                            AND    hi.stainr IN (30,52)
                            AND    hi.spsdte = -99999
                            AND    hi.strdte <= pcn_valuation_date
                            GROUP BY hi.polref,hi.inrtyp,hi.inrref,hi.strdte)
                 ,scyrq AS (SELECT spl.polref
                                  ,spl.inrref
                                  ,spl.EMPPYMPCT
                                  ,spl.EMRPYMPCT
                            FROM po350 spl
                            WHERE spl.polref = pcn_policy_reference
                            AND   spl.inrtyp = 'RVP'
                            AND   pcn_last_prem_date BETWEEN spl.strdte AND spl.enddte
                            AND   spl.sta   NOT IN (99,80))
                ,payments AS (SELECT UNIQUE fi.trnprmgrp
                                    ,SUM(amt + admcrg) OVER (PARTITION BY fi.trnprmgrp) amount
                                    ,SUM(amt + admcrg) OVER (PARTITION BY NULL) total_amount
                              FROM  fi710 fi
                              WHERE fi.polref = pcn_policy_reference
                              AND   fi.maint  != 'D'
                              AND   fi.benref != 0
                              AND   fi.inrtyp = 'RVP'
                              AND   fi.sta    = 30
                              AND   fi.duedte = pcn_last_prem_date)
                ,combined AS (SELECT(CASE
                                      WHEN payments.trnprmgrp = 'EE' THEN
                                          payments.amount * (scyrq.emppympct/100) / payments.total_amount
                                      ELSE payments.amount * (scyrq.emrpympct/100) / payments.total_amount
                                      END) weighting
                                  ,history.strdte
                                  ,payments.trnprmgrp
                              FROM history
                                  ,scyrq
                                  ,payments
                            WHERE history.polref = scyrq.polref
                            AND   history.inrref = scyrq.inrref)
            SELECT TRUNC(SUM(weighting * strdte)) weighted_date
            FROM combined;

        ln_weighted_date  hi020.strdte%TYPE;
        ld_last_prem_date DATE;
    BEGIN
        pck_process_info.p_set_action(pv_action_name => 'f_weighted_ord1_date');

        ld_last_prem_date := pck_contributions.f_last_rp_premium_due_date(
                                                            pn_policy_reference => pn_policy_reference
                                                           ,pn_valuation_date   => pn_valuation_date
                                                           ,pv_increment_type   => 'RVP');

        OPEN cu_weighted_date(pcn_policy_reference => pn_policy_reference
                             ,pcn_valuation_date   => pn_valuation_date
                             ,pcn_last_prem_date   => pck_utility.f_dtcnv(ld_last_prem_date));
        FETCH cu_weighted_date INTO ln_weighted_date;
        CLOSE cu_weighted_date;

        RETURN pck_utility.f_dtcnv(ln_weighted_date);
    END f_weighted_ord1_date;

    -- get all the dates we need to calculate ppt and put
    PROCEDURE p_get_dates_for_ppt_and_put(pn_policy_reference     IN   po010.polref%TYPE
                                         ,pv_product_reference    IN   po010.prdref%TYPE
                                         ,pn_valuation_date       IN   po020.inrcrcdte%TYPE
                                         ,pv_increment_type       IN   po020.inrtyp%TYPE
                                         ,pn_increment_reference  IN   po020.inrref%TYPE
                                         ,pd_increment_start_date OUT DATE
                                         ,pd_next_prem_due_date   OUT DATE)
    IS
        CURSOR cu_increment_details(pcn_policy_reference      po020.polref%TYPE
                                   ,pcn_valuation_date        po020.inrcrcdte%TYPE
                                   ,pcv_increment_type        po020.inrtyp%TYPE
                                   ,pcn_increment_reference   po020.inrref%TYPE)
        IS  SELECT TO_DATE(inr.inrcrcdte + 2415021, 'J') start_date
            FROM po020 inr
            WHERE inr.polref = pcn_policy_reference
            AND  inr.prdref IN ('TAL-GPS2','TAL-CPS2','TAL-GPS3','TAL-CPS3','TAL-GPS4','TAL-CPS4')
            AND  inr.inrtyp    IN ('RVP','ORD')
            AND  inr.inrtyp     = TRIM(pcv_increment_type)
            AND  inr.inrref     = pcn_increment_reference
            AND  inr.maint     != 'D'
            AND  inr.stainr    >= 30
            AND  inr.stainr    != 61
            AND  inr.inrcrcdte <= pcn_valuation_date
            UNION
            SELECT TO_DATE(hi.strdte + 2415021, 'J') start_date
            FROM hi020  hi
            WHERE hi.polref = pcn_policy_reference
            AND   hi.prdref IN ('TAL-GPS2','TAL-CPS2','TAL-GPS3','TAL-CPS3','TAL-GPS4','TAL-CPS4')
            AND   hi.inrtyp = 'RVP'
            AND   hi.inrtyp = TRIM(pcv_increment_type)
            AND   hi.inrref = pcn_increment_reference
            AND   hi.maint != 'D'
            AND   hi.stainr IN (30,52)
            AND   hi.spsdte = -99999
            AND   hi.strdte <= pcn_valuation_date;

        ld_last_prem_due_date DATE;
        lv_premium_frequency  co072.frq%TYPE;
    BEGIN
        pck_process_info.p_set_action(pv_action_name => 'p_get_dates_for_ppt_and_put');

        -- get the start date for the increment
        -- CPS policies need to use a weighted date for ORD1
        IF pv_product_reference   LIKE 'TAL-CPS%' AND
           pv_increment_type      = 'ORD'         AND
           pn_increment_reference = 1             THEN
            pd_increment_start_date := f_weighted_ord1_date(pn_policy_reference => pn_policy_reference
                                                           ,pn_valuation_date   => pn_valuation_date);
        ELSE
            OPEN cu_increment_details(pn_policy_reference
                                     ,pn_valuation_date
                                     ,pv_increment_type
                                     ,pn_increment_reference);
            FETCH cu_increment_details INTO pd_increment_start_date;
            CLOSE cu_increment_details;
        END IF;

        IF pd_increment_start_date IS NOT NULL THEN

            -- this will be the same for all the increment for the same increment type
            ld_last_prem_due_date := pck_contributions.f_last_rp_premium_due_date(
                                                            pn_policy_reference => pn_policy_reference
                                                           ,pn_valuation_date   => pn_valuation_date
                                                           ,pv_increment_type   => CASE
                                                                                   WHEN pv_product_reference LIKE 'TAL-CPS%'
                                                                                   THEN 'ORD'
                                                                                   ELSE 'RVP'
                                                                                   END);
           -- if this is a CPS case with no ORD premiums, we won't get a
           -- last premium due date for the ORD so we need to try the RVP instead
           IF ld_last_prem_due_date IS NULL AND
              pv_product_reference LIKE 'TAL-CPS%' THEN
               ld_last_prem_due_date := pck_contributions.f_last_rp_premium_due_date(
                                                            pn_policy_reference => pn_policy_reference
                                                           ,pn_valuation_date   => pn_valuation_date
                                                           ,pv_increment_type   => 'RVP');
           END IF;

           -- get the premium frequency
            lv_premium_frequency := pck_contributions.f_get_premium_frequency(pn_policy_reference => pn_policy_reference);

            IF lv_premium_frequency  IS NOT NULL AND
               ld_last_prem_due_date IS NOT NULL THEN
                -- Add premium frequency to the last premium date to get the next premium due date
                pd_next_prem_due_date := pck_dates.f_add_frequency(pd_old_date  => ld_last_prem_due_date
                                                                  ,pv_frequency => lv_premium_frequency);
            END IF;
        END IF;
    END p_get_dates_for_ppt_and_put;

    /*******************************************************************************
    -- %Description   get the premium due term and paid up terms in years for
    --                an rp increment of a policy
    -- %param         pn_policy_reference       IN   po010.polref%TYPE
    -- %param         pd_product_reference      in   po010.prdref%TYPE
    -- %param         pn_valuation_date         IN   po020.inrcrcdte%TYPE
    -- %param         pv_increment_type         IN   po020.inrtyp%TYPE
    -- %param         pn_increment_reference    IN   po020.inrref%TYPE
    -- %param         pn_paid_up_term_yrs       OUT  NUMBER
    -- %param         pn_prem_payment_term_yrs  OUT  NUMBER
    -- %raises        none
    *******************************************************************************/
    PROCEDURE p_pup_and_due_premium_terms(pn_policy_reference       IN   po010.polref%TYPE
                                         ,pv_product_reference      IN   po010.prdref%TYPE
                                         ,pn_valuation_date         IN   po020.inrcrcdte%TYPE
                                         ,pv_increment_type         IN   po020.inrtyp%TYPE
                                         ,pn_increment_reference    IN   po020.inrref%TYPE
                                         ,pn_paid_up_term_yrs       OUT  NUMBER
                                         ,pn_prem_payment_term_yrs  OUT  NUMBER)
    IS
        ld_next_prem_due_date     DATE;
        ld_pup_date               DATE;
        ld_increment_start_date   DATE;
    BEGIN
        pck_process_info.p_set_action(pv_action_name => 'p_pup_and_due_premium_terms');

        p_get_dates_for_ppt_and_put(pn_policy_reference     => pn_policy_reference
                                   ,pv_product_reference    => pv_product_reference
                                   ,pn_valuation_date       => pn_valuation_date
                                   ,pv_increment_type       => pv_increment_type
                                   ,pn_increment_reference  => pn_increment_reference
                                   ,pd_increment_start_date => ld_increment_start_date
                                   ,pd_next_prem_due_date   => ld_next_prem_due_date);

        IF ld_increment_start_date IS NOT NULL THEN
            -- get the pup date
            ld_pup_date := pck_policy_details.f_get_pupdte(pv_polref => pn_policy_reference);

            -- check for high date
            IF pck_utility.f_dtcnv(ld_pup_date) = 99999 THEN
                ld_pup_date := NULL;
            END IF;

            pn_prem_payment_term_yrs := f_premium_payment_term_years(
                                                 pd_incr_currency_date  => ld_increment_start_date
                                                ,pd_paid_up_date        => ld_pup_date
                                                ,pd_next_prem_due_date  => ld_next_prem_due_date);

            IF ld_pup_date IS NOT NULL THEN
                pn_paid_up_term_yrs := FLOOR(MONTHS_BETWEEN(pck_utility.f_dtcnv(pn_valuation_date)
                                                           ,LEAST(ld_next_prem_due_date
                                                                 ,ld_pup_date)))/12;
            ELSE
                pn_paid_up_term_yrs := 0;
            END IF;
        END IF;
    END p_pup_and_due_premium_terms;

    /*******************************************************************************
    -- %Description   get the remaining term to pay the initial commission in years.
    --                this will be called both on sqc via wrapper and pl/sql versions
    --                of pck_gpsucc
    -- %param         pn_policy_reference       IN   po010.polref%TYPE
    -- %param         pv_product_reference      IN   po010.prdref%TYPE
    -- %param         pn_valuation_date         IN   co060.strdte%TYPE
    -- %param         pn_maturity_date          IN   po030.matdte%TYPE
    -- %param         pv_increment_type         IN   po020.inrtyp%TYPE
    -- %param         pn_increment_reference    IN   po020.inrref%TYPE
    -- %return        NUMBER
    -- %raises        none
    *******************************************************************************/
    FUNCTION f_remaining_term_pay_ic(pn_policy_reference     IN  po010.polref%TYPE
                                    ,pv_product_reference    IN  po010.prdref%TYPE
                                    ,pn_valuation_date       IN  co060.strdte%TYPE
                                    ,pn_maturity_date        IN   po030.matdte%TYPE
                                    ,pv_increment_type       IN  po020.inrtyp%TYPE
                                    ,pn_increment_reference  IN  po020.inrref%TYPE)
        RETURN NUMBER
    IS
        ln_remaining_term_pay_ic    NUMBER := 0;             -- in years
        ln_prem_payment_term_yrs    NUMBER := 0;
        ln_paid_up_term_yrs         NUMBER := 0;
        ln_term_to_maturity         NUMBER := 0;
    BEGIN
        pck_process_info.p_register_module(pv_module_name => 'PCK_COMMISSION'
                                          ,pv_action_name => 'f_remaining_term_pay_ic');

       /* if the array has been populated for a different policy ref
       -- OR if it has been populated for this policy at a different date
       -- then we don't want to use what's already there so clear the array.
       -- This will also clear the array when it is already empty but is
       -- the least risky way to do this.*/
       IF NOT lpt_remaining_ic_years.EXISTS(pn_policy_reference) OR
          (lpt_remaining_ic_years.EXISTS(pn_policy_reference) AND
           NOT lpt_remaining_ic_years(pn_policy_reference).EXISTS(pn_valuation_date)) THEN
           lpt_remaining_ic_years.DELETE;
       END IF;

        /************************************************************************
        *  Remaining term (in years) that the charges has to be applied (=n):   *
        *                                                                       *
        *          (     ((75 * min(ppt,1) - ppt *((ppt + 1)      ))            *
        *          (     ((                       (--------- + put))            *
        *     = max( 0,  ((                       (    2          ))            *
        *          (     (-----------------------------------------)            *
        *          (     (                   ppt                   )            *
        *                                                                       *
        *  where ppt = premium payment/due term in years                        *
        *        put = paid up term in years                                    *
        ************************************************************************/

        /* Check if the array is already populated for this combination of inputs.
           If it is then we can get the value from the array rather than calling
           the whole process again. */
        IF lpt_remaining_ic_years.EXISTS(pn_policy_reference) AND
           lpt_remaining_ic_years(pn_policy_reference).EXISTS(pn_valuation_date) AND
           lpt_remaining_ic_years(pn_policy_reference)(pn_valuation_date).EXISTS(pv_increment_type) AND
           lpt_remaining_ic_years(pn_policy_reference)(pn_valuation_date)
                                 (pv_increment_type).EXISTS(pn_increment_reference) THEN
            ln_remaining_term_pay_ic := lpt_remaining_ic_years(pn_policy_reference)
                                                              (pn_valuation_date)
                                                              (pv_increment_type)
                                                              (pn_increment_reference);

        ELSE
            IF TRIM(pv_product_reference) IN ('TAL-GPS2','TAL-GPS3','TAL-GPS4',
                                              'TAL-CPS2','TAL-CPS3','TAL-CPS4') THEN

                -- check if policy has no initial commission
                IF f_initial_commission_exist(pn_policy_reference
                                             ,pn_valuation_date
                                             ,pv_increment_type
                                             ,pn_increment_reference) THEN

                    -- get the the premium payment and paid up term in years
                    p_pup_and_due_premium_terms(pn_policy_reference      => pn_policy_reference
                                               ,pv_product_reference     => pv_product_reference
                                               ,pn_valuation_date        => pn_valuation_date
                                               ,pv_increment_type        => pv_increment_type
                                               ,pn_increment_reference   => pn_increment_reference
                                               ,pn_paid_up_term_yrs      => ln_paid_up_term_yrs
                                               ,pn_prem_payment_term_yrs => ln_prem_payment_term_yrs);

                    -- check that premium payment term has non zero value
                    -- This value should be capped to the term to maturity
                    IF NVL(ln_prem_payment_term_yrs,0) != 0  THEN
                        ln_term_to_maturity := FLOOR(MONTHS_BETWEEN(pck_utility.f_dtcnv(pn_maturity_date)
                                                                   ,pck_utility.f_dtcnv(pn_valuation_date)))/12;

                        ln_remaining_term_pay_ic := LEAST(ln_term_to_maturity,
                                                    GREATEST(0,(LPCN_FUND_REDUCTION
                                                                * LEAST(ln_prem_payment_term_yrs,1) -
                                                                       (ln_prem_payment_term_yrs *
                                                                       ((ln_prem_payment_term_yrs + 1)/2 +
                                                                          NVL(ln_paid_up_term_yrs,0)))
                                                               )/ln_prem_payment_term_yrs));
                    ELSE
                        ln_remaining_term_pay_ic := 0;
                    END IF;
                ELSE
                    ln_remaining_term_pay_ic := 0;
                END IF;
            END IF;

            -- Add the current value to the array
            lpt_remaining_ic_years(pn_policy_reference)
                                  (pn_valuation_date)
                                  (pv_increment_type)
                                  (pn_increment_reference) := ln_remaining_term_pay_ic;

        END IF;

        RETURN ln_remaining_term_pay_ic;
    END f_remaining_term_pay_ic;

    /******************************************************************************
    -- %Description   check if the initial commission has been recouped and if it is
    --                then derive the proportion of the initial commission that needs
    --                to be paid. this will be called both on sqc via wrapper and pl/sql
    --                versions of pck_gps_sv
    -- %param         pn_policy_reference       IN   po010.polref%TYPE
    -- %param         pv_product_reference      IN   po010.prdref%TYPE
    -- %param         pn_valuation_date         IN   po020.inrcrcdte%TYPE
    -- %param         pv_increment_type         IN   po020.inrtyp%TYPE
    -- %param         pn_increment_reference    IN   po020.inrref%TYPE
    -- %param         pb_initial_csn_recouped   OUT  BOOLEAN
    -- %param         pn_initial_csn_proportn   OUT  NUMBER
    -- %raises        none
    *******************************************************************************/
    PROCEDURE p_increment_ic_proportion(pn_policy_reference       IN   po010.polref%TYPE
                                       ,pv_product_reference      IN   po010.prdref%TYPE
                                       ,pn_valuation_date         IN   po020.inrcrcdte%TYPE
                                       ,pv_increment_type         IN   po020.inrtyp%TYPE
                                       ,pn_increment_reference    IN   po020.inrref%TYPE
                                       ,pb_initial_csn_recouped   OUT  BOOLEAN
                                       ,pn_initial_csn_proportn   OUT  NUMBER)
    IS
        ln_temp                     NUMBER(10,6) := 0;
        ln_prem_payment_term_yrs    NUMBER(10,6) := 0;
        ln_paid_up_term_yrs         NUMBER(10,6) := 0;
        lv_error_text               VARCHAR2(150) := '';
        lv_error_info               VARCHAR2(200) := '';

         -- Local exceptions to handle check failures.
        le_no_last_premium_payment    EXCEPTION;
        le_no_increment_details       EXCEPTION;

    BEGIN
        pck_process_info.p_register_module(pv_module_name => 'PCK_COMMISSION'
                                          ,pv_action_name => 'p_increment_ic_proportion');

        /*******************************************************************
        *  initial commission(ic) recouped:                                *
        *    ppt * ((ppt + 1)       )                                      *
        *          (---------  + put)                                      *
        *          (    2           )                                      *
        *    if the above is less than 75, then ic has not been recouped   *
        *    otherwise the ic has been recouped                            *
        *                                                                  *
        *  proportion of the initial commission to be paid:                *
        *           (           ((ppt+1)       ))                          *
        *           (75 - ppt * (-------  + put))                          *
        *           (           (    2         ))                          *
        *            -----------------------------                         *
        *                      75                                          *
        *  where ppt = premium payment/due term in years                   *
        *        put = paid up term in years                               *
        ********************************************************************/

        IF TRIM(pv_product_reference) IN ('TAL-GPS2','TAL-CPS2') THEN
            -- check if policy has no initial commission
            IF f_initial_commission_exist(pn_policy_reference
                                         ,pn_valuation_date
                                         ,pv_increment_type
                                         ,pn_increment_reference) THEN

                 -- get the the premium payment and paid up term in years
                p_pup_and_due_premium_terms(pn_policy_reference      => pn_policy_reference
                                           ,pv_product_reference     => pv_product_reference
                                           ,pn_valuation_date        => pn_valuation_date
                                           ,pv_increment_type        => pv_increment_type
                                           ,pn_increment_reference   => pn_increment_reference
                                           ,pn_paid_up_term_yrs      => ln_paid_up_term_yrs
                                           ,pn_prem_payment_term_yrs => ln_prem_payment_term_yrs);

                IF ln_prem_payment_term_yrs IS NOT NULL AND
                   ln_paid_up_term_yrs      IS NOT NULL THEN

                    ln_temp := ln_prem_payment_term_yrs * (((ln_prem_payment_term_yrs + 1)/2)
                                                             +  NVL(ln_paid_up_term_yrs,0));

                    pb_initial_csn_recouped := NVL(ln_temp,0) >= LPCN_FUND_REDUCTION;

                    IF NOT pb_initial_csn_recouped THEN
                        ln_temp := LPCN_FUND_REDUCTION * LEAST(ln_prem_payment_term_yrs,1) -
                                                         (ln_prem_payment_term_yrs *
                                                         ((ln_prem_payment_term_yrs + 1)/2 +
                                                           ln_paid_up_term_yrs));
                        pn_initial_csn_proportn := ln_temp / LPCN_FUND_REDUCTION;
                        -- the check to get the maximum between 0 and derived proportion
                        -- will be done here as sqc cannot passed a negative value
                        pn_initial_csn_proportn := GREATEST(0,pn_initial_csn_proportn);
                    ELSE
                        pn_initial_csn_proportn := 0;
                    END IF;
                ELSE
                    -- check if increment is cancelled, hence no premium payment info
                    IF f_cancelled_increment(pn_policy_reference    => pn_policy_reference
                                            ,pv_increment_type      => pv_increment_type
                                            ,pn_increment_reference => pn_increment_reference) THEN
                        pb_initial_csn_recouped := TRUE;
                        pn_initial_csn_proportn := 0;
                    ELSE
                        lv_error_info := 'Policy Reference = '     || TO_CHAR(pn_policy_reference) ||
                                         ' Product Reference = '   || pv_product_reference         ||
                                         ' Valuation Date = '      || TO_CHAR(pn_valuation_date)   ||
                                         ' Increment Type = '      || pv_increment_type            ||
                                         ' Increment Reference = ' || TO_CHAR(pn_increment_reference);

                        -- issue exception when no increment details (po020);
                        -- derivation of paid up info is linked to increment details cursor
                        IF ln_paid_up_term_yrs IS NULL THEN
                            lv_error_text := 'No paid up term ' || lv_error_info;
                            RAISE le_no_increment_details;
                        END IF;
                        -- issue exception when no last premium due date
                        IF ln_prem_payment_term_yrs IS NULL THEN
                            lv_error_text := 'No premium payment term ' || lv_error_info;
                            RAISE le_no_last_premium_payment;
                        END IF;
                    END IF;
                END IF;
            ELSE
                -- initial commission not applicable, set to default values
                pb_initial_csn_recouped := TRUE;
                pn_initial_csn_proportn := 0;
            END IF;
        END IF;
    EXCEPTION
        WHEN le_no_increment_details THEN
            pck_err.p_handle (pv_err_code      => 'INSUFFICIENT_DATA'
                             ,pv_add_text      => lv_error_text
                             ,pn_err_occurance => 1
                             ,pb_log_err       => TRUE
                             ,pb_re_raise      => TRUE);
        WHEN le_no_last_premium_payment THEN
            pck_err.p_handle (pv_err_code      => 'INSUFFICIENT_DATA'
                             ,pv_add_text      => lv_error_text
                             ,pn_err_occurance => 2
                             ,pb_log_err       => TRUE
                             ,pb_re_raise      => TRUE);
        WHEN OTHERS THEN
            pck_err.p_handle(pv_err_code        => 'FATAL_EXCEPTION'
                            ,pv_add_text        => 'Policy Reference = '     || TO_CHAR(pn_policy_reference) ||
                                                   ' Product Reference = '   || pv_product_reference         ||
                                                   ' Valuation Date = '      || TO_CHAR(pn_valuation_date)   ||
                                                   ' Increment Type = '      || pv_increment_type            ||
                                                   ' Increment Reference = ' || TO_CHAR(pn_increment_reference)
                            ,pb_log_err         => TRUE
                            ,pb_re_raise        => TRUE);

    END p_increment_ic_proportion;

BEGIN
    pck_audits.p_process_audits (pv_process_name => 'PCK_COMMISSION'
                                ,pr_audits       => lpr_audit_info);
END pck_commission;
/
