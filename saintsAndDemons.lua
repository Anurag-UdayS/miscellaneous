--[[
	Have three locations [classes]:
		Left Side
		Right Side
		Boat

	Initially, Left Side will have Three Demon Objects and 
	Three Saint Objects.

	Objective:
		Transfer all three saints to the right side.

	Boat: 
		Can carry minimum: 1, maximum: 2 members. 

--]]



--============================== Utilities ==============================--
local esc_reset 	= "\027[0m"
local esc_red 		= "\027[31m"
local esc_green 	= "\027[32m"
local esc_orange 	= "\027[33m"
local esc_navy 		= "\027[34m"
local esc_magenta 	= "\027[35m"
local esc_cyan		= "\027[96m"

local function table_find(t,value)
	for k,v in next,t do
		if v == value then return k end
	end
	return nil
end

local function table_insert(t,v)
	for i = 1,6 do
		if t[i] == nil then 
			t[i] = v
			return 
		end
	end
end

local function getn(t)
	local n = 0
	for _,v in next,t do
		if v then 
			n = n+1
		end
	end
	return n
end

--=============================== Classes ===============================--
local Right = {
	"D",
	"D",
	"D",
	"S",
	"S",
	"S"
}

local Left = {}
local Boat = {}
local Environment = {}

--============================= Environment =============================--

Environment._emojis= {
	D = "😈",
	S = "😇",
	L = "🟩",
	W = "🌊",
	B = "🛥️"
}

Environment._initialState = 
[[

DDDSSS
LLLLLL BB    LLLLLL
LLLLLLWWWWWWWLLLLLL
LLLLLLWWWWWWWLLLLLL
]]

Environment._state = Environment._initialState
Environment._moves = 0
Environment.Boat = Boat
Environment.Left = Left
Environment.Right = Right

Environment.endGame = os.exit

function Environment:Emojify(state)
	state = state or self._state
	for letter,emoji in pairs(self._emojis) do
		state = string.gsub(state,letter,emoji)
	end
	return state
end

function Environment:EscapeColor(state)
	state = state or self._state
	state = string.gsub(state,"D",esc_magenta.."D")
	state = string.gsub(state,"S",esc_cyan.."S")
	state = string.gsub(state,"LLLLLL",esc_green.."LLLLLL")
	state = string.gsub(state,"BB",esc_orange.."BB")
	state = string.gsub(state,"WWWWWWW",esc_navy.."WWWWWWW")
	state = state..esc_reset
	return state
end

function Environment:GetState(raw)
	return raw and self._state or self:EscapeColor(self._state)
end

function Environment:Reset()
	self._state = self._initialState
	self._moves = 0
	
	self.Boat._position = "Left"
	self.Boat._members = {}
	self.Boat._S = 0
	self.Boat._D = 0

	for i,v in ipairs(self.Left._initialMembers) do
		self.Left._members[i] = v
	end

	self.Left._S = 3
	self.Left._D = 3

	self.Right._members = {}
	self.Right._D = 0
	self.Right._S = 0

	return true
end


function Environment:Refresh()
	local formatStr = 
[[

%s%s%s%s%s%s %s%s %s%s %s%s%s%s%s%s
LLLLLL %s%s %s%s LLLLLL
LLLLLLWWWWWWWLLLLLL
LLLLLLWWWWWWWLLLLLL
]]

	local b = Boat._members
	local l = Left._members
	local r = Right._members

	local function g(t,i)
		return t[i] or " "
	end

	local function g_b(p)
		return Boat._position == p and "B" or " "
	end

	local function g_m(p,i)
		return Boat._position == p and g(b,i) or " "
	end


	self._state = string.format(
		formatStr,
		g(l,1), g(l,2), g(l,3), g(l,4), g(l,5), g(l,6),
		g_m("Left",1), g_m("Left",2), g_m("Right",1), g_m("Right",2),
		g(r,6), g(r,5), g(r,4), g(r,3), g(r,2), g(r,1),
		g_b("Left"), g_b("Left"), g_b("Right"), g_b("Right")
		)
end

function Environment:LoadTest()
	boat = self.Boat
	m = function(...) boat:Mount(...) end
	u = function(...) boat:Unmount(...) end
	a = function(...) boat:UnmountAll(...) end
	r = function(...) boat:Row(...) end
	v = function(...) print(self:GetState(...)) end
	print (esc_cyan..[[

m = Boat:Mount(...)
u = Boat:Unmount(...)
a = Boat:UnmountAll(...)
r = Boat:Row(...)
v = Environment:GetState(...) -> print

	]] .. esc_reset)
end

--================================ Left =================================--


Left._initialMembers = {"S","S","S","D","D","D"}
Left._members = {"S","S","S","D","D","D"}
Left._S = 3
Left._D = 3

--================================ Right ================================--

Right._members = {}
Right._S = 0
Right._D = 0

--================================ Boat =================================--

Boat._position = "Left"
Boat._linked = {Left = Left, Right = Right, env = Environment}
Boat._members = {}
Boat._D = 0
Boat._S = 0

function Boat:Mount(Name)
	assert(Name,esc_red.."Please specify name."..esc_reset)
	
	Name = (string.lower(Name) == "saint" and "S") 
	or (string.lower(Name) == "demon" and "D")
	or Name

	assert(getn(self._members) < 2, esc_red.."Cannot mount more than two members."..esc_reset)
	
	local linkedTable = self._linked[self._position]
	local member = table_find(linkedTable._members,Name)
	
	assert(member,esc_red.."Selected member not found."..esc_reset)
	
	table_insert(self._members,Name)
	self["_"..Name] = self["_"..Name] + 1
	linkedTable._members[member] = nil
	linkedTable["_"..Name] = linkedTable["_"..Name] - 1

	Environment:Refresh()
end

function Boat:Unmount(Name)
	assert(Name,esc_red.."Please specify name."..esc_reset)
	
	Name = (string.lower(Name) == "saint" and "S") 
	or (string.lower(Name) == "demon" and "D")
	or Name

	local linkedTable = self._linked[self._position]
	local member = table_find(self._members,Name)
	
	assert(member,esc_red.."Selected member not found."..esc_reset)
	
	table_insert(linkedTable._members,Name)
	self["_"..Name] = self["_"..Name] - 1
	self._members[member] = nil
	linkedTable["_"..Name] = linkedTable["_"..Name] + 1

	Environment:Refresh()
end

function Boat:UnmountAll()

	local linkedTable = self._linked[self._position]

	for i,Name in ipairs(self._members) do
		table_insert(linkedTable._members,Name)
		self._members[i] = nil
		linkedTable["_"..Name] = linkedTable["_"..Name] + 1
	end

	self._D = 0
	self._S = 0

	Environment:Refresh()
end

function Boat:Row()
	assert(getn(self._members) > 0, esc_red.."There must be at least 1 member on board."..esc_reset)	
	self._position = self._position == "Left" and "Right" or "Left"


	for _,link in ipairs({"Left","Right"}) do
		local sideMembers = {
			S = self._position == link and self._S or 0,
			D = self._position == link and self._D or 0,	
		}

		if self._linked[link]._S + sideMembers.S > 0 
			and self._linked[link]._D + sideMembers.D > self._linked[link]._S + sideMembers.S then
			
			local function errorAndPrompt(str)
				print(esc_red..str.."\n"
					..esc_orange.."Retry?: "..esc_reset
					.."["..esc_green.."Y"
					..esc_reset
					.."/"..esc_red.."N"
					..esc_reset.."]"
				)

				local res = io.read("*line")
				io.flush()
				res = string.upper(res)
				return ( (res == "Y" or res == "YES") and Environment:Reset()) or ( (res == "N" or res == "NO") and os.exit()) or errorAndPrompt("Input not recognized.")
			end

			errorAndPrompt("Game Over! The Demons in ("..link.."-Side) ate the saints!")
			break
		end
	end

	if (self._position == "Right" and self._D == 0 and self._linked.Right._S + self._S == 3)
	 or (self._position == "Left" and self._linked.Right._S == 3)
	 then
		print(esc_green.."You win! Congrats! \nFinished in ("..Environment._moves..") moves.")
		os.exit()
	end

	Environment._moves = Environment._moves + 1
	Environment:Refresh()
end

return Environment
