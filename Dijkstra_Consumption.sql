declare 
@Source bigint =1, -- Vertice de origem
@U bigint, -- Vertice atual
@V bigint = -1, -- Vizinho atual
@Edge bigint = 0, -- Proxima aresta
@LoadOperation float = 3000
create table #Path (Id_1 int, Id_2 int)

-- Criação da lista de vertices (em tabela virtual)
create table #Q (VertexId int)
insert into #Q (VertexId)
select Id from Vertex

-- Criação da lista de custos(em tabela virtual, 999999 representa infinito)
create table #dist (VertexId int, Cost float)
insert into #dist (VertexId, Cost)
select Id, 999999 from Vertex

-- Criação da lista de predecessores(em tabela virtual)
create table #Prev (VertexId int, PrevId int, dh datetime)
insert into #prev (VertexId, PrevId)
select Id, -1 from Vertex

-- atualização do custo da origem
UPDATE #Dist
   SET Cost = 0
WHERE VertexId = @Source

-- Enquanto ainda existe vertices em @Q e não chegou no destino
While (((select count (*) from #Q) > 0))
begin
	
	-- Retorna em @U o vertice com menor custo
	select top 1 @U = #Q.VertexId from #Dist 
	inner join #Q on #Q.VertexId = #Dist.VertexId
	order by Cost asc

	-- Elimina vertice atual
	delete from #Q where VertexId = @U

	--Cursor para varrer as vertices vizinhas de @U
	DECLARE C_Neighborhood CURSOR FOR

		SELECT  case when rVertexOrigin.OriginId is not null then O_Vertex_Feeded.VertexId
		when EndVertex.Id  is not null then EndVertex.VertexId
		when rVertexOwner.OwnerId is not null then F_Vertex_Feeded.VertexId		
		else -1 end as VertexId,

		case when rVertexOrigin.OriginId is not null then O_Vertex_Feeded.OwnerId
		when rVertexOwner.OwnerId is not null then rVertexOwner.OwnerId
		else -1 end as LocationId

		FROM Vertex
		left outer join rVertexOrigin on Vertex.Id = rVertexOrigin.VertexId
		left outer join Feeder as O_Feeder on O_Feeder.OwnerId = rVertexOrigin.OriginId
		left outer join rVertexOwner as O_Vertex_Feeded on O_Vertex_Feeded.OwnerId = O_Feeder.FeededId
		left outer join rVertexOwner on rVertexOwner.VertexId = Vertex.Id
		left outer join Feeder as F_Feeder on F_Feeder.OwnerId = rVertexOwner.OwnerId
		left outer join rVertexOwner as F_Vertex_Feeded on F_Vertex_Feeded.OwnerId = F_Feeder.FeededId
		left outer join rVertexDestination as EndVertex on EndVertex.DestinationId = F_Feeder.FeededId
		where
		Vertex.Id = @U

	--Abre cursor
	OPEN C_Neighborhood
	FETCH NEXT FROM C_Neighborhood
	INTO @V, @Edge
 
	--Percorre Cursor
	WHILE @@FETCH_STATUS = 0
	BEGIN
				
		declare @alt float = 0, @loadEdge float = 0 -- Soma dos custos atual mais vizinho
		-- Soma dos custos atual mais vizinho
		Set @alt = (select Cost from #Dist where VertexId = @U) +
		isnull((select Consumption from EdgeHeuristicConsumption where Id = @Edge),0)

		select  @LoadEdge = Capacity from EdgeHeuristicCapacity where Id = @Edge

		-- Caso custo seja menor 
		if (@alt < (select Cost from #Dist where VertexId = @V) and @loadEdge >= @LoadOperation )
		begin
			UPDATE #Dist
			   SET Cost = @alt
			WHERE VertexId = @V

			UPDATE #Prev
			   SET PrevId = @U, dh = GETDATE()
			WHERE VertexId = @V

			insert into #Path (Id_1, Id_2) VALUES (@U, @V)

		end				

	FETCH NEXT FROM C_Neighborhood
	INTO  @V, @Edge
	END
 
	--Fecha Cursor
	CLOSE C_Neighborhood
	DEALLOCATE C_Neighborhood	
	
end

select 
Cost, 
replace(v1.Name,'Fedder - ','') as Tr, replace(v2.Name,'Fedder - ','') as Tr, replace(v3.Name,'Fedder - ','') as Tr, replace(v4.Name,'Fedder - ','') as Tr,replace(v5.Name,'Fedder - ','') as Tr, replace(v6.Name,'Fedder - ','') as Tr, replace(v7.Name,'Fedder - ','') as Tr, replace(v8.Name,'Fedder - ','') as Tr, replace(v9.Name,'Fedder - ','') as Tr,
replace(v10.Name,'Fedder - ','') as Tr,replace(v11.Name,'Fedder - ','') as Tr, replace(v12.Name,'Fedder - ','') as Tr, replace(v13.Name,'Fedder - ','') as Tr, replace(v14.Name,'Fedder - ','') as Tr,replace(v15.Name,'Fedder - ','') as Tr, replace(v16.Name,'Fedder - ','') as Tr, replace(v17.Name,'Fedder - ','') as Tr, 
replace(v18.Name,'Fedder - ','') as Tr, replace(v19.Name,'Fedder - ','') as Tr, replace(v20.Name,'Fedder - ','') as Tr, replace(v21.Name,'Fedder - ','') as Tr, replace(v22.Name,'Fedder - ','') as Tr, replace(v23.Name,'Fedder - ','') as Tr, replace(v24.Name,'Fedder - ','') as Tr,replace(v25.Name,'Fedder - ','') as Tr, replace(v26.Name,'Fedder - ','') as Tr, replace(v27.Name,'Fedder - ','') as Tr, 
replace(v28.Name,'Fedder - ','') as Tr, replace(v29.Name,'Fedder - ','') as Tr, replace(v30.Name,'Fedder - ','')
from #Prev as p1
left outer join Vertex as v1 on v1.Id = p1.VertexId
left outer join #Dist on #Dist.VertexId = p1.VertexId
left outer join #Prev as p2 on p2.VertexId = p1.PrevId
left outer join Vertex as v2 on v2.Id = p2.VertexId
left outer join #Prev as p3 on p3.VertexId = p2.PrevId
left outer join Vertex as v3 on v3.Id = p3.VertexId
left outer join #Prev as p4 on p4.VertexId = p3.PrevId
left outer join Vertex as v4 on v4.Id = p4.VertexId
left outer join #Prev as p5 on p5.VertexId = p4.PrevId
left outer join Vertex as v5 on v5.Id = p5.VertexId
left outer join #Prev as p6 on p6.VertexId = p5.PrevId
left outer join Vertex as v6 on v6.Id = p6.VertexId
left outer join #Prev as p7 on p7.VertexId = p6.PrevId
left outer join Vertex as v7 on v7.Id = p7.VertexId
left outer join #Prev as p8 on p8.VertexId = p7.PrevId
left outer join Vertex as v8 on v8.Id = p8.VertexId
left outer join #Prev as p9 on p9.VertexId = p8.PrevId
left outer join Vertex as v9 on v9.Id = p9.VertexId
left outer join #Prev as p10 on p10.VertexId = p9.PrevId
left outer join Vertex as v10 on v10.Id = p10.VertexId
left outer join #Prev as p11 on p11.VertexId = p10.PrevId
left outer join Vertex as v11 on v11.Id = p11.VertexId
left outer join #Prev as p12 on p12.VertexId = p11.PrevId
left outer join Vertex as v12 on v12.Id = p12.VertexId
left outer join #Prev as p13 on p13.VertexId = p12.PrevId
left outer join Vertex as v13 on v13.Id = p13.VertexId
left outer join #Prev as p14 on p14.VertexId = p13.PrevId
left outer join Vertex as v14 on v14.Id = p14.VertexId
left outer join #Prev as p15 on p15.VertexId = p14.PrevId
left outer join Vertex as v15 on v15.Id = p15.VertexId
left outer join #Prev as p16 on p16.VertexId = p15.PrevId
left outer join Vertex as v16 on v16.Id = p16.VertexId
left outer join #Prev as p17 on p17.VertexId = p16.PrevId
left outer join Vertex as v17 on v17.Id = p17.VertexId
left outer join #Prev as p18 on p18.VertexId = p17.PrevId
left outer join Vertex as v18 on v18.Id = p18.VertexId
left outer join #Prev as p19 on p19.VertexId = p18.PrevId
left outer join Vertex as v19 on v19.Id = p19.VertexId
left outer join #Prev as p20 on p20.VertexId = p19.PrevId
left outer join Vertex as v20 on v20.Id = p20.VertexId

left outer join #Prev as p21 on p21.VertexId = p20.PrevId
left outer join Vertex as v21 on v21.Id = p21.VertexId
left outer join #Prev as p22 on p22.VertexId = p21.PrevId
left outer join Vertex as v22 on v22.Id = p22.VertexId
left outer join #Prev as p23 on p23.VertexId = p22.PrevId
left outer join Vertex as v23 on v23.Id = p23.VertexId
left outer join #Prev as p24 on p24.VertexId = p23.PrevId
left outer join Vertex as v24 on v24.Id = p24.VertexId
left outer join #Prev as p25 on p25.VertexId = p24.PrevId
left outer join Vertex as v25 on v25.Id = p25.VertexId
left outer join #Prev as p26 on p26.VertexId = p25.PrevId
left outer join Vertex as v26 on v26.Id = p26.VertexId
left outer join #Prev as p27 on p27.VertexId = p26.PrevId
left outer join Vertex as v27 on v27.Id = p27.VertexId
left outer join #Prev as p28 on p28.VertexId = p27.PrevId
left outer join Vertex as v28 on v28.Id = p28.VertexId
left outer join #Prev as p29 on p29.VertexId = p28.PrevId
left outer join Vertex as v29 on v29.Id = p29.VertexId
left outer join #Prev as p30 on p30.VertexId = p29.PrevId
left outer join Vertex as v30 on v30.Id = p30.VertexId
inner join rVertexDestination on rVertexDestination.VertexId = v1.Id
where Cost < 999999

drop table #Dist
drop table #Prev
drop table #Q
drop table #Path