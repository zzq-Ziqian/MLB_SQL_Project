use LahmansBaseballDB
go

select * from dbo.people

select * from dbo.Salaries

select * from dbo.teams

select * from dbo.Batting

--batting dimension
select distinct bt.playerID, bt.yearID, bt.teamID, bt.lgID, bt.G, bt.AB, bt.R, bt.H,
		bt.[2B], bt.[3B], bt.HR, bt.SB, bt.CS, bt.SO
from dbo.Batting bt
where bt.yearID >= 2000

--team dimension
select distinct t.yearID, t.lgID, t.teamID, t.[Rank], t.W as [teamW], t.L as [teamL], 
		t.R as [teamR], t.H as [teamH], t.[2B] as [team2B], t.[3B] as [team3B], 
		t.HR as [teamHR], t.SO as [teamSO], t.SB as [teamSB], t.CS as [teamCS]
from dbo.Teams t
where t.yearID >= 2000

--player information dimension
select distinct ppl.playerID, ppl.birthYear, ppl.birthCountry, ppl.nameFirst, ppl.nameLast, ppl.[weight],
		ppl.height, ppl.bats
from dbo.People ppl 
where ppl.playerID in (select distinct bt.playerID
		from dbo.Batting bt
		where bt.yearID >= 2000)

--player salaries dimension
select distinct *
from dbo.Salaries s
where s.playerID in (select distinct bt.playerID
		from dbo.Batting bt
		where bt.yearID >= 2000) and yearID >=2000

--player statistic fact
select distinct bt.playerID, bt.yearID, bt.teamID
from dbo.Batting bt
where bt.yearID >= 2000
