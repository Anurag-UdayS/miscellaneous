#!/usr/bin/lua

-- Doubly Linked List
-- Anurag Tewary
-- 24th April, 2022
--
-- An implementation of the DoublyLinkedList data structure, written in Lua.
-- Demonstrates OOP programming structures.


local DoublyLinkedList;

DoublyLinkedList = {
	-- The Node class
	Node = {			
		-- Metadata for Object Method container.
		__meta = {
			__metatable = "Container of Instance Methods for DoublyLinkedList.Node"
			__index = DoublyLinkedList.Node.__object
			__newindex = function() error("Instance table. Cannot be modified."); io.exit(0); end
			__tostring = function(self) return self.value; end
		}

		-- Object methods.
		__object = {
			function getClass()
					return DoublyLinkedList.Node;
			end
		}

		function new(val, next, prev)
			assert(DoublyLinkedList.Node.isNode(next) or not next, "<next> must be a Node.")
			assert(DoublyLinkedList.Node.isNode(prev) or not prev, "<prev> must be a Node.")
			return setmetatable({value = val, next = next, prev = prev}, DoublyLinkedList.Node.__meta)
		end

		function isNode(node)
				return (type(node) == 'table' and node.getClass and type(node.getClass) == 'function' and node.getClass() == DoublyLinkedList.Node);
		end
	}


	-- Metadata for Object Method container
	__meta = {
		__metatable = "Container of Instance Methods for DoublyLinkedList"
		__index = DoublyLinkedList.__object
		__newindex = function() error("Instance table. Cannot be modified."); io.exit(0); end
		__tostring = function(self) 
				local str = "["
				local current = self.head

				while current do
						str = str .. current.tostring() .. ", ";
						current = current.next;
				end
				return str .. "]"
		end
	}
	
	-- Object methods.
	__object = {
		function getClass()
			return DoublyLinkedList;
		end

		function addLast(self, node)
			if (not DoublyLinkedList.Node.isNode(node)) then
					node = DoublyLinkedList.Node.new(node)
			end

			self.tail.next = node
			node.prev = self.tail
			node.next = nil
			self.tail = node
	end

	}

	function new(head, tail)
		if (not DoublyLinkedList.Node.isNode(head)) then
			head = DoublyLinkedList.Node.new(head);
		end

		if (not DoublyLinkedList.Node.isNode(tail)) then
			tail = DoublyLinkedList.Node.new(tail);
		end

		return setmetatable({head = head, tail = tail}, DoublyLinkedList.__meta);
	end
}
