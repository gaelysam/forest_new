-- 3D noises

local np_cave1 = {
	offset = 0,
	scale = 1,
	spread = {x=30, y=30, z=30},
	seed = 5203,
	octaves = 3,
	persist = 0.6
}

local np_cave2 = {
	offset = 0,
	scale = 1,
	spread = {x=30, y=30, z=30},
	seed = 7660,
	octaves = 3,
	persist = 0.6
}

local np_cave3 = {
	offset = 0,
	scale = 1,
	spread = {x=30, y=30, z=30},
	seed = 3289,
	octaves = 3,
	persist = 0.6
}

local np_cave4 = {
	offset = 0,
	scale = 1,
	spread = {x=150, y=150, z=150},
	seed = 5435,
	octaves = 3,
	persist = 0.6
}

-- 2D noises

--[[local np_n5 = {
	offset = 0,
	scale = 1,
	spread = {x=80, y=80, z=80},
	seed = 9849,
	octaves = 3,
	persist = 0.6
}

local np_n6 = {
	offset = 0,
	scale = 1,
	spread = {x=200, y=200, z=200},
	seed = 7237,
	octaves = 3,
	persist = 0.6
}

local np_n7 = {
	offset = 0,
	scale = 1,
	spread = {x=600, y=600, z=600},
	seed = 5096,
	octaves = 3,
	persist = 0.6
}

local np_n8 = {
	offset = 0,
	scale = 1,
	spread = {x=20, y=20, z=20},
	seed = 7230,
	octaves = 3,
	persist = 0.6
}

local np_n9 = {
	offset = 0,
	scale = 1,
	spread = {x=20, y=20, z=20},
	seed = 9933,
	octaves = 3,
	persist = 0.6
}]]

-- elevation noises

local np_valleys_1a = {
	offset = 0,
	scale = 1,
	spread = {x=50, y=50, z=50},
	seed = 6831,
	octaves = 3,
	persist = 0.2
}

local np_valleys_1b = {
	offset = 0,
	scale = 1,
	spread = {x=50, y=50, z=50},
	seed = 1590,
	octaves = 3,
	persist = 0.2
}

local np_valleys_2a = {
	offset = 0,
	scale = 1,
	spread = {x=25, y=25, z=25},
	seed = 4385,
	octaves = 3,
	persist = 0.2
}

local np_valleys_2b = {
	offset = 0,
	scale = 1,
	spread = {x=25, y=25, z=25},
	seed = 9726,
	octaves = 3,
	persist = 0.2
}

local np_valleys_3a = {
	offset = 0,
	scale = 1,
	spread = {x=10, y=10, z=10},
	seed = 1792,
	octaves = 3,
	persist = 0.2
}

local np_valleys_3b = {
	offset = 0,
	scale = 1,
	spread = {x=10, y=10, z=10},
	seed = 1016,
	octaves = 3,
	persist = 0.2
}

local np_valleys_depth = {
	offset = 0,
	scale = 1,
	spread = {x=300, y=300, z=300},
	seed = 8110,
	octaves = 3,
	persist = 0.2
}

local np_terrain_height = {
	offset = 0,
	scale = 1,
	spread = {x=400, y=400, z=400},
	seed = 2698,
	octaves = 3,
	persist = 0.2
}

minetest.register_on_generated(function(minp, maxp)
	
	local t0 = os.clock()
	local x1 = maxp.x
	local y1 = maxp.y
	local z1 = maxp.z
	local x0 = minp.x
	local y0 = minp.y
	local z0 = minp.z
	
	print ("[forest] Generating map from "..minetest.pos_to_string(minp).." to "..minetest.pos_to_string(maxp))
	
	--local c_dstone = minetest.get_content_id("default:desert_stone")
	--local c_dsand = minetest.get_content_id("default:desert_sand")
	local c_water = minetest.get_content_id("default:water_source")
	local c_stone = minetest.get_content_id("default:stone")
	--local c_sand = minetest.get_content_id("default:sand")
	local c_grass = minetest.get_content_id("default:dirt_with_grass")
	--local c_snow = minetest.get_content_id("default:dirt_with_snow")
	local c_dirt = minetest.get_content_id("default:dirt")
	--local c_gravel = minetest.get_content_id("default:gravel")
	--[[local c_grasses = {
		minetest.get_content_id("default:grass_1"),
		minetest.get_content_id("default:grass_2"),
		minetest.get_content_id("default:grass_3"),
		minetest.get_content_id("default:grass_4"),
		minetest.get_content_id("default:grass_5")
	}]]
	--local c_jungle = minetest.get_content_id("default:junglegrass")
	--local c_flowers = {minetest.get_content_id("flowers:dandelion_yellow"), minetest.get_content_id("flowers:dandelion_yellow"), minetest.get_content_id("flowers:dandelion_yellow"), minetest.get_content_id("flowers:geranium"), minetest.get_content_id("flowers:tulip"), minetest.get_content_id("flowers:rose")}
	--local c_papyrus = minetest.get_content_id("default:papyrus")
	--local c_shrub = minetest.get_content_id("default:dry_shrub")
	--local c_lava = minetest.get_content_id("default:lava_source")
	--local c_cactus = minetest.get_content_id("default:cactus")
	--local c_air = minetest.get_content_id("air")
	-- LVM stuff
	local manip, emin, emax = minetest.get_mapgen_object("voxelmanip")
	local area = VoxelArea:new({MinEdge = emin, MaxEdge = emax})
	local data = manip:get_data()
	
	-- perlinmap stuff
	local sidelen = x1 - x0 + 1
	local chulens = {x=sidelen, y=sidelen, z=sidelen}
	local minposxyz = {x=x0, y=y0, z=z0}
	local minposxz = {x=x0, y=z0}
	-- 3D noises
	local nvals_cave1 = minetest.get_perlin_map(np_cave1, chulens):get3dMap_flat(minposxyz)
	local nvals_cave2 = minetest.get_perlin_map(np_cave2, chulens):get3dMap_flat(minposxyz)
	local nvals_cave3 = minetest.get_perlin_map(np_cave3, chulens):get3dMap_flat(minposxyz)
	local nvals_cave4 = minetest.get_perlin_map(np_cave4, chulens):get3dMap_flat(minposxyz)
	-- 2D noises
	--local nvals_n5 = minetest.get_perlin_map(np_n5, chulens):get2dMap_flat(minposxz)
	--local nvals_n6 = minetest.get_perlin_map(np_n6, chulens):get2dMap_flat(minposxz)
	--local nvals_n7 = minetest.get_perlin_map(np_n7, chulens):get2dMap_flat(minposxz)
	--local nvals_n8 = minetest.get_perlin_map(np_n8, chulens):get2dMap_flat(minposxz)
	--local nvals_n9 = minetest.get_perlin_map(np_n9, chulens):get2dMap_flat(minposxz)
	-- elevation 2D noises
	local nvals_valleys_1a = minetest.get_perlin_map(np_valleys_1a, chulens):get2dMap_flat(minposxz)
	local nvals_valleys_1b = minetest.get_perlin_map(np_valleys_1b, chulens):get2dMap_flat(minposxz)
	local nvals_valleys_2a = minetest.get_perlin_map(np_valleys_2a, chulens):get2dMap_flat(minposxz)
	local nvals_valleys_2b = minetest.get_perlin_map(np_valleys_2b, chulens):get2dMap_flat(minposxz)
	local nvals_valleys_3a = minetest.get_perlin_map(np_valleys_3a, chulens):get2dMap_flat(minposxz)
	local nvals_valleys_3b = minetest.get_perlin_map(np_valleys_3b, chulens):get2dMap_flat(minposxz)
	local nvals_valleys_depth = minetest.get_perlin_map(np_valleys_depth, chulens):get2dMap_flat(minposxz)
	local nvals_terrain_height = minetest.get_perlin_map(np_terrain_height, chulens):get2dMap_flat(minposxz)
	
	local nixz = 1 -- 2D noise index
	for z = minp.z, maxp.z do
	for x = minp.x, maxp.x do
		local valleys1a = nvals_valleys_1a[nixz]
		local valleys1b = nvals_valleys_1b[nixz]
		local valleys2a = nvals_valleys_2a[nixz]
		local valleys2b = nvals_valleys_2b[nixz]
		local valleys3a = nvals_valleys_3a[nixz]
		local valleys3b = nvals_valleys_3b[nixz]
		local valleys_depth = math.abs(nvals_valleys_depth[nixz])
		local terrain_height = nvals_terrain_height[nixz]

		local valleys1 = math.abs(valleys1a - valleys1b) * valleys_depth
		local valleys2 = math.sqrt(valleys1 * math.abs(valleys2a - valleys2b)) * valleys_depth
		local valleys3 = math.sqrt(valleys2 * math.abs(valleys3a - valleys3b)) * valleys_depth
		local c = terrain_height + 1
		local elevation = (valleys1*20 + valleys2*15 + valleys3*10) * c + terrain_height * 50
		if elevation < 0 then
			elevation = -2 * math.sqrt(-elevation)
		end
		elevation = math.floor(elevation + 0.5)

		local top = c_grass
		local fill = c_dirt
		local stone = c_stone
		
		--[[if math.max(elevation, 1) >= minp.y then
			n5v = nvals_n5[nixz]
			n6v = nvals_n6[nixz]
			n7v = nvals_n7[nixz]
			n8v = nvals_n8[nixz]
			n9v = nvals_n9[nixz]
			if elevation < n8v * 5 then
				if n7v < 0.88 then
					if n5v - n6v > 0.8 then
						ground1 = c_gravel
						ground2 = c_gravel
						ground3 = c_stone
						ground4 = c_stone
						plant = nil
					elseif n6v < 0 then
						if n5v < -0.4 then
							ground1 = c_dsand
							ground2 = c_dsand
							ground3 = c_dstone
							ground4 = c_stone
							plant = nil
						else
							ground1 = c_sand
							ground2 = c_sand
							ground3 = c_stone
							ground4 = c_stone
							plant = nil
						end
					elseif n5v + n6v * 5 > 2 then
						if n6v > 0.8 then
							ground1 = c_gravel
							ground2 = c_gravel
							ground3 = c_stone
							ground4 = c_stone
							plant = nil
						else
							ground1 = c_grass
							ground2 = c_dirt
							ground3 = c_stone
							ground4 = c_stone
							plant = {def = c_papyrus, percent = 4, height = math.random(2, 5)}
						end
					else
						ground1 = c_sand
						ground2 = c_sand
						ground3 = c_stone
						ground4 = c_stone
						plant = {def = c_grasses[math.random(5)], percent = 15}
					end
				elseif n5v * 2 - n6v < 0 then
					ground1 = c_gravel
					ground2 = c_gravel
					ground3 = c_stone
					ground4 = c_stone
					plant = nil
				else
					ground1 = c_stone
					ground2 = c_stone
					ground3 = c_stone
					ground4 = c_stone
					plant = nil
				end
			elseif n7v < 0.88 then
				if n5v + 2 * n6v > -0.4 then
					if n5v > 0 then
						ground1 = c_grass
						ground2 = c_dirt
						ground3 = c_stone
						ground4 = c_stone
						plant = nil
					else
						ground1 = c_grass
						ground2 = c_dirt
						ground3 = c_stone
						ground4 = c_stone
						if math.random(2) == 2 then
							plant = {def = c_grasses[math.random(5)], percent = 20}
						else
							plant = {def = c_flowers[math.random(6)], percent = -n5v}
						end
					end
				elseif n6v < -0.4 then
					ground1 = c_dsand
					ground2 = c_dsand
					ground3 = c_dstone
					ground4 = c_stone
					if math.random(2) == 2 then
						plant = {def = c_cactus, percent = 2, height = math.random(2, 6)}
					else
						plant = {def = c_shrub, percent = 5}
					end
				else
					ground1 = c_sand
					ground2 = c_sand
					ground3 = c_dstone
					ground4 = c_stone
					if math.random(2) == 2 then
						plant = {def = c_cactus, percent = 0.25, height = math.random(2, 4)}
					else
						plant = {def = c_jungle, percent = 25}
					end
				end
			elseif n5v ^ 2 + n6v ^ 2 < 0.16 and n7v > 0.9 then
				ground1 = c_air
				ground2 = c_lava
				ground3 = c_stone
				ground4 = c_stone
				plant = nil
				elevation = math.min(
					elevation, get_elevation({x = x, z = z + 1}),
					get_elevation({x = x, z = z - 1}),
					get_elevation({x = x + 1, z = z}),
					get_elevation({x = x - 1, z = z})
				)
			elseif n5v > -0.6 then
				ground1 = c_stone
				ground2 = c_stone
				ground3 = c_stone
				ground4 = c_stone
				plant = nil
			else
				ground1 = c_gravel
				ground2 = c_gravel
				ground3 = c_stone
				ground4 = c_stone
				plant = nil
			end]]
			
			for y = minp.y, math.min(math.max(elevation, 1), maxp.y) do
				local pos = area:index(x, y, z) -- LVM index for node
				local nixyz = (z - z0) * 6400 + (y - y0) * 80 + (x - x0) + 1 -- noise index for node
				local cave1 = nvals_cave1[nixyz]
				local cave2 = nvals_cave2[nixyz]
				local cave3 = nvals_cave3[nixyz]
				local cave4 = nvals_cave4[nixyz]
				local node
				if y == elevation then
					node = elevation >= 1 and top or fill
				elseif y > elevation then
					node = c_water
				elseif y + math.random(2, 6) >= elevation then
					node = fill
				else
					node = stone
				end
				if math.max(cave1, cave2, cave3) - math.min(cave1, cave2, cave3) > cave4 / 5 or node == c_water then
					data[pos] = node
				end
			end
			
			--[[if elevation > 0 and plant then
				if math.random() * 100 < plant.percent then
					if plant.height then
						for i = 1, plant.height do
							if area:contains(x, elevation + i, z) then
								data[area:index(x, elevation + i, z)] = plant.def
							end
						end
					elseif area:contains(x, elevation + 1, z) then
						data[area:index(x, elevation + 1, z)] = plant.def
					end
				end
			end]]
		--end
		nixz = nixz + 1 -- increment 2D noise index
	end
	end
	manip:set_data(data)
	minetest.generate_ores(manip, minp, maxp)
	manip:update_liquids()
	manip:set_lighting({day=0, night=0})
	manip:calc_lighting()
	manip:write_to_map(data)

	local t1 = os.clock()
	print ("[forest] Time taken: " .. math.floor((t1-t0)*1e6)/1000 .. " ms")
end)
