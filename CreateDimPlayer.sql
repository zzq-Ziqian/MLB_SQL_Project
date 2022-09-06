use LahmansBaseballDB
go

--create player dimension

--  Select description
select distinct ppl.playerID, ppl.birthYear, ppl.birthCountry, ppl.nameFirst, ppl.nameLast, ppl.[weight],
		ppl.height, ppl.bats
from dbo.People ppl 
where ppl.playerID in (select distinct bt.playerID
		from dbo.Batting bt
		where bt.yearID >= 2000)

--	Create dimPlayer

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dimPlayer]') AND type in (N'U'))
DROP TABLE [dbo].[dimPlayer]
GO

CREATE TABLE [dbo].[dimPlayer](
	playerID varchar(50),
	birthYear int,
	birthCountry varchar(50),
	nameFirst varchar(50),
	nameLast varchar(50),
	[weight] int,
	height int,
	bats varchar(50),
		CONSTRAINT [PK_dimPlayer_playerID] PRIMARY KEY CLUSTERED (playerID)
)
GO

INSERT INTO dimPlayer
select distinct ppl.playerID, ppl.birthYear, ppl.birthCountry, ppl.nameFirst, ppl.nameLast, ppl.[weight],
		ppl.height, ppl.bats
from dbo.People ppl 
where ppl.playerID in (select distinct bt.playerID
		from dbo.Batting bt
		where bt.yearID >= 2000)
GO