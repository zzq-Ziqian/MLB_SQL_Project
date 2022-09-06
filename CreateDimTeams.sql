use LahmansBaseballDB
go

--create teams dimension

--  Select description
select distinct t.yearID, t.lgID, t.teamID, t.[Rank], t.W as [teamW], t.L as [teamL], 
		t.R as [teamR], t.H as [teamH], t.[2B] as [team2B], t.[3B] as [team3B], 
		t.HR as [teamHR], t.SO as [teamSO], t.SB as [teamSB], t.CS as [teamCS]
from dbo.Teams t
where t.yearID >= 2000

--	Create dimBatting

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dimTeams]') AND type in (N'U'))
DROP TABLE [dbo].[dimTeams]
GO

CREATE TABLE [dbo].[dimTeams](
	yearID int,
	lgID varchar(50),
	teamID varchar(50),
	[Rank] int,
	teamW int,
	teamL int,
	teamR int,
	teamH int,
	team2B int,
	team3B int,
	teamHR int,
	teamSO int,
	teamSB int,
	teamCS int,
		CONSTRAINT [PK_dimTeams_yearIDteamID] PRIMARY KEY CLUSTERED (yearID, teamID)
)
GO

INSERT INTO dimTeams
select distinct t.yearID, t.lgID, t.teamID, t.[Rank], t.W as [teamW], t.L as [teamL], 
		t.R as [teamR], t.H as [teamH], t.[2B] as [team2B], t.[3B] as [team3B], 
		t.HR as [teamHR], t.SO as [teamSO], t.SB as [teamSB], t.CS as [teamCS]
from dbo.Teams t
where t.yearID >= 2000
GO