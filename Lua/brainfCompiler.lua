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
	end
	self.currentIndex = idx + 1
end

function pointer:MoveLeft()
	local idx = self.currentIndex

	if idx == 0 then
		error("Index -1 out of bounds.")
	end
	self.currentIndex = idx - 1
end

function pointer:Increment()
	local idx = self.currentIndex
	main[idx] = main[idx] + 1
end

function pointer:Decrement()
	local idx = self.currentIndex
	main[idx] = main[idx] - 1
end

function function_name( ... )
	-- body
end

local config = {
	[">"] = function() pointer:MoveRight() end,
	["<"] = function() pointer:MoveLeft() end,
	["+"] = function() pointer:Increment() end,
	["-"] = function() pointer:Decrement() end,
}