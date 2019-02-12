
tetra = {x1, y1, x2, y2, x3, y3, x4, y4, sqr, spd, shape, move}
tetra.__index = tetra

function tetra:new()
	obj = {}
	setmetatable(obj, tetra)
	
	obj.spd = 1;
	obj.shape = flr(rnd(7)) + 1;
	
	--square
	if (obj.shape == 1) then
		obj.x1 = 56;
		obj.y1 = -16;
		obj.x2 = 64;
		obj.y2 = -16;
		obj.x3 = 56;
		obj.y3 = -8;
		obj.x4 = 64;
		obj.y4 = -8;
	end
	
	--line
	if(obj.shape == 2) then
		obj.x1 = 64;
		obj.y1 = -32;
		obj.x2 = 64;
		obj.y2 = -24;
		obj.x3 = 64;
		obj.y3 = -16;
		obj.x4 = 64;
		obj.y4 = -8;
	end
	
	--t shape
	if(obj.shape == 3) then
		obj.x1 = 64;
		obj.y1 = -16;
		obj.x2 = 56;
		obj.y2 = -8;
		obj.x3 = 64;
		obj.y3 = -8;
		obj.x4 = 72;
		obj.y4 = -8;
	end
	
	--z shape
	if(obj.shape == 4) then
		obj.x1 = 72;
		obj.y1 = -24;
		obj.x2 = 72;
		obj.y2 = -16;
		obj.x3 = 64;
		obj.y3 = -16;
		obj.x4 = 64;
		obj.y4 = -8;
	end
	
	--s shape
	if(obj.shape == 5) then
		obj.x1 = 64;
		obj.y1 = -16;
		obj.x2 = 72;
		obj.y2 = -16;
		obj.x3 = 56;
		obj.y3 = -8;
		obj.x4 = 64;
		obj.y4 = -8;
	end
	
	--l shape
	if(obj.shape == 6) then
		obj.x1 = 72;
		obj.y1 = -16;
		obj.x2 = 56;
		obj.y2 = -8;
		obj.x3 = 64;
		obj.y3 = -8;
		obj.x4 = 72;
		obj.y4 = -8;
	end
	
 --j shape
if(obj.shape == 7) then
	obj.x1 = 56;
	obj.y1 = -16;
	obj.x2 = 56;
	obj.y2 = -8;
	obj.x3 = 64;
	obj.y3 = -8;
	obj.x4 = 72;
	obj.y4 = -8;
	end
	obj.mv = 1;
	return obj
end

function tetra:draw()
	spr(self.shape, self.x1, self.y1);
	spr(self.shape, self.x2, self.y2);
	spr(self.shape, self.x3, self.y3);
	spr(self.shape, self.x4, self.y4);
	print(self.y1);
end

function tetra:colision()
	if (self.y1 >= 120 or self.y2 >= 120 or self.y3 >= 120 or self.y4 >= 120) then
		return (false)
	end
	for e in all(t_list) do
		if (e.y1 == self.y1) then
			return (true);
		end
		if ((self.y1 + 8 >= e.y1 and self.y1 + 8 < e.y1 + 8 and self.x1 == e.x1) or (self.y2 + 8 >= e.y1 and self.y2 + 8 < e.y1 + 8 and self.x2 == e.x1) or (self.y3 + 8 >= e.y1 and self.y3 + 8 < e.y1 + 8 and self.x3 == e.x1) or (self.y4 + 8 >= e.y1 and self.y4 + 8 < e.y1 + 8 and self.x4 == e.x1)) then
			return (false)
		end
		if ((self.y1 + 8 >= e.y2 and self.y1 + 8 < e.y2 + 8 and self.x1 == e.x2) or (self.y2 + 8 >= e.y2 and self.y2 + 8 < e.y2 + 8 and self.x2 == e.x2) or (self.y3 + 8 >= e.y2 and self.y3 + 8 < e.y2 + 8 and self.x3 == e.x2) or (self.y4 + 8 >= e.y2 and self.y4 + 8 < e.y2 + 8 and self.x4 == e.x2)) then
			return (false)
		end
		if ((self.y1 + 8 >= e.y3 and self.y1 + 8 < e.y3 + 8 and self.x1 == e.x3) or (self.y2 + 8 >= e.y3 and self.y2 + 8 < e.y3 + 8 and self.x2 == e.x3) or (self.y3 + 8 >= e.y3 and self.y3 + 8 < e.y3 + 8 and self.x3 == e.x3) or (self.y4 + 8 >= e.y3 and self.y4 + 8 < e.y3 + 8 and self.x4 == e.x3)) then
			return (false)
		end
		if ((self.y1 + 8 >= e.y4 and self.y1 + 8 < e.y4 + 8 and self.x1 == e.x4) or (self.y2 + 8 >= e.y4 and self.y2 + 8 < e.y4 + 8 and self.x2 == e.x4) or (self.y3 + 8 >= e.y4 and self.y3 + 8 < e.y4 + 8 and self.x3 == e.x4) or (self.y4 + 8 >= e.y4 and self.y4 + 8 < e.y4 + 8 and self.x2 == e.x4)) then
			return (false)
		end
	end
	return (true)
end

function tetra:update()
	col = self:colision();
	if(col) then
		self.y1 += self.spd;
		self.y2 += self.spd;
		self.y3 += self.spd;
		self.y4 += self.spd;
		if btnp(1) and self.x2 < 120 then
			self.x1 += 8
			self.x2 += 8
			self.x3 += 8
			self.x4 += 8
		end
		if btnp(0) and self.x1 > 0 then
			self.x1 -= 8
			self.x2 -= 8
			self.x3 -= 8
			self.x4 -= 8
		end
		if btn(3) then
			self.y1 += 2;
			self.y2 += 2;
			self.y3 += 2;
			self.y4 += 2;
			if (self:colision() == false) then
				self.y1 -= 2;
				self.y2 -= 2;
				self.y3 -= 2;
				self.y4 -= 2;
			end
		end
	end
	if (col == false and self.mv != 0) then
		self.mv = 0;
		if (self.y1 > 0) then
			add(t_list, tetra:new());
		end
	end
end