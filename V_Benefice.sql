/****** Script for SelectTopNRows command from SSMS  ******/
USE [BIDFAES]
GO

/****** Object:  View [dbo].[V_Benefice]    Script Date: 8/19/2022 11:18:30 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE view [dbo].[V_Benefice]
as

SELECT		   r.[CodeProjet]
			  ,bd.Case_id parent_case_id
			  ,'case_benefice' case_type
			  ,ben.Case_id
			 -- ,b.Id [BeneficeID]
			  ,tb.[Benefice]
			  ,[DateDecision]
			  ,ex.[Descrip] Expediteur
			  ,CASE WHEN b.[Confirme] = 1 THEN 'OUI'
					WHEN b.[Confirme] = 2 THEN 'NON'
					ELSE NULL END [Confirme]
			  ,b.[DateConfirmation]
			  ,b.[DateConfirmationSystem]
			  ,b.[ConfirmationUser]
			 -- ,b.[DateDeconfirme]
			 -- ,b.[UserDeconfirme]
			  ,b.[CreationDate]
			  ,b.[CreationUser]
			  ,b.[UpdateDate]
			  ,b.[UpdateUser]
		  FROM [BIDFAES].[dbo].RECRUTEMENT r 
			  INNER JOIN [BIDFAES].[dbo].[BENEFICE] b ON b.CodeProjet = r.CodeProjet AND b.Voided = 2 
			  INNER JOIN [BIDFAES].[dbo].[SITE_DISTRIBUTION] sd ON sd.Id = r.Site AND sd.Voided = 2
			  INNER JOIN [BIDFAES].[dbo].[bf_dimagi_correspondance] bd ON bd.CodeProjet = r.CodeProjet
			  INNER JOIN [BIDFAES].[dbo].[bf_dimagi_correspond_benefice] ben ON ben.[BeneficeID] = b.Id AND ben.[is_imported] = 2 AND ben.[Date_imported] IS NULL 
			  LEFT OUTER JOIN [BIDFAES].dbo.EXPEDITEUR ex ON ex.Id = b.Expediteur AND ex.Voided = 2
			  LEFT OUTER JOIN [BIDFAES].dbo.TYPE_BENEFICE tb ON tb.CodeBenefice = b.CodeBenefice
		  WHERE r.Voided = 2


GO

/* sp_configure 'show advanced options', 1;
GO
RECONFIGURE;
GO
sp_configure 'Ole Automation Procedures', 1;
GO
RECONFIGURE;
GO */


