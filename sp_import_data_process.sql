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
ALTER PROCEDURE sp_import_data_process
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
	Declare  @site nvarchar(100),@clinique nvarchar(25),@pat_net_id nvarchar(30),@case_name nvarchar(30),@caseid nvarchar(34),@type_case nvarchar(20),@prenom nvarchar(120),@nom nvarchar(100),@sexe nvarchar(2),
	@date_de_naissance nvarchar(12),@age varchar(4),@enceinte nvarchar(4),@piece nvarchar(5),@numero_identification nvarchar(25),@telephone nvarchar(30),@departement nvarchar(20),@commune nvarchar(100),@localite nvarchar(100),@adresse nvarchar(255),@Victime_Violence_Sex nvarchar(4),@Niveau_Etude nvarchar(20)

	set @getdate = (select CONVERT(varchar(32), GETDATE(),127)+'Z');
	set @HeaderText = '<?xml version="1.0" ?>
							<data name="Info Beneficiaire"
								  uiVersion="1"
								  version="1"
								  xmlns="http://openrosa.org/formdesigner/4EFCC8A9-1AD5-4D7C-AFA1-17E0B922CCB5">
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
	IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RECRUTEMENT_TABLE]') AND type in (N'U'))
	DROP TABLE [dbo].RECRUTEMENT_TABLE;
	
	SELECT
	*
	INTO RECRUTEMENT_TABLE
	FROM [dbo].[V_Recrutement];
	
	SET @RequestText = @HeaderText;

	DECLARE cur_request CURSOR   
    LOCAL FAST_FORWARD    
    FOR   
        SELECT 
			*
		FROM RECRUTEMENT_TABLE   ;
    OPEN cur_request    
    FETCH NEXT FROM cur_request    
    INTO @site,@clinique,@pat_net_id,@case_name,@caseid,@type_case,@prenom,@nom,@sexe,@date_de_naissance,@age,@enceinte
		,@piece,@numero_identification,@telephone,@departement,@commune,@localite,@adresse,@Victime_Violence_Sex,@Niveau_Etude   
    WHILE @@FETCH_STATUS = 0    
    BEGIN   
		SET @RequestText = @RequestText + '

		<n0:case user_id="9cec716348d2632b942db81950eec782"
			xmlns:n0="http://commcarehq.org/case/transaction/v2"
			case_id="'+ @caseid +'">
			<n0:create>
				<n0:case_name>'+ @case_name +'</n0:case_name>
				<n0:case_type>'+ @type_case +'</n0:case_type>				
			</n0:create>
			<n0:update>
				<n0:site>'+ @site +'</n0:site>
				<n0:clinique>'+ @clinique +'</n0:clinique>
				<n0:pat_net_id>'+ @pat_net_id +'</n0:pat_net_id>
				<n0:prenom>'+ @prenom +'</n0:prenom>
				<n0:nom>'+ @nom +'</n0:nom>
				<n0:sexe>'+ @sexe +'</n0:sexe>
				<n0:date_de_naissance>'+ @date_de_naissance +'</n0:date_de_naissance>
				<n0:age>'+ @age +'</n0:age>
				<n0:piece>'+ @piece +'</n0:piece>
				<n0:numero_identification>'+ @numero_identification +'</n0:numero_identification>
				<n0:telephone>'+ @telephone +'</n0:telephone>
				<n0:departement>'+ @departement +'</n0:departement>
				<n0:commune>'+ @commune +'</n0:commune>
				<n0:localite>'+ @localite +'</n0:localite>
				<n0:adresse>'+ @adresse +'</n0:adresse>
				<n0:Victime_Violence_Sex>'+ @Victime_Violence_Sex +'</n0:Victime_Violence_Sex>
				<n0:Niveau_Etude>'+ @Niveau_Etude +'</n0:Niveau_Etude>
			</n0:update>
		  </n0:case>		  
		  '
		  
          FETCH NEXT FROM cur_request    
          INTO  @site,@clinique,@pat_net_id,@case_name,@caseid,@type_case,@prenom,@nom,@sexe,@date_de_naissance,@age,@enceinte
				,@piece,@numero_identification,@telephone,@departement,@commune,@localite,@adresse,@Victime_Violence_Sex,@Niveau_Etude    
    END   
    CLOSE cur_request    
    DEALLOCATE cur_request 


    --SET @RequestText= (SELECT * FROM [dbo].[V_Recrutement] FOR XML RAW, ELEMENTS) ;

	SET @RequestText = @RequestText + @MetaText;
	SET @URI = 'https://www.commcarehq.org/a/api-test/receiver/api/';         
    SET @methodName= 'POST';   
    SET @SoapAction = 'https://www.commcarehq.org/a/api-test/receiver/submission/';    
    SET @UserName = 'wfleurimond@gheskio.org';     
    SET @Password = 'xxxxxxxxxxx'; 

	--SELECT @RequestText;
	exec [dbo].[sp_post_data_2_dimagi]  @RequestText,  @URI,  @methodName,    @SoapAction,   @UserName, @Password, @xmlOut out  ;


	IF @xmlOut LIKE '%submit_success%' 
	BEGIN
		--select @xmlOut Reponse;
		UPDATE bf 
		SET bf.[is_imported] = 2, [Date_imported] = GETDATE()
		FROM [BIDFAES].[dbo].[bf_dimagi_correspondance] bf
			INNER JOIN RECRUTEMENT_TABLE rt ON rt.[Case_id] = bf.[Case_id]		
		WHERE [Date_imported] IS NULL;
	END
	COMMIT TRANSACTION;
END
GO

/*

EXEC [dbo].[sp_import_data_process];

*/
