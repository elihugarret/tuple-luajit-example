local ffi = require "ffi"
local reflect = require "reflect"

local function totab(struct) 
    local t = {}
    for refct in reflect.typeof(struct):members() do
        if type(struct[refct.name]) == "cdata" then 
            t[refct.name] = ffi.string(struct[refct.name])
        else
            t[refct.name] = struct[refct.name]
        end
    end
    return t
end

ffi.cdef[[
    typedef struct { 
        const char *s;
        int x;
        int y;
    } my_tuple;
    
    my_tuple return_tuple(const char *s, int x, int y);
]]

local rust_lib = ffi.load "./libownership.dylib"

local my_tab = totab(rust_lib.return_tuple("olá", 3, 4))

for k, v in pairs(my_tab) do 
    print("key: ", k, "value: ", v)
end

--[[
Result:
key:    y       value:  3
key:    x       value:  4
key:    s       value:  olá 
--]]