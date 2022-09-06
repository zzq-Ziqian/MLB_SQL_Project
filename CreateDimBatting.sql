use LahmansBaseballDB
go

--create batting dimension

--  Select description
select distinct bt.playerID, bt.yearID, bt.teamID, bt.lgID, bt.G, bt.AB, bt.R, bt.H,
		bt.[2B], bt.[3B], bt.HR, bt.SB, bt.CS, bt.SO
from dbo.Batting bt
where bt.yearID >= 2000

--	Create dimBatting

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dimBatting]') AND type in (N'U'))
DROP TABLE [dbo].[dimBatting]
GO

CREATE TABLE [dbo].[dimBatting](
	playerID varchar(50),
	yearID int,
	teamID varchar(50),
	lgID varchar(50),
	G int,
	AB int,
	R int,
	H int,
	[2B] int,
	[3B] int,
	HR int,
	SB int,
	CS int,
	SO int,
	CONSTRAINT [PK_dimBatting_playerIDyearID] PRIMARY KEY CLUSTERED (playerID, yearID)
)
GO

INSERT INTO dimBatting
select distinct bt.playerID, bt.yearID, bt.teamID, bt.lgID, bt.G, bt.AB, bt.R, bt.H,
		bt.[2B], bt.[3B], bt.HR, bt.SB, bt.CS, bt.SO
from dbo.Batting bt
where bt.yearID >= 2000
GO

--select playerID, yearID from dimBatting group by playerID, yearID having count(*)>1

--delete from dimBatting db
--where (db.peopleId,db.seq) in   (select peopleId,seq from vitae group by peopleId,seq having count(*) > 1)
--and rowid not in (select min(rowid) from vitae group by peopleId,seq having count(*)>1)