--- Triangles, figure E-1.

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

--
local CW, CH = display.contentWidth, display.contentHeight
local BottomY = .65 * CH
local MidY = .5 * CH
local TopY = .35 * CH
local LeftX = .1 * CW
local RightX = .4 * CW

local T = triangle.New()

T:SetVertexPos(1, LeftX, MidY)
T:SetVertexPos(2, RightX, TopY)
T:SetVertexPos(3, RightX, BottomY)

T:LabelAngle(2, "A")
T:LabelAngle(3, "B")
T:MarkAngle(1, 1, { angle_offset = .15 })
T:MarkSide(1, 1)
T:MarkSide(3, 1)

local U = T:Clone()

U:Translate(.45 * CW, 0)

U:LabelAngle(3, "A")
U:LabelAngle(2, "B")