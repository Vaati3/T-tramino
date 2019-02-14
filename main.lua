
t_list = {}

line = 0

level = 1
spd = 1
c = 0

function _init()
		palt(0, false)
		etat = 0
		key = 0
end

function init_game()
	etat = 1
	local n = flr(rnd(7)) + 1;
	if (key == 0) then
		add(t_list, tetra:new(64, 16, 88, n))
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
	 print (line, 110, 20, 7)
	 print ("level", 105, 30, 7)
	 print (level, 110, 40, 7)
end

function two_player()
	map(0, 16, 0, 0, 16, 16)
	for e in all(t_list) do
		 e:draw(false);
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
	 if (line % 5 == 0 and c == 1) then
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
	if (key == 0) then
		one_update()
	end
 if (key == 1) then
	 two_update();
	end
end
