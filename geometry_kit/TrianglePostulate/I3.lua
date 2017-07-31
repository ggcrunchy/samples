--- Triangles, figure I-3.

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
local TopY = .25 * CH
local LeftX = .15 * CW
local MidX = .5 * CW
local RightX = .75 * CW

--
local L = triangle.New()

L:SetVertexPos(1, LeftX, TopY)
L:SetVertexPos(2, MidX, TopY)
L:SetVertexPos(3, LeftX, BottomY)

L:SetSideStyle(3, "dashed")
L:LabelAngle(2, "B")
L:MarkAngle(1, 1, { angle_offset = .15 })

--
local T = triangle.New()

T:SetVertexPos(1, MidX, TopY)
T:SetVertexPos(2, RightX, BottomY)
T:SetVertexPos(3, LeftX, BottomY)

T:LabelAngle(1, "A")
T:LabelAngle(2, "C")
T:LabelAngle(3, "B")

local R = triangle.New()

R:SetVertexPos(1, MidX, TopY)
R:SetVertexPos(2, RightX, TopY)
R:SetVertexPos(3, RightX, BottomY)

R:SetSideStyle(2, "dashed")
R:LabelAngle(1, "C")
R:MarkAngle(2, 1, { angle_offset = .1 })