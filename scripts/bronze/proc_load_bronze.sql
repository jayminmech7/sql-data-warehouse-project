/*
===============================================================================
Stored Procedure: bronze.load_bronze
===============================================================================
Purpose     : Loads data from CSV files into the 'bronze' schema tables.
              - Truncates each bronze table.
              - Loads data via BULK INSERT from corresponding CSV files.
              - Prints row count for verification after each load.
              - Uses dynamic SQL for BULK INSERT to avoid context/permission issues.
Parameters  : None.
Returns     : None (progress and row counts are printed to the Messages window).
Usage       : EXEC bronze.load_bronze;
Notes       : 
  - Make sure the CSV files exist at the specified paths and SQL Server
    service account has read access.
  - Do NOT wrap BULK INSERT in TRY/CATCH unless you require error trapping.
  - Using dynamic SQL for BULK INSERT ensures compatibility across environments.
===============================================================================
*/
CREATE OR ALTER PROCEDURE bronze.load_bronze
AS
BEGIN
    DECLARE @rowcount INT;
    DECLARE @sql NVARCHAR(MAX);

    PRINT '================================================';
    PRINT 'Loading Bronze Layer (Dynamic SQL BULK INSERT)';
    PRINT '================================================';

    -- ========================
    -- CRM TABLES
    -- ========================
    PRINT '------------------------------------------------';
    PRINT 'Loading CRM Tables';
    PRINT '------------------------------------------------';

    -- crm_cust_info
    PRINT 'Truncating and Loading bronze.crm_cust_info...';
    TRUNCATE TABLE bronze.crm_cust_info;
    SET @sql = N'BULK INSERT bronze.crm_cust_info
        FROM ''C:\sql\dwh_project\datasets\source_crm\cust_info.csv''
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = '','',
            TABLOCK
        )';
    EXEC(@sql);
    SELECT @rowcount = COUNT(*) FROM bronze.crm_cust_info;
    PRINT 'Rows loaded: ' + CAST(@rowcount AS NVARCHAR);

    -- crm_prd_info
    PRINT 'Truncating and Loading bronze.crm_prd_info...';
    TRUNCATE TABLE bronze.crm_prd_info;
    SET @sql = N'BULK INSERT bronze.crm_prd_info
        FROM ''C:\sql\dwh_project\datasets\source_crm\prd_info.csv''
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = '','',
            TABLOCK
        )';
    EXEC(@sql);
    SELECT @rowcount = COUNT(*) FROM bronze.crm_prd_info;
    PRINT 'Rows loaded: ' + CAST(@rowcount AS NVARCHAR);

    -- crm_sales_details
    PRINT 'Truncating and Loading bronze.crm_sales_details...';
    TRUNCATE TABLE bronze.crm_sales_details;
    SET @sql = N'BULK INSERT bronze.crm_sales_details
        FROM ''C:\sql\dwh_project\datasets\source_crm\sales_details.csv''
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = '','',
            TABLOCK
        )';
    EXEC(@sql);
    SELECT @rowcount = COUNT(*) FROM bronze.crm_sales_details;
    PRINT 'Rows loaded: ' + CAST(@rowcount AS NVARCHAR);

    -- ========================
    -- ERP TABLES
    -- ========================
    PRINT '------------------------------------------------';
    PRINT 'Loading ERP Tables';
    PRINT '------------------------------------------------';

    -- erp_loc_a101
    PRINT 'Truncating and Loading bronze.erp_loc_a101...';
    TRUNCATE TABLE bronze.erp_loc_a101;
    SET @sql = N'BULK INSERT bronze.erp_loc_a101
        FROM ''C:\sql\dwh_project\datasets\source_erp\loc_a101.csv''
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = '','',
            TABLOCK
        )';
    EXEC(@sql);
    SELECT @rowcount = COUNT(*) FROM bronze.erp_loc_a101;
    PRINT 'Rows loaded: ' + CAST(@rowcount AS NVARCHAR);

    -- erp_cust_az12
    PRINT 'Truncating and Loading bronze.erp_cust_az12...';
    TRUNCATE TABLE bronze.erp_cust_az12;
    SET @sql = N'BULK INSERT bronze.erp_cust_az12
        FROM ''C:\sql\dwh_project\datasets\source_erp\cust_az12.csv''
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = '','',
            TABLOCK
        )';
    EXEC(@sql);
    SELECT @rowcount = COUNT(*) FROM bronze.erp_cust_az12;
    PRINT 'Rows loaded: ' + CAST(@rowcount AS NVARCHAR);

    -- erp_px_cat_g1v2
    PRINT 'Truncating and Loading bronze.erp_px_cat_g1v2...';
    TRUNCATE TABLE bronze.erp_px_cat_g1v2;
    SET @sql = N'BULK INSERT bronze.erp_px_cat_g1v2
        FROM ''C:\sql\dwh_project\datasets\source_erp\px_cat_g1v2.csv''
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = '','',
            TABLOCK
        )';
    EXEC(@sql);
    SELECT @rowcount = COUNT(*) FROM bronze.erp_px_cat_g1v2;
    PRINT 'Rows loaded: ' + CAST(@rowcount AS NVARCHAR);

    PRINT '================================================';
    PRINT 'Bronze Layer Load Completed';
    PRINT '================================================';
END


/*
...
Usage       : EXEC bronze.load_bronze;
...
*/
