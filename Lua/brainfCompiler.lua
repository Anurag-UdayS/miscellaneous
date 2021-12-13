-- BrainF Compiler
-- Dev Tenga (Anurag Tewary)
-- 12th December, 2021

-- A compiler for the language BrainF - Written in lua.

-- ==================================================================================================== --

local _error = error

function error(...)
	_error("\027[31m",unpack(arg))
	print("\027[0m")
end


local main = {}

local pointer = {
	currentIndex = 0,
}

function pointer:MoveRight()
	local idx = self.currentIndex

	if idx == 30000 then
		error("Index 30,001 out of bounds.")
	else
		self.currentIndex = idx + 1
	end
end

function pointer:MoveLeft()
	local idx = self.currentIndex

	if idx == 0 then
		error("Index -1 out of bounds.")
	else
		self.currentIndex = idx - 1
	end
end

function pointer:Increment()
	local idx = self.currentIndex
	
	if main[idx] then
		main[idx] = main[idx] + 1
	else
		main[idx] = 1
	end
end

function pointer:Decrement()
	local idx = self.currentIndex

	if main[idx] then
		main[idx] = main[idx] - 1
	else
		main[idx] = -1
	end

end

function pointer:Output()
	io.write(string.char(main[self.currentIndex]))
end

function pointer:TakeInput()
	main[self.currentIndex] = string.byte(io.read(1))
end

local config = {
	[">"] = function() pointer:MoveRight() end,
	["<"] = function() pointer:MoveLeft() end,
	["+"] = function() pointer:Increment() end,
	["-"] = function() pointer:Decrement() end,
	["."] = function() pointer:Output() end,
	[","] = function() pointer:TakeInput() end,
}

function main( ... )
	local data,message = io.open(arg[1],"r")
	
	if not data then
		_error("Cannot open file. "..message)
	end

	for i = 1,#data do
		local element = string.sub(data,i,i)
		
	end


end