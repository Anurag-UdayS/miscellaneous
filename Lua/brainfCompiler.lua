-- BrainF Compiler
-- Dev Tenga (Anurag Tewary)
-- 12th December, 2021

-- A compiler for the language BrainF - Written in lua.

-- ==================================================================================================== --
-- ======================== Config ======================= --

local _error = error
local toDebug = false
local toStepDebug = false

function error(...)
	local args = {...}
	args[#args + 1] = "\027[0m"
	_error("\027[33m",table.unpack(args))
end

function _debug(...)
	local args = {...}
	if toDebug then
		args = {"\027[33m",table.unpack(args)}
		args[#args + 1] = "\027[0m"
		print(table.unpack(args))
	end
end

function _stepDebug( ... )
	local args = {...}
	if toStepDebug then
		args = {"\027[35m",table.unpack(args)}
		args[#args + 1] = "\027[0m"
		print(table.unpack(args))
	end
end

local data = {}

local pointer = {
	currentDataIndex = 1,
	currentCodeElement = 1,
	loopIndex = 0,
	loopsPos = {},
	_code = ""
}

-- ======================= Handlers ====================== --

function pointer:MoveRight()
	if self.ignoreLoop then return end

	local idx = self.currentDataIndex

	if idx == 30000 then
		_error("Index 30,001 out of bounds.")
	else
		self.currentDataIndex = idx + 1
	end
end

function pointer:MoveLeft()
	if self.ignoreLoop then return end

	local idx = self.currentDataIndex

	if idx == 0 then
		_error("Index -1 out of bounds.")
	else
		self.currentDataIndex = idx - 1
	end
end

function pointer:Increment()
	if self.ignoreLoop then return end

	local idx = self.currentDataIndex
	
	if data[idx] and data[idx] < 127 then
		data[idx] = data[idx] + 1
	elseif data[idx] == 127 then
		data[idx] = 0
	else
		data[idx] = 1
	end
end

function pointer:Decrement()
	if self.ignoreLoop then return end

	local idx = self.currentDataIndex

	if data[idx] and data[idx] > 0 then
		data[idx] = data[idx] - 1
	else
		data[idx] = 127
	end

end

function pointer:Output()
	if self.ignoreLoop then return end
	io.write(string.char(data[self.currentDataIndex]))
end

function pointer:Debug()
	if self.ignoreLoop then return end
	_debug("Current Data Value:",data[self.currentDataIndex] ,"(At Index:)", self.currentDataIndex)
end

function pointer:TakeInput()
	if self.ignoreLoop then return end
	data[self.currentDataIndex] = string.byte(io.read(1))
end

function pointer:StartLoop()
	self.loopIndex = self.loopIndex + 1
	self.loopsPos[self.loopIndex] = self.currentCodeElement
	_debug("New Loop at:",self.loopIndex,"At position:",self.currentCodeElement)

	if self.ignoreLoop then return end

	if data[self.currentDataIndex] == 0 then
		self.ignoreLoop = true
	end

	local str = string.match(self._code,"%b[]",self.currentCodeElement)
	
	for i = 1,#str do
		if not string.match(string.sub(str,i,i),"[%[%]%+%-%.,><!]") then
			_debug("Loop Rendered as comment.")
			self.ignoreLoop = true
			break
		end
	end

end

function pointer:EndLoop()
	if data[self.currentDataIndex] ~= 0 and not self.ignoreLoop then
		self.currentCodeElement = self.loopsPos[self.loopIndex]
		return
	end
	
	if self.loopIndex > 0 then
		self.loopIndex = self.loopIndex - 1
		_debug("Value of loop index decremented. Value:", self.loopIndex)
	end

	if self.loopIndex == 0 and self.ignoreLoop then
		_debug("Loop ignoring stopped.")
		self.ignoreLoop = false
	end

end

-- ========================= data ======================== --

local config = {
	[">"] = function() pointer:MoveRight() end,
	["<"] = function() pointer:MoveLeft() end,
	["+"] = function() pointer:Increment() end,
	["-"] = function() pointer:Decrement() end,
	["."] = function() pointer:Output() end,
	[","] = function() pointer:TakeInput() end,
	["["] = function() pointer:StartLoop() end,
	["]"] = function() pointer:EndLoop() end,
	["!"] = function() pointer:Debug() end
}

function pointer:HandleNextElement()
	local currentCodeElementIdx = self.currentCodeElement
	local element = string.sub(self._code,currentCodeElementIdx,currentCodeElementIdx)

	_stepDebug("Running Element:",element,"at index:",currentCodeElementIdx)
	if not string.match(element, "[%[%]%+%-%.,><!]") then 
		self.currentCodeElement = currentCodeElementIdx + 1
		return 
	end

	config [element] ()
	self.currentCodeElement = self.currentCodeElement + 1 --Variable not used as self.currentCodeElement changes in the previous function call.
end

function main(...)
	for i = 1,30000 do data[i] = 0 end

	local file,message = io.open(arg[1],"r")
	
	if not file then
		_error("Cannot open file. "..message or "")
	end

	local code = file:read("*all")

	pointer._code = code
	local length = #code

	if string.find(code,"#debug") then
		toDebug = true
	end

	if string.find(code,"#debug") then
		toStepDebug = true
	end

	while pointer.currentCodeElement <= length do
		pointer:HandleNextElement()
	end
end

-- ====================== Invocation ===================== --
main(args)