--- Triangles, figure N-1.

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

-- Modules --
local triangle = require("triangle")

-- --
local CW, CH = display.contentWidth, display.contentHeight
local BottomY = .6 * CH
local LeftX, TopY = .1 * CW, .3 * CH
local RightX = .8 * CW

--
local P = display.newCircle(.1 * CW, .6 * CH, 12)
local Q = display.newCircle(.8 * CW, .3 * CH, 12)

P:setFillColor(0)
Q:setFillColor(0)

local StrP = display.newText("p", P.x - 3, P.y - 35, native.systemFontBold, 22)
local StrQ = display.newText("q", Q.x + 5, Q.y + 35, native.systemFontBold, 22)

StrP:setTextColor(0)
StrQ:setTextColor(0)

return { P = P, Q = Q, StrP = StrP, StrQ = StrQ } -- for figure 28