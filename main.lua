
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
			for e in all(t_list) do 
				del(t_list, e);
			end
	end
end
