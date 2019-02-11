
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
