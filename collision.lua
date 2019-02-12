function tetra:colision()
	if (self.y1 >= 120 or self.y2 >= 120 or self.y3 >= 120 or self.y4 >= 120) then
		return (false)
	end
	for e in all(t_list) do
	 if (e.y1 != self.y1) then
	 	if ((self.y1 + 8 >= e.y1 and self.y1 + 8 < e.y1 + 8 and self.x1 == e.x1) 
	 		or (self.y2 + 8 >= e.y1 and self.y2 + 8 < e.y1 + 8 and self.x2 == e.x1) 
	 		or (self.y3 + 8 >= e.y1 and self.y3 + 8 < e.y1 + 8 and self.x3 == e.x1)
	 		or (self.y4 + 8 >= e.y1 and self.y4 + 8 < e.y1 + 8 and self.x4 == e.x1)) then
			 return (false)
	 	end
	 	if ((self.y1 + 8 >= e.y2 and self.y1 + 8 < e.y2 + 8 and self.x1 == e.x2)
	 		or (self.y2 + 8 >= e.y2 and self.y2 + 8 < e.y2 + 8 and self.x2 == e.x2)
				or (self.y3 + 8 >= e.y2 and self.y3 + 8 < e.y2 + 8 and self.x3 == e.x2)
				or (self.y4 + 8 >= e.y2 and self.y4 + 8 < e.y2 + 8 and self.x4 == e.x2)) then
		 	return (false)
	 	end
	 	if ((self.y1 + 8 >= e.y3 and self.y1 + 8 < e.y3 + 8 and self.x1 == e.x3)
	 		or (self.y2 + 8 >= e.y3 and self.y2 + 8 < e.y3 + 8 and self.x2 == e.x3)
	 		or (self.y3 + 8 >= e.y3 and self.y3 + 8 < e.y3 + 8 and self.x3 == e.x3)
	 		or (self.y4 + 8 >= e.y3 and self.y4 + 8 < e.y3 + 8 and self.x4 == e.x3)) then
		 	return (false)
	 	end
	 	if ((self.y1 + 8 >= e.y4 and self.y1 + 8 < e.y4 + 8 and self.x1 == e.x4)
	 		or (self.y2 + 8 >= e.y4 and self.y2 + 8 < e.y4 + 8 and self.x2 == e.x4)
	 		or (self.y3 + 8 >= e.y4 and self.y3 + 8 < e.y4 + 8 and self.x3 == e.x4)
	 		or (self.y4 + 8 >= e.y4 and self.y4 + 8 < e.y4 + 8 and self.x2 == e.x4)) then
		 	return (false)
  	end
  end
	end
	return (true)
end

function tetra:r_col()
	if (self.x1 >= 120 or self.x2 >= 120 or self.x3 >= 120 or self.x4 >= 120) then
		return (false);
	end
	for e in all(t_list) do
		if (self.x1 != e.x1) then
			if ((self.x1 + 8 >= e.x1 and self.x1 + 8 < e.x1 + 8 and self.y1 + 8 >= e.y1 and self.y1 + 8 < e.y1 + 8)
				or (self.x2 + 8 >= e.x1 and self.x2 + 8 < e.x1 + 8 and self.y2 + 8 >= e.y1 and self.y2 + 8 < e.y1 + 8)
				or (self.x3 + 8 >= e.x1 and self.x3 + 8 < e.x1 + 8 and self.y3 + 8 >= e.y1 and self.y3 + 8 < e.y1 + 8)
				or (self.x4 + 8 >= e.x1 and self.x4 + 8 < e.x1 + 8 and self.y4 + 8 >= e.y1 and self.y4 + 8 < e.y1 + 8)) then
				return (false)
			end
			if ((self.x1 + 8 >= e.x2 and self.x1 + 8 < e.x2 + 8 and self.y1 + 8 >= e.y2 and self.y1 + 8 < e.y2 + 8)
				or (self.x2 + 8 >= e.x2 and self.x2 + 8 < e.x2 + 8 and self.y2 + 8 >= e.y2 and self.y2 + 8 < e.y2 + 8)
				or (self.x3 + 8 >= e.x2 and self.x3 + 8 < e.x2 + 8 and self.y3 + 8 >= e.y2 and self.y3 + 8 < e.y2 + 8)
				or (self.x4 + 8 >= e.x2 and self.x4 + 8 < e.x2 + 8 and self.y4 + 8 >= e.y2 and self.y4 + 8 < e.y2 + 8)) then
				return (false)
			end
			if ((self.x1 + 8 >= e.x3 and self.x1 + 8 < e.x3 + 8 and self.y1 + 8 >= e.y3 and self.y1 + 8 < e.y3 + 8)
				or (self.x2 + 8 >= e.x3 and self.x2 + 8 < e.x3 + 8 and self.y2 + 8 >= e.y3 and self.y2 + 8 < e.y3 + 8)
				or (self.x3 + 8 >= e.x3 and self.x3 + 8 < e.x3 + 8 and self.y3 + 8 >= e.y3 and self.y3 + 8 < e.y3 + 8)
				or (self.x4 + 8 >= e.x3 and self.x4 + 8 < e.x3 + 8 and self.y4 + 8 >= e.y3 and self.y4 + 8 < e.y3 + 8)) then
				return (false)
			end
			if ((self.x1 + 8 >= e.x4 and self.x1 + 8 < e.x4 + 8 and self.y1 + 8 >= e.y4 and self.y1 + 8 < e.y4 + 8)
				or (self.x2 + 8 >= e.x4 and self.x2 + 8 < e.x4 + 8 and self.y2 + 8 >= e.y4 and self.y2 + 8 < e.y4 + 8)
				or (self.x3 + 8 >= e.x4 and self.x3 + 8 < e.x4 + 8 and self.y3 + 8 >= e.y4 and self.y3 + 8 < e.y4 + 8)
				or (self.x4 + 8 >= e.x4 and self.x4 + 8 < e.x4 + 8 and self.y4 + 8 >= e.y4 and self.y4 + 8 < e.y4 + 8)) then
				return (false)
			end
		end
	end
	return (true)
end


function tetra:l_col()
	if (self.x1 <= 0 or self.x2 <= 0 or self.x3 <= 0 or self.x4 <= 0) then
		return (false);
	end
	for e in all(t_list) do
		if (self.x1 != e.x1) then
			if ((self.x1 <= e.x1 + 8 and self.x1 + 8 > e.x1 and self.y1 + 8 >= e.y1 and self.y1 + 8 < e.y1 + 8)
				or (self.x2 <= e.x1 + 8 and self.x2 + 8 > e.x1 and self.y2 + 8 >= e.y1 and self.y2 + 8 < e.y1 + 8)
				or (self.x3 <= e.x1 + 8 and self.x3 + 8 > e.x1 and self.y3 + 8 >= e.y1 and self.y3 + 8 < e.y1 + 8)
				or (self.x4 <= e.x1 + 8 and self.x4 + 8 > e.x1 and self.y4 + 8 >= e.y1 and self.y4 + 8 < e.y1 + 8)) then
				return (false)
			end
			if ((self.x1 <= e.x2 + 8 and self.x1 + 8 > e.x2 and self.y1 + 8 >= e.y2 and self.y1 + 8 < e.y2 + 8)
				or (self.x2 <= e.x2 + 8 and self.x2 + 8 > e.x2 and self.y2 + 8 >= e.y2 and self.y2 + 8 < e.y2 + 8)
				or (self.x3 <= e.x2 + 8 and self.x3 + 8 > e.x2 and self.y3 + 8 >= e.y2 and self.y3 + 8 < e.y2 + 8)
				or (self.x4 <= e.x2 + 8 and self.x4 + 8 > e.x2 and self.y4 + 8 >= e.y2 and self.y4 + 8 < e.y2 + 8)) then
				return (false)
			end
			if ((self.x1 <= e.x3 + 8 and self.x1 + 8 > e.x3 and self.y1 + 8 >= e.y3 and self.y1 + 8 < e.y3 + 8)
				or (self.x2 <= e.x3 + 8 and self.x2 + 8 > e.x3 and self.y2 + 8 >= e.y3 and self.y2 + 8 < e.y3 + 8)
				or (self.x3 <= e.x3 + 8 and self.x3 + 8 > e.x3 and self.y3 + 8 >= e.y3 and self.y3 + 8 < e.y3 + 8)
				or (self.x4 <= e.x3 + 8 and self.x4 + 8 > e.x3 and self.y4 + 8 >= e.y3 and self.y4 + 8 < e.y3 + 8)) then
				return (false)
			end
			if ((self.x1 <= e.x4 + 8 and self.x1 + 8 > e.x4 and self.y1 + 8 >= e.y4 and self.y1 + 8 < e.y4 + 8)
				or (self.x2 <= e.x4 + 8 and self.x2 + 8 > e.x4 and self.y2 + 8 >= e.y4 and self.y2 + 8 < e.y4 + 8)
				or (self.x3 <= e.x4 + 8 and self.x3 + 8 > e.x4 and self.y3 + 8 >= e.y4 and self.y3 + 8 < e.y4 + 8)
				or (self.x4 <= e.x4 + 8 and self.x4 + 8 > e.x4 and self.y4 + 8 >= e.y4 and self.y4 + 8 < e.y4 + 8)) then
				return (false)
			end
		end
	end
	return (true)
end

function tetra:rotate()
	if (self.shape == 2) then
		self:r_line()	
	end
end