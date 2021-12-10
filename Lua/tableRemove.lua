-- An algorithm to quickly remove an entry from an array. (disturbs order)

function fastRemove(t,i)
	local n = #t;
	t[i] = t[n];
	t[n] = nil;
end

local test = {1,2,3,4,5,6,7,8,9,0};

setmetatable(test,{
	__tostring = function(t)
		local str = "{\n"
		
		for i,v in next,t do
			str = str .. "\t[" .. i .. "] = " .. v.. ",\n";
		end

		str = str .. "\b\b}"
		return str
	end
})

print(test,#test)
fastRemove(test,2)
print(test,#test)