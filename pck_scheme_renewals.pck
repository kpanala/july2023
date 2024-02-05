CREATE OR REPLACE PACKAGE PROJECT_DEV_07.pck_scheme_renewals
IS
/**********************************************************************************************
-- DESCRIPTION:<BR>
-- Scheme post renewals
-- %Author     DArumugam
-- %Date       17/03/2018
-- %ModHist
-- <CODE><FONT FACE="Courier" SIZE="2">
--   Version   Date                   Modified by    Brief Description of Modification<BR>
-- $Log:   //vm1/PICCSDB/archives/life/database/headers/pck_scheme_renewals.spc-arc  $
--
--   Rev 1.5   Jul 09 2019 14:43:08   SourceSafe
--Integrated version 1.4.1.0 from project TB_CJ_THREE_II
--
--   Rev 1.4.1.0   Jul 08 2019 16:51:48   MJagan
--made p_backdated_premium_check procedure private
--
--   Rev 1.4   Jun 27 2019 16:45:10   SourceSafe
--Integrated version 1.3.1.1 from project TB_CJ_THREE_II
--
--   Rev 1.3.1.1   12 Jun 2019 16:36:46   ARamakrishna
--Made p_backdated_premium_check procedure public.
--
--   Rev 1.3.1.0   Apr 24 2019 15:13:46   nswarupa
--Made p_calc_benqty procedure public
--
--   Rev 1.3   Mar 07 2019 11:12:58   SourceSafe
--Integrated version 1.2.1.5 from project TB_CJ_THREE
--
--   Rev 1.2.1.5   Feb 26 2019 19:23:16   SASOPA
--included trigger type
--
--   Rev 1.2.1.4   08 Feb 2019 15:52:32   SPatlolla
--Changes to be in sync with body.
--
--   Rev 1.2.1.3   06 Feb 2019 13:02:52   MMSmith
--synchronised spec and body
--
--   Rev 1.2.1.1   Feb 04 2019 14:12:38   SASOPA
--changes to include actref
--
--   Rev 1.2.1.0   Jan 29 2019 17:04:22   SASOPA
--changes for cimp-ip
--
--   Rev 1.2   Aug 07 2018 21:31:28   SourceSafe
--Integrated version 1.1.1.1 from project TB_CJ_THREE_II
--
--   Rev 1.1.1.1   Aug 06 2018 19:41:38   MJagan
--made  p_check_only_GLA public
--
--   Rev 1.1.1.0   Jul 17 2018 17:48:32   MJagan
--Removed p_check_valid_scheme as part of CPs changes
--
--   Rev 1.1   May 30 2018 14:34:42   SourceSafe
--Integrated version 1.0.1.6 from project TB_CJ_THREE
--
--   Rev 1.0.1.6   18 May 2018 13:28:00   MMSmith
--minor change to params
--
--   Rev 1.0.1.5   18 May 2018 10:54:48   MMSmith
--minor change to params post code review
--
--   Rev 1.0.1.4   17 May 2018 14:52:54   MMSmith
--minor changes to parameters
--
--   Rev 1.0.1.3   May 16 2018 18:18:32   DArumugam
--Added changes for wrapper call to block GPP SHR policies
--
--   Rev 1.0.1.2   Apr 18 2018 18:25:50   DArumugam
--Added changes for fund stamping process
--
--   Rev 1.0.1.1   Apr 11 2018 16:53:38   nswarupa
--made changes for bch_renewal_pack_values process
--
--   Rev 1.0.1.0   Mar 27 2018 17:31:14   DArumugam
--Added changes as part of CJ3 for triggering UT1170
--
********************************************************************************************************/

    TYPE r_eligible_schemes IS RECORD (cliref    po100.cliref%TYPE
                                      ,clicat    po100.clicat%TYPE
                                      ,actdte    po100.actdte%TYPE
                                      ,sta       po100.sta%TYPE
                                      ,actpar    po100.actpar%TYPE
                                      ,unqref    po100.unqref%TYPE
                                      ,actref    po100.actref%TYPE);

    TYPE t_eligible_schemes IS TABLE OF r_eligible_schemes INDEX BY PLS_INTEGER;

    TYPE r_gg242_rnwactpar IS RECORD(schsubcat   Co040.Schsubcat%TYPE
                                    ,adjleatme   NUMBER(2)
                                    ,pntactref   po100.actref%TYPE
                                    ,rnwdte      po100.actdte%TYPE
                                    ,prvrnwdte   po100.actdte%TYPE);

    TYPE r_wp_policy   IS RECORD (polref     po010.polref%TYPE
                                 ,cliref     po100.cliref%TYPE
                                 ,clicat     po100.clicat%TYPE
                                 ,schsubcat  co040.schsubcat%TYPE);

    TYPE t_wp_policy IS TABLE OF r_wp_policy INDEX BY PLS_INTEGER;


    TYPE r_fnd_ref IS RECORD(fndref     co055.fndref%TYPE
                            ,fndsubtyp  co055.fndsubtyp%TYPE
                            ,unttyp     co055.unttyp%TYPE);

    TYPE t_fnd_ref IS TABLE OF r_fnd_ref INDEX BY PLS_INTEGER;

    TYPE r_benefits  IS RECORD (fndref      co055.fndref%TYPE
                               ,fndsubtyp   co055.fndsubtyp%TYPE
                               ,unttyp      co055.unttyp%TYPE
                               ,pstben_pr   co055.benqty1%TYPE
                               ,pstoth_pr   co055.benqty1%TYPE
                               ,pstben_ar   co055.benqty1%TYPE
                               ,pstoth_ar   co055.benqty1%TYPE
                               ,preben_pr   co055.benqty1%TYPE
                               ,preoth_pr   co055.benqty1%TYPE
                               ,preben_ar   co055.benqty1%TYPE
                               ,preoth_ar   co055.benqty1%TYPE);

    TYPE t_benefits IS TABLE OF r_benefits INDEX BY PLS_INTEGER;

    TYPE r_transactions IS RECORD (pretrn_pr      fi700.benqty1%TYPE
                                  ,pretrnoth_pr   fi700.benqty1%TYPE
                                  ,psttrn_pr      fi700.benqty1%TYPE
                                  ,psttrnoth_pr   fi700.benqty1%TYPE
                                  ,pretrn         fi700.benqty1%TYPE
                                  ,pretrnoth      fi700.benqty1%TYPE
                                  ,psttrn         fi700.benqty1%TYPE
                                  ,psttrnoth      fi700.benqty1%TYPE);

    TYPE r_eligible_cimp_ip_policies IS RECORD (polref    po010.polref%TYPE
                                               ,cliref    po100.cliref%TYPE
                                               ,clicat    po100.clicat%TYPE
                                               ,actdte    po100.actdte%TYPE
                                               ,actpar    po100.actpar%TYPE
                                               ,unqref    po100.unqref%TYPE
                                               ,actref    po100.actref%TYPE);

    TYPE t_eligible_cimp_ip_policies IS TABLE OF r_eligible_cimp_ip_policies INDEX BY PLS_INTEGER;

    /*******************************************************************************************************
    -- %Description  Procedure fetches all the schemes that are eligible for post renewal processing
    -- %param        None
    -- %raises       None
    ********************************************************************************************************/
    PROCEDURE p_eligible_schemes;

    /*******************************************************************************************************
    -- %Description  Procedure updates the Po100 PSTSCH trigger to the given status
    -- %param        pn_status    IN  po100.sta%TYPE
    -- %param        pn_cliref    IN  po100.cliref%TYPE
    -- %param        pv_clicat    IN  po100.clicat%TYPE
    -- %param        pn_rnwdte    IN  po100.actdte%TYPE
    -- %param        pn_unqref    IN  po100.unqref%TYPE
    -- %param        pv_actpar    IN  po100.actpar%TYPE
    -- %raises       OTHERS
    ********************************************************************************************************/
    PROCEDURE p_update_po100(pn_status  IN  po100.sta%TYPE
                            ,pn_cliref  IN  po100.cliref%TYPE
                            ,pv_clicat  IN  po100.clicat%TYPE
                            ,pn_rnwdte  IN  po100.actdte%TYPE
                            ,pn_unqref  IN  po100.unqref%TYPE
                            ,pv_actpar  IN  po100.actpar%TYPE);

    /*******************************************************************************************************
    -- %Description  Function returns the actpar string for the given clire, clicat and renewal date
    -- %param        pn_cliref    IN  po100.cliref%TYPE
    -- %param        pv_clicat    IN  po100.clicat%TYPE
    -- %param        pn_rnwdte    IN  po100.actdte%TYPE
    -- %param        pn_unqref    IN  po100.unqref%TYPE
    -- %returns      po100.actpar%TYPE
    -- %raises       None
    ********************************************************************************************************/
    FUNCTION f_get_PSTSCH_details (pn_cliref  IN po100.cliref%TYPE
                                  ,pv_clicat  IN po100.clicat%TYPE
                                  ,pn_rnwdte  IN po100.actdte%TYPE
                                  ,pn_unqref  IN po100.unqref%TYPE)
    RETURN po100.actpar%TYPE;

   /*******************************************************************************************************
    -- %Description  Procedure creates the exception trigger RS-PSTEXC for a given policy
    -- %param        pn_polref        IN   po010.polref%TYPE
    -- %param        pn_cliref        IN   po100.cliref%TYPE
    -- %param        pv_clicat        IN   po100.clicat%TYPE
    -- %param        pn_rnwdte        IN   po100.actdte%TYPE
    -- %param        pn_unqref        IN   po100.unqref%TYPE
    -- %param        pv_trigger_type  IN   renewal_statement_pack_wp.trigger_type%TYPE
    -- %param        pv_actpar        OUT  po100.actpar%TYPE
    -- %raises       OTHERS
    ********************************************************************************************************/
    PROCEDURE p_create_exception (pn_polref       IN  po010.polref%TYPE
                                 ,pn_cliref       IN  po100.cliref%TYPE
                                 ,pv_clicat       IN  po100.clicat%TYPE
                                 ,pn_rnwdte       IN  po100.actdte%TYPE
                                 ,pn_unqref       IN  po100.unqref%TYPE
                                 ,pv_trigger_type IN  renewal_statement_pack_wp.trigger_type%TYPE
                                 ,pv_actpar       OUT po100.actpar%TYPE);

    /*******************************************************************************************************
    -- %Description  Procedure checks if the event records are available for all fi700 transactions
    -- %param        pn_polref        IN  po010.polref%TYPE
    -- %param        pn_cliref        IN  po100.cliref%TYPE
    -- %param        pv_clicat        IN  po100.clicat%TYPE
    -- %param        pn_rnwdte        IN  po100.actdte%TYPE
    -- %param        pn_strdte        IN  po100.actdte%TYPE
    -- %param        pn_unqref        IN  po100.unqref%TYPE
    -- %param        pv_trigger_type  IN  renewal_statement_pack_wp.trigger_type%TYPE
    -- %param        pv_valid_event   OUT VARCHAR2
    -- %raises       OTHERS
    ********************************************************************************************************/
    PROCEDURE p_check_event_records(pn_polref       IN  po010.polref%TYPE
                                   ,pn_cliref       IN  po100.cliref%TYPE
                                   ,pv_clicat       IN  po100.clicat%TYPE
                                   ,pn_rnwdte       IN  po100.actdte%TYPE
                                   ,pn_strdte       IN  po100.actdte%TYPE
                                   ,pn_unqref       IN  po100.unqref%TYPE
                                   ,pv_trigger_type IN  renewal_statement_pack_wp.trigger_type%TYPE
                                   ,pv_valid_event  OUT VARCHAR2);

   /*******************************************************************************************************
    -- %Description  Procedure calculates the benqty value for the given fundref and policy
    -- %param        pn_polref       IN   po010.polref%TYPE
    -- %param        pn_strdte       IN   po100.actdte%TYPE
    -- %param        pn_rnwdte       IN   po100.actdte%TYPE
    -- %param        pn_fndref       IN   fi700.fndref%TYPE
    -- %param        pr_benefits IN OUT   r_benefits
    -- %raises       None
    ********************************************************************************************************/
    PROCEDURE p_calc_benqty(pn_polref       IN  po010.polref%TYPE
                           ,pn_strdte       IN  po100.actdte%TYPE
                           ,pn_rnwdte       IN  po100.actdte%TYPE
                           ,pn_fndref       IN  fi700.fndref%TYPE
                           ,pr_benefits IN OUT  r_benefits);

   /***********************************************************************************************************
    -- %Description  Procedure does the Fund Stamping(co055 inserts and FI700 updates) for a particular policy
    -- %param        pn_polref         IN    po010.polref%TYPE
    -- %param        pn_strdte         IN    po100.actdte%TYPE
    -- %param        pn_rnwdte         IN    po100.actdte%TYPE
    -- %param        pv_trigger_type   IN   renewal_statement_pack_wp.trigger_type%TYPE
    -- %raises       OTHERS
    ***********************************************************************************************************/
    PROCEDURE p_fund_stamping(pn_polref       IN   po010.polref%TYPE
                             ,pn_strdte       IN   po100.actdte%TYPE
                             ,pn_rnwdte       IN   po100.actdte%TYPE
                             ,pv_trigger_type IN   renewal_statement_pack_wp.trigger_type%TYPE);

    /*******************************************************************************************************
    -- %Description  Procedure to check if the policy has only GLA funds
    -- %param        pn_polref           IN       po010.polref%TYPE
    -- %param        pv_only_GLA        OUT       VARCHAR2
    -- %raises       None
    ********************************************************************************************************/
    PROCEDURE p_check_only_GLA(pn_polref       IN  po010.polref%TYPE
                              ,pv_only_GLA     OUT  VARCHAR2);

    /*******************************************************************************************************
    -- %Description  Procedure fetches all the CIMP-IP policies that are eligible for post renewal processing
    -- %param        None
    -- %raises       Others
    ********************************************************************************************************/
    PROCEDURE p_eligible_cimp_ip_policies;

    /*******************************************************************************************************
    -- %Description  Procedure updates the Po100 RS-PST-IP trigger to the given status
    -- %param        pn_status    IN  po100.sta%TYPE
    -- %param        pn_polref    IN  po010.polref%TYPE
    -- %param        pn_cliref    IN  po100.cliref%TYPE
    -- %param        pv_clicat    IN  po100.clicat%TYPE
    -- %param        pn_rnwdte    IN  po100.actdte%TYPE
    -- %param        pn_unqref    IN  po100.unqref%TYPE
    -- %raises       Others
    ********************************************************************************************************/
    PROCEDURE p_update_po100_cimp_ip(pn_status  IN  po100.sta%TYPE
                                    ,pn_polref  IN  po010.polref%TYPE
                                    ,pn_cliref  IN  po100.cliref%TYPE
                                    ,pv_clicat  IN  po100.clicat%TYPE
                                    ,pn_rnwdte  IN  po100.actdte%TYPE
                                    ,pn_unqref  IN  po100.unqref%TYPE);

END pck_scheme_renewals;
/
CREATE OR REPLACE PACKAGE BODY PROJECT_DEV_07.pck_scheme_renewals
IS
/**********************************************************************************************
-- DESCRIPTION:<BR>
-- Scheme Post renewals
-- %Author     DArumugam
-- %Date       17/03/2018
-- %ModHist
-- <CODE><FONT FACE="Courier" SIZE="2">
--   Version   Date                   Modified by    Brief Description of Modification<BR>
-- $Log:   //vm1/PICCSDB/archives/life/database/bodies/pck_scheme_renewals.bdy-arc  $
--
--   Rev 1.10   Jul 18 2019 15:05:10   SourceSafe
--Integrated version 1.9.1.2 from project TB_CJ_THREE_II
--
--   Rev 1.9.1.2   18 Jul 2019 18:45:40   ARamakrishna
--Changes to the doc tags of p_process_policies and p_get_policies.
--
--   Rev 1.9.1.1   18 Jul 2019 18:21:40   ARamakrishna
--Changes to p_get_policies.
--
--   Rev 1.9.1.0   17 Jul 2019 13:14:54   ARamakrishna
--Bug 515729 - Changes to block schemes with no valid policies from getting inserted into our new tables.
--
--   Rev 1.9   Jun 27 2019 16:43:50   SourceSafe
--Integrated version 1.7.1.4 from project TB_CJ_THREE_II
--
--   Rev 1.7.1.4   Jun 24 2019 20:26:04   SASOPA
--minor change
--
--   Rev 1.7.1.3   May 13 2019 14:49:58   SASOPA
--changes for summary checks
--
--   Rev 1.7.1.2   May 02 2019 19:42:50   SASOPA
--changes for summary docs
--
--   Rev 1.7.1.1   Mar 08 2019 12:14:54   SASOPA
--Bug fix - 427016 & merged with version 1.6.2.16
--
--   Rev 1.7.1.0   Mar 01 2019 18:15:26   MJagan
--included CMP schemes in workplace flow and added changes from version 1.6.2.15
--
--   Rev 1.6.2.15   Feb 28 2019 15:49:54   SASOPA
--included actpar for p_check_unwound_records
--
--   Rev 1.6.2.14   Feb 26 2019 19:30:02   SASOPA
--included trigger type related to exception trigger
--
--   Rev 1.6.2.13   Feb 20 2019 12:40:00   SASOPA
--cosmetic comments
--
--   Rev 1.6.2.12   Feb 19 2019 16:48:00   SASOPA
--Bug fix - 416622
--
--   Rev 1.6.2.11   13 Feb 2019 11:33:00   SPatlolla
--Update Po100 maint to C.
--
--   Rev 1.6.2.10   13 Feb 2019 10:24:44   MMSmith
--changed back to version1.6.2.8
--
--   Rev 1.6.2.8   Feb 12 2019 17:59:24   MJagan
--added changes for bug:413341
--
--   Rev 1.6.2.7   11 Feb 2019 12:47:30   MMSmith
--Peer review - used 'p_lookup_renewal_audit' instead of 'p_lookup_renewal_audit_wp' in order to make regression testing easier
--
--   Rev 1.6.2.6   08 Feb 2019 15:49:22   SPatlolla
--Bug 414764 fix.
--
--   Rev 1.6.2.5   08 Feb 2019 11:55:12   MMSmith
--Added audit details for CMP-IP
--
--   Rev 1.6.2.3   Feb 05 2019 15:00:06   SASOPA
--merged with version 1.6.1.4
--
--   Rev 1.6.2.2   Feb 04 2019 14:12:58   SASOPA
--changes to include actref
--
--   Rev 1.6.2.1   Jan 31 2019 18:05:18   SASOPA
--peer review comments
--
--   Rev 1.6.2.0   Jan 29 2019 17:04:46   SASOPA
--changes for cimp-ip trigger
--
--   Rev 1.6.1.4   23 Jan 2019 12:24:56   MMSmith
--Code Review - Reverted back to 1.6.1.2
--
--   Rev 1.6.1.1   18 Jan 2019 15:17:48   MMSmith
--Removed MOD on AUDIT_ID from MERGE. Changed to UPDATE duplicate Po100s to 55 so that they are re-processed again and again!!  Code Analyser compliance!
--
--   Rev 1.6   Sep 14 2018 09:54:50   SourceSafe
--Integrated version 1.5.1.1 from project TB_CJ_THREE
--
--   Rev 1.5.1.1   Sep 13 2018 11:01:24   SASOPA
--cosmetic change
--
--   Rev 1.5.1.0   Sep 10 2018 16:56:28   SASOPA
--code changes for FI700 fund stamping issue
--
--   Rev 1.5   Aug 31 2018 17:15:18   SourceSafe
--Integrated version 1.4.1.3 from project TB_CJ_THREE_III
--
--   Rev 1.4.1.3   31 Aug 2018 12:47:04   MMSmith
--minor changes to indentation
--
--   Rev 1.4.1.1   29 Aug 2018 14:53:06   MMSmith
--changed Exception re-raise to FALSE when getting audit details
--
--   Rev 1.4.1.0   28 Aug 2018 11:57:58   MMSmith
--Replaced hardocded audit details for 1171 with lookup from package_audits
--
--   Rev 1.4   Aug 15 2018 15:04:24   SourceSafe
--Integrated version 1.2.2.4 from project TB_CJ_THREE
--
--   Rev 1.2.2.4   13 Aug 2018 12:26:54   MMSmith
--minor change to remove extra spaces
--
--   Rev 1.2.2.1   Aug 13 2018 10:11:24   MJagan
--Added procedure to delete 'RS-PSTEXC' trigger
--
--   Rev 1.2.2.0   09 Aug 2018 16:09:02   MMSmith
--amended MERGE to convert date without using RL function vall in SQL
--
--   Rev 1.3   Aug 07 2018 21:31:20   SourceSafe
--Integrated version 1.2.1.3 from project TB_CJ_THREE_II
--
--   Rev 1.2.1.3   Jul 24 2018 12:14:10   DArumugam
--Fixed Peer review comments
--
--   Rev 1.2.1.2   Jul 23 2018 12:25:54   DArumugam
--Defect Fix 258885
--
--   Rev 1.2.1.1   Jul 17 2018 17:46:12   MJagan
--Removed p_check_valid_scheme as part of CPs changes
--
--   Rev 1.2.1.0   Jul 17 2018 17:14:04   DArumugam
--added changes to pick continuation plans in new process
--
--   Rev 1.2   Jun 20 2018 10:31:28   SourceSafe
--Integrated version 1.1.1.5 from project TB_CJ_THREE
--
--   Rev 1.1.1.5   Jun 14 2018 15:09:24   SASOPA
--reverted back early errors changes
--
--   Rev 1.1.1.4   Jun 12 2018 13:50:12   SASOPA
--minor wording change
--
--   Rev 1.1.1.3   Jun 11 2018 17:20:02   SASOPA
--cosmetic changes
--
--   Rev 1.1.1.2   Jun 11 2018 15:44:58   SASOPA
--peer review comments
--
--   Rev 1.1.1.1   Jun 07 2018 18:04:40   SASOPA
--minor changes
--
--   Rev 1.1.1.0   Jun 07 2018 17:30:28   SASOPA
--changes for early errors
--
--   Rev 1.1   May 30 2018 14:33:16   SourceSafe
--Integrated version 1.0.1.25 from project TB_CJ_THREE
--
--   Rev 1.0.1.25   25 May 2018 14:49:56   MMSmith
--Refactored post code review
--
--   Rev 1.0.1.24   25 May 2018 13:19:00   MMSmith
--Refactored post code review
--
--   Rev 1.0.1.22   May 24 2018 13:26:10   SASOPA
--Code review comments fixed
--
--   Rev 1.0.1.21   24 May 2018 11:41:50   MMSmith
--Refactoring of p_get_reversed_funds
--
--   Rev 1.0.1.20   18 May 2018 13:23:48   MMSmith
--minor change to apply MOD to audit_id + 1
--
--   Rev 1.0.1.19   18 May 2018 12:20:18   MMSmith
--Various changes post code review
--
--   Rev 1.0.1.16   17 May 2018 14:59:04   MMSmith
--minor changes to params
--
--   Rev 1.0.1.15   17 May 2018 14:44:16   MMSmith
--minor change to indentation
--
--   Rev 1.0.1.14   May 16 2018 18:17:30   DArumugam
--Fixed review comments
--
--   Rev 1.0.1.13   May 10 2018 12:24:20   DArumugam
--Minor change to diaplay data in E-service
--
--   Rev 1.0.1.12   May 03 2018 12:47:52   SASOPA
--minor change
--
--   Rev 1.0.1.11   Apr 27 2018 16:54:20   DArumugam
--Fixed review comments
--
--   Rev 1.0.1.10   Apr 25 2018 14:37:38   DArumugam
--Fixed Bug 213997
--
--   Rev 1.0.1.9   Apr 23 2018 15:36:24   DArumugam
--Added changes to pickup only RGP and SHR schemes
--
--   Rev 1.0.1.8   Apr 18 2018 18:25:06   DArumugam
--Added changes for Fund Stamping
--
--   Rev 1.0.1.7   Apr 17 2018 13:43:26   DArumugam
--Made changes for the bug 210258
--
--   Rev 1.0.1.6   Apr 13 2018 14:42:28   nswarupa
--Made changes to fix BUG 209338
--
--   Rev 1.0.1.5   Apr 12 2018 12:44:42   nswarupa
--Made some changes to add Doctags
--
--   Rev 1.0.1.4   Apr 11 2018 16:51:32   nswarupa
--minor changes
--
--   Rev 1.0.1.3   Apr 10 2018 16:56:10   nswarupa
--Made chanages as part of renewal_values process
--
--   Rev 1.0.1.1   Mar 28 2018 18:08:08   DArumugam
--Fixed Bug 201964 and minor changes on Unwind trigger validation
--
--   Rev 1.0.1.0   Mar 27 2018 17:26:54   DArumugam
--Added changes as part of CJ3 for triggerring UT1170.
--
********************************************************************************************************/

    LPCV_PACKAGE_NAME   CONSTANT   VARCHAR2(19)        :=  'PCK_SCHEME_RENEWALS';
    lpn_sysdate         cs340.sysdte%TYPE              :=  pck_system_context.f_get_system_date;
    lpn_bulk_limit      PLS_INTEGER                    :=  pck_bulk_collect_limits_api.f_bulk_limit('GENERAL');
    lpd_system_date     cs340.system_dt%TYPE           :=  pck_dates.f_system_date;
    lpn_audupdtme       cs340.audupdtme%TYPE           :=  TO_NUMBER(TO_CHAR(SYSTIMESTAMP,'HH24MMSSFF2'));
    lpr_audit_details   pck_audits.rec_audits;

    TYPE t_audit_type IS TABLE OF lpr_audit_details%TYPE INDEX BY PO100.actref%TYPE;
    lpt_audit_details t_audit_type;

    /***************************************************************************************************************
    -- %Description Procedure to lookup audit info for workplace (WP)
    -- %param       none
    -- %raises      OTHERS
    ****************************************************************************************************************/
    PROCEDURE p_lookup_renewal_audit
    IS
    BEGIN
        pck_process_info.p_register_module(pv_module_name => LPCV_PACKAGE_NAME
                                          ,pv_action_name => 'P_LOOKUP_RENEWAL_AUDIT');
        -- Look up WP audit data on package_audits table
        pck_audits.p_process_audits(pv_process_name  => 'P_LOOKUP_RENEWAL_AUDIT'
                                   ,pr_audits        => lpt_audit_details('RS-PSTSCH'));

    EXCEPTION
    WHEN OTHERS THEN
        pck_err.p_handle(pv_err_code => 'ERRMSG'
                        ,pv_add_text => 'Error getting WP audit data'   || CHR(10) ||
                                        'LPCV_PACKAGE_NAME          : ' || LPCV_PACKAGE_NAME
                        ,pb_log_err  => TRUE
                        ,pb_re_raise => FALSE);

    END p_lookup_renewal_audit;

    /***************************************************************************************************************
    -- %Description Procedure to lookup audit info for CMP-IP
    -- %param       none
    -- %raises      OTHERS
    ****************************************************************************************************************/
    PROCEDURE p_lookup_renewal_audit_cmp_ip
    IS
    BEGIN
        pck_process_info.p_register_module(pv_module_name => LPCV_PACKAGE_NAME
                                          ,pv_action_name => 'P_LOOKUP_RENEWAL_AUDIT_CMP_IP');
        -- Look up CMP-IP audit data on package_audits table
        pck_audits.p_process_audits(pv_process_name  => 'P_LOOKUP_RENEWAL_AUDIT_CMP_IP'
                                   ,pr_audits        => lpt_audit_details('RS-PST-IP'));

    EXCEPTION
    WHEN OTHERS THEN
        pck_err.p_handle(pv_err_code => 'ERRMSG'
                        ,pv_add_text => 'Error getting CMP-IP audit data'   || CHR(10) ||
                                        'LPCV_PACKAGE_NAME              : ' || LPCV_PACKAGE_NAME
                        ,pb_log_err  => TRUE
                        ,pb_re_raise => FALSE);

    END p_lookup_renewal_audit_cmp_ip;

  /*******************************************************************************************************
   -- %Description  Procedure to update funds om fi700
   -- %param        pn_nxtstm_no   IN co055.untstm_no%TYPE
   -- %param        pt_fi700       IN pck_fund_movements.tab_fi700s
   -- %param        pv_trigger_type IN renewal_statement_pack_wp.trigger_type%TYPE
   -- %raises       none
   ********************************************************************************************************/

   PROCEDURE p_update_fi700_funds(pn_nxtstm_no    IN co055.untstm_no%TYPE
                                 ,pt_fi700        IN pck_fund_movements.tab_fi700s
                                 ,pv_trigger_type IN renewal_statement_pack_wp.trigger_type%TYPE)
    IS
    BEGIN
        pck_process_info.p_set_action(pv_action_name => 'P_UPDATE_FI700_FUNDS');

        FORALL i IN 1.. pt_fi700.COUNT
            UPDATE fi700 f
                SET    f.untstm_no = pn_nxtstm_no
                      ,f.staevt    = pt_fi700(i).staevt
                      ,f.audupd_id = MOD(f.audupd_id + 1
                                       ,100)
                      ,f.audupddte = lpn_sysdate
                      ,f.audupdtme = lpn_audupdtme
                      ,f.audaplcde = lpt_audit_details(pv_trigger_type).audit_application_code
                      ,f.audstf_no = lpt_audit_details(pv_trigger_type).audit_staff_number
                WHERE  f.polref    = pt_fi700(i).polref
                AND    f.trnctl_no = pt_fi700(i).trnctl_no
                AND    f.trn_no    = pt_fi700(i).trn_no
                AND    f.evtunq    = pt_fi700(i).evtunq
                AND    f.evttrn_no = pt_fi700(i).evttrn_no
                AND    f.duedte    = pt_fi700(i).duedte
                AND    f.staevt    = pt_fi700(i).staevt;

   END p_update_fi700_funds;

   /*******************************************************************************************************
   -- %Description  Procedure to reverse update funds om fi700
   -- %param        pn_untstm_no    IN fi700.untstm_no%TYPE
   -- %param        pt_fi700        IN pck_fund_movements.tab_fi700s
   -- %param        pv_trigger_type IN renewal_statement_pack_wp.trigger_type%TYPE
   -- %raises       none
   ********************************************************************************************************/

   PROCEDURE p_reverse_update_fi700_funds(pn_untstm_no IN fi700.untstm_no%TYPE
                                         ,pt_fi700     IN pck_fund_movements.tab_fi700s
                                         ,pv_trigger_type IN renewal_statement_pack_wp.trigger_type%TYPE)
    IS
    BEGIN
       pck_process_info.p_set_action(pv_action_name => 'P_REVERSE_UPDATE_FI700_FUNDS');

       FORALL i IN 1.. pt_fi700.COUNT
           UPDATE fi700 f
               SET    f.untstm_no = pn_untstm_no
                     ,f.staevt    = 80
                     ,f.audupd_id = MOD(f.audupd_id + 1
                                       ,100)
                     ,f.audupddte = lpn_sysdate
                     ,f.audupdtme = lpn_audupdtme
                     ,f.audaplcde = lpt_audit_details(pv_trigger_type).audit_application_code
                     ,f.audstf_no = lpt_audit_details(pv_trigger_type).audit_staff_number
               WHERE  f.polref    = pt_fi700(i).polref
               AND    f.trnctl_no = pt_fi700(i).trnctl_no
               AND    f.trn_no    = pt_fi700(i).trn_no
               AND    f.evtunq    = pt_fi700(i).evtunq
               AND    f.evttrn_no = pt_fi700(i).evttrn_no
               AND    f.duedte    = pt_fi700(i).duedte
               AND    f.staevt    = 70;

   END p_reverse_update_fi700_funds;

    /*******************************************************************************************************
    -- %Description  Procedure to insert the Policies into renewal_statement_pack_wp table
    -- %param        pr_wp_policy      IN   r_wp_policy
    -- %param        pn_sch_rnwdte     IN   po100.actdte%TYPE
    -- %param        pn_unqref         IN   po100.unqref%TYPE
    -- %param        pv_actref         IN   po100.actref%TYPE
    -- %raises       Others
    ********************************************************************************************************/
    PROCEDURE p_insert_rnw_stmt_pck_wp (pr_wp_policy      IN   r_wp_policy
                                       ,pn_sch_rnwdte     IN   po100.actdte%TYPE
                                       ,pn_unqref         IN   po100.unqref%TYPE
                                       ,pv_actref         IN   po100.actref%TYPE)

    IS
        ld_renewal_date renewal_statement_pack_wp.scheme_renewal_date%TYPE;

    BEGIN
        pck_process_info.p_set_action(pv_action_name => 'P_INSERT_RNW_STMT_PCK_WP');

        ld_renewal_date := pck_dates.f_dte_to_oracledate(pn_sch_rnwdte);

        MERGE INTO renewal_statement_pack_wp r
            USING dual
            ON   (r.policy_reference    = pr_wp_policy.polref
            AND   r.scheme_renewal_date = ld_renewal_date
            AND   r.scheme_reference    = pr_wp_policy.cliref
            AND   r.scheme_category     = pr_wp_policy.clicat)
            WHEN MATCHED THEN
                UPDATE SET  r.status           = 5
                           ,r.processed_date   = lpd_system_date
                           ,r.stream           = 0
                           ,r.audit_id         = r.audit_id + 1
                           ,r.error_details    = NULL
                           ,r.po100_unique_ref = pn_unqref
            WHEN NOT MATCHED THEN
                INSERT (renewal_statement_pack_wp_id
                       ,policy_reference
                       ,scheme_reference
                       ,scheme_category
                       ,scheme_sub_category
                       ,scheme_renewal_date
                       ,status
                       ,stream
                       ,shadow_id
                       ,audit_id
                       ,processed_date
                       ,po100_unique_ref
                       ,error_details
                       ,trigger_type)
                VALUES
                       (renewal_stmt_wp_seq.nextval
                       ,pr_wp_policy.polref
                       ,pr_wp_policy.cliref
                       ,pr_wp_policy.clicat
                       ,pr_wp_policy.schsubcat
                       ,ld_renewal_date
                       ,5
                       ,0
                       ,0
                       ,0
                       ,lpd_system_date
                       ,pn_unqref
                       ,NULL
                       ,pv_actref);
    EXCEPTION
        WHEN OTHERS THEN

        -- log error for investigation later
        pck_err.p_handle(pv_err_code => 'ERRMSG'
                        ,pv_add_text => 'Error while inserting into RENEWAL_STATEMENT_PACK_WP'  || CHR(10) ||
                                        'Policy Reference : ' || TO_CHAR(pr_wp_policy.polref)   || CHR(10) ||
                                        'Renewal Date     : ' || TO_CHAR(pn_sch_rnwdte)         || CHR(10) ||
                                        'Scheme Reference : ' || TO_CHAR(pr_wp_policy.cliref)   || CHR(10) ||
                                        'Scheme Category  : ' || TO_CHAR(pr_wp_policy.clicat)   || CHR(10)
                        ,pb_log_err  => TRUE
                        ,pb_re_raise => TRUE);

    END p_insert_rnw_stmt_pck_wp;

    /*******************************************************************************************************
    -- %Description  Procedure to check if the policy has valid funds
    -- %param        pn_polref           IN       po010.polref%TYPE
    -- %param        pv_valid_funds     OUT       VARCHAR2
    -- %raises       None
    ********************************************************************************************************/
    PROCEDURE p_check_valid_funds(pn_polref       IN  po010.polref%TYPE
                                 ,pv_valid_funds OUT  VARCHAR2)
    IS
        CURSOR cu_check_funds(pcn_polref IN po010.polref%TYPE)
        IS
            SELECT 'Y'
            FROM ( SELECT *
                   FROM   co055 c55
                   WHERE  c55.polref   = pcn_polref
                   AND    c55.stastd   = 30
                   AND    c55.maint   <> 'D'
                   AND    c55.benqty1 != 0
                   ORDER BY 1 DESC)
            WHERE rownum = 1;
    BEGIN

        pck_process_info.p_set_action(pv_action_name => 'P_CHECK_VALID_FUNDS');

        pv_valid_funds := 'N';

        OPEN cu_check_funds(pcn_polref => pn_polref);
        FETCH cu_check_funds INTO pv_valid_funds;
        CLOSE cu_check_funds;

    END p_check_valid_funds;

   /*******************************************************************************************************
    -- %Description  Procedure to check if the policy has only GLA funds
    -- %param        pn_polref           IN       po010.polref%TYPE
    -- %param        pv_only_GLA        OUT       VARCHAR2
    -- %raises       None
    ********************************************************************************************************/
    PROCEDURE p_check_only_GLA(pn_polref       IN  po010.polref%TYPE
                              ,pv_only_GLA    OUT  VARCHAR2)
    IS
        CURSOR cu_check_GLA(pcn_polref IN po010.polref%TYPE)
        IS
            SELECT 'N'
            FROM (SELECT 'N'
                  FROM   po030 p3
                  WHERE  p3.polref = pcn_polref
                  AND    p3.maint <> 'D'
                  AND    ((p3.staben  IN (30, 52) AND
                           p3.inrtyp  IN ('AVCS', 'SP', 'TV', 'DSS')) OR
                          (p3.inrref  =   0       AND
                           p3.bentyp  <> 'GLA'    AND
                           p3.inrtyp  IN ('AVCR', 'RVP')))
                  ORDER BY 1 DESC)
             WHERE rownum = 1;

    BEGIN

        pck_process_info.p_set_action(pv_action_name => 'P_CHECK_ONLY_GLA');

        pv_only_GLA := 'Y';

        OPEN cu_check_GLA(pcn_polref => pn_polref);
        FETCH cu_check_GLA INTO pv_only_GLA;
        CLOSE cu_check_GLA;

    END p_check_only_GLA;

    /*******************************************************************************************************
    -- %Description  Procedure to delete the RS-PSTEXC trigger
    -- %param        pn_polref    IN   po100.polref%TYPE
    -- %raises       None
    ********************************************************************************************************/
    PROCEDURE p_delete_pstexc(pn_polref   IN po100.polref%TYPE)
    IS
    BEGIN

        DELETE FROM PO100 p
        WHERE  p.polref = pn_polref
        AND    p.actref = 'RS-PSTEXC'
        AND    p.sta    = 80;

      EXCEPTION
        WHEN OTHERS THEN
        -- log error for investigation later
        pck_err.p_handle(pv_err_code => 'ERRMSG'
                        ,pv_add_text => 'Error while deleting the RS-PSTEXC trigger from po100' || CHR(10) ||
                                        'Policy Reference : ' || TO_CHAR(pn_polref)   || CHR(10)
                        ,pb_log_err  => TRUE
                        ,pb_re_raise => TRUE);


    END p_delete_pstexc;

    /*******************************************************************************************************
    -- %Description  Procedure to get the policies under the scheme which is Live /Pending Exit
    -- %param        pv_clicat      IN     po100.clicat%TYPE
    -- %param        pn_cliref      IN     po100.cliref%TYPE
    -- %param        pn_strdte      IN     po100.actdte%TYPE
    -- %param        pn_enddte      IN     po100.actdte%TYPE
    -- %param        pn_unqref      IN     po100.unqref%TYPE
    -- %param        pv_actref      IN     po100.actref%TYPE
    -- %param        pv_actpar      IN     po100.actpar%TYPE
    -- %raises       None
    ********************************************************************************************************/
    PROCEDURE p_get_policies(pv_clicat     IN  po100.clicat%TYPE
                            ,pn_cliref     IN  po100.cliref%TYPE
                            ,pn_strdte     IN  po100.actdte%TYPE
                            ,pn_enddte     IN  po100.actdte%TYPE
                            ,pn_unqref     IN  po100.unqref%TYPE
                            ,pv_actref     IN  po100.actref%TYPE
                            ,pv_actpar     IN  po100.actpar%TYPE)

    IS
        CURSOR cu_get_policies(pcv_clicat  IN  po100.clicat%TYPE
                              ,pcn_cliref  IN  po100.cliref%TYPE
                              ,pcn_strdte  IN  po100.actdte%TYPE
                              ,pcn_enddte  IN  po100.actdte%TYPE)
        IS

            SELECT c.polref
                  ,c.cliref
                  ,c.clicat
                  ,c.schsubcat
            FROM    co040 c
                   ,po010 p
            WHERE  c.cliref    = pcn_cliref
            AND    c.clicat    = pcv_clicat
            AND    c.rolref    = 'SCH'
            AND    c.staxrf    = 30
            AND    c.maint    <> 'D'
            AND    p.polref    = c.polref
            AND    ((p.stapol  = 30) OR
                    (p.stapol  = 52  AND --Checks if the Pending Exit cases have keyed Death
                     p.extmod != 21))
            AND    p.maint    <> 'D'
            AND    c.strdte   <  pcn_enddte
            AND    c.enddte   >= pcn_strdte
            ORDER BY 1 DESC;

        lv_valid_fund     VARCHAR2(1);
        lv_only_GLA       VARCHAR2(1);
        lt_wp_policy      t_wp_policy;
        ln_row            NUMBER := 0;

    BEGIN
        pck_process_info.p_set_action(pv_action_name => 'P_GET_POLICIES');

        OPEN cu_get_policies(pcv_clicat => pv_clicat
                            ,pcn_cliref => pn_cliref
                            ,pcn_strdte => pn_strdte
                            ,pcn_enddte => pn_enddte);
        LOOP
            FETCH cu_get_policies BULK COLLECT INTO lt_wp_policy LIMIT lpn_bulk_limit;
            EXIT WHEN lt_wp_policy.COUNT =0;

                FOR i IN 1 .. lt_wp_policy.COUNT LOOP

                    -- Delete RS-PSTEXC trigger
                    p_delete_pstexc(pn_polref   => lt_wp_policy(i).polref);

                    -- Check if the policy has valid funds
                    p_check_valid_funds(pn_polref       => lt_wp_policy(i).polref
                                       ,pv_valid_funds  => lv_valid_fund);

                    -- Check if the policy has only GLA
                    p_check_only_GLA(pn_polref   => lt_wp_policy(i).polref
                                    ,pv_only_GLA => lv_only_GLA);

                    -- Inserts into renewal_statement_pack_wp table
                    IF (lv_valid_fund = 'Y' AND lv_only_GLA = 'N') THEN

                        p_insert_rnw_stmt_pck_wp(pr_wp_policy      =>  lt_wp_policy(i)
                                                ,pn_sch_rnwdte     =>  pn_enddte
                                                ,pn_unqref         =>  pn_unqref
                                                ,pv_actref         =>  pv_actref);

                    END IF;

                END LOOP;
            ln_row := NVL(lt_wp_policy.COUNT,0);
        END LOOP;
        CLOSE cu_get_policies;

        IF ln_row > 0  AND pv_clicat = 'CMP' THEN
            --populate summary_scheme_details
            pck_renewal_summary.p_populate_scheme_details(pn_scheme_reference      => pn_cliref
                                                         ,pv_scheme_category       => pv_clicat
                                                         ,pn_scheme_renewal_date   => pn_enddte
                                                         ,pn_previous_renewal_date => pn_strdte
                                                         ,pv_postdocrqd            => SUBSTR(pv_actpar, 65, 1));
        END IF;

    END p_get_policies;

    /*******************************************************************************************************
    -- %Description  Get the renewal date from the Actpar string
    -- %param        pv_actpar              IN     po100.actpar%TYPE
    -- %param        pr_gg242_rnwactpar    OUT     r_gg242_rnwactpar
    -- %raises       None
    ********************************************************************************************************/
    PROCEDURE p_get_po100_actpar_data (pv_actpar            IN   po100.actpar%TYPE
                                      ,pr_gg242_rnwactpar  OUT   r_gg242_rnwactpar)
    IS
    BEGIN

        pck_process_info.p_set_action(pv_action_name => 'P_GET_PO100_ACTPAR_DATA');

        --Split the Po100 actpar fixed length undelimited string into its substrings

        -- Scheme Sub Category
        pr_gg242_rnwactpar.schsubcat  :=  NVL(TRIM(SUBSTR(pv_actpar, 1 ,2)), ' ');

        -- Adjusted Lead Time
        pr_gg242_rnwactpar.adjleatme  :=  NVL(TRIM(SUBSTR(pv_actpar, 3 ,2)), ' ');

        -- Pnt Action Ref
        pr_gg242_rnwactpar.pntactref  :=  NVL(TRIM(SUBSTR(pv_actpar, 5 ,9)), ' ');

        -- Renewal Date
        pr_gg242_rnwactpar.rnwdte     :=  NVL(TRIM(SUBSTR(pv_actpar, 41 ,5)), ' ');

        --  Previous Renewal Date (Only for PSTSCH trigger)
        pr_gg242_rnwactpar.prvrnwdte  :=  NVL(TRIM(SUBSTR(pv_actpar, 46 ,5)), ' ');

    END p_get_po100_actpar_data;

    /*******************************************************************************************************
    -- %Description  Procedure to validate, if the Exception triggers are completed
                     succesfully for the current year
    -- %param        pv_clicat     IN     po100.clicat%TYPE
    -- %param        pn_cliref     IN     po100.cliref%TYPE
    -- %param        pv_rnwdte     IN     po100.actdte%TYPE
    -- %param        pv_excsch     OUT    VARCHAR2
    -- %raises       None
    ********************************************************************************************************/
    PROCEDURE p_check_excsch(pv_clicat   IN   po100.clicat%TYPE
                            ,pn_cliref   IN   po100.cliref%TYPE
                            ,pn_rnwdte   IN   po100.actdte%TYPE
                            ,pv_excsch   OUT  VARCHAR2)
    IS
        CURSOR cu_check_excsch(pcn_cliref   IN  po100.cliref%TYPE
                              ,pcv_clicat   IN  po100.clicat%TYPE
                              ,pcn_rnwdte   IN  po100.actdte%TYPE)
        IS
            SELECT 'Y'
            FROM   po100 p
            WHERE  p.actref             = 'RS-EXCSCH'
            AND    p.cliref             = pcn_cliref
            AND    p.clicat             = pcv_clicat
            AND    p.sta                = 50
            AND    SUBSTR(p.actpar,1,5) = TO_CHAR(pcn_rnwdte);
    BEGIN
        pck_process_info.p_set_action(pv_action_name => 'P_CHECK_EXCSCH');

        pv_excsch := 'N';

        OPEN cu_check_excsch(pcn_cliref => pn_cliref
                            ,pcv_clicat => pv_clicat
                            ,pcn_rnwdte => pn_rnwdte);

        FETCH cu_check_excsch INTO pv_excsch;
        CLOSE cu_check_excsch;

    END p_check_excsch;

    /*******************************************************************************************************
    -- %Description  Procedure to validate, if the full Benefit clear up triggers are completed
                     succesfully for the current year
    -- %param        pv_clicat     IN     po100.clicat%TYPE
    -- %param        pn_cliref     IN     po100.cliref%TYPE
    -- %param        pv_rnwdte     IN     po100.actdte%TYPE
    -- %param        pv_ficsch     OUT    VARCHAR2
    -- %raises       None
    ********************************************************************************************************/
    PROCEDURE p_check_ficsch(pv_clicat    IN  po100.clicat%TYPE
                            ,pn_cliref    IN  po100.cliref%TYPE
                            ,pn_rnwdte    IN  po100.actdte%TYPE
                            ,pv_ficsch    OUT VARCHAR2)
    IS
        CURSOR cu_check_ficsch(pcn_cliref   IN po100.cliref%TYPE
                              ,pcv_clicat   IN po100.clicat%TYPE
                              ,pcn_rnwdte   IN po100.actdte%TYPE)
        IS
            SELECT 'Y'
            FROM   po100 p
            WHERE  p.actref = 'RS-FICSCH'
            AND    p.cliref = pcn_cliref
            AND    p.clicat = pcv_clicat
            AND    p.sta    = 50
            AND    SUBSTR(p.actpar,41,5) =TO_CHAR(pcn_rnwdte);

    BEGIN
        pck_process_info.p_set_action(pv_action_name => 'P_CHECK_FICSCH');

        pv_ficsch := 'N';

        OPEN cu_check_ficsch(pcn_cliref => pn_cliref
                            ,pcv_clicat => pv_clicat
                            ,pcn_rnwdte => pn_rnwdte);

        FETCH cu_check_ficsch INTO pv_ficsch;
        CLOSE cu_check_ficsch;

    END p_check_ficsch;

    /*******************************************************************************************************
    -- %Description  Procedure to check if the Scheme has a latest Outstanding unwind trigger
    -- %param        pv_clicat                     IN     po100.clicat%TYPE
    -- %param        pn_cliref                     IN     po100.cliref%TYPE
    -- %param        pv_pending_unwind_trigger     OUT    VARCHAR2
    ********************************************************************************************************/
    PROCEDURE p_check_unwind_trigger(pn_cliref                  IN  po100.cliref%TYPE
                                    ,pv_clicat                  IN  po100.clicat%TYPE
                                    ,pv_pending_unwind_trigger  OUT VARCHAR2)

    IS
        CURSOR cu_check_unwind(pcn_cliref IN po100.cliref%TYPE
                              ,pcv_clicat IN po100.clicat%TYPE)
        IS
            SELECT sta
            FROM (  SELECT *
                    FROM   po100 p
                    WHERE  p.actref  = 'RS-UWPSCH'
                    AND    p.cliref  = pcn_cliref
                    AND    p.clicat  = pcv_clicat
                    ORDER BY  p.actdte DESC
                             ,p.unqref DESC)
            WHERE rownum =1;

        ln_status  po100.sta%TYPE;

    BEGIN
        pck_process_info.p_set_action(pv_action_name => 'P_CHECK_UNWIND_TRIGGER');

        OPEN cu_check_unwind(pcn_cliref => pn_cliref
                            ,pcv_clicat => pv_clicat);

        FETCH cu_check_unwind INTO ln_status;
        CLOSE cu_check_unwind;

        IF ln_status != 50 THEN
            pv_pending_unwind_trigger := 'Y';
        ELSE
            pv_pending_unwind_trigger := 'N';
        END IF;

    END p_check_unwind_trigger;

   /*******************************************************************************************************
    -- %Description  Function to fetch the Live policy for a Continuation scheme
    -- %param        pv_clicat             IN     po100.clicat%TYPE
    -- %param        pn_cliref             IN     po100.cliref%TYPE
    -- %returns      co040.polref%TYPE
    ********************************************************************************************************/
    FUNCTION f_get_live_cps_policy(pn_cliref   IN  po100.cliref%TYPE
                                  ,pv_clicat   IN  po100.clicat%TYPE)
    RETURN co040.polref%TYPE
    IS
         CURSOR cu_get_live_policy(pcn_cliref IN po100.cliref%TYPE
                                  ,pcv_clicat IN po100.clicat%TYPE)
         IS
            SELECT c.polref
            FROM   co040 c
            WHERE  c.cliref = pcn_cliref
            AND    c.clicat = pcv_clicat
            AND    c.rolref = 'SCH'
            AND    c.maint != 'D'
            AND    c.staxrf = 30;

        ln_polref           co040.polref%TYPE;

    BEGIN

        pck_process_info.p_set_action(pv_action_name => 'F_GET_LIVE_CPS_POLICY');

        OPEN cu_get_live_policy(pcn_cliref => pn_cliref
                               ,pcv_clicat => pv_clicat);
        FETCH cu_get_live_policy INTO ln_polref;
        CLOSE cu_get_live_policy;

        RETURN ln_polref;

    END f_get_live_cps_policy;

    /*******************************************************************************************************
    -- %Description  Function to check if the ITRS is Live for a Continuation scheme
    -- %param        pn_cliref             IN     po100.cliref%TYPE
    -- %param        pv_clicat             IN     po100.clicat%TYPE
    -- %returns      VARCHAR2
    ********************************************************************************************************/
    FUNCTION f_check_cps_itrs(pn_cliref      IN  po100.cliref%TYPE
                             ,pv_clicat      IN  po100.clicat%TYPE)
    RETURN VARCHAR2
    IS
        CURSOR cu_check_itr(pcn_itr_no   IN   cl090.itr_no%TYPE)
        IS
            SELECT 'Y'
            FROM   cl090 c
            WHERE  c.itr_no  = pcn_itr_no
            AND    c.mnt    <> 'D'
            AND    c.enddte >= c.efvdte
            AND    c.enddte >= lpn_sysdate
            AND    c.itrsta  = 30
            AND    ROWNUM    = 1;

        ln_polref       co040.polref%TYPE;
        ln_itr_no       co040.cliref%TYPE;
        lv_valid_itr    VARCHAR2(1) := 'N';
    BEGIN
        pck_process_info.p_set_action(pv_action_name => 'P_CHECK_CPS_ITRS');

        -- Fetch the live policy for the continuation scheme
        ln_polref := f_get_live_cps_policy(pn_cliref => pn_cliref
                                          ,pv_clicat => pv_clicat);
        -- Get the policy's ITR No
        ln_itr_no := pck_policy_details.f_get_policy_adviser(pn_policy => ln_polref
                                                            ,pn_efvdte => lpn_sysdate);

        OPEN cu_check_itr(pcn_itr_no  => ln_itr_no);
        FETCH cu_check_itr INTO lv_valid_itr;
        CLOSE cu_check_itr;

        RETURN lv_valid_itr;

    END f_check_cps_itrs;

    /*******************************************************************************************************
    -- %Description  Procedure to check if the ITRS is Live for a particular scheme
    -- %param        pn_cliref             IN     po100.cliref%TYPE
    -- %param        pv_clicat             IN     po100.clicat%TYPE
    -- %param        pv_valid_itr         OUT     VARCHAR2
    ********************************************************************************************************/
    PROCEDURE p_check_itrs(pn_cliref      IN  po100.cliref%TYPE
                          ,pv_clicat      IN  po100.clicat%TYPE
                          ,pv_valid_itr   OUT VARCHAR2)

    IS
        CURSOR cu_check_itr(pcn_itr_no   IN   cl090.itr_no%TYPE)
        IS
            SELECT 'Y'
            FROM ( SELECT *
                   FROM   cl090 c
                   WHERE  c.itr_no  = pcn_itr_no
                   AND    c.mnt    <> 'D'
                   AND    c.enddte >= c.efvdte
                   AND    c.enddte >= lpn_sysdate
                   AND    c.itrsta  = 30
                   ORDER BY 1 DESC)
            WHERE rownum = 1;

        ln_itr_no        NUMBER;

    BEGIN
        pck_process_info.p_set_action(pv_action_name => 'P_CHECK_ITRS');

        pv_valid_itr := 'N';

        ln_itr_no := pck_scheme_details.f_itr_for_scheme(pn_client_ref => pn_cliref
                                                        ,pv_client_cat => pv_clicat);

        OPEN cu_check_itr(pcn_itr_no  => ln_itr_no);
        FETCH cu_check_itr INTO pv_valid_itr;
        CLOSE cu_check_itr;

    END p_check_itrs;

    /*******************************************************************************************************
    -- %Description  Procedure updates the Po100 PSTSCH trigger to the given status
    -- %param        pn_status    IN  po100.sta%TYPE
    -- %param        pn_cliref    IN  po100.cliref%TYPE
    -- %param        pv_clicat    IN  po100.clicat%TYPE
    -- %param        pn_rnwdte    IN  po100.actdte%TYPE
    -- %param        pn_unqref    IN  po100.unqref%TYPE
    -- %param        pv_actpar    IN  po100.actpar%TYPE
    -- %raises       None
    ********************************************************************************************************/
    PROCEDURE p_update_po100(pn_status  IN  po100.sta%TYPE
                            ,pn_cliref  IN  po100.cliref%TYPE
                            ,pv_clicat  IN  po100.clicat%TYPE
                            ,pn_rnwdte  IN  po100.actdte%TYPE
                            ,pn_unqref  IN  po100.unqref%TYPE
                            ,pv_actpar  IN  po100.actpar%TYPE)
    IS
    BEGIN
        pck_process_info.p_set_action(pv_action_name => 'P_UPDATE_PO100');

        UPDATE po100 p
        SET    p.sta       = pn_status
              ,p.audupd_id = MOD(p.audupd_id + 1,100)
              ,p.audupdtme = lpn_audupdtme
              ,p.audupddte = lpn_sysdate
              ,p.audaplcde = lpt_audit_details('RS-PSTSCH').audit_application_code
              ,p.audstf_no = lpt_audit_details('RS-PSTSCH').audit_staff_number
              ,p.actpar    = pv_actpar
        WHERE  p.cliref    = pn_cliref
        AND    p.clicat    = pv_clicat
        AND    p.unqref    = pn_unqref
        AND    p.actref    = 'RS-PSTSCH'
        AND    SUBSTR(p.actpar, 41, 5) = TO_CHAR(pn_rnwdte);

    EXCEPTION
        WHEN OTHERS THEN
            -- Any unhandled expection occurs
            pck_err.p_handle(pv_err_code      => 'ERRMSG'
                            ,pt_err_param     => pck_err.t_err_param('PCK_SCHEME_RENEWALS.P_UPDATE_PO100')
                            ,pv_subprcss_name => pck_err.f_get_subprocess
                            ,pn_err_occurance => 0
                            ,pv_add_text      => 'Failure in updating PO100'    ||
                                                 'Scheme reference   : ' || TO_CHAR(pn_cliref)   ||
                                                 'Scheme category    : ' || pv_clicat            ||
                                                 'Renewal Date       : ' || TO_CHAR(pn_rnwdte)
                            ,pb_log_err       => TRUE
                            ,pb_re_raise      => FALSE);
    END p_update_po100;

    /*******************************************************************************************************
    -- %Description  Procedure updates the Po100 RS-PST-IP trigger to the given status
    -- %param        pn_status    IN  po100.sta%TYPE
    -- %param        pn_polref    IN  po010.polref%TYPE
    -- %param        pn_cliref    IN  po100.cliref%TYPE
    -- %param        pv_clicat    IN  po100.clicat%TYPE
    -- %param        pn_rnwdte    IN  po100.actdte%TYPE
    -- %param        pn_unqref    IN  po100.unqref%TYPE
    -- %raises       Others
    ********************************************************************************************************/
    PROCEDURE p_update_po100_cimp_ip(pn_status  IN  po100.sta%TYPE
                                    ,pn_polref  IN  po010.polref%TYPE
                                    ,pn_cliref  IN  po100.cliref%TYPE
                                    ,pv_clicat  IN  po100.clicat%TYPE
                                    ,pn_rnwdte  IN  po100.actdte%TYPE
                                    ,pn_unqref  IN  po100.unqref%TYPE)
    IS
    BEGIN
        pck_process_info.p_set_action(pv_action_name => 'P_UPDATE_PO100_CIMP_IP');

        UPDATE po100 p
        SET    p.sta       = pn_status
              ,p.maint     = 'C'
              ,p.enddte    = lpn_sysdate
              ,p.audupd_id = MOD(p.audupd_id + 1,100)
              ,p.audupdtme = lpn_audupdtme
              ,p.audupddte = lpn_sysdate
              ,p.audaplcde = lpt_audit_details('RS-PST-IP').audit_application_code
              ,p.audstf_no = lpt_audit_details('RS-PST-IP').audit_staff_number
        WHERE  p.cliref    = pn_cliref
        AND    p.clicat    = pv_clicat
        AND    p.polref    = pn_polref
        AND    p.unqref    = pn_unqref
        AND    p.actref    = 'RS-PST-IP'
        AND    SUBSTR(p.actpar, 41, 5) = TO_CHAR(pn_rnwdte);

    EXCEPTION
        WHEN OTHERS THEN
            -- Any unhandled expection occurs
            pck_err.p_handle(pv_err_code      => 'ERRMSG'
                            ,pt_err_param     => pck_err.t_err_param('PCK_SCHEME_RENEWALS.P_UPDATE_PO100_CIMP_IP')
                            ,pv_subprcss_name => pck_err.f_get_subprocess
                            ,pn_err_occurance => 0
                            ,pv_add_text      => 'Failure in updating PO100 for'                 ||
                                                 'Policy reference   : ' || TO_CHAR(pn_polref)   ||
                                                 'Scheme reference   : ' || TO_CHAR(pn_cliref)   ||
                                                 'Scheme category    : ' || pv_clicat            ||
                                                 'Renewal Date       : ' || TO_CHAR(pn_rnwdte)
                            ,pb_log_err       => TRUE
                            ,pb_re_raise      => FALSE);
    END p_update_po100_cimp_ip;

   /*******************************************************************************************************
    -- %Description  Function returns if valid policy found on PO010 table
    -- %param        pn_polref  IN  po010.polref%TYPE
    -- %returns      boolean
    -- %raises       None
    ********************************************************************************************************/
    FUNCTION f_is_valid_policy(pn_polref  IN  po010.polref%TYPE)
    RETURN BOOLEAN
    IS
        CURSOR cu_check_valid_policy(pcn_polref IN po010.polref%TYPE)
        IS
            SELECT 1
            FROM   po010  p
            WHERE  ((p.stapol  = 30) OR
                    (p.stapol  = 52  AND --Checks if the Pending Exit cases have keyed Death
                     p.extmod != 21))
            AND    p.maint   <> 'D'
            AND    p.polref   = pcn_polref
            AND    rownum = 1;

        lb_valid_policy    BOOLEAN := FALSE;
        ln_result          PLS_INTEGER;
    BEGIN
        pck_process_info.p_set_action(pv_action_name => 'F_CHECK_VALID_POLICY');

        OPEN cu_check_valid_policy(pcn_polref => pn_polref);
        FETCH cu_check_valid_policy INTO ln_result;

        lb_valid_policy := cu_check_valid_policy%ROWCOUNT > 0;

        CLOSE cu_check_valid_policy;

        RETURN lb_valid_policy;

    END f_is_valid_policy;

   /*******************************************************************************************************
    -- %Description  Function returns scheme sub cat if valid scheme record is found on CO040 table
    -- %param        pn_polref    IN    po010.polref%TYPE
    -- %param        pn_cliref    IN    po100.cliref%TYPE
    -- %param        pv_clicat    IN    po100.clicat%TYPE
    -- %returns      sc010.schsubcat%TYPE
    -- %raises       None
    ********************************************************************************************************/
    FUNCTION f_check_co040(pn_polref  IN  po010.polref%TYPE
                          ,pn_cliref  IN  po100.cliref%TYPE
                          ,pv_clicat  IN  po100.clicat%TYPE)
    RETURN sc010.schsubcat%TYPE
    IS
        CURSOR cu_check_co040(pcn_polref  IN  po010.polref%TYPE
                             ,pcn_cliref  IN  po100.cliref%TYPE
                             ,pcv_clicat  IN  po100.clicat%TYPE)
        IS
            SELECT c.schsubcat
            FROM   co040  c
            WHERE  c.rolref = 'SCH'
            AND    c.polref = pcn_polref
            AND    c.cliref = pcn_cliref
            AND    c.clicat = pcv_clicat
            AND    c.maint <> 'D'
            AND    c.staxrf = 30;

        ln_schsubcat    sc010.schsubcat%TYPE;
    BEGIN
        pck_process_info.p_set_action(pv_action_name => 'F_CHECK_CO040');

        OPEN cu_check_co040(pcn_polref => pn_polref
                           ,pcn_cliref => pn_cliref
                           ,pcv_clicat => pv_clicat);

        FETCH cu_check_co040 INTO ln_schsubcat;

        CLOSE cu_check_co040;

        RETURN ln_schsubcat;

    END f_check_co040;

    /*******************************************************************************************************
    -- %Description  Procedure to delete the RS-PST-IP trigger with status 30 for input policy & renewal date
    -- %param        pn_polref    IN    po010.polref%TYPE
    -- %param        pn_cliref    IN    po100.cliref%TYPE
    -- %param        pv_clicat    IN    po100.clicat%TYPE
    -- %param        pn_rnwdte    IN    po100.actdte%TYPE
    -- %param        pn_unqref    IN    po100.unqref%TYPE
    -- %raises       None
    ********************************************************************************************************/
    PROCEDURE p_delete_live_trigger(pn_polref  IN  po010.polref%TYPE
                                   ,pn_cliref  IN  po100.cliref%TYPE
                                   ,pv_clicat  IN  po100.clicat%TYPE
                                   ,pn_rnwdte  IN  po100.actdte%TYPE
                                   ,pn_unqref  IN  po100.unqref%TYPE)
    IS
    BEGIN

        pck_process_info.p_set_action(pv_action_name => 'P_DELETE_LIVE_TRIGGER');

        DELETE FROM PO100 p
        WHERE  p.polref = pn_polref
        AND    p.cliref = pn_cliref
        AND    p.clicat = pv_clicat
        AND    p.actref = 'RS-PST-IP'
        AND    p.sta    = 30
        AND    p.unqref = pn_unqref
        AND    SUBSTR(p.actpar, 41, 5) = TO_CHAR(pn_rnwdte);

    EXCEPTION
        WHEN OTHERS THEN
        -- log error for investigation later
        pck_err.p_handle(pv_err_code => 'ERRMSG'
                        ,pv_add_text => 'Error while deleting the RS-PST-IP trigger with status 30 from po100' || CHR(10) ||
                                        'Policy Reference : ' || TO_CHAR(pn_polref)                            || CHR(10) ||
                                        'Renewal date : '     || TO_CHAR(pn_rnwdte)
                        ,pb_log_err  => TRUE
                        ,pb_re_raise => TRUE);


    END p_delete_live_trigger;

   /*******************************************************************************************************
    -- %Description  Function returns count of live PO100 RS-PST-IP triggers for policy
    -- %param        pn_polref    IN    po010.polref%TYPE
    -- %param        pn_cliref    IN    po100.cliref%TYPE
    -- %param        pv_clicat    IN    po100.clicat%TYPE
    -- %param        pn_rnwdte    IN    po100.actdte%TYPE
    -- %returns      NUMBER
    -- %raises       None
    ********************************************************************************************************/
    FUNCTION f_count_po100_trigger(pn_polref  IN  po010.polref%TYPE
                                  ,pn_cliref  IN  po100.cliref%TYPE
                                  ,pv_clicat  IN  po100.clicat%TYPE
                                  ,pn_rnwdte  IN  po100.actdte%TYPE)
    RETURN NUMBER
    IS

        CURSOR cu_count_live_trigger_cimp_ip(pcn_polref    IN  po010.polref%TYPE
                                            ,pcn_cliref    IN  po100.cliref%TYPE
                                            ,pcv_clicat    IN  po100.clicat%TYPE
                                            ,pcn_rnwdte    IN  po100.actdte%TYPE)
        IS
            SELECT COUNT(p.polref)
            FROM   po100  p
            WHERE  p.actref   = 'RS-PST-IP'
            AND    p.polref   = pcn_polref
            AND    p.cliref   = pcn_cliref
            AND    p.clicat   = pcv_clicat
            AND    p.maint   != 'D'
            AND    p.sta      = 30
            AND    SUBSTR(p.actpar, 41, 5) = TO_CHAR(pcn_rnwdte);

        ln_count_value    NUMBER;
    BEGIN
        pck_process_info.p_set_action(pv_action_name => 'F_COUNT_PO100_TRIGGER');

        OPEN cu_count_live_trigger_cimp_ip(pcn_polref => pn_polref
                                          ,pcn_cliref => pn_cliref
                                          ,pcv_clicat => pv_clicat
                                          ,pcn_rnwdte => pn_rnwdte);

        FETCH cu_count_live_trigger_cimp_ip INTO ln_count_value;

        CLOSE cu_count_live_trigger_cimp_ip;

        RETURN ln_count_value;

    END f_count_po100_trigger;

   /*******************************************************************************************************
    -- %Description  Function checks if a record exists on renewal_statement_pack_wp table for
                     input policy and renewal date
    -- %param        pn_policy_reference   IN  renewal_statement_pack_wp.policy_reference%TYPE
    -- %param        pn_scheme_reference   IN  renewal_statement_pack_wp.scheme_reference%TYPE
    -- %param        pv_scheme_category    IN  renewal_statement_pack_wp.scheme_category%TYPE
    -- %param        pd_renewal_date       IN  renewal_statement_pack_wp.scheme_renewal_date%TYPE
    -- %param        pv_trigger_type       IN  renewal_statement_pack_wp.trigger_type%TYPE
    -- %returns      VARCHAR2
    -- %raises       None
    ********************************************************************************************************/
    FUNCTION f_check_renewal_stmt_exists(pn_policy_reference   IN  renewal_statement_pack_wp.policy_reference%TYPE
                                        ,pn_scheme_reference   IN  renewal_statement_pack_wp.scheme_reference%TYPE
                                        ,pv_scheme_category    IN  renewal_statement_pack_wp.scheme_category%TYPE
                                        ,pd_renewal_date       IN  renewal_statement_pack_wp.scheme_renewal_date%TYPE
                                        ,pv_trigger_type       IN  renewal_statement_pack_wp.trigger_type%TYPE)
    RETURN VARCHAR2
    IS
        CURSOR cu_check_record_exists(pcn_policy_reference   IN  renewal_statement_pack_wp.policy_reference%TYPE
                                     ,pcn_scheme_reference   IN  renewal_statement_pack_wp.scheme_reference%TYPE
                                     ,pcv_scheme_category    IN  renewal_statement_pack_wp.scheme_category%TYPE
                                     ,pcd_renewal_date       IN  renewal_statement_pack_wp.scheme_renewal_date%TYPE
                                     ,pcv_trigger_type       IN  renewal_statement_pack_wp.trigger_type%TYPE)
        IS
            SELECT 'Y'
            FROM   renewal_statement_pack_wp rspw
            WHERE  rspw.policy_reference    = pcn_policy_reference
            AND    rspw.scheme_reference    = pcn_scheme_reference
            AND    rspw.scheme_category     = pcv_scheme_category
            AND    rspw.scheme_renewal_date = pcd_renewal_date
            AND    rspw.trigger_type        = pcv_trigger_type;

        lv_record_exists  VARCHAR2(1) := 'N';
    BEGIN
        pck_process_info.p_set_action(pv_action_name => 'F_CHECK_RENEWAL_STMT_EXISTS');

        OPEN cu_check_record_exists(pcn_policy_reference  => pn_policy_reference
                                   ,pcn_scheme_reference  => pn_scheme_reference
                                   ,pcv_scheme_category   => pv_scheme_category
                                   ,pcd_renewal_date      => pd_renewal_date
                                   ,pcv_trigger_type      => pv_trigger_type);

        FETCH cu_check_record_exists INTO lv_record_exists;

        CLOSE cu_check_record_exists;

        RETURN lv_record_exists;

    END f_check_renewal_stmt_exists;

    /*******************************************************************************************************
    -- %Description Function to check if a duplicate RS-PST-IP trigger exists for same renewal period
    -- %param       pn_polref   IN   po010.polref%TYPE
    -- %param       pn_cliref   IN   po100.cliref%TYPE
    -- %param       pv_clicat   IN   po100.clicat%TYPE
    -- %param       pn_unqref   IN   po100.unqref%TYPE
    -- %param       pn_rnwdte   IN   po100.actdte%TYPE
    -- %returns     VARCHAR2
    ********************************************************************************************************/
    FUNCTION f_duplicate_trigger_cimp_ip(pn_polref   IN  po010.polref%TYPE
                                        ,pn_cliref   IN  po100.cliref%TYPE
                                        ,pv_clicat   IN  po100.clicat%TYPE
                                        ,pn_unqref   IN  po100.unqref%TYPE
                                        ,pn_rnwdte   IN  po100.actdte%TYPE)
    RETURN VARCHAR2
    IS
        lv_duplicate_po100_exists   VARCHAR2(1) := 'N';
        ln_count_value              NUMBER;
        lv_policy_record_exists     VARCHAR2(1) := 'N';

    BEGIN
        pck_process_info.p_set_action(pv_action_name => 'F_DUPLICATE_TRIGGER_CIMP_IP');

        lv_policy_record_exists := f_check_renewal_stmt_exists(pn_policy_reference  => pn_polref
                                                              ,pn_scheme_reference  => pn_cliref
                                                              ,pv_scheme_category   => pv_clicat
                                                              ,pd_renewal_date      => pck_utility.f_dtcnv(pn_rnwdte)
                                                              ,pv_trigger_type      => 'RS-PST-IP');

        --Check if record already exists on renewal_statement_pack_wp table for renewal date
        IF lv_policy_record_exists != 'Y' THEN
            lv_duplicate_po100_exists := 'N';
        ELSE
            --Check count of live RS-PST-IP triggers
            ln_count_value := f_count_po100_trigger(pn_polref  => pn_polref
                                                   ,pn_cliref  => pn_cliref
                                                   ,pv_clicat  => pv_clicat
                                                   ,pn_rnwdte  => pn_rnwdte);

            IF ln_count_value > 1 THEN

                --Duplicate live RS-PST-IP triggers exist
                lv_duplicate_po100_exists := 'Y';

                --Delete current live RS-PST-IP trigger as record already exist on renewal_statement_pack_wp table
                p_delete_live_trigger(pn_polref => pn_polref
                                     ,pn_cliref => pn_cliref
                                     ,pv_clicat => pv_clicat
                                     ,pn_rnwdte => pn_rnwdte
                                     ,pn_unqref => pn_unqref);
            ELSE
                lv_duplicate_po100_exists := 'N';
            END IF;

        END IF;

        RETURN lv_duplicate_po100_exists;

    END f_duplicate_trigger_cimp_ip;

   /*******************************************************************************************************
    -- %Description  Procedure to validate cimp-ip policy
    -- %param        pn_polref                  IN    po010.polref%TYPE
    -- %param        pn_cliref                  IN    po100.cliref%TYPE
    -- %param        pv_clicat                  IN    po100.clicat%TYPE
    -- %param        pv_actpar                  IN    po100.actpar%TYPE
    -- %param        pn_unqref                  IN    po100.unqref%TYPE
    -- %param        pn_actdte                  IN    po100.actdte%TYPE
    -- %param        pn_schsubcat               OUT   sc010.schsubcat%TYPE
    -- %param        pv_valid_fund              OUT   VARCHAR2
    -- %param        pv_servicing_department    OUT   VARCHAR2
    -- %param        pv_psa_error_flag          OUT   VARCHAR2
    -- %param        pv_process_policy          OUT   VARCHAR2
    -- %param        pv_duplicate_po100_exists  OUT   VARCHAR2
    -- %raises       None
    ********************************************************************************************************/
    PROCEDURE p_validate_cimp_ip_policy(pn_polref                  IN    po100.polref%TYPE
                                       ,pn_cliref                  IN    po100.cliref%TYPE
                                       ,pv_clicat                  IN    po100.clicat%TYPE
                                       ,pv_actpar                  IN    po100.actpar%TYPE
                                       ,pn_unqref                  IN    po100.unqref%TYPE
                                       ,pn_actdte                  IN    po100.actdte%TYPE
                                       ,pn_schsubcat               OUT   sc010.schsubcat%TYPE
                                       ,pv_valid_fund              OUT   VARCHAR2
                                       ,pv_servicing_department    OUT   VARCHAR2
                                       ,pv_psa_error_flag          OUT   VARCHAR2
                                       ,pv_process_policy          OUT   VARCHAR2
                                       ,pv_duplicate_po100_exists  OUT   VARCHAR2)
    IS
    BEGIN
        pck_process_info.p_set_action(pv_action_name => 'P_VALIDATE_CIMP_IP_POLICY');

        pv_process_policy := 'Y';

        --Check if policy is valid
        IF NOT f_is_valid_policy(pn_polref => pn_polref) THEN

            pv_process_policy := 'N';

            --Update PO100 record to 'dead'
            p_update_po100_cimp_ip(pn_status => 60 --dead
                                  ,pn_polref => pn_polref
                                  ,pn_cliref => pn_cliref
                                  ,pv_clicat => pv_clicat
                                  ,pn_rnwdte => SUBSTR(pv_actpar, 41 ,5)
                                  ,pn_unqref => pn_unqref);
        ELSE
            -- Check if scheme is valid
            pn_schsubcat := f_check_co040(pn_polref => pn_polref
                                         ,pn_cliref => pn_cliref
                                         ,pv_clicat => pv_clicat);

            -- Check if the policy has valid funds
            p_check_valid_funds(pn_polref       => pn_polref
                               ,pv_valid_funds  => pv_valid_fund);

            -- Check servicing department exists
            pv_servicing_department := pck_prod_support.f_servicing_department(pn_policy_reference    => pn_polref
                                                                              ,pv_client_category     => NULL
                                                                              ,pn_client_reference    => NULL
                                                                              ,pv_scheme_category     => pv_clicat
                                                                              ,pn_scheme_reference    => pn_cliref
                                                                              ,pn_scheme_sub_category => 0);

            --Check if PSA is not due for policy
            pck_profitshare_queries.p_check_tal_psa_due(pn_policy_reference => pn_polref
                                                       ,pd_renewal_date     => pck_dates.f_dte_to_oracledate(pn_actdte)
                                                       ,pv_error_flag       => pv_psa_error_flag);

            --Check if duplicate po100 trigger exists
            pv_duplicate_po100_exists := f_duplicate_trigger_cimp_ip(pn_polref => pn_polref
                                                                    ,pn_cliref => pn_cliref
                                                                    ,pv_clicat => pv_clicat
                                                                    ,pn_unqref => pn_unqref
                                                                    ,pn_rnwdte => SUBSTR(pv_actpar, 41 ,5));

        END IF;

    END p_validate_cimp_ip_policy;

    /*******************************************************************************************************
    -- %Description  Procedure fetches all the CIMP-IP policies that are eligible for post renewal processing
    -- %param        None
    -- %raises       Others
    ********************************************************************************************************/
    PROCEDURE p_eligible_cimp_ip_policies
    IS

        CURSOR cu_eligible_cimp_ip_policies(pcn_leadte IN po100.actdte%TYPE)
        IS
            SELECT  p100.polref
                   ,p100.cliref
                   ,p100.clicat
                   ,p100.actdte
                   ,p100.actpar
                   ,p100.unqref
                   ,p100.actref
            FROM   po100  p100
            WHERE  p100.actref    = 'RS-PST-IP'
            AND    p100.maint    <> 'D'
            AND    p100.sta       = 30
            AND    p100.actpar   != ' '
            AND    p100.actdte   <= pcn_leadte;

        lt_eligible_cimp_ip_policies    t_eligible_cimp_ip_policies;
        ln_lead_date                    po100.actdte%TYPE;
        lt_wp_policy                    t_wp_policy;
        ln_schsubcat                    sc010.schsubcat%TYPE;
        lv_servicing_department         cl570.loccde%TYPE;
        lv_valid_fund                   VARCHAR2(1);
        lv_process_policy               VARCHAR2(1);
        lv_psa_error_flag               VARCHAR2(1);
        lv_duplicate_po100_exists       VARCHAR2(1);

    BEGIN
        pck_process_info.p_register_module(pv_module_name => LPCV_PACKAGE_NAME
                                          ,pv_action_name => 'P_ELIGIBLE_CIMP_IP_POLICIES');

        -- Calculate the adjusted lead time for renewals using lead time for RS-PST-IP trigger
        ln_lead_date := lpn_sysdate + pck_ir_reviews.f_lead_time(pv_activity_reference => 'RS-PST-IP');

        OPEN cu_eligible_cimp_ip_policies(pcn_leadte => ln_lead_date);
        LOOP
            FETCH cu_eligible_cimp_ip_policies BULK COLLECT INTO lt_eligible_cimp_ip_policies LIMIT lpn_bulk_limit;
            EXIT WHEN lt_eligible_cimp_ip_policies.COUNT =0;

            FOR i IN 1.. lt_eligible_cimp_ip_policies.LAST LOOP
            BEGIN

                --validate cimp-ip policy
                p_validate_cimp_ip_policy(pn_polref                  => lt_eligible_cimp_ip_policies(i).polref
                                         ,pn_cliref                  => lt_eligible_cimp_ip_policies(i).cliref
                                         ,pv_clicat                  => lt_eligible_cimp_ip_policies(i).clicat
                                         ,pv_actpar                  => lt_eligible_cimp_ip_policies(i).actpar
                                         ,pn_unqref                  => lt_eligible_cimp_ip_policies(i).unqref
                                         ,pn_actdte                  => lt_eligible_cimp_ip_policies(i).actdte
                                         ,pn_schsubcat               => ln_schsubcat
                                         ,pv_valid_fund              => lv_valid_fund
                                         ,pv_servicing_department    => lv_servicing_department
                                         ,pv_psa_error_flag          => lv_psa_error_flag
                                         ,pv_process_policy          => lv_process_policy
                                         ,pv_duplicate_po100_exists  => lv_duplicate_po100_exists);

                --If all flags are correct then process the policy
                IF lv_process_policy                   ||
                   lv_psa_error_flag                   ||
                   lv_valid_fund                       ||
                   lv_duplicate_po100_exists  = 'YNYN' AND
                   lv_servicing_department   != ' '    AND
                   ln_schsubcat IS NOT NULL THEN

                    lt_wp_policy(i).schsubcat := ln_schsubcat;
                    lt_wp_policy(i).polref    := lt_eligible_cimp_ip_policies(i).polref;
                    lt_wp_policy(i).cliref    := lt_eligible_cimp_ip_policies(i).cliref;
                    lt_wp_policy(i).clicat    := lt_eligible_cimp_ip_policies(i).clicat;

                    -- Inserts into renewal_statement_pack_wp table
                    p_insert_rnw_stmt_pck_wp(pr_wp_policy   => lt_wp_policy(i)
                                            ,pn_sch_rnwdte  => SUBSTR(lt_eligible_cimp_ip_policies(i).actpar, 41 ,5)
                                            ,pn_unqref      => lt_eligible_cimp_ip_policies(i).unqref
                                            ,pv_actref      => lt_eligible_cimp_ip_policies(i).actref);

                END IF;

            EXCEPTION
                WHEN OTHERS THEN
                    -- Any unhandled expection occurs
                    pck_err.p_handle(pv_err_code      => 'ERRMSG'
                                    ,pt_err_param     => pck_err.t_err_param('PCK_SCHEME_RENEWALS.P_ELIGIBLE_CIMP_IP_POLICIES')
                                    ,pv_subprcss_name => pck_err.f_get_subprocess
                                    ,pn_err_occurance => 0
                                    ,pv_add_text      => 'Policy failed while fetching eligible cimp-ip policies: '                ||
                                                         'Policy reference  : ' || TO_CHAR(lt_eligible_cimp_ip_policies(i).polref) ||
                                                         'Scheme reference  : ' || TO_CHAR(lt_eligible_cimp_ip_policies(i).cliref) ||
                                                         'Scheme category   : ' || TO_CHAR(lt_eligible_cimp_ip_policies(i).clicat) ||
                                                         'Renewal Date      : ' || SUBSTR(lt_eligible_cimp_ip_policies(i).actpar, 41 ,5)
                                    ,pb_log_err       => TRUE
                                    ,pb_re_raise      => FALSE);

            END;
            END LOOP;
        END LOOP;
        CLOSE cu_eligible_cimp_ip_policies;

    EXCEPTION
        WHEN OTHERS THEN
            pck_err.p_handle (pv_err_code => 'ERRMSG'
                             ,pv_add_text => 'Error while executing procedure pck_scheme_renewals.p_eligible_cimp_ip_policies'
                             ,pb_log_err  => TRUE
                             ,pb_re_raise => FALSE);

    END p_eligible_cimp_ip_policies;

    /*******************************************************************************************************
    -- %Description Function to check if a duplicate RS-PSTSCH trigger exists for same renewal period
    -- %param       pn_schref      IN   sc010.schref%TYPE
    -- %param       pv_schcat      IN   sc010.schcat%TYPE
    -- %param       pn_rnwdte      IN   po100.actdte%TYPE
    -- %param       pn_prvrnwdte   IN   po100.actdte%TYPE
    -- %returns     VARCHAR2
    ********************************************************************************************************/
    FUNCTION f_duplicate_trigger(pn_schref     IN  sc010.schref%TYPE
                                ,pv_schcat     IN  sc010.schcat%TYPE
                                ,pn_rnwdte     IN  po100.actdte%TYPE
                                ,pn_prvrnwdte  IN  po100.actdte%TYPE)
    RETURN VARCHAR2
    IS
        CURSOR cu_duplicate_trigger(pcn_schref    IN  sc010.schref%TYPE
                                   ,pcv_schcat    IN  sc010.schcat%TYPE
                                   ,pcn_rnwdte    IN  po100.actdte%TYPE
                                   ,pcn_prvrnwdte IN  po100.actdte%TYPE)
        IS
            SELECT COUNT(p.polref)
            FROM   po100  p
            WHERE  p.actref   = 'RS-PSTSCH'
            AND    p.cliref   = pcn_schref
            AND    p.clicat   = pcv_schcat
            AND    p.maint   != 'D'
            AND    SUBSTR(p.actpar, 41, 5) = TO_CHAR(pcn_rnwdte)
            AND    SUBSTR(p.actpar, 46 ,5) = TO_CHAR(pcn_prvrnwdte);

        lv_duplicate_po100_exists   VARCHAR2(1) := 'N';
        ln_value                    NUMBER;

    BEGIN
        pck_process_info.p_set_action(pv_action_name => 'F_DUPLICATE_TRIGGER');

        OPEN cu_duplicate_trigger(pcn_schref    => pn_schref
                                 ,pcv_schcat    => pv_schcat
                                 ,pcn_rnwdte    => pn_rnwdte
                                 ,pcn_prvrnwdte => pn_prvrnwdte);

        FETCH cu_duplicate_trigger INTO ln_value;

        IF ln_value > 1 THEN
            lv_duplicate_po100_exists := 'Y';
        END IF;

        CLOSE cu_duplicate_trigger;

        RETURN lv_duplicate_po100_exists;

    END f_duplicate_trigger;

    /*******************************************************************************************************
    -- %Description Function to check for a completed unwind trigger for the renewal period
    -- %param       pn_schref      IN   sc010.schref%TYPE
    -- %param       pv_schcat      IN   sc010.schcat%TYPE
    -- %param       pn_rnwdte      IN   po100.actdte%TYPE
    -- %param       pn_prvrnwdte   IN   po100.actdte%TYPE
    -- %returns     VARCHAR2
    ********************************************************************************************************/
    FUNCTION f_unwind_trigger(pn_schref     IN  sc010.schref%TYPE
                             ,pv_schcat     IN  sc010.schcat%TYPE
                             ,pn_rnwdte     IN  po100.actdte%TYPE
                             ,pn_prvrnwdte  IN  po100.actdte%TYPE)
    RETURN VARCHAR2
    IS
        CURSOR cu_unwind_trigger(pcn_schref    IN sc010.schref%TYPE
                                ,pcv_schcat    IN sc010.schcat%TYPE
                                ,pcn_rnwdte    IN po100.actdte%TYPE
                                ,pcn_prvrnwdte IN po100.actdte%TYPE)
        IS
            SELECT 'Y'
            FROM   po100  p
            WHERE  p.actref   = 'RS-UWPSCH'
            AND    p.sta      = 50
            AND    p.cliref   = pcn_schref
            AND    p.clicat   = pcv_schcat
            AND    p.maint   != 'D'
            AND    SUBSTR(p.actpar, 41, 5) = TO_CHAR(pcn_rnwdte)
            AND    SUBSTR(p.actpar, 46 ,5) = TO_CHAR(pcn_prvrnwdte);

        lv_po100_duplicate_and_unwind VARCHAR2(1) := 'D';

    BEGIN
        pck_process_info.p_set_action(pv_action_name => 'F_UNWIND_TRIGGER');

        OPEN cu_unwind_trigger(pcn_schref    => pn_schref
                              ,pcv_schcat    => pv_schcat
                              ,pcn_rnwdte    => pn_rnwdte
                              ,pcn_prvrnwdte => pn_prvrnwdte);

        FETCH cu_unwind_trigger INTO lv_po100_duplicate_and_unwind;

        CLOSE cu_unwind_trigger;

        -- Return 'D' = Duplicate without unwind
        --        'Y' = Valid Duplicate as it has an unwind
        RETURN lv_po100_duplicate_and_unwind;

    END f_unwind_trigger;

    /*******************************************************************************************************
    -- %Description  Check if the Scheme is valid
    -- %param        pn_cliref             IN     po100.cliref%TYPE
    -- %param        pv_clicat             IN     po100.clicat%TYPE
    -- %param        pn_rnwdte             IN     po100.actdte%TYPE
    -- %param        pn_prvrnwdte          IN     po100.actdte%TYPE
    -- %param        pv_scheme_valid       OUT    VARCHAR2
    ********************************************************************************************************/
    PROCEDURE p_check_is_scheme_valid(pn_cliref         IN po100.cliref%TYPE
                                     ,pv_clicat         IN po100.clicat%TYPE
                                     ,pn_rnwdte         IN po100.actdte%TYPE
                                     ,pn_prvrnwdte      IN  po100.actdte%TYPE
                                     ,pv_scheme_valid   OUT VARCHAR2)

    IS
        lv_valid_itr               VARCHAR2(1) := 'N';
        lv_excsch_trigger          VARCHAR2(1) := 'N';
        lv_ficsch_trigger          VARCHAR2(1) := 'N';
        lv_cps_scheme              VARCHAR2(1) := 'N';
        lv_duplicate_po100_exists  VARCHAR2(1) := 'N';

    BEGIN

        pck_process_info.p_set_action(pv_action_name => 'P_CHECK_IS_SCHEME_VALID');

        pv_scheme_valid := 'N';

        lv_cps_scheme := pck_scheme_details.f_continuation_scheme(pv_scheme_category  => pv_clicat
                                                                 ,pn_scheme_reference => pn_cliref);

        IF lv_cps_scheme ='Y' THEN
            -- Check if the scheme has Valid ITR
            lv_valid_itr := f_check_cps_itrs(pn_cliref    =>  pn_cliref
                                            ,pv_clicat    =>  pv_clicat);

            IF lv_valid_itr = 'Y' THEN
                -- Check if Full Benefit Clearup is Complete
                 p_check_ficsch (pv_clicat         => pv_clicat
                                ,pn_cliref         => pn_cliref
                                ,pn_rnwdte         => pn_rnwdte
                                ,pv_ficsch         => pv_scheme_valid );
            END IF;
        ELSE
            -- Check if the scheme has Valid ITR
            p_check_itrs(pn_cliref    =>  pn_cliref
                        ,pv_clicat    =>  pv_clicat
                        ,pv_valid_itr =>  lv_valid_itr);

            IF lv_valid_itr = 'Y' THEN
                -- Check if Exception triggers is complete
                p_check_excsch (pv_clicat        => pv_clicat
                               ,pn_cliref        => pn_cliref
                               ,pn_rnwdte        => pn_rnwdte
                               ,pv_excsch        => lv_excsch_trigger);

                -- Check if Full Benefit Clearup is Complete
                p_check_ficsch (pv_clicat         => pv_clicat
                               ,pn_cliref         => pn_cliref
                               ,pn_rnwdte         => pn_rnwdte
                               ,pv_ficsch         => lv_ficsch_trigger);
            END IF;

            IF lv_excsch_trigger = 'Y' AND lv_ficsch_trigger = 'Y' THEN
                pv_scheme_valid := 'Y';
            END IF;
        END IF;
        -- Check for erroneous duplicate PO100 record that does not have a corresponding unwind trigger?
        IF pv_scheme_valid = 'Y' THEN
            -- Check if we have a duplicate po100 trigger, so that we can skip these ones
            lv_duplicate_po100_exists := f_duplicate_trigger(pn_schref    => pn_cliref
                                                            ,pv_schcat    => pv_clicat
                                                            ,pn_rnwdte    => pn_rnwdte
                                                            ,pn_prvrnwdte => pn_prvrnwdte);
            IF lv_duplicate_po100_exists = 'Y' THEN
                -- Check if we don't have a completed unwind trigger corresponding to the renewal period
                pv_scheme_valid := f_unwind_trigger(pn_schref    => pn_cliref
                                                   ,pv_schcat    => pv_clicat
                                                   ,pn_rnwdte    => pn_rnwdte
                                                   ,pn_prvrnwdte => pn_prvrnwdte);
            END IF;
        END IF;
    -- Send back pv_scheme_valid values as:-
    -- 'D' Invalid as a duplicate has been found without a corresponding unwind
    -- 'Y' Valid
    -- 'N' Invalid
    END p_check_is_scheme_valid;

  /*******************************************************************************************************
    -- %Description Procedure to extract renewal dates and ajustment dates
    -- %param       pv_actpar      IN    po100.actpar%TYPE
    -- %param       pn_actdte      IN    po100.actdte%TYPE
    -- %param       pn_fulleadtme  IN    NUMBER
    -- %param       pn_rnwdte      OUT   po100.actdte%TYPE
    -- %param       pn_prvrnwdte   OUT   po100.actdte%TYPE
    -- %param       pn_adjdte      OUT   NUMBER
    ********************************************************************************************************/
    PROCEDURE p_extract_dates(pv_actpar      IN   po100.actpar%TYPE
                             ,pn_actdte      IN   po100.actdte%TYPE
                             ,pn_fulleadtme  IN   NUMBER
                             ,pn_rnwdte      OUT  po100.actdte%TYPE
                             ,pn_prvrnwdte   OUT  po100.actdte%TYPE
                             ,pn_adjdte      OUT  NUMBER)

    IS
        lr_gg242_rnwactpar   r_gg242_rnwactpar;
    BEGIN

        pck_process_info.p_set_action(pv_action_name => 'P_EXTRACT_DATES');

        p_get_po100_actpar_data(pv_actpar           =>  pv_actpar
                               ,pr_gg242_rnwactpar  =>  lr_gg242_rnwactpar);

        pn_rnwdte    := lr_gg242_rnwactpar.rnwdte;
        pn_prvrnwdte := lr_gg242_rnwactpar.prvrnwdte;

        pn_adjdte := pn_actdte - pn_fulleadtme;
        pn_adjdte := pn_adjdte + lr_gg242_rnwactpar.adjleatme;

    END p_extract_dates;
    /*******************************************************************************************************
    -- %Description Process polices in given scheme
    -- %param       pv_scheme_valid IN VARCHAR2
    -- %param       pv_clicat       IN  po100.clicat%TYPE
    -- %param       pn_cliref       IN  po100.cliref%TYPE
    -- %param       pn_rnwdte       IN  po100.actdte%TYPE
    -- %param       pn_prvrnwdte    IN  po100.actdte%TYPE
    -- %param       pn_unqref       IN  po100.unqref%TYPE
    -- %param       pv_actpar       IN  po100.actpar%TYPE
    -- %param       pv_actref       IN  po100.actref%TYPE)
    ********************************************************************************************************/
    PROCEDURE p_process_policies(pv_scheme_valid IN  VARCHAR2
                                ,pv_clicat       IN  po100.clicat%TYPE
                                ,pn_cliref       IN  po100.cliref%TYPE
                                ,pn_rnwdte       IN  po100.actdte%TYPE
                                ,pn_prvrnwdte    IN  po100.actdte%TYPE
                                ,pn_unqref       IN  po100.unqref%TYPE
                                ,pv_actpar       IN  po100.actpar%TYPE
                                ,pv_actref       IN  po100.actref%TYPE)
    IS
    BEGIN

        pck_process_info.p_set_action(pv_action_name => 'P_PROCESS_POLICIES');

        IF pv_scheme_valid = 'Y' THEN
            -- The scheme is valid so get all the live policies under the scheme
            p_get_policies(pv_clicat => pv_clicat
                          ,pn_cliref => pn_cliref
                          ,pn_strdte => pn_prvrnwdte
                          ,pn_enddte => pn_rnwdte
                          ,pn_unqref => pn_unqref
                          ,pv_actref => pv_actref
                          ,pv_actpar => pv_actpar);
        END IF;

        IF pv_scheme_valid = 'D' THEN
            -- The scheme is invalid as it has a duplicate Po100 record
            -- Lets complete that rogue duplicate record in order to
            -- prevent it being checked again next time
            p_update_po100(pn_status  =>  55
                          ,pn_cliref  =>  pn_cliref
                          ,pv_clicat  =>  pv_clicat
                          ,pn_rnwdte  =>  pn_rnwdte
                          ,pn_unqref  =>  pn_unqref
                          ,pv_actpar  =>  pv_actpar);
        END IF;

       -- Where pv_scheme_valid is 'N' then it is NOT valid so we ignore
    END p_process_policies;

    /*******************************************************************************************************
    -- %Description Process eligible schemes
    -- %param       pn_cliref     IN  po100.cliref%TYPE
    -- %param       pv_clicat     IN  po100.clicat%TYPE
    -- %param       pn_rnwdte     IN  po100.actdte%TYPE
    -- %param       pn_prvrnwdte  IN  po100.actdte%TYPE
    -- %param       pn_unqref     IN  po100.unqref%TYPE
    -- %param       pv_actpar     IN  po100.actpar%TYPE
    -- %param       pv_actref     IN  po100.actref%TYPE
    ********************************************************************************************************/
    PROCEDURE p_process_eligible_schemes(pn_cliref     IN  po100.cliref%TYPE
                                        ,pn_clicat     IN  po100.clicat%TYPE
                                        ,pn_rnwdte     IN  po100.actdte%TYPE
                                        ,pn_prvrnwdte  IN  po100.actdte%TYPE
                                        ,pn_unqref     IN  po100.unqref%TYPE
                                        ,pv_actpar     IN  po100.actpar%TYPE
                                        ,pv_actref     IN  po100.actref%TYPE)
    IS
        lv_scheme_valid   VARCHAR2(1);
    BEGIN
        pck_process_info.p_set_action(pv_action_name => 'P_PROCESS_ELIGIBLE_SCHEMES');

        --check if scheme is valid
        p_check_is_scheme_valid(pn_cliref        => pn_cliref
                               ,pv_clicat        => pn_clicat
                               ,pn_rnwdte        => pn_rnwdte
                               ,pn_prvrnwdte     => pn_prvrnwdte
                               ,pv_scheme_valid  => lv_scheme_valid);

        p_process_policies(pv_scheme_valid => lv_scheme_valid
                          ,pv_clicat       => pn_clicat
                          ,pn_cliref       => pn_cliref
                          ,pn_rnwdte       => pn_rnwdte
                          ,pn_prvrnwdte    => pn_prvrnwdte
                          ,pn_unqref       => pn_unqref
                          ,pv_actpar       => pv_actpar
                          ,pv_actref       => pv_actref);

    END p_process_eligible_schemes;

    /*******************************************************************************************************
    -- %Description  Procedure fetches all the schemes that are eligible for post renewal processing
    -- %param        None
    -- %raises       Others
    ********************************************************************************************************/
    PROCEDURE p_eligible_schemes
    IS

        CURSOR cu_eligible_schemes(pcn_ctfdte IN po100.actdte%TYPE)
        IS
            SELECT  p.cliref
                   ,p.clicat
                   ,p.actdte
                   ,p.sta
                   ,p.actpar
                   ,p.unqref
                   ,p.actref
            FROM   po100  p, sc010 s
            WHERE  p.actref    = 'RS-PSTSCH'
            AND    p.sta      IN (30, 35)
            AND    p.clicat   IN ('RGP', 'SHR', 'CMP')
            AND    s.schref    = p.cliref
            AND    s.schcat    = p.clicat
            AND    s.stapol    = 30
            AND    s.maint    <> 'D'
            AND    s.schsubcat =  0
            AND    p.maint    <> 'D'
            AND    s.strdte   <= pcn_ctfdte
            AND    s.enddte    = 99999
            AND    p.actdte   <= pcn_ctfdte
            ORDER BY 1 DESC;

        lt_eligible_schemes        t_eligible_schemes;
        ln_rnwdte                  po100.actdte%TYPE;
        ln_prvrnwdte               po100.actdte%TYPE;
        ln_adjdte                  NUMBER;
        ln_fulleadtme              NUMBER;
        ln_fulctfdte               NUMBER;
        lv_pending_unwind_trigger  VARCHAR2(1);

    BEGIN

        pck_process_info.p_register_module(pv_module_name => LPCV_PACKAGE_NAME
                                          ,pv_action_name => 'P_ELIGIBLE_SCHEMES');

        -- Calculate the adjusted lead time for full renewals
        ln_fulleadtme := lpn_sysdate + pck_ir_reviews.f_lead_time(pv_activity_reference => 'RS-PSTSCH');

        --Derive activity read cut off dates (max po100 lead adjustment is 8 days)
        ln_fulctfdte := ln_fulleadtme + 9;

        OPEN cu_eligible_schemes(pcn_ctfdte => ln_fulctfdte);
        LOOP
            FETCH cu_eligible_schemes BULK COLLECT INTO lt_eligible_schemes LIMIT lpn_bulk_limit;
            EXIT WHEN lt_eligible_schemes.COUNT =0;

            FOR i IN 1.. lt_eligible_schemes.LAST LOOP
            BEGIN
                -- Fetch the Exact renewal Date from PO100 actpar, since po100 actdte is inserted with sysdte
                -- instead of actual renewal date from UT1153
                p_extract_dates(pv_actpar      => lt_eligible_schemes(i).actpar
                               ,pn_actdte      => lt_eligible_schemes(i).actdte
                               ,pn_fulleadtme  => ln_fulleadtme
                               ,pn_rnwdte      => ln_rnwdte
                               ,pn_prvrnwdte   => ln_prvrnwdte
                               ,pn_adjdte      => ln_adjdte);

                --Only process if the activity date preceeds the new lead date
                --(today + lead time - lead time adjustment)
                IF ln_adjdte <= lpn_sysdate THEN

                    -- If the status is 35(unwound) check if any existing unwound trigger is outstanding
                    IF lt_eligible_schemes(i).sta = 35 THEN
                        p_check_unwind_trigger(pn_cliref                 => lt_eligible_schemes(i).cliref
                                              ,pv_clicat                 => lt_eligible_schemes(i).clicat
                                              ,pv_pending_unwind_trigger => lv_pending_unwind_trigger);
                    END IF;

                    -- If an outstanding unwound trigger should break, if not process further
                    IF lt_eligible_schemes(i).sta = 30 OR lv_pending_unwind_trigger = 'N' THEN

                        p_process_eligible_schemes(pn_cliref     => lt_eligible_schemes(i).cliref
                                                  ,pn_clicat     => lt_eligible_schemes(i).clicat
                                                  ,pn_rnwdte     => ln_rnwdte
                                                  ,pn_prvrnwdte  => ln_prvrnwdte
                                                  ,pn_unqref     => lt_eligible_schemes(i).unqref
                                                  ,pv_actpar     => lt_eligible_schemes(i).actpar
                                                  ,pv_actref     => lt_eligible_schemes(i).actref);

                    END IF;
                END IF;

            EXCEPTION
                WHEN OTHERS THEN
                    -- Any unhandled expection occurs
                    pck_err.p_handle(pv_err_code      => 'ERRMSG'
                                    ,pt_err_param     => pck_err.t_err_param('PCK_SCHEME_RENEWALS.P_ELIGIBLE_SCHEMES')
                                    ,pv_subprcss_name => pck_err.f_get_subprocess
                                    ,pn_err_occurance => 0
                                    ,pv_add_text      => 'Scheme failed while fetching eligible schemes ' ||
                                                         'Scheme category   : ' || TO_CHAR(lt_eligible_schemes(i).clicat) ||
                                                         'Scheme reference  : ' || TO_CHAR(lt_eligible_schemes(i).cliref) ||
                                                         'Renewal Date      : ' || TO_CHAR(ln_rnwdte)
                                    ,pb_log_err       => TRUE
                                    ,pb_re_raise      => FALSE);

            END;
            END LOOP;
        END LOOP;
        CLOSE cu_eligible_schemes;

    EXCEPTION
        WHEN OTHERS THEN
            pck_err.p_handle (pv_err_code => 'ERRMSG'
                             ,pv_add_text => 'Error while executing procedure pck_scheme_renewals.p_eligible_schemes'
                             ,pb_log_err  => TRUE
                             ,pb_re_raise => FALSE);

    END p_eligible_schemes;

    /*******************************************************************************************************
    -- %Description  Procedure creates new actpar string required for PO100 Exception creation
    -- %param        pv_actpar       IN  po100.actpar%TYPE
    -- %param        pn_unqref       IN  po100.unqref%TYPE
    -- %param        pv_trigger_type IN  renewal_statement_pack_wp.trigger_type%TYPE
    -- %param        pv_newactpar    OUT po100.actpar%TYPE
    -- %raises       None
    ********************************************************************************************************/
    PROCEDURE p_create_actpar(pv_actpar       IN   po100.actpar%TYPE
                             ,pn_unqref       IN   po100.unqref%TYPE
                             ,pv_trigger_type IN   renewal_statement_pack_wp.trigger_type%TYPE
                             ,pv_newactpar    OUT  po100.actpar%TYPE)
    IS
        ln_schsubcat  co040.schsubcat%TYPE := 00;
        ln_leadtime   po105.actleatme%TYPE := 00;
        lv_substr     po100.actpar%TYPE;
    BEGIN
        pck_process_info.p_set_action(pv_action_name => 'P_CREATE_ACTPAR');

        ln_leadtime  := pck_ir_reviews.f_lead_time('RS-PSTEXC');

        lv_substr    := SUBSTR(pv_actpar,21);

        pv_newactpar := TO_CHAR(LPAD(ln_schsubcat, 2, '00'))   ||
                        TO_CHAR(LPAD(ln_leadtime, 2, '00'))    ||
                        pv_trigger_type                        ||
                        TO_CHAR(LPAD(pn_unqref, 7, '0000000')) ||
                        lv_substr;

    END p_create_actpar;

   /*******************************************************************************************************
   -- %Description  Function returns the actpar string for th given clire, clicat and renewal date
    -- %param        pn_cliref    IN  po100.cliref%TYPE
    -- %param        pv_clicat    IN  po100.clicat%TYPE
    -- %param        pn_rnwdte    IN  po100.actdte%TYPE
    -- %param        pn_unqref    IN  po100.unqref%TYPE
    -- %returns      po100.actpar%TYPE
    -- %raises       OTHERS
    ********************************************************************************************************/
    FUNCTION f_get_PSTSCH_details (pn_cliref  IN po100.cliref%TYPE
                                  ,pv_clicat  IN po100.clicat%TYPE
                                  ,pn_rnwdte  IN po100.actdte%TYPE
                                  ,pn_unqref  IN po100.unqref%TYPE)
    RETURN po100.actpar%TYPE
    IS
        CURSOR cu_get_PSTSCH_details(pcn_cliref IN po100.cliref%TYPE
                                    ,pcv_clicat IN po100.clicat%TYPE
                                    ,pcn_rnwdte IN po100.actdte%TYPE
                                    ,pcn_unqref IN po100.unqref%TYPE)
        IS
            SELECT p.actpar
            FROM   po100 p
            WHERE  p.cliref              = pcn_cliref
            AND    p.clicat              = pcv_clicat
            AND    p.actref              = 'RS-PSTSCH'
            AND    SUBSTR(p.actpar,41,5) = TO_CHAR(pcn_rnwdte)
            AND    p.unqref              = pcn_unqref;

        lv_actpar     po100.actpar%TYPE;
    BEGIN

        pck_process_info.p_register_module(pv_module_name => LPCV_PACKAGE_NAME
                                          ,pv_action_name => 'F_GET_PSTSCH_DETAILS');

        OPEN cu_get_PSTSCH_details(pcn_cliref => pn_cliref
                                  ,pcv_clicat => pv_clicat
                                  ,pcn_rnwdte => pn_rnwdte
                                  ,pcn_unqref => pn_unqref);

        FETCH cu_get_PSTSCH_details INTO lv_actpar;
        CLOSE cu_get_PSTSCH_details;
        RETURN lv_actpar;

    EXCEPTION
        WHEN OTHERS THEN
            -- Any unhandled expection occurs
            pck_err.p_handle(pv_err_code      => 'ERRMSG'
                            ,pt_err_param     => pck_err.t_err_param('PCK_SCHEME_RENEWALS.F_GET_PSTSCH_DETAILS')
                            ,pv_subprcss_name => pck_err.f_get_subprocess
                            ,pn_err_occurance => 0
                            ,pv_add_text      => 'Failure in fetching PSTSCH trigger details'    ||
                                                 'Scheme reference   : ' || TO_CHAR(pn_cliref)   ||
                                                 'Scheme category    : ' || pv_clicat            ||
                                                 'Renewal Date       : ' || TO_CHAR(pn_rnwdte)
                            ,pb_log_err       => TRUE
                            ,pb_re_raise      => FALSE);

    END f_get_PSTSCH_details;

   /*******************************************************************************************************
   -- %Description  Function returns the actpar string for th given polref, cliref, clicat and renewal date
    -- %param        pn_polref    IN  po010.polref%TYPE
    -- %param        pn_cliref    IN  po100.cliref%TYPE
    -- %param        pv_clicat    IN  po100.clicat%TYPE
    -- %param        pn_rnwdte    IN  po100.actdte%TYPE
    -- %param        pn_unqref    IN  po100.unqref%TYPE
    -- %returns      po100.actpar%TYPE
    -- %raises       OTHERS
    ********************************************************************************************************/
    FUNCTION f_get_PST_IP_details(pn_polref  IN po010.polref%TYPE
                                 ,pn_cliref  IN po100.cliref%TYPE
                                 ,pv_clicat  IN po100.clicat%TYPE
                                 ,pn_rnwdte  IN po100.actdte%TYPE
                                 ,pn_unqref  IN po100.unqref%TYPE)
    RETURN po100.actpar%TYPE
    IS
        CURSOR cu_get_PST_IP_details(pcn_polref IN po010.polref%TYPE
                                    ,pcn_cliref IN po100.cliref%TYPE
                                    ,pcv_clicat IN po100.clicat%TYPE
                                    ,pcn_rnwdte IN po100.actdte%TYPE
                                    ,pcn_unqref IN po100.unqref%TYPE)
        IS
            SELECT p.actpar
            FROM   po100 p
            WHERE  p.polref              = pcn_polref
            AND    p.cliref              = pcn_cliref
            AND    p.clicat              = pcv_clicat
            AND    p.actref              = 'RS-PST-IP'
            AND    SUBSTR(p.actpar,41,5) = TO_CHAR(pcn_rnwdte)
            AND    p.unqref              = pcn_unqref;

        lv_actpar     po100.actpar%TYPE;
    BEGIN

        pck_process_info.p_set_action(pv_action_name => 'F_GET_PST_IP_DETAILS');

        OPEN cu_get_PST_IP_details(pcn_polref => pn_polref
                                  ,pcn_cliref => pn_cliref
                                  ,pcv_clicat => pv_clicat
                                  ,pcn_rnwdte => pn_rnwdte
                                  ,pcn_unqref => pn_unqref);

        FETCH cu_get_PST_IP_details INTO lv_actpar;
        CLOSE cu_get_PST_IP_details;

        RETURN lv_actpar;

    EXCEPTION
        WHEN OTHERS THEN
            -- Any unhandled expection occurs
            pck_err.p_handle(pv_err_code      => 'ERRMSG'
                            ,pt_err_param     => pck_err.t_err_param('PCK_SCHEME_RENEWALS.F_GET_PST_IP_DETAILS')
                            ,pv_subprcss_name => pck_err.f_get_subprocess
                            ,pn_err_occurance => 0
                            ,pv_add_text      => 'Failure in fetching RS-PST-IP trigger details'    ||
                                                 'Policy reference   : ' || TO_CHAR(pn_polref)   ||
                                                 'Scheme reference   : ' || TO_CHAR(pn_cliref)   ||
                                                 'Scheme category    : ' || pv_clicat            ||
                                                 'Renewal Date       : ' || TO_CHAR(pn_rnwdte)
                            ,pb_log_err       => TRUE
                            ,pb_re_raise      => FALSE);

    END f_get_PST_IP_details;

    /*******************************************************************************************************
    -- %Description  Procedure creates the exception trigger RS-PSTEXC for a given policy & trigger type
    -- %param        pn_polref       IN  po010.polref%TYPE
    -- %param        pn_cliref       IN  po100.cliref%TYPE
    -- %param        pv_clicat       IN  po100.clicat%TYPE
    -- %param        pn_rnwdte       IN  po100.actdte%TYPE
    -- %param        pn_unqref       IN  po100.unqref%TYPE
    -- %param        pv_trigger_type IN  renewal_statement_pack_wp.trigger_type%TYPE
    -- %param        pv_actpar       OUT po100.actpar%TYPE
    -- %raises       OTHERS
    ********************************************************************************************************/
    PROCEDURE p_create_exception (pn_polref       IN  po010.polref%TYPE
                                 ,pn_cliref       IN  po100.cliref%TYPE
                                 ,pv_clicat       IN  po100.clicat%TYPE
                                 ,pn_rnwdte       IN  po100.actdte%TYPE
                                 ,pn_unqref       IN  po100.unqref%TYPE
                                 ,pv_trigger_type IN  renewal_statement_pack_wp.trigger_type%TYPE
                                 ,pv_actpar       OUT po100.actpar%TYPE)
    IS
        lr_po100      pck_activity.rec_po100;
        lv_actpar     po100.actpar%TYPE;
        lv_newactpar  po100.actpar%TYPE;
    BEGIN
        pck_process_info.p_register_module(pv_module_name => LPCV_PACKAGE_NAME
                                          ,pv_action_name => 'P_CREATE_EXCEPTION');

        IF pv_trigger_type != 'RS-PST-IP' THEN
            lv_actpar := f_get_PSTSCH_details(pn_cliref  => pn_cliref
                                             ,pv_clicat  => pv_clicat
                                             ,pn_rnwdte  => pn_rnwdte
                                             ,pn_unqref  => pn_unqref);
        ELSE
            lv_actpar := f_get_PST_IP_details(pn_polref  => pn_polref
                                             ,pn_cliref  => pn_cliref
                                             ,pv_clicat  => pv_clicat
                                             ,pn_rnwdte  => pn_rnwdte
                                             ,pn_unqref  => pn_unqref);
        END IF;

        --create new actpar
        p_create_actpar(pv_actpar       => lv_actpar
                       ,pn_unqref       => pn_unqref
                       ,pv_trigger_type => pv_trigger_type
                       ,pv_newactpar    => lv_newactpar);

        --setup inputs for po100
        lr_po100.maint         := 'A';
        lr_po100.audupd_id     := 1;
        lr_po100.audupddte     := lpn_sysdate;
        lr_po100.audupdtme     := lpn_audupdtme;
        lr_po100.audstf_no     := lpt_audit_details(pv_trigger_type).audit_staff_number;
        lr_po100.sta           := 80;
        lr_po100.polref        := pn_polref;
        lr_po100.oridte        := lpn_sysdate;
        lr_po100.lstactdte     := lpn_sysdate;
        lr_po100.enddte        := 99999;
        lr_po100.cliref        := pn_cliref;
        lr_po100.clicat        := pv_clicat;
        lr_po100.actref        := 'RS-PSTEXC';
        lr_po100.audaplcde     := lpt_audit_details(pv_trigger_type).audit_application_code;
        lr_po100.actpar        := lv_newactpar;
        lr_po100.actdte        := lpn_sysdate;
        --Create Exception record
        pck_activity.p_create(pr_po100           => lr_po100
                             ,pb_throw_exception => TRUE);

        pv_actpar := lv_newactpar;

    EXCEPTION
        WHEN OTHERS THEN
            -- Any unhandled expection occurs
            pck_err.p_handle(pv_err_code      => 'ERRMSG'
                            ,pt_err_param     => pck_err.t_err_param('PCK_SCHEME_RENEWALS.P_CREATE_EXCEPTION')
                            ,pv_subprcss_name => pck_err.f_get_subprocess
                            ,pn_err_occurance => 0
                            ,pv_add_text      => 'Failure in creating po100 exception trigger' ||
                                                 'Policy reference   : ' || TO_CHAR(pn_polref) ||
                                                 'Scheme reference   : ' || TO_CHAR(pn_cliref) ||
                                                 'Scheme category    : ' || pv_clicat          ||
                                                 'Renewal Date       : ' || TO_CHAR(pn_rnwdte)
                            ,pb_log_err       => TRUE
                            ,pb_re_raise      => FALSE);
    END p_create_exception;

    /*******************************************************************************************************
   -- %Description  Procedure checks if the premium is backadated
    -- %param        pn_movement_efvdte      IN    fi700.efvdte%TYPE
    -- %param        pn_strdte               IN    po100.actdte%TYPE
    -- %param        pn_enddte               IN    po100.actdte%TYPE
    -- %param        pv_evtdte               IN    event.input_date%TYPE
    -- %param        pv_skip_premium        OUT    VARCHAR2
    -- %raises       None
    ********************************************************************************************************/
    PROCEDURE p_backdated_premium_check(pn_movemnt_efvdte  IN fi700.efvdte%TYPE
                                       ,pn_strdte          IN po100.actdte%TYPE
                                       ,pn_enddte          IN po100.actdte%TYPE
                                       ,pv_evtdte          IN event.input_date%TYPE
                                       ,pv_skip_premium   OUT VARCHAR2)
    IS
        ln_evtdte     po100.actdte%TYPE;
    BEGIN

        pck_process_info.p_set_action(pv_action_name => 'P_BACKDATED_PREMIUM_CHECK');

        pv_skip_premium := 'N';

        IF (pn_movemnt_efvdte < pn_strdte) OR (pn_movemnt_efvdte > pn_enddte) THEN

            ln_evtdte := pck_utility.f_dtcnv(TO_DATE(pv_evtdte));

            IF NOT ((ln_evtdte >= pn_strdte) AND (ln_evtdte <= pn_enddte)) THEN
                pv_skip_premium := 'Y';
            END IF;
        END IF;
    END p_backdated_premium_check;

   /*******************************************************************************************************
    -- %Description  Procedure checks if there is a corresponding event record for the given evtunq and evttrn
                     number
    -- %param        pn_evtunq          IN     event.unq%TYPE
    -- %param        pn_evttrn          IN     event.tranno%TYPE
    -- %param        pv_valid_event    OUT     VARCHAR2
    -- %raises       None
    ********************************************************************************************************/
    PROCEDURE p_get_event_unwound(pn_evtunq        IN event.unq%TYPE
                                 ,pn_evttrn        IN event.tranno%TYPE
                                 ,pv_valid_event  OUT VARCHAR2)
    IS
        CURSOR cu_get_event(pcn_evtunq IN event.unq%TYPE
                           ,pcn_evttrn IN event.tranno%TYPE)
        IS
            SELECT input_date
            FROM   (SELECT e.input_date
                    FROM   event e
                    WHERE  e.unq      = pcn_evtunq
                    AND    e.tranno   = pcn_evttrn
                    AND    e.staevt NOT IN (82 ,88)
                    ORDER BY 1 DESC)
            WHERE rownum = 1;

        lv_inputdate      event.input_date%TYPE;
    BEGIN
        pck_process_info.p_set_action(pv_action_name => 'P_GET_EVENT_UNWOUND');

        pv_valid_event := 'Y';

        OPEN cu_get_event(pcn_evtunq => pn_evtunq
                         ,pcn_evttrn => pn_evttrn);
        FETCH cu_get_event INTO lv_inputdate;
        CLOSE cu_get_event;

        IF lv_inputdate IS NULL THEN
            pv_valid_event := 'N';
        END IF;

    END p_get_event_unwound;

   /*******************************************************************************************************
    -- %Description  Procedure checks if there is a corresponding event record for the given evtunq and evttrn
                     number and checks for backdated premiums
    -- %param        pn_evtunq          IN     event.unq%TYPE
    -- %param        pn_evttrn          IN     event.tranno%TYPE
    -- %param        pn_efvdte          IN     fi700.efvdte%TYPE
    -- %param        pn_fndtrntyp       IN     fi700.fndtrntyp%TYPE
    -- %param        pn_rnwdte          IN     po100.actdte%TYPE
    -- %param        pn_prvrnwdte       IN     po100.actdte%TYPE
    -- %param        pv_valid_event    OUT     VARCHAR2
    -- %raises       None
    ********************************************************************************************************/
    PROCEDURE p_get_event(pn_evtunq        IN  event.unq%TYPE
                         ,pn_evttrn        IN  event.tranno%TYPE
                         ,pn_efvdte        IN  fi700.efvdte%TYPE
                         ,pn_fndtrntyp     IN  fi700.fndtrntyp%TYPE
                         ,pn_rnwdte        IN  po100.actdte%TYPE
                         ,pn_prvrnwdte     IN  po100.actdte%TYPE
                         ,pv_valid_event  OUT  VARCHAR2)
    IS
        CURSOR cu_get_event(pcn_evtunq IN event.unq%TYPE
                           ,pcn_evttrn IN event.tranno%TYPE)
        IS
            SELECT input_date
            FROM   (SELECT e.input_date
                    FROM  event e
                    WHERE e.unq      = pcn_evtunq
                    AND   e.tranno   = pcn_evttrn
                    AND   e.staevt NOT IN (82 ,88)
                    AND   e.trnind1  < 2
                    ORDER BY 1 DESC)
            WHERE rownum = 1;

        CURSOR cu_get_event2(pcn_evtunq IN event.unq%TYPE
                            ,pcn_evttrn IN event.tranno%TYPE)
        IS
            SELECT input_date
            FROM   (SELECT e.input_date
                    FROM  event e
                    WHERE e.unq      = pcn_evtunq
                    AND   e.tranno   = pcn_evttrn
                    AND   e.staevt NOT IN (82 ,88)
                    ORDER BY 1 DESC)
            WHERE rownum = 1;

        lv_skip_premium   VARCHAR2(1);
        lv_inputdate      event.input_date%TYPE;
        lv_record_fnd     VARCHAR2(1) := 'N';

    BEGIN

        pck_process_info.p_set_action(pv_action_name => 'P_GET_EVENT');

        pv_valid_event := 'Y';

        OPEN cu_get_event(pcn_evtunq => pn_evtunq
                         ,pcn_evttrn => pn_evttrn);
        FETCH cu_get_event INTO lv_inputdate;
        CLOSE cu_get_event;

        IF pn_fndtrntyp IN ('SP', 'SW') THEN
            OPEN cu_get_event2(pcn_evtunq => pn_evtunq
                               ,pcn_evttrn => pn_evttrn);
            FETCH cu_get_event2 INTO lv_inputdate;
            CLOSE cu_get_event2;
        END IF;

        IF lv_inputdate IS NOT NULL THEN
            lv_record_fnd := 'Y';
        END IF;

        p_backdated_premium_check(pn_movemnt_efvdte => pn_efvdte
                                 ,pn_strdte         => pn_prvrnwdte
                                 ,pn_enddte         => pn_rnwdte
                                 ,pv_evtdte         => lv_inputdate
                                 ,pv_skip_premium   => lv_skip_premium);

        IF lv_skip_premium = 'N' AND lv_record_fnd = 'N' THEN
            pv_valid_event := 'N';
        END IF;
    END p_get_event;

    /*******************************************************************************************************
   -- %Description  Procedure checks if the event records are available for all fi700 transactions
    -- %param        pn_polref        IN     po010.polref%TYPE
    -- %param        pn_cliref        IN     po100.cliref%TYPE
    -- %param        pv_clicat        IN     po100.clicat%TYPE
    -- %param        pn_rnwdte        IN     po100.actdte%TYPE
    -- %param        pn_strdte        IN     po100.actdte%TYPE
    -- %param        pn_unqref        IN     po100.unqref%TYPE
    -- %param        pv_trigger_type  IN     renewal_statement_pack_wp.trigger_type%TYPE
    -- %param        pv_actpar        OUT    po100.actpar%TYPE
    -- %param        pv_valid_event   IN OUT VARCHAR2
    ********************************************************************************************************/
    PROCEDURE p_check_unwound_records(pn_polref       IN      po010.polref%TYPE
                                     ,pn_cliref       IN      po100.cliref%TYPE
                                     ,pv_clicat       IN      po100.clicat%TYPE
                                     ,pn_rnwdte       IN      po100.actdte%TYPE
                                     ,pn_strdte       IN      po100.actdte%TYPE
                                     ,pn_unqref       IN      po100.unqref%TYPE
                                     ,pv_trigger_type IN      renewal_statement_pack_wp.trigger_type%TYPE
                                     ,pv_actpar       OUT     po100.actpar%TYPE
                                     ,pv_valid_event  IN OUT  VARCHAR2)
     IS
       CURSOR cu_unwound_transactions(pcn_polref  IN po010.polref%TYPE
                                     ,pcn_rnwdte  IN po100.actdte%TYPE
                                     ,pcn_strdte  IN po100.actdte%TYPE)
        IS
            SELECT *
            FROM   fi700 f
            WHERE  f.polref    = pcn_polref
            AND    f.untstm_no <> 999
            AND    f.efvdte    < pcn_rnwdte
            AND    f.efvdte    >= pcn_strdte
            AND    f.staevt    IN (50, 65)
            ORDER BY 1 DESC;

        lt_fi700            pck_fund_movements.tab_fi700s;
        ln_unq              fi700.evtunq%TYPE    := 0;
        ln_trnno            fi700.evttrn_no%TYPE := 0;
    BEGIN
        pck_process_info.p_set_action(pv_action_name => 'P_CHECK_UNWOUND_RECORDS');

        OPEN cu_unwound_transactions(pcn_polref => pn_polref
                                    ,pcn_rnwdte => pn_rnwdte
                                    ,pcn_strdte => pn_strdte);
        <<OUTER_LOOP>>
        LOOP
            FETCH cu_unwound_transactions BULK COLLECT INTO lt_fi700 LIMIT lpn_bulk_limit;
            EXIT WHEN lt_fi700.COUNT = 0;
            <<INNER_LOOP>>
                FOR i IN 1.. lt_fi700.LAST LOOP
                    IF (ln_unq != lt_fi700(i).evtunq) OR (ln_trnno != lt_fi700(i).evttrn_no) THEN
                        p_get_event_unwound(pn_evtunq       => lt_fi700(i).evtunq
                                           ,pn_evttrn       => lt_fi700(i).evttrn_no
                                           ,pv_valid_event  => pv_valid_event);

                        IF pv_valid_event = 'N' THEN
                            p_create_exception(pn_polref       => pn_polref
                                              ,pn_cliref       => pn_cliref
                                              ,pv_clicat       => pv_clicat
                                              ,pn_rnwdte       => pn_rnwdte
                                              ,pn_unqref       => pn_unqref
                                              ,pv_trigger_type => pv_trigger_type
                                              ,pv_actpar       => pv_actpar);
                        END IF;
                    END IF;

                    ln_unq   := lt_fi700(i).evtunq;
                    ln_trnno := lt_fi700(i).evttrn_no;

                    EXIT OUTER_LOOP WHEN pv_valid_event = 'N';
               END LOOP;
        END LOOP;
        CLOSE cu_unwound_transactions;
     END p_check_unwound_records;

    /*******************************************************************************************************
    -- %Description  Procedure checks if the event records are available for all fi700 transactions
    -- %param        pn_polref        IN  po010.polref%TYPE
    -- %param        pn_cliref        IN  po100.cliref%TYPE
    -- %param        pv_clicat        IN  po100.clicat%TYPE
    -- %param        pn_rnwdte        IN  po100.actdte%TYPE
    -- %param        pn_strdte        IN  po100.actdte%TYPE
    -- %param        pn_unqref        IN  po100.unqref%TYPE
    -- %param        pv_trigger_type  IN  renewal_statement_pack_wp.trigger_type%TYPE
    -- %param        pv_valid_event   OUT VARCHAR2
    -- %raises       OTHERS
    ********************************************************************************************************/
    PROCEDURE p_check_event_records(pn_polref       IN  po010.polref%TYPE
                                   ,pn_cliref       IN  po100.cliref%TYPE
                                   ,pv_clicat       IN  po100.clicat%TYPE
                                   ,pn_rnwdte       IN  po100.actdte%TYPE
                                   ,pn_strdte       IN  po100.actdte%TYPE
                                   ,pn_unqref       IN  po100.unqref%TYPE
                                   ,pv_trigger_type IN  renewal_statement_pack_wp.trigger_type%TYPE
                                   ,pv_valid_event  OUT VARCHAR2)
    IS
        CURSOR cu_new_transactions(pcn_polref  IN po010.polref%TYPE
                                  ,pcn_rnwdte  IN po100.actdte%TYPE
                                  ,pcn_strdte  IN po100.actdte%TYPE)
        IS
            SELECT *
            FROM   fi700 f
            WHERE  f.polref    = pcn_polref
            AND    f.untstm_no = 999
            AND    f.efvdte    < pcn_rnwdte
            AND    f.efvdte   >= pcn_strdte
            AND    f.staevt    IN (50, 65)
            ORDER BY 1 DESC;
        lt_fi700            pck_fund_movements.tab_fi700s;
        ln_unq              fi700.evtunq%TYPE    := 0;
        ln_trnno            fi700.evttrn_no%TYPE := 0;
        lv_actpar           po100.actpar%TYPE;
     BEGIN
        pck_process_info.p_register_module(pv_module_name => LPCV_PACKAGE_NAME
                                          ,pv_action_name => 'P_CHECK_EVENT_RECORDS');

        pv_valid_event := 'Y';

        OPEN cu_new_transactions (pcn_polref => pn_polref
                                 ,pcn_rnwdte => pn_rnwdte
                                 ,pcn_strdte => pn_strdte);
        <<OUTER_LOOP>>
        LOOP
            FETCH cu_new_transactions BULK COLLECT INTO lt_fi700 LIMIT lpn_bulk_limit;
            EXIT WHEN lt_fi700.COUNT = 0;
                <<INNER_LOOP>>
                FOR i IN 1.. lt_fi700.LAST LOOP
                       IF (ln_unq != lt_fi700(i).evtunq) OR (ln_trnno != lt_fi700(i).evttrn_no) THEN
                            p_get_event(pn_evtunq       => lt_fi700(i).evtunq
                                       ,pn_evttrn       => lt_fi700(i).evttrn_no
                                       ,pn_efvdte       => lt_fi700(i).efvdte
                                       ,pn_fndtrntyp    => lt_fi700(i).fndtrntyp
                                       ,pn_rnwdte       => pn_rnwdte
                                       ,pn_prvrnwdte    => pn_strdte
                                       ,pv_valid_event  => pv_valid_event);

                            IF pv_valid_event = 'N' THEN
                                p_create_exception(pn_polref       => pn_polref
                                                  ,pn_cliref       => pn_cliref
                                                  ,pv_clicat       => pv_clicat
                                                  ,pn_rnwdte       => pn_rnwdte
                                                  ,pn_unqref       => pn_unqref
                                                  ,pv_trigger_type => pv_trigger_type
                                                  ,pv_actpar       => lv_actpar);
                            END IF;
                        END IF;

                        ln_unq   := lt_fi700(i).evtunq;
                        ln_trnno := lt_fi700(i).evttrn_no;

                    EXIT OUTER_LOOP WHEN pv_valid_event = 'N';
               END LOOP;
        END LOOP;
        CLOSE cu_new_transactions;

        -- Check unwound transactions
        IF pv_valid_event = 'Y' THEN
            p_check_unwound_records(pn_polref       => pn_polref
                                   ,pn_cliref       => pn_cliref
                                   ,pv_clicat       => pv_clicat
                                   ,pn_rnwdte       => pn_rnwdte
                                   ,pn_strdte       => pn_strdte
                                   ,pn_unqref       => pn_unqref
                                   ,pv_trigger_type => pv_trigger_type
                                   ,pv_actpar       => lv_actpar
                                   ,pv_valid_event  => pv_valid_event);
        END IF;

        IF pv_valid_event = 'N' THEN
            IF pv_trigger_type != 'RS-PST-IP' THEN
                -- Update the PO100 RS-PSTSCH trigger to 45
                p_update_po100(pn_status  => 45
                              ,pn_cliref  => pn_cliref
                              ,pv_clicat  => pv_clicat
                              ,pn_rnwdte  => pn_rnwdte
                              ,pn_unqref  => pn_unqref
                              ,pv_actpar  => lv_actpar);
            ELSE
                -- Update the PO100 RS-PST-IP trigger to 45
                p_update_po100_cimp_ip(pn_status => 45
                                      ,pn_polref => pn_polref
                                      ,pn_cliref => pn_cliref
                                      ,pv_clicat => pv_clicat
                                      ,pn_rnwdte => pn_rnwdte
                                      ,pn_unqref => pn_unqref);
            END IF;
       END IF;

    EXCEPTION
        WHEN OTHERS THEN
            -- Any unhandled expection occurs
            pck_err.p_handle(pv_err_code      => 'ERRMSG'
                            ,pt_err_param     => pck_err.t_err_param('PCK_SCHEME_RENEWALS.P_CHECK_EVENT_RECORDS')
                            ,pv_subprcss_name => pck_err.f_get_subprocess
                            ,pn_err_occurance => 0
                            ,pv_add_text      => 'Failure in p_check_event_records for a policy'    ||
                                                 'Policy reference   : ' || TO_CHAR(pn_polref)      ||
                                                 'Scheme reference   : ' || TO_CHAR(pn_cliref)      ||
                                                 'Scheme category    : ' || pv_clicat               ||
                                                 'Renewal Date       : ' || TO_CHAR(pn_rnwdte)
                            ,pb_log_err       => TRUE
                            ,pb_re_raise      => FALSE);
    END p_check_event_records;

    /*******************************************************************************************************
    -- %Description  Function returns the next untstm_no for a given policy
    -- %param        pn_polref              IN   po010.polref%TYPE
    -- %returns      co055.untstm_no%TYPE
    -- %raises       None
    ********************************************************************************************************/
    FUNCTION f_get_nxt_stmt_no(pn_polref  IN  po010.polref%TYPE)
    RETURN co055.untstm_no%TYPE
    IS

        CURSOR cu_get_lststmt_no(pcn_polref IN Po010.Polref%TYPE)
        IS
            SELECT *
            FROM ( SELECT c.untstm_no
                   FROM   co055 c
                   WHERE  c.stastd    = 30
                   AND    c.polref    = pcn_polref
                   AND    c.maint    <> 'D'
                   AND    c.untstm_no < 999
                   ORDER BY 1 DESC )
            WHERE ROWNUM = 1;

        ln_lst_stmt_no   co055.untstm_no%TYPE := 0;

    BEGIN
        pck_process_info.p_set_action(pv_action_name => 'F_GET_NXT_STMT_NO');

        OPEN cu_get_lststmt_no(pcn_polref => pn_polref);
        FETCH cu_get_lststmt_no INTO ln_lst_stmt_no ;
        CLOSE cu_get_lststmt_no;

        RETURN ln_lst_stmt_no+1;
    END f_get_nxt_stmt_no;

   /*******************************************************************************************************
    -- %Description  Function calculates the untind for the given fund reference
    -- %param        pn_fndref          IN  co055.fndref%TYPE
    -- %returns      pr310.untind%TYPE
    -- %raises       None
    ********************************************************************************************************/
    FUNCTION f_calculate_untind(pn_fndref   IN co055.fndref%TYPE)
    RETURN pr310.untind%TYPE
    IS
        CURSOR cu_funds(pcn_fndref  IN pr315.fndref%TYPE)
        IS
            SELECT p.untind
            FROM   pr310 p
            WHERE  p.fndref = pcn_fndref;

        ln_untind     pr310.untind%TYPE;

    BEGIN
        pck_process_info.p_set_action(pv_action_name => 'F_CALCULATE_UNTIND');

        OPEN cu_funds(pcn_fndref => pn_fndref);
        FETCH cu_funds INTO ln_untind;
        CLOSE cu_funds;

        RETURN ln_untind;
    END f_calculate_untind;

   /*******************************************************************************************************
    -- %Description  Function returns the end date of the given policy reference
    -- %param        pn_polref           IN     co040.polref%TYPE
    -- %returns      co040.enddte%TYPE
    -- %raises       None
    ********************************************************************************************************/
    FUNCTION f_get_policy_endte(pn_polref  IN  co040.polref%TYPE)
    RETURN co040.enddte%TYPE
    IS
       CURSOR cu_get_enddte(pcn_polref IN co040.polref%TYPE)
       IS
           SELECT c.enddte
           FROM  co040 c
           WHERE c.polref = pcn_polref
           AND   c.rolref = 'SCH'
           AND   c.staxrf = 30
           ORDER BY 1 DESC;

       ln_enddte     co040.enddte%TYPE;
    BEGIN
        pck_process_info.p_set_action(pv_action_name => 'F_GET_POLICY_ENDTE');

        OPEN cu_get_enddte(pcn_polref => pn_polref);
        FETCH cu_get_enddte INTO ln_enddte;
        CLOSE cu_get_enddte;

        RETURN ln_enddte;
    END f_get_policy_endte;

   /*******************************************************************************************************
    -- %Description  set transaction by applying any reversed funds
    -- %param        pn_spldte           IN co055.spldte%TYPE
    -- %param        pv_rhttyp           IN PO030.rhttyp%TYPE
    -- %param        pn_benqty1          IN fi700.benqty1%TYPE
    -- %param        pn_othbenqty        IN fi700.othbenqty%TYPE
    -- %param        pn_psttrn_pr    IN OUT fi700.benqty1%TYPE
    -- %param        pn_psttrnoth_pr IN OUT fi700.benqty1%TYPE
    -- %param        pn_psttrn       IN OUT fi700.benqty1%TYPE
    -- %param        pn_psttrnoth    IN OUT fi700.benqty1%TYPE
    -- %param        pn_pretrn_pr    IN OUT fi700.benqty1%TYPE
    -- %param        pn_pretrnoth_pr IN OUT fi700.benqty1%TYPE
    -- %param        pn_pretrn       IN OUT fi700.benqty1%TYPE
    -- %param        pn_pretrnoth    IN OUT fi700.benqty1%TYPE)
    -- %raises       None
    ********************************************************************************************************/
    PROCEDURE p_apply_rvrsed_trn(pn_spldte           IN co055.spldte%TYPE
                                ,pv_rhttyp           IN PO030.rhttyp%TYPE
                                ,pn_benqty1          IN fi700.benqty1%TYPE
                                ,pn_othbenqty        IN fi700.othbenqty%TYPE
                                ,pn_psttrn_pr    IN OUT fi700.benqty1%TYPE
                                ,pn_psttrnoth_pr IN OUT fi700.benqty1%TYPE
                                ,pn_psttrn       IN OUT fi700.benqty1%TYPE
                                ,pn_psttrnoth    IN OUT fi700.benqty1%TYPE
                                ,pn_pretrn_pr    IN OUT fi700.benqty1%TYPE
                                ,pn_pretrnoth_pr IN OUT fi700.benqty1%TYPE
                                ,pn_pretrn       IN OUT fi700.benqty1%TYPE
                                ,pn_pretrnoth    IN OUT fi700.benqty1%TYPE)
    IS
    BEGIN
        CASE
            WHEN pn_spldte = 35524 THEN
                IF pv_rhttyp = 'P' THEN
                   pn_psttrn_pr    := NVL(pn_psttrn_pr,0)     - pn_benqty1;
                   pn_psttrnoth_pr := NVL(pn_psttrnoth_pr,0)  - pn_othbenqty;
                ELSE
                   pn_psttrn       := NVL(pn_psttrn,0)        - pn_benqty1;
                   pn_psttrnoth    := NVL(pn_psttrnoth,0)     - pn_othbenqty;
                END IF;
            WHEN pn_spldte = -99999 THEN
                IF pv_rhttyp = 'P' THEN
                   pn_pretrn_pr    := NVL(pn_pretrn_pr ,0)    - pn_benqty1;
                   pn_pretrnoth_pr := NVL(pn_pretrnoth_pr ,0) - pn_othbenqty;
                ELSE
                   pn_pretrn       := NVL(pn_pretrn ,0)       - pn_benqty1;
                   pn_pretrnoth    := NVL(pn_pretrnoth, 0)    - pn_othbenqty;
                END IF;
        END CASE;
    END p_apply_rvrsed_trn;

   /*******************************************************************************************************
    -- %Description  set transaction by applying reversion or accumulation
    -- %param        pn_spldte           IN co055.spldte%TYPE
    -- %param        pv_rhttyp           IN PO030.rhttyp%TYPE
    -- %param        pn_benqty1          IN fi700.benqty1%TYPE
    -- %param        pn_othbenqty        IN fi700.othbenqty%TYPE
    -- %param        pn_factor           IN PLS_INTEGER
    -- %param        pn_psttrn_pr    IN OUT fi700.benqty1%TYPE
    -- %param        pn_psttrnoth_pr IN OUT fi700.benqty1%TYPE
    -- %param        pn_psttrn       IN OUT fi700.benqty1%TYPE
    -- %param        pn_psttrnoth    IN OUT fi700.benqty1%TYPE
    -- %param        pn_pretrn_pr    IN OUT fi700.benqty1%TYPE
    -- %param        pn_pretrnoth_pr IN OUT fi700.benqty1%TYPE
    -- %param        pn_pretrn       IN OUT fi700.benqty1%TYPE
    -- %param        pn_pretrnoth    IN OUT fi700.benqty1%TYPE)
    -- %raises       None
    ********************************************************************************************************/
    PROCEDURE p_apply_trn(pn_spldte           IN co055.spldte%TYPE
                         ,pv_rhttyp           IN PO030.rhttyp%TYPE
                         ,pn_benqty1          IN fi700.benqty1%TYPE
                         ,pn_othbenqty        IN fi700.othbenqty%TYPE
                         ,pn_factor           IN NUMBER
                         ,pn_psttrn_pr    IN OUT fi700.benqty1%TYPE
                         ,pn_psttrnoth_pr IN OUT fi700.benqty1%TYPE
                         ,pn_psttrn       IN OUT fi700.benqty1%TYPE
                         ,pn_psttrnoth    IN OUT fi700.benqty1%TYPE
                         ,pn_pretrn_pr    IN OUT fi700.benqty1%TYPE
                         ,pn_pretrnoth_pr IN OUT fi700.benqty1%TYPE
                         ,pn_pretrn       IN OUT fi700.benqty1%TYPE
                         ,pn_pretrnoth    IN OUT fi700.benqty1%TYPE)
    IS
    BEGIN
        -- Calculations are applied using pn_factor as a multiplier(-1 or +1) to
        -- deduct or add benefit value
        CASE
            WHEN pn_spldte = 35524 THEN
                IF pv_rhttyp = 'P' THEN
                   pn_psttrn_pr    := NVL(pn_psttrn_pr,0)     + (pn_benqty1 * pn_factor);
                   pn_psttrnoth_pr := NVL(pn_psttrnoth_pr,0)  + (pn_othbenqty * pn_factor);
                ELSE
                   pn_psttrn       := NVL(pn_psttrn,0)        + (pn_benqty1 * pn_factor);
                   pn_psttrnoth    := NVL(pn_psttrnoth,0)     + (pn_othbenqty * pn_factor);
                END IF;
            WHEN pn_spldte = -99999 THEN
                IF pv_rhttyp = 'P' THEN
                   pn_pretrn_pr    := NVL(pn_pretrn_pr ,0)    + (pn_benqty1 * pn_factor);
                   pn_pretrnoth_pr := NVL(pn_pretrnoth_pr ,0) + (pn_othbenqty * pn_factor);
                ELSE
                   pn_pretrn       := NVL(pn_pretrn ,0)       + (pn_benqty1 * pn_factor);
                   pn_pretrnoth    := NVL(pn_pretrnoth, 0)    + (pn_othbenqty * pn_factor);
                END IF;
        END CASE;
    END p_apply_trn;

   /*******************************************************************************************************
    -- %Description  Procedure returns the reversed funds if there are any for the given policy reference
    -- %param        pn_polref           IN      po010.polref%TYPE
    -- %param        pn_fndref           IN      fi700.fndref%TYPE
    -- %param        pn_untstm_no        IN      fi700.untstm_no%TYPE
    -- %param        pv_trigger_type     IN      renewal_statement_pack_wp.trigger_type%TYPE
    -- %param        pr_transaction  IN OUT      r_transactions
    -- %raises       None
    ********************************************************************************************************/
    PROCEDURE p_get_reversed_funds(pn_polref           IN   po010.polref%TYPE
                                  ,pn_fndref           IN   fi700.fndref%TYPE
                                  ,pn_untstm_no        IN   fi700.untstm_no%TYPE
                                  ,pv_trigger_type     IN   renewal_statement_pack_wp.trigger_type%TYPE
                                  ,pr_transaction  IN OUT   r_transactions)
    IS
        CURSOR cu_reversed_funds(pcn_polref IN  po010.polref%TYPE
                                ,pcn_fndref IN  fi700.fndref%TYPE)
       IS
           SELECT *
           FROM  fi700 f
           WHERE f.polref     = pcn_polref
           AND   f.staevt     = 70
           AND   f.untstm_no < 999
           AND   f.fndref    = pcn_fndref;

        lt_rvr_fi700        pck_fund_movements.tab_fi700s;
        ln_spldte           co055.spldte%TYPE;

    BEGIN
        pck_process_info.p_set_action(pv_action_name => 'P_GET_REVERSED_FUNDS');

        OPEN cu_reversed_funds(pcn_polref => pn_polref
                              ,pcn_fndref => pn_fndref);
        LOOP
            FETCH cu_reversed_funds BULK COLLECT INTO lt_rvr_fi700 LIMIT lpn_bulk_limit;
            EXIT WHEN lt_rvr_fi700.COUNT = 0;
                FOR i IN 1.. lt_rvr_fi700.COUNT LOOP
                    -- Get Split Date
                    ln_spldte := pck_fund_movements.f_get_split_dte(pn_polref => pn_polref
                                                                   ,pn_duedte => lt_rvr_fi700(i).duedte
                                                                   ,pn_efvdte => lt_rvr_fi700(i).efvdte
                                                                   ,pn_prdgrp => GA.GA_MAITCHRCD);

                    p_apply_trn(pn_spldte => ln_spldte
                               ,pv_rhttyp => lt_rvr_fi700(i).rhttyp
                               ,pn_benqty1 => lt_rvr_fi700(i).benqty1
                               ,pn_othbenqty => lt_rvr_fi700(i).othbenqty
                               ,pn_factor => -1
                               ,pn_psttrn_pr => pr_transaction.psttrn_pr
                               ,pn_psttrnoth_pr => pr_transaction.psttrnoth_pr
                               ,pn_psttrn => pr_transaction.psttrn
                               ,pn_psttrnoth => pr_transaction.psttrnoth
                               ,pn_pretrn_pr => pr_transaction.pretrn_pr
                               ,pn_pretrnoth_pr => pr_transaction.pretrnoth_pr
                               ,pn_pretrn => pr_transaction.pretrn
                               ,pn_pretrnoth => pr_transaction.pretrnoth);
                END LOOP;

                -- Update all reversed funds
                p_reverse_update_fi700_funds(pn_untstm_no    => pn_untstm_no
                                            ,pt_fi700        => lt_rvr_fi700
                                            ,pv_trigger_type => pv_trigger_type);

        END LOOP;
        CLOSE cu_reversed_funds;
    END p_get_reversed_funds;

   /*******************************************************************************************************
    -- %Description  Procedure calculates the fund movements for a given polref in a current renewal year
    -- %param        pn_polref         IN      po010.polref%TYPE
    -- %param        pn_rnwdte         IN      po100.actdte%TYPE
    -- %param        pn_nxtstm_no      IN      co055.untstm_no%TYPE
    -- %param        pr_benefits       IN      r_benefits
    -- %param        pv_trigger_type   IN      renewal_statement_pack_wp.trigger_type%TYPE
    -- %param        pn_enddte        OUT      co040.enddte%TYPE
    -- %param        pr_transactions  OUT      r_transactions
    -- %raises       None
    ********************************************************************************************************/
    PROCEDURE p_get_fund_movements(pn_polref        IN  po010.polref%TYPE
                                  ,pn_rnwdte        IN  po100.actdte%TYPE
                                  ,pn_nxtstm_no     IN  co055.untstm_no%TYPE
                                  ,pr_benefits      IN  r_benefits
                                  ,pv_trigger_type  IN  renewal_statement_pack_wp.trigger_type%TYPE
                                  ,pn_enddte       OUT  co040.enddte%TYPE
                                  ,pr_transactions OUT  r_transactions)

    IS
        CURSOR cu_calc_funds(pcn_polref IN  po010.polref%TYPE
                            ,pcn_fndref IN  fi700.fndref%TYPE
                            ,pcn_rnwdte IN  po100.actdte%TYPE
                            ,pcn_enddte IN  co040.enddte%TYPE)
       IS
           SELECT *
           FROM  fi700 f
           WHERE f.polref     = pcn_polref
           AND   f.staevt    IN (50, 65)
           AND   f.untstm_no  = 999
           AND   f.efvdte     < pcn_rnwdte
           AND   f.efvdte    <= pcn_enddte
           AND   f.fndref     = pcn_fndref;

        lt_fi700                    pck_fund_movements.tab_fi700s;
        ln_spldte                   fi700.spsdte%TYPE;
        lr_transactions             r_transactions;
    BEGIN
        pck_process_info.p_set_action(pv_action_name => 'P_GET_FUND_MOVEMENTS');

        -- Get the policy end date
        pn_enddte := f_get_policy_endte(pn_polref => pn_polref);

        OPEN cu_calc_funds (pcn_polref => pn_polref
                           ,pcn_fndref => pr_benefits.fndref
                           ,pcn_rnwdte => pn_rnwdte
                           ,pcn_enddte => pn_enddte);

        LOOP
             FETCH cu_calc_funds BULK COLLECT INTO lt_fi700 LIMIT lpn_bulk_limit;
             EXIT WHEN lt_fi700.COUNT = 0;
                 FOR i IN 1.. lt_fi700.LAST LOOP
                   -- Get Split date
                     ln_spldte := pck_fund_movements.f_get_split_dte(pn_polref => pn_polref
                                                                  ,pn_duedte => lt_fi700(i).duedte
                                                                  ,pn_efvdte => lt_fi700(i).efvdte
                                                                  ,pn_prdgrp => GA.GA_MAITCHRCD);

                     p_apply_trn(pn_spldte => ln_spldte
                                ,pv_rhttyp => lt_fi700(i).rhttyp
                                ,pn_benqty1 => lt_fi700(i).benqty1
                                ,pn_othbenqty => lt_fi700(i).othbenqty
                                ,pn_factor => +1
                                ,pn_psttrn_pr => lr_transactions.psttrn_pr
                                ,pn_psttrnoth_pr => lr_transactions.psttrnoth_pr
                                ,pn_psttrn => lr_transactions.psttrn
                                ,pn_psttrnoth => lr_transactions.psttrnoth
                                ,pn_pretrn_pr => lr_transactions.pretrn_pr
                                ,pn_pretrnoth_pr => lr_transactions.pretrnoth_pr
                                ,pn_pretrn => lr_transactions.pretrn
                                ,pn_pretrnoth => lr_transactions.pretrnoth);

                 END LOOP;

            -- Update all Fi700 records
            p_update_fi700_funds(pn_nxtstm_no    => pn_nxtstm_no
                                ,pt_fi700        => lt_fi700
                                ,pv_trigger_type => pv_trigger_type);

        END LOOP;
        --Check for any revered transactions
        p_get_reversed_funds(pn_polref       => pn_polref
                            ,pn_fndref       => pr_benefits.fndref
                            ,pn_untstm_no    => pn_nxtstm_no
                            ,pr_transaction  => lr_transactions
                            ,pv_trigger_type => pv_trigger_type);

        pr_transactions := lr_transactions;
        CLOSE cu_calc_funds;

    END p_get_fund_movements;

    /*******************************************************************************************************
    -- %Description  Procedure created the co055 records
    -- %param        pr_co055        IN   pck_fund_holdings.rec_co055
    -- %param        pv_trigger_type IN  renewal_statement_pack_wp.trigger_type%TYPE
    -- %raises       None
    ********************************************************************************************************/
    PROCEDURE p_create_co055(pr_co055        IN  pck_fund_holdings.rec_co055
                            ,pv_trigger_type IN  renewal_statement_pack_wp.trigger_type%TYPE)
    IS
        lb_throw_exception   BOOLEAN := TRUE;
        lr_co055             pck_fund_holdings.rec_co055;
    BEGIN

        pck_process_info.p_set_action(pv_action_name => 'P_CREATE_CO055');

        lr_co055.maint                := 'A';
        lr_co055.audaplcde            := lpt_audit_details(pv_trigger_type).audit_application_code;
        lr_co055.audstf_no            := lpt_audit_details(pv_trigger_type).audit_staff_number;
        lr_co055.audupddte            := lpn_sysdate;
        lr_co055.unttyp               := 'A';
        lr_co055.untstm_no            := pr_co055.untstm_no;
        lr_co055.untind               := pr_co055.untind;
        lr_co055.untstmdte            := pr_co055.untstmdte;
        lr_co055.strdte               := lpn_sysdate;
        lr_co055.stastd               := 30;
        lr_co055.spldte               := pr_co055.spldte;
        lr_co055.rhttyp               := pr_co055.rhttyp;
        lr_co055.polref               := pr_co055.polref;
        lr_co055.othbenqty            := pr_co055.othbenqty;
        lr_co055.audupdtme            := lpn_audupdtme;
        lr_co055.enddte               := 99999;
        lr_co055.benqty1              := pr_co055.benqty1;
        lr_co055.benqty2              := pr_co055.benqty1;
        lr_co055.fndref               := pr_co055.fndref;
        lr_co055.fndsubtyp            := pr_co055.fndsubtyp;

        pck_fund_holdings.p_create(pr_co055           => lr_co055
                                  ,pb_throw_exception => lb_throw_exception);

    END p_create_co055;
    /*******************************************************************************************************
    -- %Description  Procedure calculates the fund holdings of a given policy
    -- %param        pn_polref       IN   co055.polref%TYPE
    -- %param        pn_rnwdte       IN   po100.actdte%TYPE
    -- %param        pn_untstm_no    IN   co055.untstm_no%TYPE
    -- %param        pt_benefits     IN   t_benefits
    -- %param        pv_trigger_type IN   renewal_statement_pack_wp.trigger_type%TYPE)
    -- %raises       None
    ********************************************************************************************************/
    PROCEDURE p_calc_funds(pn_polref       IN   co055.polref%TYPE
                          ,pn_rnwdte       IN   po100.actdte%TYPE
                          ,pn_untstm_no    IN   co055.untstm_no%TYPE
                          ,pt_benefits     IN   t_benefits
                          ,pv_trigger_type IN renewal_statement_pack_wp.trigger_type%TYPE)
    IS
        lr_transactions             r_transactions;
        ln_untind                   pr310.untind%TYPE;
        lr_co055                    pck_fund_holdings.rec_co055;
        ln_pre_ar                   co055.benqty1%TYPE;
        ln_preoth_ar                co055.benqty1%TYPE;
        ln_pst_ar                   co055.benqty1%TYPE;
        ln_pstoth_ar                co055.benqty1%TYPE;
        ln_pre_pr                   co055.benqty1%TYPE;
        ln_preoth_pr                co055.benqty1%TYPE;
        ln_pst_pr                   co055.benqty1%TYPE;
        ln_pstoth_pr                co055.benqty1%TYPE;
        ln_enddte                   co040.enddte%TYPE;
    BEGIN
        pck_process_info.p_set_action(pv_action_name => 'P_CALC_FUNDS');

        FOR i IN 1.. pt_benefits.LAST LOOP
            --Calculate fund movements
            p_get_fund_movements(pn_polref       => pn_polref
                                ,pn_rnwdte       => pn_rnwdte
                                ,pr_benefits     => pt_benefits(i)
                                ,pn_nxtstm_no    => pn_untstm_no
                                ,pv_trigger_type => pv_trigger_type
                                ,pn_enddte       => ln_enddte
                                ,pr_transactions => lr_transactions);

            -- Get UntInd for fndref
            ln_untind := f_calculate_untind(pn_fndref => pt_benefits(i).fndref);

            lr_co055.polref    := pn_polref;
            lr_co055.untstm_no := pn_untstm_no;
            lr_co055.fndref    := pt_benefits(i).fndref;
            lr_co055.fndsubtyp := pt_benefits(i).fndsubtyp;
            lr_co055.untind    := ln_untind;
            lr_co055.untstmdte := pn_rnwdte;

            -- Calculate Pre-split date AR Fund holdings
            ln_pre_ar    := NVL(lr_transactions.pretrn,0) + NVL(pt_benefits(i).preben_ar,0);
            ln_preoth_ar := NVL(lr_transactions.pretrnoth,0) + NVL(pt_benefits(i).preoth_ar,0);

            IF (ln_pre_ar != 0) AND (ln_enddte = 99999) THEN
                lr_co055.rhttyp    := 'A';
                lr_co055.spldte    := -99999;
                lr_co055.benqty1   := ln_pre_ar;
                lr_co055.othbenqty := ln_preoth_ar;
                p_create_co055(pr_co055        => lr_co055
                              ,pv_trigger_type => pv_trigger_type);
            END IF;

            -- Calcualte Post-split date AR fund holdings
            ln_pst_ar     := NVL(lr_transactions.psttrn,0)+ NVL(pt_benefits(i).pstben_ar,0);
            ln_pstoth_ar  := NVL(lr_transactions.psttrnoth,0) + NVL(pt_benefits(i).pstoth_ar,0);

            IF (ln_pst_ar != 0) AND (ln_enddte = 99999) THEN
                lr_co055.rhttyp    := 'A';
                lr_co055.spldte    := 35524;
                lr_co055.benqty1   := ln_pst_ar;
                lr_co055.othbenqty := ln_pstoth_ar;
                p_create_co055(pr_co055        => lr_co055
                              ,pv_trigger_type => pv_trigger_type);
            END IF;

            --Calculate Pre-Split date PR holdings
            ln_pre_pr     := NVL(lr_transactions.pretrn_pr,0) + NVL(pt_benefits(i).preben_pr,0);
            ln_preoth_pr  := NVL(lr_transactions.pretrnoth_pr,0) + NVL(pt_benefits(i).preoth_pr,0);

            IF (ln_pre_pr != 0) AND (ln_enddte = 99999) THEN
               lr_co055.rhttyp    := 'P';
               lr_co055.spldte    := -99999;
               lr_co055.benqty1   := ln_pre_pr;
               lr_co055.othbenqty := ln_preoth_pr;
               p_create_co055(pr_co055 => lr_co055
                             ,pv_trigger_type => pv_trigger_type);
            END IF;

            --Calculate Post-Split date PR holdings
            ln_pst_pr      := NVL(lr_transactions.psttrn_pr,0) + NVL(pt_benefits(i).pstben_pr,0);
            ln_pstoth_pr   := NVL(lr_transactions.psttrnoth_pr,0) + NVL(pt_benefits(i).pstoth_pr,0);

            IF (ln_pst_pr != 0) AND (ln_enddte = 99999) THEN
               lr_co055.rhttyp    := 'P';
               lr_co055.spldte    := 35524;
               lr_co055.benqty1   := ln_pst_pr;
               lr_co055.othbenqty := ln_pstoth_pr;
               p_create_co055(pr_co055 => lr_co055
                             ,pv_trigger_type => pv_trigger_type);
            END IF;
        END LOOP;
    END p_calc_funds;

   /*******************************************************************************************************
    -- %Description  Procedure calculates the benqty value for the given fundref and policy
    -- %param        pn_polref       IN   po010.polref%TYPE
    -- %param        pn_strdte       IN   po100.actdte%TYPE
    -- %param        pn_rnwdte       IN   po100.actdte%TYPE
    -- %param        pn_fndref       IN   fi700.fndref%TYPE
    -- %param        pr_benefits IN OUT   r_benefits
    -- %raises       None
    ********************************************************************************************************/
    PROCEDURE p_calc_benqty(pn_polref       IN  po010.polref%TYPE
                           ,pn_strdte       IN  po100.actdte%TYPE
                           ,pn_rnwdte       IN  po100.actdte%TYPE
                           ,pn_fndref       IN  fi700.fndref%TYPE
                           ,pr_benefits IN OUT  r_benefits)
    IS
        CURSOR cu_calc_benqty(pcn_polref IN co055.polref%TYPE
                             ,pcn_strdte IN co055.strdte%TYPE
                             ,pcn_rnwdte IN po100.actdte%TYPE
                             ,pcn_fndref IN fi700.fndref%TYPE)
        IS
            SELECT *
            FROM  co055 c
            WHERE c.polref     = pcn_polref
            AND   c.untstm_no <= 999
            AND   c.untstmdte >= pcn_strdte
            AND   c.untstmdte  < pcn_rnwdte
            AND   c.stastd     = 30
            AND   c.maint     <> 'D'
            AND   c.fndref     = pcn_fndref;

        lt_co055           pck_fund_holdings.tab_co055s;

    BEGIN
        pck_process_info.p_set_action(pv_action_name => 'P_CALC_BENQTY');

        OPEN cu_calc_benqty (pcn_polref => pn_polref
                            ,pcn_strdte => pn_strdte
                            ,pcn_rnwdte => pn_rnwdte
                            ,pcn_fndref => pn_fndref);
        LOOP
            FETCH cu_calc_benqty BULK COLLECT INTO lt_co055 LIMIT lpn_bulk_limit;
            EXIT WHEN lt_co055.COUNT = 0;
            FOR i IN 1 .. lt_co055.LAST LOOP
                CASE
                    WHEN lt_co055(i).spldte = 35524  THEN
                        IF lt_co055(i).rhttyp = 'P' THEN
                            pr_benefits.pstben_pr := lt_co055(i).benqty1;
                            pr_benefits.pstoth_pr := lt_co055(i).othbenqty;
                        ELSE
                            pr_benefits.pstben_ar := lt_co055(i).benqty1;
                            pr_benefits.pstoth_ar := lt_co055(i).othbenqty;
                        END IF;
                    WHEN lt_co055(i).spldte = -99999 THEN
                        IF lt_co055(i).rhttyp = 'P' THEN
                            pr_benefits.preben_pr := lt_co055(i).benqty1;
                            pr_benefits.preoth_pr := lt_co055(i).othbenqty;
                        ELSE
                            pr_benefits.preben_ar := lt_co055(i).benqty1;
                            pr_benefits.preoth_ar := lt_co055(i).othbenqty;
                        END IF;
                END CASE;
            END LOOP;
        END LOOP;
        CLOSE cu_calc_benqty;
    END p_calc_benqty;

   /***********************************************************************************************************
    -- %Description  Procedure does the Fund Stamping(co055 inserts and FI700 updates) for a particular policy
    -- %param        pn_polref         IN    po010.polref%TYPE
    -- %param        pn_strdte         IN    po100.actdte%TYPE
    -- %param        pn_rnwdte         IN    po100.actdte%TYPE
    -- %param        pv_trigger_type   IN   renewal_statement_pack_wp.trigger_type%TYPE
    -- %raises       OTHERS
    ***********************************************************************************************************/
    PROCEDURE p_fund_stamping(pn_polref       IN   po010.polref%TYPE
                             ,pn_strdte       IN   po100.actdte%TYPE
                             ,pn_rnwdte       IN   po100.actdte%TYPE
                             ,pv_trigger_type IN   renewal_statement_pack_wp.trigger_type%TYPE)
    IS
        CURSOR cu_curr_funds(pcn_polref IN co055.polref%TYPE)
        IS
             SELECT DISTINCT c.fndref
                            ,c.fndsubtyp
                            ,c.unttyp
             FROM   co055 c
             WHERE  c.polref    = pcn_polref
             AND    c.stastd    = 30
             AND    c.untstm_no = 999
             AND    c.maint     <> 'D';

        lt_benefits                 t_benefits;
        lr_benefits                 r_benefits;
        lt_fndref                   t_fnd_ref;
        ln_idx                      PLS_INTEGER := 0;
        LCN_MAX_FUND_DOUBLED        CONSTANT NUMBER(2) := 70;
        ln_nxtstmt_no               co055.untstm_no%TYPE;
    BEGIN

        pck_process_info.p_register_module(pv_module_name => LPCV_PACKAGE_NAME
                                          ,pv_action_name => 'P_FUND_STAMPING');
        -- Get the next Statement Number
        ln_nxtstmt_no := f_get_nxt_stmt_no(pn_polref => pn_polref);

        -- Get the current fund holdings for a policy
        OPEN cu_curr_funds(pcn_polref => pn_polref);
        LOOP
             FETCH cu_curr_funds BULK COLLECT INTO lt_fndref LIMIT lpn_bulk_limit ;
             EXIT WHEN lt_fndref.COUNT = 0;
                FOR i IN 1.. lt_fndref.LAST LOOP

                    ln_idx := ln_idx + 1;

                    lr_benefits.fndref    := lt_fndref(i).fndref;
                    lr_benefits.fndsubtyp := lt_fndref(i).fndsubtyp;
                    lr_benefits.unttyp    := lt_fndref(i).unttyp;
                    lr_benefits.pstben_pr := 0;
                    lr_benefits.pstoth_pr := 0;
                    lr_benefits.pstben_ar := 0;
                    lr_benefits.pstoth_ar := 0;
                    lr_benefits.preben_pr := 0;
                    lr_benefits.preoth_pr := 0;
                    lr_benefits.preben_ar := 0;
                    lr_benefits.preoth_ar := 0;
                    -- Calculate benqty value if it has previous year accumulated funds.
                    p_calc_benqty (pn_polref   => pn_polref
                                  ,pn_strdte   => pn_strdte
                                  ,pn_rnwdte   => pn_rnwdte
                                  ,pn_fndref   => lt_fndref(i).fndref
                                  ,pr_benefits => lr_benefits);

                    lt_benefits(ln_idx) := lr_benefits;
                    EXIT WHEN i > LCN_MAX_FUND_DOUBLED; -- max limit of funds allowed
                END LOOP;
                -- calculate fund values from FI700 benqty column
                p_calc_funds(pn_polref       => pn_polref
                            ,pn_rnwdte       => pn_rnwdte
                            ,pn_untstm_no    => ln_nxtstmt_no
                            ,pt_benefits     => lt_benefits
                            ,pv_trigger_type => pv_trigger_type);
        END LOOP;
        CLOSE cu_curr_funds;
    EXCEPTION
        WHEN OTHERS THEN
            -- Any unhandled expection occurs
            pck_err.p_handle(pv_err_code      => 'ERRMSG'
                            ,pt_err_param     => pck_err.t_err_param('PCK_SCHEME_RENEWALS.P_FUND_STAMPING')
                            ,pv_subprcss_name => pck_err.f_get_subprocess
                            ,pn_err_occurance => 0
                            ,pv_add_text      => 'Failure in Fund movement Stamping for the policy'    ||
                                                 'Policy reference   : ' || TO_CHAR(pn_polref)         ||
                                                 'Renewal Date       : ' || TO_CHAR(pn_rnwdte)
                            ,pb_log_err       => TRUE
                            ,pb_re_raise      => TRUE);
    END  p_fund_stamping;

BEGIN
    -- Lookup audit details to apply to DML
    p_lookup_renewal_audit;
    p_lookup_renewal_audit_cmp_ip;
END pck_scheme_renewals;
/
