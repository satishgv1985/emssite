/*
   29 October 201311:15:50
   User: sa
   Server: localhost
   Database: JNTUAEMS
   Application: 
*/

/* To prevent any potential data loss issues, you should review this script in detail before running it outside the context of the database designer.*/
BEGIN TRANSACTION
SET QUOTED_IDENTIFIER ON
SET ARITHABORT ON
SET NUMERIC_ROUNDABORT OFF
SET CONCAT_NULL_YIELDS_NULL ON
SET ANSI_NULLS ON
SET ANSI_PADDING ON
SET ANSI_WARNINGS ON
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.ExamNotification
	DROP CONSTRAINT FK_ExamNotification_Regulation
GO
ALTER TABLE dbo.Regulation SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.ExamNotification
	DROP CONSTRAINT FK_ExamNotification_Semester
GO
ALTER TABLE dbo.Semester SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.ExamNotification
	DROP CONSTRAINT FK_ExamNotification_Course
GO
ALTER TABLE dbo.Course SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.ExamNotification
	DROP CONSTRAINT DF_ExamNotification_IsRegular
GO
ALTER TABLE dbo.ExamNotification
	DROP CONSTRAINT DF_ExamNotification_ApplyJumbling
GO
ALTER TABLE dbo.ExamNotification
	DROP CONSTRAINT DF_ExamNotification_AlterDate
GO
CREATE TABLE dbo.Tmp_ExamNotification
	(
	ExamNotificationID smallint NOT NULL IDENTITY (1, 1),
	ExamNotificationCode nvarchar(50) NULL,
	ExamNotificationYear smallint NULL,
	ExamNotificationMonth tinyint NULL,
	CourseID tinyint NOT NULL,
	SemesterID smallint NOT NULL,
	IsRegular tinyint NOT NULL,
	MemorandumOfMarksFee money NULL,
	CostOfApplication money NULL,
	ExamCommencingDate date NULL,
	NotificationStartDate date NULL,
	NotificationEndDate date NULL,
	WholeExamFee money NULL,
	EachExamFee money NULL,
	LateFee1 money NULL,
	LateFee1Date date NULL,
	LateFee2 money NULL,
	LateFee2Date date NULL,
	Description nvarchar(500) NULL,
	MonthName nvarchar(50) NULL,
	ApplyJumbling bit NOT NULL,
	RegulationID tinyint NULL,
	NotificationFileName nvarchar(100) NULL,
	NotificationPDF_File varbinary(MAX) NULL,
	AlterBy smallint NULL,
	AlterDate smalldatetime NULL
	)  ON [PRIMARY]
	 TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE dbo.Tmp_ExamNotification SET (LOCK_ESCALATION = TABLE)
GO
DECLARE @v sql_variant 
SET @v = N'0-Regular, 1-Supply, 2-both'
EXECUTE sp_addextendedproperty N'MS_Description', @v, N'SCHEMA', N'dbo', N'TABLE', N'Tmp_ExamNotification', N'COLUMN', N'IsRegular'
GO
DECLARE @v sql_variant 
SET @v = N'0-No, 1-Yes'
EXECUTE sp_addextendedproperty N'MS_Description', @v, N'SCHEMA', N'dbo', N'TABLE', N'Tmp_ExamNotification', N'COLUMN', N'ApplyJumbling'
GO
ALTER TABLE dbo.Tmp_ExamNotification ADD CONSTRAINT
	DF_ExamNotification_IsRegular DEFAULT ((0)) FOR IsRegular
GO
ALTER TABLE dbo.Tmp_ExamNotification ADD CONSTRAINT
	DF_ExamNotification_ApplyJumbling DEFAULT ((0)) FOR ApplyJumbling
GO
ALTER TABLE dbo.Tmp_ExamNotification ADD CONSTRAINT
	DF_ExamNotification_AlterDate DEFAULT (getdate()) FOR AlterDate
GO
SET IDENTITY_INSERT dbo.Tmp_ExamNotification ON
GO
IF EXISTS(SELECT * FROM dbo.ExamNotification)
	 EXEC('INSERT INTO dbo.Tmp_ExamNotification (ExamNotificationID, ExamNotificationCode, ExamNotificationYear, ExamNotificationMonth, CourseID, SemesterID, IsRegular, MemorandumOfMarksFee, CostOfApplication, ExamCommencingDate, NotificationStartDate, NotificationEndDate, WholeExamFee, EachExamFee, LateFee1, LateFee1Date, LateFee2, LateFee2Date, Description, MonthName, ApplyJumbling, RegulationID, AlterBy, AlterDate)
		SELECT ExamNotificationID, ExamNotificationCode, ExamNotificationYear, ExamNotificationMonth, CourseID, SemesterID, IsRegular, MemorandumOfMarksFee, CostOfApplication, ExamCommencingDate, NotificationStartDate, NotificationEndDate, WholeExamFee, EachExamFee, LateFee1, LateFee1Date, LateFee2, LateFee2Date, Description, MonthName, ApplyJumbling, RegulationID, AlterBy, AlterDate FROM dbo.ExamNotification WITH (HOLDLOCK TABLOCKX)')
GO
SET IDENTITY_INSERT dbo.Tmp_ExamNotification OFF
GO
ALTER TABLE dbo.StudentExternalMarks
	DROP CONSTRAINT FK_StudentExternalMarks_ExamNotification
GO
ALTER TABLE dbo.StudentSubjectRegistration
	DROP CONSTRAINT FK_StudetnSubjectRegistration_ExamNotification
GO
DROP TABLE dbo.ExamNotification
GO
EXECUTE sp_rename N'dbo.Tmp_ExamNotification', N'ExamNotification', 'OBJECT' 
GO
ALTER TABLE dbo.ExamNotification ADD CONSTRAINT
	PK_ExamNotification PRIMARY KEY CLUSTERED 
	(
	ExamNotificationID
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
ALTER TABLE dbo.ExamNotification ADD CONSTRAINT
	FK_ExamNotification_Course FOREIGN KEY
	(
	CourseID
	) REFERENCES dbo.Course
	(
	CourseID
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.ExamNotification ADD CONSTRAINT
	FK_ExamNotification_Semester FOREIGN KEY
	(
	SemesterID
	) REFERENCES dbo.Semester
	(
	SemesterID
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.ExamNotification ADD CONSTRAINT
	FK_ExamNotification_Regulation FOREIGN KEY
	(
	RegulationID
	) REFERENCES dbo.Regulation
	(
	RegulationID
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.StudentSubjectRegistration ADD CONSTRAINT
	FK_StudetnSubjectRegistration_ExamNotification FOREIGN KEY
	(
	ExamNotificationID
	) REFERENCES dbo.ExamNotification
	(
	ExamNotificationID
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.StudentSubjectRegistration SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.StudentExternalMarks ADD CONSTRAINT
	FK_StudentExternalMarks_ExamNotification FOREIGN KEY
	(
	ExamNotificationID
	) REFERENCES dbo.ExamNotification
	(
	ExamNotificationID
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.StudentExternalMarks SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
