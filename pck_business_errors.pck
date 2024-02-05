CREATE OR REPLACE PACKAGE BUSINESSERRORS.pck_business_errors IS

    /*
    Version     : 1.0.0
    Author      : RAJBROWN
    Purpose     : AWD/Business Errors Processing.
    Use         : p_setup_data      : Call prior to processing to setup the information needed for an error item. Enables data to be
                                        stored in advance of an error being encountered in a converted global logic package via CSL_ERRMSG.
                  p_log_error   : Call when an error is encountered to log to ErrorData. Appropriate ErrorDefinition record(s) will
                                        be needed to allow and AWD work item to be created, otherwise info just stored in ErrorData.
                  p_log_error_sqc :   Called from SQC (CSL_ERRHDL) to insert directly to ErrorData. DON'T USE FROM PL/SQL PLEASE!

    Modification History
    Date        By              Details
    15/03/2006  RAJBROWN        Package created.

    10/06/2006  A Reid          Added in cursor for use in MC0021 (part of Auddis changes)

    20/07/2006  SMuniraju   Created a procedure which will call the function f_get_teamcode
                (Caritor)   (part of ARUDDS changes)
    */

    -- Subtype of errordata table.
    SUBTYPE rec_errordata IS errordata%ROWTYPE;
    lr_errordata rec_errordata;

    -- Subtypes to define fields held on other schemas.
    SUBTYPE error_area IS VARCHAR2(2);
    SUBTYPE error_number IS NUMBER(4);
    SUBTYPE client_category IS VARCHAR(3);
    SUBTYPE client_reference IS NUMBER(8);

    -- Type for cursor on errordata table
    TYPE lptyp_error_data IS RECORD(
         systemdate         errordata.systemdate%TYPE
        ,sourcecode         errordata.sourcecode%TYPE
        ,errorcode          errordata.errorcode%TYPE
        ,policy             errordata.policy%TYPE
        ,primaryclient      errordata.primaryclient%TYPE
        ,awdservicestandard errordefinition.awdservicestandard%TYPE);

    TYPE lptyp_cur_errordata IS REF CURSOR RETURN lptyp_error_data;

    -- Setup data for AWD error handling.
    PROCEDURE p_save_data(pr_errordata IN rec_errordata);

    PROCEDURE p_get_teamcode(pv_teamcode IN OUT teamcode.teamcode%TYPE);

    -- Setup error code information.
    PROCEDURE p_save_data(pv_errorcode  IN errordata.errorcode%TYPE
                         ,pv_errortype  IN errordata.errortype%TYPE
                         ,pv_error_info IN VARCHAR2);

    -- Setup freetext field.
    PROCEDURE p_save_data(pv_freetext IN errordata.freetext%TYPE);

    -- Insert a record.
    PROCEDURE p_log_error;

    -- Insert a record (called from SQC).
    PROCEDURE p_log_error_sqc(pv_source_code        errordata.sourcecode%TYPE
                             ,pn_system_date        errordata.systemdate%TYPE
                             ,pv_error_area         error_area
                             ,pn_error_number       error_number
                             ,pv_error_type         errordata.errortype%TYPE
                             ,pn_policy_reference   errordata.policy%TYPE
                             ,pv_client_category1   client_category
                             ,pn_client_reference1  client_reference
                             ,pv_client_category2   client_category
                             ,pn_client_reference2  client_reference
                             ,pv_location_code      errordata.processingdept%TYPE
                             ,pv_adp_reference      errordata.adpreference%TYPE
                             ,pv_free_text          errordata.freetext%TYPE
                             ,pv_product_reference  errordata.productreference%TYPE
                             ,pv_mix_number         NUMBER
                             ,pv_server_id          NUMBER
                             ,pv_run_number         NUMBER
                             ,pv_report_request_unq NUMBER
                             ,pv_initiator          NUMBER);

    -- Outputs a cursor (on errordata and errordefinition) for use in MC0021
    PROCEDURE p_open_cur_errordata(p_error_data IN OUT lptyp_cur_errordata
                                  ,p_coriqcode  errordefinition.coriqcode%TYPE
                                  ,p_location   errordata.processingdept%TYPE);

    -- Return the teamcode for AWD errors to be indexed under, given the input branch and consultant (NB/NCS only for now).
    FUNCTION f_get_teamcode(pv_branchcode IN teamcode.branchcode%TYPE) RETURN teamcode.teamcode%TYPE;

    -------------------------------------------------------------------------------------------------------------------
    -- Procedure to get the NB2003 failure errors - same as would appear on the Y print
    -------------------------------------------------------------------------------------------------------------------
    PROCEDURE p_get_rep_errors_policy(pv_schema      IN errordata.systemid%TYPE
                                     ,pv_report      IN errordata.sourcecode%TYPE
                                     ,pn_policy      IN errordata.policy%TYPE
                                     ,pn_proposal_id IN INTEGER
                                     ,pc_rep_errors  OUT SYS_REFCURSOR);

END pck_business_errors;
/
CREATE OR REPLACE PACKAGE BODY BUSINESSERRORS.pck_business_errors IS
    lv_freetext errordata.freetext%TYPE := ' ';

    lcv_mix_number         errordata.mixnumber%TYPE := '0';
    lcv_server_id          errordata.serverid%TYPE := '00';
    lcv_run_number         errordata.runnumber%TYPE := '0';
    lcv_request_id         errordata.requestid%TYPE := '0000000000';
    lcv_report_request_unq errordata.reportrequestunique%TYPE := '00000000';
    lcv_system_initiator   errordata.initiator%TYPE := '90000';

    --------------------------------------------------------------------------------------------------------
    -- Setup data for AWD error handling (called from 'new' PL/SQL packages). ------------------------------
    --------------------------------------------------------------------------------------------------------
    PROCEDURE p_save_data(pr_errordata IN rec_errordata) IS
    BEGIN
        lr_errordata := pr_errordata;
        lv_freetext  := pr_errordata.freetext;
    END;

    --------------------------------------------------------------------------------------------------------
    -- Procedure to call f_get_teamcode. -------------------------------------------------------------------
    --------------------------------------------------------------------------------------------------------
    PROCEDURE p_get_teamcode(pv_teamcode IN OUT teamcode.teamcode%TYPE) IS
    BEGIN
        pv_teamcode := NVL(TRIM(pck_business_errors.f_get_teamcode(pv_teamcode))
                          ,' ');
    END;

    --------------------------------------------------------------------------------------------------------
    -- Setup error code information (called from CSL_ERRMSG). ----------------------------------------------
    --------------------------------------------------------------------------------------------------------
    PROCEDURE p_save_data(pv_errorcode  IN errordata.errorcode%TYPE
                         ,pv_errortype  IN errordata.errortype%TYPE
                         ,pv_error_info IN VARCHAR2) IS
    BEGIN
        lr_errordata.errorcode := NVL(pv_errorcode
                                     ,lr_errordata.errorcode);
        lr_errordata.errortype := NVL(pv_errortype
                                     ,lr_errordata.errortype);

        -- Append formatted error message to original freetext.
        IF pv_error_info IS NOT NULL
           AND pv_error_info != ' ' THEN
            lr_errordata.freetext := SUBSTR(NVL(lv_freetext
                                               ,'') || ' ' || NVL(RTRIM(pv_error_info)
                                                                 ,'')
                                           ,1
                                           ,1803);
        END IF;
    END;

    --------------------------------------------------------------------------------------------------------
    -- Setup freetext field. -------------------------------------------------------------------------------
    --------------------------------------------------------------------------------------------------------
    PROCEDURE p_save_data(pv_freetext IN errordata.freetext%TYPE) IS
    BEGIN
        lr_errordata.freetext := NVL(pv_freetext
                                    ,lr_errordata.freetext);
    END;

    --------------------------------------------------------------------------------------------------------
    -- Log an error - just inserts the details to the ErrorData table. -------------------------------------
    --------------------------------------------------------------------------------------------------------
    PROCEDURE p_log_error IS
        lt_err_params      pck_err.t_err_param;
        lv_add_err_text    VARCHAR2(4000);
        lcv_version_number errordata.version%TYPE := '002';
        lcv_plsql_record   errordata.recordtype%TYPE := '02';

        PRAGMA AUTONOMOUS_TRANSACTION;
    BEGIN

        -- Only log if sourcecode setup & do not log warnings and systems errors.
        IF lr_errordata.sourcecode IS NOT NULL
           AND lr_errordata.errorcode IS NOT NULL
           AND (lr_errordata.errortype NOT IN ('W', 'Z') OR lr_errordata.errortype IS NULL) THEN
            INSERT INTO errordata
                (version
                ,mixnumber
                ,recordtype
                ,systemid
                ,serverid
                ,sourcecode
                ,runnumber
                ,actualdate
                ,systemdate
                ,TIME
                ,errorcode
                ,errortype
                ,requestid
                ,reportrequestunique
                ,initiator
                ,policy
                ,primaryclient
                ,secondaryclient
                ,processingdept
                ,adpreference
                ,freetext
                ,productreference
                ,statusid
                ,actualdatetime
                ,systemdatetime)
            VALUES
                (lcv_version_number -- VersionNumber      - Incremented to 002 for move to Oracle
                ,lcv_mix_number -- MixNumber
                ,lcv_plsql_record -- RecordType
                ,SUBSTR(USER
                       ,1
                       ,20) -- SystemID                - ie. Schema name
                ,lcv_server_id -- ServerID
                ,NVL(TRIM(lr_errordata.sourcecode)
                    ,' ') -- SourceCode            - What generated error? AB1234 format (from pck_audits)
                ,lcv_run_number -- RunNumber
                ,LPAD(TO_CHAR(SYSDATE
                             ,'ddmmyy')
                     ,6
                     ,0) -- ActualDate
                ,LPAD(lr_errordata.systemdate
                     ,6
                     ,0) -- SystemDate
                ,LPAD(TO_CHAR(SYSDATE
                             ,'hh24mmss')
                     ,6
                     ,0) || '00' -- Time
                ,NVL(lr_errordata.errorcode
                    ,' ') -- ErrorCode       - CS001 format error code
                ,NVL(lr_errordata.errortype
                    ,' ') -- ErrorType
                ,lcv_request_id -- RequestID
                ,lcv_report_request_unq -- ReportRequestUnique
                ,lcv_system_initiator -- Initiator
                ,NVL(lr_errordata.policy
                    ,0) -- Policy
                ,NVL(lr_errordata.primaryclient
                    ,' ') -- PrimaryClient
                ,NVL(lr_errordata.secondaryclient
                    ,' ') -- SecondaryClient
                ,NVL(lr_errordata.processingdept
                    ,' ') -- ProcessingDept   - Servicing dept of policy/scheme
                ,NVL(lr_errordata.adpreference
                    ,' ') -- ADPReference         - ADP reference, if appropriate
                ,NVL(lr_errordata.freetext
                    ,' ') -- FreeText             - free format. Label fields and separate with ~
                ,NVL(lr_errordata.productreference
                    ,' ') -- ProductReference
                ,DECODE(lr_errordata.errorcode
                       ,'ZZ9999'
                       ,15
                       ,1)
                ,SYSDATE
                ,to_date(LPAD(lr_errordata.systemdate
                             ,6
                             ,0)
                        ,'DDMMYY') -- SystemDate
                 ); -- StatusID
            COMMIT;

            -- Restore original freetext in case CSL_ERRMSG has appended to it.
            lr_errordata.freetext := lv_freetext;
        END IF;
    EXCEPTION
        WHEN dup_val_on_index THEN
            pck_err.p_handle('DUP_VAL_ON_INDEX'
                            ,lt_err_params
                            ,0
                            ,lv_add_err_text
                            ,TRUE
                            ,TRUE);
        WHEN OTHERS THEN
            pck_err.p_handle('CANNOT_INSERT_RECORD'
                            ,pck_err.t_err_param('ErrorData'
                                                ,'p_log_error')
                            ,0
                            ,lr_errordata.sourcecode || ',' || lr_errordata.errorcode
                            ,TRUE
                            ,FALSE);
    END;

    --------------------------------------------------------------------------------------------------------
    -- Log an error - just inserts the details to the ErrorData table. -------------------------------------
    --------------------------------------------------------------------------------------------------------
    PROCEDURE p_log_error_sqc(pv_source_code        errordata.sourcecode%TYPE
                             ,pn_system_date        errordata.systemdate%TYPE
                             ,pv_error_area         error_area
                             ,pn_error_number       error_number
                             ,pv_error_type         errordata.errortype%TYPE
                             ,pn_policy_reference   errordata.policy%TYPE
                             ,pv_client_category1   client_category
                             ,pn_client_reference1  client_reference
                             ,pv_client_category2   client_category
                             ,pn_client_reference2  client_reference
                             ,pv_location_code      errordata.processingdept%TYPE
                             ,pv_adp_reference      errordata.adpreference%TYPE
                             ,pv_free_text          errordata.freetext%TYPE
                             ,pv_product_reference  errordata.productreference%TYPE
                             ,pv_mix_number         NUMBER
                             ,pv_server_id          NUMBER
                             ,pv_run_number         NUMBER
                             ,pv_report_request_unq NUMBER
                             ,pv_initiator          NUMBER) IS
        lv_add_err_text VARCHAR2(4000);
        lv_error_code   VARCHAR2(10);

        lcv_version_number errordata.version%TYPE := '002';
        lcv_sqc_record     errordata.recordtype%TYPE := '01';

        PRAGMA AUTONOMOUS_TRANSACTION;
    BEGIN

        lv_error_code := LPAD(NVL(pv_error_area
                                 ,' ')
                             ,2
                             ,' ') || LPAD(pn_error_number
                                          ,4
                                          ,0);

        -- set up some error text
        lv_add_err_text := ' Policy:' || pn_policy_reference || ' Source:' || pv_source_code || ' System_date:' ||
                           pn_system_date;

        -- Do not log warnings and systems errors.
        IF pv_error_type NOT IN ('W', 'Z')
           OR pv_error_type IS NULL THEN
            INSERT INTO errordata
                (version
                ,mixnumber
                ,recordtype
                ,systemid
                ,serverid
                ,sourcecode
                ,runnumber
                ,actualdate
                ,systemdate
                ,TIME
                ,errorcode
                ,errortype
                ,requestid
                ,reportrequestunique
                ,initiator
                ,policy
                ,primaryclient
                ,secondaryclient
                ,processingdept
                ,adpreference
                ,freetext
                ,productreference
                ,statusid
                ,actualdatetime
                ,systemdatetime)
            VALUES
                (lcv_version_number -- VersionNumber   - Incremented to 002 for move to Oracle
                ,NVL(pv_mix_number
                    ,lcv_mix_number) -- MixNumber
                ,lcv_sqc_record -- RecordType
                ,SUBSTR(USER
                       ,1
                       ,20) -- SystemID             - ie. Schema name
                ,NVL(pv_server_id
                    ,lcv_server_id) -- ServerID
                ,NVL(TRIM(pv_source_code)
                    ,' ') -- SourceCode            - What generated error? AB1234 format (from pck_audits)
                ,NVL(pv_run_number
                    ,lcv_run_number) -- RunNumber
                ,LPAD(TO_CHAR(SYSDATE
                             ,'ddmmyy')
                     ,6
                     ,0) -- ActualDate
                ,LPAD(pn_system_date
                     ,6
                     ,0) -- SystemDate
                ,LPAD(TO_CHAR(SYSDATE
                             ,'hh24mmss') || '00'
                     ,8
                     ,0) -- Time
                ,lv_error_code -- ErrorCode         - CS001 format error code
                ,NVL(pv_error_type
                    ,' ') -- ErrorType
                ,lcv_request_id -- RequestID
                ,NVL(pv_report_request_unq
                    ,lcv_report_request_unq) -- ReportRequestUnique
                ,NVL(pv_initiator
                    ,lcv_system_initiator) -- Initiator
                ,pn_policy_reference -- Policy
                ,LPAD(NVL(pv_client_category1
                         ,' ')
                     ,3
                     ,' ') || LPAD(pn_client_reference1
                                  ,8
                                  ,0) -- PrimaryClient
                ,LPAD(NVL(pv_client_category2
                         ,' ')
                     ,3
                     ,' ') || LPAD(pn_client_reference2
                                  ,8
                                  ,0) -- SecondaryClient
                ,NVL(pv_location_code
                    ,' ') -- ProcessingDept        - Servicing dept of policy/scheme
                ,NVL(pv_adp_reference
                    ,' ') -- ADPReference         - ADP reference, if appropriate
                ,NVL(pv_free_text
                    ,' ') -- FreeText             - free format. Label fields and separate with ~
                ,NVL(pv_product_reference
                    ,' ') -- ProductReference
                ,DECODE(lv_error_code
                       ,'ZZ9999'
                       ,15
                       ,1)

                ,SYSDATE
                ,CASE WHEN pn_system_date IS NOT NULL AND pn_system_date != 0 THEN to_date(LPAD(pn_system_date
                             ,6
                             ,0)
                        ,'DDMMYY') -- SystemDate
                 ELSE NULL END); -- StatusID
            COMMIT;
        END IF;
    EXCEPTION
        WHEN dup_val_on_index THEN
            pck_err.p_handle('DUP_VAL_ON_INDEX'
                            ,pck_err.t_err_param(''
                                                ,'ErrorData')
                            ,0
                            ,'p_log_error_sqc'
                            ,TRUE
                            ,FALSE);
        WHEN OTHERS THEN
            pck_err.p_handle('CANNOT_INSERT_RECORD'
                            ,pck_err.t_err_param('ErrorData'
                                                ,'p_log_error_sqc')
                            ,0
                            ,lv_add_err_text
                            ,TRUE
                            ,FALSE);
    END;

    --------------------------------------------------------------------------------------------------------
    -- Outputs a record from errordata table for use in MC0021. --------------------------------------------
    --------------------------------------------------------------------------------------------------------
    PROCEDURE p_open_cur_errordata(p_error_data IN OUT lptyp_cur_errordata
                                  ,p_coriqcode  errordefinition.coriqcode%TYPE
                                  ,p_location   errordata.processingdept%TYPE) IS

    BEGIN
        OPEN p_error_data FOR
            SELECT a.systemdate
                  ,a.sourcecode
                  ,a.errorcode
                  ,a.policy
                  ,a.primaryclient
                  ,b.awdservicestandard
            FROM   errordata       a
                  ,errordefinition b
            WHERE  a.sourcecode IN ('WB1205', 'FI1205', 'FI0490', 'FI1200', 'FI1201', 'FI1202', 'FI0750', 'TH0001')
            AND    a.statusid = 2
            AND    RTRIM(coriqcode) = RTRIM(p_coriqcode)
            AND    RTRIM(processingdept) = RTRIM(p_location)
            AND    RTRIM(a.sourcecode) = RTRIM(b.sourcecode)
            AND    RTRIM(a.errorcode) = RTRIM(b.errorcode);
    END p_open_cur_errordata;

    --------------------------------------------------------------------------------------------------------
    -- Return the teamcode for the input branch & consultant. ----------------------------------------------
    --------------------------------------------------------------------------------------------------------
    FUNCTION f_get_teamcode(pv_branchcode IN teamcode.branchcode%TYPE) RETURN teamcode.teamcode%TYPE IS
        lv_teamcode teamcode.teamcode%TYPE := ' ';
    BEGIN

        -- Find the teamcode which matches the input branch - for TS branch, the consultant number is required
        -- to derive the team. Conveniently, this is held on AWD so this work needs done by ErrProcessor.exe
        -- which requires to be passed TS as processingdept and ITR in the secondaryclient field. Magic.
        IF RTRIM(pv_branchcode) != 'TS' THEN
            SELECT teamcode
            INTO   lv_teamcode
            FROM   teamcode
            WHERE  RTRIM(branchcode) = RTRIM(pv_branchcode)
            AND    consultantnumber IS NULL;
        ELSE
            -- Return TS if thats input.
            lv_teamcode := RTRIM(pv_branchcode);
        END IF;

        RETURN lv_teamcode;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            pck_err.p_handle('NO_DATA_FOUND'
                            ,pck_err.t_err_param('teamcode')
                            ,0
                            ,pv_branchcode
                            ,TRUE
                            ,TRUE);
        WHEN too_many_rows THEN
            pck_err.p_handle('TOO_MANY_ROWS'
                            ,pck_err.t_err_param('teamcode')
                            ,0
                            ,pv_branchcode
                            ,TRUE
                            ,TRUE);
    END;

    -------------------------------------------------------------------------------------------------------------------
    -- Procedure to get the failure errors - same as would appear on the Y print
    -------------------------------------------------------------------------------------------------------------------
    PROCEDURE p_get_rep_errors_policy(pv_schema      IN errordata.systemid%TYPE
                                     ,pv_report      IN errordata.sourcecode%TYPE
                                     ,pn_policy      IN errordata.policy%TYPE
                                     ,pn_proposal_id IN INTEGER
                                     ,pc_rep_errors  OUT SYS_REFCURSOR) AS
    BEGIN

        OPEN pc_rep_errors FOR
            SELECT trunc(systemdatetime) AS run_date
                  ,err.errortype AS error_type
                  ,err.errorcode AS code
                  ,cs.sysdescription AS errmsg

                  ,to_number(SUBSTR(freetext
                                   ,5
                                   ,16)) AS error_int
                  ,SUBSTR(freetext
                         ,22
                         ,16) AS error_dec
                  ,SUBSTR(freetext
                         ,39
                         ,25) AS error_alp
            FROM   errordata err
            INNER  JOIN errorerrorcodedescription cs ON cs.errorcode = err.errorcode
            WHERE  err.policy = pn_policy
            AND    err.sourcecode = pv_report
            AND    to_number(SUBSTR(err.freetext
                                   ,1
                                   ,3)) = pn_proposal_id
            AND    SUBSTR(err.systemid
                         ,1
                         ,5) = pv_schema
            AND    err.mixnumber = (SELECT mixnumber
                                    FROM   (SELECT mixnumber
                                                  ,rank() over(PARTITION BY policy ORDER BY actualdatetime DESC, errordataid DESC) ran
                                            FROM   errordata err1
                                            WHERE  err1.policy = pn_policy
                                            AND    err1.sourcecode = pv_report
                                            AND    to_number(SUBSTR(err1.freetext
                                                                   ,1
                                                                   ,3)) = pn_proposal_id
                                            AND    SUBSTR(err1.systemid
                                                         ,1
                                                         ,5) = pv_schema)
                                    WHERE  ran = 1);

    END p_get_rep_errors_policy;

END pck_business_errors;
/
