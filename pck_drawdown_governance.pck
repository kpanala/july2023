CREATE OR REPLACE PACKAGE PROJECT_DEV_07.pck_drawdown_governance IS
/******************************************************************************************
-- DESCRIPTION:<BR>
-- Generate Extract of IR Plans for Drawdown Governance tool
-- %Author
-- %Date             25/02/2016
-- %ModHist
-- <CODE><FONT FACE="Courier" SIZE="2">
--   Version   Date                   Modified by    Brief Description of Modification<BR>
-- $Log:   //vm1/PICCSDB/archives/life/database/headers/pck_drawdown_governance.spc-arc  $
--
--   Rev 1.5   Apr 06 2017 15:56:26   SourceSafe
--Integrated version 1.4.1.6 from project INCOME_PLANNING_TOOL_II
--
--   Rev 1.4.1.6   Mar 17 2017 14:18:20   shuxley
--Added a parameter to p_retrieve_run_attributes.
--
--   Rev 1.4.1.5   Mar 17 2017 11:13:54   shuxley
--Added %log for p_retrieve_run_attributes.
--
--   Rev 1.4.1.4   Mar 17 2017 11:11:26   shuxley
--Removed f_effective_date. Added overcoded version of p_retrieve_run_attributes.
--
--   Rev 1.4.1.3   Mar 17 2017 09:49:22   shuxley
--Added f_get_effective_date.
--
--   Rev 1.4.1.2   Mar 17 2017 09:44:20   shuxley
--Added p_write_extract_to_file to write from the extract tables to files.
--
--   Rev 1.4.1.1   Mar 16 2017 17:11:32   shuxley
--Extract can run for one policy or all policies.
--
--   Rev 1.4.1.0   Mar 16 2017 12:40:28   shuxley
--Changes for running in streams.
--
--   Rev 1.4   Mar 14 2017 09:38:48   SourceSafe
--Integrated version 1.3.1.0 from project INCOME_PLANNING_TOOL
--
--   Rev 1.3.1.0   Mar 09 2017 11:08:14   shuxley
--Made f_get_policy_adviser public to allow testing.
--
--   Rev 1.3   Dec 06 2016 10:23:58   SourceSafe
--Integrated version 1.2.1.4 from project INCOME_PLANNING_TOOL
--
--   Rev 1.2.1.4   Nov 04 2016 09:37:02   shuxley
--Refactoring.
--
--   Rev 1.2.1.3   Nov 03 2016 17:47:36   shuxley
--Made p_verbalise_strategy_types public.
--
--   Rev 1.2.1.2   Nov 03 2016 16:49:26   shuxley
--Made p_retrieve_client_details, p_retrieve_policy_details and p_drawdown_gov_service public.
--
--   Rev 1.2.1.1   Nov 03 2016 12:03:56   shuxley
--Added p_retrieve_policy_investments.
--
--   Rev 1.2.1.0   Nov 03 2016 11:56:10   shuxley
--Added f_get_governed_portfolio_types.
--
--   Rev 1.2   Aug 12 2016 11:09:16   SourceSafe
--Integrated version 1.1.1.1 from project INCOME_PLANNING_TOOL
--
--   Rev 1.1.1.1   Jul 27 2016 08:37:46   sgodfrey
--Add p_adviser_names
--
--   Rev 1.1.1.0   Jul 20 2016 15:29:12   shuxley
--Added lpn_extract_period and lpn_extract_charge_period.
--
--   Rev 1.1   Apr 28 2016 14:30:06   SourceSafe
--Integrated version 1.0.1.3 from project DRAWDOWN_GOVERNANCE
--
--   Rev 1.0.1.3   Apr 28 2016 10:58:04   rhegganni
--Added procedures
--
--   Rev 1.0.1.2   Apr 20 2016 19:06:52   rhegganni
--Added affective date to client details & ITR changes
--
--   Rev 1.0.1.1   Apr 15 2016 10:17:46   rhegganni
--Added columns
--
--   Rev 1.0.1.0   Mar 15 2016 19:59:10   rhegganni
--Initial version
-- </FONT></CODE>
******************************************************************************************/

    TYPE r_client_details IS RECORD (title             cl010.ttl%TYPE
                                    ,forename          cl010.clifor%TYPE
                                    ,surname           cl010.clisur%TYPE
                                    ,date_of_birth     DATE
                                    ,age               NUMBER
                                    ,sex               cl010.sex%TYPE
                                    ,address_name      cl060.adrnam%TYPE
                                    ,address_line_1    cl060.adrlneone%TYPE
                                    ,address_line_2    cl060.adrlnetwo%TYPE
                                    ,address_line_3    cl060.adrlnethr%TYPE
                                    ,address_line_4    cl060.adrlnefor%TYPE
                                    ,postcode          cl060.pcd%TYPE);

    TYPE r_policy_details IS RECORD (policy_index      NUMBER
                                    ,policy_reference  po010.polref%TYPE
                                    ,product_reference po010.prdref%TYPE
                                    ,product_version   po010.prdvrs_no%TYPE
                                    ,commencement_date DATE
                                    ,first_bce_date    DATE
                                    ,policy_status     cs060.itevaldes%TYPE
                                    ,stapol            po010.stapol%TYPE
                                    ,exit_mode         cs060.itevaldes%TYPE
                                    ,adviser_no        co040.cliref%TYPE
                                    ,adviser_name      VARCHAR2(110)
                                    ,firm_name         VARCHAR2(110)
                                    ,retirement_date   DATE
                                    ,term_to_retire    PLS_INTEGER
                                    ,retirement_age    po030.benage%TYPE
                                    ,income_flag       VARCHAR2(1));

    /**************************************************************
    -- %Description Generate extract of IR plans
    -- %raises     NONE
    **************************************************************/
    PROCEDURE p_generate_extract(pn_stream IN PLS_INTEGER);

    /*****************************************************************************
    -- %Description Return any Client Name / Address Changes for IR Plans
    -- %param      pd_effective_date  IN  DATE
    -- %param      prc_client_details OUT SYS_REFCURSOR
    -- %raises     NONE
    *****************************************************************************/
    PROCEDURE p_client_name_address_changes (pd_effective_date  IN  DATE
                                            ,prc_client_details OUT SYS_REFCURSOR);

    /********************************************************************
    -- %Description Return any ITR changes for IR Plans
    -- %param      pd_effective_date  IN  DATE
    -- %param      prc_client_details OUT SYS_REFCURSOR
    -- %raises     NONE
    ********************************************************************/
    PROCEDURE p_adviser_changes (pd_effective_date  IN  DATE
                                ,prc_client_details OUT SYS_REFCURSOR);

    /**************************************************************
    -- Procedure to retrieve run attributes
    -- %param   pd_effective_date        OUT DATE
    -- %param   pn_inflation_date        OUT NUMBER
    -- %param   pv_run_healthchecks      OUT VARCHAR2
    -- %param   pn_staff_number          OUT cl011.stf_no%TYPE
    -- %param   pn_extract_period        OUT PLS_INTEGER
    -- %param   pn_extract_charge_period OUT PLS_INTEGER
    -- %param   pn_policy_reference      OUT po010.polref%TYPE
    **************************************************************/
    PROCEDURE p_retrieve_run_attributes (pd_effective_date        OUT DATE
                                        ,pn_inflation_date        OUT NUMBER
                                        ,pv_run_healthchecks      OUT VARCHAR2
                                        ,pn_staff_number          OUT cl011.stf_no%TYPE
                                        ,pn_extract_period        OUT PLS_INTEGER
                                        ,pn_extract_charge_period OUT PLS_INTEGER
                                        ,pn_policy_reference      OUT po010.polref%TYPE);

    /**************************************************************
    -- Procedure to retrieve run attributes
    -- %param   pd_effective_date      OUT DATE
    -- %param   pn_policy_reference    OUT po010.polref%TYPE
    -- %param   pn_extract_period      OUT PLS_INTEGER
    -- %raises  NONE
    **************************************************************/
    PROCEDURE p_retrieve_run_attributes (pd_effective_date      OUT DATE
                                        ,pn_policy_reference    OUT po010.polref%TYPE
                                        ,pn_extract_period      OUT PLS_INTEGER);

    /********************************************************************
    -- %Description return all adviser names
    -- %param      Prc_intermediary_details  OUT SYS_REFCURSOR
    -- %raises     NONE
    ********************************************************************/
    PROCEDURE p_adviser_names(prc_intermediary_details  OUT SYS_REFCURSOR);

   /********************************************************************
    -- %Description Return governed portfolio types
    -- %return     pck_asset_class_allocation.t_governed_portfolio_types
    -- %raises     NONE
    ********************************************************************/
    FUNCTION f_get_governed_portfolio_types RETURN pck_asset_class_allocation.t_governed_portfolio_types;

    /***********************************************************************************************************************
    -- Procedure Retrieve policy investments
    -- %param   pn_policy_reference         IN   po010.polref%TYPE
    -- %param   pn_effective_date           IN   cs340.sysdte%TYPE
    -- %param   pt_governed_portfolio_types IN pck_asset_class_allocation.t_governed_portfolio_types
    -- %param   pr_investment_details       OUT  pck_asset_class_allocation.r_investment_details
    -- %raises  NONE
    ************************************************************************************************************************/
    PROCEDURE p_retrieve_policy_investments (pn_policy_reference         IN  po010.polref%TYPE
                                            ,pn_effective_date           IN  cs340.sysdte%TYPE
                                            ,pt_governed_portfolio_types IN  pck_asset_class_allocation.t_governed_portfolio_types
                                            ,pt_strategy_desc            IN  pck_asset_class_allocation.t_strategy_desc
                                            ,pr_investment_details       OUT pck_asset_class_allocation.r_investment_details);

    /***********************************************************************************************************************
    -- Procedure Retrieve client details
    -- %param   pn_policy_reference IN  po010.polref%TYPE
    -- %param   pd_effective_date   IN  DATE
    -- %param   pr_client_details   OUT r_client_details
    -- %raises  NONE
    ************************************************************************************************************************/
    PROCEDURE p_retrieve_client_details (pn_policy_reference IN  po010.polref%TYPE
                                        ,pd_effective_date   IN  DATE
                                        ,pr_client_details   OUT r_client_details);

    /***********************************************************************************************************************
    -- Procedure Retrieve policy details
    -- %param   pn_policy_reference IN  po010.polref%TYPE
    -- %param   pn_policy_index     IN  PLS_INTEGER
    -- %param   pr_client_details   IN  r_client_details
    -- %param   pr_policy_details   OUT r_policy_details
    -- %raises  NONE
    ************************************************************************************************************************/
    PROCEDURE p_retrieve_policy_details (pn_policy_reference IN  po010.polref%TYPE
                                        ,pn_policy_index     IN  PLS_INTEGER
                                        ,pr_client_details   IN  r_client_details
                                        ,pr_policy_details   OUT r_policy_details);

    /***********************************************************************************************************************
    -- Procedure Retrieve drawdown_governance values for policy
    -- %param   pn_policy_reference   IN   po010.polref%TYPE
    -- %param   pv_review_in_service  OUT drawdown_governance.service_opted%TYPE
    -- %param   pn_target_age         OUT drawdown_governance.target_age%TYPE
    -- %param   pv_target_type        OUT drawdown_gov_income_targets.target_description%TYPE
    -- %raises  NONE
    ************************************************************************************************************************/
    PROCEDURE p_drawdown_gov_service(pn_policy_reference   IN  po010.polref%TYPE
                                    ,pv_review_in_service  OUT drawdown_governance.service_opted%TYPE
                                    ,pn_target_age         OUT drawdown_governance.target_age%TYPE
                                    ,pv_target_type        OUT drawdown_gov_income_targets.target_description%TYPE);

   /***********************************************************************************************************************
    -- Procedure Retrieve drawdown_governance values for policy
    -- %param   pn_policy IN co040.polref%TYPE
    -- %param   pn_efvdte IN co040.strdte%TYPE
    -- %return  co040.cliref%TYPE
    -- %raises  NONE
    ************************************************************************************************************************/
    FUNCTION f_get_policy_adviser (pn_policy IN co040.polref%TYPE
                                  ,pn_efvdte IN co040.strdte%TYPE)
    RETURN co040.cliref%TYPE;

   /***********************************************************************************************************************
    -- Procedure Write the extract files from their tables
    -- %param   pd_effective_date IN DATE
    -- %raises  NONE
    ************************************************************************************************************************/
    PROCEDURE p_write_extract_to_file;


END pck_drawdown_governance;
/
CREATE OR REPLACE PACKAGE BODY PROJECT_DEV_07.pck_drawdown_governance IS
/******************************************************************************************
-- DESCRIPTION:<BR>
-- Generate Extract of IR Plans for Drawdown Governance tool
-- %Author
-- %Date             25/02/2016
-- %ModHist
-- <CODE><FONT FACE="Courier" SIZE="2">
--   Version   Date                   Modified by    Brief Description of Modification<BR>
-- $Log:   //vm1/PICCSDB/archives/life/database/bodies/pck_drawdown_governance.bdy-arc  $
--
--   Rev 1.16   Dec 17 2020 19:40:44   SourceSafe
--Integrated version 1.15.1.0 from project RORIII_ANNRVW
--
--   Rev 1.15.1.0   01 Dec 2020 13:37:34   sbathala
--Added investment pathway changes
--
--   Rev 1.15   Apr 06 2017 15:56:10   SourceSafe
--Integrated version 1.14.1.15 from project INCOME_PLANNING_TOOL_II
--
--   Rev 1.14.1.15   Apr 06 2017 09:35:44   shuxley
--Fixed bug in p_write_extract_to_file.
--
--   Rev 1.14.1.14   Apr 03 2017 15:12:18   shuxley
--Added p_set_extract_to_stop.
--
--   Rev 1.14.1.13   Apr 03 2017 12:42:00   shuxley
--Changed p_retrieve_run_attributes to return a policy number that will control if the extract is run. 'STOP' will prevent execution, 'ALL' will execute for all policies, a policy number will execute the extract for that policy only.
--
--   Rev 1.14.1.12   Mar 28 2017 16:32:18   shuxley
--Changed p_write_extract_to_file to reorder the rows read from ddg_moodys_input.
--
--   Rev 1.14.1.11   Mar 27 2017 08:51:20   shuxley
--Removed lpn_policy_index. This is generated in pck_streams and stored in DDG_EXTRACT_REQUESTS so p_generate_extract uses a unique value for each stream it runs in.
--
--   Rev 1.14.1.10   Mar 24 2017 12:33:02   shuxley
--Added exception handing around writing to tables.
--
--   Rev 1.14.1.9   Mar 22 2017 10:26:32   shuxley
--Made policy_index a package level variable to maintain its value acrosss streams. Fixed problems writing to tables.
--
--   Rev 1.14.1.8   Mar 21 2017 09:51:56   shuxley
--Bug fixes.
--
--   Rev 1.14.1.7   Mar 17 2017 15:47:00   shuxley
--Live defect fix. ACTUAL_GROSS_INCOME (income_amount_annual) was calculating over incorrect period.
--
--   Rev 1.14.1.6   Mar 17 2017 15:06:30   shuxley
--Only produce an actual growth rate if commencement date is before or equal to one year ago.
--
--   Rev 1.14.1.5   Mar 17 2017 14:18:30   shuxley
--Added a parameter to p_retrieve_run_attributes.
--
--   Rev 1.14.1.4   Mar 17 2017 14:09:22   shuxley
--Changed extract filenames.
--
--   Rev 1.14.1.3   Mar 17 2017 11:16:44   shuxley
--Added overcoded version of p_retrieve_run_attributes. p_generate_extract gets bulk collect limit specific to DDG.
--
--   Rev 1.14.1.2   Mar 17 2017 09:44:02   shuxley
--Added p_write_extract_to_file to write from the extract tables to files.
--
--   Rev 1.14.1.1   Mar 16 2017 17:11:56   shuxley
--Extract can run for one policy or all policies.
--
--   Rev 1.14.1.0   Mar 16 2017 12:40:12   shuxley
--Changes for running in streams.
--
--   Rev 1.14   Mar 14 2017 09:38:44   SourceSafe
--Integrated version 1.13.1.3 from project INCOME_PLANNING_TOOL
--
--   Rev 1.13.1.3   Mar 13 2017 12:02:26   shuxley
--Defect fix.
--
--   Rev 1.13.1.2   Mar 09 2017 15:57:46   shuxley
--Change after peer review.
--
--   Rev 1.13.1.0   Mar 09 2017 11:09:30   shuxley
--Changes to  f_get_policy_adviser and p_adviser_names.
--
--   Rev 1.13   Feb 14 2017 11:41:50   SourceSafe
--Integrated version 1.11.1.8 from project INCOME_PLANNING_TOOL_II
--
--   Rev 1.11.1.8   Feb 13 2017 15:06:00   shuxley
--Changed error message for CLIENT_AGE_EQUALS_TARGET_AGE.
--
--   Rev 1.11.1.7   Feb 08 2017 15:55:42   shuxley
--Change to check if client age is greater than or equal to target age.
--
--   Rev 1.11.1.6   Feb 08 2017 14:52:52   shuxley
--Reinstated v1.11.1.4
--
--   Rev 1.11.1.5   Feb 03 2017 11:50:48   shuxley
--Overwritten with v1.12 to track down fit defect.
--
--   Rev 1.11.1.4   Jan 19 2017 08:33:16   shuxley
--Defect fixes.
--
--   Rev 1.11.1.3   Dec 22 2016 11:24:12   shuxley
--Removed DBMS_OUTPUT.
--
--   Rev 1.11.1.2   Dec 22 2016 11:17:46   shuxley
--Fixed defect.
--
--   Rev 1.11.1.1   Dec 22 2016 09:47:40   shuxley
--Removed unused code. Changed parameters to pck_calcs_existing_biz.p_derive_inputs.
--
--   Rev 1.11.1.0   Dec 22 2016 09:18:38   shuxley
--Extract no longer creating quote records.
--
--   Rev 1.11   Dec 06 2016 14:53:00   SourceSafe
--Integrated version 1.10.1.1 from project INCOME_PLANNING_TOOL
--
--   Rev 1.10.1.1   Dec 06 2016 13:58:12   shuxley
--Removed dbms_output ...
--
--   Rev 1.10.1.0   Dec 06 2016 13:55:56   shuxley
--Refactored p_calc_actual_growth_rate. Moved With Profits code to  f_with_profits_growth_rate.
--
--   Rev 1.10   Dec 06 2016 10:23:52   SourceSafe
--Integrated version 1.9.1.8 from project INCOME_PLANNING_TOOL
--
--   Rev 1.9.1.8   Dec 01 2016 12:10:20   shuxley
--Further change to lpcu_actual_fund_value.
--
--   Rev 1.9.1.7   Dec 01 2016 10:59:48   shuxley
--Tidied up lpcu_actual_fund_value following peer review.
--
--   Rev 1.9.1.6   Dec 01 2016 09:43:38   shuxley
--Updated p_calc_actual_growth_rate to return correct value for With Profits policies. Also added in some more exception reporting.
--
--   Rev 1.9.1.5   Nov 24 2016 08:55:18   shuxley
--Changed lpcu_actual_fund_value to remove zero values not needed in actual growth rate calcs. Removed dbms_output.
--
--   Rev 1.9.1.4   Nov 22 2016 16:03:44   shuxley
--Changed p_calc_actual_growth_rate to include policies commencing in the last year.
--
--   Rev 1.9.1.3   Nov 04 2016 09:36:52   shuxley
--Refactoring.
--
--   Rev 1.9.1.2   Nov 03 2016 17:46:56   shuxley
--Changes to p_retrieve_client_details.
--
--   Rev 1.9.1.1   Nov 03 2016 16:49:38   shuxley
--Made p_retrieve_client_details, p_retrieve_policy_details and p_drawdown_gov_service public.
--
--   Rev 1.9.1.0   Nov 03 2016 11:25:08   shuxley
--Refactored to create link between Income Planning Tool and Drawdown Governance.
--
--   Rev 1.9   Oct 20 2016 15:37:38   SourceSafe
--Integrated version 1.8.1.12 from project DRAWDOWN_GOVERNANCE
--
--   Rev 1.8.1.12   Oct 20 2016 09:37:08   shuxley
--Peer review comments.
--
--   Rev 1.8.1.11   Oct 19 2016 15:27:34   shuxley
--Fixed defect in p_fund_values.
--
--   Rev 1.8.1.10   Oct 14 2016 15:58:28   shuxley
--Changed lb_moodys_file_required check in p_review_service_switch.
--
--   Rev 1.8.1.9   Oct 14 2016 14:10:38   shuxley
--Removed commented out code etc.
--
--   Rev 1.8.1.8   Oct 13 2016 16:33:14   shuxley
--Reworked client age = target age check in p_generate_policy_extract to raise technical error and write to error file.
--
--   Rev 1.8.1.7   Oct 13 2016 15:22:26   shuxley
--Updated p_calc_actual_growth_rate.
--
--   Rev 1.8.1.6   Oct 13 2016 15:19:36   shuxley
--Changed p_retrieve_run_attributes.
--
--   Rev 1.8.1.5   Oct 11 2016 16:35:38   shuxley
--Tidying up.
--
--   Rev 1.8.1.4   Oct 11 2016 16:31:00   shuxley
--Removed commented out code.
--
--   Rev 1.8.1.3   Oct 11 2016 14:49:46   shuxley
--Removed function.
--
--   Rev 1.8.1.2   Oct 11 2016 09:54:16   shuxley
--Changed p_adviser_changes. Should now return same new ITR as CLIPF screen.
--
--   Rev 1.8.1.1   Oct 10 2016 14:52:12   shuxley
--Updated f_get_policy_adviser.
--
--   Rev 1.8.1.0   Oct 07 2016 11:54:52   shuxley
--Various defect and performance changes.
--
--   Rev 1.8   Sep 27 2016 10:55:26   SourceSafe
--Integrated version 1.7.1.0 from project INCOME_PLANNING_TOOL
--
--   Rev 1.7.1.0   Sep 15 2016 16:48:36   shuxley
--Call public functions in pck_asset_class_allocation.
--
--   Rev 1.7   Sep 05 2016 08:56:32   SourceSafe
--Integrated version 1.6.1.0 from project INCOME_PLANNING_TOOL
--
--   Rev 1.6.1.0   Aug 31 2016 15:05:50   shuxley
--Moved some procedures into pck_asset_class_allocation so they can be shared with Income Planning Tool code.
--
--   Rev 1.6   Aug 12 2016 11:09:12   SourceSafe
--Integrated version 1.3.2.6 from project INCOME_PLANNING_TOOL
--
--   Rev 1.3.2.6   Aug 05 2016 08:18:14   sgodfrey
--removed cl090 from intermediary query
--
--   Rev 1.3.2.5   Aug 04 2016 15:48:44   sgodfrey
--integrated 1.3.1.25 and 1.4 to 1.4.1.8
--
--   Rev 1.3.2.4   Aug 03 2016 16:13:04   sgodfrey
--reworked intermediary query
--
--   Rev 1.3.2.3   Jul 27 2016 08:38:04   sgodfrey
--Add p_adviser_names
--
--   Rev 1.3.2.2   Jul 21 2016 15:19:22   sgodfrey
--Added ITR name
--
--   Rev 1.3.2.1   Jul 20 2016 15:29:56   shuxley
--Added lpn_extract_period and lpn_extract_charge_period.
--
--   Rev 1.3.2.0   Jul 20 2016 11:26:00   shuxley
--Integrated with v1.3.1.24 from DRAWDOWN_GOVERNANCE.
--
--   Rev 1.3.1.24   Jul 19 2016 16:38:54   shuxley
--Defect fixes and removed unnecessary number formating.
--
--   Rev 1.3.1.23   Jul 19 2016 12:49:56   sgodfrey
--Check for premium holiday
--
--   Rev 1.3.1.22   Jul 19 2016 11:27:34   shuxley
--Changes following peer review.
--
--   Rev 1.3.1.21   Jul 15 2016 15:32:04   shuxley
--Removed unnecessary comments.
--
--   Rev 1.3.1.20   Jul 15 2016 15:18:10   shuxley
--Formatting changes to numbers on extracts.
--
--   Rev 1.3.1.19   Jul 15 2016 11:48:36   shuxley
--Changed the call to f_round_investment_details. lr_investment_details can be sparsely populated so for fund range asset classes it only has a single entry for an index = term to retirement.
--
--   Rev 1.3.1.18   Jul 15 2016 10:21:08   sgodfrey
--Checked on income flag to do calcs
--
--   Rev 1.3.1.17   Jul 15 2016 09:28:12   shuxley
--Added leading zero formats to values written to file.
--
--   Rev 1.3.1.16   Jul 15 2016 08:24:30   sgodfrey
--Added nvl round f_get_premium_frequency
--
--   Rev 1.3.1.15   Jul 14 2016 16:54:44   shuxley
--Added f_round_investment_details.
--
--   Rev 1.3.1.14   Jul 13 2016 13:24:06   shuxley
--Further change to lpcu_actual_fund_value.
--
--   Rev 1.3.1.13   Jul 13 2016 12:36:06   shuxley
--Changes to lpcu_actual_fund_value.
--
--   Rev 1.3.1.12   Jul 13 2016 09:59:28   shuxley
--Changes around (but not limited to) p_calc_actual_growth_rate and  p_policy_asset_allocation.
--
--   Rev 1.3.1.11   Jul 13 2016 09:11:20   sgodfrey
--Removed max age from moodys file extract , moved income flag code
--
--   Rev 1.3.1.10   Jul 12 2016 15:21:18   sgodfrey
--Use correct income flag
--
--   Rev 1.3.1.9   Jul 12 2016 13:36:18   sgodfrey
--remove null frequency error
--
--   Rev 1.3.1.8   Jul 12 2016 12:32:34   sgodfrey
--Added mtv cases, removed 3 extra fields, removed NO INCOME cases warning
--
--   Rev 1.3.1.6   Jul 07 2016 17:10:06   sgodfrey
--Made changes for amc calc
--
--   Rev 1.3.1.5   Jul 06 2016 16:01:36   sgodfrey
--Add retirement age remove crystallised amount
--
--refactor to avoid creating expected growth rate for any case apart from new income cases
--
--populate target age, type and default review service switch
--
--   Rev 1.3.1.4   Jun 30 2016 15:45:38   sgodfrey
--removed crystallised amount, refactored p_calc_inputs
--
--   Rev 1.3.1.2   Jun 17 2016 14:14:34   shuxley
--Removed dbms_output.
--
--   Rev 1.3.1.1   Jun 17 2016 14:09:50   shuxley
--Multiple changes.
--
--   Rev 1.3.1.0   Jun 16 2016 10:53:58   shuxley
--Extract changes - Work In Progress
--
--   Rev 1.3   May 20 2016 17:01:52   SourceSafe
--Integrated version 1.2.1.1 from project DRAWDOWN_GOVERNANCE
--
--   Rev 1.2.1.1   May 20 2016 15:25:38   rhegganni
--Apply ADP Formatting rules
--
--   Rev 1.2.1.0   May 17 2016 19:02:46   rhegganni
--Remove duplicate entries.
--
--   Rev 1.2   May 03 2016 15:09:50   SourceSafe
--Integrated version 1.0.1.23 from project DRAWDOWN_GOVERNANCE
--
--   Rev 1.0.1.23   May 03 2016 15:02:10   rhegganni
--Minor Changes
--
--   Rev 1.0.1.22   May 03 2016 14:30:52   rhegganni
--Exclude SIPP Cases
--
--   Rev 1.1   Apr 28 2016 14:30:02   SourceSafe
--Integrated version 1.0.1.21 from project DRAWDOWN_GOVERNANCE
--
--   Rev 1.0.1.21   Apr 28 2016 14:00:16   rhegganni
--Fixed review comment
--
--   Rev 1.0.1.20   Apr 28 2016 12:53:42   rhegganni
--Fix total pcls issue
--
--   Rev 1.0.1.19   Apr 28 2016 12:20:56   rhegganni
--Minor changes
--
--   Rev 1.0.1.17   Apr 20 2016 19:06:36   rhegganni
--Added affective date to client details & ITR changes
--
--   Rev 1.0.1.16   Apr 18 2016 20:39:22   rhegganni
--further tuning
--
--   Rev 1.0.1.15   Apr 18 2016 17:31:58   rhegganni
--Fix defects
--
--   Rev 1.0.1.13   Apr 17 2016 18:38:34   rhegganni
--Minor restructure..
--
--   Rev 1.0.1.10   Apr 04 2016 10:24:46   rhegganni
--Fixes for AMC and Adviser charges
--
--   Rev 1.0.1.8   Mar 31 2016 12:05:28   rhegganni
--more fixes
--
--   Rev 1.0.1.4   Mar 24 2016 09:43:04   rhegganni
--Further Changes
--
--   Rev 1.0.1.3   Mar 17 2016 10:57:28   rhegganni
--Retrieve actual growth rate
--
--   Rev 1.0.1.2   Mar 17 2016 08:32:42   rhegganni
--Remove test data
--
--   Rev 1.0.1.0   Mar 15 2016 19:59:08   rhegganni
--Initial version
-- </FONT></CODE>
******************************************************************************************/

    LPCV_PACKAGE_NAME    CONSTANT VARCHAR2(23) := 'pck_drawdown_governance';
    LPCV_DELIMITER       CONSTANT VARCHAR2(1)  :=  ',';
    LPCV_SPACE           CONSTANT VARCHAR2(1)  :=  ' ';
    LPCV_TARGET          CONSTANT VARCHAR2(15) := 'INCOME FOR LIFE';
    LPCN_DGS_HEALTHCHECK CONSTANT health_check_process_rules.process_id%TYPE := 4003;

    -- Check whether the trace is activated for this package.
    -- Do this at the level of the package, since trace state is defined at the level
    -- of the package, not the individual procedure.
    lpb_trace BOOLEAN := trace_parameters.is_activated(pv_app     => pck_app.f_get_name
                                                      ,pv_process => LPCV_PACKAGE_NAME);

    SUBTYPE tyv_vchar_idx IS VARCHAR2(50);

    TYPE r_incrm_amc IS RECORD(adviser_payment NUMBER(5,2) -- holds adviser payment component of amc
                              ,fund_value      fi700.amt%TYPE
                              ,incr_typ        po020.inrtyp%TYPE
                              ,incr_ref        po020.inrref%TYPE
                              ,amc_rate        NUMBER(5,2)); -- holds total amc

    TYPE t_incrm_amc IS TABLE OF r_incrm_amc         INDEX BY PLS_INTEGER;

    TYPE r_calcs_inputs IS RECORD (expected_growth_rate       NUMBER(4,1)
                                  ,actual_growth_rate         NUMBER(4,1)
                                  ,expected_rp_amount         po020.polamt%TYPE
                                  ,expected_rp_amount_yr      po020.polamt%TYPE
                                  ,expected_rp_frequency      po030.prmfrq%TYPE
                                  ,rp_indicator               VARCHAR2(1)
                                  ,rp_esc_rate                po015.inrrte%TYPE  DEFAULT 0
                                  ,policy_amc                 po028.crgadjrte%TYPE
                                  ,policy_adviser_charge      charge_increment_dates.charge_percentage%TYPE
                                  ,crystallised_fund_value    fi700.amt%TYPE
                                  ,transfer_in_drawdown_ind   VARCHAR2(1)
                                  ,ir_switch_on_ind           VARCHAR2(1)
                                  ,total_pcls_amount          bce.bce_amount%TYPE
                                  ,total_income_amount        event.trnamt1%TYPE
                                  ,adhoc_income_last_quarter  additional_payments.payment_amount%TYPE
                                  ,adhoc_income_last_year     additional_payments.payment_amount%TYPE
                                  ,actual_conts_last_quarter  event.trnamt2%TYPE
                                  ,actual_conts_last_year     event.trnamt2%TYPE
                                  ,expected_income_amount_yr  pre_sale_designation_dtls.annual_income_amount%TYPE
                                  ,expected_income_amount     pre_sale_designation_dtls.annual_income_amount%TYPE
                                  ,income_amount_annual       pre_sale_designation_dtls.annual_income_amount%TYPE
                                  ,income_frequency           pre_sale_designation_dtls.frequency%TYPE
                                  ,escalation_rate            pre_sale_designation_dtls.escalation_rate%TYPE
                                  ,short_term_outlook         VARCHAR2(1)
                                  ,review_service_switch      VARCHAR2(1)
                                  ,target                     VARCHAR2(100)
                                  ,target_age                 po030.benage%TYPE
                                  ,reason_for_exclusion       VARCHAR2(1000)
                                  ,contract_version           po010.prdvrs_no%TYPE
                                  ,default_rev_serv_switch    VARCHAR2(1)
                                  );

    TYPE t_technical_issues IS TABLE OF VARCHAR2(500)                   INDEX BY PLS_INTEGER;

    lpd_system_date               cs340.system_dt%TYPE := pck_dates.f_system_date;
    lpd_effective_date            cs340.system_dt%TYPE;
    lpn_effective_date            cs340.sysdte%TYPE;
    lpd_effective_date_minus_1yr  cs340.system_dt%TYPE;
    lpt_technical_issues          t_technical_issues;

    -- The extract cycle could be changed therefore this value is softcoded.
    lpn_extract_period            PLS_INTEGER := 3;
    lpn_extract_charge_period     PLS_INTEGER := 3;

    lpr_file_handle_dashboard     pck_file_handler.r_file_handle;
    lpr_file_handle_moodys        pck_file_handler.r_file_handle;
    lpr_file_handle_error         pck_file_handler.r_file_handle;

    -- Cursor to retrieve fund split
    CURSOR lpcu_fund_split (pcn_policy_reference IN po010.polref%TYPE
                           ,pcn_effective_date   IN fi700.efvdte%TYPE) IS
       WITH
          --  Level 1 - funds_info
          funds_info AS (SELECT     fndmov.polref       polref
                                   ,SUM(fndmov.benqty1) ben
                                   ,fndmov.fndref fndref
                                   ,fndmov.rhttyp rhttyp
                                   ,fndmov.inrtyp inrtyp
                                   ,fndmov.inrref inrref
                                   ,TRUNC(price.fndbidprc / 100, 3) price
                            FROM fi700 fndmov
                            JOIN pr060 price ON  price.fndref    = fndmov.fndref
                                             AND price.fndsubtyp = fndmov.fndsubtyp
                                             AND price.fndprcdte = pcn_effective_date
                            WHERE  fndmov.polref  = pcn_policy_reference
                            AND    fndmov.efvdte <= (pcn_effective_date - 1)
                            AND    fndmov.staevt IN (50, 65)
                            AND    fndmov.inrtyp IN ('SP','TV','ORD','DSS')
                            GROUP  BY fndmov.polref
                                     ,fndmov.fndref
                                     ,fndmov.rhttyp
                                     ,fndmov.inrtyp
                                     ,fndmov.inrref
                                     ,price.fndbidprc)

         --Level 2 - fund_value
        ,fund_value AS (SELECT fi.polref
                              ,fi.inrtyp
                              ,fi.inrref
                              ,fi.fndref
                              ,ABS(ROUND(fi.price * fi.ben, 2)) fnd_val
                        FROM funds_info fi)

        SELECT   polref
                ,inrtyp
                ,inrref
                ,fndref
                ,fnd_id
                ,fndnam
                ,mgmfeepct
                ,fndval_incrm_ref
                ,fndval_incrm_type
                ,fndval_policy_level
                ,fndval_fund_level
                ,incrm_ref_fund_split
                ,fund_split
                ,fund_split_rank
                ,MAX(fund_split_rank) OVER (PARTITION BY polref) max_rank
        FROM (
                SELECT   polref
                        ,inrtyp
                        ,inrref
                        ,fndref
                        ,fnd_id
                        ,fndnam
                        ,mgmfeepct
                        ,fndval_incrm_ref
                        ,fndval_incrm_type
                        ,fndval_policy_level
                        ,fndval_fund_level
                        ,ROUND(fndval_fund_level / fndval_policy_level, 4) * 100 fund_split
                        ,ROUND(fndval_incrm_fndref / fndval_incrm_ref, 4) * 100  incrm_ref_fund_split
                        ,DENSE_RANK() OVER (PARTITION BY polref ORDER BY fndval_fund_level) fund_split_rank
                FROM (
                        SELECT  f.polref
                               ,f.inrtyp
                               ,f.inrref
                               ,f.fndref
                               ,p3.fnd_id
                               ,p5.fndnam
                               ,p5.mgmfeepct
                               ,f.fnd_val
                               ,SUM (f.fnd_val) OVER (PARTITION BY f.polref, f.inrtyp,  f.inrref)             fndval_incrm_ref
                               ,SUM (f.fnd_val) OVER (PARTITION BY f.polref, f.inrtyp,  f.inrref, f.fndref)   fndval_incrm_fndref
                               ,SUM (f.fnd_val) OVER (PARTITION BY f.polref, f.inrtyp)                        fndval_incrm_type
                               ,SUM (f.fnd_val) OVER (PARTITION BY f.polref)                                  fndval_policy_level
                               ,SUM (f.fnd_val) OVER (PARTITION BY f.polref, f.fndref)                        fndval_fund_level
                        FROM    fund_value f
                               ,pr310 p3
                               ,pr315 p5
                        WHERE   f.fndref       =  p3.fndref
                        AND     p3.fndref      =  p5.fndref
                        AND     p5.fndsubtyp   =  'P'
                        AND     p3.maint      !=  'D'
                        AND     p5.maint      !=  'D')
               WHERE fnd_val > 0)
        ORDER BY fund_split_rank;

    CURSOR lpcu_actual_fund_value(pcn_policy_reference         IN po010.polref%TYPE
                                 ,pcn_effective_date           IN fi700.efvdte%TYPE
                                 ,pcn_effective_date_minus_1yr IN fi700.efvdte%TYPE) IS

        WITH days_in_year AS
            (SELECT pcn_effective_date + 1 - ROWNUM AS dd FROM DUAL
             CONNECT BY rownum <= pcn_effective_date - pcn_effective_date_minus_1yr + 1)
        SELECT DISTINCT
            TO_DATE(TO_CHAR(dd + 2415021) ,'J') dd,
            fndref,
            NVL(SUM(amt) over (PARTITION BY dd),0) fund_change
        FROM fi700 fi
        RIGHT OUTER JOIN days_in_year d ON  d.dd = fi.efvdte
                                        AND fi.fndtrntyp != 'SW'
                                        AND fi.staevt    IN (50, 65)
                                        AND fi.polref    = pcn_policy_reference
        ORDER BY dd;

    TYPE t_value_range IS TABLE OF lpcu_actual_fund_value%ROWTYPE;

    PROCEDURE p_trace_individual_comment    (pv_comment IN  VARCHAR2)
    IS
        LCV_ACTION  CONSTANT VARCHAR2(30) := 'p_trace_individual_comment';
    BEGIN

        -- Setting the action here would mean that it would then need to be re-set after each call. On balance it is not worth
        -- doing because this is a straightforward procedure which is very unlikely to fail.
        IF lpb_trace THEN
        trace_parameters.trace_rules_insert
           (p_rule_name    =>  LPCV_PACKAGE_NAME || '.' || LCV_ACTION
           ,p_rules_params =>  'comment: ' || pv_comment
           ,p_io           =>  'I'
           ,p_pack_name    =>  LPCV_PACKAGE_NAME
           ,p_app          =>  pck_app.f_get_name);
        END IF;

    END p_trace_individual_comment;

     -- Function to determine premium holiday start age
    FUNCTION f_premium_hol_start_age (pn_policy_ref    IN po010.polref%TYPE
                                     ,pd_date_of_birth IN DATE)
    RETURN NUMBER
    IS
        CURSOR cu_premium_holiday_strdte (pcn_policy_ref IN po010.polref%TYPE)
        IS
        SELECT TO_DATE(hol.holstrdte + 2415021, 'J')
        FROM   fi350 hol
              ,cs340 c
        WHERE  hol.polref    = pcn_policy_ref
        AND    hol.prmholsta = 30
        AND    hol.maint    != 'D'
        AND    hol.holstrdte <= c.sysdte
        AND    hol.holenddte >= c.sysdte
        AND    c.maint != 'D';

        ld_holiday_start_date DATE;
        ln_holiday_start_age  NUMBER;
    BEGIN
        pck_process_info.p_set_action (pv_action_name => 'f_premium_hol_start_age');

        OPEN  cu_premium_holiday_strdte (pn_policy_ref);
        FETCH cu_premium_holiday_strdte INTO ld_holiday_start_date;
        CLOSE cu_premium_holiday_strdte;

        ln_holiday_start_age := TRUNC(MONTHS_BETWEEN(ld_holiday_start_date, pd_date_of_birth) / 12);

        RETURN ln_holiday_start_age;
    END f_premium_hol_start_age;

    -- Adviser for the policy, code should follow tl010_p which is called by the COMON Oryx screen.
    FUNCTION f_get_policy_adviser (pn_policy IN co040.polref%TYPE
                                  ,pn_efvdte IN co040.strdte%TYPE)
    RETURN co040.cliref%TYPE IS

        CURSOR cu_policy_adviser (pcn_policy  co040.polref%TYPE
                                 ,pcn_efvdte  co040.strdte%TYPE)
        IS
        SELECT
            cliref
        FROM
        (
            SELECT co.cliref
            FROM   co040 co
            WHERE  co.polref  = pcn_policy
            AND    co.rolref  = 'ITR'
            AND    co.clicat  = 'ITR'
            AND    pcn_efvdte BETWEEN co.strdte AND co.enddte
            AND    co.staxrf  = 30
            AND    co.jtlind  = 1
            AND    co.enddte = 99999
            AND    co.maint  != 'D'
            -- Order the same way as co040_prc_group_f3 called by tl010_p
            ORDER BY co.cliref ASC, co.xrfunq ASC)
        -- Take the first record found
        WHERE ROWNUM = 1;

        ln_policy_adviser   co040.cliref%TYPE;
    BEGIN
        pck_process_info.p_set_action (pv_action_name => 'f_get_policy_adviser');

        OPEN  cu_policy_adviser (pn_policy
                                ,pn_efvdte);

        FETCH cu_policy_adviser INTO ln_policy_adviser;
        CLOSE cu_policy_adviser;

        RETURN ln_policy_adviser;
    END f_get_policy_adviser;

    -- function to replace commas
    FUNCTION f_replace_comma_with_space (pv_input_string IN VARCHAR2)
    RETURN VARCHAR2
    IS
    BEGIN
        RETURN REPLACE (pv_input_string, LPCV_DELIMITER, LPCV_SPACE);
    END f_replace_comma_with_space;

    -- Open Extract file
    PROCEDURE p_open_extract_file (pr_file_handle IN OUT pck_file_handler.r_file_handle
                                  ,pv_file_name   IN     VARCHAR2)
    IS
    BEGIN
        pck_process_info.p_set_action(pv_action_name => 'p_open_extract_file');

        --to open the external file
        pck_file_handler.p_open_file(pv_directory       =>  'OUTPUT_DIR'
                                    ,pv_file_name       =>  pv_file_name
                                    ,pv_open_mode       =>  'W'
                                    ,pn_max_line_size   =>  4000
                                    ,pr_file_handle     =>  pr_file_handle
                                    ,pb_apply_timestamp =>  FALSE
                                    ,pb_apply_schema    =>  FALSE);
    END p_open_extract_file;

    -- Close extract file
    PROCEDURE p_close_extract_file (pr_file_handle  IN OUT pck_file_handler.r_file_handle)
    IS
    BEGIN
        IF pck_file_handler.f_file_already_open (pr_file_handle => pr_file_handle) THEN
            pck_file_handler.p_close_file(pr_file_handle => pr_file_handle);
        END IF;
    END  p_close_extract_file;

    -- Procedure to cloce extract files
    PROCEDURE p_close_extract_files
    IS
    BEGIN
         pck_process_info.p_set_action(pv_action_name => 'p_close_extract_files');

         p_close_extract_file (pr_file_handle  => lpr_file_handle_dashboard);
         p_close_extract_file (pr_file_handle  => lpr_file_handle_moodys);
         p_close_extract_file (pr_file_handle  => lpr_file_handle_error);
    END p_close_extract_files;

    -- Write Dashboard Header
    PROCEDURE p_write_dashboard_hdr (pd_effective_date IN DATE
                                    ,pr_file_handle OUT pck_file_handler.r_file_handle)
    IS
        lv_line_header  VARCHAR2(10000);
        lv_file_name    VARCHAR2(100) := 'DGS_ORYX_EXTRACT_' || TO_CHAR(pd_effective_date, 'YYYYMMDD') ||'.csv';
    BEGIN
        pck_process_info.p_set_action(pv_action_name => 'p_write_dashboard_hdr');

        p_open_extract_file (pr_file_handle  => pr_file_handle
                            ,pv_file_name    => lv_file_name);

        --Header for output file
        lv_line_header := 'CASE_NUMBER'                              || LPCV_DELIMITER ||
                          'CLIENT_TITLE'                             || LPCV_DELIMITER ||
                          'CLIENT_FORENAME'                          || LPCV_DELIMITER ||
                          'CLIENT_LASTNAME'                          || LPCV_DELIMITER ||
                          'DATE_OF_BIRTH'                            || LPCV_DELIMITER ||
                          'AGE'                                      || LPCV_DELIMITER ||
                          'GENDER'                                   || LPCV_DELIMITER ||
                          'ADDRESS_NAME'                             || LPCV_DELIMITER ||
                          'HOME_ADDRESS_LINE_1'                      || LPCV_DELIMITER ||
                          'HOME_ADDRESS_LINE_2'                      || LPCV_DELIMITER ||
                          'HOME_ADDRESS_LINE_3'                      || LPCV_DELIMITER ||
                          'HOME_ADDRESS_LINE_4'                      || LPCV_DELIMITER ||
                          'POST_CODE'                                || LPCV_DELIMITER ||
                          'POLREF'                                   || LPCV_DELIMITER ||
                          'PRDREF'                                   || LPCV_DELIMITER ||
                          'POL_STATUS'                               || LPCV_DELIMITER ||
                          'EXTMOD'                                   || LPCV_DELIMITER ||
                          'POLCRCDTE'                                || LPCV_DELIMITER ||
                          'FIRST_BCE_DATE'                           || LPCV_DELIMITER ||
                          'PCLS_AMOUNT'                              || LPCV_DELIMITER ||
                          'TID'                                      || LPCV_DELIMITER ||
                          'IR_SWITCH_ON'                             || LPCV_DELIMITER ||
                          'FUND_VALUE'                               || LPCV_DELIMITER ||
                          'ADVISER_NAME'                             || LPCV_DELIMITER ||
                          'ITR_NO'                                   || LPCV_DELIMITER ||
                          'FIRM_NAME'                                || LPCV_DELIMITER ||
                          'EXPECTED_INCOME_LEVEL'                    || LPCV_DELIMITER ||
                          'EXPECTED_INCOME_FREQ'                     || LPCV_DELIMITER ||
                          'EXPECTED_INCOME_ESC_RATE'                 || LPCV_DELIMITER ||
                          'EXPECTED_CONTRIBUTION_AMT'                || LPCV_DELIMITER ||
                          'EXPECTED_CONTRIBUTION_FREQ'               || LPCV_DELIMITER ||
                          'ANNUAL_MANAGEMENT_CHARGE'                 || LPCV_DELIMITER ||
                          'ADVISER_CHARGES_YEARLY_PCT'               || LPCV_DELIMITER ||
                          'ACTUAL_CONTRIBUTIONS_ANNUAL'              || LPCV_DELIMITER ||
                          'ACTUAL_CONTRIBUTIONS_QUARTER'             || LPCV_DELIMITER ||
                          'ACTUAL_GROSS_INCOME'                      || LPCV_DELIMITER ||
                          'ACTUAL_OTHER_PAYMENTS_OUT'                || LPCV_DELIMITER ||
                          'QTLY_ADHOC_INCOME_TAKEN'                  || LPCV_DELIMITER ||
                          'INVESTMENT_TYPE'                          || LPCV_DELIMITER ||
                          'PORTFOLIO_NAME'                           || LPCV_DELIMITER ||
                          'LIFESTYLE_NAME';

        FOR idx IN 1..35 LOOP
            lv_line_header :=  lv_line_header                        || LPCV_DELIMITER ||
                               'FUND_NAME' || idx                    || LPCV_DELIMITER ||
                               'FUND_CODE' || idx                    || LPCV_DELIMITER ||
                               'FUND_PCT'  || idx;
        END LOOP;

        lv_line_header :=  lv_line_header                            || LPCV_DELIMITER ||
                          'TARGET'                                   || LPCV_DELIMITER ||
                          'TARGET_AGE'                               || LPCV_DELIMITER ||
                          'REVIEW_SERVICE_SWITCH'                    || LPCV_DELIMITER ||
                          'REASON_FOR_EXCLUSION'                     || LPCV_DELIMITER ||
                          'SHORT_TERM_OUTLOOK'                       || LPCV_DELIMITER ||
                          'ACTUAL_INV_GROWTH_RATE'                   || LPCV_DELIMITER ||
                          'EXPECTED_INV_GROWTH_RATE'                 || LPCV_DELIMITER ||
                          'TOTAL_INCOME_PAID'                        || LPCV_DELIMITER ||
                          'CONTRACT_VERSION'                         || LPCV_DELIMITER ||
                          'RETIREMENT_AGE';

        -- write to the external file
        pck_file_handler.p_write_to_file (pr_file_handle => pr_file_handle
                                         ,pv_line        => lv_line_header
                                         ,pb_new_line    => TRUE
                                         ,pb_flush       => FALSE);
    END p_write_dashboard_hdr;

    -- Write Moodys Inputs Header
    PROCEDURE p_write_moodys_hdr (pd_effective_date IN DATE
                                 ,pr_file_handle OUT pck_file_handler.r_file_handle)
    IS
        lv_line_header  VARCHAR2(10000);
        lv_file_name    VARCHAR2(100) := 'DGS_BATCH_PROCESSOR_INPUT_' || TO_CHAR(pd_effective_date, 'YYYYMMDD') ||'.csv';
    BEGIN
        pck_process_info.p_set_action(pv_action_name => 'p_write_moodys_hdr');

        p_open_extract_file (pr_file_handle  => pr_file_handle
                            ,pv_file_name    => lv_file_name);

        --Header for output file
        lv_line_header :=   'CASE_NUMBER'                             || LPCV_DELIMITER ||
                            'DATE_OF_BIRTH'                              || LPCV_DELIMITER ||
                            'AGE'                                      || LPCV_DELIMITER ||
                            'FUND'                                      || LPCV_DELIMITER ||
                            'CHARGE'                                  || LPCV_DELIMITER ||
                            'RP_AMOUNT'                                  || LPCV_DELIMITER ||
                            'ESC_RATE'                                || LPCV_DELIMITER ||
                            'RP_END_AGE'                              || LPCV_DELIMITER ||
                            'INCOME_AMOUNT'                              || LPCV_DELIMITER ||
                            'TARGET'                                  || LPCV_DELIMITER ||
                            'TARGET_AGE'                              || LPCV_DELIMITER ||
                            'INVESTMENT_TYPE'                          || LPCV_DELIMITER ||
                            'FUND_NAME'                                  || LPCV_DELIMITER ||
                            'TERM_TO_RETIRE'                          || LPCV_DELIMITER ||
                            'CASH'                                       || LPCV_DELIMITER ||
                            'CORPORATE_BONDS_5'                          || LPCV_DELIMITER ||
                            'CORPORATE_BONDS_10'                      || LPCV_DELIMITER ||
                            'CORPORATE_BONDS_15'                      || LPCV_DELIMITER ||
                            'GILTS_5'                                   || LPCV_DELIMITER ||
                            'GILTS_10'                                   || LPCV_DELIMITER ||
                            'GILTS_15'                                   || LPCV_DELIMITER ||
                            'INDEX_LINKED_BONDS_5'                      || LPCV_DELIMITER ||
                            'INDEX_LINKED_BONDS_10'                      || LPCV_DELIMITER ||
                            'INDEX_LINKED_BONDS_15'                      || LPCV_DELIMITER ||
                            'OVERSEAS_EQUITY'                          || LPCV_DELIMITER ||
                            'PROPERTY'                                   || LPCV_DELIMITER ||
                            'UK_EQUITY'                               || LPCV_DELIMITER ||
                            'COMMODITIES'                             || LPCV_DELIMITER ||
                            'ABSOLUTE_RETURN_BOND'                    || LPCV_DELIMITER ||
                            'ABSOLUTE_RETURN_MULTI_STRATEGIES'        || LPCV_DELIMITER ||
                            'UK_HIGH_YIELD';

        pck_file_handler.p_write_to_file (pr_file_handle => pr_file_handle
                                         ,pv_line        => lv_line_header
                                         ,pb_new_line    => TRUE
                                         ,pb_flush       => FALSE);
    END p_write_moodys_hdr;

    -- Write Drawdown Header
    PROCEDURE p_write_error_file_hdr (pd_effective_date IN DATE
                                     ,pr_file_handle    OUT pck_file_handler.r_file_handle)
    IS
        lv_line_header  VARCHAR2(4000);
        lv_file_name    VARCHAR2(100) := 'DGS_ERROR_FILE_' || TO_CHAR(pd_effective_date, 'YYYYMMDD') ||'.csv';
    BEGIN
        pck_process_info.p_set_action (pv_action_name => 'p_write_error_file_hdr');

        p_open_extract_file (pr_file_handle  => pr_file_handle
                            ,pv_file_name    => lv_file_name);

        lv_line_header :=  'POLREF'            || LPCV_DELIMITER ||
                           'ERROR_DETAILS';

        pck_file_handler.p_write_to_file (pr_file_handle => pr_file_handle
                                         ,pv_line        => lv_line_header
                                         ,pb_new_line    => TRUE
                                         ,pb_flush       => FALSE);
    END p_write_error_file_hdr;

     -- Procedure to open extract headers
    PROCEDURE p_write_extract_headers(pd_effective_date IN DATE)
    IS
    BEGIN
        pck_process_info.p_set_action (pv_action_name => 'p_write_extract_headers');

        p_write_dashboard_hdr  (pd_effective_date => pd_effective_date
                               ,pr_file_handle    => lpr_file_handle_dashboard);

        p_write_moodys_hdr     (pd_effective_date => pd_effective_date
                               ,pr_file_handle  => lpr_file_handle_moodys);

        p_write_error_file_hdr (pd_effective_date => pd_effective_date
                               ,pr_file_handle  => lpr_file_handle_error);

    END p_write_extract_headers;

    -- Procedure to generate error file
    PROCEDURE p_write_to_error_table (pn_policy_reference IN po010.polref%TYPE
                                     ,pv_error_details    IN VARCHAR2
                                     ,pd_effective_date   IN DATE
                                     ,pn_stream           IN PLS_INTEGER)
    IS
        lv_extract  VARCHAR2(4000);
    BEGIN
        pck_process_info.p_set_action (pv_action_name => 'p_write_to_error_table');

        lv_extract :=  pn_policy_reference || LPCV_DELIMITER ||
                       pv_error_details;

        INSERT INTO ddg_extract_errors(extract_date,policy_reference, stream_no, error_text)
        VALUES (pd_effective_date, pn_policy_reference, pn_stream,lv_extract);

    EXCEPTION
    WHEN OTHERS THEN
            pck_err.p_handle(pv_err_code        => 'ERRMSG'
                            ,pt_err_param       => NULL
                            ,pn_err_occurance   => 1
                            ,pv_add_text        => 'Exception in p_write_to_error_table ' ||
                                                    ' for date = ' || TO_CHAR(pd_effective_date, 'dd/mm/yyyy') ||
                                                    ', policy = '  || TO_CHAR(pn_policy_reference) ||
                                                    ', stream = '  || TO_CHAR(pn_stream) ||
                                                    '.'
                            ,pb_log_err         => TRUE
                            ,pb_re_raise        => TRUE
                            ,pb_use_oracle_errm => TRUE);

    END p_write_to_error_table;

    PROCEDURE p_write_to_dashboard_table (pr_client_details   IN r_client_details
                                         ,pr_policy_details   IN r_policy_details
                                         ,pr_calcs_inputs     IN r_calcs_inputs
                                         ,pr_investment_dtls  IN pck_asset_class_allocation.r_investment_details
                                         ,pd_effective_date   IN DATE
                                         ,pn_stream           IN PLS_INTEGER )
    IS
        lv_extract         VARCHAR2(10000);
        ln_fund_ref        pr310.fndref%TYPE;
        ln_fund_idx        PLS_INTEGER := 1;
        LCV_PRODUCT_REF    CONSTANT po010.prdref%TYPE := 'RS-IR';
        LCN_MAX_FUND_COUNT CONSTANT PLS_INTEGER := 35;
    BEGIN
        pck_process_info.p_set_action (pv_action_name => 'p_write_to_dashboard_table');

        lv_extract :=  pr_policy_details.policy_index                              || LPCV_DELIMITER ||
                       pr_client_details.title                                     || LPCV_DELIMITER ||
                       pr_client_details.forename                                  || LPCV_DELIMITER ||
                       pr_client_details.surname                                   || LPCV_DELIMITER ||
                       TO_CHAR(pr_client_details.date_of_birth, 'DD/MM/YYYY')      || LPCV_DELIMITER ||
                       pr_client_details.age                                       || LPCV_DELIMITER ||
                       pr_client_details.sex                                       || LPCV_DELIMITER ||
                       pr_client_details.address_name                              || LPCV_DELIMITER ||
                       pr_client_details.address_line_1                            || LPCV_DELIMITER ||
                       pr_client_details.address_line_2                            || LPCV_DELIMITER ||
                       pr_client_details.address_line_3                            || LPCV_DELIMITER ||
                       pr_client_details.address_line_4                            || LPCV_DELIMITER ||
                       pr_client_details.postcode                                  || LPCV_DELIMITER ||
                       pr_policy_details.policy_reference                          || LPCV_DELIMITER ||
                       LCV_PRODUCT_REF                                             || LPCV_DELIMITER ||
                       pr_policy_details.policy_status                             || LPCV_DELIMITER ||
                       pr_policy_details.exit_mode                                 || LPCV_DELIMITER ||
                       TO_CHAR(pr_policy_details.commencement_date, 'DD/MM/YYYY')  || LPCV_DELIMITER ||
                       TO_CHAR(pr_policy_details.first_bce_date, 'DD/MM/YYYY')     || LPCV_DELIMITER ||
                       pr_calcs_inputs.total_pcls_amount                           || LPCV_DELIMITER ||
                       pr_calcs_inputs.transfer_in_drawdown_ind                    || LPCV_DELIMITER ||
                       pr_calcs_inputs.ir_switch_on_ind                            || LPCV_DELIMITER ||
                       pr_investment_dtls.policy_fund_value                        || LPCV_DELIMITER ||
                       pr_policy_details.adviser_name                              || LPCV_DELIMITER ||
                       pr_policy_details.adviser_no                                || LPCV_DELIMITER ||
                       pr_policy_details.firm_name                                 || LPCV_DELIMITER ||
                       pr_calcs_inputs.expected_income_amount                      || LPCV_DELIMITER ||
                       pr_calcs_inputs.income_frequency                            || LPCV_DELIMITER ||
                       pr_calcs_inputs.escalation_rate                             || LPCV_DELIMITER ||
                       pr_calcs_inputs.expected_rp_amount                          || LPCV_DELIMITER ||
                       pr_calcs_inputs.expected_rp_frequency                       || LPCV_DELIMITER ||
                       TO_CHAR(pr_calcs_inputs.policy_amc, 'FM9990.09')            || LPCV_DELIMITER ||
                       TO_CHAR(pr_calcs_inputs.policy_adviser_charge, 'FM9990.09') || LPCV_DELIMITER ||
                       pr_calcs_inputs.actual_conts_last_year                      || LPCV_DELIMITER ||
                       pr_calcs_inputs.actual_conts_last_quarter                   || LPCV_DELIMITER ||
                       pr_calcs_inputs.income_amount_annual                        || LPCV_DELIMITER ||
                       pr_calcs_inputs.adhoc_income_last_year                      || LPCV_DELIMITER ||
                       pr_calcs_inputs.adhoc_income_last_quarter                   || LPCV_DELIMITER ||
                       pr_investment_dtls.investment_type                          || LPCV_DELIMITER ||
                       pr_investment_dtls.portfolio_name                           || LPCV_DELIMITER ||
                       pr_investment_dtls.strategy_name;

        -- Fund Split
        ln_fund_ref := pr_investment_dtls.fund_split.FIRST;

        WHILE (ln_fund_ref IS NOT NULL) LOOP

            ln_fund_idx := ln_fund_idx + 1;

            lv_extract := lv_extract || LPCV_DELIMITER || pr_investment_dtls.fund_split(ln_fund_ref).fund_name   || LPCV_DELIMITER ||
                                                          pr_investment_dtls.fund_split(ln_fund_ref).fund_code   || LPCV_DELIMITER ||
                                                          pr_investment_dtls.fund_split(ln_fund_ref).fund_split;

            ln_fund_ref := pr_investment_dtls.fund_split.NEXT(ln_fund_ref);
        END LOOP;

        -- Fill it with blank values
        FOR idx IN ln_fund_idx..LCN_MAX_FUND_COUNT LOOP
            lv_extract := lv_extract || LPCV_DELIMITER || LPCV_DELIMITER || LPCV_DELIMITER;
        END LOOP;

        lv_extract := lv_extract || LPCV_DELIMITER || pr_calcs_inputs.target                      || LPCV_DELIMITER ||
                                                      pr_calcs_inputs.target_age                  || LPCV_DELIMITER ||
                                                      pr_calcs_inputs.review_service_switch       || LPCV_DELIMITER ||
                                                      pr_calcs_inputs.reason_for_exclusion        || LPCV_DELIMITER ||
                                                      pr_calcs_inputs.short_term_outlook          || LPCV_DELIMITER ||
                                                      TO_CHAR(pr_calcs_inputs.actual_growth_rate, 'FM9990.09') || LPCV_DELIMITER ||
                                                      pr_calcs_inputs.expected_growth_rate        || LPCV_DELIMITER ||
                                                      pr_calcs_inputs.total_income_amount         || LPCV_DELIMITER ||
                                                      pr_policy_details.product_version           || LPCV_DELIMITER ||
                                                      pr_policy_details.retirement_age;

        INSERT INTO ddg_oryx_extract(extract_date, policy_index, stream_no, policy_reference,extract_row)
        VALUES (pd_effective_date, pr_policy_details.policy_index, pn_stream, pr_policy_details.policy_reference, lv_extract);

    EXCEPTION
    WHEN OTHERS THEN
            pck_err.p_handle(pv_err_code        => 'ERRMSG'
                            ,pt_err_param       => NULL
                            ,pn_err_occurance   => 1
                            ,pv_add_text        => 'Exception in p_write_to_dashboard_table ' ||
                                                    ' for date = ' || TO_CHAR(pd_effective_date, 'dd/mm/yyyy') ||
                                                    ', policy = '  || TO_CHAR(pr_policy_details.policy_reference) ||
                                                    ', stream = '  || TO_CHAR(pn_stream) ||
                                                    '.'
                            ,pb_log_err         => TRUE
                            ,pb_re_raise        => TRUE
                            ,pb_use_oracle_errm => TRUE);

    END p_write_to_dashboard_table;

    PROCEDURE p_write_to_moodys_table (pr_client_details   IN r_client_details
                                      ,pr_policy_details   IN r_policy_details
                                      ,pr_calcs_inputs     IN r_calcs_inputs
                                      ,pr_investment_dtls  IN pck_asset_class_allocation.r_investment_details
                                      ,pd_effective_date   IN DATE
                                      ,pn_stream           IN PLS_INTEGER)
    IS
        lv_extract  VARCHAR2(10000);
        ln_term_idx  PLS_INTEGER     := pr_investment_dtls.asset_class_split.LAST ;
    BEGIN
        pck_process_info.p_set_action (pv_action_name => 'p_write_to_moodys_table');

        WHILE (ln_term_idx IS NOT NULL) LOOP

            lv_extract :=  pr_policy_details.policy_index                                                                    || LPCV_DELIMITER ||
                           TO_CHAR(pr_client_details.date_of_birth, 'DD/MM/YYYY')                                            || LPCV_DELIMITER ||
                           pr_client_details.age                                                                             || LPCV_DELIMITER ||
                           pr_investment_dtls.policy_fund_value                                                              || LPCV_DELIMITER ||
                           TO_CHAR(pr_calcs_inputs.policy_amc + pr_calcs_inputs.policy_adviser_charge)                       || LPCV_DELIMITER ||
                           pr_calcs_inputs.expected_rp_amount_yr                                                             || LPCV_DELIMITER ||
                           TO_CHAR(pr_calcs_inputs.rp_esc_rate)                                                              || LPCV_DELIMITER ||
                           CASE
                           WHEN pr_calcs_inputs.rp_indicator = 'N' THEN LPCV_SPACE
                           WHEN pck_policy_details.f_is_premium_holiday
                                            (pn_policy_ref => pr_policy_details.policy_reference) THEN

                                TO_CHAR(f_premium_hol_start_age (pr_policy_details.policy_reference
                                                                ,pr_client_details.date_of_birth))

                           ELSE TO_CHAR(pr_policy_details.retirement_age) END                                                 || LPCV_DELIMITER ||
                           pr_calcs_inputs.expected_income_amount_yr                                                          || LPCV_DELIMITER ||
                           pr_calcs_inputs.target                                                                             || LPCV_DELIMITER ||
                           TO_CHAR(pr_calcs_inputs.target_age)                                                                || LPCV_DELIMITER ||
                           pr_investment_dtls.investment_type                                                                 || LPCV_DELIMITER ||
                           CASE
                           WHEN pr_investment_dtls.strategy_name  IS NOT NULL THEN pr_investment_dtls.strategy_name
                           WHEN pr_investment_dtls.portfolio_name IS NOT NULL THEN pr_investment_dtls.portfolio_name
                           ELSE LPCV_SPACE END                                                                                || LPCV_DELIMITER ||
                           ln_term_idx                                                                   || LPCV_DELIMITER ||
                           pr_investment_dtls.asset_class_split(ln_term_idx).cash                        || LPCV_DELIMITER ||
                           pr_investment_dtls.asset_class_split(ln_term_idx).corporate_bonds_5           || LPCV_DELIMITER ||
                           pr_investment_dtls.asset_class_split(ln_term_idx).corporate_bonds_10          || LPCV_DELIMITER ||
                           pr_investment_dtls.asset_class_split(ln_term_idx).corporate_bonds_15          || LPCV_DELIMITER ||
                           pr_investment_dtls.asset_class_split(ln_term_idx).gilts_5                     || LPCV_DELIMITER ||
                           pr_investment_dtls.asset_class_split(ln_term_idx).gilts_10                    || LPCV_DELIMITER ||
                           pr_investment_dtls.asset_class_split(ln_term_idx).gilts_15                    || LPCV_DELIMITER ||
                           pr_investment_dtls.asset_class_split(ln_term_idx).index_linked_bonds_5        || LPCV_DELIMITER ||
                           pr_investment_dtls.asset_class_split(ln_term_idx).index_linked_bonds_10       || LPCV_DELIMITER ||
                           pr_investment_dtls.asset_class_split(ln_term_idx).index_linked_bonds_15       || LPCV_DELIMITER ||
                           pr_investment_dtls.asset_class_split(ln_term_idx).overseas_equity             || LPCV_DELIMITER ||
                           pr_investment_dtls.asset_class_split(ln_term_idx).property                    || LPCV_DELIMITER ||
                           pr_investment_dtls.asset_class_split(ln_term_idx).uk_equity                   || LPCV_DELIMITER ||
                           pr_investment_dtls.asset_class_split(ln_term_idx).Commodities                 || LPCV_DELIMITER ||
                           pr_investment_dtls.asset_class_split(ln_term_idx).Absolute_return_bond        || LPCV_DELIMITER ||
                           pr_investment_dtls.asset_class_split(ln_term_idx).Absolute_return_multi_strat || LPCV_DELIMITER ||
                           pr_investment_dtls.asset_class_split(ln_term_idx).Uk_high_yield;

            INSERT INTO ddg_moodys_input(extract_date, policy_index, term_to_retire, stream_no, extract_row)
            VALUES (pd_effective_date, pr_policy_details.policy_index, ln_term_idx, pn_stream, lv_extract);

            ln_term_idx :=  pr_investment_dtls.asset_class_split.PRIOR(ln_term_idx);

        END LOOP;

    EXCEPTION
    WHEN OTHERS THEN
            pck_err.p_handle(pv_err_code        => 'ERRMSG'
                            ,pt_err_param       => NULL
                            ,pn_err_occurance   => 1
                            ,pv_add_text        => 'Exception in p_write_to_moodys_table ' ||
                                                    ' for date = ' || TO_CHAR(pd_effective_date, 'dd/mm/yyyy') ||
                                                    ', policy = '  || TO_CHAR(pr_policy_details.policy_index) ||
                                                    ', stream = '  || TO_CHAR(pn_stream) ||
                                                    '.'
                            ,pb_log_err         => TRUE
                            ,pb_re_raise        => TRUE
                            ,pb_use_oracle_errm => TRUE);

    END p_write_to_moodys_table;

    FUNCTION f_get_effective_date RETURN DATE IS

        ln_process_id       process_master.process_id%TYPE;
        lr_ddg_attributes   pck_process_control_parameters.r_process_control_data;

    BEGIN
        pck_process_info.p_set_action (pv_action_name => 'F_GET_EFFECTIVE_DATE');

        ln_process_id := pck_process_master.f_process_id (pv_process_name    => 'PCK_DRAWDOWN_GOVERNANCE'
                                                         ,pv_subprocess_name => 'P_DDG_ORYX_EXTRACT_ATTRIBUTES'
                                                         ,pv_process_type    => 'PL/SQL');

        lr_ddg_attributes := pck_process_control_parameters.f_curr_process_cntrl_setting
                                                                     (pn_process_id       => ln_process_id
                                                                     ,pv_process_subname  => 'F_DDG_RUN_DATE'
                                                                     ,pv_control_type     => 'DDG_RUN_DATE');

        RETURN TO_DATE(lr_ddg_attributes.process_control_value, 'DD/MM/YYYY');

    END f_get_effective_date;

    PROCEDURE p_set_extract_to_stop IS

    BEGIN
        pck_process_info.p_set_action (pv_action_name => 'P_SET_EXTRACT_TO_STOP');

        --Set the DDG_Policy parameter in process_control_parameters to 'STOP' so the extract won't run again.

        UPDATE process_control_parameters pcp
        SET pcp.process_control_value = 'STOP'
        WHERE pcp.process_control_id =
                                        (
                                        SELECT pcp2.process_control_id
                                        FROM process_control_parameters pcp2
                                        WHERE pcp2.process_id =
                                                                (
                                                                SELECT pm.process_id
                                                                FROM process_master pm
                                                                WHERE pm.process_name  = 'PCK_DRAWDOWN_GOVERNANCE'
                                                                AND pm.process_type    = 'PL/SQL'
                                                                AND pm.SUBPROCESS_NAME = 'P_DDG_ORYX_EXTRACT_ATTRIBUTES'
                                                                )
                                        AND pcp2.process_control_type = 'DDG_POLICY'
                                        AND pcp2.end_date            = TO_DATE('01/01/2999', 'dd-mm-yyyy')
                                        );

    EXCEPTION
    WHEN OTHERS THEN
            pck_err.p_handle(pv_err_code        => 'ERRMSG'
                            ,pt_err_param       => NULL
                            ,pn_err_occurance   => 1
                            ,pv_add_text        => 'Exception in p_set_extract_to_stop.'
                            ,pb_log_err         => TRUE
                            ,pb_re_raise        => TRUE
                            ,pb_use_oracle_errm => TRUE);

    END p_set_extract_to_stop;

    PROCEDURE p_write_extract_to_file IS

        ld_effective_date DATE := f_get_effective_date;
        lv_error_message  VARCHAR2(100);

    BEGIN
        pck_process_info.p_set_action (pv_action_name => 'P_WRITE_EXTRACT_TO_FILE');

        p_write_extract_headers(pd_effective_date => ld_effective_date);

        lv_error_message := 'writing to ddg_oryx_extract';

        FOR rec IN (SELECT doe.extract_row
                    FROM ddg_oryx_extract doe
                    WHERE doe.extract_date = ld_effective_date)
        LOOP

            pck_file_handler.p_write_to_file (pr_file_handle => lpr_file_handle_dashboard
                                             ,pv_line        => rec.extract_row
                                             ,pb_new_line    => TRUE
                                             ,pb_flush       => FALSE);

        END LOOP;

        lv_error_message := 'writing to ddg_moodys_input';

        FOR rec IN (SELECT dmi.extract_row
                    FROM ddg_moodys_input dmi
                    WHERE dmi.extract_date = ld_effective_date
                    ORDER BY dmi.policy_index, dmi.term_to_retire DESC)
        LOOP

            pck_file_handler.p_write_to_file (pr_file_handle => lpr_file_handle_moodys
                                             ,pv_line        => rec.extract_row
                                             ,pb_new_line    => TRUE
                                             ,pb_flush       => FALSE);

        END LOOP;

        lv_error_message := 'writing to ddg_extract_errors';

        FOR rec IN (SELECT dee.error_text
                    FROM ddg_extract_errors dee
                    WHERE dee.extract_date = ld_effective_date)
        LOOP

            pck_file_handler.p_write_to_file (pr_file_handle => lpr_file_handle_error
                                             ,pv_line        => rec.error_text
                                             ,pb_new_line    => TRUE
                                             ,pb_flush       => FALSE);

        END LOOP;

        p_close_extract_files;
        p_set_extract_to_stop;

    EXCEPTION
    WHEN OTHERS THEN
            pck_err.p_handle(pv_err_code        => 'ERRMSG'
                            ,pt_err_param       => NULL
                            ,pn_err_occurance   => 1
                            ,pv_add_text        => 'Exception in p_write_extract_to_file ' ||
                                                    lv_error_message ||
                                                    ' for date ' || TO_CHAR(ld_effective_date, 'dd/mm/yyyy') ||
                                                    '.'
                            ,pb_log_err         => TRUE
                            ,pb_re_raise        => TRUE
                            ,pb_use_oracle_errm => TRUE);

    END p_write_extract_to_file;

    PROCEDURE p_get_escalation_rate (pn_policy_ref      IN  po010.polref%TYPE
                                    ,pn_escalation_rate OUT po015.emrinrrte%TYPE)
    IS
        ln_employer_ctb_percent     po015.emrctbpct%TYPE;
        ln_employee_ctb_percent     po015.empctbpct%TYPE;
        lv_employer_ctb_basis       po015.emrctbbas%TYPE;
        lv_employee_ctb_basis       po015.empctbbas%TYPE;
        ln_employee_incr_rate       po015.empctbpct%TYPE;
        ln_employer_incr_rate       po015.emrctbpct%TYPE;
        lv_employer_escalation_type po015.emresctyp%TYPE;
        lv_employee_escalation_type po015.empesctyp%TYPE;
        ln_escalation_rate          po015.rtrescrte%TYPE;
        lv_adv_arr_ind              po015.advarsind%TYPE;
        ln_widow_annuity_percent    po015.pln_b_fac%TYPE;
        lr_rates                    pck_calcs_definitions.r_rates;
    BEGIN
        pck_process_info.p_set_action (pv_action_name => 'p_get_escalation_rate');

        pck_projections_common.p_get_contribs (pn_policy_ref               => pn_policy_ref
                                              ,pn_employer_ctb_percent     => ln_employer_ctb_percent
                                              ,pn_employee_ctb_percent     => ln_employee_ctb_percent
                                              ,pv_employee_ctb_basis       => lv_employee_ctb_basis
                                              ,pn_employee_incr_rate       => ln_employee_incr_rate
                                              ,pv_employer_ctb_basis       => lv_employer_ctb_basis
                                              ,pn_employer_incr_rate       => ln_employer_incr_rate
                                              ,pv_employer_escalation_type => lv_employer_escalation_type
                                              ,pv_employee_escalation_type => lv_employee_escalation_type
                                              ,pn_escalation_rate          => ln_escalation_rate
                                              ,pn_widow_annuity_percent    => ln_widow_annuity_percent
                                              ,pv_adv_arr_ind              => lv_adv_arr_ind);

        IF lv_employer_escalation_type = 'R' OR
           lv_employee_escalation_type = 'R' THEN

            lr_rates := pck_Calcs_common.f_rates;
            pn_escalation_rate :=   lr_rates.mid_rpi * 100;

        ELSIF lv_employer_escalation_type = 'F' OR
              lv_employee_escalation_type = 'F' THEN
            pn_escalation_rate := GREATEST (ln_employee_incr_rate, ln_employer_incr_rate);
        END IF;

        pn_escalation_rate := NVL(pn_escalation_rate, 0);
    END p_get_escalation_rate;

    -- Function to get Custom Governed portfolio Name
    FUNCTION f_get_custom_gov_portfolio (pn_strategy_id    IN strategy_portfolios.strategy_id%TYPE
                                        ,pd_effective_date IN strategy_portfolios.end_date%TYPE)
    RETURN strategy_portfolios.fund_reference%TYPE
    IS
        CURSOR cu_custom_gov_portfolio (pcn_strategy_id    strategy_portfolios.strategy_id%TYPE
                                       ,pcd_effective_date strategy_portfolios.end_date%TYPE) IS
            SELECT  fund_reference
            FROM    strategy_portfolios
            WHERE   strategy_id =  pcn_strategy_id
            AND     pcd_effective_date BETWEEN start_date AND end_date;

        ln_custom_gp_ref  strategy_portfolios.fund_reference%TYPE;
    BEGIN
        pck_process_info.p_set_action (pv_action_name => 'f_get_custom_gov_portfolio');

        OPEN cu_custom_gov_portfolio (pcn_strategy_id     => pn_strategy_id
                                     ,pcd_effective_date  => pd_effective_date);

        FETCH cu_custom_gov_portfolio INTO  ln_custom_gp_ref;
        CLOSE cu_custom_gov_portfolio;
    RETURN ln_custom_gp_ref;
    END f_get_custom_gov_portfolio;

    PROCEDURE p_income_paid (pn_policy_reference IN  po010.polref%TYPE
                            ,pn_number_of_months IN  NUMBER
                            ,pn_regular_total    OUT NUMBER
                            ,pn_adhoc_total      OUT NUMBER)
    IS

    BEGIN
        pck_process_info.p_set_action (pv_action_name => 'p_income_paid');

        pck_payment_history_api.p_paid_by_due_date(pn_policy_reference => pn_policy_reference
                                                  ,pd_start_date       => ADD_MONTHS(lpd_effective_date, -1 * pn_number_of_months)
                                                  ,pd_end_date         => lpd_effective_date - 1
                                                  ,pn_regular_total    => pn_regular_total
                                                  ,pn_adhoc_total      => pn_adhoc_total);

    END p_income_paid;

    -- Actual contributions paid in
    FUNCTION f_contributions_paid (pn_policy_reference IN po010.polref%TYPE
                                  ,pn_number_of_months IN NUMBER)
    RETURN event.trnamt2%TYPE
    IS
        CURSOR cu_contributions_paid (pcn_policy_reference  po010.polref%TYPE
                                     ,pcn_number_of_months  NUMBER)
        IS
            SELECT SUM(e.trnamt2)
            FROM   event e
            WHERE  e.polref  =  pcn_policy_reference
            AND    e.ispec   =  'FI560'
            AND    e.staevt  =  55
            AND    TO_DATE(e.dte1 + 2415021, 'J') BETWEEN  ADD_MONTHS(lpd_effective_date, - pcn_number_of_months)
                                                  AND (lpd_effective_date - 1);

        ln_contributions_paid  event.trnamt2%TYPE;
    BEGIN
        pck_process_info.p_set_action (pv_action_name => 'f_contributions_paid');

        OPEN cu_contributions_paid (pcn_policy_reference  => pn_policy_reference
                                   ,pcn_number_of_months  => pn_number_of_months);

        FETCH cu_contributions_paid INTO ln_contributions_paid;
        CLOSE cu_contributions_paid;

        RETURN NVL(ln_contributions_paid, 0);
    END f_contributions_paid;

    -- Procedure to retreive future RPs
    PROCEDURE p_retrieve_future_rps (pn_policy_reference   IN po010.polref%TYPE
                                    ,pn_expected_amount_yr OUT po020.polamt%TYPE
                                    ,pn_expected_amount    OUT po020.polamt%TYPE
                                    ,pv_expected_frequency OUT po030.prmfrq%TYPE
                                    ,pv_rp_indicator       OUT VARCHAR2)
    IS
        ln_frp_index         PLS_INTEGER;
        ln_frp_fund          po020.polamt%TYPE := 0;
        lt_frp_inputs        pck_calcs_definitions_nipp.t_frp_details_inrref;
        ln_frequency         PLS_INTEGER;
        lv_premium_frequency po030.prmfrq%TYPE;

    BEGIN
        pck_process_info.p_set_action (pv_action_name => 'p_retrieve_future_rps');

        lv_premium_frequency := NVL(TRIM(pck_calcs_existing_biz.f_get_premium_frequency(pn_policy_reference => pn_policy_reference
                                                                                  ,pv_ben_type         => 'INV'
                                                                                  ,pn_quote_date       => lpd_effective_date - to_date('01/01/1900','dd/mm/yyyy')))
                                   ,'S');

        ln_frequency := pck_calcs_common.f_frequency_factor(pv_frequency => lv_premium_frequency);

        pck_projections_common.p_get_future_premiums(pn_policy_ref  => pn_policy_reference,
                                                     pt_frp_details => lt_frp_inputs);

            IF pck_projections_common.f_any_future_rp(pn_policy_reference => pn_policy_reference
                                                     ,pn_quote_date       => lpn_effective_date) THEN
                -- FRP inputs
                ln_frp_index := lt_frp_inputs.FIRST;

                -- fund is divided to get the expected amount then multiplied up to get the expected amount year, to
                -- replicate the rounding applied in projection calculations
                WHILE ln_frp_index IS NOT NULL LOOP
                    ln_frp_fund := NVL(ln_frp_fund , 0)
                                +  NVL(ROUND(lt_frp_inputs(ln_frp_index).employer_ctb_amount/ln_frequency,2), 0)
                                +  NVL(ROUND(lt_frp_inputs(ln_frp_index).member_ctb_amount/ln_frequency,2), 0);
                    ln_frp_index := lt_frp_inputs.NEXT(ln_frp_index);
                END LOOP;


               pn_expected_amount := ln_frp_fund;

               pn_expected_amount_yr := ln_frp_fund
                                         * pck_calcs_common.f_frequency_factor(lv_premium_frequency);

            ELSE

                pn_expected_amount := 0;
                pn_expected_amount_yr := 0;

            END IF;

       IF pn_expected_amount_yr > 0  THEN
           pv_rp_indicator          := 'Y';
           pv_expected_frequency    := lv_premium_frequency;
       ELSE
           pv_rp_indicator          := 'N';
           pv_expected_frequency    := 'M';
       END IF;

    END p_retrieve_future_rps;

    PROCEDURE p_expected_income(pn_policy_reference          IN  po010.polref%TYPE
                               ,pn_expected_income_amount    OUT pre_sale_designation_dtls.annual_income_amount%TYPE
                               ,pn_expected_income_amount_yr OUT pre_sale_designation_dtls.annual_income_amount%TYPE
                               ,pv_expected_income_frequency OUT pre_sale_designation_dtls.frequency%TYPE
                               ,pn_expected_income_esc_rate  OUT pre_sale_designation_dtls.escalation_rate%TYPE
                               )
    IS

        lr_psdd_inputs pck_ir_reviews.r_psdd_inputs;

    BEGIN

        pck_process_info.p_set_action (pv_action_name => 'p_expected_income');

        lr_psdd_inputs := pck_ir_reviews.f_ir_details(pn_policy_reference => pn_policy_reference
                                                     ,pn_quote_date       => lpd_effective_date - to_date('01/01/1900','dd/mm/yyyy'));

        pn_expected_income_amount_yr   := NVL(lr_psdd_inputs.annual_income_amount, 0);

        pn_expected_income_amount      := 0;
        pv_expected_income_frequency   := 'M';
        pn_expected_income_esc_rate    := 0;

        IF lr_psdd_inputs.frequency IS NULL THEN
            --replicate functionality OF pck_ir_reviews.p_eavl_ir_details
            pn_expected_income_amount_yr := 0;

        ELSIF pn_expected_income_amount_yr > 0 THEN

            pv_expected_income_frequency := lr_psdd_inputs.frequency;
            pn_expected_income_esc_rate  := NVL(lr_psdd_inputs.escalation_rate,0);
            pn_expected_income_amount    := ROUND(pn_expected_income_amount_yr / pck_calcs_common.f_frequency_factor(pv_expected_income_frequency), 2);

        END IF;

    END p_expected_income;

    PROCEDURE p_tfc_income_out (pn_policy_reference IN po010.polref%TYPE
                               ,pn_number_of_months IN NUMBER
                               ,pn_id_amt_total     OUT NUMBER
                               ,pn_tfc_amt_total    OUT NUMBER
                               ,pn_dtf_amt_total    OUT NUMBER ) IS
    BEGIN
        pck_process_info.p_set_action (pv_action_name => 'p_tfc_income_out');

        SELECT
            NVL(SUM(id_amt)  * -1, 0) id_amt_total,
            NVL(SUM(tfc_amt) * -1, 0) tfc_amt_total,
            NVL(SUM(dtf_amt) * -1, 0) dtf_amt_total
        INTO
            pn_id_amt_total,
            pn_tfc_amt_total,
            pn_dtf_amt_total
        FROM
            (
            SELECT
                (CASE WHEN fi.fndtrntyp = 'ID' THEN amt END)  id_amt,
                (CASE WHEN fi.fndtrntyp = 'TFC' THEN amt END) tfc_amt,
                (CASE WHEN fi.fndtrntyp = 'DTF' THEN amt END) dtf_amt
            FROM
                fi700 fi
            WHERE
                fi.polref =  pn_policy_reference
            AND fndtrntyp IN ('ID', 'TFC', 'DTF')
            AND staevt    IN (50, 65)
            AND TO_DATE(efvdte + 2415021, 'J') BETWEEN  ADD_MONTHS(lpd_effective_date, - pn_number_of_months)
                                               AND (lpd_effective_date - 1)
            ) trn_amt;

    END p_tfc_income_out;

    -- Procedure to get client details
    PROCEDURE p_retrieve_client_details (pn_policy_reference IN  po010.polref%TYPE
                                        ,pd_effective_date   IN  DATE
                                        ,pr_client_details   OUT r_client_details)
    IS
        lv_clicat            cl010.clicat%TYPE;
        lv_cliref            cl010.cliref%TYPE;
        lv_nat_insurance_no  cl010.natinr_no%TYPE;
        ln_birth_date        cl010.bthdte%TYPE;
        lv_marrital_status   cl010.mrrsta%TYPE;
        lr_address_details   pck_addresses.r_address_details;
    BEGIN
        pck_process_info.p_set_action (pv_action_name => 'p_retrieve_client_details');

        pck_client_details.p_get_policy_client
                                   (pn_policy_reference  =>  pn_policy_reference
                                   ,pv_clicat            =>  lv_clicat
                                   ,pn_cliref            =>  lv_cliref
                                   ,pv_title             =>  pr_client_details.title
                                   ,pv_forenames         =>  pr_client_details.forename
                                   ,pv_surname           =>  pr_client_details.surname
                                   ,pv_sex               =>  pr_client_details.sex
                                   ,pv_nat_insurance_no  =>  lv_nat_insurance_no
                                   ,pn_birth_date        =>  ln_birth_date
                                   ,pv_marrital_status   =>  lv_marrital_status);

        pr_client_details.date_of_birth := pck_utility.f_dtcnv (ln_birth_date);
        pr_client_details.age           := TRUNC(MONTHS_BETWEEN(pd_effective_date, pr_client_details.date_of_birth) / 12);

        pck_addresses.p_get_policyholder_address (pv_client_category   => lv_clicat
                                                 ,pn_client_reference  => lv_cliref
                                                 ,pn_policy_reference  => pn_policy_reference
                                                 ,pr_address_details   => lr_address_details);

        pr_client_details.title          :=  f_replace_comma_with_space (pr_client_details.title);
        pr_client_details.forename       :=  f_replace_comma_with_space (pr_client_details.forename);
        pr_client_details.surname        :=  f_replace_comma_with_space (pr_client_details.surname);
        pr_client_details.address_name   :=  f_replace_comma_with_space (lr_address_details.addressee_name);
        pr_client_details.address_line_1 :=  f_replace_comma_with_space (lr_address_details.address_line1);
        pr_client_details.address_line_2 :=  f_replace_comma_with_space (lr_address_details.address_line2);
        pr_client_details.address_line_3 :=  f_replace_comma_with_space (lr_address_details.address_line3);
        pr_client_details.address_line_4 :=  f_replace_comma_with_space (lr_address_details.address_line4);
        pr_client_details.postcode       :=  f_replace_comma_with_space (lr_address_details.post_code);

    END p_retrieve_client_details;

    PROCEDURE p_retrieve_policy_details (pn_policy_reference IN  po010.polref%TYPE
                                        ,pn_policy_index     IN  PLS_INTEGER
                                        ,pr_client_details   IN  r_client_details
                                        ,pr_policy_details   OUT r_policy_details)
    IS
        lr_po010            po010%ROWTYPE;

        -- First BCE Date
        CURSOR lcu_bce_date (pcn_policy_reference IN po010.polref%TYPE) IS
           WITH first_bce_date AS
               (SELECT TO_DATE(bce_date + 2415021, 'J')  bce_date
                FROM   (SELECT b.bce_date
                              ,ROW_NUMBER() OVER (PARTITION BY policy ORDER BY bce_date) pick_one_record
                        FROM   bce   b
                        WHERE  exit_mode    = 90
                        AND    policy       = pcn_policy_reference
                        AND    bce_subtype IN ('PCLS','USP'))
                WHERE pick_one_record = 1)

            SELECT bce_date
            FROM   first_bce_date;
    BEGIN
        pck_process_info.p_set_action (pv_action_name => 'p_retrieve_policy_details');

        lr_po010 := pck_policy_details.f_get_row (pn_policy_reference => pn_policy_reference);

        pr_policy_details.policy_index      :=  pn_policy_index;
        pr_policy_details.policy_reference  :=  pn_policy_reference;
        pr_policy_details.product_reference :=  lr_po010.prdref;
        pr_policy_details.product_version   :=  lr_po010.prdvrs_no;
        pr_policy_details.commencement_date :=  pck_common.f_dtcnv (lr_po010.polcrcdte);
        pr_policy_details.stapol            :=  lr_po010.Stapol;

        pr_policy_details.policy_status := pck_income_release_common.f_verbalise
                         (pv_ispec          =>  'POL'
                         ,pv_data_item      =>  'STAPOL'
                         ,pn_data_value     =>  lr_po010.Stapol
                         ,pn_name_or_desc   =>  1);

        pr_policy_details.retirement_date := pck_calcs_existing_biz.f_get_retire_date
                                                                        (pn_policy_reference => pn_policy_reference
                                                                        ,pr_po010_row        => lr_po010);

        pr_policy_details.retirement_age := ROUND(MONTHS_BETWEEN(pr_policy_details.retirement_date, pr_client_details.date_of_birth) / 12);

        pr_policy_details.term_to_retire := pr_policy_details.retirement_age- pr_client_details.age;

        pr_policy_details.adviser_no := f_get_policy_adviser (pn_policy => pn_policy_reference
                                                             ,pn_efvdte => lpn_effective_date);

        pr_policy_details.adviser_name := f_replace_comma_with_space(pck_intermediary_details.f_get_itr_name
                                                                             (pn_itr_reference => pr_policy_details.adviser_no));

        pr_policy_details.firm_name := f_replace_comma_with_space(pck_intermediary_details.f_get_company_name
                                                                       (pn_itr_reference =>  pr_policy_details.adviser_no));

        OPEN  lcu_bce_date (pcn_policy_reference => pn_policy_reference);
        FETCH lcu_bce_date INTO pr_policy_details.first_bce_date;
        CLOSE lcu_bce_date;

        pr_policy_details.exit_mode := pck_verbalize_codes.f_description(pv_ispec_group_name =>  'POL'
                                                                        ,pv_data_item_name   =>  'EXTMOD'
                                                                        ,pv_data_item_value  =>  LPAD(lr_po010.extmod,5,'0'));

    END p_retrieve_policy_details;

    -- Procedure to calculate composite FMC
    PROCEDURE p_calculate_composite_fmc (pt_fund_ref_split  IN  pck_asset_class_allocation.t_fund_ref_split
                                        ,pn_fmc             OUT pr315.mgmfeepct%TYPE)
    IS
        ln_fnd_idx  PLS_INTEGER;
    BEGIN
        pck_process_info.p_set_action (pv_action_name => 'p_calculate_composite_fmc');

        pn_fmc := 0;

        ln_fnd_idx :=  pt_fund_ref_split.FIRST;

        WHILE (ln_fnd_idx IS NOT NULL)  LOOP
            pn_fmc := pn_fmc + (pt_fund_ref_split (ln_fnd_idx).split
                              * NVL(pt_fund_ref_split (ln_fnd_idx).fmc - 1,0)/100);

            ln_fnd_idx :=  pt_fund_ref_split.NEXT(ln_fnd_idx);
        END LOOP;
    END p_calculate_composite_fmc;

    -- Procedure to retreive AMC for each increments
    PROCEDURE p_retrieve_increment_amc (pr_policy_details             IN  r_policy_details
                                       ,pn_policy_fund_value          IN  NUMBER
                                       ,pt_inrtyp_inrref_fndref_split IN  pck_asset_class_allocation.t_inrtyp_inrref_fndref_split
                                       ,pt_incrm_amc                  IN OUT t_incrm_amc)
    IS
        lr_mgmt_charge_sec_data     pck_nip603_setup_data.r_mgmt_charge_sec_data;
        ln_eb_idx                   PLS_INTEGER;
    BEGIN
        pck_process_info.p_set_action (pv_action_name => 'p_retrieve_increment_amc');

        ln_eb_idx := pt_incrm_amc.FIRST;

        WHILE ln_eb_idx IS NOT NULL LOOP

            -- Get management charge discount dependent on product and fund value
            lr_mgmt_charge_sec_data.discount := pck_charges.f_calculate_discount
                                                      (pv_product_ref      => pr_policy_details.product_reference
                                                      ,pn_product_version  => pr_policy_details.product_version
                                                      ,pn_fund_value       => pn_policy_fund_value
                                                      ,pn_start_date       => lpn_effective_date);

            lr_mgmt_charge_sec_data.add_fund_charge := 0;

            IF pt_inrtyp_inrref_fndref_split.EXISTS(pt_incrm_amc(ln_eb_idx).incr_typ) AND
               pt_inrtyp_inrref_fndref_split(pt_incrm_amc(ln_eb_idx).incr_typ).EXISTS (pt_incrm_amc(ln_eb_idx).incr_ref) THEN


                 p_calculate_composite_fmc (pt_fund_ref_split  => pt_inrtyp_inrref_fndref_split (pt_incrm_amc(ln_eb_idx).incr_typ)
                                                                                           (pt_incrm_amc(ln_eb_idx).incr_ref)
                                           ,pn_fmc             => lr_mgmt_charge_sec_data.add_fund_charge);

            END IF;

            /*
            AMC calc:

                Total management charge =
                    Basic charge
                    minus Management charge discount
                    plus/minus Adviser adjustment (if applicable)
                    plus Adviser payment charge (if applicable)
                    plus Additional investment charge (if applicable)
            */

            pt_incrm_amc (ln_eb_idx).amc_rate := 1
                                                 - pt_incrm_amc(ln_eb_idx).amc_rate
                                                 + lr_mgmt_charge_sec_data.add_fund_charge
                                                 - lr_mgmt_charge_sec_data.discount;

            ln_eb_idx := pt_incrm_amc.NEXT(ln_eb_idx);
        END LOOP;
    END p_retrieve_increment_amc;

    FUNCTION f_increment_rate_adjustment(pn_policy_reference IN po010.polref%TYPE
                                       ,pv_increment_type   IN po020.inrtyp%TYPE
                                       ,pn_increment_ref    IN po020.inrref%TYPE)
    RETURN NUMBER
    IS

        CURSOR cu_adc(pcn_policy_reference IN po010.polref%TYPE
                     ,pcv_increment_type   IN po020.inrtyp%TYPE
                     ,pcn_increment_ref    IN po020.inrref%TYPE
                     ,pcn_effective_date   IN po028.strdte%TYPE) IS
        SELECT (TRUNC(SUM(NVL(p2.crgadjrte, 0)), 2)) adc
          FROM   po028 p2
          WHERE  p2.polref = pcn_policy_reference
          AND    p2.inrtyp = pcv_increment_type
          AND    p2.inrref = pcn_increment_ref
          AND    p2.sta IN (30,52)
          AND    p2.strdte <= pcn_effective_date
          AND    p2.enddte >= pcn_effective_date
          AND    p2.crgadjtyp = 'BN'
          AND    p2.crgadjsrc IN ('C', 'QSD', 'HOC', 'HOE', 'TAC', 'ECR', 'KAE', 'E', 'SPC')
          GROUP BY polref, inrtyp, inrref;

          ln_rate_adjustment NUMBER(6,2);

    BEGIN
        pck_process_info.p_set_action (pv_action_name => 'f_increment_rate_adjustment');

        OPEN cu_adc(pcn_policy_reference => pn_policy_reference
                   ,pcv_increment_type   => pv_increment_type
                   ,pcn_increment_ref    => pn_increment_ref
                   ,pcn_effective_date   => lpd_effective_date - to_date('01/01/1900','dd/mm/yyyy'));

        FETCH cu_adc INTO ln_rate_adjustment;
        CLOSE cu_adc;

        RETURN NVL(ln_rate_adjustment,0);

    END f_increment_rate_adjustment;

    PROCEDURE p_adviser_commission(pn_policy_reference IN po010.polref%TYPE
                                  ,pt_incrm_ref_fndvl  IN  pck_asset_class_allocation.t_incrm_ref_fndvl
                                  ,pt_incrm_amc        OUT t_incrm_amc)
    IS
        lv_incr_type_ref  tyv_vchar_idx;
        lv_increment_type po020.inrtyp%TYPE;
        ln_increment_ref  po020.inrref%TYPE;
        ln_count          PLS_INTEGER := 0;
    BEGIN
        pck_process_info.p_set_action (pv_action_name => 'p_adviser_commission');

        lv_incr_type_ref := pt_incrm_ref_fndvl.FIRST;

            WHILE lv_incr_type_ref IS NOT NULL LOOP

                lv_increment_type := TRIM(SUBSTR(lv_incr_type_ref,1,3));
                ln_increment_ref  := TO_NUMBER(SUBSTR(lv_incr_type_ref,4));
                ln_count          := ln_count + 1;
                pt_incrm_amc(ln_count).fund_value := pt_incrm_ref_fndvl(lv_incr_type_ref);
                pt_incrm_amc(ln_count).incr_typ := lv_increment_type;
                pt_incrm_amc(ln_count).incr_ref := ln_increment_ref;
                pt_incrm_amc(ln_count).amc_rate := f_increment_rate_adjustment
                                                    (pn_policy_reference => pn_policy_reference
                                                    ,pv_increment_type   => lv_increment_type
                                                    ,pn_increment_ref    => ln_increment_ref);

                lv_incr_type_ref := pt_incrm_ref_fndvl.NEXT(lv_incr_type_ref);

            END LOOP;

    END p_adviser_commission;

    -- Calculate policy level AMC
    PROCEDURE p_policy_level_amc (pr_policy_details             IN  r_policy_details
                                 ,pn_policy_fund_value          IN  NUMBER
                                 ,pt_incrm_ref_fndvl            IN  pck_asset_class_allocation.t_incrm_ref_fndvl
                                 ,pt_inrtyp_inrref_fndref_split IN  pck_asset_class_allocation.t_inrtyp_inrref_fndref_split
                                 ,pn_amc                        OUT po028.crgadjrte%TYPE)
    IS
         ln_total_policy_fund_value fi700.amt%TYPE := 0;
         ln_running_total           fi700.amt%TYPE := 0;
         lt_incrm_amc               t_incrm_amc;
         ln_eb_idx                  PLS_INTEGER;
         ln_amc                     NUMBER(5,2);
    BEGIN
        pck_process_info.p_set_action (pv_action_name => 'p_policy_level_amc');

        p_adviser_commission(pn_policy_reference => pr_policy_details.policy_reference
                            ,pt_incrm_ref_fndvl  => pt_incrm_ref_fndvl
                            ,pt_incrm_amc        => lt_incrm_amc);

        p_retrieve_increment_amc (pr_policy_details               =>  pr_policy_details
                                 ,pn_policy_fund_value            =>  pn_policy_fund_value
                                 ,pt_inrtyp_inrref_fndref_split   =>  pt_inrtyp_inrref_fndref_split
                                 ,pt_incrm_amc                    =>  lt_incrm_amc);

        ln_eb_idx := lt_incrm_amc.FIRST;

        WHILE ln_eb_idx IS NOT NULL LOOP
            ln_running_total            :=   ln_running_total + lt_incrm_amc (ln_eb_idx).fund_value *  lt_incrm_amc (ln_eb_idx).amc_rate;
            ln_total_policy_fund_value  :=   ln_total_policy_fund_value + lt_incrm_amc (ln_eb_idx).fund_value;

            ln_amc := lt_incrm_amc (ln_eb_idx).amc_rate;

            ln_eb_idx := lt_incrm_amc.NEXT(ln_eb_idx);
        END LOOP;
        -- divide the sum of the increment level amcs by the total policy fund value to get the policy amc
        pn_amc := ROUND(ln_running_total / ln_total_policy_fund_value , 2);
    END p_policy_level_amc;

    PROCEDURE p_calc_actual_growth_rate (pn_policy_reference    IN  po010.polref%TYPE
                                        ,pd_policy_commencement IN  DATE
                                        ,pd_effective_date      IN  DATE
                                        ,pn_stream              IN  PLS_INTEGER
                                        ,pn_act_growth_rate     OUT NUMBER)
    IS

        lt_value_range_fndref       t_value_range       := t_value_range();
        lt_value_range              t_value_range       := t_value_range();
        ln_effective_date_minus_1yr cs340.sysdte%TYPE   := pck_common.f_dtcnv (lpd_effective_date_minus_1yr);
        ld_last_wp_fund_movement    DATE;
        ln_sum_values               NUMBER  := 0;
        ln_last_years_fund_value    NUMBER;
        ln_current_fund_value       NUMBER;
        e_validation                EXCEPTION;
        e_calc_does_not_converge    EXCEPTION;

        PROCEDURE p_validate_values(pt_value_range IN t_value_range) IS

            ln_i        PLS_INTEGER := 0;
            lb_pos_neg  BOOLEAN     := TRUE;
            lb_pos      BOOLEAN     := FALSE;
            lb_neg      BOOLEAN     := FALSE;

        BEGIN
            pck_process_info.p_set_action (pv_action_name => 'p_validate_values');

            WHILE lb_pos_neg AND ln_i < 12 LOOP
                ln_i := ln_i + 1;

                IF pt_value_range(ln_i).fund_change > 0 THEN
                    lb_pos := TRUE;
                ELSIF lt_value_range(ln_i).fund_change < 0 THEN
                    lb_neg := TRUE;
                END IF;

                IF lb_pos AND lb_neg THEN
                    lb_pos_neg := FALSE;
                END IF;
            END LOOP;

            IF (NOT lb_pos OR NOT lb_neg) THEN
                lpt_technical_issues (pn_policy_reference) :=
                        TO_CHAR(SQLCODE) || SQLERRM || '. *** Cannot calculate growth rate: ' ||
                                                       'Need both income and contributions. ***';
                RAISE e_validation;
            END IF;

        END p_validate_values;

        FUNCTION f_calc_act_growth_rate(pn_policy_reference IN po010.polref%TYPE
                                       ,pt_value_range      IN t_value_range) RETURN NUMBER IS

            --Intermediate results for calculations defined as NUMBER to maintain precision.
            ln_running_total    NUMBER;
            ln_discounted_pos   NUMBER;
            ln_positive         NUMBER;
            ln_discounted_neg   NUMBER;
            ln_negative         NUMBER;
            ln_value            NUMBER;
            ln_temp             NUMBER;
            ln_delta            NUMBER;
            ln_act_growth_rate  NUMBER;
            ld_time             NUMBER;
            lb_calc_again       BOOLEAN              := TRUE;
            ln_j                PLS_INTEGER          := 0;
            LCN_ITERATIONS      CONSTANT PLS_INTEGER := 25; --Value agreed with calcs BA.
            LCN_ERROR           CONSTANT NUMBER      := 0.000001;

        BEGIN
            pck_process_info.p_set_action (pv_action_name => 'f_calc_act_growth_rate');

            ln_running_total := 0;

            WHILE (lb_calc_again AND ln_j < LCN_ITERATIONS) LOOP

                ln_j                := ln_j + 1;
                ln_positive         := 0;
                ln_discounted_pos   := 0;
                ln_negative         := 0;
                ln_discounted_neg   := 0;

                FOR i IN 1 .. pt_value_range.count LOOP

                    ln_value := pt_value_range(i).fund_change;
                    ld_time  := (pt_value_range(i).dd - pt_value_range(1).dd) / 365.25;

                    IF (ln_value > 0) THEN
                        ln_temp :=  ln_value * EXP(ln_running_total * ld_time);
                        ln_positive := ln_positive + ln_temp;
                        ln_discounted_pos := ln_discounted_pos + ln_temp * ld_time;
                    ELSIF (ln_value < 0) THEN
                        ln_temp :=  -1 * ln_value * EXP(ln_running_total * ld_time);
                        ln_negative := ln_negative + ln_temp;
                        ln_discounted_neg := ln_discounted_neg + ln_temp * ld_time;
                    END IF;

                END LOOP; -- i

                ln_delta := ln(ln_negative / ln_positive) /
                                ( ln_discounted_neg / ln_negative - ln_discounted_pos / ln_positive );

                IF (ABS(ln_delta) < LCN_ERROR) THEN
                    lb_calc_again := FALSE;
                END IF;

                ln_running_total := ln_running_total - ln_delta;

            END LOOP; --ln_j

            --Error handler if not possible to find solution
            IF (ln_j = LCN_ITERATIONS) THEN

                lpt_technical_issues (pn_policy_reference) := TO_CHAR(SQLCODE) || SQLERRM ||
                                                                '. *** irr does not converge in ' || TO_CHAR(LCN_ITERATIONS) || ' iterations ***';
                RAISE e_validation;

            ELSE
                ln_act_growth_rate := ln_running_total;
            END IF;

            ln_act_growth_rate := ( (EXP(-1 * ln_act_growth_rate)) - 1) * 100;
            RETURN ln_act_growth_rate;

        END f_calc_act_growth_rate;

        PROCEDURE p_fund_values(pn_policy_reference         IN  po010.polref%TYPE
                               ,pn_effective_date           IN  fi700.efvdte%TYPE
                               ,pn_effective_date_minus_1yr IN  fi700.efvdte%TYPE
                               ,pn_last_years_fund_value    OUT NUMBER
                               ,pn_current_fund_value       OUT NUMBER) IS
        BEGIN
            pck_process_info.p_set_action (pv_action_name => 'p_fund_values');

            SELECT SUM(last_year_value), SUM(current_year_value)
            INTO pn_last_years_fund_value, pn_current_fund_value
            FROM
                (
                SELECT fndmov.*,
                    ROUND((sum_last_year * TRUNC    (
                                                        (
                                                        SELECT price_last_year.fndbidprc
                                                        FROM pr060 price_last_year
                                                        WHERE price_last_year.fndref  = fndmov.fndref
                                                        AND price_last_year.fndsubtyp = fndmov.fndsubtyp
                                                        AND price_last_year.fndprcdte = pn_effective_date_minus_1yr
                                                        )
                                                    ,3) / 100),2) last_year_value,
                    ROUND((sum_current_year * TRUNC (
                                                        (
                                                        SELECT price_current_year.fndbidprc
                                                        FROM pr060 price_current_year
                                                        WHERE price_current_year.fndref = fndmov.fndref
                                                        AND   price_current_year.fndsubtyp = fndmov.fndsubtyp
                                                        AND   price_current_year.fndprcdte = pn_effective_date
                                                        )
                                                    ,3) / 100),2) current_year_value
                FROM
                    (
                    SELECT DISTINCT B.Fndref, B.fndsubtyp, SUM(last_year) sum_last_year, SUM(current_year) sum_current_year
                    FROM
                        (
                        SELECT A.Fndref, A.Fndsubtyp,
                            (CASE WHEN a.efvdte <= pn_effective_date_minus_1yr THEN A.benqty1 END) last_year,
                            (CASE WHEN a.efvdte <= pn_effective_date           THEN A.benqty1 END) current_year
                        FROM
                            (
                            SELECT *
                            FROM fi700 fi
                            WHERE  fi.staevt IN (50, 65)
                            AND    fi.inrtyp IN ('SP','TV','ORD','DSS')
                            AND    fi.polref = pn_policy_reference
                            ) A
                        ) B
                    GROUP BY B.fndref, B.fndsubtyp
                    ) fndmov
                );

        END p_fund_values;

        FUNCTION f_with_profits_growth_rate(pn_policy_reference         IN po010.polref%TYPE
                                           ,pd_policy_commencement      IN DATE
                                           ,pn_effective_date_minus_1yr IN cs340.sysdte%TYPE
                                           ,pd_last_wp_fund_movement    IN DATE
                                           ,pt_value_range              IN t_value_range) RETURN NUMBER IS

            ln_last_years_fund_value    NUMBER;
            ln_totval_ar                NUMBER;
            ln_totval_pr                NUMBER;
            ln_totvalpre                NUMBER;
            ln_totvalpst                NUMBER;
            ln_wp_switch_fund_value     NUMBER;
            ln_current_fund_value       NUMBER;
            ln_sum_values               NUMBER        := 0;
            ln_act_growth_rate_before   NUMBER;
            ln_act_growth_rate_after    NUMBER;
            ln_Date_Diff_Before         NUMBER;
            ln_Date_Diff_After          NUMBER;
            ln_act_growth_rate          NUMBER;
            lt_value_range_before       t_value_range := t_value_range();
            lt_value_range_after        t_value_range := t_value_range();

        BEGIN
            pck_process_info.p_set_action (pv_action_name => 'f_with_profits_growth_rate');

            -- This policy has been invested in WP at some point in the year = only a handful of cases.

            -- The simple fund valuation in p_fund_values doesn't work for With Profits.
            -- Instead use this procedure which wraps the same valuation code as the FNDVL Oryx screen
            wrp_fnd_val.p_calculate_fund_value(pn_polref    => pn_policy_reference
                                              ,pn_qtedte    => pn_effective_date_minus_1yr
                                              ,pv_talind    => 'N'
                                              ,pn_totvalpol => ln_last_years_fund_value
                                              ,pn_totval_ar => ln_totval_ar
                                              ,pn_totval_pr => ln_totval_pr
                                              ,pn_totvalpre => ln_totvalpre
                                              ,pn_totvalpst => ln_totvalpst);

            -- Use day following last WP fund movement
            wrp_fnd_val.p_calculate_fund_value(pn_polref    => pn_policy_reference
                                              ,pn_qtedte    => pck_utility.f_dtcnv(pd_last_wp_fund_movement) + 1
                                              ,pv_talind    => 'N'
                                              ,pn_totvalpol => ln_wp_switch_fund_value
                                              ,pn_totval_ar => ln_totval_ar
                                              ,pn_totval_pr => ln_totval_pr
                                              ,pn_totvalpre => ln_totvalpre
                                              ,pn_totvalpst => ln_totvalpst);

            wrp_fnd_val.p_calculate_fund_value(pn_polref    => pn_policy_reference
                                              ,pn_qtedte    => lpn_effective_date
                                              ,pv_talind    => 'N'
                                              ,pn_totvalpol => ln_current_fund_value
                                              ,pn_totval_ar => ln_totval_ar
                                              ,pn_totval_pr => ln_totval_pr
                                              ,pn_totvalpre => ln_totvalpre
                                              ,pn_totvalpst => ln_totvalpst);

            -- Add a value for last years fund value to top of "before" table
            lt_value_range_before.extend(1);
            lt_value_range_before(1).dd          := pck_utility.f_dtcnv(pn_effective_date_minus_1yr);
            lt_value_range_before(1).fund_change := ln_last_years_fund_value;

            --Split lt_value_range into 2 collections.
            FOR i IN 1 .. pt_value_range.count LOOP

                --Before the last date policy invested in WP.
                IF pt_value_range(i).dd <= pd_last_wp_fund_movement THEN
                    lt_value_range_before.extend(1);
                    lt_value_range_before(lt_value_range_before.last).dd := pt_value_range(i).dd;
                    lt_value_range_before(lt_value_range_before.last).fund_change := pt_value_range(i).fund_change;
                END IF;

                --After the last date policy invested in WP.
                IF pt_value_range(i).dd >= pd_last_wp_fund_movement THEN
                    lt_value_range_after.extend(1);
                    lt_value_range_after(lt_value_range_after.last).dd := pt_value_range(i).dd;
                    lt_value_range_after(lt_value_range_after.last).fund_change := pt_value_range(i).fund_change;
                END IF;

            END LOOP;

            IF lt_value_range_after(1).dd != pd_policy_commencement THEN

                -- There will be no fund movements if the policy hasn't commenced yet.

                lt_value_range_after(1).dd          := pd_last_wp_fund_movement;
                lt_value_range_after(1).fund_change := ln_wp_switch_fund_value;

                --Growth rate on last day invested in WP.
                lt_value_range_before(lt_value_range_before.last).fund_change := -1 * ln_wp_switch_fund_value;

                -- Before WP ends Growth rate.
                FOR i IN 1 .. lt_value_range_before.count LOOP
                    ln_sum_values := ln_sum_values + lt_value_range_before(i).fund_change;
                END LOOP;

                IF (ln_sum_values = ln_last_years_fund_value - ln_wp_switch_fund_value ) THEN

                    -- Simple formula when no intermediate cashflows
                    ln_act_growth_rate_before := (ln_wp_switch_fund_value - ln_last_years_fund_value) /
                                                  ln_last_years_fund_value;
                ELSE

                    ln_act_growth_rate_before := f_calc_act_growth_rate(pn_policy_reference => pn_policy_reference
                                                                       ,pt_value_range      => lt_value_range_before);
                END IF;

            END IF;

            lt_value_range_after(lt_value_range_after.last).fund_change := -1 * ln_current_fund_value;

            -- After WP ends Growth Rate.
            FOR i IN 1 .. lt_value_range_after.count LOOP
                ln_sum_values := ln_sum_values + lt_value_range_after(i).fund_change;
            END LOOP;

            IF (ln_sum_values = ln_wp_switch_fund_value - ln_current_fund_value ) THEN

                -- Simple formula when no intermediate cashflows
                ln_act_growth_rate_after := (ln_current_fund_value - ln_wp_switch_fund_value) /
                                            ln_wp_switch_fund_value;
            ELSE
                ln_act_growth_rate_after := f_calc_act_growth_rate(pn_policy_reference => pn_policy_reference
                                                                  ,pt_value_range      => lt_value_range_after);
            END IF;

            ln_Date_Diff_Before := (pd_last_wp_fund_movement - pck_utility.f_dtcnv(pn_effective_date_minus_1yr) )/365.25 ;
            ln_Date_Diff_After  := (pck_utility.f_dtcnv(lpn_effective_date) - pd_last_wp_fund_movement) /356.25;

            ln_act_growth_rate := (NVL(ln_act_growth_rate_before,0) * ln_Date_Diff_Before) + (ln_act_growth_rate_after * ln_Date_Diff_After );

            RETURN ln_act_growth_rate;

        END f_with_profits_growth_rate;

    BEGIN
        pck_process_info.p_set_action (pv_action_name => 'p_calc_actual_growth_rate');

        IF (pd_policy_commencement <= lpd_effective_date_minus_1yr) THEN

            OPEN  lpcu_actual_fund_value(pcn_policy_reference         => pn_policy_reference
                                        ,pcn_effective_date           => lpn_effective_date
                                        ,pcn_effective_date_minus_1yr => ln_effective_date_minus_1yr);

            FETCH lpcu_actual_fund_value BULK COLLECT INTO lt_value_range_fndref;
            CLOSE lpcu_actual_fund_value;

            -- Compress lt_value_range_fndref to remove the fndref values.
            -- Store a fund movement per date in lt_value_range.
            -- This avoids a call to FI700 to get the date policies move out of With Profits.
            FOR i IN 1 .. lt_value_range_fndref.count LOOP
                IF (i = 1 OR lt_value_range_fndref(i).dd != lt_value_range_fndref(i-1).dd) THEN
                    IF (i = 1 OR i = lt_value_range_fndref.last OR lt_value_range_fndref(i).fund_change != 0) THEN
                        lt_value_range.extend(1);
                        lt_value_range(lt_value_range.last).dd := lt_value_range_fndref(i).dd;
                        lt_value_range(lt_value_range.last).fund_change := lt_value_range_fndref(i).fund_change;
                    END IF;
                END IF;
                IF lt_value_range_fndref(i).fndref IN (320, 340, 360, 400, 410) THEN
                    ld_last_wp_fund_movement := lt_value_range_fndref(i).dd;
                END IF;
            END LOOP;

            IF ld_last_wp_fund_movement IS NULL THEN
                -- This policy wasn't invested in WP in the last year = the vast majority of cases.

                p_fund_values(pn_policy_reference         => pn_policy_reference
                             ,pn_effective_date           => lpn_effective_date
                             ,pn_effective_date_minus_1yr => ln_effective_date_minus_1yr
                             ,pn_last_years_fund_value    => ln_last_years_fund_value
                             ,pn_current_fund_value       => ln_current_fund_value);

                lt_value_range(1).fund_change
                                    := lt_value_range(1).fund_change + nvl(ln_last_years_fund_value,0);

                lt_value_range(lt_value_range.last).fund_change
                                    := -1 * (lt_value_range(lt_value_range.last).fund_change + ln_current_fund_value);

                FOR i IN 1 .. lt_value_range.count LOOP
                    ln_sum_values := ln_sum_values + lt_value_range(i).fund_change;
                END LOOP;

                -- Simple formula when no intermediate cashflows
                IF (ln_sum_values = ln_last_years_fund_value - ln_current_fund_value ) THEN

                    pn_act_growth_rate := (ln_current_fund_value - ln_last_years_fund_value) /
                                                ln_last_years_fund_value;

                ELSE

                    pn_act_growth_rate := f_calc_act_growth_rate(pn_policy_reference => pn_policy_reference
                                                                ,pt_value_range      => lt_value_range);

                END IF;

            ELSE

                pn_act_growth_rate := f_with_profits_growth_rate(pn_policy_reference         => pn_policy_reference
                                                                ,pd_policy_commencement      => pd_policy_commencement
                                                                ,pn_effective_date_minus_1yr => ln_effective_date_minus_1yr
                                                                ,pd_last_wp_fund_movement    => ld_last_wp_fund_movement
                                                                ,pt_value_range              => lt_value_range);

            END IF;

        END IF; --Commencement Date Check

    EXCEPTION
        WHEN e_validation THEN

             p_write_to_error_table(pn_policy_reference  => pn_policy_reference
                                  ,pv_error_details     => lpt_technical_issues (pn_policy_reference)
                                  ,pd_effective_date    => pd_effective_date
                                  ,pn_stream            => pn_stream);

        WHEN OTHERS THEN

             p_write_to_error_table(pn_policy_reference  => pn_policy_reference
                                  ,pv_error_details     => 'Error in actual growth rate calculation ' || ', ' ||
                                                           SQLERRM || ', ' ||
                                                           pck_process_info.f_action
                                  ,pd_effective_date    => pd_effective_date
                                  ,pn_stream            => pn_stream);

    END p_calc_actual_growth_rate;

    FUNCTION f_get_governed_portfolio_types RETURN pck_asset_class_allocation.t_governed_portfolio_types
    IS
        lt_governed_portfolio_types pck_asset_class_allocation.t_governed_portfolio_types;
    BEGIN
        pck_process_info.p_set_action (pv_action_name => 'p_get_governed_portfolio_types');

        FOR idx IN (SELECT sty.description
                          ,st.strategy_reference
                    FROM   strategies      st
                          ,strategy_types  sty
                    WHERE  st.strategy_type      = sty.strategy_type
                    AND    st.status             = 30) LOOP
            lt_governed_portfolio_types (idx.strategy_reference) := idx.description;
        END LOOP;

        RETURN lt_governed_portfolio_types;

    END f_get_governed_portfolio_types;

    -- Procedure to retreive investments / fund split for a policy
    PROCEDURE p_retrieve_policy_investments (pn_policy_reference         IN  po010.polref%TYPE
                                            ,pn_effective_date           IN  cs340.sysdte%TYPE
                                            ,pt_governed_portfolio_types IN  pck_asset_class_allocation.t_governed_portfolio_types
                                            ,pt_strategy_desc            IN  pck_asset_class_allocation.t_strategy_desc
                                            ,pr_investment_details       OUT pck_asset_class_allocation.r_investment_details)
    IS
        ln_ris_pct                    co050.fndctlpct%TYPE;
        lv_ms_id                      pr310.fnd_id%TYPE;
        ln_ms_pct                     co050.fndctlpct%TYPE;
        lb_strategy_found             BOOLEAN;
        ln_total_fund_split           co050.fndctlpct%TYPE := 0;
        lv_increment_type             VARCHAR2(10);
        lv_strategy_type              strategy_list.strategy_type%TYPE;
        lv_is_investment_pathway      VARCHAR2(1) := 'N';
        lv_ip_strategy_type           VARCHAR2(2) := 'IP';

    BEGIN
        pck_process_info.p_set_action (pv_action_name => 'p_retrieve_policy_investments');

        pck_investments.p_strategy_policy_or_scheme  (pn_policy_ref     => pn_policy_reference
                                                     ,pn_system_DTE     => pn_effective_date
                                                     ,pb_scheme_level   => FALSE
                                                     ,pv_scheme_cat     => NULL
                                                     ,pn_scheme_ref     => NULL
                                                     ,pn_scheme_sub_cat => NULL
                                                     ,pn_strategy_id    => pr_investment_details.strategy_id
                                                     ,pv_RIS_id         => pr_investment_details.ris_id
                                                     ,pn_RIS_ref        => pr_investment_details.ris_ref
                                                     ,pn_RIS_pct        => ln_ris_pct
                                                     ,pv_ms_id          => lv_ms_id
                                                     ,pn_ms_ref         => pr_investment_details.ms_ref
                                                     ,pn_ms_pct         => ln_ms_pct
                                                     ,pb_strategy_found => lb_strategy_found);

        IF lb_strategy_found THEN
            CASE
                WHEN pr_investment_details.strategy_id IS NOT NULL THEN

                    pck_funds.p_strategy_type(pn_strategy_id    => pr_investment_details.strategy_id
                                             ,pv_strategy_type  => lv_strategy_type
                                             ,pv_is_inv_pathway => lv_is_investment_pathway);

                    IF NVL(lv_is_investment_pathway, 'N') = 'Y' THEN
                        pr_investment_details.investment_type := pt_strategy_desc (lv_ip_strategy_type);
                    ELSE
                        pr_investment_details.investment_type := pt_strategy_desc (lv_strategy_type);
                    END IF;

                    -- Custom Portfolio
                    IF lv_strategy_type IN ('P', 'G') THEN

                        pck_rs_nipp_existing_business.p_get_strategy_name
                                                             (pn_strategy_id   => pr_investment_details.strategy_id
                                                             ,pv_strategy_name => pr_investment_details.portfolio_name);

                    -- Flexible Lifestyle Strategy
                    ELSIF lv_strategy_type IN ('L', 'M', 'C') THEN

                         -- Get the strategy name.
                         pck_rs_nipp_existing_business.p_get_strategy_name
                                                                 (pn_strategy_id   => pr_investment_details.strategy_id
                                                                 ,pv_strategy_name => pr_investment_details.strategy_name);
                    END IF;

                WHEN pr_investment_details.ris_id IS NOT NULL THEN

                    pr_investment_details.investment_type := 'OLD RETIREMENT INVESTMENT STRATEGY';
                    pr_investment_details.strategy_name   := pck_investments.f_fund_name (pn_fund_ref => pr_investment_details.ris_ref);

                WHEN pr_investment_details.ms_ref IS NOT NULL THEN

                    pr_investment_details.investment_type := pt_governed_portfolio_types (pr_investment_details.ms_ref);
                    pr_investment_details.portfolio_name  := pck_investments.f_fund_name (pn_fund_ref => pr_investment_details.ms_ref);
                END CASE;
        ELSE
            pr_investment_details.investment_type := 'FUND RANGE';
        END IF;

        pr_investment_details.investment_type := UPPER(pr_investment_details.investment_type);
        pr_investment_details.portfolio_name  := UPPER(pr_investment_details.portfolio_name);
        pr_investment_details.strategy_name   := UPPER(pr_investment_details.strategy_name);

        FOR ir_idx IN  lpcu_fund_split (pcn_policy_reference => pn_policy_reference
                                       ,pcn_effective_date   => pn_effective_date) LOOP
            -- Increment fund values
            CASE
                WHEN ir_idx.inrtyp = 'ORD' THEN
                    pr_investment_details.rp_fund_value :=  ir_idx.fndval_incrm_type;

                WHEN ir_idx.inrtyp = 'SP' THEN
                    pr_investment_details.sp_fund_value :=  ir_idx.fndval_incrm_type;

                WHEN ir_idx.inrtyp = 'TV' THEN
                    pr_investment_details.tv_fund_value :=  ir_idx.fndval_incrm_type;

                WHEN ir_idx.inrtyp = 'DSS' THEN
                    pr_investment_details.dss_fund_value := ir_idx.fndval_incrm_type;
            END CASE;

            lv_increment_type := LPAD(ir_idx.inrtyp, 3, ' ') || TO_CHAR(ir_idx.inrref);

            -- fund split at increment type / increment ref level
            IF NOT pr_investment_details.increment_ref_fndvl.EXISTS(lv_increment_type) THEN
                pr_investment_details.increment_ref_fndvl (lv_increment_type) :=  ir_idx.fndval_incrm_ref;
            END IF;

            -- Policy fund split
            IF NOT  pr_investment_details.fund_split.EXISTS(ir_idx.fndref) AND
                    ir_idx.fund_split > 0                                  THEN
                pr_investment_details.fund_split(ir_idx.fndref).fund_code  :=  ir_idx.fnd_id;
                pr_investment_details.fund_split(ir_idx.fndref).fund_name  :=  ir_idx.fndnam;
                pr_investment_details.fund_split(ir_idx.fndref).fund_split :=  ir_idx.fund_split;

                ln_total_fund_split :=  ln_total_fund_split + ir_idx.fund_split;

                -- Adjust split for fund with highest fund value
                IF ir_idx.fund_split_rank = ir_idx.max_rank THEN
                    pr_investment_details.fund_split(ir_idx.fndref).fund_split :=
                            100 - ln_total_fund_split + pr_investment_details.fund_split(ir_idx.fndref).fund_split;
                END IF;
            END IF;

            -- Fund split at Increment type / increment ref / fund ref level
            IF ((NOT pr_investment_details.inrtyp_inrref_fndref_split.EXISTS(ir_idx.inrtyp))                  OR
               (NOT  pr_investment_details.inrtyp_inrref_fndref_split(ir_idx.inrtyp).EXISTS(ir_idx.inrref))   OR
               (NOT  pr_investment_details.inrtyp_inrref_fndref_split(ir_idx.inrtyp)(ir_idx.inrref).EXISTS(ir_idx.fndref))) AND
               ir_idx.incrm_ref_fund_split > 0   THEN

                 pr_investment_details.inrtyp_inrref_fndref_split(ir_idx.inrtyp)(ir_idx.inrref)(ir_idx.fndref).split
                                                                      := ir_idx.incrm_ref_fund_split;

                 pr_investment_details.inrtyp_inrref_fndref_split(ir_idx.inrtyp)(ir_idx.inrref)(ir_idx.fndref).fmc
                                                                      := ir_idx.mgmfeepct;

            END IF;

            pr_investment_details.policy_fund_value := ir_idx.fndval_policy_level;
        END LOOP;

        IF  pr_investment_details.investment_type != 'FUND RANGE' THEN
            pr_investment_details.fund_split.DELETE;
        END IF;
    END p_retrieve_policy_investments;

    FUNCTION f_policy_level_growth_rate (pt_policy_rates IN t_quote_growth_rates_doc)
    RETURN quote_growth_rates_doc.mid_growth%TYPE
    IS
        ln_mid_inflation_growth_rate pr190.tblval1%TYPE;
        ln_mid_growth                quote_growth_rates_doc.mid_growth%TYPE;
    BEGIN
        pck_process_info.p_set_action (pv_action_name => 'f_policy_level_growth_rate');

        ln_mid_inflation_growth_rate := pck_inflation_adjustments.f_get_inflation_rate
                                              (pv_growth_type => 'MID');

        FOR i IN 1 .. pt_policy_rates.count LOOP
            IF pt_policy_rates(i).projection_id      = 0    AND
               pt_policy_rates(i).doc_increment_type = 'P'  AND
               pt_policy_rates(i).rights_type        = ' ' THEN

                ln_mid_growth := ((1 + pt_policy_rates(i).mid_growth) * (1 + ln_mid_inflation_growth_rate)) -1;

            END IF;
        END LOOP;

        RETURN ln_mid_growth;

    END f_policy_level_growth_rate;

    FUNCTION f_ongoing_charges(pn_policy_reference IN po010.polref%TYPE)
    RETURN NUMBER
    IS
        ln_ongoing_charges NUMBER(10,2);

        CURSOR cu_ongoing_charges(pcn_policy_reference   IN     po010.polref%TYPE
                                 ,pcd_effective_date     IN     DATE)
        IS
        WITH funds_info AS (SELECT  fndmov.polref       polref
                                   ,SUM(fndmov.benqty1) ben
                                   ,fndmov.fndref fndref
                                   ,fndmov.rhttyp rhttyp
                                   ,fndmov.inrtyp inrtyp
                                   ,fndmov.inrref inrref
                                   ,TRUNC(price.fndbidprc / 100, 3) price
                            FROM fi700 fndmov
                            JOIN pr060 price ON  price.fndref    = fndmov.fndref
                                             AND price.fndsubtyp = fndmov.fndsubtyp
                                             AND price.fndprcdte = pcd_effective_date - to_date('01/01/1900','dd/mm/yyyy')
                            WHERE fndmov.staevt IN (50, 65)
                            AND fndmov.inrtyp IN ('SP','TV','ORD','DSS')
                            AND fndmov.efvdte <= (pcd_effective_date - to_date('01/01/1900','dd/mm/yyyy')) - 1
                            AND fndmov.polref = pcn_policy_reference
                            GROUP  BY fndmov.polref
                                     ,fndmov.fndref
                                     ,fndmov.rhttyp
                                     ,fndmov.inrtyp
                                     ,fndmov.inrref
                                     ,price.fndbidprc)
         --Level 2 - fund_value
        ,fund_value AS (SELECT fi.polref
                              ,fi.inrtyp
                              ,fi.inrref
                              ,fi.fndref
                              ,ABS(ROUND(fi.price * fi.ben, 2)) fnd_val
                        FROM funds_info fi)

        -- Increment type / ref level fund values
        ,increment_level_fndvl AS
           (SELECT  polref
                   ,inrtyp
                   ,inrref
                   ,fndval_inrtyp_ref
                   ,fndval_policy_level
             FROM  (SELECT  f.polref
                           ,f.inrtyp
                           ,f.inrref
                           ,SUM (f.fnd_val) OVER (PARTITION BY f.polref, f.inrtyp,  f.inrref)             fndval_inrtyp_ref
                           ,SUM (f.fnd_val) OVER (PARTITION BY f.polref)                                  fndval_policy_level
                           ,ROW_NUMBER() OVER (PARTITION BY  f.polref, f.inrtyp,  f.inrref ORDER BY NULL) rank_increment_values
                    FROM    fund_value f)
            WHERE rank_increment_values = 1
            AND   fndval_inrtyp_ref > 0)

      -- Ongoing Charge records
      ,charge_records AS
          (SELECT  polref
                  ,increment_type
                  ,increment_reference
                  ,charge_subtype
                  ,charge_method
                  ,annual_charge
                  ,charge_percentage
          FROM
              (SELECT cd.polref
                     ,cid.increment_type
                     ,cid.increment_reference
                     ,cd.charge_subtype
                     ,cd.charge_method
                     ,cid.charge_amount * (CASE WHEN g.occpyr != 0 THEN g.occpyr ELSE 1 END)  annual_charge
                     ,cid.charge_percentage
                     ,ROW_NUMBER() OVER (PARTITION BY cd.polref, cid.increment_type, cid.increment_reference, cd.charge_method ORDER BY cid.start_date DESC) rankac

              FROM  charge_details cd
              JOIN  charge_increment_dates cid ON  cd.charge_id = cid.charge_id
                                               AND cid.status IN (30, 50)
              LEFT OUTER JOIN ge070 g ON g.frq = cd.frequency
              WHERE pcd_effective_date <= NVL(cid.end_date, pcd_effective_date)
              AND   cd.charge_type      = 'AC'
              AND   cd.charge_subtype   = 'ONG'
              AND   cd.polref           = pcn_policy_reference
              AND   NOT(MONTHS_BETWEEN(cid.end_date, cid.start_date) = 0 AND cid.status = 50)
              AND   (cd.duration IS NULL
                 OR  NVL(cid.end_date,TO_DATE('01/01/2999','dd/mm/yyyy')) > ADD_MONTHS(pcd_effective_date, lpn_extract_charge_period) - 1
                    )
              AND   charge_method != 'ASA')
          WHERE rankac = 1)
        SELECT  ROUND(ROUND(SUM(running_total) OVER (PARTITION BY polref), 2) / fndval_policy_level, 2) policy_level_charge
        FROM
           (SELECT  ilf.polref
                   ,ilf.fndval_policy_level
                   ,CASE WHEN NVL(cr.charge_method, 'XXX') = 'FND' THEN ilf.fndval_inrtyp_ref  * NVL(cr.charge_percentage, 0)
                         WHEN NVL(cr.charge_method, 'XXX') = 'FIX' THEN NVL(cr.annual_charge, 0) * 100
                         ELSE 0 END running_total
            FROM  increment_level_fndvl  ilf
            LEFT OUTER JOIN charge_records cr ON ilf.polref = cr.polref
                                             AND ilf.inrtyp = cr.increment_type
                                             AND ilf.inrref = cr.increment_reference)
        WHERE polref = pcn_policy_reference;


    BEGIN

        OPEN cu_ongoing_charges(pcn_policy_reference => pn_policy_reference
                               ,pcd_effective_date   => lpd_effective_date);
        FETCH cu_ongoing_charges INTO ln_ongoing_charges;
        CLOSE cu_ongoing_charges;

        RETURN ln_ongoing_charges;

    END f_ongoing_charges;

    PROCEDURE p_drawdown_gov_service(pn_policy_reference   IN  po010.polref%TYPE
                                    ,pv_review_in_service  OUT drawdown_governance.service_opted%TYPE
                                    ,pn_target_age         OUT drawdown_governance.target_age%TYPE
                                    ,pv_target_type        OUT drawdown_gov_income_targets.target_description%TYPE)
    IS

        lr_drawdown_governance drawdown_governance%ROWTYPE;
        lv_target_type drawdown_governance.income_target%TYPE;

    BEGIN
        lr_drawdown_governance := pck_drawdown_gov_service.f_get_income_target
                                                          (pn_policy_reference => pn_policy_reference);

        pv_review_in_service := lr_drawdown_governance.service_opted;
        pn_target_age        := lr_drawdown_governance.target_age;
        lv_target_type       := lr_drawdown_governance.income_target;

        IF  lv_target_type = 'A' THEN
            pv_target_type := 'INCOME TO AGE';
        ELSIF  lv_target_type IS NOT NULL THEN
            pv_target_type       := UPPER(pck_drawdown_gov_service.f_get_target_type(lv_target_type));
        END IF;

    END p_drawdown_gov_service;

    PROCEDURE p_policy_calculation_inputs(pn_policy_reference   IN     po010.polref%TYPE
                                         ,pr_policy_details     IN     r_policy_details
                                         ,pr_investment_details IN     pck_asset_class_allocation.r_investment_details
                                         ,pn_inflation_date     IN     NUMBER
                                         ,pd_effective_date     IN     DATE
                                         ,pn_stream             IN     PLS_INTEGER
                                         ,pr_calcs_inputs       IN OUT r_calcs_inputs
                                         ) IS

        ln_months_from_commence     NUMBER;
        ln_regular_total            NUMBER := 0;
        ln_regular_total_last_year  NUMBER := 0;
        ln_adhoc_total_last_quarter NUMBER := 0;
        ln_adhoc_total_last_year    NUMBER := 0;
        ln_id_amt_total             NUMBER := 0;
        ln_tfc_amt_total            NUMBER := 0;
        ln_dtf_amt_total            NUMBER := 0;

    BEGIN
        pck_process_info.p_set_action (pv_action_name => 'p_policy_calculation_inputs');

       ln_months_from_commence := MONTHS_BETWEEN (lpd_effective_date, pr_policy_details.commencement_date);

       p_calc_actual_growth_rate (pn_policy_reference    => pn_policy_reference
                                 ,pd_policy_commencement => pr_policy_details.commencement_date
                                 ,pn_act_growth_rate     => pr_calcs_inputs.actual_growth_rate
                                 ,pd_effective_date      => pd_effective_date
                                 ,pn_stream              => pn_stream);

        IF  pr_calcs_inputs.actual_growth_rate IS NULL THEN
             pr_calcs_inputs.short_term_outlook := ' ';
        ELSIF pr_calcs_inputs.actual_growth_rate < pn_inflation_date THEN
            pr_calcs_inputs.short_term_outlook := 'N';
        ELSE
            pr_calcs_inputs.short_term_outlook := 'Y';
        END IF;

        pr_calcs_inputs.transfer_in_drawdown_ind := pck_income_release_queries.f_transfer_in_drawdown
                                                               (pn_policy_reference => pn_policy_reference);

        pck_income_release_queries.p_check_ir_switch_on
                                       (pn_policy_reference     => pn_policy_reference
                                       ,pv_ir_switched_on_flag  => pr_calcs_inputs.ir_switch_on_ind);

        p_tfc_income_out (pn_policy_reference => pn_policy_reference
                         ,pn_number_of_months => (ln_months_from_commence + 1)
                         ,pn_id_amt_total     => ln_id_amt_total
                         ,pn_tfc_amt_total    => ln_tfc_amt_total
                         ,pn_dtf_amt_total    => ln_dtf_amt_total);

        pr_calcs_inputs.total_pcls_amount := ln_tfc_amt_total + ln_dtf_amt_total; --PCLS_AMOUNT
        pr_calcs_inputs.total_income_amount := ln_id_amt_total;                   --TOTAL_INCOME_PAID

        p_income_paid (pn_policy_reference  => pn_policy_reference
                      ,pn_number_of_months  => lpn_extract_period
                      ,pn_regular_total     => ln_regular_total
                      ,pn_adhoc_total       => ln_adhoc_total_last_quarter);

        pr_calcs_inputs.adhoc_income_last_quarter := ln_adhoc_total_last_quarter;

        p_income_paid (pn_policy_reference  => pn_policy_reference
                      ,pn_number_of_months  => 12
                      ,pn_regular_total     => ln_regular_total_last_year
                      ,pn_adhoc_total       => ln_adhoc_total_last_year);

        pr_calcs_inputs.adhoc_income_last_year := ln_adhoc_total_last_year;
        pr_calcs_inputs.income_amount_annual := ln_regular_total_last_year; --ACTUAL_GROSS_INCOME = Regular payments only, no adhoc.

        pr_calcs_inputs.actual_conts_last_quarter := f_contributions_paid
                                                       (pn_policy_reference  => pn_policy_reference
                                                       ,pn_number_of_months  => lpn_extract_period);

        pr_calcs_inputs.actual_conts_last_year := f_contributions_paid
                                                       (pn_policy_reference  => pn_policy_reference
                                                       ,pn_number_of_months  => 12);

        pr_calcs_inputs.rp_esc_rate := 0;

        p_retrieve_future_rps (pn_policy_reference   => pn_policy_reference
                              ,pn_expected_amount_yr => pr_calcs_inputs.expected_rp_amount_yr
                              ,pn_expected_amount    => pr_calcs_inputs.expected_rp_amount
                              ,pv_expected_frequency => pr_calcs_inputs.expected_rp_frequency
                              ,pv_rp_indicator       => pr_calcs_inputs.rp_indicator);

        IF pr_calcs_inputs.rp_indicator = 'Y' THEN
            p_get_escalation_rate (pn_policy_ref       => pn_policy_reference
                                  ,pn_escalation_rate  => pr_calcs_inputs.rp_esc_rate);
        END IF;

        pr_calcs_inputs.policy_adviser_charge := f_ongoing_charges(pn_policy_reference => pn_policy_reference);

        p_policy_level_amc (pr_policy_details               => pr_policy_details
                           ,pn_policy_fund_value            => pr_investment_details.policy_fund_value
                           ,pt_incrm_ref_fndvl              => pr_investment_details.increment_ref_fndvl
                           ,pt_inrtyp_inrref_fndref_split   => pr_investment_details.inrtyp_inrref_fndref_split
                           ,pn_amc                          => pr_calcs_inputs.policy_amc);

        pr_calcs_inputs.target           := NVL(pr_calcs_inputs.target,LPCV_TARGET);
        pr_calcs_inputs.target_age       := NVL(pr_calcs_inputs.target_age,pr_policy_details.retirement_age);
        pr_calcs_inputs.contract_version := pr_policy_details.product_version;

    END p_policy_calculation_inputs;

    PROCEDURE p_quote_calculation_inputs(pn_policy_reference IN     po010.polref%TYPE
                                        ,pr_policy_details   IN     r_policy_details
                                        ,pr_calcs_inputs     IN OUT r_calcs_inputs)
    IS

        lr_common_inputs            pck_calcs_definitions_nipp.r_common_inputs;
        lr_annuity_inputs           pck_calcs_definitions.r_annuity_inputs;
        lr_sp_inputs                pck_calcs_definitions_nipp.r_sp_inputs;
        lr_tv_inputs                pck_calcs_definitions_nipp.r_tv_inputs;
        lr_ir_inputs                pck_calcs_definitions_nipp.r_ir_inputs;
        lt_eb_inputs                pck_calcs_definitions_nipp.t_eb_inputs;
        lt_frp_inputs               pck_calcs_definitions_nipp.t_frp_inputs;
        lt_dg_growth_rates_comp     t_quote_growth_rates_comp;
        ln_term                     po030.trmmth%TYPE;
        lt_policy_rates             t_quote_growth_rates_doc;

    BEGIN
        pck_process_info.p_set_action (pv_action_name => 'p_quote_calculation_inputs_new');

        pck_calcs_existing_biz.p_derive_inputs
                     (pn_policy_ref                => pn_policy_reference
                     ,pd_quote_date                => lpd_effective_date
                     ,pd_system_date               => lpd_system_date
                     ,pb_increment_only            => FALSE
                     ,pd_retirement_date           => pr_policy_details.retirement_date
                     ,pv_charge_maint_projection   => NULL
                     ,pr_common_inputs             => lr_common_inputs
                     ,pr_annuity_inputs            => lr_annuity_inputs
                     ,pr_sp_inputs                 => lr_sp_inputs
                     ,pr_tv_inputs                 => lr_tv_inputs
                     ,pr_ir_inputs                 => lr_ir_inputs
                     ,pt_eb_inputs                 => lt_eb_inputs
                     ,pt_frp_inputs                => lt_frp_inputs
                     ,pt_dg_growth_rates_comp      => lt_dg_growth_rates_comp
                     ,pn_term                      => ln_term
                     ,pt_policy_rates              => lt_policy_rates);

        pr_calcs_inputs.expected_growth_rate := ROUND(f_policy_level_growth_rate
                                                               (pt_policy_rates => lt_policy_rates) * 100, 1);

    END p_quote_calculation_inputs;

    -- Procedure for initial setup
    PROCEDURE p_initial_setup (pd_effective_date         IN DATE)
    IS
    BEGIN
        pck_process_info.p_set_action (pv_action_name => 'p_initial_setup');

        lpd_effective_date  :=  pd_effective_date;
        lpn_effective_date  :=  pck_utility.f_dtcnv (lpd_effective_date);
        lpd_effective_date_minus_1yr := ADD_MONTHS(pd_effective_date, -12);

        -- Delete Technical errors log
        lpt_technical_issues.DELETE;
    END p_initial_setup;

    -- Procedure to check review service switch
    PROCEDURE p_review_service_switch (pb_technical_issue         IN  BOOLEAN
                                      ,pv_income_flag             IN  VARCHAR2
                                      ,pb_healthchecks_failed     IN  BOOLEAN
                                      ,pn_stapol                  IN  po010.stapol%TYPE
                                      ,pv_exit_mode               IN  VARCHAR2
                                      ,pv_default_rev_serv_switch IN  VARCHAR2
                                      ,pv_review_service_switch   OUT VARCHAR2
                                      ,pv_reason_for_exclusion    OUT VARCHAR2
                                      ,pb_moodys_file_required    OUT BOOLEAN )
    IS
        lb_moodys_file_required BOOLEAN := TRUE;
    BEGIN
        pck_process_info.p_set_action (pv_action_name => 'p_review_service_switch');

            -- set the flag to whatever has been entered on eservice or drawdown gov service.
            -- If nothing is entered, default to N.
        pv_review_service_switch := NVL(pv_default_rev_serv_switch,'N');

        IF pb_healthchecks_failed OR
           pb_technical_issue     OR
           pn_stapol = 61         OR
           pv_income_flag = 'N'   THEN

            lb_moodys_file_required := FALSE;
        END IF;

        pb_moodys_file_required := lb_moodys_file_required;

        -- Validation
        IF pb_healthchecks_failed            OR
           pb_technical_issue                OR
           pv_default_rev_serv_switch = 'N'  OR
           pn_stapol = 61                    THEN

           IF pb_technical_issue THEN
               pv_reason_for_exclusion := pv_reason_for_exclusion || 'TECHNICAL ISSUE'    || LPCV_DELIMITER;

           ELSIF pb_healthchecks_failed THEN
               pv_reason_for_exclusion := pv_reason_for_exclusion || 'HEALTHCHECKS FAILED'    || LPCV_DELIMITER;

           ELSIF pv_default_rev_serv_switch = 'N' THEN
               pv_reason_for_exclusion := pv_reason_for_exclusion || 'ADVISER EXCLUDED'    || LPCV_DELIMITER;

           ELSIF pn_stapol = 61     THEN
              IF pv_exit_mode != 'DEATH' THEN
                  pv_reason_for_exclusion := pv_reason_for_exclusion || 'PLAN EXIT'       || LPCV_DELIMITER;
              ELSE
                  pv_reason_for_exclusion := pv_reason_for_exclusion || 'CLIENT DECEASED' || LPCV_DELIMITER;
              END IF;
           END IF;

           pv_reason_for_exclusion := RTRIM(pv_reason_for_exclusion, LPCV_DELIMITER);
        END IF;

    END p_review_service_switch;

    -- Procedure to generate extract for Individual policy
    PROCEDURE p_generate_policy_extract (pn_policy_reference         IN po010.polref%TYPE
                                        ,pn_policy_index             IN PLS_INTEGER DEFAULT 1
                                        ,pd_effective_date           IN DATE
                                        ,pn_stream                   IN PLS_INTEGER
                                        ,pn_inflation_date           IN NUMBER
                                        ,pv_run_healthchecks         IN VARCHAR2
                                        ,pt_governed_portfolio_types IN pck_asset_class_allocation.t_governed_portfolio_types
                                        ,pt_asset_class_split        IN pck_asset_class_allocation.t_asset_class_split
                                        ,pt_strategy_desc            IN pck_asset_class_allocation.t_strategy_desc)
    IS
        lb_healthchecks_found        BOOLEAN := FALSE;
        lb_error_found               BOOLEAN := FALSE;
        lb_moodys_file_required      BOOLEAN := TRUE;
        lr_client_details            r_client_details;
        lr_policy_details            r_policy_details;
        lr_investment_details        pck_asset_class_allocation.r_investment_details;
        lr_calcs_inputs              r_calcs_inputs;
        CLIENT_AGE_EQUALS_TARGET_AGE EXCEPTION;
    BEGIN
        pck_process_info.p_register_module (pv_module_name =>  LPCV_PACKAGE_NAME
                                           ,pv_action_name =>  'p_generate_policy_extract');

        -- Clear Global Arrays
        pck_projection_process.p_cleanup;

        p_retrieve_client_details (pn_policy_reference  =>  pn_policy_reference
                                  ,pd_effective_date    =>  lpd_effective_date
                                  ,pr_client_details    =>  lr_client_details);

        p_retrieve_policy_details (pn_policy_reference  =>  pn_policy_reference
                                  ,pn_policy_index      =>  pn_policy_index
                                  ,pr_client_details    =>  lr_client_details
                                  ,pr_policy_details    =>  lr_policy_details);

        IF pv_run_healthchecks = 'Y' THEN
            -- Call Healthchecks to check if policy has any issues
            pck_health_check_wrapper.p_call_health_check (pn_process_id         =>  LPCN_DGS_HEALTHCHECK
                                                         ,pn_policy_number      =>  pn_policy_reference
                                                         ,pn_start_date         =>  lpn_effective_date
                                                         ,pn_end_date           =>  lpn_effective_date
                                                         ,pb_health_check_found =>  lb_healthchecks_found
                                                         ,pb_error_found        =>  lb_error_found);
        END IF;

        BEGIN

            p_drawdown_gov_service(pn_policy_reference     => pn_policy_reference
                                  ,pv_review_in_service    => lr_calcs_inputs.default_rev_serv_switch
                                  ,pn_target_age           => lr_calcs_inputs.target_age
                                  ,pv_target_type          => lr_calcs_inputs.target);

            IF (lr_client_details.age >= lr_calcs_inputs.target_age) THEN
                RAISE CLIENT_AGE_EQUALS_TARGET_AGE;
            END IF;

            p_expected_income(pn_policy_reference          => pn_policy_reference
                             ,pn_expected_income_amount    => lr_calcs_inputs.expected_income_amount
                             ,pn_expected_income_amount_yr => lr_calcs_inputs.expected_income_amount_yr
                             ,pv_expected_income_frequency => lr_calcs_inputs.income_frequency
                             ,pn_expected_income_esc_rate  => lr_calcs_inputs.escalation_rate);

            lr_policy_details.income_flag := CASE WHEN lr_calcs_inputs.expected_income_amount > 0 THEN 'Y' ELSE 'N' END;

            IF lr_policy_details.stapol BETWEEN 30 AND 52
            AND NOT lb_healthchecks_found
            AND (lr_policy_details.income_flag = 'Y' OR lr_calcs_inputs.default_rev_serv_switch = 'Y') THEN

                p_retrieve_policy_investments (pn_policy_reference         =>  pn_policy_reference
                                              ,pn_effective_date           =>  lpn_effective_date
                                              ,pr_investment_details       =>  lr_investment_details
                                              ,pt_strategy_desc            =>  pt_strategy_desc
                                              ,pt_governed_portfolio_types =>  pt_governed_portfolio_types);

                p_policy_calculation_inputs(pn_policy_reference    =>  pn_policy_reference
                                           ,pr_policy_details      =>  lr_policy_details
                                           ,pr_investment_details  =>  lr_investment_details
                                           ,pn_inflation_date      =>  pn_inflation_date
                                           ,pr_calcs_inputs        =>  lr_calcs_inputs
                                           ,pd_effective_date      =>  pd_effective_date
                                           ,pn_stream              =>  pn_stream);

                p_quote_calculation_inputs(pn_policy_reference    =>  pn_policy_reference
                                          ,pr_policy_details      =>  lr_policy_details
                                          ,pr_calcs_inputs        =>  lr_calcs_inputs);
            END IF;

        EXCEPTION
        WHEN CLIENT_AGE_EQUALS_TARGET_AGE THEN
            lpt_technical_issues (pn_policy_reference) :=
                'Client Age (' || TO_CHAR(lr_client_details.age)      || ') >= ' ||
                'Target Age (' || TO_CHAR(lr_calcs_inputs.target_age) || ').';

            p_write_to_error_table (pn_policy_reference  => pn_policy_reference
                                  ,pv_error_details     => lpt_technical_issues (pn_policy_reference)
                                  ,pd_effective_date    => pd_effective_date
                                  ,pn_stream            => pn_stream);

        WHEN OTHERS THEN
            lpt_technical_issues (pn_policy_reference) := TO_CHAR(SQLCODE) || SQLERRM;

            p_write_to_error_table (pn_policy_reference  => pn_policy_reference
                                  ,pv_error_details     => lpt_technical_issues (pn_policy_reference)
                                  ,pd_effective_date    => pd_effective_date
                                  ,pn_stream            => pn_stream);
        END;

        p_review_service_switch (pb_healthchecks_failed     =>  lb_healthchecks_found
                                ,pb_technical_issue         =>  lpt_technical_issues.EXISTS(pn_policy_reference)
                                ,pv_income_flag             =>  lr_policy_details.income_flag
                                ,pn_stapol                  =>  lr_policy_details.stapol
                                ,pv_exit_mode               =>  lr_policy_details.exit_mode
                                ,pv_default_rev_serv_switch =>  lr_calcs_inputs.default_rev_serv_switch
                                ,pv_review_service_switch   =>  lr_calcs_inputs.review_service_switch
                                ,pv_reason_for_exclusion    =>  lr_calcs_inputs.reason_for_exclusion
                                ,pb_moodys_file_required    =>  lb_moodys_file_required);

        IF lb_moodys_file_required THEN

            pck_asset_class_allocation.p_policy_asset_allocation
                                        (pn_policy_reference    => pn_policy_reference
                                        ,pn_term_to_retire      => lr_policy_Details.term_to_retire
                                        ,pn_term_to_target      => lr_calcs_inputs.target_age - lr_client_details.age
                                        ,pr_investment_details  => lr_investment_details
                                        ,pd_effective_date      => lpd_effective_date
                                        ,pt_asset_class_split   => pt_asset_class_split);

            FOR i IN lr_investment_details.asset_class_split.first .. lr_investment_details.asset_class_split.last LOOP
                IF (lr_investment_details.asset_class_split.exists(i)) THEN

                    lr_investment_details.asset_class_split(i) :=
                        pck_asset_class_allocation.f_round_investment_details
                                                    (pr_asset_class_split => lr_investment_details.asset_class_split(i));

                END IF;
            END LOOP;

        END IF;

        p_write_to_dashboard_table (pr_client_details   =>  lr_client_details
                                  ,pr_policy_details   =>  lr_policy_details
                                  ,pr_calcs_inputs     =>  lr_calcs_inputs
                                  ,pr_investment_dtls  =>  lr_investment_details
                                  ,pd_effective_date   =>  pd_effective_date
                                  ,pn_stream           =>  pn_stream);

        -- Only create record in Moodys file , if Plan will be included in Drawdown Service
        -- or if adviser has excluded it, as figures may be required if service switched back on.
        -- Do not include plans without income
        IF lb_moodys_file_required  THEN
            p_write_to_moodys_table (pr_client_details   =>  lr_client_details
                                   ,pr_policy_details   =>  lr_policy_details
                                   ,pr_calcs_inputs     =>  lr_calcs_inputs
                                   ,pr_investment_dtls  =>  lr_investment_details
                                   ,pd_effective_date   =>  pd_effective_date
                                   ,pn_stream           =>  pn_stream);
        END IF;

    EXCEPTION
        WHEN OTHERS THEN
            p_write_to_error_table (pn_policy_reference  => pn_policy_reference
                                  ,pv_error_details     => TO_CHAR(SQLCODE) || SQLERRM
                                  ,pd_effective_date    => pd_effective_date
                                  ,pn_stream            => pn_stream);

    END p_generate_policy_extract;

    -- Procedure to setup run attributes
    PROCEDURE p_retrieve_run_attributes (pd_effective_date        OUT DATE
                                        ,pn_inflation_date        OUT NUMBER
                                        ,pv_run_healthchecks      OUT VARCHAR2
                                        ,pn_staff_number          OUT cl011.stf_no%TYPE
                                        ,pn_extract_period        OUT PLS_INTEGER
                                        ,pn_extract_charge_period OUT PLS_INTEGER
                                        ,pn_policy_reference      OUT po010.polref%TYPE)
    IS
        ln_process_id        process_master.process_id%TYPE;
        lr_ddg_attributes    pck_process_control_parameters.r_process_control_data;
    BEGIN
        pck_process_info.p_set_action (pv_action_name => 'p_retrieve_run_attributes');

        ln_process_id := pck_process_master.f_process_id (pv_process_name    => 'PCK_DRAWDOWN_GOVERNANCE'
                                                         ,pv_subprocess_name => 'P_DDG_ORYX_EXTRACT_ATTRIBUTES'
                                                         ,pv_process_type    => 'PL/SQL');

        lr_ddg_attributes := pck_process_control_parameters.f_curr_process_cntrl_setting
                                                                     (pn_process_id       => ln_process_id
                                                                     ,pv_process_subname  => 'F_DDG_RUN_DATE'
                                                                     ,pv_control_type     => 'DDG_RUN_DATE');

        pd_effective_date := TO_DATE(lr_ddg_attributes.process_control_value, 'DD/MM/YYYY');


        lr_ddg_attributes := pck_process_control_parameters.f_curr_process_cntrl_setting
                                                                     (pn_process_id       => ln_process_id
                                                                     ,pv_process_subname  => 'F_MID_INFLATION_RATE'
                                                                     ,pv_control_type     => 'DDG_MID_INF_RATE');

        pn_inflation_date := TO_NUMBER(lr_ddg_attributes.process_control_value);


        lr_ddg_attributes := pck_process_control_parameters.f_curr_process_cntrl_setting
                                                                     (pn_process_id       => ln_process_id
                                                                     ,pv_process_subname  => 'F_DDG_STAFF_NUMBER'
                                                                     ,pv_control_type     => 'DDG_STAFF_NUMBER');

        pn_staff_number := TO_NUMBER(lr_ddg_attributes.process_control_value);


        lr_ddg_attributes := pck_process_control_parameters.f_curr_process_cntrl_setting
                                                                     (pn_process_id       => ln_process_id
                                                                     ,pv_process_subname  => 'F_DDG_HEALTHCHECK_RUN_IND'
                                                                     ,pv_control_type     => 'DDG_HEALTHCHECK_IND');

        pv_run_healthchecks := lr_ddg_attributes.process_control_value;

        lr_ddg_attributes := pck_process_control_parameters.f_curr_process_cntrl_setting
                                                                     (pn_process_id       => ln_process_id
                                                                     ,pv_process_subname  => 'F_DDG_HEALTHCHECK_RUN_IND'
                                                                     ,pv_control_type     => 'DDG_EXTRACT_PERIOD');

        pn_extract_period := TO_NUMBER(lr_ddg_attributes.process_control_value);

        lr_ddg_attributes := pck_process_control_parameters.f_curr_process_cntrl_setting
                                                                     (pn_process_id       => ln_process_id
                                                                     ,pv_process_subname  => 'F_DDG_HEALTHCHECK_RUN_IND'
                                                                     ,pv_control_type     => 'DDG_CHARGE_PERIOD');

        pn_extract_charge_period := TO_NUMBER(lr_ddg_attributes.process_control_value);


        lr_ddg_attributes := pck_process_control_parameters.f_curr_process_cntrl_setting
                                                                     (pn_process_id       => ln_process_id
                                                                     ,pv_process_subname  => 'P_DDG_EXTRACT_STREAMS'
                                                                     ,pv_control_type     => 'DDG_POLICY');

        pn_policy_reference :=  CASE
                                WHEN lr_ddg_attributes.process_control_value = 'ALL' THEN
                                    NULL
                                WHEN lr_ddg_attributes.process_control_value = 'STOP' THEN
                                    0
                                ELSE
                                    TO_NUMBER(lr_ddg_attributes.process_control_value)
                                END;

    END p_retrieve_run_attributes;

    PROCEDURE p_retrieve_run_attributes (pd_effective_date      OUT DATE
                                        ,pn_policy_reference    OUT po010.polref%TYPE
                                        ,pn_extract_period      OUT PLS_INTEGER)

    IS
        ln_inflation_rate        NUMBER;
        lv_run_healthchecks      VARCHAR2(1);
        ln_staff_number          cl011.stf_no%TYPE;
        ln_extract_charge_period PLS_INTEGER;

    BEGIN
        pck_process_info.p_set_action (pv_action_name => 'P_RETRIEVE_RUN_ATTRIBUTES');

        p_retrieve_run_attributes   (pd_effective_date          => pd_effective_date
                                    ,pn_inflation_date          => ln_inflation_rate
                                    ,pv_run_healthchecks        => lv_run_healthchecks
                                    ,pn_staff_number            => ln_staff_number
                                    ,pn_extract_period          => pn_extract_period
                                    ,pn_extract_charge_period   => ln_extract_charge_period
                                    ,pn_policy_reference        => pn_policy_reference);

    END p_retrieve_run_attributes;

    PROCEDURE p_generate_extract(pn_stream IN PLS_INTEGER)
    IS

        CURSOR cu_extract_policies(pcn_stream PLS_INTEGER)
        IS
          SELECT policy_reference,
                 policy_index
          FROM DDG_EXTRACT_REQUESTS
          WHERE stream = pcn_stream
          AND to_be_processed = 'Y'
          ORDER BY policy_reference;

        TYPE r_policy_list IS RECORD(policy_reference po010.polref%TYPE
                                    ,policy_index     INTEGER);
        TYPE t_policy_list IS TABLE OF  r_policy_list;

        lt_policy_list t_policy_list;

        lr_bulk_settings            pck_process_control_parameters.r_process_control_data;
        ln_bulk_limit               PLS_INTEGER;
        ld_effective_date           DATE;
        ln_inflation_date           NUMBER;
        lv_run_healthchecks         VARCHAR2(1);
        ln_staff_number             cl011.stf_no%TYPE;
        ln_policy_reference         po010.polref%TYPE;
        lt_governed_portfolio_types pck_asset_class_allocation.t_governed_portfolio_types;
        lt_asset_class_split        pck_asset_class_allocation.t_asset_class_split;
        lt_strategy_desc            pck_asset_class_allocation.t_strategy_desc;
    BEGIN
        pck_process_info.p_register_module (pv_module_name =>  LPCV_PACKAGE_NAME
                                           ,pv_action_name => 'p_generate_extract');

        p_trace_individual_comment
            (pv_comment => 'Started pck_drawdown_governance.p_generate_extract Stream ' || pn_stream || ' at ' ||
                            TO_CHAR(SYSTIMESTAMP, 'HH24:MI:SS:FF2') );

        p_retrieve_run_attributes (pd_effective_date        =>  ld_effective_date
                                  ,pn_inflation_date        =>  ln_inflation_date
                                  ,pv_run_healthchecks      =>  lv_run_healthchecks
                                  ,pn_staff_number          =>  ln_staff_number
                                  ,pn_extract_period        =>  lpn_extract_period
                                  ,pn_extract_charge_period =>  lpn_extract_charge_period
                                  ,pn_policy_reference      =>  ln_policy_reference);

        p_initial_setup (pd_effective_date  => ld_effective_date);

        lt_governed_portfolio_types := f_get_governed_portfolio_types;
        lt_asset_class_split        := pck_asset_class_allocation.f_retrieve_asset_class_split (pd_effective_date => lpd_effective_date);
        lt_strategy_desc            := pck_asset_class_allocation.f_verbalise_strategy_types;

        lr_bulk_settings := pck_process_control_parameters.f_curr_process_cntrl_setting
                                                            (pv_process_name    => 'PCK_DRAWDOWN_GOVERNANCE'
                                                            ,pv_subprocess_name => 'P_DDG_ORYX_EXTRACT_ATTRIBUTES'
                                                            ,pv_process_type    => 'PL/SQL'
                                                            ,pv_control_type    => 'BULK_LIMIT'
                                                            ,pv_process_subname => 'P_GENERATE_EXTRACT');

        ln_bulk_limit := NVL(TO_NUMBER(lr_bulk_settings.process_control_value),100);

        OPEN cu_extract_policies(pcn_stream => pn_stream);

        LOOP
            EXIT WHEN cu_extract_policies%NOTFOUND;

            FETCH cu_extract_policies BULK COLLECT INTO lt_policy_list
                LIMIT ln_bulk_limit;

            IF  lt_policy_list.COUNT > 0 THEN

                FOR i IN lt_policy_list.FIRST..lt_policy_list.LAST LOOP

                    p_generate_policy_extract (pn_policy_reference         =>  lt_policy_list(i).policy_reference
                                              ,pn_policy_index             =>  lt_policy_list(i).policy_index
                                              ,pd_effective_date           =>  ld_effective_date
                                              ,pn_stream                   =>  pn_stream
                                              ,pn_inflation_date           =>  ln_inflation_date
                                              ,pv_run_healthchecks         =>  lv_run_healthchecks
                                              ,pt_governed_portfolio_types =>  lt_governed_portfolio_types
                                              ,pt_asset_class_split        =>  lt_asset_class_split
                                              ,pt_strategy_desc            =>  lt_strategy_desc);


                END LOOP;
            END IF;
        END LOOP;

        CLOSE cu_extract_policies;

        p_trace_individual_comment
            (pv_comment => 'Ending pck_drawdown_governance.p_generate_extract ' || pn_stream || ' at ' ||
                            TO_CHAR(SYSTIMESTAMP, 'HH24:MI:SS:FF2') );

    END p_generate_extract;

    PROCEDURE p_format_client_name_address (pt_client_name_address     IN t_client_v2
                                           ,pt_all_client_name_address IN OUT t_client_v2)
    IS
        ln_idx  PLS_INTEGER := 1;
    BEGIN
        pck_process_info.p_set_action (pv_action_name => 'p_format_client_name_address');

        ln_idx := pt_all_client_name_address.COUNT - pt_client_name_address.COUNT + 1;

        FOR i IN 1 .. pt_client_name_address.COUNT
        LOOP

            pt_all_client_name_address(ln_idx) := obj_client_v2 (NULL
                                                                ,NULL
                                                                ,pck_common.f_format_case(TRIM(pt_client_name_address(i).title), ' '||pck_common.GCV_FMT_INITCAP||pck_common.GCV_FMT_NO_COMPACT)
                                                                ,INITCAP(SUBSTR(pt_client_name_address(i).forename,1,(REGEXP_INSTR(SUBSTR(pt_client_name_address(i).forename,1,65),pck_pattern_matching.f_regular_expression('SPACE_OR_EOL'))-1)))
                                                                ,pck_common.f_format_case(TRIM(pt_client_name_address(i).surname), ' '||pck_common.GCV_FMT_INITCAP||pck_common.GCV_FMT_NO_COMPACT)
                                                                ,NULL
                                                                ,pck_common.f_format_case(TRIM(pt_client_name_address(i).address_name),   ' '||pck_common.GCV_FMT_INITCAP||pck_common.GCV_FMT_NO_COMPACT)
                                                                ,pck_common.f_format_case(TRIM(pt_client_name_address(i).address_line_1), ' '||pck_common.GCV_FMT_INITCAP||pck_common.GCV_FMT_NO_COMPACT)
                                                                ,pck_common.f_format_case(TRIM(pt_client_name_address(i).address_line_2), ' '||pck_common.GCV_FMT_INITCAP||pck_common.GCV_FMT_NO_COMPACT)
                                                                ,pck_common.f_format_case(TRIM(pt_client_name_address(i).address_line_3), ' '||pck_common.GCV_FMT_INITCAP||pck_common.GCV_FMT_NO_COMPACT)
                                                                ,pck_common.f_format_case(TRIM(pt_client_name_address(i).address_line_4), ' '||pck_common.GCV_FMT_INITCAP||pck_common.GCV_FMT_NO_COMPACT)
                                                                ,UPPER(TRIM(pt_client_name_address(i).postcode))
                                                                ,pt_client_name_address(i).client_ref);
            ln_idx := ln_idx + 1;
        END LOOP;
    END p_format_client_name_address;

    -- Procedure to return any Client Name / Address Changes
    PROCEDURE p_client_name_address_changes (pd_effective_date  IN  DATE
                                            ,prc_client_details OUT SYS_REFCURSOR)
    IS
        CURSOR cu_client_name_address_chg (pcn_effective_date co040.enddte%TYPE) IS
             WITH
                ir_policies AS
                    (SELECT policy
                           ,cliref
                           ,sysdte
                           ,adrref
                     FROM   (SELECT policy
                                   ,ROW_NUMBER() OVER (PARTITION BY policy ORDER BY NULL) pick_one_record
                                   ,cs3.sysdte sysdte
                                   ,c4.cliref
                                   ,c4.adrref
                             FROM   bce   b
                                   ,po010 p
                                   ,co040 c4
                                   ,cs340 cs3
                             WHERE  exit_mode    =  90
                             AND    p.stapol     BETWEEN 30 AND 52
                             AND    p.polref     =  b.policy
                             AND    bce_subtype  IN ('PCLS','USP')
                             AND    p.polref     =  c4.polref
                             AND    c4.rolref    =  'PL'
                             AND    c4.staxrf    =  30
                             AND    c4.maint    !=  'D'
                             AND    c4.enddte    >  cs3.sysdte
                             AND    p.maint     !=  'D')
                     WHERE pick_one_record   =  1)

                   ,name_change AS
                        (SELECT irp.policy
                               ,irp.cliref
                               ,irp.sysdte
                               ,irp.adrref
                         FROM   ir_policies irp
                               ,hc010 hc
                         WHERE  hc.cliref =  irp.cliref
                         AND    hc.clicat =  ' '
                         AND    hc.enddte BETWEEN (pcn_effective_date - 1) AND irp.sysdte)

                   ,address_change AS
                        (SELECT irp.policy
                               ,irp.cliref
                               ,irp.sysdte
                               ,irp.adrref
                         FROM   ir_policies irp
                               ,cl060 cl6
                         WHERE  cl6.cliref =  irp.cliref
                         AND    cl6.clicat =  ' '
                         AND    cl6.sta    =  60
                         AND    cl6.enddte BETWEEN (pcn_effective_date - 1) AND irp.sysdte)

                   ,name_n_address_changes AS
                        (SELECT  policy
                                ,cliref
                                ,sysdte
                                ,adrref
                         FROM    name_change
                         UNION
                         SELECT  policy
                                ,cliref
                                ,sysdte
                                ,adrref
                         FROM    address_change)

                SELECT   obj_client_v2
                                (email_address   => NULL
                                ,phone_number    => NULL
                                ,title           => cl10.ttl
                                ,forename        => cl10.clifor
                                ,surname         => cl10.clisur
                                ,contact_name    => NULL
                                ,address_name    => cl60.adrnam
                                ,address_line_1  => cl60.adrlneone
                                ,address_line_2  => cl60.adrlnetwo
                                ,address_line_3  => cl60.adrlnethr
                                ,address_line_4  => cl60.adrlnefor
                                ,postcode        => cl60.pcd
                                ,client_ref      => cl10.cliref)
                FROM     name_n_address_changes chg
                        ,cl010 cl10
                        ,cl060 cl60
                WHERE    chg.cliref   =  cl10.cliref
                AND      chg.cliref   =  cl60.cliref
                AND      cl60.enddte  >  chg.sysdte
                AND      cl10.clicat  =  ' '
                AND      cl60.clicat  =  ' '
                AND      cl10.maint  !=  'D'
                AND      cl60.maint  !=  'D'
                AND      cl10.stacli  =  30
                AND      cl60.sta     =  30
                AND      cl60.adrref  =  chg.adrref;

        lt_client_name_address     t_client_v2 := t_client_v2();
        lt_all_client_name_address t_client_v2 := t_client_v2();

        ln_effective_date          co040.enddte%TYPE := pck_common.f_dtcnv(pd_effective_date);
        ln_bulk_limit              PLS_INTEGER       := pck_bulk_collect_limits_api.f_bulk_limit (pv_object_name => 'GENERAL');
    BEGIN
        pck_process_info.p_register_module(pv_module_name =>  LPCV_PACKAGE_NAME
                                          ,pv_action_name => 'p_client_name_address_changes');

        OPEN cu_client_name_address_chg (pcn_effective_date => ln_effective_date);

        LOOP
            FETCH cu_client_name_address_chg BULK COLLECT
            INTO  lt_client_name_address LIMIT ln_bulk_limit;

            lt_all_client_name_address.EXTEND(lt_client_name_address.COUNT);

            p_format_client_name_address (pt_client_name_address     => lt_client_name_address
                                         ,pt_all_client_name_address => lt_all_client_name_address);

            EXIT WHEN cu_client_name_address_chg%NOTFOUND;
        END LOOP;

        CLOSE cu_client_name_address_chg;

        OPEN prc_client_details FOR
            SELECT  Policy_reference
                   ,Title
                   ,Forename
                   ,Surname
                   ,addressee_name
                   ,address_line1
                   ,address_line2
                   ,address_line3
                   ,address_line4
                   ,Postcode
            FROM (SELECT   c4.polref                      Policy_reference
                          ,client_dtls.title              Title
                          ,client_dtls.forename           Forename
                          ,client_dtls.surname            Surname
                          ,client_dtls.address_name       addressee_name
                          ,client_dtls.address_line_1     address_line1
                          ,client_dtls.address_line_2     address_line2
                          ,client_dtls.address_line_3     address_line3
                          ,client_dtls.address_line_4     address_line4
                          ,client_dtls.postcode           Postcode
                          ,ROW_NUMBER() OVER (PARTITION BY c4.polref ORDER BY NULL) pick_one_record
                  FROM   TABLE (CAST(lt_all_client_name_address AS t_client_v2)) client_dtls
                        ,co040 c4
                        ,cs340 cs34
                  WHERE  c4.cliref = client_dtls.client_ref
                  AND    c4.clicat = ' '
                  AND    c4.rolref = 'PL'
                  AND    c4.staxrf = 30
                  AND    c4.enddte > cs34.sysdte
                  AND    c4.maint != 'D')
           WHERE pick_one_record = 1 ;
    END p_client_name_address_changes;

    -- Procedure to return any ITR changes.
    -- pd_effective_date is likely to be system date minus 7 days to return any changes
    -- over that period in case the web job that calls this fails to run and needs to
    -- catch up.
    PROCEDURE p_adviser_changes (pd_effective_date  IN  DATE
                                ,prc_client_details OUT SYS_REFCURSOR)
    IS
        ln_effective_date co040.enddte%TYPE := pck_common.f_dtcnv(pd_effective_date);
    BEGIN
        pck_process_info.p_register_module (pv_module_name =>  LPCV_PACKAGE_NAME
                                           ,pv_action_name => 'p_adviser_changes');

        OPEN prc_client_details FOR
            WITH ir_policies_old_itr AS
                (
                -- An ITR might change more than once over the period the sync is called for
                -- and might in that time change back to the original ITR so therefore
                -- no change.
                SELECT DISTINCT
                        c4.polref policy
                       ,cs3.sysdte sysdte
                       ,c4.cliref  old_itr
                       ,c4.strdte
                       ,c4.xrfunq
                FROM
                    bce   b
                   ,po010 p
                   ,co040 c4
                   ,cs340 cs3
                WHERE  exit_mode    =  90
                AND    p.stapol     BETWEEN 30 AND 52
                AND    p.polref     =  b.policy
                AND    bce_subtype  IN ('PCLS','USP')
                AND    p.polref     =  c4.polref
                AND    c4.rolref    =  'ITR'
                AND    c4.staxrf    =  30
                AND    c4.enddte   BETWEEN (ln_effective_date - 1) AND cs3.sysdte
                AND    c4.maint    !=  'D'
                ORDER BY c4.polref, c4.strdte DESC, c4.xrfunq DESC
                )

            SELECT
                A.Policy_reference, A.Old_ITR_number, A.New_ITR_number, A.Itr_Name
            FROM
                (
                -- Returns list of possible current records ranked by cliref
                SELECT DISTINCT
                    irp.policy      Policy_reference
                    ,irp.old_itr    Old_ITR_number
                    ,c4.cliref      New_ITR_number
                    ,(
                        SELECT itr.itr_name
                        FROM
                            (
                                SELECT adrnam itr_name
                                      ,cliref itr_ref
                                      ,clicat itr_cat
                                      ,row_number() over (PARTITION BY a.cliref,a.clicat ORDER BY adrref ASC) pick_record
                                FROM  cl060 a
                                WHERE maint != 'D'
                                AND   enddte = 99999
                                AND   sta = 30
                            ) itr
                        WHERE pick_record = 1
                        AND itr.itr_ref = c4.cliref
                        AND itr.itr_cat = c4.clicat
                    ) Itr_Name

                    -- It's possible for there to be more than one ITR with enddte = 99999 and different
                    -- start dates. The sync needs to return the "current" ITR i.e the same as on COMON.
                    -- Follow the code in TL010_p which calls cursor co040_prc_group_f3 and this is ordered
                    -- by polref ASC,rolref ASC,clicat ASC,cliref ASC,xrfunq ASC
                    ,RANK() OVER(PARTITION BY c4.polref ORDER BY c4.cliref,c4.xrfunq) rnk

                FROM
                    ir_policies_old_itr  irp
                    ,co040 c4
                WHERE   irp.policy  =  c4.polref
                AND     c4.rolref   =  'ITR'
                AND     c4.clicat   =  'ITR'
                AND     c4.staxrf   =  30
                AND     c4.enddte   = 99999
                AND     c4.jtlind   =  1
                AND     c4.maint    != 'D'
                ) A
            WHERE rnk = 1
            -- rnk = 1 records might be the same ITR as one of the closed records
            -- so don't return it.
            AND A.New_ITR_number != A.Old_ITR_number;

    END p_adviser_changes;

    PROCEDURE p_adviser_names(prc_intermediary_details OUT SYS_REFCURSOR)
    IS
    BEGIN

        pck_process_info.p_register_module(pv_module_name =>  LPCV_PACKAGE_NAME
                                          ,pv_action_name => 'p_adviser_names');

        OPEN prc_intermediary_details FOR
        SELECT intermediary_reference
              ,REPLACE (intermediary_name, ',', ' ') intermediary_name -- replace comma with space to keep in line with adviser names in the extract
        FROM
        (SELECT  adrnam intermediary_name
                ,cliref intermediary_reference
                ,row_number() OVER (PARTITION BY a.cliref ORDER BY a.adrref,a.strdte DESC) rnk
        FROM  cl060 a
        WHERE maint != 'D'
        AND   enddte = 99999
        AND   clicat = 'ITR'
        AND   sta = 30)
        WHERE rnk = 1;

    END p_adviser_names;

END pck_drawdown_governance;
/
