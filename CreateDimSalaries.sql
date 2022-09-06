use LahmansBaseballDB
go

--create salaries dimension

--  Select description
select distinct s.playerID, s.yearID, s.salary
from dbo.Salaries s
where s.playerID in (select distinct bt.playerID
		from dbo.Batting bt
		where bt.yearID >= 2000) and yearID >=2000

--	Create dimSalaries

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dimSalaries]') AND type in (N'U'))
DROP TABLE [dbo].[dimSalaries]
GO

CREATE TABLE [dbo].[dimSalaries](
	playerID varchar(50),
	yearID int,
	salary int,
		CONSTRAINT [PK_dimSalaries_playerIDyearID] PRIMARY KEY CLUSTERED (playerID, yearID)
)
GO

INSERT INTO dimSalaries
select distinct s.playerID, s.yearID, s.salary
from dbo.Salaries s
where s.playerID in (select distinct bt.playerID
		from dbo.Batting bt
		where bt.yearID >= 2000) and s.yearID >=2000
GO