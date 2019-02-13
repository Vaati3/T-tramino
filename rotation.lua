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