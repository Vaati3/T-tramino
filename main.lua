
t_list = {}

line = 0

level = 1
spd = 1
c = 0

function _init()
		palt(0, false)
		add(t_list, tetra:new(16, 88))
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
	  print ("line", 105, 10, 7)
	  print (line, 110, 20, 7)
	  print ("level", 105, 30, 7)
	  print (level, 110, 40, 7)
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
