
/****** Script for SelectTopNRows command from SSMS  ******/
USE [BIDFAES]
GO

/****** Object:  View [dbo].[V_Recrutement]    Script Date: 8/19/2022 11:18:30 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE view [dbo].[V_Recrutement]
as
SELECT sd.Descript [Site]
			  ,r.[Clinic]
			  ,r.[PatNetId]
			  ,r.[CodeProjet]
			  ,bd.Case_id
			  ,'case_patient' type_case
			  ,r.[Prenom]
			  ,r.[Nom]
			  ,CASE WHEN r.[Sexe] = 1 THEN 'F'
					WHEN r.[Sexe] = 2 THEN 'M'
					ELSE NULL END [Sexe]
			  ,r.[DateNaiss]
			  ,r.[Age]
			  ,CASE WHEN r.[Enceinte] = 1 THEN 'OUI'
					WHEN r.[Enceinte] = 2 THEN 'NON'
					ELSE NULL END [Enceinte]
			  ,CASE WHEN r.[CinNif] = 1 THEN 'CIN'
					WHEN r.[CinNif] = 2 THEN 'NIF'
					ELSE NULL END [CinNif]
			  ,r.[Cin/Nif]
			  ,r.[Phone]
			  ,r.[Depart] Departement
			  ,com.[Desc] Commune
			  , loc.[Desc] LOCALITE
			  ,r.[Adresse] 
			  ,CASE WHEN r.Q7_4 = 4 THEN 'OUI' ELSE 'NON' END Victime_Violence_Sex
			  ,CASE WHEN r.Q4_1 = 1 THEN 'Primaire' 
					WHEN r.Q4_1 = 2 THEN 'Secondaire' 
					WHEN r.Q4_1 = 3 THEN 'Post Secondaire' 
					WHEN r.Q4_1 = 4 THEN 'Aucun' 
					ELSE NULL END Niveau_Etude
		  FROM [BIDFAES].[dbo].RECRUTEMENT r 
			  INNER JOIN [BIDFAES].[dbo].[SITE_DISTRIBUTION] sd ON sd.Id = r.Site AND sd.Voided = 2
			  INNER JOIN [BIDFAES].[dbo].[bf_dimagi_correspondance] bd ON bd.CodeProjet = r.CodeProjet AND bd.[is_imported] = 2 AND bd.[Date_imported] IS NULL
			  LEFT OUTER JOIN [BIDFAES].[dbo].[Comm] com ON com.Id = r.Commune AND com.Voided = 2
			  LEFT OUTER JOIN [BIDFAES].[dbo].[LOCALITE] loc ON loc.Id = r.localite
		  WHERE r.Voided = 2
GO
