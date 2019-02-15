pico-8 cartridge // http://www.pico-8.com
version 16
__lua__

t_list = {}

function _init()
		palt(0, false)
		p1_m = 0
		p2_m = 0
		etat = 0
		key = 0
		level = 1
		spd = 1
		lined = 0
		c = 0
		music(0)
end

function init_game()
	etat = 1 
	music(1)
	local n = flr(rnd(7)) + 1;
	if (key == 0) then
		add(t_list, tetra:new(56, 16, 88, n))
	end
	if (key == 1) then
		add(t_list, tetra:new(32, 0, 56, n))
		add(t_list, tetra:new(96, 64, 120, n))
	end
end

function menu()
	map(16, 0, 0, 0, 16, 16)
	if (btnp(1) or btnp(0)) then
		if key == 1 then key = 0
		else key = 1 end
 end
 if (key == 0) then
 	spr(142, 0, 65)
 	spr(143, 8, 65)
 	spr(158, 0, 73)
 	spr(159, 8, 73)
 end
 if (key == 1) then
  spr(142, 64, 65)
  spr(143, 72, 65)
  spr(158, 64, 73)
  spr(159, 72, 73)
 end
 if btnp(4) then
 	init_game()	
	end
end

function one_player()
		map(0, 0, 0, 0, 16, 16)
	 for e in all(t_list) do
		 e:draw(true);
	 end
	 print ("line", 105, 10, 7)
	 print (lined, 110, 20, 7)
	 print ("level", 105, 30, 7)
	 print (level, 110, 40, 7)
end

function two_player()
 local h = 120
	map(0, 16, 0, 0, 16, 16)
	for e in all(t_list) do
		 e:draw(false);
	end
	for i = 1, p2_m do
		map(16, 16, 64, h, 8, 1)
		h -= 8
	end
	h = 120
	for i = 1, p1_m do
		map(16, 16, 0, h, 8, 1)
		h -= 8
	end
end

function _draw()
	cls()
	if (etat != 0) then
	 if (key == 0) then
	  one_player();
	 end
		if (key == 1) then
		two_player();
		end
	end
	if (etat == 3 and key == 1) then
	  --player 2 win
	  map(48, 0, 0, 0, 16, 16)
	end
	if (etat == 2 and key == 1) then
	  --player 1 win
	  map(32, 0, 0, 0, 16, 16)
	end
	if (etat == 2 and key == 0) then
	  --solo
	  map(64, 0, 0, 0, 16, 16)
	end 
	if (etat == 0) then
	 menu()
	end
end

function one_update()
	for e in all(t_list) do
		 if (e.mv == 1) then
		 	e:update();
		 end
	 end
	 check_line(10, 16, 88)
	 destroy();
	 if (lined % 5 == 0 and c == 1) then
	 	level += 1
	 	spd += 0.25
	 	c = 0
	 end
end

function two_update()
 for e in all(t_list) do
		 if (e.mv == 1) then
		 	e:update();
		 end
	 end
	 check_line(8, 0, 56);
	 check_line(8, 64, 120);
	 destroy();
end

function _update()
	if etat == -1 then etat = 0 end
	if etat == 1 then
		if (key == 0) then
			one_update()
		end
 	if (key == 1) then
	 	two_update();
		end
	end
	if (etat >= 2 and btnp(4)) then
		etat = -1
		music(0)
		p1_m = 0
		p2_m = 0
		for e in all(t_list) do 
			del(t_list, e);
		end
	end
end

-->8

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
		else
			etat = 2
			if self.min_x == 64 then
				etat = 3
			end
		end
	end
end

-->8
function tetra:offset()
	while (self.y1 % 8 != 0) do
		self.y1 = ceil(self.y1);
		self.y2 = ceil(self.y2);
		self.y3 = ceil(self.y3);
		self.y4 = ceil(self.y4);
		self.y1 -= 1;
		self.y2 -= 1;
		self.y3 -= 1;
		self.y4 -= 1;
	end
end

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
			 self:offset()
			 return (false)
	 	end
	 	if ((self.y1 + 8 >= e.y2 and self.y1 + 8 < e.y2 + 8 and self.x1 == e.x2)
	 		or (self.y2 + 8 >= e.y2 and self.y2 + 8 < e.y2 + 8 and self.x2 == e.x2)
				or (self.y3 + 8 >= e.y2 and self.y3 + 8 < e.y2 + 8 and self.x3 == e.x2)
				or (self.y4 + 8 >= e.y2 and self.y4 + 8 < e.y2 + 8 and self.x4 == e.x2)) then
		 	self:offset()
		 	return (false)
	 	end
	 	if ((self.y1 + 8 >= e.y3 and self.y1 + 8 < e.y3 + 8 and self.x1 == e.x3)
	 		or (self.y2 + 8 >= e.y3 and self.y2 + 8 < e.y3 + 8 and self.x2 == e.x3)
	 		or (self.y3 + 8 >= e.y3 and self.y3 + 8 < e.y3 + 8 and self.x3 == e.x3)
	 		or (self.y4 + 8 >= e.y3 and self.y4 + 8 < e.y3 + 8 and self.x4 == e.x3)) then
		 	self:offset()
		 	return (false)
	 	end
	 	if ((self.y1 + 8 >= e.y4 and self.y1 + 8 < e.y4 + 8 and self.x1 == e.x4)
	 		or (self.y2 + 8 >= e.y4 and self.y2 + 8 < e.y4 + 8 and self.x2 == e.x4)
	 		or (self.y3 + 8 >= e.y4 and self.y3 + 8 < e.y4 + 8 and self.x3 == e.x4)
	 		or (self.y4 + 8 >= e.y4 and self.y4 + 8 < e.y4 + 8 and self.x4 == e.x4)) then
		 	return (false)
  	end
  end
	end
	return (true)
end

function tetra:r_col()
	if (self.x1 >= self.max_x or self.x2 >= self.max_x or self.x3 >= self.max_x or self.x4 >= self.max_x) then
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
	if (self.x1 <= self.min_x or self.x2 <= self.min_x or self.x3 <= self.min_x or self.x4 <= self.min_x) then
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
	self.min_x -= 1
	self.max_x += 1
	if (self.shape == 2) then
		self:r_line()
	end
	if (self.shape == 3) then
		self:r_t_shape()
	end
	if (self.shape == 4) then
		self:r_z_shape()
	end
	if (self.shape == 5) then
		self:r_s_shape()
	end
	if (self.shape == 6) then
		self:r_l_shape()
	end
	if (self.shape == 7) then
		self:r_j_shape()
	end
	self.min_x += 1
	self.max_x -= 1
end
-->8
function tetra:set_rotate(x1, y1, x2, y2, x3, y3, x4, y4)
	self.x1 = x1
	self.y1 = y1
	self.x2 = x2
	self.y2 = y2
	self.x3 = x3
	self.y3 = y3
	self.x4 = x4
	self.y4 = y4
end

function tetra:r_line()
	local x1 = self.x1
	local y1 = self.y1
	local x2 = self.x2
	local y2 = self.y2
	local x3 = self.x3
	local y3 = self.y3
	local x3 = self.x3
	local y3 = self.y3
	local x4 = self.x4
	local y4 = self.y4

	if (self.state == 0) then
		self:set_rotate(x2 - 8, y2, x2, y2, x2 + 8, y2, x2 + 16, y2)
		self.state = 1;
		if ((self:r_col() == false) 
			or (self:l_col() == false)) then
				self:set_rotate(x1, y1, x2, y2, x3, y3, x4, y4)
				self.state = 0;
		end
	else
		if (self.state == 1) then
		self:set_rotate(x2, y2 + 8, x2, y2, x2, y2 - 8, x2, y2 - 16)
		self.state = 0;
		end
		if (self:colision() == false) then
			self:set_rotate(x1, y1, x2, y2, x3, y3, x4, y4)
			self.state = 0
		end
	end
end

function tetra:r_t_shape()
	local x1 = self.x1
	local y1 = self.y1
	local x2 = self.x2
	local y2 = self.y2
	local x3 = self.x3
	local y3 = self.y3
	local x3 = self.x3
	local y3 = self.y3
	local x4 = self.x4
	local y4 = self.y4

	if (self.state == 0) then
		self.x2 = x3
		self.y2 = y3 + 8 
		self.state = 1;
		if ((self:colision() == false)
			or (self:r_col() == false)
			or (self:l_col() == false)) then
				self:set_rotate(x1, y1, x2, y2, x3, y3, x4, y4)
				self.state = 0;
		end
	else
		if (self.state == 1) then
			self.x1 = x3 - 8
			self.y1 = y3
			self.state = 2;
			if ((self:colision() == false)
				or (self:r_col() == false)
				or (self:l_col() == false)) then
				self:set_rotate(x1, y1, x2, y2, x3, y3, x4, y4)
				self.state = 1;
			end
		else
			if (self.state == 2) then
				self.x4 = x3
				self.y4 = y3 - 8
				self.state = 3
				if ((self:colision() == false)
					or (self:r_col() == false)
					or (self:l_col() == false)) then
					self:set_rotate(x1, y1, x2, y2, x3, y3, x4, y4)
					self.state = 2;
				end
			else
				if (self.state == 3) then
					self:set_rotate(x3, y3 - 8, x3 - 8, y3, x3, y3, x3 + 8, y3)
					self.state = 0
					if ((self:colision() == false)
						or (self:r_col() == false)
						or (self:l_col() == false)) then
						self:set_rotate(x1, y1, x2, y2, x3, y3, x4, y4)
						self.state = 3;
					end
				end
			end
		end
	end
end

function tetra:r_z_shape()
  
	local x1 = self.x1
	local y1 = self.y1
	local x2 = self.x2
	local y2 = self.y2
	local x3 = self.x3
	local y3 = self.y3
	local x3 = self.x3
	local y3 = self.y3
	local x4 = self.x4
	local y4 = self.y4
	
 if (self.state == 0) then
 self:set_rotate(x2 - 8, y2, x2, y2, x2 - 8, y2 - 8, x2 - 16, y2 - 8)
 self.state = 1;
 if ((self:colision() == false)
			or (self:r_col() == false)
			or (self:l_col() == false)) then
				self:set_rotate(x1, y1, x2, y2, x3, y3, x4, y4)
				self.state = 0;
		end
 else
  if (self.state == 1) then
  	self:set_rotate(x2, y2 - 8, x2, y2, x2 - 8, y2 + 8, x2 - 8, y2)
   self.state = 0
   if ((self:colision() == false)
				or (self:r_col() == false)
				or (self:l_col() == false)) then
					self:set_rotate(x1, y1, x2, y2, x3, y3, x4, y4)
					self.state = 1;
			end
 	end
 end
end

function tetra:r_s_shape()
 local x1 = self.x1
	local y1 = self.y1
	local x2 = self.x2
	local y2 = self.y2
	local x3 = self.x3
	local y3 = self.y3
	local x3 = self.x3
	local y3 = self.y3
	local x4 = self.x4
	local y4 = self.y4

	if (self.state == 0) then
		self:set_rotate(x1, y2 - 8, x2, y2, x2 - 8, y2, x2, y4)
  self.state = 1;
  if ((self:colision() == false)
			or (self:r_col() == false)
			or (self:l_col() == false)) then
				self:set_rotate(x1, y1, x2, y2, x3, y3, x4, y4)
				self.state = 0;
		end
 else
 	if (self.state == 1) then
 		self:set_rotate(x1, y2, x2, y2, x2 - 8, y2 + 8, x2 - 16, y4)
  	self.state = 0;
  	if ((self:colision() == false)
				or (self:r_col() == false)
				or (self:l_col() == false)) then
				self:set_rotate(x1, y1, x2, y2, x3, y3, x4, y4)
				self.state = 1;
			end
  end
 end
end

function tetra:r_l_shape()
	local x1 = self.x1
	local y1 = self.y1
	local x2 = self.x2
	local y2 = self.y2
	local x3 = self.x3
	local y3 = self.y3
	local x3 = self.x3
	local y3 = self.y3
	local x4 = self.x4
	local y4 = self.y4
	
	if (self.state == 0) then
  self:set_rotate(x2, y2 - 16, x2, y2, x2, y2 - 8, x2 + 8, y2)
  self.state = 1;
  if ((self:colision() == false)
				or (self:r_col() == false)
				or (self:l_col() == false)) then
				self:set_rotate(x1, y1, x2, y2, x3, y3, x4, y4)
				self.state = 0;
			end
 else
  if (self.state == 1) then
  	self:set_rotate(x1, y2 - 8, x2, y2, x2 + 8, y3, x2 + 16, y2 - 8)  
   self.state = 2
   if ((self:colision() == false)
				or (self:r_col() == false)
				or (self:l_col() == false)) then
				self:set_rotate(x1, y1, x2, y2, x3, y3, x4, y4)
				self.state = 1;
			end
  else
   if (self.state == 2) then
   	self:set_rotate(x1, y1, x2, y2, x2, y2 - 16, x2 - 8, y2 - 16)
    self.state = 3;
   	if ((self:colision() == false)
					or (self:r_col() == false)
					or (self:l_col() == false)) then
					self:set_rotate(x1, y1, x2, y2, x3, y3, x4, y4)
					self.state = 2;
				end
   else
    if (self.state == 3) then
    	self:set_rotate(x2 - 8, y2, x2, y2, x2 + 8, y2, x2 + 8, y2 - 8)
     self.state = 0;
    	if ((self:colision() == false)
						or (self:r_col() == false)
						or (self:l_col() == false)) then
						self:set_rotate(x1, y1, x2, y2, x3, y3, x4, y4)
						self.state = 3;
					end
  		end
   end
  end
 end
end

function tetra:r_j_shape()
 local x1 = self.x1
	local y1 = self.y1
	local x2 = self.x2
	local y2 = self.y2
	local x3 = self.x3
	local y3 = self.y3
	local x3 = self.x3
	local y3 = self.y3
	local x4 = self.x4
	local y4 = self.y4

 if (self.state == 0) then
 	self:set_rotate(x1, y2 + 8, x3, y3 + 8, x3, y3, x3, y3 - 8)
  self.state = 1;
  if ((self:colision() == false)
			or (self:r_col() == false)
			or (self:l_col() == false)) then
				self:set_rotate(x1, y1, x2, y2, x3, y3, x4, y4)
				self.state = 0;
			end
 else
 	if (self.state == 1) then
 	self:set_rotate(x2 + 8, y1, x3 + 8, y3, x3, y3, x3 - 8, y3)
 	 self.state = 2;
 	 if ((self:colision() == false)
				or (self:r_col() == false)
				or (self:l_col() == false)) then
				self:set_rotate(x1, y1, x2, y2, x3, y3, x4, y4)
				self.state = 1;
			end
 	else
 		if (self.state == 2) then
 			self:set_rotate(x2, y2, x3, y3, x3, y3 + 8, x3, y3 + 16) 
 			self.state = 3
 			if ((self:colision() == false)
						or (self:r_col() == false)
						or (self:l_col() == false)) then
						self:set_rotate(x1, y1, x2, y2, x3, y3, x4, y4)
						self.state = 2;
				end
 		else
 			if (self.state == 3) then
 				self:set_rotate(x2 - 8, y2 - 8, x2 - 8, y2, x3, y3 - 8, x3 + 8, y3 - 8)
					self.state = 0;
					if ((self:colision() == false)
						or (self:r_col() == false)
						or (self:l_col() == false)) then
						self:set_rotate(x1, y1, x2, y2, x3, y3, x4, y4)
						self.state = 3;
					end
 			end
 		end
 	end
 end
end
-->8

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
__gfx__
000000007aaaaaa07cccccc072222220788888807bbbbbb0799999907eeeeee000000000ddddddd0888888887777777777777777770000770677777706777777
00000000a77aaaa0c77cccc02772222087788880b77bbbb097799990e77eeee000000000ddddddd0888888887777777770000007770000770677777706777777
00700700a7aaaaa0c7ccccc02722222087888880b7bbbbb097999990e7eeeee000000000ddddddd0888888887777777770000007770077770677777706777777
00077000aaaaaaa0ccccccc02222222088888880bbbbbbb099999990eeeeeee000000000ddddddd0888888887777777777700777770000770677777706777777
00077000aaaaaaa0ccccccc02222222088888880bbbbbbb099999990eeeeeee000000000ddddddd0888888887777777777700777770000770677777706777777
00700700aaaaaaa0ccccccc02222222088888880bbbbbbb099999990eeeeeee000000000ddddddd0888888887777777777700777770077770677777706777777
00000000aaaaaaa0ccccccc02222222088888880bbbbbbb099999990eeeeeee000000000ddddddd0888888887777777777700777770000770677777706666666
00000000000000000000000000000000000000000000000000000000000000000000000000000000888888887777777777700777770000770677777700000000
0000000077777777777777600000000000000000777777607777777777777777ffffffff77760ffffff06777fff0677777760fff333333333333333000000000
0666666677777777777777606666666666666660777777607777777777777777ffffffff77760ffffff06777fff0677777760fff333333333333333000000000
0677777777777777777777607777777777777760777777607777777777777777ffffffff77760ffffff06777fff0677777760fff333333333333333000000000
0677777777777777777777607777777777777760777777607777777777777777ffffffff77760ffffff06777fff0677777760fff333333333333333000000000
0677777777777777777777607777777777777760777777607777777777777777ffffffff77760ffffff06777fff0677777760fff333333333333333000000000
0677777777777777777777607777777777777760777777607777777777777777ffffffff77760ffffff06777fff0677777760fff333333333333333000000000
0677777766666666777777607777777777777760666666606666677777766666ffffffff77760ffffff06777fff0666666660fff333333333333333000000000
0677777700000000777777607777777777777760000000000000677777760000ffffffff77760ffffff06777fff0000000000fff333333333333333000000000
33333333333cc33333333333333388833bbb3333399933333333eee300000000000000003dddddd0ddddddd399999999cccccccc22222222aaaaaaaaeeeeeeee
3aaaaaa3333cc33333322333333388833bbb3333399933333333eee300000000000000003dddddd0ddddddd399999999cccccccc22222222aaaaaaaaeeeeeeee
3aaaaaa3333cc33333322333333388833bbb3333399933333333eee300000000000000003dddddd0ddddddd399999999cccccccc22222222aaaaaaaaeeeeeeee
3aaaaaa3333cc33333322333388888833bbbbbb3399933333333eee300000000000000003dddddd0ddddddd399999999cccccccc22222222aaaaaaaaeeeeeeee
3aaaaaa3333cc33332222223388888833bbbbbb3399933333333eee300000000000000003dddddd0ddddddd399999999cccccccc22222222aaaaaaaaeeeeeeee
3aaaaaa3333cc33332222223388833333333bbb3399999933eeeeee300000000000000003dddddd0ddddddd399999999cccccccc22222222aaaaaaaaeeeeeeee
3aaaaaa3333cc33332222223388833333333bbb3399999933eeeeee300000000000000003dddddd0ddddddd399999999cccccccc22222222aaaaaaaaeeeeeeee
33333333333cc33333333333388833333333bbb3399999933eeeeee30000000000000000300000000000000399999999cccccccc22222222aaaaaaaaeeeeeeee
755555508888888899999999cccccccc22222222aaaaaaaaeeeeeeee333333337555555300000000000000000000000000000000000000000000000000000000
577555508777788897777999c7777ccc27777222a7777aaae7777eee377773335775555300000000000000000000000000000000000000000000000000000000
575555508777788897777999c7777ccc27777222a7777aaae7777eee377773335755555300000000000000000000000000000000000000000000000000000000
555555508778888897799999c77ccccc27722222a77aaaaae77eeeee377333335555555300000000000000000000000000000000000000000000000000000000
555555508778888897799999c77ccccc27722222a77aaaaae77eeeee377333335555555300000000000000000000000000000000000000000000000000000000
555555508778888897799999c77ccccc27722222a77aaaaae77eeeee377333335555555300000000000000000000000000000000000000000000000000000000
555555508778888897799999c77ccccc27722222a77aaaaae77eeeee377333335555555300000000000000000000000000000000000000000000000000000000
000000008888888899999999cccccccc22222222aaaaaaaaeeeeeeee333333330000000300000000000000000000000000000000000000000000000000000000
ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff7777777777777777777777777777777700000000000000000000000000000000
ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff7777777777777777777777777777777700000000000000000000000000000000
ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff7777777777777777777777777777777700000000000000000000000000000000
ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff7777777777777777777777777777777700000000000000000000000000000000
ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff7777777777777777777777777777777700000000000000000000000000000000
ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff7777777777777777777777777777777700000000000000000000000000000000
ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff7777777777777777777777777777777700000000000000000000000000000000
ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff7777777777777777777777777777777700000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000007777777777777777777777777777777700000000000000000000000000000000
06666666666666666666666666666666666666666666666666666666666666607777777777777777777777777777777700000000000000000000000000000000
06888888888888799999999997aaaaaaaaaaaa73333333333cccc722222222607777777777777777777777777777777700000000000000000000000000000000
06877888888888797799999997a77aaaaaaaaa73773333333c77c727722222607777777777777777777777777777777700000000000000000000000000000000
06878888888888797999999997a7aaaaaaaaaa73733333337c7cc727222222607777777777777777777777777777777700000000000000000000000000000000
06878888888888797999999997a7aaaaaaaaaa73733777337cccc722227772607777777777777777777777777777777700000000000000000000000000000000
06888888888888799999999997aaaaaaaaaaaa733377733377777722277777607777777777777777777777777777777700000000000000000000000000000000
06888888888888799999999997aaaaaaaaaaaa73337773337cccc722277777607777777777777777777777777777777700000000000000000000000000000000
06777888888777799999777777777aaaaaa77773337773377cccc722227777607777777777777777777777777777777700000000000000000000000000000000
06777888888777799999777777777aaaaaa77773337733377cccc722222777607777777777777777777777777777777700000000000000000000000000000000
06777888888777799999777777777aaaaaa77773333333377cccc722222277607777777777777777777777777777777700000000000000000000000000000000
06777888888777799999999997777aaaaaa77773333333377cccc772222227607777777777777777777777777777777700000000000000000000000000000000
06777888888777799999999997777aaaaaa77773337333337cccc777222222607777777777777777777777777777777700000000000000000000000000000000
06777888888777799999999997777aaaaaa77773337733337cccc777722222607777777777777777777777777777777700000000000000000000000000000000
06777888888777799999999997777aaaaaa77773337733337cccc777772222607777777777777777777777777777777700000000000000000000000000000000
06777888888777799999977777777aaaaaa77773337773337cccc777777222607777777777777777777777777777777700000000000000000000000000000000
06777888888777799999977777777aaaaaa77773337773337cccc777777222607777777777777777777777777777777700000000000000000000000000000000
06777888888777799999977777777aaaaaa77773337773333cccc777777222607777777777777777777777777777777700000000000000000000000000000000
06777878888777797999999997777a7aaaa77773337777333cccc727772222607777777777777777777777777777777700000000000000000000000000000000
06777878888777797999999997777a7aaaa777733377773333ccc722222222607777777777777777777777777777777700000000000000000000000000000000
06777877888777797799999997777a77aaa777737377777333ccc727722222607777777777777777777777777777777700000000000000000000000000000000
06777888888777799999999997777aaaaaa7777333777773333cc722222222607777777777777777777777777777777700000000000000000000000000000000
06666666666666666666677777777777777777777776666666666666666666607777777777777777777777777777777700000000000000000000000000000000
00000000000000000000677777777777777777777776000000000000000000007777777777777777777777777777777700000000000000000000000000000000
fffffffffffffffffff06777777777777777777777760fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
fffffffffffffffffff06777777777777777777777760fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
fffffffffffffffffff06777777777777777777777760ffffffffffffffffffff00000fff00000fff00ffffffff00000ffffffffffffffffffffffffffffffff
fffffffffffffffffff06777777777777777777777760fffffffffffffffffff000000ff0000000ff00fffffff0000000fffffffffffffffffffffffffffffff
fffffffffffffffffff06777777777777777777777760fffffffffffffffffff00ffffff0000000ff00fffffff00fff00ffffffffffffffff0fffffff0ffffff
fffffffffffffffffff06777777777777777777777760fffffffffffffffffff00ffffff00fff00ff00fffffff00fff00fffffffffffffffff000ffff000ffff
fffffffffffffffffff06777700777777777700777760fffffffffffffffffff00ffffff00fff00ff00fffffff00fff00fffffffffffffffffff0000000000ff
fffffffffffffffffff067770dd0777777770dd077760fffffffffffffffffff000000ff00fff00ff00fffffff00fff00ffffffffffffffff00fff000000000f
fffffffffffffffffff067770ddd07777770ddd077760fffffffffffffffffff000000ff00fff00ff00fffffff00fff00ffffffffffffffffff00000000000ff
fffffffffffffffffff067770dddd000000dddd077760fffffffffffffffffffffff00ff00fff00ff00fffffff00fff00ffffffffffffffffffffffff000ffff
fffffffffffffffffff067770ddddd5555ddddd077760fffffffffffffffffffffff00ff00fff00ff00fffffff00fff00ffffffffffffffffffffffff0ffffff
fffffffffffffffffff067770dddddddddddddd077760fffffffffffffffffffffff00ff00fff00ff00fffffff0000000fffffffffffffffffffffffffffffff
fffffffffffffffffff067770dddddddddddddd077760fffffffffffffffffff000000ff0000000ff0000000ff0000000fffffffffffffffffffffffffffffff
fffffffffffffffffff06770dddddddddddddddd07760fffffffffffffffffff00000ffff00000fff0000000fff00000ffffffffffffffffffffffffffffffff
fffffffffffffffffff06770000000000000000007760fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
fffffffffffffffffff067700707000d0070700007760fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
fffffffffffffffffff06770d07000ddd007000e07760fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff0000000000000000
fffffffffffffffffff06770de000dddddd000ee07760fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff0000000000000000
fffffffffffffffffff06770deeeddd0dddddeee07760fffffffffffffffffff00ffff00ff00fff00ff00ffff000000ff00fffffffffffff0000000000000000
fffffffffffffffffff067770ddddd000dddddd077760fffffffffffffffffff000ff000ff00fff00ff00ffff000000ff00fffffffffffff0000000000000000
fffffffffffffffffff0677770dddddddddddd0777760fffffffffffffffffff00000000ff00fff00ff00ffffff00fffffffffffffffffff0000000000000000
fffffffffffffffffff06777700000000000000777760fffffffffffffffffff00f00f00ff00fff00ff00ffffff00ffff00fffffffffffff0000000000000000
fffffffffffffffffff06666666666666666666666660fffffffffffffffffff00ffff00ff00fff00ff00ffffff00ffff00fffffffffffff0000000000000000
fffffffffffffffffff00000000000000000000000000fffffffffffffffffff00ffff00ff00fff00ff00ffffff00ffff00fffffffffffff0000000000000000
ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff00ffff00ff00fff00ff00ffffff00ffff00fffffffffffff0000000000000000
ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff00ffff00ff00fff00ff00ffffff00ffff00fffffffffffff0000000000000000
ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff00ffff00ff00fff00ff00ffffff00ffff00fffffffffffff0000000000000000
ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff00ffff00ff00fff00ff00ffffff00ffff00fffffffffffff0000000000000000
ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff00ffff00ff0000000ff000000ff00ffff00fffffffffffff0000000000000000
ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff00ffff00fff00000fff000000ff00ffff00fffffffffffff0000000000000000
ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff0000000000000000
ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff0000000000000000
ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff0000000000000000000000000000000077777777777777777777777777777777
ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff0777777777777777777777777777777077777777777777777777777777777777
ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff0777777777777777777777777777777077777777777777777777777777777777
ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff0770000700007077707000777777777070000000700000007007777007000007
ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff0770777707707007007077777777777070000000700000007000770007000007
ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff0770700700007070707007777777777070077777700777007000000007007777
ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff0770770707707077707077777777777070077777700777007007007007000007
ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff0770000707707077707000777777777070077000700000007007007007000007
00000000000000000000000000000000000000000000000000000000000000000777777777777777777777777777777070077700700777007007777007007777
00000000000000000000000000000000000000000000000000000000000000000777777777777777777777777777777070000000700777007007777007000007
00000000000000000000000000000000000000000000000000000000000000000777777777777777777777777777777070000000700777007007777007000007
00000000000000000000000000000000000000000000000000000000000000000777777777777777777777777777777077777777777777777777777777777777
00000000000000000000000000000000000000000000000000000000000000000777777777777777777777777777777077777777777777777777777777777777
00000000000000000000000000000000000000000000000000000000000000000777777777777777777777777777777077777777777777777777777777777777
00000000000000000000000000000000000000000000000000000000000000000777777777777777777777777777777070000000700777007000007000000777
00000000000000000000000000000000000000000000000000000000000000000777777777777777777777777777777070000000700777007000007000700077
00000000000000000000000000000000000000000000000000000000000000000777777777777777777777777777777070077700700070007007777007770077
00000000000000000000000000000000000000000000000000000000000000000777777777777777777777777777777070077700770070077000007007000777
00000000000000000000000000000000000000000000000000000000000000000777777777777777777777777777777070077700770070077000007000007777
00000000000000000000000000000000000000000000000000000000000000000777777777777777777777777777777070077700770000077007777007707777
00000000000000000000000000000000000000000000000000000000000000000777777777777777777777777777777070000000777000777000007007700777
00000000000000000000000000000000000000000000000000000000000000000777777777777777777777777777777070000000777000777000007007770077
00000000000000000000000000000000000000000000000000000000000000000777777777777777777777777777777077777777777777777777777777777777
00000000000000000000000000000000000000000000000000000000000000000777777777777777777777777777777077777777777777777777777777777777
00000000000000000000000000000000000000000000000000000000000000000777777777777777777777777777777077777777777777777777777777777777
00000000000000000000000000000000000000000000000000000000000000000777777777777777777777777777777077777777777777777777777777777777
00000000000000000000000000000000000000000000000000000000000000000777777777777777777777777777777070000007777777777777777777777777
00000000000000000000000000000000000000000000000000000000000000000777777777777777777777777777777070000007777777777777777777777777
00000000000000000000000000000000000000000000000000000000000000000777777777777777777777777777777070077007777777777777777777777777
00000000000000000000000000000000000000000000000000000000000000000777777777777777777777777777777070077007777777777777777777777777
00000000000000000000000000000000000000000000000000000000000000000777777777777777777777777777777070000007777777777777777777777777
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000070000007777777777777777777777777
__map__
1d1e090909090909090909091d1d1d1d181818184041424344454647181818181818181818181818181818181818181818181818181818181818181818181818181831183118322b2b18331833181818000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1d1e090909090909090909091d1d1d1d18181818505152535455565718181818310a0a18321818183518351818371d1d310a0a1832181818351835181818183718180a180a182b182b182c182c181818000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1d1e090909090909090909091d1d1d1d181818186061626364656667181818180a180a182b1818182e182e181818181d0a180a182b1818182e182e1818181d1d18180a0a0a182b182b182c182c181818000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1d1e090909090909090909091d1d1d1d181818187071727374757677181818180a0a0a182b1818182e2e2e18181d1d1d0a0a0a182b1818182e2e2e18181d181d1818180a18182b182b182c182c181818000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1d1e090909090909090909091d1d1d1d181818188081828384858687181818180a1818182b181818182e1818181d18180a1818182b181818182e18181818181d1818180a18182b2b2b182c2c2c181818000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1d1e090909090909090909091d1d1d1d181818189091929394959697181818180a1818182b2b2b18182e1818181d1d1d0a1818182b2b2b18182e18181818181d18181818181818181818181818181818000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1d1e090909090909090909091d1d1d1d18181818a0a1a2a3a4a5a6a718181818181818181818181818181818181818181818181818181818181818181818181818341818352e2e18362f2f18371d1d18000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1d1e090909090909090909091d1d1d1d18181818b0b1b2b3b4b5b6b7181818181833181818181833183418361818361818331818181818331834183618183618182d18182e182e182f1818181d181818000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1d1e090909090909090909091d1d1d1d9d9d88898a8b8c8d9d9da8a9aaabac18182c18182c18182c1818182f2f182f18182c18182c18182c1818182f2f182f18182d18182e182e182f2f2f181d1d1818000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1d1e090909090909090909091d1d1d1d9d9d98999a9b9c9d9d9db8b9babbbcbd18182c182c182c181834182f182f2f1818182c182c182c181834182f182f2f18182d18182e182e1818182f181d181818000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1d1e090909090909090909091d1d1d1d1818181818181818181818181818181818182c182c182c18182d182f18182f1818182c182c182c18182d182f18182f18182d2d182e2e2e182f2f2f181d1d1d18000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1d1e090909090909090909091d1d1d1d180418181818021818181818181818181804182c182c1818182d182f18182f181804182c182c1818182d182f18182f1818041818181818181818181818181818000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1d1e090909090909090909091d1d1d1d04040318010102051818181818181804040418181818181818181818181818040404181818181818181818181818180404041818181818181818181818181804000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1d1e090909090909090909091d1d1d1d04030303010102050518180707070404040101180505181818181807070704040401011805051818181818070707040404010118050518181818180707070404000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1d1e090909090909090909091d1d1d1d07020202020602030501010705050406070101050506180318010107050504060701010505061803180101070505040607010105050618031801010705050406000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1d1e090909090909090909091d1d1d1d07070706060603030301010505060606070707060606030303010105050606060707070606060303030101050506060607070706060603030301010505060606000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
290909090909092a290909090909092a30303030303030380808080808080808080000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
290909090909092a290909090909092a00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
290909090909092a290909090909092a00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
290909090909092a290909090909092a00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
290909090909092a290909090909092a00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
290909090909092a290909090909092a00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
290909090909092a290909090909092a00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
290909090909092a290909090909092a00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
290909090909092a290909090909092a00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
290909090909092a290909090909092a00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
290909090909092a290909090909092a00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
290909090909092a290909090909092a00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
290909090909092a290909090909092a00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
290909090909092a290909090909092a00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
290909090909092a290909090909092a00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
290909090909092a290909090909092a00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__sfx__
00010100150511605318052190511a051125531b0531c0531c0531c0531c0531c0531c0531c0501b0502355019050180501605015050130501305012050110501105009550110501105011050120501405017050
0010000018550185501855018550185501a5501a5501c5501c5501a5501a5501a5501a55018550185501a5501c5501d5501f5501c5501c5501a550185501a5501a5501c5501d550185501a5501c5501d5501f550
001000001850028300283002800028000233002800024300000002630000000283002630024300000002330000000213002130000000000002130000000243000000028300283000000000000263000000024300
000f00000f5000f5000f500155000f5000e50016500105001650018500185000f5001c5000f5001f5000f5000e5000e5000f500165001c500165001c5000c5002450024500245001850018500165001c50010500
001000002835028350280002800023350280002435000000263500000028350263502435000000233500000021350213500000000000213500000024350000002835028350000000000026350000002435000000
001000002335023350000000000023350000002435000000263502635000000000002835028350000000000024350243500000000000213502135000000000002135021350000000000023350000002435000000
0010000000000000002635026350000000000029350000002d3502d35000000000002b3500000029350000002d3502d3500000000000283500000028350000002835028350293502835026350000002435000000
001000002335023350000000000023350000002435000000263502635000000000002835028350000000000024350243500000000000213502135000000000002135021350213502135000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000001c7501c7501c7501c7001c7501c7501e7501e750207502075020750207501c7501c7501c7501c700187501875018750000001c7501c7501c750000001875018750187500000015750157501575000000
00100000177501775017750000001c7501c7501c750000001475014750147500000017750177501775000000187501875018750000001c7501c7501c750000001575015750157501575015750157501575000000
001000001d7501d7501d750000001d7501d7501d750000001a7501a7501a750000001a7501a7501a750000001c7501c7501c750000001c7501c7501c750000001875018750187500000015750157501575000000
001000001c7501c7501c750000001c7501c7501c750000001a7501a7501a750000001775017750177500000018750187501875000000157501575015750157001575015750157501570015750157501575000000
001000001c3501c3501c3501c3501c3501c3501c3501830018350183501835018350183501835018350173001a3501a3501a3501a3501a3501a3501a350153001735017350173501735017350173501735017300
001000001835018350183501835018350183501835000000153501535015350153501535015350153500000014350143501435014350143501435014350000001735017350173501735017350173501735000000
00120000183501835018350000001c3501c3501c3501c300213502135021350000002135021350213500000020350203502035020350203502035020350203502035020350203502035000000000000000000000
001000001865300000000000000018653000040000400004186530000300003000031865300003000030000318653000030000300003186530000300003000031865318603000030000318653000030000300003
001000001863000000246300000018630000002463000000186300000024630000001863000000246300000018630000002463000000186300000024630000001863000000246300000018630000002463000000
__music__
04 01424444
01 04424311
00 05424311
00 06424311
00 07424311
00 040a4311
00 050b4311
00 060c4311
00 070d4311
00 0e424312
00 0f424312
00 0e424312
02 10424312
00 40424344

