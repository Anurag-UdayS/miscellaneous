-- BrainF Compiler
-- Dev Tenga (Anurag Tewary)
-- 12th December, 2021

-- A compiler for the language BrainF - Written in lua.

-- ==================================================================================================== --
-- ======================== Config ======================= --

local toDebug = false
local toStepDebug = false


function _error(...)
	local args = {"\027[31m",...}
	args[#args + 1] = "\027[0m"
	print(table.unpack(args))
	os.exit(1)
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
	currentDataIndex = 0,
	loopIndex = 0;

	ignoreLoop = false,
	isComment = false;

	_code = "";
	
	codePos = {
		char = 0, 
		absolute = 1,
		line = 1
	},
	loopsPos = {}
}

-- ======================= Handlers ====================== --

function pointer:MoveRight()
	if self.ignoreLoop then return end

	local idx = self.currentDataIndex

	if idx == 30000-1 then
		_error("Index 30,000 out of bounds.")
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
	
	if data[idx] and data[idx] < 255 then
		data[idx] = data[idx] + 1
	elseif data[idx] == 255 then
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
		data[idx] = 255
	end

end

function pointer:Output()
	if self.ignoreLoop then return end
	io.write(string.char(data[self.currentDataIndex]))
end

function pointer:Debug()
	if self.ignoreLoop then return end
	_debug("Current Data Value:",data[self.currentDataIndex] ,"(At Index):", self.currentDataIndex,"(Str): '"..string.char(data[self.currentDataIndex]).."'")
end

function pointer:TakeInput()
	if self.ignoreLoop then return end
	data[self.currentDataIndex] = string.byte(io.read(1))
end

function pointer:StartLoop()
	self.loopIndex = self.loopIndex + 1
	self.loopsPos[self.loopIndex] = self.codePos.absolute

	if self.ignoreLoop then return end

	if data[self.currentDataIndex] == 0 then
		self.ignoreLoop = true
	end

	local str = string.match(self._code,"%b[]",self.codePos.absolute)
	

	if not string.match(str,"%b[]",2) then
		for i = 2,#str do
			if not string.match(string.sub(str,i,i),"[%+%-%]%.,><!]") then
				self.isComment = true
				self.ignoreLoop = true
				break
			end
		end
	end

end

function pointer:EndLoop()
	if data[self.currentDataIndex] ~= 0 and not self.ignoreLoop then
		self.codePos.absolute = self.loopsPos[self.loopIndex]
		return
	end
	
	if self.loopIndex > 0 then
		self.loopIndex = self.loopIndex - 1
	end

	if self.ignoreLoop and (self.loopIndex == 0 or self.isComment) then
		self.ignoreLoop = false
		self.isComment = false
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
	local absoluteIdx = self.codePos.absolute
	local element = string.sub(self._code,absoluteIdx,absoluteIdx)

	_stepDebug("Running Element:",element,"at index:",absoluteIdx)
	if not string.match(element, "[%[%]%+%-%.,><!]") then 
		self.codePos.absolute = absoluteIdx + 1
		return 
	end

	config [element] ()
	self.codePos.absolute = self.codePos.absolute + 1 --Variable not used as self.codePos.absolute changes in the previous function call.
end

function main(...)
	for i = 0,30000-1 do data[i] = 0 end

	local file,message = io.open(arg[1],"r")
	
	if not file then
		_error("Cannot open file. "..message or "")
	end

	local code = file:read("*all")

	pointer._code = code
	local length = #code

	if string.find(code,"@debug") then
		toDebug = true
	end

	if string.find(code,"@step") then
		toStepDebug = true
	end

	while pointer.codePos.absolute <= length do
		pointer:HandleNextElement()
	end
end

-- ====================== Invocation ===================== --
main(args)