function buffer.new(size)
	local nbuffer = {}
	setmetatable(nbuffer, buffer)

	--initial data
	local newqueue = {}
	nbuffer.first = 0
	nbuffer.last = size
	nbuffer.size = size
	nbuffer.negated = Vector2.new(0,0)
	
	for i=1,size,1 do newqueue[i] = 0 end
	nbuffer.queue = newqueue
	
	
	--buffer functions
	nbuffer.iterate = function(i)
		if (nbuffer.first+i) % size == 0 then
			return size
		else
			return (nbuffer.first+i) % size
		end
	end

	nbuffer.step = function(i)
		if i ~= nil then 
			if i == nbuffer.first then
				return size
			else
				return (nbuffer.size-(nbuffer.first-i)) % nbuffer.size + 1
			end
		end
	end

	nbuffer.get = function(i)
		if nbuffer.step(i)<nbuffer.negated.X or nbuffer.step(i)>nbuffer.negated.Y then
			return (nbuffer.first + i) % nbuffer.size + 1
		end
	end  
	
	nbuffer.add = function(item)
		nbuffer.queue[nbuffer.iterate(1)] = item
		nbuffer.first = nbuffer.iterate(1)
		nbuffer.last = nbuffer.iterate(1) + nbuffer.negated.Y - nbuffer.negated.X
	end
	
	return nbuffer
end
