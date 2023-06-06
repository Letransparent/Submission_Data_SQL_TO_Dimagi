
USE [BIDFAES]
GO

/****** Object:  Table [dbo].[bf_dimagi_correspondance]    Script Date: 8/18/2022 11:42:59 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[bf_dimagi_correspondance](
	[CodeProjet] [varchar](50) NOT NULL,
	[Pat_net_id] [varchar](50) NULL,
	[Case_id] [varchar](50) NOT NULL,
	[is_imported] [int] NOT NULL,
	[Date_imported] [datetime] NULL,
 CONSTRAINT [UK_Beneficiaire] UNIQUE NONCLUSTERED 
(
	[CodeProjet] ASC,
	[Case_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[bf_dimagi_correspondance] ADD  DEFAULT ((1)) FOR [is_imported]
GO

ALTER TABLE [dbo].[bf_dimagi_correspondance]  WITH CHECK ADD  CONSTRAINT [FK_CodeProjet] FOREIGN KEY([CodeProjet])
REFERENCES [dbo].[RECRUTEMENT] ([CodeProjet])
GO

ALTER TABLE [dbo].[bf_dimagi_correspondance] CHECK CONSTRAINT [FK_CodeProjet]
GO



USE [BIDFAES]
GO

/****** Object:  Table [dbo].[bf_dimagi_correspondance]    Script Date: 8/18/2022 11:42:59 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[bf_dimagi_correspond_benefice](
	[BeneficeID] int NOT NULL,
	[Parent_case_id] [varchar](32) NULL,
	[Case_id] [varchar](50) NOT NULL,
	[is_imported] [int] NOT NULL,
	[Date_imported] [datetime] NULL,
 CONSTRAINT [UK_Benefice] UNIQUE NONCLUSTERED 
(
	--[Parent_case_id] ASC,
	[Case_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[bf_dimagi_correspond_benefice] ADD  DEFAULT ((1)) FOR [is_imported]
GO

ALTER TABLE [dbo].[bf_dimagi_correspond_benefice]  WITH CHECK ADD  CONSTRAINT [FK_BeneficeID] FOREIGN KEY([BeneficeID])
REFERENCES [dbo].[BENEFICE] ([Id])
GO

ALTER TABLE [dbo].[bf_dimagi_correspond_benefice]  WITH CHECK ADD  CONSTRAINT [FK_ParentCaseID] FOREIGN KEY([Parent_case_id])
REFERENCES [dbo].[bf_dimagi_correspondance] ([Case_id])
GO

ALTER TABLE [dbo].[bf_dimagi_correspond_benefice] CHECK CONSTRAINT [Case_id]
GO


