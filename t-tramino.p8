pico-8 cartridge // http://www.pico-8.com
version 16
__lua__

t_list = {}

line = 0

level = 1
spd = 1
c = 0

function _init()
		palt(0, false)
		add(t_list, tetra:new())
		etat = 0
end

function _draw()
	cls()
	if (btn(4)) then
	  etat = 1
	end
	if (etat == 1) then
	  map(0, 0, 0, 0, 16, 16)
	  for e in all(t_list) do
		  e:draw();
	  end
	  print ("line")
	  print (line)
	  print ("level")
	  print (level)
	end
	if (etat == 0) then
	   map(16, 0, 0, 0, 16, 16)
	end
end

function _update()
 if (etat == 1) then
	 for e in all(t_list) do
		 if (e.mv == 1) then
		 	e:update();
		 end
	 end
	 check_line()
	 destroy();
	 if (line % 5 == 0 and c == 1) then
	 	level += 1
	 	spd += 0.25
	 	c = 0
	 end
	end
end

-->8

tetra = {x1, y1, x2, y2, x3, y3, x4, y4, sqr, spd, shape, move, state, d}
tetra.__index = tetra

function tetra:new()
	obj = {}
	setmetatable(obj, tetra)
	
	obj.spd = spd;
	obj.shape = flr(rnd(7)) + 1;
	obj.state = 0;
	
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
	obj.d = 0
	return obj
end

function tetra:draw()
	spr(self.shape, self.x1, self.y1);
	spr(self.shape, self.x2, self.y2);
 spr(self.shape, self.x3, self.y3);
 spr(self.shape, self.x4, self.y4);
end

function tetra:update()
	if(self:colision()) then
		self.y1 += self.spd;
		self.y2 += self.spd;
		self.y3 += self.spd;
		self.y4 += self.spd;
		if btnp(1) and self.mv == 1 and self:r_col() then
			self.x1 += 8
			self.x2 += 8
			self.x3 += 8
			self.x4 += 8
		end
		
		if btnp(0) and self.mv == 1 and self:l_col() then
			self.x1 -= 8
			self.x2 -= 8
			self.x3 -= 8
			self.x4 -= 8
		end
		
		if btnp(2) and self.mv == 1 then
			self:rotate()
		end
		
		if btn(3) and self.mv == 1 then
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
			add(t_list, tetra:new());
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
		if (l >= 16) then
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
__gfx__
000000007aaaaaa07cccccc072222220788888807bbbbbb0799999907eeeeee000000000ddddddd0888888887777777777777777770000770677777706777777
00000000a77aaaa0c77cccc02772222087788880b77bbbb097799990e77eeee000000000ddddddd0888888887777777770000007770000770677777706777777
00700700a7aaaaa0c7ccccc02722222087888880b7bbbbb097999990e7eeeee000000000ddddddd0888888887777777770000007770077770677777706777777
00077000aaaaaaa0ccccccc02222222088888880bbbbbbb099999990eeeeeee000000000ddddddd0888888887777777777700777770000770677777706777777
00077000aaaaaaa0ccccccc02222222088888880bbbbbbb099999990eeeeeee000000000ddddddd0888888887777777777700777770000770677777706777777
00700700aaaaaaa0ccccccc02222222088888880bbbbbbb099999990eeeeeee000000000ddddddd0888888887777777777700777770077770677777706777777
00000000aaaaaaa0ccccccc02222222088888880bbbbbbb099999990eeeeeee000000000ddddddd0888888887777777777700777770000770677777706666666
00000000000000000000000000000000000000000000000000000000000000000000000000000000888888887777777777700777770000770677777700000000
0000000077777777777777600000000000000000777777607777777777777777ffffffff00000000000000000000000000000000000000000000000000000000
0666666677777777777777606666666666666660777777607777777777777777ffffffff00000000000000000000000000000000000000000000000000000000
0677777777777777777777607777777777777760777777607777777777777777ffffffff00000000000000000000000000000000000000000000000000000000
0677777777777777777777607777777777777760777777607777777777777777ffffffff00000000000000000000000000000000000000000000000000000000
0677777777777777777777607777777777777760777777607777777777777777ffffffff00000000000000000000000000000000000000000000000000000000
0677777777777777777777607777777777777760777777607777777777777777ffffffff00000000000000000000000000000000000000000000000000000000
0677777766666666777777607777777777777760666666606677777777777766ffffffff00000000000000000000000000000000000000000000000000000000
0677777700000000777777607777777777777760000000000677777777777760ffffffff00000000000000000000000000000000000000000000000000000000
__map__
0909090909090909090909090909090918181818181818181818181818181818000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0909090909090909090909090909090918181818181818181818181818181818000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0909090909090909090909090909090918181818101313131313131418181818000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
09090909090909090909090909090909181818180e0b0b0b0b0b0b1218181818000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
09090909090909090909090909090909181818180e0b0b0b0b0b0b1218181818000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
09090909090909090909090909090909181818180f11160b0b17111518181818000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
090909090909090909090909090909091818181818180e0b0b12181818181818000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
090909090909090909090909090909091818181818180e0b0b12181818181818000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
090909090909090909090909090909091818181818180f111115181818181818000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0909090909090909090909090909090918181818181818181818181818181818000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0909090909090909090909090909090918181818181818181818181818181818000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0909090909090909090909090909090918041818181802181818181818181818000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0909090909090909090909090909090904040318010102051818181818181804000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0909090909090909090909090909090904030303010102050518180707070404000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0909090909090909090909090909090907020202020602030501010705050406000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0909090909090909090909090909090907070706060603030301010505060606000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000080000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__sfx__
00010100130510a55324552155511355112553115531c5531d5531e5530d5730d5730d523325002255023550245500d55025550255502655026550275502755029550095500f5500f55011550125501355000000
0010000018550185501855018550185501a5501a5501c5501c5501a5501a5501a5501a55018550185501a5501c5501d5501f5501c5501c5501a550185501a5501a5501c5501d550185501a5501c5501d5501f550
0010000018550185501a550245500f5501f5501e5501b550225501e5501e550225501b550205501955020550205501e5502055019550205501e5502055019550205501e5502055019550205501e5501b5501b550
000f00000f5500f5500f550155500f5500e55016550105501655018550185500f5501c5500f5501f5500f5500e5500e5500f550165501c550165501c5500c5502455024550245501855018550165501c55010550
__music__
04 01424344

