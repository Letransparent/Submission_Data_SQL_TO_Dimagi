-- ================================================
-- Template generated from Template Explorer using:
-- Create Trigger (New Menu).SQL
--
-- Use the Specify Values for Template Parameters 
-- command (Ctrl-Shift-M) to fill in the parameter 
-- values below.
--
-- See additional Create Trigger templates for more
-- examples of different Trigger statements.
--
-- This block of comments will not be included in
-- the definition of the function.
-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Wilson FLEURIMOND
-- Create date: 18/08/2022
-- Description:	Declencheur devant alimenter la table [bf_dimagi_correspondance] à chaque recrutement
-- =============================================
CREATE TRIGGER dbo.tr_populate_dimagi_correspondance 
   ON  dbo.RECRUTEMENT 
   AFTER INSERT
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for trigger here
	DECLARE @code_projet VARCHAR(28)
	DECLARE @var_case_id VARCHAR(32)

	SELECT @var_case_id = REPLACE(lower(NEWid()),'-','')

	IF EXISTS ( SELECT 0 FROM Inserted )
		BEGIN
			IF NOT EXISTS (SELECT 0 FROM BIDFAES.dbo.bf_dimagi_correspondance bf WHERE bf.[CodeProjet] = (SELECT J.[CodeProjet] FROM Inserted J))
				BEGIN
					INSERT INTO dbo.bf_dimagi_correspondance
							( [CodeProjet],
							  [Pat_net_id],
							  [Case_id] 
							  --[is_imported] ,
							 -- [Date_imported]
							)
							SELECT  I.[CodeProjet] ,
									I.[PatNetId] ,
									@var_case_id 
							FROM    Inserted I
				END
		END
END
GO


SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Wilson FLEURIMOND
-- Create date: 18/08/2022
-- Description:	Declencheur devant alimenter la table [bf_dimagi_correspond_benefice] à chaque recrutement
-- =============================================
CREATE TRIGGER dbo.tr_populate_dimagi_correspond_benefice 
   ON  dbo.BENEFICE 
   AFTER INSERT
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for trigger here
	DECLARE @var_case_id VARCHAR(32)

	SELECT @var_case_id = REPLACE(lower(NEWid()),'-','')

	IF EXISTS ( SELECT 0 FROM Inserted )
		BEGIN
			IF NOT EXISTS (SELECT 0 FROM BIDFAES.dbo.bf_dimagi_correspond_benefice bf WHERE bf.[BeneficeID] = (SELECT J.[Id] FROM Inserted J))
				BEGIN
					INSERT INTO dbo.bf_dimagi_correspond_benefice
							( [BeneficeID],
							  [Parent_case_id],
							  [Case_id] 
							  --[is_imported] ,
							 -- [Date_imported]
							)
							SELECT  I.[Id] ,
									bc.[Case_id],
									@var_case_id 
							FROM    Inserted I
							INNER JOIN dbo.bf_dimagi_correspondance bc ON bc.[CodeProjet] = I.CodeProjet
				END
		END
END
GO
