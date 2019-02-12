pico-8 cartridge // http://www.pico-8.com
version 16
__lua__

t_list = {}

function _init()
		add(t_list, tetra:new())
end

function _draw()
	cls()
	for e in all(t_list) do
		e:draw();
	end
end

function _update()
	for e in all(t_list) do
		e:update();
	end
end

-->8

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
-->8
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
__gfx__
00000000666666666666666666666666666666666666666666666666666666660000000000000000000000000000000000000000000000000000000000000000
000000006aaaaaa66cccccc662222226688888866bbbbbb6699999966eeeeee60000000000000000000000000000000000000000000000000000000000000000
007007006aaaaaa66cccccc662222226688888866bbbbbb6699999966eeeeee60000000000000000000000000000000000000000000000000000000000000000
000770006aaaaaa66cccccc662222226688888866bbbbbb6699999966eeeeee60000000000000000000000000000000000000000000000000000000000000000
000770006aaaaaa66cccccc662222226688888866bbbbbb6699999966eeeeee60000000000000000000000000000000000000000000000000000000000000000
007007006aaaaaa66cccccc662222226688888866bbbbbb6699999966eeeeee60000000000000000000000000000000000000000000000000000000000000000
000000006aaaaaa66cccccc662222226688888866bbbbbb6699999966eeeeee60000000000000000000000000000000000000000000000000000000000000000
00000000666666666666666666666666666666666666666666666666666666660000000000000000000000000000000000000000000000000000000000000000
__map__
0101010101010101010101000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0101010101010101010101000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0101010101010101010101000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0101010101010101010101000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0101010101010101010101000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__sfx__
00010100130510a55324552155511355112553115531c5531d5531e5530d5730d5730d523325002255023550245500d55025550255502655026550275502755029550095500f5500f55011550125501355000000
0010000018550185501855018550185501a5501a5501c5501c5501a5501a5501a5501a55018550185501a5501c5501d5501f5501c5501c5501a550185501a5501a5501c5501d550185501a5501c5501d5501f550
0010000018550185501a550245500f5501f5501e5501b550225501e5501e550225501b550205501955020550205501e5502055019550205501e5502055019550205501e5502055019550205501e5501b5501b550
000f00000f5500f5500f550155500f5500e55016550105501655018550185500f5501c5500f5501f5500f5500e5500e5500f550165501c550165501c5500c5502455024550245501855018550165501c55010550
__music__
04 01424344

