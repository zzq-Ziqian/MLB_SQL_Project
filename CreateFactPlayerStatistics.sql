use LahmansBaseballDB
go

--	Create factPlayerStatistics

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FactHivFile]') AND type in (N'U'))
DROP TABLE [dbo].[factHivFile]
GO

CREATE TABLE [dbo].[factPlayerStatistics](
	PlayerStatisticsID int IDENTITY(1,1) NOT NULL,
		CONSTRAINT PK_factHivFile_PlayerStatisticsID PRIMARY KEY CLUSTERED (PlayerStatisticsID),
	yearID int,
    playerID varchar(50),
	teamID varchar(50),
		CONSTRAINT FK_dimBatting_factPlayerStatistics FOREIGN KEY (playerID, yearID)
		REFERENCES dimBatting (playerID, yearID),
		CONSTRAINT FK_dimPlayer_factPlayerStatistics FOREIGN KEY (playerID)
		REFERENCES dimPlayer (playerID),
		CONSTRAINT FK_dimSalaries_factPlayerStatistics FOREIGN KEY (playerID, yearID)
		REFERENCES dimSalaries (playerID, yearID),
		CONSTRAINT FK_dimTeams_factPlayerStatistics FOREIGN KEY (yearID, teamID)
		REFERENCES dimTeams (yearID, teamID),
)
GO

INSERT INTO factPlayerStatistics
select distinct bt.playerID, bt.yearID, bt.teamID
from dbo.Batting bt
where bt.yearID >= 2000