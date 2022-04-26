#!/usr/bin/lua

-- Doubly Linked List
-- Anurag Tewary
-- 24th April, 2022
--
-- An implementation of the DoublyLinkedList data structure, written in Lua.
-- Demonstrates OOP programming structures.

-- Abstract structure of the DoublyLinkedList
local DoublyLinkedList = {Node = {__object = {}, __meta = {}}, __object = {}, __meta = {}};

-- Color raised errors red.
local _error = error;
local _assert = assert;

function error(msg)
	_error("\027[31m" .. msg .. "\027[0m")
end

function assert(cond, msg)
	_assert(cond, "\027[31m" .. msg .. "\027[0m")
end

DoublyLinkedList = {
	-- The Node class
	Node = {			
		-- Metadata for Instance Method container.
		__meta = {
			--__metatable = "Container of Instance Methods for DoublyLinkedList.Node",
			__newindex = function(self, k, v) 
				if (k ~= "prev" and k ~= "next" and k ~= "value") then 
					error("Instance Table. Cannot be modified. (unknown key: '" .. k .. "')"); 
				else
					rawset(self, k, v)
				end; 
			end,

			__tostring = function(self) return tostring(self.value); end,
			__index = DoublyLinkedList.Node.__object, 
			__type = "<class 'DoublyLinkedList/Node'>"

		},

		-- Instance methods will be stored here.
		__object = DoublyLinkedList.Node.__object -- Reference to the older table is saved.

	},


	-- Metadata for Instance Method container
	__meta = {
		__metatable = "Container of Instance Methods for DoublyLinkedList",
		__index = DoublyLinkedList.__object,
		__type = "<class 'DoublyLinkedList'>",
		__newindex = function(self, k, v) 
			if (k ~= "head" and k ~= "tail") then 
				error("Instance Table. Cannot be modified. (unknown key: '" .. k .. "')"); 
			else
				rawset(self, k, v)	
			end; 
		end,
		__tostring = function(self) 
			if (not self.head) then return "[]" end
			local str = "["
			local current = self.head

			while (current) do
				if (current.next) then
					str = str .. current:tostring() .. ", ";
					current = current.next;
				else
					return str .. current:tostring() .. "]";
				end
			end

		end
	},
	
	-- Instance methods will be stored here.
	__object = DoublyLinkedList.__object -- Reference to the older table is saved.
}

--====================================================================================================--
--								DoublyLinkedList.Node --> Instance Methods
--====================================================================================================--
-- Instance methods of DoublyLinkedList's Node class.
-- Methods are written outside in order to utilize eye candy.

function DoublyLinkedList.Node.__object.getClass()
	return DoublyLinkedList.Node;
end

function DoublyLinkedList.Node.__object:tostring() 
	return tostring(self); 
end

--====================================================================================================--
--								DoublyLinkedList.Node --> Class Methods
--====================================================================================================--
-- Class methods of DoublyLinkedList's Node.
-- Includes constructor, hardcoded class methods and utility functions.

function DoublyLinkedList.Node.new(val, next, prev)
	assert(DoublyLinkedList.Node.isNode(next) or next == nil, "<next> must be a Node.")
	assert(DoublyLinkedList.Node.isNode(prev) or prev == nil, "<prev> must be a Node.")
	return setmetatable({value = val, next = next, prev = prev}, DoublyLinkedList.Node.__meta)
end

-- Get simple name of the class.
function DoublyLinkedList.Node.getSimpleName()
	return "Node"
end

-- Get full name of the class.
function DoublyLinkedList.Node.getFullName()
	return "DoublyLinkedList/Node"
end

-- Check if passed arg is instance of Node.
-- Simple implementation of `instanceof`
function DoublyLinkedList.Node.isNode(node)
	return type(node) == "<class 'DoublyLinkedList/Node'>";
end


--====================================================================================================--
--								DoublyLinkedList --> Instance Methods
--====================================================================================================--
-- Instance Methods of DoublyLinkedList.
-- All implementations of the LinkedList API will be demonstrated here.


function DoublyLinkedList.__object.getClass()
	return DoublyLinkedList;
end

function DoublyLinkedList.__object:tostring() 
	return tostring(self); 
end

-- Reverse tostring for traversing from tail.
function DoublyLinkedList.__object:tostringTailToHead() 
	if (not self.tail) then return "[]" end
	local str = "["
	local current = self.tail

	while (current) do
		if (current.prev) then
			str = str .. current:tostring() .. ", ";
			current = current.prev;
		else
			return str .. current:tostring() .. "]";
		end
	end

end

-- Helper function for `DoublyLinkedList#addAt`
local function addAt(current, idx, node, lastNode, self)
	if (current == idx) then
		lastNode.prev.next = node
		node.prev = lastNode.prev
		lastNode.prev = node
		node.next = lastNode
	else
		addAt(current + 1, idx, node, lastNode.next, self)	
	end
end


function DoublyLinkedList.__object:addAt(idx, node)
	if (idx == 1) then 
		self:addFirst(node)
		return;
	end

	size = self:size()

	if (idx > size + 1 or idx < 1) then
		error("Index (" .. tostring(idx) .. ") is out of bounds.")
	end

	if (idx == size + 1) then
		self:addLast(node)
		return;
	end

	if (not DoublyLinkedList.Node.isNode(node)) then
		node = DoublyLinkedList.Node.new(node)
	end


	addAt(1, idx, node, self.head, self)
end

function DoublyLinkedList.__object:addAll(t)
	if (not next(t)) then return; end
	assert(type(t) == 'table' and t[1] ~= nil, "Table must be an array (indexed with 1).")
	
	for _, node in ipairs(t) do 
		if (not DoublyLinkedList.Node.isNode(node)) then
			node = DoublyLinkedList.Node.new(node)
		end
		self:addLast(node) 
	end

end

-- TODO: DoublyLinkedList#addAllFrom(idx, t)

function DoublyLinkedList.__object:addFirst(node)
	if (not DoublyLinkedList.Node.isNode(node)) then
		node = DoublyLinkedList.Node.new(node)
	end

	if (self.head) then
		self.head.prev = node
		node.next = self.head
		node.prev = nil
	end

	self.head = node
	if (not self.tail) then self.tail = node end
end

DoublyLinkedList.__object.offerFirst 	= DoublyLinkedList.__object.addFirst
DoublyLinkedList.__object.push 		= DoublyLinkedList.__object.addFirst

function DoublyLinkedList.__object:addLast(node)
	if (not DoublyLinkedList.Node.isNode(node)) then
		node = DoublyLinkedList.Node.new(node)
	end

	if (self.tail) then
		self.tail.next = node
		node.prev = self.tail
		node.next = nil
	end
	
	self.tail = node
	if (not self.head) then self.head = node end
end

DoublyLinkedList.__object.add 		= DoublyLinkedList.__object.addLast
DoublyLinkedList.__object.offer 	= DoublyLinkedList.__object.addLast
DoublyLinkedList.__object.offerLast = DoublyLinkedList.__object.addLast

-- I'm gonna let the GC do these two.
function DoublyLinkedList.__object:clear()
	self.head = nil
	self.tail = nil
end

function DoublyLinkedList.__object:clone()
	return DoublyLinkedList.new(self.head, self.tail) -- A shallow copy. References remain same.
end

function DoublyLinkedList.__object:contains(needle)
	local current = self.head
	while (current) do
		if (current == needle or current.value == needle) then return true end
		current = current.next
	end
	return false
end

-- TODO: Reverse
function DoublyLinkedList.__object:reverse()
	local current = self.tail
end

function DoublyLinkedList.__object:getFirst()
	return self.head.value
end

DoublyLinkedList.__object.element 		= DoublyLinkedList.__object.getFirst 
DoublyLinkedList.__object.peek 			= DoublyLinkedList.__object.getFirst 
DoublyLinkedList.__object.peekFirst 	= DoublyLinkedList.__object.getFirst 

function DoublyLinkedList.__object:getLast()
	return self.tail.value
end

DoublyLinkedList.__object.peekLast 		= DoublyLinkedList.__object.getFirst 


function DoublyLinkedList.__object:get(idx)
	if (idx < 1) then
		error("Index (" .. tostring(idx) .. ") is out of bounds.")
	end

	local current = self.head
	local i = 1
	while (current) do
		if (idx == i) then return current.value end
		idx = idx + 1
		current = current.next
	end
	error("Index (" .. tostring(idx) .. ") is out of bounds.")
end

function DoublyLinkedList.__object:indexOf(element)
	local current = self.head
	local idx = 1
	while (current) do
		if (current == element or current.value == element) then return idx end
		idx = idx + 1
		current = current.next
	end
	return -1
end

function DoublyLinkedList.__object:lastIndexOf(element)
	local current = self.tail
	local idx = 1
	while (current) do
		if (current == element or current.value == element) then return self:size() - idx end
		idx = idx + 1
		current = current.prev
	end
	return -1
end

function DoublyLinkedList.__object:pollFirst()
	local val = self.head.value
	self.head = self.head.next
	self.head.prev = nil
	return val
end

DoublyLinkedList.__object.poll 			= DoublyLinkedList.__object.pollFirst
DoublyLinkedList.__object.pop 			= DoublyLinkedList.__object.pollFirst
DoublyLinkedList.__object.remove		= DoublyLinkedList.__object.pollFirst
DoublyLinkedList.__object.removeFirst	= DoublyLinkedList.__object.pollFirst

function DoublyLinkedList.__object:pollLast()
	local val = self.tail.value
	self.tail = self.tail.prev
	self.tail.next = nil
	return val
end

DoublyLinkedList.__object.removeLast = DoublyLinkedList.__object.pollLast

-- TODO: RemoveAt, RemoveFirstOccurence, RemoveLastOccurence, set, toTable
--function 


function DoublyLinkedList.__object:size()
	local current = self.head
	local size = 0
	while (current) do
		size = size + 1
		current = current.next
	end
	return size;
end

--====================================================================================================--
--								DoublyLinkedList --> Class Methods
--====================================================================================================--
-- Class methods of DoublyLinkedList.
-- Includes constructors and hardcoded class methods.

function DoublyLinkedList.new(head, tail)
	if (head ~= nil and not DoublyLinkedList.Node.isNode(head)) then
		head = DoublyLinkedList.Node.new(head);
	end

	if (tail ~= nil and not DoublyLinkedList.Node.isNode(tail)) then
		tail = DoublyLinkedList.Node.new(tail);
		tail.prev = head
	elseif (tail == nil) then
		tail = head
	end

	if (head and head ~= tail) then head.next = tail end

	return setmetatable({head = head, tail = tail}, DoublyLinkedList.__meta);
end	
	
function DoublyLinkedList.fromTable(t)
	if (not next(t)) then return DoublyLinkedList.new(); end
	assert(type(t) == 'table' and t[1] ~= nil, "Table must be an array (indexed with 1).")
	
	local list = DoublyLinkedList.new();

	local current;

	for _, val in ipairs(t) do
		local node = DoublyLinkedList.Node.new(val)

		if (not list.head) then
			list.head = node
		else
			node.prev = current
			current.next = node
		end
			
		current = node
	end

	list.tail = current
	return list
end


-- Get simple name of the class.
function DoublyLinkedList.getSimpleName()
	return "DoublyLinkedList"
end

-- Get full name of the class.
function DoublyLinkedList.getFullName()
	return "DoublyLinkedList"
end
--====================================================================================================--
--====================================================================================================--


-- Protecting the Class tables.
local protected = {}

function protected.__newindex(_, k)
	error("Class Table. Cannot be modified. (unknown key: '" .. k .. "')"); 
end

setmetatable(DoublyLinkedList, protected)
setmetatable(DoublyLinkedList.Node, protected)
	
return DoublyLinkedList;
