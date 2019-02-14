
tetra = {x, x1, y1, x2, y2, x3, y3, x4, y4, sqr, spd, shape, next, move, state, d, min_x, max_x}
tetra.__index = tetra

function tetra:new(x, min_x, max_x, sha)
	obj = {}
	setmetatable(obj, tetra)
	
	obj.spd = spd;
	obj.next = flr(rnd(7)) + 1;
	obj.shape = sha
	obj.state = 0;
	obj.min_x = min_x
	obj.max_x = max_x
	obj.x = x
	
	--square
	if (obj.shape == 1) then
		obj.x1 = -8 + x;
 	obj.y1 = -16;
 	obj.x2 = x;
 	obj.y2 = -16;
 	obj.x3 = - 8 + x;
 	obj.y3 = -8;
 	obj.x4 = x;
 	obj.y4 = -8;
	end
	
	--line
	if(obj.shape == 2) then
		obj.x1 = x;
 	obj.y1 = -32;
 	obj.x2 = x;
 	obj.y2 = -24;
 	obj.x3 = x;
 	obj.y3 = -16;
 	obj.x4 = x;
 	obj.y4 = -8;
	end
	
	--t shape
	if(obj.shape == 3) then
	 obj.x1 = x;
 	obj.y1 = -16;
 	obj.x2 = -8 + x;
 	obj.y2 = -8;
 	obj.x3 = x;
 	obj.y3 = -8;
 	obj.x4 = 8 + x;
 	obj.y4 = -8;
	end
	
	--z shape
	if(obj.shape == 4) then
	 obj.x1 = 8 + x;
 	obj.y1 = -24;
 	obj.x2 = 8 + x;
 	obj.y2 = -16;
 	obj.x3 = x;
 	obj.y3 = -16;
 	obj.x4 = x;
 	obj.y4 = -8;
	end
	
	--s shape
	if(obj.shape == 5) then
	 obj.x1 = x;
 	obj.y1 = -16;
 	obj.x2 = 8 + x;
 	obj.y2 = -16;
 	obj.x3 = -8 + x;
 	obj.y3 = -8;
 	obj.x4 = x;
 	obj.y4 = -8;
	end
	
	--l shape
	if(obj.shape == 6) then
	 obj.x1 = 8 + x;
 	obj.y1 = -16;
 	obj.x2 = -8 + x;
 	obj.y2 = -8;
 	obj.x3 = x;
 	obj.y3 = -8;
 	obj.x4 = 8 + x;
 	obj.y4 = -8;
	end
	
 --j shape
 if(obj.shape == 7) then
	 obj.x1 = -8 + x;
 	obj.y1 = -16;
 	obj.x2 = -8 + x;
 	obj.y2 = -8;
 	obj.x3 = x;
 	obj.y3 = -8;
 	obj.x4 = 8 + x;
 	obj.y4 = -8;
	end
	obj.mv = 1;
	obj.d = 0
	return obj
end

function tetra:draw(mode)
	spr(self.shape, self.x1, self.y1);
	spr(self.shape, self.x2, self.y2);
 spr(self.shape, self.x3, self.y3);
 spr(self.shape, self.x4, self.y4);
	if (mode) then
		spr(31 + self.next, 110, 100);
	end
end

function tetra:update()
	local mode = 0
	if self.min_x == 64 then mode = 1 end
	if(self:colision()) then
		self.y1 += self.spd;
		self.y2 += self.spd;
		self.y3 += self.spd;
		self.y4 += self.spd;
		
		if btnp(1, mode) and self.mv == 1 and self:r_col() then
			self.x1 += 8
			self.x2 += 8
			self.x3 += 8
			self.x4 += 8
		end
		
		if btnp(0, mode) and self.mv == 1 and self:l_col() then
			self.x1 -= 8
			self.x2 -= 8
			self.x3 -= 8
			self.x4 -= 8
		end
		
		if btnp(2, mode) and self.mv == 1 then
			self:rotate()
		end
		
		if btn(3, mode) and self.mv == 1 then
			self.y1 += 2;
			self.y2 += 2;
			self.y3 += 2;
			self.y4 += 2;
		end
	end
	
	if (self:colision() == false and self.mv != 0) then
		self.mv = 0;
		self:offset()
		if (self.y1 > 0) then
			add(t_list, tetra:new(self.x, self.min_x, self.max_x, self.next));
		end
	end
end