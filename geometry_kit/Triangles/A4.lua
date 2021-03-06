--- Triangles, figure A-4.

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

--
local BottomY, BottomLeftX = .75 * CH, .5 * CW
local TopX, TopY = .25 * CW, .25 * CH
local RightX = .9 * CW

--
local T = triangle.New()

T:SetVertexPos(1, BottomLeftX, BottomY)
T:SetVertexPos(2, TopX, TopY)
T:SetVertexPos(3, RightX, BottomY)

T:LabelSide(3, "base")

local U = triangle.New()

U:SetVertexPos(1, TopX, BottomY)
U:SetVertexPos(2, TopX, TopY)
U:SetVertexPos(3, BottomLeftX, BottomY)

U:SetSideStyle(1, "dashed")
U:SetSideStyle(3, "dashed")
U:LabelSide(1, "altitude", { align = true, t = .35, text_offset = 15 })
U:MarkAngle(1, 1)

return { T1 = T, T2 = U } -- reused later