--- Entry point.

--
-- Permission is hereby granted, free of charge, to any person obtaining
-- a copy of this software and associated documentation files (the
-- "Software"), to deal in the Software without restriction, including
-- without limitation the rights to use, copy, modify, merge, publish,
-- distribute, sublicense, and/or sell copies of the Software, and to
-- permit persons to whom the Software is furnished to do so, subject to
-- the following conditions:
--
-- The above copyright notice and this permission notice shall be
-- included in all copies or substantial portions of the Software.
--
-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
-- EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
-- MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
-- IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
-- CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
-- TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
-- SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
--
-- [ MIT license: http://www.opensource.org/licenses/mit-license.php ]
--

-- Override print to avoid having to flip to the console constantly. (Also less of a mess, after a while!)
local y = 20

local function my_print (...)
	local args = { n = select("#", ...), ... }

	for i = 1, args.n do
		args[i] = tostring(args[i])
	end

	local text = display.newText(table.concat(args, "  "), 0, y, native.systemFontBold, 15)

	text.anchorX, text.x = 0, 20

	y = y + text.height + 5
end

print = my_print

--[[
require("basic1")
--]]

--[[
require("basic2")
--]]

--[[
require("basic3")
--]]

--[[
require("debugging")
--]]

--[[
require("wait_howto")
--]]

--[[
require("hilbert")
--]]