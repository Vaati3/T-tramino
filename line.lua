function clear_line(i)
	for e in all (t_list) do
		if (e.y1 == i and e.mv == 0) then 
			e.y1 = -10
			e.x1 = -10
			e.d += 1
		end
		if (e.y2 == i and e.mv == 0) then 
			e.y2 = -10
			e.x2 = -10
			e.d += 1
		end
		if (e.y3 == i and e.mv == 0) then 
			e.y3 = -10
			e.x3 = -10
			e.d += 1
		end
		if (e.y4 == i and e.mv == 0) then 
			e.y4 = -10
			e.x4 = -10
			e.d += 1
		end
	end
end

function update_line(i)
	for e in all(t_list) do
		if e.y1 < i then e.y1 += 8 end
		if e.y2 < i then e.y2 += 8 end
		if e.y3 < i then e.y3 += 8 end
		if e.y4 < i then e.y4 += 8 end
	end
end

function check_line()
	local i = 0
	local l = 0
	while (i <= 120) do
		for e in all(t_list) do
			if (e.mv == 0) then
				if (e.y1 == i) then l += 1 end
				if (e.y2 == i) then l += 1 end
				if (e.y3 == i) then l += 1 end
				if (e.y4 == i) then l += 1 end
			end
		end
		if (l >= 10) then
			clear_line(i)
			update_line(i)
			line += 1
			c = 1
		end
		i += 8
		l = 0
	end
end

function destroy()
	for e in all(t_list) do
		if (e.d == 4) then
			del(t_list, e)
		end
	end
end