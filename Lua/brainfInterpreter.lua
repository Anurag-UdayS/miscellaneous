-- BrainF Compiler
-- Dev Tenga (Anurag Tewary)
-- 12th December, 2021

-- A compiler for the language BrainF - Written in lua.

-- ==================================================================================================== --
-- ======================== Config ======================= --

local toDebug = false
local toStepDebug = false

local pointer

local tabSize = 4

function _error(...)
	local point = string.format("\n%s: at line %d: at char %d:",
			pointer.filename,
			pointer.codePos.line,
			pointer.codePos.char)

	local args = {"\027[31m",point,...}
	args[#args + 1] = "\027[0m"
	print(table.unpack(args))
	os.exit(1)
end

function _debug(...)
	if toDebug then
		local args = {...}

		local point = string.format("\n%s: at line %d: at char %d:",
			pointer.filename,
			pointer.codePos.line,
			pointer.codePos.char)

		args = {"\027[33m",point,table.unpack(args)}
		args[#args + 1] = "\027[0m"
		print(table.unpack(args))
	end
end

function _stepDebug( ... )
	if toStepDebug then
		local args = {...}
		args = {"\027[35m",table.unpack(args)}
		args[#args + 1] = "\027[0m"
		print(table.unpack(args))
	end
end

local data = {}

pointer = {
	currentDataIndex = 0,
	loopIndex = 0;

	ignoreLoops = {},
	isComment = false;

	_code = "",
	filename = "";
	
	codePos = {
		char = 0, 
		absolute = 1,
		line = 1
	},
	loopsPos = {}
}

-- ======================= Handlers ====================== --

function pointer:MoveRight()
	if self.ignoreLoops[self.loopIndex] then return end

	local idx = self.currentDataIndex

	if idx == 30000-1 then
		_error("Index 30,000 out of bounds.")
	else
		self.currentDataIndex = idx + 1
	end
end

function pointer:MoveLeft()
	if self.ignoreLoops[self.loopIndex] then return end

	local idx = self.currentDataIndex

	if idx == 0 then
		_error("Index -1 out of bounds.")
	else
		self.currentDataIndex = idx - 1
	end
end

function pointer:Increment()
	if self.ignoreLoops[self.loopIndex] then return end

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
	if self.ignoreLoops[self.loopIndex] then return end

	local idx = self.currentDataIndex

	if data[idx] and data[idx] > 0 then
		data[idx] = data[idx] - 1
	else
		data[idx] = 255
	end

end

function pointer:Output()
	if self.ignoreLoops[self.loopIndex] then return end
	io.write(string.char(data[self.currentDataIndex]))
end

function pointer:Debug()
	if self.ignoreLoops[self.loopIndex] then return end
	_debug("Current Data Value:",data[self.currentDataIndex] ,"(At Index):", self.currentDataIndex,"(Str): '"..string.char(data[self.currentDataIndex]).."'","LoopIG:",self.ignoreLoops[loopIndex] or "false")
end

function pointer:TakeInput()
	if self.ignoreLoops[self.loopIndex] then return end
	data[self.currentDataIndex] = string.byte(io.read(1))
end

function pointer:StartLoop()
	self.loopIndex = self.loopIndex + 1
	self.loopsPos[self.loopIndex] = self.codePos.absolute

	if self.ignoreLoops[self.loopIndex] then return end

	if data[self.currentDataIndex] == 0 then
		self.ignoreLoops[self.loopIndex] = true
	end

	local str = string.match(self._code,"%b[]",self.codePos.absolute)
	

	if not string.match(str,"%b[]",2) then
		for i = 2,#str do
			if not string.match(string.sub(str,i,i),"[%+%-%]%.,><!\n]") then
				self.isComment = true
				--print(str)
				self.ignoreLoops[self.loopIndex] = true
				break
			end
		end
	end

end

function pointer:EndLoop()
	if data[self.currentDataIndex] ~= 0 and not self.ignoreLoops[self.loopIndex] then
		local code = self._code

		local absolutePos = self.codePos.absolute 
		local charAt = 0

		for i = absolutePos, self.loopsPos[self.loopIndex], -1 do
			if string.sub(code, i, i) == "\n" then
				self.codePos.line = self.codePos.line - 1
			end
		end

		absolutePos = self.loopsPos[self.loopIndex]
		local element = string.sub(code,absolutePos,absolutePos)

		if string.find(code,"\n") then
			while element ~= "\n" do
				--print(string.sub(code,absolutePos,absolutePos),charAt,absolutePos)
				charAt = charAt + (element == "\t" and tabSize or 1)
				absolutePos =  absolutePos - 1
				element = string.sub(code,absolutePos,absolutePos)
			end
		end

		self.codePos.char = charAt 
		self.codePos.absolute = self.loopsPos[self.loopIndex]

		return
	end
	
	if self.ignoreLoops[self.loopIndex] and (self.loopIndex == 0 or self.isComment) then
		self.ignoreLoops[self.loopIndex] = false
		self.isComment = false
	end

	if self.loopIndex > 0 then
		self.ignoreLoops[self.loopIndex] = false
		self.loopIndex = self.loopIndex - 1
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

	_stepDebug(string.format("Running Element: %s at index:(%d ; %d)",
		element,
		self.codePos.line,
		self.codePos.char)
	)

	if element == "\n" then
		self.codePos.line = self.codePos.line + 1
		self.codePos.char = 0
	else
		self.codePos.char = self.codePos.char + (element == "\t" and tabSize or 1)
	end

	if string.match(element, "[%[%]%+%-%.,><!]") then 
		config [element] ()
	end

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
	pointer.filename = arg[1]
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