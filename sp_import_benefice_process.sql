-- ================================================
-- Template generated from Template Explorer using:
-- Create Procedure (New Menu).SQL
--
-- Use the Specify Values for Template Parameters 
-- command (Ctrl-Shift-M) to fill in the parameter 
-- values below.
--
-- This block of comments will not be included in
-- the definition of the procedure.
-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE sp_import_benefice_process
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	Declare @xmlOut varchar(8000) ;
	Declare @RequestText as nvarchar(max) = ''; 
	Declare @HeaderText as varchar(2000); 
	Declare @MetaText as varchar(2000); 
	Declare @getdate as varchar(35);        
    Declare @URI varchar(2000);         
    Declare @methodName varchar(50);     
    Declare @SoapAction varchar(255);     
    Declare @UserName nvarchar(100);    
    Declare @Password nvarchar(100);
	Declare  @CodeProjet nvarchar(30),@parent_case_id nvarchar(34),@parent_case_type nvarchar(20),@case_type nvarchar(20),@caseid nvarchar(34),@Benefice nvarchar(20),@DateDecision nvarchar(20),@Expediteur nvarchar(20),@Confirme nvarchar(4),
		 @DateConfirmation nvarchar(20),@DateConfirmationSystem nvarchar(50),@ConfirmationUser nvarchar(30),@CreationDate nvarchar(50),@CreationUser nvarchar(30),@UpdateDate nvarchar(32),@UpdateUser nvarchar(30);

	set @getdate = (select CONVERT(varchar(32), GETDATE(),127)+'Z');
	set @HeaderText = '<?xml version="1.0" ?>
							<data name="Benefices"
									uiVersion="1"
									version="1"
									xmlns="http://openrosa.org/formdesigner/A2C1363F-FB63-4ED6-B5AC-9EE1665276DB">
								  '
	set @MetaText = '
							  <!-- ... meta ... -->
 								<meta xmlns:cc="http://commcarehq.org/xforms">        
									<deviceID>script_sql_process</deviceID>       
									<timeStart>'+ CAST(@getdate as varchar(32)) + '</timeStart>
									<timeEnd>'+ CAST(@getdate as varchar(32)) + '</timeEnd>       
									<username>scriptsql@api-test.commcarehq.org</username> 
									<userID>b52b82f9a31741339c8a1e2b575cec82</userID>
									<instanceID>'+ REPLACE(lower(NEWid()),'-','') + '</instanceID>
									<cc:appVersion/>

								</meta> 
							</data>'
	BEGIN TRANSACTION
	IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BENEFICIAIRE_TABLE]') AND type in (N'U'))
	DROP TABLE [dbo].BENEFICIAIRE_TABLE;
	
	SELECT
	*
	INTO BENEFICIAIRE_TABLE
	FROM [BIDFAES].[dbo].[V_Benefice];
	
	SET @RequestText = @HeaderText;

	DECLARE cur_request_ben CURSOR   
    LOCAL FAST_FORWARD    
    FOR   
        SELECT 
			*
		FROM BENEFICIAIRE_TABLE   ;
    OPEN cur_request_ben    
    FETCH NEXT FROM cur_request_ben    
    INTO @CodeProjet,@parent_case_id,@parent_case_type,@case_type,@caseid,@Benefice,@DateDecision,@Expediteur,@Confirme,
		 @DateConfirmation,@DateConfirmationSystem,@ConfirmationUser,@CreationDate,@CreationUser,@UpdateDate,@UpdateUser   
    WHILE @@FETCH_STATUS = 0    
    BEGIN   
		SET @RequestText = @RequestText + '

		<n0:case user_id="b52b82f9a31741339c8a1e2b575cec82"
			xmlns:n0="http://commcarehq.org/case/transaction/v2"
			case_id="'+ @caseid +'"
			parent_case_id="'+ @parent_case_id +'"
			parent_case_type="'+ @parent_case_type +'">
			<n0:create>
				<n0:parent_case_name>'+ @CodeProjet +'</n0:parent_case_name>
				<n0:case_name>'+ @Benefice +'</n0:case_name>
				<n0:case_type>'+ @case_type +'</n0:case_type>
			</n0:create>
			<n0:update>
				<n0:datedecision>'+ @DateDecision +'</n0:datedecision>
				<n0:Expediteur>'+ @Expediteur +'</n0:Expediteur>
				<n0:Confirme>'+ @Confirme +'</n0:Confirme>
				<n0:DateConfirmation>'+ @DateConfirmation +'</n0:DateConfirmation>
				<n0:DateConfirmationSystem>'+ @DateConfirmationSystem +'</n0:DateConfirmationSystem>
				<n0:ConfirmationUser>'+ @ConfirmationUser +'</n0:ConfirmationUser>
				<n0:CreationDate>'+ @CreationDate +'</n0:CreationDate>
				<n0:CreationUser>'+ @CreationUser +'</n0:CreationUser>
				<n0:UpdateDate>'+ @UpdateDate +'</n0:UpdateDate>
				<n0:UpdateUser>'+ @UpdateUser +'</n0:UpdateUser>
			</n0:update>
		  </n0:case>		  
		  '
		  
          FETCH NEXT FROM cur_request_ben    
          INTO  @CodeProjet,@parent_case_id,@parent_case_type,@case_type,@caseid,@Benefice,@DateDecision,@Expediteur,@Confirme,
				@DateConfirmation,@DateConfirmationSystem,@ConfirmationUser,@CreationDate,@CreationUser,@UpdateDate,@UpdateUser    
    END   
    CLOSE cur_request_ben    
    DEALLOCATE cur_request_ben 


    --SET @RequestText= (SELECT * FROM [dbo].[V_Recrutement] FOR XML RAW, ELEMENTS) ;

	SET @RequestText = @RequestText + @MetaText;
	SET @URI = 'https://www.commcarehq.org/a/api-test/receiver/api/';         
    SET @methodName= 'POST';   
    SET @SoapAction = 'https://www.commcarehq.org/a/api-test/receiver/submission/';    
    SET @UserName = 'wfleurimond@gheskio.org';     
    SET @Password = 'xxxxxxxxxxxxx'; 

	--SELECT @RequestText;
	exec [dbo].[sp_post_data_2_dimagi]  @RequestText,  @URI,  @methodName,    @SoapAction,   @UserName, @Password, @xmlOut out  ;


	IF @xmlOut LIKE '%submit_success%' 
	BEGIN
		--select @xmlOut Reponse;
		UPDATE bf 
		SET bf.[is_imported] = 2, [Date_imported] = GETDATE()
		FROM [BIDFAES].[dbo].[bf_dimagi_correspond_benefice] bf
			INNER JOIN BENEFICIAIRE_TABLE rt ON rt.[caseid] = bf.[Case_id]		
		WHERE [Date_imported] IS NULL;
	END
	COMMIT TRANSACTION;
END
GO

--EXEC [dbo].[sp_import_data_process];



