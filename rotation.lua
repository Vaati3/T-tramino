function tetra:r_line()
	local ok = 0

	if (self.state == 0) then
		self.x1 = self.x2 - 8
		self.y1 = self.y2
		self.x3 = self.x2 + 8
		self.y3 = self.y2
		self.x4 = self.x2 + 16
		self.y4 = self.y2
		self.state = 1;
		ok = 1
		if ((self:r_col() == false) 
			or (self:l_col() == false)) then 
			ok = 0;
		end
	end
	if (self.state == 1 and ok == 0) then
			self.x1 = self.x2
			self.y1 = self.y2 + 8
			self.x3 = self.x2
			self.y3 = self.y2 - 8
			self.x4 = self.x2
			self.y4 = self.y2 - 16
			self.state = 0;
	end
	if (self:colision() == false) then
		self.x1 = self.x2 - 8
		self.y1 = self.y2
		self.x3 = self.x2 + 8
		self.y3 = self.y2
		self.x4 = self.x2 + 16
		self.y4 = self.y2
		self.state = 1;
	end
end