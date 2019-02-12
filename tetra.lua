
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
end

function tetra:update()
	col = self:colision();
	if(col) then
		self.y1 += self.spd;
		self.y2 += self.spd;
		self.y3 += self.spd;
		self.y4 += self.spd;
		
		if btnp(1) and self:r_col() then
			self.x1 += 8
			self.x2 += 8
			self.x3 += 8
			self.x4 += 8
		end
		
		if btnp(0) and self:l_col() then
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