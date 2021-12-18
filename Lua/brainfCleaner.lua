-- BrainF Cleaner
-- Dev Tenga (Anurag Tewary)
-- 18th December, 2021

-- A cleaner for the language BrainF - Written in lua.

-- ==================================================================================================== --
-- ======================== Config ======================= --

local collector = {
	code = "",
	_code = "";
	currentCodeIndex = 0;
	isComment = false;
}

-- ======================= Handlers ====================== --

function collector:appendStr(str)
	if self.isComment then return end
	self.code = self.code .. str
end

function collector:startLoop()
	local str = string.match(self._code,"%b[]",self.currentCodeIndex)
	
	if not string.match(str,"%b[]",2) then
		for i = 2,#str do
			if not string.match(string.sub(str,i,i),"[%+%-%]%.,><!\n]") then
				self.isComment = true
				break
			end
		end
	end

	if not self.isComment then self:appendStr("[") end

end

function collector:endLoop()	
	if not self.isComment then self:appendStr("]") end
	self.isComment = false
end

-- ========================= data ======================== --

local config = {
	[">"] = function() collector:appendStr(">") end,
	["<"] = function() collector:appendStr("<") end,
	["+"] = function() collector:appendStr("+") end,
	["-"] = function() collector:appendStr("-") end,
	["."] = function() collector:appendStr(".") end,
	[","] = function() collector:appendStr(",") end,
	["["] = function() collector:startLoop() end,
	["]"] = function() collector:endLoop() end
}

function collector:HandleNextElement()
	local element = string.sub(self._code,self.currentCodeIndex,self.currentCodeIndex)

	if string.match(element, "[%[%]%+%-%.,><]") then 
		--print(element)
		config [element] ()
	end

	collector.currentCodeIndex = collector.currentCodeIndex + 1
end

function main(...)
	local file,message = io.open(arg[1],"r")
	
	if not file then
		_error("Cannot open file. "..message or "")
	end

	local code = file:read("*all")
	collector._code = code

	local length = #code
	while collector.currentCodeIndex <= length do
		collector:HandleNextElement()
	end
	print(collector.code)
	return collector.code
end

-- ====================== Invocation ===================== --
return main(args)