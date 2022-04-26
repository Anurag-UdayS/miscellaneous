#!/usr/bin/lua

-- Test file
-- Anurag Tewary
-- 24th April, 2022
--
-- The file used to test the DoublyLinkedList implementation.

-- assertEquals implementation
function assertEquals(b1, b2, testcase)
	if (b1 == b2) then
		print("\027[1;32mTest " .. testcase .. " was successful!\027[0m")
	else
		error("\027[31mTest " .. testcase .. " failed!\027[0m\n"
			.. "\027[33mExpected:\027[0m " .. b2 .. "\n" 
			.. "\027[33mReceived:\027[0m " .. b1 .. "\n")
	end
end

local DoublyLinkedList = require 'DoublyLinkedList'
local dll -- our object

-- Test 0.0.0
-- Construction of a new DoublyLinkedList (without parameters).
dll = DoublyLinkedList.new()
assertEquals(dll:tostring(), "[]", "0.0.0.1")
assertEquals(dll:tostringTailToHead(), "[]", "0.0.0.2")

-- Test 0.1.0
-- Testing the pointed class.
dll = DoublyLinkedList.new()
assertEquals(dll.getClass(), DoublyLinkedList, "0.1.0.0")
assertEquals(dll.getClass().getSimpleName(), "DoublyLinkedList", "0.1.0.1")
assertEquals(dll.getClass().getFullName(), "DoublyLinkedList", "0.1.0.2")

-- Test 0.1.1
-- Testing the pointed node class
dll = DoublyLinkedList.new(0)
assertEquals(dll.head.getClass(), DoublyLinkedList.Node, "0.1.1.0")
assertEquals(dll.head.getClass().getSimpleName(), "Node", "0.1.1.1")
assertEquals(dll.head.getClass().getFullName(), "DoublyLinkedList/Node", "0.1.1.2")

-- Test 0.2.0
-- Adding an unknown key to the protected classes.
local testcase;
dll = DoublyLinkedList.new(5)

local function classError(err)
	if (err:find("failed!")) then
		print(err)
	else
		err = err:sub(err:find('\027%[31m') + 5, #err - 4) -- Picking out the message and removing the control characters.
		assertEquals(err, "Class Table. Cannot be modified. (unknown key: 'foo')", testcase)
	end
end

testcase = "0.2.0.0"
xpcall(function() DoublyLinkedList.foo = "bar"; end, classError)

testcase = "0.2.0.1"
xpcall(function() DoublyLinkedList.Node.foo = "bar"; end, classError)

-- Test 0.3.0
-- Adding an unknown key to the protected instances.
local function instanceError(err)
	if (err:find("failed!")) then
		print(err)
	else
		err = err:sub(err:find('\027%[31m') + 5, #err - 4) -- Picking out the message and removing the control characters.
		assertEquals(err, "Instance Table. Cannot be modified. (unknown key: 'foo')", testcase)
	end
end

testcase = "0.3.0.0"
xpcall(function() DoublyLinkedList.new().foo = "bar"; end, instanceError)

testcase = "0.3.0.1"
xpcall(function() DoublyLinkedList.Node.new().foo = "bar"; end, instanceError)

testcase = nil

-- Test 1.0.0
-- Construction of a new DoublyLinkedList (with just head as a parameter).
dll = DoublyLinkedList.new(5)
assertEquals(dll:tostring(), "[5]", "1.0.1.1")
assertEquals(dll:tostringTailToHead(), "[5]", "1.0.1.2")

-- Test 1.0.1
-- Construction of a new DoublyLinkedList (with a head and a tail as parameters.)
dll = DoublyLinkedList.new(1,5)
assertEquals(dll:tostring(), "[1, 5]", "1.0.1.1")
assertEquals(dll:tostringTailToHead(), "[5, 1]", "1.0.1.2")

-- Test 1.1.0
-- Adding two values to the head of an empty list.
dll = DoublyLinkedList.new()
dll:addFirst(4)
dll:addFirst(3)
assertEquals(dll:tostring(), "[3, 4]", "1.1.0.1")
assertEquals(dll:tostringTailToHead(), "[4, 3]", "1.1.0.2")

-- Test 1.1.1
-- Adding two values to the head of a head-only list.
dll = DoublyLinkedList.new(5)
dll:addFirst(4)
dll:addFirst(3)
assertEquals(dll:tostring(), "[3, 4, 5]", "1.1.1.1")
assertEquals(dll:tostringTailToHead(), "[5, 4, 3]", "1.1.1.2")

-- Test 1.1.2
-- Adding two values to the head of a head and tail list.
dll = DoublyLinkedList.new(1,5)
dll:addFirst(4)
dll:addFirst(3)
assertEquals(dll:tostring(), "[3, 4, 1, 5]", "1.1.2.1")
assertEquals(dll:tostringTailToHead(), "[5, 1, 4, 3]", "1.1.2.2")

-- Test 1.2.0
-- Adding two values to the tail of an empty list.
dll = DoublyLinkedList.new()
dll:addLast(4)
dll:addLast(3)
assertEquals(dll:tostring(), "[4, 3]", "1.2.0.1")
assertEquals(dll:tostringTailToHead(), "[3, 4]", "1.2.0.2")


-- Test 1.2.1
-- Adding two values to the tail of a head-only list.
dll = DoublyLinkedList.new(5)
dll:addLast(4)
dll:addLast(3)
assertEquals(dll:tostring(), "[5, 4, 3]", "1.2.1.1")
assertEquals(dll:tostringTailToHead(), "[3, 4, 5]", "1.2.1.2")

-- Test 1.2.2
-- Adding two values to the head of a head and tail list.
dll = DoublyLinkedList.new(1,5)
dll:addLast(6)
dll:addLast(7)
assertEquals(dll:tostring(), "[1, 5, 6, 7]", "1.2.2.1")
assertEquals(dll:tostringTailToHead(), "[7, 6, 5, 1]", "1.2.2.2")

-- Test 1.2.3
-- Adding values in both ways of a head and tail list.
dll = DoublyLinkedList.new(5,10)
dll:addLast(11)
dll:addLast(12)
dll:addFirst(4)
dll:addFirst(3)
dll:addLast(13)
dll:addFirst(2)
assertEquals(dll:tostring(), "[2, 3, 4, 5, 10, 11, 12, 13]", "1.2.3.1")
assertEquals(dll:tostringTailToHead(), "[13, 12, 11, 10, 5, 4, 3, 2]", "1.2.3.2")

-- NOTE: Due to similarity of behavior of `new` and `fromTable` constructors,
-- Rest of the test cases will be written with tables constructed by `fromTable` constructor.

-- Test 2.0.0
-- Creating an empty list using `fromTable`.
dll = DoublyLinkedList.fromTable {}
assertEquals(dll:tostring(), "[]", "2.0.0.1")
assertEquals(dll:tostringTailToHead(), "[]", "2.0.0.2")

-- Test 2.0.1
-- Creating a list with values using `fromTable`.
dll = DoublyLinkedList.fromTable {1,2,3,4,5}
assertEquals(dll:tostring(), "[1, 2, 3, 4, 5]", "2.0.1.1")
assertEquals(dll:tostringTailToHead(), "[5, 4, 3, 2, 1]", "2.0.1.2")

-- Test 2.0.2
-- Creating a list with map.
xpcall(function()
		dll = DoublyLinkedList.fromTable {a = 1}
	end,
	function()
		if (err:find("failed!")) then
			print(err)
		else
			err = err:sub(err:find('\027%[31m') + 5, #err - 4) -- Picking out the message and removing the control characters.
			assertEquals(err, "Table must be an array (indexed with 1).", "2.0.2.0")
		end
	end
)


-- Helper function for Tests in 2.1
local testcase;
local function addError(err)
	if (err:find("failed!")) then
		print(err)
	else
		err = err:sub(err:find('\027%[31m') + 5, #err - 4) -- Picking out the message and removing the control characters.
		assertEquals(err, "Index (5) is out of bounds.", testcase)
	end
end

-- Test 2.1.0
-- `DoublyLinkedList#addAt(1)` with empty list.
dll = DoublyLinkedList.fromTable {}
dll:addAt(1, "foo")
assertEquals(dll:tostring(), "[foo]", "2.1.0.0")
assertEquals(dll:tostringTailToHead(), "[foo]", "2.1.0.1")

-- Test 2.1.1
-- `DoublyLinkedList#addAt(5)` with empty list.
testcase = "2.1.1.0"
dll = DoublyLinkedList.fromTable {}
xpcall (function() dll:addAt(5, "foo") end, addError) 

-- Test 2.1.2 
-- `DoublyLinkedList#addAt(1)` with list having one value.
dll = DoublyLinkedList.fromTable {"bar"}
dll:addAt(1, "foo")
assertEquals(dll:tostring(), "[foo, bar]", "2.1.2.0")
assertEquals(dll:tostringTailToHead(), "[bar, foo]", "2.1.2.1")

-- Test 2.1.3
-- `DoublyLinkedList#addAt(2)` with list having one value.
dll = DoublyLinkedList.fromTable {"bar"}
dll:addAt(2, "foo")
assertEquals(dll:tostring(), "[bar, foo]", "2.1.3.0")
assertEquals(dll:tostringTailToHead(), "[foo, bar]", "2.1.3.1")

-- Test 2.1.4
-- `DoublyLinkedList#addAt(5)` with list having one value.
testcase = "2.1.4.0"
dll = DoublyLinkedList.fromTable {"foo"}
xpcall (function() dll:addAt(5, "bar") end, addError) 

-- Test 2.1.5
-- `DoublyLinkedList#addAt(2)` with list having three values.
dll = DoublyLinkedList.fromTable {"foo", "bar", "baz"}
dll:addAt(2, "qbz")
assertEquals(dll:tostring(), "[foo, qbz, bar, baz]", "2.1.5.0")
assertEquals(dll:tostringTailToHead(), "[baz, bar, qbz, foo]", "2.1.5.1")

-- Test 2.1.6
-- `DoublyLinkedList#addAt(4)` with list having three values.
dll = DoublyLinkedList.fromTable {"foo", "bar", "baz"}
dll:addAt(4, "qbz")
assertEquals(dll:tostring(), "[foo, bar, baz, qbz]", "2.1.6.0")
assertEquals(dll:tostringTailToHead(), "[qbz, baz, bar, foo]", "2.1.6.1")


-- Test 2.1.7
-- `DoublyLinkedList#addAt(5)` with list having three values.
testcase = "2.1.7.0"
dll = DoublyLinkedList.fromTable {"foo", "bar", "baz"}
xpcall (function() dll:addAt(5, "qbz") end, addError) 

-- Test 2.1.8
-- `DoublyLinkedList#addAt(-1)` with list.
dll = DoublyLinkedList.fromTable {"foo"}
xpcall(function()
		dll:addAt(-1, "bar")
	end,
	
	function(err)
		if (err:find("failed!")) then
			print(err)
		else
			err = err:sub(err:find('\027%[31m') + 5, #err - 4) -- Picking out the message and removing the control characters.
			assertEquals(err, "Index (-1) is out of bounds.", "2.1.8.0")
		end
	end
)

testcase = nil

-- Test 2.2.0
-- `DoublyLinkedList#addAll` empty array inside empty list.
dll = DoublyLinkedList.fromTable {}
dll:addAll {}
assertEquals(dll:tostring(), "[]", "2.2.0.0")
assertEquals(dll:tostringTailToHead(), "[]", "2.2.0.1")

-- Test 2.2.1
-- `DoublyLinkedList#addAll` array with elements inside empty list.
dll = DoublyLinkedList.fromTable {}
dll:addAll {1, 2, 3}
assertEquals(dll:tostring(), "[1, 2, 3]", "2.2.1.0")
assertEquals(dll:tostringTailToHead(), "[3, 2, 1]", "2.2.1.1")

-- Test 2.2.2
-- `DoublyLinkedList#addAll` empty array inside list with elements.
dll = DoublyLinkedList.fromTable {1, 2, 3}
dll:addAll {}
assertEquals(dll:tostring(), "[1, 2, 3]", "2.2.2.0")
assertEquals(dll:tostringTailToHead(), "[3, 2, 1]", "2.2.2.1")

-- Test 2.2.3
-- `DoublyLinkedList#addAll` array with elements inside list with elements.
dll = DoublyLinkedList.fromTable {1, 2, 3}
dll:addAll {4, 5, 6}
assertEquals(dll:tostring(), "[1, 2, 3, 4, 5, 6]", "2.2.0.0")
assertEquals(dll:tostringTailToHead(), "[6, 5, 4, 3, 2, 1]", "2.2.0.1")


