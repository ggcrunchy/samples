--- Triangles, figure 20.

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
local BottomY = .55 * CH
local TopY = .25 * CH
local LeftX = .3 * CW
local RightX = .6 * CW

--
local L = triangle.New()

L:SetVertexPos(1, LeftX, TopY)
L:SetVertexPos(2, LeftX, BottomY)
L:SetVertexPos(3, .1 * CW, TopY)

L:SetSideStyle(1, "hide")

--
local T = triangle.New()

T:SetVertexPos(1, LeftX, TopY)
T:SetVertexPos(2, RightX, TopY)
T:SetVertexPos(3, LeftX, BottomY)

T:SetSideStyle(3, "dashed")
T:MarkAngle(1, 1, { angle_offset = .15 })
T:MarkAngle(2, 1, { angle_offset = .15 })

local U = triangle.New()

U:SetVertexPos(1, RightX, TopY)
U:SetVertexPos(2, RightX, BottomY)
U:SetVertexPos(3, LeftX, BottomY)

U:SetSideStyle(1, "dashed")
U:MarkAngle(2, 1, { angle_offset = .15 })
U:MarkAngle(3, 1, { angle_offset = .15 })

local V = triangle.New()

V:SetVertexPos(1, RightX, TopY)
V:SetVertexPos(2, RightX + .2 * CW, TopY - .2 * CH)
V:SetVertexPos(3, RightX + .2 * CW, TopY)

V:SetSideStyle(2, "hide")
V:MarkAngle(1, 1, { angle_offset = .2 })