
function clear_line(i, min_x, max_x)
	for e in all (t_list) do
		if (e.y1 == i and e.mv == 0
			and e.x1 >= min_x and e.x1 <= max_x) then 
			e.y1 = -10
			e.x1 = -10
			e.d += 1
		end
		if (e.y2 == i and e.mv == 0
			and e.x2 >= min_x and e.x2 <= max_x) then 
			e.y2 = -10
			e.x2 = -10
			e.d += 1
		end
		if (e.y3 == i and e.mv == 0
		 and e.x3 >= min_x and e.x3 <= max_x) then 
			e.y3 = -10
			e.x3 = -10
			e.d += 1
		end
		if (e.y4 == i and e.mv == 0
			and e.x4 >= min_x and e.x4 <= max_x) then 
			e.y4 = -10
			e.x4 = -10
			e.d += 1
		end
	end
end

function update_line(n, i, min_x, max_x)
	for e in all(t_list) do
		if e.y1 <= i and e.x1 >= min_x and e.x1 <= max_x then
			e.y1 += n end
		if e.y2 <= i and e.x2 >= min_x and e.x2 <= max_x then 
			e.y2 += n end
		if e.y3 <= i and e.x3 >= min_x and e.x3 <= max_x then
			e.y3 += n end
		if e.y4 <= i and e.x4 >= min_x and e.x4 <= max_x then
			e.y4 += n end
	end
end

function put_tetris(tetris, x)
	if (tetris == 4 and x == 0) then
		update_line(-24, 120, 64, 120) 
		p2_m += 3 end
	if (tetris == 3 and x == 0) then
		update_line(-8, 120, 64, 120)
		p2_m += 1 end
	if (tetris == 4 and x == 64) then
		update_line(-24, 120, 0, 56) 
		p1_m += 3 end
	if (tetris == 3 and x == 64) then
		update_line(-8, 120, 0, 56)
		p1_m += 1 end
end

function check_line(cpl, min_x, max_x)
	local i = 0
	local l = 0
	local tetris = 0
	while (i <= 120) do
		for e in all(t_list) do
			if (e.mv == 0) then
				if (e.y1 == i and e.x1 >= min_x and e.x1 <= max_x) then 
					l += 1 end
				if (e.y2 == i and e.x2 >= min_x and e.x2 <= max_x) then 
					l += 1 end
				if (e.y3 == i and e.x3 >= min_x and e.x3 <= max_x) then 
					l += 1 end
				if (e.y4 == i and e.x4 >= min_x and e.x4 <= max_x) then 
					l += 1 end
			end
		end
		if (l >= cpl) then
			clear_line(i, min_x, max_x)
			update_line(8, i, min_x, max_x)
			lined += 1
			tetris += 1
			c = 1 
		end
		i += 8
		l = 0
	end
	if (cpl == 8) then
		put_tetris(tetris, min_x) end
end

function destroy()
	for e in all(t_list) do
		if (e.d == 4) then
			del(t_list, e)
		end
	end
end